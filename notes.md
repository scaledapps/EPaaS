
```mermaid
graph TD;
    subgraph External Entities
        A[Merchant]
        B[TPPP]
        C[Bank]
    end

    subgraph Kong API Gateway
        D[Kong API Gateway]
    end

    subgraph Kafka Topics
        E1[Kafka Topic: Payment Requests]
        E2[Kafka Topic: Payment Responses]
        E3[Kafka Topic: Reconciliation Events]
    end

    subgraph Microservices on Kubernetes
        F[Payment Service]
        G[Reconciliation Service]
    end

    subgraph Database & Storage
        I1[PostgreSQL]
        I2[Redis Cache]
        I3[S3 for Logs]
    end

    A -->|Payment Initiation| B
    B -->|POST /payments| D
    D -->|Publish to Kafka| E1
    E1 -->|Consume & Process| F
    F -->|Call Bank API| C
    C -->|Payment Status Response| F
    F -->|Publish to Kafka| E2
    E2 -->|Consume| G
    G -->|Match & Update Status| I1
    G -->|Publish to Kafka| E3

```

**Success Case (200 OK)**
```json
{
  "paymentId": "1234567890",
  "status": "SUCCESS",
  "bankReferenceId": "BANK56789",
  "settlementTime": "2025-03-30T10:16:40Z",
  "message": "Payment processed successfully",
  "reconciliationStatus": "MATCH",
  "timestamp": "2025-03-30T10:16:45Z"
}
```

**Failure Case (500 Internal Server Error)**
```json
{
  "paymentId": "1234567890",
  "status": "FAILED",
  "errorCode": "BANK_TXN_TIMEOUT",
  "errorMessage": "Transaction timed out at bank",
  "reconciliationStatus": "TECHNICAL_EXCEPTION",
  "timestamp": "2025-03-30T10:16:40Z"
}
```

### Batch Reconciliation Process
Reconciliation is performed immediately upon receiving payment response from the Bank.
This diagram illustrates the API interactions between Merchants, Third-Party Payment Providers (TPPPs), EPaaS, and the Bank during batch reconciliation process.

```mermaid
sequenceDiagram
    participant Merchant
    participant TPPP
    participant ReconService as Reconciliation Service
    participant Bank

    Merchant->>TPPP: Upload Reconciliation Batch File
    TPPP->>ReconService: Forward Batch File
    ReconService->>Bank: Fetch Bank Transactions for Batch Period
    Bank-->>ReconService: Bank's Transaction Records
    ReconService->>ReconService: Match Transactions & Compute Status
    ReconService-->>TPPP: Send Reconciliation Results
    TPPP-->>Merchant: Notify Reconciliation Status

```
