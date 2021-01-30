Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDFD309122
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Jan 2021 02:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbhA3A5j (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Jan 2021 19:57:39 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59522 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbhA3A4Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jan 2021 19:56:16 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 233C620B6C40;
        Fri, 29 Jan 2021 16:45:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 233C620B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1611967528;
        bh=Qsm5xaSqX4CxWPDSOE+2LngnqgNIktKRGDQRkYEnpr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODI6B0nKtYsFP1dkXOyNo9r+auY0UYa99sFNj+F4LCA1ImMY1u6W/QnFvC83nQH2L
         rMyZUdHxfjAIJpuGLZzXCY/XDYZokfCEqJbVTW1w2H1XbPiOMV0ATrrCGp86kutggT
         yFEzY8bDR59YM60i0bow4720oUw/mwMlm0Pal5UE=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 1/3] IMA: add policy condition to measure duplicate critical data
Date:   Fri, 29 Jan 2021 16:45:17 -0800
Message-Id: <20210130004519.25106-2-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210130004519.25106-1-tusharsu@linux.microsoft.com>
References: <20210130004519.25106-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA needs to support duplicate measurements of integrity
critical data to accurately determine the current state of that data
on the system.  Further, since measurement of duplicate data is not
required for all the use cases, it needs to be policy driven.

Define "allow_dup", a new IMA policy condition, for the IMA func
CRITICAL_DATA to allow duplicate buffer measurement of integrity
critical data.

Limit the ability to measure duplicate buffer data when action is
"measure" and func is CRITICAL_DATA.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy |  4 +++-
 security/integrity/ima/ima_policy.c  | 24 ++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index bc8e1cbe5e61..9598287e3bbf 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -27,7 +27,7 @@ Description:
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
 			option:	[[appraise_type=]] [template=] [permit_directio]
-				[appraise_flag=] [keyrings=]
+				[appraise_flag=] [keyrings=] [allow_dup]
 		  base:
 			func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK]MODULE_CHECK]
 			        [FIRMWARE_CHECK]
@@ -55,6 +55,8 @@ Description:
 			label:= [selinux]|[kernel_info]|[data_label]
 			data_label:= a unique string used for grouping and limiting critical data.
 			For example, "selinux" to measure critical data for SELinux.
+			allow_dup allows measurement of duplicate data.  Only valid
+			when action is "measure" and func is CRITICAL_DATA.
 
 		  default policy:
 			# PROC_SUPER_MAGIC
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 9b45d064a87d..b89eb768dd05 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -35,6 +35,7 @@
 #define IMA_FSNAME	0x0200
 #define IMA_KEYRINGS	0x0400
 #define IMA_LABEL	0x0800
+#define IMA_ALLOW_DUP	0x1000
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -87,6 +88,7 @@ struct ima_rule_entry {
 	char *fsname;
 	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
 	struct ima_rule_opt_list *label; /* Measure data grouped under this label */
+	bool allow_dup; /* Allow duplicate buffer entry measurement */
 	struct ima_template_desc *template;
 };
 
@@ -942,7 +944,7 @@ enum {
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_appraise_flag,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_label, Opt_err
+	Opt_label, Opt_allow_dup, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -980,6 +982,7 @@ static const match_table_t policy_tokens = {
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
 	{Opt_label, "label=%s"},
+	{Opt_allow_dup, "allow_dup"},
 	{Opt_err, NULL}
 };
 
@@ -1148,7 +1151,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 			return false;
 
 		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
-				     IMA_LABEL))
+				     IMA_LABEL | IMA_ALLOW_DUP))
 			return false;
 
 		if (ima_rule_contains_lsm_cond(entry))
@@ -1184,6 +1187,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	entry->uid_op = &uid_eq;
 	entry->fowner_op = &uid_eq;
 	entry->action = UNKNOWN;
+	entry->allow_dup = false;
 	while ((p = strsep(&rule, " \t")) != NULL) {
 		substring_t args[MAX_OPT_ARGS];
 		int token;
@@ -1375,6 +1379,19 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 
 			entry->flags |= IMA_LABEL;
 			break;
+		case Opt_allow_dup:
+			ima_log_string(ab, "allow_dup", NULL);
+
+			if ((entry->func != CRITICAL_DATA) ||
+			    (entry->action != MEASURE)) {
+				result = -EINVAL;
+				break;
+			}
+
+			entry->allow_dup = true;
+
+			entry->flags |= IMA_ALLOW_DUP;
+			break;
 		case Opt_fsuuid:
 			ima_log_string(ab, "fsuuid", args[0].from);
 
@@ -1761,6 +1778,9 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
 
+	if (entry->flags & IMA_ALLOW_DUP)
+		seq_puts(m, "allow_dup");
+
 	if (entry->flags & IMA_PCR) {
 		snprintf(tbuf, sizeof(tbuf), "%d", entry->pcr);
 		seq_printf(m, pt(Opt_pcr), tbuf);
-- 
2.17.1

