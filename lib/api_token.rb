module ApiToken
  extend self

  def generate
    Digest::SHA2.hexdigest(Time.now.to_s + rand(100000..99999999).to_s)
  end
end