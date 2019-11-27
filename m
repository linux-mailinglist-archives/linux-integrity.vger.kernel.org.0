Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F69310A8E3
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 03:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfK0CwT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Nov 2019 21:52:19 -0500
Received: from linux.microsoft.com ([13.77.154.182]:46244 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfK0CwT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Nov 2019 21:52:19 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 68EE420B4900;
        Tue, 26 Nov 2019 18:52:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 68EE420B4900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574823138;
        bh=NY73Sctw/JXdsrtDWDQpiJ3oE1L+m9cg6g8/RdNnFLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z62o4O2bb1Xid4vMBSOhc4wZmH6iMsOJWLXjWNW+hjgkazS8wOPG5oEzH0/hAVQCb
         06w1HzoD8BDDjWuV89/ChVOqsPmCg5J6J7Ri3MNEThErpwDVjV8+7LyLfUkBN9SxH2
         +Zzg3/bOkxbvcm+N+7SWkI4RSc9D6A4BKWZqU/lY=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [PATCH v0 2/2] IMA: Call queue functions to measure keys
Date:   Tue, 26 Nov 2019 18:52:12 -0800
Message-Id: <20191127025212.3077-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191127025212.3077-1-nramas@linux.microsoft.com>
References: <20191127025212.3077-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Keys should be queued for measurement if custom IMA policies have
not yet been applied. Keys queued for measurement, if any, need to be
processed when custom IMA policies have been applied.

This patch adds the call to ima_queue_key_for_measurement() in
the IMA hook function if ima_process_keys_for_measurement flag is set
to false. And, the call to ima_process_queued_keys_for_measurement()
when custom IMA policies have been applied in ima_update_policy().

NOTE:
If the kernel is built with CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
enabled then the IMA policy should be applied as custom IMA policies.

Keys will be queued up until custom policies are applied and processed
when custom policies have been applied.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_asymmetric_keys.c | 16 ++++++++++++++++
 security/integrity/ima/ima_policy.c          | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 10deb77b22a0..adb7a307190f 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -157,6 +157,8 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   const void *payload, size_t payload_len,
 				   unsigned long flags, bool create)
 {
+	bool key_queued = false;
+
 	/* Only asymmetric keys are handled by this hook. */
 	if (key->type != &key_type_asymmetric)
 		return;
@@ -164,6 +166,20 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	if (!payload || (payload_len == 0))
 		return;
 
+	if (!ima_process_keys_for_measurement)
+		key_queued = ima_queue_key_for_measurement(keyring,
+							   payload,
+							   payload_len);
+
+	/*
+	 * Need to check again if the key was queued or not because
+	 * ima_process_keys_for_measurement could have flipped from
+	 * false to true after it was checked above, but before the key
+	 * could be queued by ima_queue_key_for_measurement().
+	 */
+	if (key_queued)
+		return;
+
 	/*
 	 * keyring->description points to the name of the keyring
 	 * (such as ".builtin_trusted_keys", ".ima", etc.) to
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 78b25f083fe1..a2e30a90f97d 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -812,6 +812,18 @@ void ima_update_policy(void)
 		kfree(arch_policy_entry);
 	}
 	ima_update_policy_flag();
+
+	/*
+	 * Custom IMA policies have been setup.
+	 * Process key(s) queued up for measurement now.
+	 *
+	 * NOTE:
+	 *   Custom IMA policies always overwrite builtin policies
+	 *   (policies compiled in code). If one wants measurement
+	 *   of asymmetric keys then it has to be configured in
+	 *   custom policies and updated here.
+	 */
+	ima_process_queued_keys_for_measurement();
 }
 
 /* Keep the enumeration in sync with the policy_tokens! */
-- 
2.17.1

