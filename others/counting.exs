defmodule Counting do
  @moduledoc """
    fixed
  """

  @doc """
    Esto mantiene el valor como parámetro durante la recursividad
    recibe un :get y manda el value con que fue llamada
  """
  def counter(value) do
    receive do
      {:get, sender} ->
        send sender, {:counter, value}
        counter value
      :increase -> counter value + 1
    end
  end

  @doc """
    simple, es llamada y manda un mensaje :increase
  """
  def counting(sender, counter, times) do
    if times > 0 do
      send counter, :increase
      counting(sender, counter, times - 1) # re ejecuta
    else
      send sender, {:done, self()}  # aqui termina
    end
  end
end

# veces
times = 500_000 * 10
# crea un nuevo proceso
counter = spawn fn -> Counting.counter 0 end
# acá inicia la aplicación
IO.puts "Starting counting processes"
# el proceso padre
this = self()

counting1 = spawn fn ->
  IO.puts "Counting A started"
  Counting.counting this, counter, times
  IO.puts "Counting A finished"
end

counting2 = spawn fn ->
  IO.puts "counting B started"
  Counting.counting this, counter, times
  IO.puts "Counting B finished"
end

IO.puts "waiting for counting o be done"
# termina 1
receive do
  {:done, ^counting1} -> nil
end
# termina 2
receive do
  {:done, ^counting2} -> nil
end

send counter, {:get, self()}
receive do
  {:counter, value} -> IO.puts "Counter is: #{value}"
end
