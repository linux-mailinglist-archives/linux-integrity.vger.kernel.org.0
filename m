Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B13D11E90F
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2019 18:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfLMRSf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Dec 2019 12:18:35 -0500
Received: from linux.microsoft.com ([13.77.154.182]:35420 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbfLMRSf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Dec 2019 12:18:35 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id DB2BE20B71AC;
        Fri, 13 Dec 2019 09:18:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DB2BE20B71AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576257513;
        bh=I0gjxohX1nBjPsiUh65vZrUktQccLgJ11vyHnoHaE/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YqVEwjtOsUq9YlmsaHv8f0c4NvpJKet2O1xdGggQL60Kze0GC24Y4LS/WS2A6zCeZ
         On0Ns5QiyMf+dWJEtgXEwtIVFlRru7yiBK1z4sfE9rXeg0RAXoJmsdBgNL9SBHuxq6
         FotJZq7cOU1NbnkplGvIPfeduMkGeEHpN6ixa22s=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH v4 2/2] IMA: Call workqueue functions to measure queued keys
Date:   Fri, 13 Dec 2019 09:18:27 -0800
Message-Id: <20191213171827.28657-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213171827.28657-1-nramas@linux.microsoft.com>
References: <20191213171827.28657-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Measuring keys requires a custom IMA policy to be loaded.
Keys should be queued for measurement if a custom IMA policy
is not yet loaded. Keys queued for measurement, if any, should be
processed when a custom IMA policy is loaded.

This patch updates the IMA hook function ima_post_key_create_or_update()
to queue the key if a custom IMA policy has not yet been loaded.
And, ima_update_policy() function, which is called when
a custom IMA policy is loaded, is updated to process queued keys.

Sample "key" measurement rule in the IMA policy:

measure func=KEY_CHECK uid=0 keyrings=.ima|.builtin_trusted_keys template=ima-buf

If the kernel is built with one or more built-in trusted certificates,
IMA measurement should list all the keys imported from those certificates.

Display "key" measurement in the IMA measurement list:

cat /sys/kernel/security/ima/ascii_runtime_measurements

10 faf3...e702 ima-buf sha256:27c915b8ddb9fae7214cf0a8a7043cc3eeeaa7539bcb136f8427067b5f6c3b7b .builtin_trusted_keys 308202863082...4aee

Verify "key" measurement data for a key added to ".builtin_trusted_keys" keyring:

cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements | grep -m 1 "\.builtin_trusted_keys" | cut -d' ' -f 6 | xxd -r -p |tee btk-cert.der | sha256sum | cut -d' ' -f 1

The output of the above command should match the template hash
of the first "key" measurement entry in the IMA measurement list for
the key added to ".builtin_trusted_keys" keyring.

The file namely "btk-cert.der" generated by the above command
should be a valid x509 certificate (in DER format) and should match
the one that was used to import the key to the ".builtin_trusted_keys" keyring.
The certificate file can be verified using openssl tool.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_asymmetric_keys.c | 8 ++++++++
 security/integrity/ima/ima_policy.c          | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index ae6de1bb2e79..8a9d8bc7e10d 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -158,6 +158,8 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   const void *payload, size_t payload_len,
 				   unsigned long flags, bool create)
 {
+	bool queued = false;
+
 	/* Only asymmetric keys are handled by this hook. */
 	if (key->type != &key_type_asymmetric)
 		return;
@@ -165,6 +167,12 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	if (!payload || (payload_len == 0))
 		return;
 
+	if (!ima_process_keys)
+		queued = ima_queue_key(keyring, payload, payload_len);
+
+	if (queued)
+		return;
+
 	/*
 	 * keyring->description points to the name of the keyring
 	 * (such as ".builtin_trusted_keys", ".ima", etc.) to
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index a4dde9d575b2..04b9c6c555de 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -807,6 +807,9 @@ void ima_update_policy(void)
 		kfree(arch_policy_entry);
 	}
 	ima_update_policy_flag();
+
+	/* Custom IMA policy has been loaded */
+	ima_process_queued_keys();
 }
 
 /* Keep the enumeration in sync with the policy_tokens! */
-- 
2.17.1

