Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9C82EEC3F
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Jan 2021 05:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbhAHEIp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jan 2021 23:08:45 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59247 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbhAHEIp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jan 2021 23:08:45 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id F12E520B6C44;
        Thu,  7 Jan 2021 20:07:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F12E520B6C44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610078845;
        bh=oP4hs57Ovo2mWRRk2dcebbPVikngKbjBbImBel4Stjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G7HhFWE2Q+GhEzDKvm2pshLCUMA3I880DIfAERIKxtYBJsuvzcpDLQLpsaBFQRQg6
         GkaRh5fpPUYpnChAX7H5817+kvHf9ll9hWpS3gJ222wlzuPNtMcmWnMbWn4KPB8nWw
         aIIEl6iNb3K6YhU1Drv8gkA5U0tmBuWS0MsolHN4=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v10 5/8] IMA: limit critical data measurement based on a label
Date:   Thu,  7 Jan 2021 20:07:05 -0800
Message-Id: <20210108040708.8389-6-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
References: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Integrity critical data may belong to a single subsystem or it may
arise from cross subsystem interaction.  Currently there is no mechanism
to group or limit the data based on certain label.  Limiting and
grouping critical data based on a label would make it flexible and
configurable to measure.

Define "label:=", a new IMA policy condition, for the IMA func
CRITICAL_DATA to allow grouping and limiting measurement of integrity
critical data.

Limit the measurement to the labels that are specified in the IMA
policy - CRITICAL_DATA+"label:=".  If "label:=" is not provided with
the func CRITICAL_DATA, measure all the input integrity critical data.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy |  2 ++
 security/integrity/ima/ima_policy.c  | 37 +++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 6ec7daa87cba..54fe1c15ed50 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -52,6 +52,8 @@ Description:
 			template:= name of a defined IMA template type
 			(eg, ima-ng). Only valid when action is "measure".
 			pcr:= decimal value
+			label:= [data_label]
+			data_label:= a unique string used for grouping and limiting critical data.
 
 		  default policy:
 			# PROC_SUPER_MAGIC
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 96ba4273c4d0..2c9db2d0b434 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -34,6 +34,7 @@
 #define IMA_PCR		0x0100
 #define IMA_FSNAME	0x0200
 #define IMA_KEYRINGS	0x0400
+#define IMA_LABEL	0x0800
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -85,6 +86,7 @@ struct ima_rule_entry {
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
 	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
+	struct ima_rule_opt_list *label; /* Measure data grouped under this label */
 	struct ima_template_desc *template;
 };
 
@@ -479,7 +481,11 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
 		opt_list = rule->keyrings;
 		break;
 	case CRITICAL_DATA:
-		return true;
+		if (!rule->label)
+			return true;
+
+		opt_list = rule->label;
+		break;
 	default:
 		return false;
 	}
@@ -924,7 +930,7 @@ enum {
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_appraise_flag,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_err
+	Opt_label, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -961,6 +967,7 @@ static const match_table_t policy_tokens = {
 	{Opt_pcr, "pcr=%s"},
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
+	{Opt_label, "label=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1128,7 +1135,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (entry->action & ~(MEASURE | DONT_MEASURE))
 			return false;
 
-		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR))
+		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
+				     IMA_LABEL))
 			return false;
 
 		if (ima_rule_contains_lsm_cond(entry))
@@ -1338,6 +1346,23 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 
 			entry->flags |= IMA_KEYRINGS;
 			break;
+		case Opt_label:
+			ima_log_string(ab, "label", args[0].from);
+
+			if (entry->label) {
+				result = -EINVAL;
+				break;
+			}
+
+			entry->label = ima_alloc_rule_opt_list(args);
+			if (IS_ERR(entry->label)) {
+				result = PTR_ERR(entry->label);
+				entry->label = NULL;
+				break;
+			}
+
+			entry->flags |= IMA_LABEL;
+			break;
 		case Opt_fsuuid:
 			ima_log_string(ab, "fsuuid", args[0].from);
 
@@ -1718,6 +1743,12 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
 
+	if (entry->flags & IMA_LABEL) {
+		seq_puts(m, "label=");
+		ima_show_rule_opt_list(m, entry->label);
+		seq_puts(m, " ");
+	}
+
 	if (entry->flags & IMA_PCR) {
 		snprintf(tbuf, sizeof(tbuf), "%d", entry->pcr);
 		seq_printf(m, pt(Opt_pcr), tbuf);
-- 
2.17.1

