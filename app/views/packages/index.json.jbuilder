json.array!(@packages) do |package|
  json.extract! package, :id, :name, :branch_id, :version, :path, :control
  json.url package_url(package, format: :json)
end
