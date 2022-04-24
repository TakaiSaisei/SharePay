module JsonWebToken
  def encode_token(payload)
    JWT.encode(payload, 'secret')
  end

  def decoded_token
    return unless auth_header

    token = auth_header.split[1]
    begin
      JWT.decode(token, 'secret', true)[0]
    rescue JWT::DecodeError
      nil
    end
  end

  private

  # { Authorization: 'Bearer <token>' }
  def auth_header
    request.headers['Authorization']
  end
end
