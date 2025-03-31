import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
    
using TypeSpec.Http;
    
namespace EPaaSServices;
    
@doc("Request to process payment")
model PaymentRequest {
    @doc("Payment Identifier")
    paymentId?: string;

    @doc("Merchant Identifier")
    merchantId?: string;

    @doc("TPPP Identifier")
    tpppId?: string;

    @doc("Correlation Identifier")
    correlationId?: string;

    @doc("Amount")
    amount?: Amount;

    @doc("Payer Account")
    payer?: Account;

    @doc("Payee Account")
    payee?: Account;

    @doc("Metadata")
    metadata?: Metadata;
}

model Amount {

    @doc("Currency")
    currency?: string;

    @doc("Value")
    value?: float64;
}

model Account {

    @doc("Name")
    name?: string;

    @doc("Account Number")
    accountNumber?: string;

    @doc("Banking Code")
    ifsc?: string;
}

model Metadata {

    @doc("Order ID")
    orderId?: string;

    @doc("Invoice ID")
    invoiceId?: string;

    @doc("Description")
    description?: string;

    @doc("Timestamp")
    timestamp?: plainDate;
}

    
@doc("Response to process payment")
model PaymentResponse {

    @doc("Payment Identifier")
    paymentId?: string;

    @doc("Status")
    status?: string;

    @doc("Message")
    message?: string;

    @doc("Expected Completion Time")
    expectedCompletionTime?: plainDate;

    @doc("Timestamp")
    timestamp?: plainDate;

}