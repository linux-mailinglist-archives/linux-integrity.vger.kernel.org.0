Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C34B12FD4F
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2020 20:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgACTyx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jan 2020 14:54:53 -0500
Received: from linux.microsoft.com ([13.77.154.182]:35980 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbgACTyn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jan 2020 14:54:43 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 50EF920B479A;
        Fri,  3 Jan 2020 11:54:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 50EF920B479A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1578081282;
        bh=G7JsHkOv/dsWoA1W1YI9qCN8w3wlw2Y2hEWkl92HWFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BmV/F8pBcuU0wThe5VP4CVKiOITLJn1dXzJti/SidAHmpwsXpSl3LQCNYD2Zj+6UJ
         MxwmiPJG94xZ3XTeZ9UKPboUf+GG8+KTnh2KURJT/qp3eEYWU3I17EF0ikzBXKl+DM
         eMvBuPgcT8Uo5BQz8HQp5tGGb1O4fPW+9zWqUcqA=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     James.Bottomley@HansenPartnership.com, eric.snowberg@oracle.com,
        dhowells@redhat.com, mathew.j.martineau@linux.intel.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [PATCH v7 2/3] IMA: Call workqueue functions to measure queued keys
Date:   Fri,  3 Jan 2020 11:54:34 -0800
Message-Id: <20200103195435.2647-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103195435.2647-1-nramas@linux.microsoft.com>
References: <20200103195435.2647-1-nramas@linux.microsoft.com>
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
index 1d56f003f1a7..eb71cbf224c1 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -145,6 +145,8 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   const void *payload, size_t payload_len,
 				   unsigned long flags, bool create)
 {
+	bool queued = false;
+
 	/* Only asymmetric keys are handled by this hook. */
 	if (key->type != &key_type_asymmetric)
 		return;
@@ -152,6 +154,12 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
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

