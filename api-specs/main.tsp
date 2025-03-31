import "@typespec/http";
import "./services/payment.tsp";

using TypeSpec.Http;
@service(#{ title: "EPaaS Services" })
namespace EPaaSServices {}

