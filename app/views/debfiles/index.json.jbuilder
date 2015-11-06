json.array!(@debfiles) do |debfile|
  json.extract! debfile, :id, :name, :control, :version
  json.url debfile_url(debfile, format: :json)
end
