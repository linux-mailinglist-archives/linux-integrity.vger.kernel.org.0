Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C62242F56
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Aug 2020 21:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgHLTb1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Aug 2020 15:31:27 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51170 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgHLTbO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Aug 2020 15:31:14 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3C4B120B490D;
        Wed, 12 Aug 2020 12:31:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3C4B120B490D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597260672;
        bh=1JH4jChNS0fa5DFFMyXyCP3gvcSLfR3XN5s6YUWp8Eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MIxMEJeISvTQ7NN5IisP4jWYFX4zFj3WHpvnd+9p1LDZgpMXGC+bckHZqRClUr+Nc
         PkHUFZMNpr92w7Aw0Xl258nJ9C9Be+thQmt+eyIUo9K5LrICU+WDKg59D7I6nKZvdI
         vY8c9rsHafodvjTnRv3J4EINhRMUu2+9wRaRHmpY=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        nramas@linux.microsoft.com
Subject: [PATCH 2/3] IMA: add policy to support measuring critical data from kernel components
Date:   Wed, 12 Aug 2020 12:31:01 -0700
Message-Id: <20200812193102.18636-3-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812193102.18636-1-tusharsu@linux.microsoft.com>
References: <20200812193102.18636-1-tusharsu@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There would be several candidate kernel components suitable for IMA
measurement. Not all of them would be enlightened for IMA measurement.
Also, system administrators may not want to measure data for all of
them, even when they are enlightened for IMA measurements. An IMA policy
specific to various kernel components is needed to measure their
respective critical data.

Add a new IMA policy CRITICAL_DATA+data_sources to support measuring
various critical kernel components. This policy would enable the
system administrators to limit the measurement to the components,
if the components are enlightened for IMA measurement.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy |  6 +-
 security/integrity/ima/ima.h         |  1 +
 security/integrity/ima/ima_api.c     |  2 +-
 security/integrity/ima/ima_policy.c  | 84 ++++++++++++++++++++++------
 4 files changed, 74 insertions(+), 19 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index cd572912c593..a0dd0f108555 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -29,7 +29,7 @@ Description:
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
-				[KEXEC_CMDLINE] [KEY_CHECK]
+				[KEXEC_CMDLINE] [KEY_CHECK] [CRITICAL_DATA]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
@@ -125,3 +125,7 @@ Description:
 		keys added to .builtin_trusted_keys or .ima keyring:
 
 			measure func=KEY_CHECK keyrings=.builtin_trusted_keys|.ima
+
+		Example of measure rule using CRITICAL_DATA to measure critical data
+
+			measure func=CRITICAL_DATA data_sources=selinux|apparmor|dm-crypt
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e2a151d6653d..99773dfa2541 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -200,6 +200,7 @@ static inline unsigned int ima_hash_key(u8 *digest)
 	hook(POLICY_CHECK, policy)			\
 	hook(KEXEC_CMDLINE, kexec_cmdline)		\
 	hook(KEY_CHECK, key)				\
+	hook(CRITICAL_DATA, critical_data)		\
 	hook(MAX_CHECK, none)
 
 #define __ima_hook_enumify(ENUM, str)	ENUM,
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index af218babd198..9917e1730cb6 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -176,7 +176,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *		subj=, obj=, type=, func=, mask=, fsmagic=
  *	subj,obj, and type: are LSM specific.
  *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
- *	| KEXEC_CMDLINE | KEY_CHECK
+ *	| KEXEC_CMDLINE | KEY_CHECK | CRITICAL_DATA
  *	mask: contains the permission mask
  *	fsmagic: hex value
  *
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 4efaf8956eb8..8451ccb2a775 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -22,17 +22,18 @@
 #include "ima.h"
 
 /* flags definitions */
-#define IMA_FUNC	0x0001
-#define IMA_MASK	0x0002
-#define IMA_FSMAGIC	0x0004
-#define IMA_UID		0x0008
-#define IMA_FOWNER	0x0010
-#define IMA_FSUUID	0x0020
-#define IMA_INMASK	0x0040
-#define IMA_EUID	0x0080
-#define IMA_PCR		0x0100
-#define IMA_FSNAME	0x0200
-#define IMA_KEYRINGS	0x0400
+#define IMA_FUNC		0x0001
+#define IMA_MASK		0x0002
+#define IMA_FSMAGIC		0x0004
+#define IMA_UID			0x0008
+#define IMA_FOWNER		0x0010
+#define IMA_FSUUID		0x0020
+#define IMA_INMASK		0x0040
+#define IMA_EUID		0x0080
+#define IMA_PCR			0x0100
+#define IMA_FSNAME		0x0200
+#define IMA_KEYRINGS		0x0400
+#define IMA_DATA_SOURCES	0x0800
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -84,6 +85,7 @@ struct ima_rule_entry {
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
 	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
+	struct ima_rule_opt_list *data_sources; /* Measure data from these sources */
 	struct ima_template_desc *template;
 };
 
@@ -508,14 +510,23 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 {
 	int i;
 
-	if (func == KEY_CHECK) {
-		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
-		       ima_match_rule_data(rule, rule->keyrings, func_data,
-					   true, cred);
-	}
 	if ((rule->flags & IMA_FUNC) &&
 	    (rule->func != func && func != POST_SETATTR))
 		return false;
+
+	switch (func) {
+	case KEY_CHECK:
+		return ((rule->func == func) &&
+			ima_match_rule_data(rule, rule->keyrings,
+					    func_data, true, cred));
+	case CRITICAL_DATA:
+		return ((rule->func == func) &&
+			ima_match_rule_data(rule, rule->data_sources,
+					    func_data, false, cred));
+	default:
+		break;
+	}
+
 	if ((rule->flags & IMA_MASK) &&
 	    (rule->mask != mask && func != POST_SETATTR))
 		return false;
@@ -911,7 +922,7 @@ enum {
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_appraise_flag,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_err
+	Opt_data_sources, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -948,6 +959,7 @@ static const match_table_t policy_tokens = {
 	{Opt_pcr, "pcr=%s"},
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
+	{Opt_data_sources, "data_sources=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1110,6 +1122,19 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (ima_rule_contains_lsm_cond(entry))
 			return false;
 
+		break;
+	case CRITICAL_DATA:
+		if (entry->action & ~(MEASURE | DONT_MEASURE))
+			return false;
+
+		if (!(entry->flags & IMA_DATA_SOURCES) ||
+		    (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
+		    IMA_DATA_SOURCES)))
+			return false;
+
+		if (ima_rule_contains_lsm_cond(entry))
+			return false;
+
 		break;
 	default:
 		return false;
@@ -1242,6 +1267,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			else if (IS_ENABLED(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) &&
 				 strcmp(args[0].from, "KEY_CHECK") == 0)
 				entry->func = KEY_CHECK;
+			else if (strcmp(args[0].from, "CRITICAL_DATA") == 0)
+				entry->func = CRITICAL_DATA;
 			else
 				result = -EINVAL;
 			if (!result)
@@ -1312,6 +1339,23 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 
 			entry->flags |= IMA_KEYRINGS;
 			break;
+		case Opt_data_sources:
+			ima_log_string(ab, "data_sources", args[0].from);
+
+			if (entry->data_sources) {
+				result = -EINVAL;
+				break;
+			}
+
+			entry->data_sources = ima_alloc_rule_opt_list(args);
+			if (IS_ERR(entry->data_sources)) {
+				result = PTR_ERR(entry->data_sources);
+				entry->data_sources = NULL;
+				break;
+			}
+
+			entry->flags |= IMA_DATA_SOURCES;
+			break;
 		case Opt_fsuuid:
 			ima_log_string(ab, "fsuuid", args[0].from);
 
@@ -1692,6 +1736,12 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
 
+	if (entry->flags & IMA_DATA_SOURCES) {
+		seq_puts(m, "data_sources=");
+		ima_show_rule_opt_list(m, entry->data_sources);
+		seq_puts(m, " ");
+	}
+
 	if (entry->flags & IMA_PCR) {
 		snprintf(tbuf, sizeof(tbuf), "%d", entry->pcr);
 		seq_printf(m, pt(Opt_pcr), tbuf);
-- 
2.17.1

