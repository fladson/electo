defmodule ElectoWeb.HomeLive do
  use ElectoWeb, :live_view

  alias Electo.Things

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :things, Things.list_things_ordered())}
  end

  @impl true
  def handle_event("vote", %{"id" => id}, socket) do
    thing = Things.get_thing!(id)
    {:ok, updated_thing} = Things.increment_vote(thing)
    {:noreply, stream_insert(socket, :things, updated_thing)}
  end
end
