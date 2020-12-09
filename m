Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F7D2D4AC2
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Dec 2020 20:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbgLITnt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Dec 2020 14:43:49 -0500
Received: from linux.microsoft.com ([13.77.154.182]:47630 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbgLITnq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Dec 2020 14:43:46 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 63C8420B718A;
        Wed,  9 Dec 2020 11:42:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63C8420B718A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607542945;
        bh=bzuU81mo+/j5mNSRtkpRgP9nYoQTmrBcFrpkU3iE3ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pCjeKE1fNFwsNAHAmuZljsUTb383ZrRhoNT2NkT0DLtcfKkRLl/DmwpZWo9LvNPIS
         yXhMfNUvsjvhkquZbGZ4eZ05FX476WF4f4yVNY+GYbK5kFfuUtzAYYY0ALu5Ll5r4W
         TMEPWp4as7YNEEp0B2rXoAJ51EmwLmWFJ9yYRtjM=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v7 5/8] IMA: limit critical data measurement based on a label
Date:   Wed,  9 Dec 2020 11:42:09 -0800
Message-Id: <20201209194212.5131-6-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209194212.5131-1-tusharsu@linux.microsoft.com>
References: <20201209194212.5131-1-tusharsu@linux.microsoft.com>
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
 security/integrity/ima/ima_policy.c  | 26 +++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

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
index 9a8ee80a3128..7486d09a3f60 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -934,7 +934,7 @@ enum {
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_appraise_flag,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_err
+	Opt_data_source, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -971,6 +971,7 @@ static const match_table_t policy_tokens = {
 	{Opt_pcr, "pcr=%s"},
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
+	{Opt_data_source, "data_source=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1350,6 +1351,23 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 
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
 
@@ -1730,6 +1748,12 @@ int ima_policy_show(struct seq_file *m, void *v)
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

