defmodule FawkesWeb.RoomChannel do
  @moduledoc """
  FawkesWeb.RoomChannel
  """
  use FawkesWeb, :channel
  require Logger
  alias Fawkes.Chat
  alias Fawkes.Chat.Message

  def join("room:" <> room_id, payload, socket) do
    Logger.info("Welcome #{inspect(payload)} to room: #{room_id}")
    room = Chat.get_room(room_id)

    if is_nil(room) do
      {:error, socket}
    else
      {:ok, assign(socket, :room_id, room_id)}
    end
  end

  def handle_in("new_msg", payload, socket) do
    room_id = socket.assigns.room_id
    Logger.info("Receiving new message: #{inspect(payload)}, room: #{room_id}")
    room = Chat.get_room(room_id)
    eval_message(socket, room, payload)
  end

  defp eval_message(socket, nil, _) do
    Logger.info("Room not found")
    {:noreply, socket}
  end

  defp eval_message(socket, _room, %{"payload" => %{"content" => content}}) do
    room_id = socket.assigns.room_id
    payload = %{content: content, room_id: room_id}

    case Message.create_message(payload) do
      {:ok, message} ->
        Logger.info("Message created: #{inspect(message)}")
        broadcast!(socket, "new_msg", %{payload: %{message: message}})

      {:error, %Ecto.Changeset{} = changeset} ->
        Logger.info("ChangeSet: #{inspect(changeset)}")

      others ->
        Logger.info("Errors: #{inspect(others)}")
    end

    {:noreply, socket}
  end
end
