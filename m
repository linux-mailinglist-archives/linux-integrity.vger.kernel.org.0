Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3882D831E
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Dec 2020 01:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437555AbgLKX7z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 18:59:55 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54884 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437541AbgLKX7m (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 18:59:42 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id E111820B718A;
        Fri, 11 Dec 2020 15:58:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E111820B718A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607731102;
        bh=b/dW00r01ZpsVJiBaCQgT3WIzsGSZSZkBDeK7+9jjQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HFSOA7/g+5gCv/83iJ8oX5HZB1QfENbskxk4cySL68rSziR9zZO8Riv6d9RKvVI9t
         +KOQzahiHErtmfJj+DIAi5DFUjapRg27Guw/svWzrxAp1/uQQva2tJrgGAb3G5WCd3
         9aNc2SfoXD77ig5vYh11xugCCxcYdc+8TCrESkqs=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v8 5/8] IMA: limit critical data measurement based on a label
Date:   Fri, 11 Dec 2020 15:58:04 -0800
Message-Id: <20201211235807.30815-6-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201211235807.30815-1-tusharsu@linux.microsoft.com>
References: <20201211235807.30815-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

System administrators should be able to limit which kernel subsystems
they want to measure the critical data for. To enable that, an IMA policy
condition to choose specific kernel subsystems is needed. This policy
condition would constrain the measurement of the critical data based on
a label for the given subsystems.

Add a new IMA policy condition - "data_source:=" to the IMA func
CRITICAL_DATA to allow measurement of various kernel subsystems. This
policy condition would enable the system administrators to restrict the
measurement to the labels listed in "data_source:=".

Limit the measurement to the labels that are specified in the IMA
policy - CRITICAL_DATA+"data_source:=". If "data_sources:=" is not
provided with the func CRITICAL_DATA, the data from all the
supported kernel subsystems is measured.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy |  2 ++
 security/integrity/ima/ima_policy.c  | 30 ++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 6ec7daa87cba..0f4ee9e0a455 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -52,6 +52,8 @@ Description:
 			template:= name of a defined IMA template type
 			(eg, ima-ng). Only valid when action is "measure".
 			pcr:= decimal value
+			data_source:= [label]
+			label:= a unique string used for grouping and limiting critical data.
 
 		  default policy:
 			# PROC_SUPER_MAGIC
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 07116ff35c25..fea996a9e26c 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -34,6 +34,7 @@
 #define IMA_PCR		0x0100
 #define IMA_FSNAME	0x0200
 #define IMA_KEYRINGS	0x0400
+#define IMA_DATA_SOURCE	0x0800
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -930,7 +931,7 @@ enum {
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_appraise_flag,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_err
+	Opt_data_source, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -967,6 +968,7 @@ static const match_table_t policy_tokens = {
 	{Opt_pcr, "pcr=%s"},
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
+	{Opt_data_source, "data_source=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1134,7 +1136,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (entry->action & ~(MEASURE | DONT_MEASURE))
 			return false;
 
-		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR))
+		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
+				     IMA_DATA_SOURCE))
 			return false;
 
 		if (ima_rule_contains_lsm_cond(entry))
@@ -1344,6 +1347,23 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 
 			entry->flags |= IMA_KEYRINGS;
 			break;
+		case Opt_data_source:
+			ima_log_string(ab, "data_source", args[0].from);
+
+			if (entry->data_source) {
+				result = -EINVAL;
+				break;
+			}
+
+			entry->data_source = ima_alloc_rule_opt_list(args);
+			if (IS_ERR(entry->data_source)) {
+				result = PTR_ERR(entry->data_source);
+				entry->data_source = NULL;
+				break;
+			}
+
+			entry->flags |= IMA_DATA_SOURCE;
+			break;
 		case Opt_fsuuid:
 			ima_log_string(ab, "fsuuid", args[0].from);
 
@@ -1724,6 +1744,12 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
 
+	if (entry->flags & IMA_DATA_SOURCE) {
+		seq_puts(m, "data_source=");
+		ima_show_rule_opt_list(m, entry->data_source);
+		seq_puts(m, " ");
+	}
+
 	if (entry->flags & IMA_PCR) {
 		snprintf(tbuf, sizeof(tbuf), "%d", entry->pcr);
 		seq_printf(m, pt(Opt_pcr), tbuf);
-- 
2.17.1

