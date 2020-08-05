Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB30523C2AF
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 02:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgHEAnj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Aug 2020 20:43:39 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38366 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgHEAnh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Aug 2020 20:43:37 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id ED0F120B490A;
        Tue,  4 Aug 2020 17:43:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED0F120B490A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596588216;
        bh=SF9nLu7J2HUvWV7Tl+ZwVBSS+d5Qa91rslKFBRAWfq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SwPdfQBvdVK2gPdIEwEvbF0H4ed7PrBGla5VF04p65M5fa0kMmJozKIJy+EBsm4ED
         IoSdqWDBoALJYHcJ6hvC2/wdNxRGXfVPt7hz8sGMGtppNduc8lPxSpMBISIjFkhIv2
         XDlpO2YBoYk8MMgQ1tz4Fmm2OiglfUiHd95jSzLs=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/4] IMA: Add func to measure LSM state and policy
Date:   Tue,  4 Aug 2020 17:43:28 -0700
Message-Id: <20200805004331.20652-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200805004331.20652-1-nramas@linux.microsoft.com>
References: <20200805004331.20652-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Critical data structures of security modules need to be measured to
enable an attestation service to verify if the configuration and
policies for the security modules have been setup correctly and
that they haven't been tampered with at runtime. A new IMA policy is
required for handling this measurement.

Define two new IMA policy func namely LSM_STATE and LSM_POLICY to
measure the state and the policy provided by the security modules.
Update ima_match_rules() and ima_validate_rule() to check for
the new func and ima_parse_rule() to handle the new func.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy |  9 ++++++++
 security/integrity/ima/ima.h         |  2 ++
 security/integrity/ima/ima_api.c     |  2 +-
 security/integrity/ima/ima_policy.c  | 34 ++++++++++++++++++++++++----
 4 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index cd572912c593..b7c7fb548c0c 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -30,6 +30,7 @@ Description:
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
 				[KEXEC_CMDLINE] [KEY_CHECK]
+				[LSM_STATE] [LSM_POLICY]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
@@ -125,3 +126,11 @@ Description:
 		keys added to .builtin_trusted_keys or .ima keyring:
 
 			measure func=KEY_CHECK keyrings=.builtin_trusted_keys|.ima
+
+		Example of measure rule using LSM_STATE to measure LSM state:
+
+			measure func=LSM_STATE template=ima-buf
+
+		Example of measure rule using LSM_POLICY to measure LSM policy:
+
+			measure func=LSM_POLICY template=ima-ng
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 38043074ce5e..1b5f4b2f17d0 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -200,6 +200,8 @@ static inline unsigned int ima_hash_key(u8 *digest)
 	hook(POLICY_CHECK, policy)			\
 	hook(KEXEC_CMDLINE, kexec_cmdline)		\
 	hook(KEY_CHECK, key)				\
+	hook(LSM_STATE, lsm_state)			\
+	hook(LSM_POLICY, lsm_policy)			\
 	hook(MAX_CHECK, none)
 
 #define __ima_hook_enumify(ENUM, str)	ENUM,
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 4f39fb93f278..8c8b4e4a6493 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -176,7 +176,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *		subj=, obj=, type=, func=, mask=, fsmagic=
  *	subj,obj, and type: are LSM specific.
  *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
- *	| KEXEC_CMDLINE | KEY_CHECK
+ *	| KEXEC_CMDLINE | KEY_CHECK | LSM_STATE | LSM_POLICY
  *	mask: contains the permission mask
  *	fsmagic: hex value
  *
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 07f033634b27..e4de581442d5 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -442,13 +442,21 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 {
 	int i;
 
-	if (func == KEY_CHECK) {
-		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
-		       ima_match_keyring(rule, keyring, cred);
-	}
 	if ((rule->flags & IMA_FUNC) &&
 	    (rule->func != func && func != POST_SETATTR))
 		return false;
+
+	switch (func) {
+	case KEY_CHECK:
+		return ((rule->func == func) &&
+			ima_match_keyring(rule, keyring, cred));
+	case LSM_STATE:
+	case LSM_POLICY:
+		return (rule->func == func);
+	default:
+		break;
+	}
+
 	if ((rule->flags & IMA_MASK) &&
 	    (rule->mask != mask && func != POST_SETATTR))
 		return false;
@@ -1044,6 +1052,18 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (ima_rule_contains_lsm_cond(entry))
 			return false;
 
+		break;
+	case LSM_STATE:
+	case LSM_POLICY:
+		if (entry->action & ~(MEASURE | DONT_MEASURE))
+			return false;
+
+		if (entry->flags & ~(IMA_FUNC | IMA_PCR))
+			return false;
+
+		if (ima_rule_contains_lsm_cond(entry))
+			return false;
+
 		break;
 	default:
 		return false;
@@ -1176,6 +1196,12 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = KEXEC_CMDLINE;
 			else if (strcmp(args[0].from, "KEY_CHECK") == 0)
 				entry->func = KEY_CHECK;
+			else if (IS_ENABLED(CONFIG_SECURITY_SELINUX) &&
+				 strcmp(args[0].from, "LSM_STATE") == 0)
+				entry->func = LSM_STATE;
+			else if (IS_ENABLED(CONFIG_SECURITY_SELINUX) &&
+				 strcmp(args[0].from, "LSM_POLICY") == 0)
+				entry->func = LSM_POLICY;
 			else
 				result = -EINVAL;
 			if (!result)
-- 
2.27.0

