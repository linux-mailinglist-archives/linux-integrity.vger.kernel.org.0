Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39682552C1
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 03:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgH1B5X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Aug 2020 21:57:23 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38468 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbgH1B5U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Aug 2020 21:57:20 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 39B5820553ED;
        Thu, 27 Aug 2020 18:57:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 39B5820553ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598579839;
        bh=kFumSg9D6IWrKowDRCuR6JaYkRpAKGrG3kd2UMi5yG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jIwOfUjvQXDXIMbP0VzJC16ORhjF/LMllEOYLfOMSnZnqc6XGKsLEaw8udDpMU8dN
         Pza7ffFGu1KYIZvITQ4jggbSl9W/OsUTNFMOrjlofkqOXk3o96hovIq4uFI4cfZHk+
         CD61VH/PhTFB7JNgZAjeC5JE+HqVFpu978bUOJQA=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v3 4/6] IMA: add policy to measure critical data from kernel components
Date:   Thu, 27 Aug 2020 18:57:02 -0700
Message-Id: <20200828015704.6629-5-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828015704.6629-1-tusharsu@linux.microsoft.com>
References: <20200828015704.6629-1-tusharsu@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There would be several candidate kernel components suitable for IMA
measurement. Not all of them would have support for IMA measurement.
Also, system administrators may not want to measure data for all of
them, even when they support IMA measurement. An IMA policy specific
to various kernel components is needed to measure their respective
critical data.

Add a new IMA policy "critical_kernel_data_sources" to support measuring
various critical kernel components. This policy would enable the
system administrators to limit the measurement to the components,
if the components support IMA measurement.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy |  3 +++
 security/integrity/ima/ima_policy.c  | 29 +++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index cd572912c593..7ccdc1964e29 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -48,6 +48,9 @@ Description:
 			template:= name of a defined IMA template type
 			(eg, ima-ng). Only valid when action is "measure".
 			pcr:= decimal value
+			critical_kernel_data_sources:= list of kernel
+			components (eg, selinux|apparmor|dm-crypt) that
+			contain data critical to the security of the kernel.
 
 		default policy:
 			# PROC_SUPER_MAGIC
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8866e84d0062..c8a044705347 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -33,6 +33,7 @@
 #define IMA_PCR		0x0100
 #define IMA_FSNAME	0x0200
 #define IMA_KEYRINGS	0x0400
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
 
@@ -911,7 +913,7 @@ enum {
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_appraise_flag,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_err
+	Opt_data_sources, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -948,6 +950,7 @@ static const match_table_t policy_tokens = {
 	{Opt_pcr, "pcr=%s"},
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
+	{Opt_data_sources, "critical_kernel_data_sources=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1312,6 +1315,24 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 
 			entry->flags |= IMA_KEYRINGS;
 			break;
+		case Opt_data_sources:
+			ima_log_string(ab, "critical_kernel_data_sources",
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
 
@@ -1692,6 +1713,12 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
 
+	if (entry->flags & IMA_DATA_SOURCES) {
+		seq_puts(m, "critical_kernel_data_sources=");
+		ima_show_rule_opt_list(m, entry->data_sources);
+		seq_puts(m, " ");
+	}
+
 	if (entry->flags & IMA_PCR) {
 		snprintf(tbuf, sizeof(tbuf), "%d", entry->pcr);
 		seq_printf(m, pt(Opt_pcr), tbuf);
-- 
2.17.1

