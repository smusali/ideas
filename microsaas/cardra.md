# **Cardra — Credit Statement Insights API**

*A simple API that turns credit card statements into actionable insights, subscription detection, and spend summaries for developers and fintech apps.*

---

## 1. Executive Summary

Cardra is a plug-and-play API that ingests credit card statements (PDF, CSV, or text), extracts transactions, and provides instant insights on subscriptions, spend categories, and anomalies. Designed for developers and fintech builders, Cardra makes it easy to add spend intelligence to any app or workflow with a single API call.

---

## 2. Problem Landscape

| Challenge                    | Pain Point                                 |
| ---------------------------- | ------------------------------------------ |
| Messy, inconsistent formats  | Hard to parse, error-prone manual work     |
| Hidden recurring charges     | Missed subscriptions, surprise expenses    |
| No easy way to analyze spend | Users lack clarity on where money goes     |

---

## 3. Target Users

- **Developers** building personal finance tools
- **Fintech startups** needing fast statement parsing
- **Indie hackers** adding spend insights to apps
- **Small businesses** tracking recurring charges

---

## 4. Core Features (MVP)

| Feature                | Description                                      |
| ---------------------- | ------------------------------------------------ |
| **Statement Upload**   | Accept PDF, CSV, or text statement via API       |
| **Transaction Parsing**| Extract date, merchant, amount, and description  |
| **Subscription Finder**| Detect recurring charges and flag duplicates     |
| **Spend Summary**      | Categorize spend and highlight top categories    |
| **Simple Webhook**     | Notify on new subscriptions or anomalies         |

---

## 5. API Design

### Endpoints

```
POST /api/v1/statement
GET  /api/v1/statement/{id}/summary
GET  /api/v1/statement/{id}/subscriptions
POST /api/v1/webhook
```

### Example Request
```json
{
  "file": "base64_encoded_pdf_or_csv",
  "format": "pdf"
}
```

### Example Response (Summary)
```json
{
  "total_spend": 1200.50,
  "top_categories": ["Dining", "Groceries", "Utilities"],
  "subscriptions": [
    {"merchant": "Netflix", "amount": 15.99, "frequency": "monthly"}
  ],
  "anomalies": [
    {"date": "2024-06-01", "merchant": "Unknown", "amount": 200.00, "note": "Unusual spend"}
  ]
}
```

---

## 6. Simple Architecture

```
[Client] → API Gateway → Parser & Insights Engine → Response
```

- **No complex integrations**
- **In-memory processing** for speed
- **No sensitive data stored**

---

## 7. Security & Privacy

- **No statement retention** (processed in memory)
- **API key authentication**
- **HTTPS only**
- **Rate limiting**

---

## 8. Monetization Plan

### Free Tier (Launch Day)
- 20 statements/month
- Basic parsing & summary
- Community support

### Pro Tier ($29/month)
- 500 statements/month
- Subscription detection
- Webhook notifications
- Email support

### Pay-as-you-go
- $0.10 per statement after limit

---

## 9. 7-Day Launch Plan

### Day 1-2: Core Development
- Build PDF/CSV parser for common formats
- Implement REST API endpoints
- Extract transactions and basic fields

### Day 3-4: Features & Testing
- Add subscription detection (simple pattern matching)
- Generate spend summaries
- Test with real statements

### Day 5-6: Infrastructure & Docs
- Deploy API
- Write API documentation
- Build simple landing page

### Day 7: Launch & Marketing
- Post on Product Hunt, Indie Hackers, and Reddit
- Reach out to 10 fintech founders
- Offer free credits to first 20 signups

---

## 10. Go-to-Market Strategy

- **Launch on developer platforms** (Product Hunt, Indie Hackers)
- **Share on fintech and dev communities** (Reddit, Twitter)
- **Direct outreach** to indie app builders and small fintechs
- **Create sample integrations** (e.g., "Add spend insights to your app in 10 minutes!")
- **Offer free credits** for early adopters

---

## 11. Key Metrics

- **API calls per day**
- **Number of signups**
- **First week revenue**
- **Subscription detection accuracy**
- **Customer retention**

---

## 12. Risk Mitigation

| Risk                   | Mitigation                                 |
| ---------------------- | ------------------------------------------ |
| Format drift           | Start with most common formats, iterate    |
| Low adoption           | Focus on developer pain points, fast feedback |
| Data privacy concerns  | No data retention, clear privacy policy    |

---

## 13. Success Criteria

- 20 signups in first week
- 100 statements processed
- $100 in revenue in first 7 days

---

## 14. Call to Action

Cardra makes it easy for developers to add credit card statement insights to any app. No complex setup, no sensitive data stored—just upload a statement and get instant results.

**Start your free trial at api.cardra.com**

---

*Built for developers and fintech builders who want to launch fast.*
