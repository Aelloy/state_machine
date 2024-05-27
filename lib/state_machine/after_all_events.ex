defmodule StateMachine.AfterAllEvents do
  @moduledoc """
  AfterAllEvents module provides a structure for defining a list of callbacks
  to run after all events.
  """

  alias StateMachine.Callback

  @type t(model) :: %__MODULE__{
          run: list(Callback.t(model))
        }

  @enforce_keys [:run]
  defstruct run: []

  @doc """
  Function for running all callbacks.
  """
  def callbacks(%{status: :failed} = ctx, _arg), do: ctx

  def callbacks(ctx, arg) do
    context = %{ctx | payload: arg}
    [event] = context.definition.after_all_events
    Callback.apply_chain(context, event.run, :run)
  end
end
