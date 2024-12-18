defmodule ElectoWeb.ThingLive.Index do
  use ElectoWeb, :live_view

  alias Electo.Things
  alias Electo.Things.Thing

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :things, Things.list_things())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Thing")
    |> assign(:thing, Things.get_thing!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Thing")
    |> assign(:thing, %Thing{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Things")
    |> assign(:thing, nil)
  end

  @impl true
  def handle_info({ElectoWeb.ThingLive.FormComponent, {:saved, thing}}, socket) do
    {:noreply, stream_insert(socket, :things, thing)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    thing = Things.get_thing!(id)
    {:ok, _} = Things.delete_thing(thing)

    {:noreply, stream_delete(socket, :things, thing)}
  end

  def handle_event("vote", %{"id" => id}, socket) do
    thing = Things.get_thing!(id)
    {:ok, updated_thing} = Things.increment_vote(thing)
    {:noreply, stream_insert(socket, :things, updated_thing)}
  end
end
