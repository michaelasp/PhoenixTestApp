defmodule TestPhoenix.ApiInterface do
    @moduledoc """
    The Api interface
    """

    @api "http://jservice.io/"
    def get_random() do
        clues = HTTPoison.get(@api<>"api/random/?count=1")
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
    def get_questions(params) do
        value = get_in(params, ["value"])
        cat = get_in(params, ["category"])
        min = get_in(params, ["min"])
        max = get_in(params, ["max"])
        min_date = if max != nil and max != "" do max <> "T00:00:00Z" else "" end
        max_date = if min != nil and min != "" do min <> "T00:00:00Z" else "" end
        IO.puts(@api<>"api/clues/?value=#{value}&category=#{cat}&min_date=#{min_date}&max_date=#{max_date}")
        clues = HTTPoison.get(@api<>"api/clues/?value=#{value}&category=#{cat}&min_date=#{min_date}&max_date=#{max_date}")
        case clues do
            {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
                Poison.decode!(body)
                |> Enum.sort_by(fn x -> x["value"] end) 
            {:ok, %HTTPoison.Response{status_code: 500, body: body}} ->
                IO.puts "Sad"
                []
            {:ok, %HTTPoison.Response{status_code: 404}} ->
                IO.puts "Not found :("
                []
            {:error, %HTTPoison.Error{reason: reason}} ->
                IO.inspect reason
                []
        end
    end
    def get_cat(params) do
        category = get_in(params, ["cat"])
        raw = HTTPoison.get(@api<>"search?query=#{category}")
        case raw do
            {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
                category_nums = body
                |> Floki.parse
                |> Floki.attribute("a", "href") 
                |> Enum.filter(fn x -> String.contains?(x, "/popular") end) 
                |> Enum.map(fn x -> String.replace_prefix(x, "/popular/", "") end)
                categories = body 
                |> Floki.parse 
                |> Floki.find("a") 
                |> Enum.filter(fn x -> String.contains?(List.first(Floki.attribute(x,"href")), "/popular") end) 
                |> Enum.map(fn x -> Floki.text(x) end)
                Enum.zip(category_nums, categories)
            _ -> IO.puts "Sad"
                []
        end
    end
end