class AptlyController < ApplicationController

  def index
    @config = JSON.pretty_generate(Aptly::Config.open(nil), indent: '    ')
  end

  def save_settings

  end

  def save_config
    Aptly::Config.save(Settings.aptly.config, params[:config])
  end

end
