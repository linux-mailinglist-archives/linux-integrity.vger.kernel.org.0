Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 846A5EA8AB
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 02:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfJaBTo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Oct 2019 21:19:44 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34428 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfJaBTS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Oct 2019 21:19:18 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 12B5A20B4903;
        Wed, 30 Oct 2019 18:19:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 12B5A20B4903
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572484757;
        bh=Yt7zvROV2WRfOD8Z9HJCq2ITyurhwXk4qzuAU0jlehg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AyzQn2hRMfh6Qz2mX5up1n0lUe0dYU8hgo5DyJD9VNUfMPfWLr/2SjkMY6F7RiQkn
         7hCIlp4rCiBrVyAsUoOKXEIkuWKzzisX/zgPe7/MMPmoNm4hzovtmIhihJeEzoVLqO
         MmI/YId1p1jFBJPhzk2MrKHg0ocHJM7eJphz/CTA=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc:     prsriva@linux.microsoft.com
Subject: [PATCH v3 3/9] KEYS: Added KEYRING_CHECK policy for key measurement
Date:   Wed, 30 Oct 2019 18:19:04 -0700
Message-Id: <20191031011910.2574-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031011910.2574-1-nramas@linux.microsoft.com>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

An IMA policy to manage measurement of keys is not supported.
A new IMA policy is needed to manage the measurement of keys.
A policy option is also needed to allow measurement of keys
linked to a given set of keyrings only.

This patch defines KEYRING_CHECK and keyrings in IMA policy
for this purpose. 

KEYRING_CHECK can be added in the IMA policy to measure keys.
keyrings can be, optionally, set to only measure keys
added or updated to a given set of keyrings. If keyrings is not
specified for KEYRING_CHECK, keys added or updated in
all keyrings are measured.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy | 15 +++++++++++++++
 security/integrity/ima/ima.h         |  1 +
 security/integrity/ima/ima_main.c    |  2 +-
 security/integrity/ima/ima_policy.c  |  2 +-
 security/integrity/ima/ima_queue.c   |  2 +-
 5 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index fc376a323908..757faf1a1a27 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -25,10 +25,12 @@ Description:
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
 			option:	[[appraise_type=]] [template=] [permit_directio]
+				[keyrings=]
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
 				[KEXEC_CMDLINE]
+				[KEYRING_CHECK]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
@@ -38,6 +40,9 @@ Description:
 			fowner:= decimal value
 		lsm:  	are LSM specific
 		option:	appraise_type:= [imasig]
+			keyrings: = list of keyrings to measure
+			(eg, .builtin_trusted_keys|.ima). Only valid
+			when action is "measure" and func is KEYRING_CHECK.
 			template:= name of a defined IMA template type
 			(eg, ima-ng). Only valid when action is "measure".
 			pcr:= decimal value
@@ -105,3 +110,13 @@ Description:
 
 			measure func=KEXEC_KERNEL_CHECK pcr=4
 			measure func=KEXEC_INITRAMFS_CHECK pcr=5
+
+		Example of measure rules using KEYRING_CHECK
+			To measure keys added to
+			.builtin_trusted_keys or .ima keyring:
+
+			measure func=KEYRING_CHECK keyrings=.builtin_trusted_keys|.ima
+
+			To measure keys added to all keyrings:
+
+			measure func=KEYRING_CHECK
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index b9600070e415..12e9ec6847b5 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -191,6 +191,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
 	hook(KEXEC_INITRAMFS_CHECK)	\
 	hook(POLICY_CHECK)		\
 	hook(KEXEC_CMDLINE)		\
+	hook(KEYRING_CHECK)		\
 	hook(MAX_CHECK)
 #define __ima_hook_enumify(ENUM)	ENUM,
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 18e1bc105be7..72ae0878ec5d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -718,7 +718,7 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	pk = key->payload.data[asym_crypto];
 	process_buffer_measurement(pk->key, pk->keylen,
 				   keyring->description,
-				   NONE, 0);
+				   KEYRING_CHECK, 0);
 }
 
 static int __init init_ima(void)
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 6df7f641ff66..0cc49f2d5233 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -370,7 +370,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 {
 	int i;
 
-	if (func == KEXEC_CMDLINE) {
+	if ((func == KEXEC_CMDLINE) || (func == KEYRING_CHECK)) {
 		if ((rule->flags & IMA_FUNC) && (rule->func == func))
 			return true;
 		return false;
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index f2503f10abf4..5625381c5a97 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -317,7 +317,7 @@ void ima_measure_queued_keys(void)
 		process_buffer_measurement(entry->public_key,
 					   entry->public_key_len,
 					   entry->keyring_name,
-					   NONE, 0);
+					   KEYRING_CHECK, 0);
 		list_del(&entry->list);
 		ima_free_measure_key_entry(entry);
 	}
-- 
2.17.1

