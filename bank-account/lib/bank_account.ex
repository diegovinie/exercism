defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, pid} = Task.start_link(fn -> account(0, true) end)
    pid
  end

  def account(amount, is_open) when is_open == true do
    receive do
      {caller, :get} ->
        send caller, {self(), {:ok, amount}}
        account(amount, is_open)
      {caller, {:put, value}} ->
        send caller, {self(), :ok}
        account(amount + value, is_open)
      {caller, :stop} ->
        send caller, {self(), :ok}
        account(amount, false)
    end
  end

  def account(amount, is_open) do
    receive do
      {caller, :start} ->
        send caller, {self(), :ok}
        account(amount, true)
      {caller, _} ->
        send caller, {self(), {:error, :account_closed}}
        account(amount, is_open)
    end
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    send account, { self(), :stop}
    receive do
      {^account, :ok} -> :ok
      {^account, other} -> other
    end
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    send account, {self(), :get}
    receive do
      {^account, {:ok, balance}} -> balance
      {^account, other}          -> other
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    send account, {self(), {:put, amount}}
    receive do
      {^account, :ok}    -> :ok
      {^account, other}  -> other
    end
  end
end
