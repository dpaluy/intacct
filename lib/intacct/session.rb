module Intacct
  class Session
    EXPIRATION_BUFFER = 1.minute
    attr_reader :session_id, :expired_at, :endpoint

    def initialize(session_id:, expired_at:, endpoint: nil)
      @session_id = session_id
      @expired_at = DateTime.parse(expired_at)
      @endpoint = endpoint
    end

    def expired?
      (Time.current - EXPIRATION_BUFFER) > expired_at
    end

    def self.response_to_session(response)
      new(
        session_id: response.sessionid,
        expired_at: response.sessiontimeout,
        endpoint: response.endpoint
      )
    end
  end
end
