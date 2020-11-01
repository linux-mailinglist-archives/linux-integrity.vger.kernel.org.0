Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B222A222A
	for <lists+linux-integrity@lfdr.de>; Sun,  1 Nov 2020 23:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgKAW1D (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 1 Nov 2020 17:27:03 -0500
Received: from linux.microsoft.com ([13.77.154.182]:42026 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgKAW0j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 1 Nov 2020 17:26:39 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 743722089EFD;
        Sun,  1 Nov 2020 14:26:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 743722089EFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604269597;
        bh=v5Ge/oPZlFxr7KJLQjdzrNdBGjbmlZ14Yd+wQvIi3QU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rFc5WJ0zMdsMRSh6vZoqCTqk/YOtAJrjSRzCPDgBIlgrqL25aagJVbYUdhOLPbUOO
         AFzBuMkTG4YF0bIPFgIYiX0z5KM/OpAMVFfGcwqlTvjm+aOUaGQDj3HEHg5cjIko3/
         i6ZAzUIIDphWld20/2VCms++/EKEt6Nl75Xnj8Tk=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v5 4/7] IMA: add policy to measure critical data
Date:   Sun,  1 Nov 2020 14:26:23 -0800
Message-Id: <20201101222626.6111-5-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

System administrators should be able to choose which kernel subsystems
they want to measure the critical data for. To enable that, an IMA policy
option to choose specific kernel subsystems is needed. This policy option
would constrain the measurement of the critical data to the given kernel
subsystems.

Add a new IMA policy option - "data_sources:=" to the IMA func 
CRITICAL_DATA to allow measurement of various kernel subsystems. This
policy option would enable the system administrators to limit the
measurement to the subsystems listed in "data_sources:=", if the 
subsystem measures its data by calling ima_measure_critical_data().

Limit the measurement to the subsystems that are specified in the IMA
policy - CRITICAL_DATA+"data_sources:=". If "data_sources:=" is not
provided with the func CRITICAL_DATA, measure the data from all the
supported kernel subsystems.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy |  4 ++
 security/integrity/ima/ima_policy.c  | 62 +++++++++++++++++++++++++---
 2 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 3de6c774c37e..15be8b16f6f3 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -48,6 +48,10 @@ Description:
 			template:= name of a defined IMA template type
 			(eg, ima-ng). Only valid when action is "measure".
 			pcr:= decimal value
+			data_sources:= list of kernel subsystems that contain
+			kernel in-memory data critical to the integrity of the kernel.
+			Only valid when action is "measure" and func is
+			CRITICAL_DATA.
 
 		default policy:
 			# PROC_SUPER_MAGIC
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index f48e82450fe1..ec99e0bb6c6f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -34,6 +34,7 @@
 #define IMA_PCR		0x0100
 #define IMA_FSNAME	0x0200
 #define IMA_KEYRINGS	0x0400
+#define IMA_DATA_SOURCES	0x0800
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -85,6 +86,7 @@ struct ima_rule_entry {
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
 	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
+	struct ima_rule_opt_list *data_sources; /* Measure data from these sources */
 	struct ima_template_desc *template;
 };
 
@@ -479,6 +481,12 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
 		else
 			opt_list = rule->keyrings;
 		break;
+	case CRITICAL_DATA:
+		if (!rule->data_sources)
+			return true;
+		else
+			opt_list = rule->data_sources;
+		break;
 	default:
 		break;
 	}
@@ -518,13 +526,19 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 {
 	int i;
 
-	if (func == KEY_CHECK) {
-		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
-			ima_match_rule_data(rule, func_data, cred);
-	}
 	if ((rule->flags & IMA_FUNC) &&
 	    (rule->func != func && func != POST_SETATTR))
 		return false;
+
+	switch (func) {
+	case KEY_CHECK:
+	case CRITICAL_DATA:
+		return ((rule->func == func) &&
+			ima_match_rule_data(rule, func_data, cred));
+	default:
+		break;
+	}
+
 	if ((rule->flags & IMA_MASK) &&
 	    (rule->mask != mask && func != POST_SETATTR))
 		return false;
@@ -920,7 +934,7 @@ enum {
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_appraise_flag,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_err
+	Opt_data_sources, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -957,6 +971,7 @@ static const match_table_t policy_tokens = {
 	{Opt_pcr, "pcr=%s"},
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
+	{Opt_data_sources, "data_sources=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1119,6 +1134,19 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
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
@@ -1323,6 +1351,24 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 
 			entry->flags |= IMA_KEYRINGS;
 			break;
+		case Opt_data_sources:
+			ima_log_string(ab, "data_sources",
+				       args[0].from);
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
 
@@ -1703,6 +1749,12 @@ int ima_policy_show(struct seq_file *m, void *v)
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

