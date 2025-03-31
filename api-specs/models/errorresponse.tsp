namespace EPaaSServices;

@error
@doc("Error Response")
model ErrorResponse {
  @doc("Standard code")
  code: string;

  @doc("A human-readable explanation specific to this occurrence of the problem.")
  message: string;
}