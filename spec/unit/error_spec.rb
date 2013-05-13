require 'helper'
require 'striped/error'

describe Striped::Error do
  it_inherits_from_the_proper_error(
    [Striped::Error],
    StandardError
  )

  it_inherits_from_the_proper_error(
    [Striped::Error::BadRequest, Striped::Error::ServerError],
    Striped::Error
  )

  it_inherits_from_the_proper_error(
    [ Striped::Error::Unauthorized,
      Striped::Error::RequestFailed,
      Striped::Error::NotFound,
    ],
    Striped::Error::BadRequest
  )

  it_inherits_from_the_proper_error(
    [
      Striped::Error::InvalidRequest,
      Striped::Error::APIError,
      Striped::Error::CardError
    ],
    Striped::Error::RequestFailed
  )
end
