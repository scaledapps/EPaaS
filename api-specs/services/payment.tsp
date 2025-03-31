import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
    
import "../models/payment.tsp";
import "../models/errorresponse.tsp";
    
using TypeSpec.Http;
using TypeSpec.OpenAPI;
    
@route("/payment")
    
@service(#{
    title: "Make a Payment"
})
@doc("Handles payment requests and responses.")
    
namespace EPaaSServices {
    @route("/v1/api")
    @tag("Payments")
    @doc("This API Handles incoming payment requests, and sends payment events to the Payment-Requests topic. This service also processes transaction responses, that are posted to the Payment-Responses topic.")
    @post
    op processPayment(...PaymentRequest):
        | {
                @statusCode statusCode: 202;
                @header("content-type") contentType: "application/json";
                @body body: PaymentResponse[];
            }
        | {
                @statusCode statusCode: 400;
                @body body: ErrorResponse;
            }
        | {
                @statusCode statusCode: 401;
                @body body: ErrorResponse;
            }
        | {
                @statusCode statusCode: 403;
                @body body: ErrorResponse;
            }
        | {
                @statusCode statusCode: 404;
                @body body: ErrorResponse;
            }
        | {
                @statusCode statusCode: 500;
                @body body: ErrorResponse;
            };
}
