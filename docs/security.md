# 🔐 DPI Security Stack – Data Protection & Privacy Infrastructure

## Overview

This module defines the security architecture required for handling sensitive data in DPI systems. It provides building blocks for **data protection**, **encryption**, and **privacy-preserving computation**. These tools can be integrated into APIs, batch jobs, and data pipelines.

---

## Table of Contents

1. [Core Components](#-components)
2. [Setup Instructions](#-setup-instructions)
   1. [PyCryptodome/Fernet](#1-pycryptodome--fernet-encryption-library)
   2. [Vault](#2-vault-secret-management)
   3. [Open Policy Agent](#3-open-policy-agent-opa)
   4. [TensorFlow Privacy/OpenDP](#4-tensorflow-privacy--opendp-differential-privacy)
3. [Cross-Language Considerations](#-cross-language-considerations)
4. [Best Practices](#-best-practices)
5. [Nigeria DPI Notes](#-nigeria-dpi-notes)
6. [References](#-references)
7. [Contributors](#-contributors)

---

## 🔧 Components

| Function                   | Tool                      | Description |
|---------------------------|---------------------------|-------------|
| Data Encryption           | PyCryptodome / Fernet     | AES-256 encryption & symmetric key operations |
| Secrets Management        | Vault (by HashiCorp)      | Secure key & credential storage |
| Differential Privacy      | TensorFlow Privacy / OpenDP | Add noise to analytics to protect individual identity |
| Policy Enforcement        | Open Policy Agent (OPA)   | Declarative policies for access control & purpose limitation |

---

## 🛠 Setup Instructions

### 1. PyCryptodome / Fernet (Encryption Library)

```bash
pip install pycryptodome cryptography
```

```python
from cryptography.fernet import Fernet

# Generate & store key
key = Fernet.generate_key()
cipher = Fernet(key)

# Encrypt
token = cipher.encrypt(b"confidential DPI data")

# Decrypt
data = cipher.decrypt(token)

# AES Example
from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes

key = get_random_bytes(32)
cipher = AES.new(key, AES.MODE_EAX)
```

---

### 2. Vault (Secret Management)

**Start in dev mode** (not for production):

```bash
vault server -dev
```

**Store and retrieve secrets:**

```bash
export VAULT_ADDR='http://127.0.0.1:8200'
vault kv put secret/dpi api_key=abcd1234
vault kv get secret/dpi
```

**Production integrations:**

- AWS IAM auth
- Kubernetes auth
- PKI certificates

---

### 3. Open Policy Agent (OPA)

**Install:**

```bash
chmod +x install_opa.sh
./install_opa.sh
```

**Create policy** (`consent.rego`):

```rego
package consent

allow {
  input.user == "user123"
  input.purpose == "healthcare"
}
```

**Query via HTTP API:**

```bash
opa run --server

# POST request
{
  "input": {
    "user": "user123",
    "purpose": "healthcare"
  }
}

```

---

### 4. TensorFlow Privacy / OpenDP (Differential Privacy)

**TensorFlow Privacy:**

```bash
pip install tensorflow tensorflow-privacy
```

```python
from tensorflow_privacy.privacy.optimizers.dp_optimizer_keras import DPKerasAdamOptimizer
```

**OpenDP:**

```bash
pip install opendp
```

```python
from opendp.transformations import make_bounded_sum
trans = make_bounded_sum(bounds=(0, 1))
```

---

## 🌐 Cross-Language Considerations

| Component         | Java          | GoLang        | .NET          |
|-------------------|---------------|---------------|---------------|
| Vault             | ✅ (SDK)      | ✅ (SDK)      | ✅ (REST)     |
| OPA               | ✅ (HTTP)     | ✅ (SDK)      | ✅ (HTTP)     |
| Encryption        | ✅ (JCE)      | ✅ (x/crypto) | ✅ (System.Security) |
| Privacy (TF/DP)   | ⚠️ Python-only | ❌           | ❌           |

---

## ✅ Best Practices

- Use Fernet or AES-256 for all in-transit and at-rest data encryption
- Centralize secret storage using Vault or AWS KMS
- Validate access with policy-as-code (OPA) at API or gateway level
- Add differential privacy where data aggregation or model training is done
- Enforce purpose limitation in APIs using OPA policies

---

## 🇳🇬 Nigeria DPI Notes

- Align with NDPR for citizen data protection
- Support offline encryption and syncing
- Host Vault on-premises for government/sovereign cloud usage
- Use local language codes in policy enforcement (e.g., `"purpose": "agriculture-data-hausa"`)

---

## 📚 References

- [Vault by HashiCorp](https://www.vaultproject.io)
- [Open Policy Agent](https://www.openpolicyagent.org)
- [TensorFlow Privacy](https://www.tensorflow.org/responsible_ai/privacy)
- [OpenDP](https://opendp.org)
- [NDPR Nigeria](https://nitda.gov.ng/ndpr)

---

## 🤝 Contributors

Security guidelines curated as part of the DPI middleware stack for scalable and responsible platform design in Nigeria markets.
