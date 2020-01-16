Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA8213D29B
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jan 2020 04:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgAPDPN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jan 2020 22:15:13 -0500
Received: from linux.microsoft.com ([13.77.154.182]:40020 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgAPDPM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jan 2020 22:15:12 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id C577320EB6F2;
        Wed, 15 Jan 2020 19:15:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C577320EB6F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1579144511;
        bh=51ZtaeTK0xdzML3ytYQategWAEvZogHwBZXh6YAH4qE=;
        h=From:To:Cc:Subject:Date:From;
        b=ihidpj779OugJ6Wfvc5HgzK4OihXNNL4PWL4Y3scEwGFgrfVT7dtQVgJLI2I+D2em
         TJkUaIQ3jTDjr84kgt7axq6ECQSQ/qPLj2ZkOJtCSkS5S1TsiSp0MCT8wVtH4ox9Zs
         9BGz7zX05QKI0BBkTex8Wp3o2dzQukr0LcHJRyJo=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com,
        arnd@arndb.de, linux-integrity@vger.kernel.org
Cc:     dhowells@redhat.com, sashal@kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH] IMA: pre-allocate keyrings string
Date:   Wed, 15 Jan 2020 19:15:08 -0800
Message-Id: <20200116031508.3481-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ima_match_keyring() is called while holding rcu read lock.
Since this function executes in atmomic context, it should
not call any function that can sleep (such as kstrdup()).

This patch pre-allocates a buffer to hold the keyrings
string read from the IMA policy and uses that to check
the given keyring in ima_match_keyring().

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Fixes: e9085e0ad38a ("IMA: Add support to limit measuring keys")
---
 security/integrity/ima/ima_policy.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 9963863d6c92..0bb4376ddba7 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -207,6 +207,7 @@ static LIST_HEAD(ima_default_rules);
 static LIST_HEAD(ima_policy_rules);
 static LIST_HEAD(ima_temp_rules);
 static struct list_head *ima_rules;
+static char *ima_keyrings;
 
 static int ima_policy __initdata;
 
@@ -369,7 +370,7 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 static bool ima_match_keyring(struct ima_rule_entry *rule,
 			      const char *keyring, const struct cred *cred)
 {
-	char *keyrings, *next_keyring, *keyrings_ptr;
+	char *next_keyring, *keyrings_ptr;
 	bool matched = false;
 
 	if ((rule->flags & IMA_UID) && !rule->uid_op(cred->uid, rule->uid))
@@ -381,15 +382,13 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
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
@@ -397,8 +396,6 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
 		}
 	}
 
-	kfree(keyrings);
-
 	return matched;
 }
 
@@ -1120,8 +1117,17 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				result = -EINVAL;
 				break;
 			}
+
+			ima_keyrings = kstrdup(args[0].from, GFP_KERNEL);
+			if (!ima_keyrings) {
+				result = -ENOMEM;
+				break;
+			}
+
 			entry->keyrings = kstrdup(args[0].from, GFP_KERNEL);
 			if (!entry->keyrings) {
+				kfree(ima_keyrings);
+				ima_keyrings = NULL;
 				result = -ENOMEM;
 				break;
 			}
-- 
2.17.1

