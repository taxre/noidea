json.array!(@words) do |word|
  json.extract! word, :word, :wordtype, :description
  json.url word_url(word, format: :json)
end
