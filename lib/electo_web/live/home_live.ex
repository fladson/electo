defmodule ElectoWeb.HomeLive do
  use ElectoWeb, :live_view

  alias Electo.Things

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Things.subscribe()

    {:ok, stream(socket, :things, Things.list_things_ordered())}
  end

  @impl true
  def handle_event("vote", %{"id" => id}, socket) do
    Things.get_thing!(id)
    |> Things.increment_vote()

    # Let the broadcast handle the stream update
    {:noreply, socket}
  end

  @impl true
  def handle_info({:thing_voted, _thing}, socket) do
    # Refresh entire stream with new order when any vote happens
    # not the most efficient but it's simple and works
    {:noreply, stream(socket, :things, Things.list_things_ordered(), reset: true)}
  end
end
