Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D882D1F805F
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jun 2020 04:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgFMClh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jun 2020 22:41:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54102 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgFMClh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jun 2020 22:41:37 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 28EFE20B4780;
        Fri, 12 Jun 2020 19:41:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 28EFE20B4780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592016096;
        bh=WVGmiiMS7vSH7gVwPrFMIQeJRoD4AACiFyCZE6Qm16s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o9UcLG+H6pVJ4Co/Cd/R0cdp/JBg2sTz6B5yOd2ll61VQR+dKb5917dnnhSQ28r35
         mQXDPqaJBdWPYpg10rZwjlVuT9iOcjhux7ec2SA2Caz6ebauM5JVA7wfI3cSL9zPy6
         GGb2EKm282FN2mZM6Vzbg5AcVWDhWkHg6rzQNt2w=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley@gmail.com,
        casey@schaufler-ca.com
Cc:     jmorris@namei.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] IMA: Add LSM_STATE func to measure LSM data
Date:   Fri, 12 Jun 2020 19:41:26 -0700
Message-Id: <20200613024130.3356-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200613024130.3356-1-nramas@linux.microsoft.com>
References: <20200613024130.3356-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Data provided by security modules need to be measured. A new IMA policy
is required for handling this measurement.

Define a new IMA policy func namely LSM_STATE to measure data provided
by security modules. Update ima_match_rules() to check for LSM_STATE
and ima_parse_rule() to handle LSM_STATE.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy |  6 +++++-
 security/integrity/ima/ima.h         |  1 +
 security/integrity/ima/ima_api.c     |  2 +-
 security/integrity/ima/ima_policy.c  | 28 +++++++++++++++++++++++-----
 4 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index cd572912c593..355bc3eade33 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -29,7 +29,7 @@ Description:
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
-				[KEXEC_CMDLINE] [KEY_CHECK]
+				[KEXEC_CMDLINE] [KEY_CHECK] [LSM_STATE]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
@@ -125,3 +125,7 @@ Description:
 		keys added to .builtin_trusted_keys or .ima keyring:
 
 			measure func=KEY_CHECK keyrings=.builtin_trusted_keys|.ima
+
+		Example of measure rule using LSM_STATE to measure LSM data:
+
+			measure func=LSM_STATE
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index df93ac258e01..58c62269028a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -200,6 +200,7 @@ static inline unsigned int ima_hash_key(u8 *digest)
 	hook(POLICY_CHECK)		\
 	hook(KEXEC_CMDLINE)		\
 	hook(KEY_CHECK)			\
+	hook(LSM_STATE)			\
 	hook(MAX_CHECK)
 #define __ima_hook_enumify(ENUM)	ENUM,
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index bf22de8b7ce0..0cebd2404dcf 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -176,7 +176,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *		subj=, obj=, type=, func=, mask=, fsmagic=
  *	subj,obj, and type: are LSM specific.
  *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
- *	| KEXEC_CMDLINE | KEY_CHECK
+ *	| KEXEC_CMDLINE | KEY_CHECK | LSM_STATE
  *	mask: contains the permission mask
  *	fsmagic: hex value
  *
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e493063a3c34..1a6ee09e6993 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -417,15 +417,31 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 			    const char *keyring)
 {
 	int i;
+	int funcmatch = 0;
 
-	if ((func == KEXEC_CMDLINE) || (func == KEY_CHECK)) {
+	switch (func) {
+	case KEXEC_CMDLINE:
+	case KEY_CHECK:
+	case LSM_STATE:
 		if ((rule->flags & IMA_FUNC) && (rule->func == func)) {
 			if (func == KEY_CHECK)
-				return ima_match_keyring(rule, keyring, cred);
-			return true;
-		}
-		return false;
+				funcmatch = ima_match_keyring(rule, keyring,
+							      cred) ? 1 : -1;
+			else
+				funcmatch = 1;
+		} else
+			funcmatch = -1;
+
+		break;
+
+	default:
+		funcmatch = 0;
+		break;
 	}
+
+	if (funcmatch)
+		return (funcmatch == 1) ? true : false;
+
 	if ((rule->flags & IMA_FUNC) &&
 	    (rule->func != func && func != POST_SETATTR))
 		return false;
@@ -1068,6 +1084,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = KEXEC_CMDLINE;
 			else if (strcmp(args[0].from, "KEY_CHECK") == 0)
 				entry->func = KEY_CHECK;
+			else if (strcmp(args[0].from, "LSM_STATE") == 0)
+				entry->func = LSM_STATE;
 			else
 				result = -EINVAL;
 			if (!result)
-- 
2.27.0

