defmodule FawkesWeb.MessageController do
  @moduledoc """
  FawkesWeb.MessageController
  """
  use FawkesWeb, :controller
  alias Fawkes.Chat.Message
  alias Fawkes.Chat
  alias FawkesWeb.Utils.Util

  require Logger

  def create(conn, params) do
    room = Chat.get_room(params["room_id"])

    conn
    |> create_message(room, params)
  end

  defp create_message(conn, nil, _) do
    conn
    |> render("errors.json", %{errors: ["Room not found"]})
  end

  defp create_message(conn, _room, params) do
    case Message.create_message(params) do
      {:ok, message} ->
        Logger.info("Message created: #{inspect(message)}")

        conn
        |> render("ack.json", %{message: "Message created"})

      {:error, %Ecto.Changeset{} = changeset} ->
        Logger.info("ChangeSet: #{inspect(changeset)}")

        conn
        |> render("errors.json", %{errors: Util.format_changeset_errors(changeset)})

      others ->
        conn
        |> render("errors.json", %{errors: ["#{inspect(others)}"]})
    end
  end

  def list(conn, _params) do
    conn
    |> render("ack.json", %{data: Message.list_messages()})
  end
end
