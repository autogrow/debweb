# Do some basic setup of aptly

binary   = Settings.aptly.exec
cfg      = File.join(ENV["HOME"], ".aptly.conf")
path     = Rails.root.join("aptly").to_s
settings = Rails.root.join("config", "settings.yml")

cfg_good  = false
path_good = false


def generate_config(binary, config)
  return true if File.exist?(config)
  `#{binary} config show`
  File.exist?(config)
end

puts "\n"

if File.exist?(binary)
  if File.executable?(binary)
    puts "Detected Aptly settings:"
    puts "Binary: #{binary}"

    yaml = YAML.load_file(settings)
    
    if generate_config(binary, cfg)
      puts "Config: #{cfg}"
      yaml["aptly"]["config"] = cfg
      cfg_good = true
    else
      warn "ERROR: Config not found at #{cfg}"
    end

    FileUtils.mkdir_p(path)
    if File.directory?(path)
      puts "Path:   #{path}"
      yaml["aptly"]["path"]   = path
      path_good = true
    else
      warn "ERROR: Aptly path not found at #{path}"
    end

    File.write(settings, yaml.to_yaml)

    if path_good and cfg_good
      json = JSON.parse(File.read(cfg))
      json["rootDir"] = path
      File.write(cfg, JSON.pretty_generate(json))
    end

  else
    warn "ERROR: Aptly binary not executable: #{binary}"
  end
else
  warn "ERROR: Aptly binary not found: #{binary}"
end

puts "\n"
