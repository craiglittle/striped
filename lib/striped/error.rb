module Striped
  class Error < StandardError
    class BadRequest  < Error; end
    class ServerError < Error; end

    class Unauthorized  < Error::BadRequest; end
    class RequestFailed < Error::BadRequest; end
    class NotFound      < Error::BadRequest; end

    class InvalidRequest < Error::RequestFailed; end
    class APIError       < Error::RequestFailed; end
    class CardError      < Error::RequestFailed; end
  end
end
