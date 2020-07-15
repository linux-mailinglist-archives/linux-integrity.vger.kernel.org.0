Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C292211A5
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 17:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgGOPtm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 11:49:42 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45900 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgGOPs7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 11:48:59 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id D03CB20B4909;
        Wed, 15 Jul 2020 08:48:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D03CB20B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594828139;
        bh=JPlRumbOfvyOco8L8nkT1d2Rp+0/lx8FfGi5jva830E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V8Z90u3n3Edtg4DNq9sdR21/qS4DM3+DhjPKfEzdx22E2qNsyPmUqqBOCk6pwmgVO
         naeoyfb93tlv0K16kntLc5r2JWk1OAGmpzaiZXNA9QQBz8DpsFKGa1RyNWiLyPMn5u
         76U29TvGvk09P3mvIUXPQjup/USv/mMc5QIMVYPY=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     jmorris@namei.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] IMA: Add LSM_STATE func to measure LSM data
Date:   Wed, 15 Jul 2020 08:48:49 -0700
Message-Id: <20200715154853.23374-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200715154853.23374-1-nramas@linux.microsoft.com>
References: <20200715154853.23374-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Critical data structures of security modules need to be measured to
enable an attestation service to verify if the policies and
configuration have been setup correctly and that they haven't been
tampered with at runtime. A new IMA policy is required for handling
this measurement.

Define a new IMA policy func namely LSM_STATE to measure data provided
by security modules. Update ima_match_rules() to check for LSM_STATE
and ima_parse_rule() to handle LSM_STATE.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy |  6 +++++-
 security/integrity/ima/ima.h         |  1 +
 security/integrity/ima/ima_api.c     |  2 +-
 security/integrity/ima/ima_policy.c  | 29 +++++++++++++++++++++++-----
 4 files changed, 31 insertions(+), 7 deletions(-)

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
index 4515975cc540..880fda11a61b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -200,6 +200,7 @@ static inline unsigned int ima_hash_key(u8 *digest)
 	hook(POLICY_CHECK, policy)			\
 	hook(KEXEC_CMDLINE, kexec_cmdline)		\
 	hook(KEY_CHECK, key)				\
+	hook(LSM_STATE, lsm_state)			\
 	hook(MAX_CHECK, none)
 
 #define __ima_hook_enumify(ENUM, str)	ENUM,
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
index 66aa3e17a888..fc8457d9242b 100644
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
@@ -1068,6 +1084,9 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = KEXEC_CMDLINE;
 			else if (strcmp(args[0].from, "KEY_CHECK") == 0)
 				entry->func = KEY_CHECK;
+			else if (strcmp(args[0].from, "LSM_STATE") == 0)
+				entry->func = LSM_STATE;
+
 			else
 				result = -EINVAL;
 			if (!result)
-- 
2.27.0

