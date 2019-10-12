defmodule TestPhoenix.ApiInterface do
    @moduledoc """
    The Api interface
    """

    @api "http://jservice.io/api"
    def get_random() do
        clues = HTTPoison.get(@api<>"/random/?count=1")
        case clues do
            {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
                Poison.decode!(body)
                |> List.first    
            {:ok, %HTTPoison.Response{status_code: 404}} ->
                IO.puts "Not found :("
            {:error, %HTTPoison.Error{reason: reason}} ->
                IO.inspect reason
        end
    end
end