Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C97FFFBE2A
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2019 04:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfKNDMK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Nov 2019 22:12:10 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48482 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfKNDMK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Nov 2019 22:12:10 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.159.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id DBB9420B4907;
        Wed, 13 Nov 2019 19:12:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DBB9420B4907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573701129;
        bh=iOrOVwBuQdZlIC0TEFsCX95BqjX25mEotcAfj6F+LW4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ktkZWZPad5TpT7gqPfOeY2vxQ6RUlP1lfwzzIfP66mI7F6yVH7TDw2shlJBTrOc8c
         IHqvwwY58RBhwBZgnRlBPssT0wqOIxX5o1khNAoqKbVDihegS2ljnIyw8f4QKVfAVn
         mq45gkxYKOGdKnrFQKMZvUF1VBRZR2dbAuHNP5oY=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/5] IMA: Read keyrings= option from the IMA policy
Date:   Wed, 13 Nov 2019 19:12:02 -0800
Message-Id: <20191114031202.18012-6-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191114031202.18012-1-nramas@linux.microsoft.com>
References: <20191114031202.18012-1-nramas@linux.microsoft.com>
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
---
 security/integrity/ima/ima_policy.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 76da4f17bc79..577a51a548fb 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -34,6 +34,7 @@
 #define IMA_EUID	0x0080
 #define IMA_PCR		0x0100
 #define IMA_FSNAME	0x0200
+#define IMA_KEYRINGS	0x0400
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -795,7 +796,8 @@ enum {
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_appraise_flag,
-	Opt_permit_directio, Opt_pcr, Opt_template, Opt_err
+	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
+	Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -831,6 +833,7 @@ static const match_table_t policy_tokens = {
 	{Opt_permit_directio, "permit_directio"},
 	{Opt_pcr, "pcr=%s"},
 	{Opt_template, "template=%s"},
+	{Opt_keyrings, "keyrings=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1080,6 +1083,23 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
 
@@ -1455,6 +1475,13 @@ int ima_policy_show(struct seq_file *m, void *v)
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

