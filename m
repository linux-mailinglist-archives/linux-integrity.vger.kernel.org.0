Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2F02760F2
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Sep 2020 21:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgIWTU3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Sep 2020 15:20:29 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47400 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgIWTUW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Sep 2020 15:20:22 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id C73252089E58;
        Wed, 23 Sep 2020 12:20:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C73252089E58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600888821;
        bh=2FNwvx49AfXNiGqLOUX6pzzqyCNzi5u8FEaXRE5OT/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nftv16elAWhpMY6rI6VQCO/6/lsNQgClY9rx60Pn7tpmtcxVxngLn6Yws1M9ZxScT
         dGuqErmY5EZ07/+iIBLfA5tvb6d/mC1wDB4pUEavUzWQYg5fNFx/qGZSKltG8JNLkC
         qX6hHKKDXeyO6dhNWrR26dFzMJsq28P0EsQZhvCA=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v4 4/6] IMA: add policy to measure critical data from kernel components
Date:   Wed, 23 Sep 2020 12:20:09 -0700
Message-Id: <20200923192011.5293-5-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923192011.5293-1-tusharsu@linux.microsoft.com>
References: <20200923192011.5293-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There would be several candidate kernel components suitable for IMA
measurement. Not all of them would have support for IMA measurement.
Also, system administrators may not want to measure data for all of
them, even when they support IMA measurement. An IMA policy option 
specific to various kernel components is needed to measure their
respective critical data.

This policy option needs to be constrained to measure data for
specific kernel components that are specified as input values to the
policy option.

Add a new IMA policy option - "data_sources:=" to allow measuring
various critical kernel components. This policy option would enable the
system administrators to limit the measurement to the components
listed in "data_sources:=", if the components support IMA measurement.

The new policy option "data_sources:=" is different from the existing
policy option "keyrings:=". 

In case of "keyrings:=", a policy may measure all keyrings (when
"keyrings:=" option is not provided for func KEY_CHECK), or may
constrain which keyrings need to be measured (when "keyrings:=" option
is provided for func KEY_CHECK).

But unlike "keyrings:=", the entries in "data_sources:=" would have
different data format. Further, the components listed in
"data_sources:=" need to be modified to call IMA to measure their
data. Therefore, unlike "keyrings:=", IMA shouldn't measure all of the
components by default, when "data_sources:=" is not specified. Because
measuring non-vetted components just by specifying them as a policy
option value may impact the overall reliability of the system.

To address this, "data_sources:=" should be a mandatory policy option
for func=CRITICAL_DATA. This func is introduced in the 5th patch in this
series). And the compile-time vetting functionality described above is
introduced in the 6th patch in this series.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy |  3 +++
 security/integrity/ima/ima_policy.c  | 29 +++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index cd572912c593..a81cf79fb255 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -48,6 +48,9 @@ Description:
 			template:= name of a defined IMA template type
 			(eg, ima-ng). Only valid when action is "measure".
 			pcr:= decimal value
+			data_sources:= list of kernel components
+			(eg, selinux|apparmor|dm-crypt) that contain data critical
+			to the security of the kernel.
 
 		default policy:
 			# PROC_SUPER_MAGIC
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8866e84d0062..89452245f54a 100644
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
+	{Opt_data_sources, "data_sources=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1312,6 +1315,24 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 
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
 
@@ -1692,6 +1713,12 @@ int ima_policy_show(struct seq_file *m, void *v)
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

