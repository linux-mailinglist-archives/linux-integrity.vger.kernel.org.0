Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F925EA8BD
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 02:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfJaBT7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Oct 2019 21:19:59 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34438 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfJaBTS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Oct 2019 21:19:18 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 38EF620B4904;
        Wed, 30 Oct 2019 18:19:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 38EF620B4904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572484757;
        bh=XlQLoUx/R/OlQ6F/D8Ody7ZjhmjwsfFRD9rGHtKdnZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W4xoXvW7Jef9sPGEsiw9ByZaydA07Uth+2dkpPRx8ES94qbzco6NK2hmqRE1FhjjT
         xeDXD9oDFJhRYL6aBME+Rl80JAQmSZJnd8M1OBNyx+MX8Ks4WxHY0D0D+ClF1rrU3p
         oDddkpdz0/TWT5H73xMW9++DaW9/5qNBxrgPU/0Q=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc:     prsriva@linux.microsoft.com
Subject: [PATCH v3 4/9] KEYS: Updated IMA policy functions for handling key measurement
Date:   Wed, 30 Oct 2019 18:19:05 -0700
Message-Id: <20191031011910.2574-5-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031011910.2574-1-nramas@linux.microsoft.com>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Information regarding what keyrings need to be measured is missing.

A new field in the IMA policy, namely, keyrings is added to
convey what keyrings need to be measured.

This patch updates the IMA function to retrieve keyrings from the policy.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h          |  6 ++--
 security/integrity/ima/ima_api.c      |  3 +-
 security/integrity/ima/ima_appraise.c |  2 +-
 security/integrity/ima/ima_policy.c   | 40 +++++++++++++++++++++++++--
 4 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 12e9ec6847b5..3539a159a7ac 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -240,8 +240,10 @@ void ima_measure_queued_keys(void);
 
 /* IMA policy related functions */
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr,
-		     struct ima_template_desc **template_desc);
+		     enum ima_hooks func, int mask,
+		     int flags, int *pcr,
+		     struct ima_template_desc **template_desc,
+		     char **keyrings);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flag(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index f614e22bf39f..f488d1cead79 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -175,6 +175,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *	subj,obj, and type: are LSM specific.
  *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
  *	| KEXEC_CMDLINE
+ *      | KEYRING_CHECK
  *	mask: contains the permission mask
  *	fsmagic: hex value
  *
@@ -190,7 +191,7 @@ int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 	flags &= ima_policy_flag;
 
 	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
-				template_desc);
+				template_desc, NULL);
 }
 
 /*
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 89b83194d1dc..5bed19be0f6a 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -54,7 +54,7 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 
 	security_task_getsecid(current, &secid);
 	return ima_match_policy(inode, current_cred(), secid, func, mask,
-				IMA_APPRAISE | IMA_HASH, NULL, NULL);
+				IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry,
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 0cc49f2d5233..b972a32ccb1b 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -31,6 +31,7 @@
 #define IMA_EUID	0x0080
 #define IMA_PCR		0x0100
 #define IMA_FSNAME	0x0200
+#define IMA_KEYRINGS	0x0400
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -76,6 +77,7 @@ struct ima_rule_entry {
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
+	char *keyrings; /* Keyrings to measure */
 	struct ima_template_desc *template;
 };
 
@@ -476,6 +478,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
  * @template_desc: the template that should be used for this rule
+ * @keyrings: keyrings for this rule, if specified
  *
  * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
  * conditions.
@@ -486,7 +489,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  */
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		     enum ima_hooks func, int mask, int flags, int *pcr,
-		     struct ima_template_desc **template_desc)
+		     struct ima_template_desc **template_desc,
+		     char **keyrings)
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
@@ -518,6 +522,9 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		if ((pcr) && (entry->flags & IMA_PCR))
 			*pcr = entry->pcr;
 
+		if ((keyrings) && (entry->flags & IMA_KEYRINGS))
+			*keyrings = entry->keyrings;
+
 		if (template_desc && entry->template)
 			*template_desc = entry->template;
 		else if (template_desc)
@@ -761,7 +768,7 @@ enum {
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_permit_directio,
-	Opt_pcr, Opt_template, Opt_err
+	Opt_pcr, Opt_template, Opt_keyrings, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -796,6 +803,7 @@ static const match_table_t policy_tokens = {
 	{Opt_permit_directio, "permit_directio"},
 	{Opt_pcr, "pcr=%s"},
 	{Opt_template, "template=%s"},
+	{Opt_keyrings, "keyrings=%s"},
 	{Opt_err, NULL}
 };
 
@@ -959,6 +967,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = POLICY_CHECK;
 			else if (strcmp(args[0].from, "KEXEC_CMDLINE") == 0)
 				entry->func = KEXEC_CMDLINE;
+			else if (strcmp(args[0].from, "KEYRING_CHECK") == 0)
+				entry->func = KEYRING_CHECK;
 			else
 				result = -EINVAL;
 			if (!result)
@@ -1011,6 +1021,23 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			result = 0;
 			entry->flags |= IMA_FSNAME;
 			break;
+		case Opt_keyrings:
+			ima_log_string(ab, "keyrings", args[0].from);
+
+			if ((entry->keyrings) ||
+			    (entry->action != MEASURE) ||
+			    (entry->func != KEYRING_CHECK)) {
+				result = -EINVAL;
+				break;
+			}
+			entry->keyrings = kstrdup(args[0].from, GFP_KERNEL);
+			if (!entry->keyrings) {
+				result = -ENOMEM;
+				break;
+			}
+			result = 0;
+			entry->flags |= IMA_KEYRINGS;
+			break;
 		case Opt_fsuuid:
 			ima_log_string(ab, "fsuuid", args[0].from);
 
@@ -1371,6 +1398,15 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
 
+	if (entry->flags & IMA_KEYRINGS) {
+		if (entry->keyrings != NULL)
+			snprintf(tbuf, sizeof(tbuf), "%s", entry->keyrings);
+		else
+			snprintf(tbuf, sizeof(tbuf), "%s", "All keyrings");
+		seq_printf(m, pt(Opt_keyrings), tbuf);
+		seq_puts(m, " ");
+	}
+
 	if (entry->flags & IMA_PCR) {
 		snprintf(tbuf, sizeof(tbuf), "%d", entry->pcr);
 		seq_printf(m, pt(Opt_pcr), tbuf);
-- 
2.17.1

