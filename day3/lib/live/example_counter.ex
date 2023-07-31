defmodule Day3Web.ExampleCounterLive do
  use Day3Web, :live_view
  require Logger

  def mount(_params, _session, socket) do
    socket = assign(socket, :cnt, 10)
    Logger.info("Mount Counter")
    if connected?(socket) do :timer.send_interval(1000, self(), :update) end
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Counter</h1>
    <%= @cnt %>%
    """
  end

  def handle_info(:update, socket) do
    Logger.info("Update Counter")
    socket = update(socket, :cnt, fn x -> x + 1 end)
    {:noreply, socket}
  end
end
