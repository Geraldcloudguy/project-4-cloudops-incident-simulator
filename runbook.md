# Incident Response Runbook

## Scenario 1 – EC2 Instance Stopped
**Detection**
CloudWatch alarm triggers on missing metrics.

**Response**
1. Check EC2 instance state
2. Restart instance
3. Verify service health

---

## Scenario 2 – Network Access Broken
**Detection**
SSH or service health check fails.

**Response**
1. Inspect Security Group inbound rules
2. Restore SSH from trusted IP
3. Confirm access restored

---

## Scenario 3 – High CPU Load
**Detection**
CloudWatch CPU alarm triggers.

**Response**
1. Connect to instance
2. Identify process consuming CPU
3. Restart service if required
