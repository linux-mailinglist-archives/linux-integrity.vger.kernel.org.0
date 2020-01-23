Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95E7614605D
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2020 02:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgAWBcN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jan 2020 20:32:13 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55886 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgAWBcM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jan 2020 20:32:12 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id B76C0200881F;
        Wed, 22 Jan 2020 17:32:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B76C0200881F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1579743131;
        bh=yzBpJmLcmKpLbuMp++dNzRjccHLIRwtlfv7PZnss+EY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D6Goiyvf+e4WRHC7bwFHhDpvBKDZPqCuqUvkcipCyrJOzhd9ivKsVX0e9hX34tg2n
         NhOiPfQtsp/hY1Qmo66hgHKWlH32yjpUfWwrRwofUzOl8Ysha92BlrgD3q3YbxHup5
         GksSY1/kjUlpKP34205DivG2c4ikLQVwyK53qIN0=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH v9 2/3] IMA: Call workqueue functions to measure queued keys
Date:   Wed, 22 Jan 2020 17:32:05 -0800
Message-Id: <20200123013206.8499-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200123013206.8499-1-nramas@linux.microsoft.com>
References: <20200123013206.8499-1-nramas@linux.microsoft.com>
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

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_asymmetric_keys.c | 8 ++++++++
 security/integrity/ima/ima_policy.c          | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index fea2e7dd3b09..7678f0e3e84d 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -30,6 +30,8 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   const void *payload, size_t payload_len,
 				   unsigned long flags, bool create)
 {
+	bool queued = false;
+
 	/* Only asymmetric keys are handled by this hook. */
 	if (key->type != &key_type_asymmetric)
 		return;
@@ -37,6 +39,12 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	if (!payload || (payload_len == 0))
 		return;
 
+	if (ima_should_queue_key())
+		queued = ima_queue_key(keyring, payload, payload_len);
+
+	if (queued)
+		return;
+
 	/*
 	 * keyring->description points to the name of the keyring
 	 * (such as ".builtin_trusted_keys", ".ima", etc.) to
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 3b16b190ae9b..f2fc24511cf4 100644
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

