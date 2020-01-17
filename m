Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9941401BE
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jan 2020 03:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbgAQCS0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jan 2020 21:18:26 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54188 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731794AbgAQCS0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jan 2020 21:18:26 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2B2B620B4798;
        Thu, 16 Jan 2020 18:18:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2B2B620B4798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1579227505;
        bh=3DPtxdzEuRBvzO+EeSGb0wH3lYD0uB0b2KEtfivyzHM=;
        h=From:To:Cc:Subject:Date:From;
        b=S27CgPjrSEEqIgHkbbHLBRnOjwZi0eK/hWi0J3rauKmjDqE0IIaMBThHyMWVye+DL
         0E6aWpJcRIrUZgKrwxl3TePi6oDFRZsSlg01FH7UN28Nr/94Nru0byFqDv0GWtsJul
         J2z7szb+pz0qE0MVqSmGGQvFlzKyB1myO10rwEVI=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] IMA: pre-allocate buffer to hold keyrings string
Date:   Thu, 16 Jan 2020 18:18:21 -0800
Message-Id: <20200117021821.2566-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ima_match_keyring() is called while holding rcu read lock. Since this
function executes in atomic context, it should not call any function
that can sleep (such as kstrdup()).

This patch pre-allocates a buffer to hold the keyrings string read from
the IMA policy and uses that to match the given keyring.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Fixes: e9085e0ad38a ("IMA: Add support to limit measuring keys")
---
 security/integrity/ima/ima_policy.c | 38 +++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 9963863d6c92..3e296051feea 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -208,6 +208,10 @@ static LIST_HEAD(ima_policy_rules);
 static LIST_HEAD(ima_temp_rules);
 static struct list_head *ima_rules;
 
+/* Pre-allocated buffer used for matching keyrings. */
+static char *ima_keyrings;
+static size_t ima_keyrings_len;
+
 static int ima_policy __initdata;
 
 static int __init default_measure_policy_setup(char *str)
@@ -369,7 +373,7 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 static bool ima_match_keyring(struct ima_rule_entry *rule,
 			      const char *keyring, const struct cred *cred)
 {
-	char *keyrings, *next_keyring, *keyrings_ptr;
+	char *next_keyring, *keyrings_ptr;
 	bool matched = false;
 
 	if ((rule->flags & IMA_UID) && !rule->uid_op(cred->uid, rule->uid))
@@ -381,15 +385,13 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
 	if (!keyring)
 		return false;
 
-	keyrings = kstrdup(rule->keyrings, GFP_KERNEL);
-	if (!keyrings)
-		return false;
+	strcpy(ima_keyrings, rule->keyrings);
 
 	/*
 	 * "keyrings=" is specified in the policy in the format below:
 	 * keyrings=.builtin_trusted_keys|.ima|.evm
 	 */
-	keyrings_ptr = keyrings;
+	keyrings_ptr = ima_keyrings;
 	while ((next_keyring = strsep(&keyrings_ptr, "|")) != NULL) {
 		if (!strcmp(next_keyring, keyring)) {
 			matched = true;
@@ -397,8 +399,6 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
 		}
 	}
 
-	kfree(keyrings);
-
 	return matched;
 }
 
@@ -949,6 +949,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	bool uid_token;
 	struct ima_template_desc *template_desc;
 	int result = 0;
+	size_t keyrings_len;
 
 	ab = integrity_audit_log_start(audit_context(), GFP_KERNEL,
 				       AUDIT_INTEGRITY_POLICY_RULE);
@@ -1114,14 +1115,35 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 		case Opt_keyrings:
 			ima_log_string(ab, "keyrings", args[0].from);
 
+			keyrings_len = strlen(args[0].from) + 1;
+
 			if ((entry->keyrings) ||
 			    (entry->action != MEASURE) ||
-			    (entry->func != KEY_CHECK)) {
+			    (entry->func != KEY_CHECK) ||
+			    (keyrings_len < 2)) {
 				result = -EINVAL;
 				break;
 			}
+
+			if (keyrings_len > ima_keyrings_len) {
+				char *tmpbuf;
+
+				tmpbuf = krealloc(ima_keyrings, keyrings_len,
+						  GFP_KERNEL);
+				if (!tmpbuf) {
+					result = -ENOMEM;
+					break;
+				}
+
+				ima_keyrings = tmpbuf;
+				ima_keyrings_len = keyrings_len;
+			}
+
 			entry->keyrings = kstrdup(args[0].from, GFP_KERNEL);
 			if (!entry->keyrings) {
+				kfree(ima_keyrings);
+				ima_keyrings = NULL;
+				ima_keyrings_len = 0;
 				result = -ENOMEM;
 				break;
 			}
-- 
2.17.1

