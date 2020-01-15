Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E8413C83A
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2020 16:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAOPna (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jan 2020 10:43:30 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41267 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgAOPn3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jan 2020 10:43:29 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so19070208ljc.8;
        Wed, 15 Jan 2020 07:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DpZXkxiLAGNsYRkSxKJ75JmpalW8URD38e3nWz/COXw=;
        b=fZQrAJ/ODRQHoTBaQ13Aq9AiWSWSFS2Tzs9VZZKN2ih+1hFsmtZ6w486r4pl+UI1rD
         IPwyGzXq18pXPI9ZBRuUeYXq/G+DsTsfKGy9hKWV9IzmRCirez6rtrG13yWkRk0XQS54
         hJpTX5vPNftxnKht0s3j2Z8Jgwu6cec2UR1+katu32qUwd9f4uRzqiusd7IwJfukh0B8
         0Q13v6MutmNkj170UDIODLUA3tH4MebZ1SMDArCNhB0l5RJBiUsSx4cY59TkjRf51+WO
         p3kDfaMiI2G085hmBICF+zXXA/ITGCQIVyXYMrOQb7B8UPMfzGVetiEecKoSF4vQz6Tq
         Tv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DpZXkxiLAGNsYRkSxKJ75JmpalW8URD38e3nWz/COXw=;
        b=rYKfHYEKTh4/kuLXoOY4tSAqUTwp6Y/ngP/ZOXKyG/CWyoz9zR8pbW8MlR5eINEdW+
         LZ33Z4UYDbfQd5nF9+7e++vz/trxJGyv0oEvTa8efooUeQKYKfpO+u6DCNqZvyhagrwd
         O7fIQuGjLvKLZ4M7xTZI11Kpcr7OZixmYXj+Eidgbsabk2H6KqVhrFgXh9ajEcCp38h+
         Qz5F8NfWQ8FkB+GUPUe7fJsR5e26uZ8Ec150LbwJKGdCOizUxKaUK+0DoIM1xp5VUiO4
         8hW0+ozIzK+V6OR5vcqhX8G0gV0t3tss2TLbIk5iL8pP+/rcE0ilqojsV/TqXnaJD64t
         GaoA==
X-Gm-Message-State: APjAAAWHf3lLw2GdHcAUXHEfbRP74nPSFK4jz4n5u4FBllzwuDpCkCO8
        rk1CU3T7Kdh5yq09xm/U2DPIY6Sa
X-Google-Smtp-Source: APXvYqxzllRnG95sS2iIIRvNsDX1mQRaj3Ewhkdm6y1Qnk9Z5hoz8+2a5FcNRlci5QsgWFcViKsDEQ==
X-Received: by 2002:a2e:3609:: with SMTP id d9mr2049051lja.188.1579103006708;
        Wed, 15 Jan 2020 07:43:26 -0800 (PST)
Received: from localhost.localdomain (mobile-user-c1d2e4-97.dhcp.inet.fi. [193.210.228.97])
        by smtp.gmail.com with ESMTPSA id p136sm9221240lfa.8.2020.01.15.07.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:43:26 -0800 (PST)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com
Cc:     Janne Karhunen <janne.karhunen@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Konsta Karsisto <konsta.karsisto@gmail.com>
Subject: [PATCH v4] ima: ima/lsm policy rule loading logic bug fixes
Date:   Wed, 15 Jan 2020 17:42:30 +0200
Message-Id: <20200115154230.2048-1-janne.karhunen@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Keep the ima policy rules around from the beginning even if they appear
invalid at the time of loading, as they may become active after an lsm
policy load. However, loading a custom IMA policy with unknown LSM
labels is only safe after we have transitioned from the "built-in"
policy rules to a custom IMA policy.

Patch also fixes the rule re-use during the lsm policy reload and makes
some prints a bit more human readable.

Changelog:
v4:
- Do not allow the initial policy load refer to non-existing lsm rules.
v3:
- Fix too wide policy rule matching for non-initialized LSMs
v2:
- Fix log prints

Fixes: b16942455193 ("ima: use the lsm policy update notifier")
Cc: Casey Schaufler <casey@schaufler-ca.com>
Reported-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
Signed-off-by: Konsta Karsisto <konsta.karsisto@gmail.com>
---
 security/integrity/ima/ima_policy.c | 44 +++++++++++++++++------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index a4dde9d575b2..76dc9b3dd0fc 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -265,7 +265,7 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
 static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 {
 	struct ima_rule_entry *nentry;
-	int i, result;
+	int i;
 
 	nentry = kmalloc(sizeof(*nentry), GFP_KERNEL);
 	if (!nentry)
@@ -279,7 +279,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 	memset(nentry->lsm, 0, FIELD_SIZEOF(struct ima_rule_entry, lsm));
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		if (!entry->lsm[i].rule)
+		if (!entry->lsm[i].args_p)
 			continue;
 
 		nentry->lsm[i].type = entry->lsm[i].type;
@@ -288,13 +288,13 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 		if (!nentry->lsm[i].args_p)
 			goto out_err;
 
-		result = security_filter_rule_init(nentry->lsm[i].type,
-						   Audit_equal,
-						   nentry->lsm[i].args_p,
-						   &nentry->lsm[i].rule);
-		if (result == -EINVAL)
-			pr_warn("ima: rule for LSM \'%d\' is undefined\n",
-				entry->lsm[i].type);
+		security_filter_rule_init(nentry->lsm[i].type,
+					  Audit_equal,
+					  nentry->lsm[i].args_p,
+					  &nentry->lsm[i].rule);
+		if (!nentry->lsm[i].rule)
+			pr_warn("rule for LSM \'%s\' is undefined\n",
+				(char *)entry->lsm[i].args_p);
 	}
 	return nentry;
 
@@ -331,7 +331,7 @@ static void ima_lsm_update_rules(void)
 	list_for_each_entry_safe(entry, e, &ima_policy_rules, list) {
 		needs_update = 0;
 		for (i = 0; i < MAX_LSM_RULES; i++) {
-			if (entry->lsm[i].rule) {
+			if (entry->lsm[i].args_p) {
 				needs_update = 1;
 				break;
 			}
@@ -341,8 +341,7 @@ static void ima_lsm_update_rules(void)
 
 		result = ima_lsm_update_rule(entry);
 		if (result) {
-			pr_err("ima: lsm rule update error %d\n",
-				result);
+			pr_err("lsm rule update error %d\n", result);
 			return;
 		}
 	}
@@ -403,7 +402,7 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
 }
 
 /**
- * ima_match_rules - determine whether an inode matches the measure rule.
+ * ima_match_rules - determine whether an inode matches the policy rule.
  * @rule: a pointer to a rule
  * @inode: a pointer to an inode
  * @cred: a pointer to a credentials structure for user validation
@@ -466,9 +465,12 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		int rc = 0;
 		u32 osid;
 
-		if (!rule->lsm[i].rule)
-			continue;
-
+		if (!rule->lsm[i].rule) {
+			if (!rule->lsm[i].args_p)
+				continue;
+			else
+				return false;
+		}
 		switch (i) {
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
@@ -880,8 +882,14 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 					   entry->lsm[lsm_rule].args_p,
 					   &entry->lsm[lsm_rule].rule);
 	if (!entry->lsm[lsm_rule].rule) {
-		kfree(entry->lsm[lsm_rule].args_p);
-		return -EINVAL;
+		pr_warn("rule for LSM \'%s\' is undefined\n",
+			(char *)entry->lsm[lsm_rule].args_p);
+
+		if (ima_rules == &ima_default_rules) {
+			kfree(entry->lsm[lsm_rule].args_p);
+			result = -EINVAL;
+		} else
+			result = 0;
 	}
 
 	return result;
-- 
2.17.1

