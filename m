Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1991A100EDF
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Nov 2019 23:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfKRWii (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 Nov 2019 17:38:38 -0500
Received: from linux.microsoft.com ([13.77.154.182]:50938 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfKRWiZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Nov 2019 17:38:25 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8CD9F20BBF29;
        Mon, 18 Nov 2019 14:38:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8CD9F20BBF29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574116704;
        bh=6fT84HQtmgssUIHiqprsdXnwaoFEPuDfnilSFBVgCag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bhxRpbubDoxZZNMwD/nPiDdS7Nq93sFgCWNTNFa6ggQycD9EDgzzueR/0godo8+1p
         U5PAOIlhW3+1ophunycD9SJXMDiloHw7Sn5u/V15bwQjM4WTdN1lSshnJEYrI01w4w
         r+eUVBw1jMsnpGMvYQlGnNBnDhV3q1Hs2MIQDecM=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH v8 5/5] IMA: Read keyrings= option from the IMA policy
Date:   Mon, 18 Nov 2019 14:38:18 -0800
Message-Id: <20191118223818.3353-6-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191118223818.3353-1-nramas@linux.microsoft.com>
References: <20191118223818.3353-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Read "keyrings=" option, if specified in the IMA policy, and store in
the list of IMA rules when the configured IMA policy is read.

This patch defines a new policy token enum namely Opt_keyrings
and an option flag IMA_KEYRINGS for reading "keyrings=" option
from the IMA policy.

Updated ima_parse_rule() to parse "keyrings=" option in the policy.
Updated ima_policy_show() to display "keyrings=" option.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: James Morris <jamorris@linux.microsoft.com>
---
 security/integrity/ima/ima_policy.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index d9400585fcda..78b25f083fe1 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -34,6 +34,7 @@
 #define IMA_EUID	0x0080
 #define IMA_PCR		0x0100
 #define IMA_FSNAME	0x0200
+#define IMA_KEYRINGS	0x0400
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -825,7 +826,8 @@ enum {
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_appraise_flag,
-	Opt_permit_directio, Opt_pcr, Opt_template, Opt_err
+	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
+	Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -861,6 +863,7 @@ static const match_table_t policy_tokens = {
 	{Opt_permit_directio, "permit_directio"},
 	{Opt_pcr, "pcr=%s"},
 	{Opt_template, "template=%s"},
+	{Opt_keyrings, "keyrings=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1110,6 +1113,23 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			result = 0;
 			entry->flags |= IMA_FSNAME;
 			break;
+		case Opt_keyrings:
+			ima_log_string(ab, "keyrings", args[0].from);
+
+			if ((entry->keyrings) ||
+			    (entry->action != MEASURE) ||
+			    (entry->func != KEY_CHECK)) {
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
 
@@ -1485,6 +1505,13 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
 
+	if (entry->flags & IMA_KEYRINGS) {
+		if (entry->keyrings != NULL)
+			snprintf(tbuf, sizeof(tbuf), "%s", entry->keyrings);
+		seq_printf(m, pt(Opt_keyrings), tbuf);
+		seq_puts(m, " ");
+	}
+
 	if (entry->flags & IMA_PCR) {
 		snprintf(tbuf, sizeof(tbuf), "%d", entry->pcr);
 		seq_printf(m, pt(Opt_pcr), tbuf);
-- 
2.17.1

