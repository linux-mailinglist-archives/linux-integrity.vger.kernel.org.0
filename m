Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0131368AE
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Jun 2019 02:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfFFAQv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jun 2019 20:16:51 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35708 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFFAQu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jun 2019 20:16:50 -0400
Received: from [10.200.157.26] (unknown [131.107.160.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id BED9720B46F1;
        Wed,  5 Jun 2019 17:16:49 -0700 (PDT)
To:     Linux Integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Cc:     James Morris <jamorris@linux.microsoft.com>,
        Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Jordan Hand <jorhand@linux.microsoft.com>
From:   Lakshmi <nramas@linux.microsoft.com>
Subject: [PATCH 1/2] [IMA] Measure public keys of BuiltIn Trusted Keys - Query
 public key of given key
Message-ID: <098f2b8f-6d9d-dd75-f163-7bf75f16ffd9@linux.microsoft.com>
Date:   Wed, 5 Jun 2019 17:16:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Added a new interface method namely query_public_key
to asymmetric_key_subtype interface.

Defined public_key_query_public_key method that returns the public key
of the given key. This method is called when the query_public_key
interface method in asymmetric_key_subtype interface is invoked.

This change will be used by IMA (described in
PATCH 2/2: [IMA] Measure public keys of BuiltIn Trusted Keys) that
measures the public key of keys in BuiltIn Trusted Keys.

Signed-off-by: Lakshmi <nramas@microsoft.com>
---
  Documentation/crypto/asymmetric-keys.txt |  1 +
  crypto/asymmetric_keys/public_key.c      |  7 +++++++
  crypto/asymmetric_keys/signature.c       | 24 ++++++++++++++++++++++++
  include/crypto/public_key.h              |  1 +
  include/keys/asymmetric-subtype.h        |  3 +++
  5 files changed, 36 insertions(+)

diff --git a/Documentation/crypto/asymmetric-keys.txt 
b/Documentation/crypto/asymmetric-keys.txt
index 8763866b11cf..50f79dd54ab6 100644
--- a/Documentation/crypto/asymmetric-keys.txt
+++ b/Documentation/crypto/asymmetric-keys.txt
@@ -189,6 +189,7 @@ and looks like the following:
  			      const void *in, void *out);
  		int (*verify_signature)(const struct key *key,
  					const struct public_key_signature *sig);
+		const struct public_key* (*query_public_key)(const struct key *key);
  	};

  Asymmetric keys point to this with their payload[asym_subtype] member.
diff --git a/crypto/asymmetric_keys/public_key.c 
b/crypto/asymmetric_keys/public_key.c
index 77e0ae7840ff..97a27c7e4f94 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -332,6 +332,12 @@ static int public_key_verify_signature_2(const 
struct key *key,
  	return public_key_verify_signature(pk, sig);
  }

+static const struct public_key *public_key_query_public_key(
+					const struct key *key)
+{
+	return key->payload.data[asym_crypto];
+}
+
  /*
   * Public key algorithm asymmetric key subtype
   */
@@ -344,5 +350,6 @@ struct asymmetric_key_subtype public_key_subtype = {
  	.query			= software_key_query,
  	.eds_op			= software_key_eds_op,
  	.verify_signature	= public_key_verify_signature_2,
+	.query_public_key	= public_key_query_public_key,
  };
  EXPORT_SYMBOL_GPL(public_key_subtype);
diff --git a/crypto/asymmetric_keys/signature.c 
b/crypto/asymmetric_keys/signature.c
index ad95a58c6642..7db14f8f3ddd 100644
--- a/crypto/asymmetric_keys/signature.c
+++ b/crypto/asymmetric_keys/signature.c
@@ -161,3 +161,27 @@ int verify_signature(const struct key *key,
  	return ret;
  }
  EXPORT_SYMBOL_GPL(verify_signature);
+
+const struct public_key *query_public_key(const struct key *key)
+{
+	const struct public_key *pk;
+	const struct asymmetric_key_subtype *subtype;
+
+	pr_devel("==>%s()\n", __func__);
+
+	if (key->type != &key_type_asymmetric)
+		return NULL;
+	subtype = asymmetric_key_subtype(key);
+	if (!subtype ||
+	    !key->payload.data[0])
+		return NULL;
+	if (!subtype->query_public_key)
+		return NULL;
+
+	pk = subtype->query_public_key(key);
+
+	pr_devel("<==%s()\n", __func__);
+
+	return pk;
+}
+EXPORT_SYMBOL_GPL(query_public_key);
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 712fe1214b5f..6f3a0d1f3c80 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -81,6 +81,7 @@ extern int decrypt_blob(struct kernel_pkey_params *, 
const void *, void *);
  extern int create_signature(struct kernel_pkey_params *, const void *, 
void *);
  extern int verify_signature(const struct key *,
  			    const struct public_key_signature *);
+extern const struct public_key *query_public_key(const struct key *key);

  int public_key_verify_signature(const struct public_key *pkey,
  				const struct public_key_signature *sig);
diff --git a/include/keys/asymmetric-subtype.h 
b/include/keys/asymmetric-subtype.h
index 9ce2f0fae57e..8e1cbeed4d54 100644
--- a/include/keys/asymmetric-subtype.h
+++ b/include/keys/asymmetric-subtype.h
@@ -46,6 +46,9 @@ struct asymmetric_key_subtype {
  	/* Verify the signature on a key of this subtype (optional) */
  	int (*verify_signature)(const struct key *key,
  				const struct public_key_signature *sig);
+
+	/* Query public key of the given key */
+	const struct public_key *(*query_public_key)(const struct key *key);
  };

  /**
-- 
2.17.1

