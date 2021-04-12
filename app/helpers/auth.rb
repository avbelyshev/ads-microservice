module Auth
  class Unauthorized < StandardError; end

  def user_id
    user_id = auth_service.auth(request.env['HTTP_AUTHORIZATION']).user_id
    raise Unauthorized if user_id.blank?

    user_id
  end

  private

  def auth_service
    @auth_service ||= AuthService::RpcClient.fetch
  end
end
