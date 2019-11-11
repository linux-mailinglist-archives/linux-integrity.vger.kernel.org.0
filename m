Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC8EF8005
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Nov 2019 20:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfKKTdM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Nov 2019 14:33:12 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44862 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbfKKTdL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Nov 2019 14:33:11 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 53FAA20B490A;
        Mon, 11 Nov 2019 11:33:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 53FAA20B490A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573500790;
        bh=vVWpClEcFcpAowfWbFY2ESxzTm/YP//DDYRJ/xxk6To=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eBXUregc316UFl+Gocc0g/Qz8shfEDGUumHzIXECKiuau/UHXD1f/sSvmnq/QCC6w
         0M/bqLtrDMaNRbIfkZD57YN32hpwV5HcIaFWRczObp6ggXfk8I56CWuMb2HKL7p+xS
         Zi9562Li+ETyvfuBFk9r1jvdffzu970JHHthru9s=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/10] IMA: Call queue and dequeue functions to measure keys.
Date:   Mon, 11 Nov 2019 11:33:03 -0800
Message-Id: <20191111193303.12781-11-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111193303.12781-1-nramas@linux.microsoft.com>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Keys should be queued for measurement if custom IMA policies have
not been applied. Keys queued for measurement, if any, need to be
processed when custom IMA policies have been applied.

This patch adds the call to ima_queue_key_for_measurement in the IMA hook
function and the call to ima_process_queued_keys_for_measurement when
custom IMA policies have been applied.

NOTE:
If the kernel is built with CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
then the IMA policy for measuring keys should be applied as part of
custom IMA policies. Keys will be queued up until custom policies
are applied and processed when applied.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_asymmetric_keys.c | 31 ++++++++++++++++++--
 security/integrity/ima/ima_policy.c          | 12 ++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 4a38b4957b8c..fab1d4672715 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -158,15 +158,42 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   unsigned long flags, bool create)
 {
 	const struct public_key *pk;
+	bool key_queued = false;
 
-	/* Only asymmetric keys are handled */
+	/* Only asymmetric keys are handled by this hook. */
 	if (key->type != &key_type_asymmetric)
 		return;
 
+	if (!ima_process_keys_for_measurement)
+		key_queued = ima_queue_key_for_measurement(keyring, key);
+
 	/*
-	 * Get the public_key of the given asymmetric key to measure.
+	 * Need to check again if the key was queued or not because
+	 * ima_process_keys_for_measurement could have flipped from
+	 * false to true after it was checked above, but before the key
+	 * could be queued by ima_queue_key_for_measurement().
 	 */
+	if (key_queued)
+		return;
+
+	/* Public key of the given asymmetric key is measured. */
 	pk = key->payload.data[asym_crypto];
+
+	/*
+	 * keyring->description points to the name of the keyring
+	 * (such as ".builtin_trusted_keys", ".ima", etc.) to
+	 * which the given key is linked to.
+	 *
+	 * The name of the keyring is passed in the "eventname"
+	 * parameter to process_buffer_measurement() and is set
+	 * in the "eventname" field in ima_event_data for
+	 * the key measurement IMA event.
+	 *
+	 * The name of the keyring is also passed in the "keyring"
+	 * parameter to process_buffer_measurement() to check
+	 * if the IMA policy is configured to measure a key linked
+	 * to the given keyring.
+	 */
 	process_buffer_measurement(pk->key, pk->keylen,
 				   keyring->description,
 				   KEYRING_CHECK, 0,
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index d1889eee9287..d130bdcbc174 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -759,6 +759,18 @@ void ima_update_policy(void)
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

