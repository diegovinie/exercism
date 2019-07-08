defmodule Counting do
  @moduledoc """
    Counter value is 115
    Process A reads the value of the counter (115)
    Process B reads the value of the counter (115)
    Process B increases the value locally (116)
    Process B sets increased value to the counter (116)
    Process A increases the value of the counter (116)
    Process A sets increased value to the counter (116)
    Counter value is 116
  """

  @doc """
    recibe un :get y manda el value con que fue llamada
    recibe un :set, no manda nada y devuelve con en nuevo valor
  """
  def counter(value) do
    receive do
      {:get, sender} ->
        send sender, {:counter, value}
        counter value
      {:set, new_value} -> counter(new_value)
    end
  end

  @doc """
    times veces manda un :get, con el valor de la respuesta manda un set más 1
  """
  def counting(sender, counter, times) do
    if times > 0 do
      send counter, {:get, self()}
      receive do
        {:counter, value} -> send counter, {:set, value + 1}
      end
      counting(sender, counter, times - 1) # re ejecuta
    else
      send sender, {:done, self()}  # aqui termina
    end
  end
end

# veces
times = 500_000
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
