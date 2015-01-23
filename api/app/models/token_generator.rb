class TokenGenerator
  def self.create
    loop do
      token = SecureRandom.hex
      break token unless User.find_by(auth_code: token)
    end
  end
end