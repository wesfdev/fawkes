defmodule FawkesWeb.RoomController do
  @moduledoc """
  FawkesWeb.RoomController
  """
  use FawkesWeb, :controller
  alias Fawkes.Chat
  alias FawkesWeb.Utils.Util

  require Logger

  @doc """
    ping function
  """
  def ping(conn, _params), do: conn |> render("ack.json", %{success: true, message: "pong"})

  def create(conn, params) do
    case Chat.create_room(params) do
      {:ok, room} ->
        Logger.info("Room created: #{inspect(room)}")

        conn
        |> render("ack.json", %{message: "Room created"})

      {:error, %Ecto.Changeset{errors: errors} = changeset} ->
        Logger.info("ChangeSet: #{inspect(errors)}")

        conn
        |> render("errors.json", %{errors: Util.format_changeset_errors(changeset)})

      others ->
        conn
        |> render("errors.json", %{errors: ["#{inspect(others)}"]})
    end
  end

  def list(conn, _params) do
    conn
    |> render("ack.json", %{data: Chat.list_rooms()})
  end
end
