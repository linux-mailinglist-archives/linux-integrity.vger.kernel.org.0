Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA8FC41E2E
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jun 2019 09:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407952AbfFLHqf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jun 2019 03:46:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34788 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406508AbfFLHqe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jun 2019 03:46:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id p17so6932735ljg.1;
        Wed, 12 Jun 2019 00:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=voWdC+EmtQNr66ZM3yr4qbq+boeE2fF1DJk/pbOxntM=;
        b=qC4nOHZzlq4T87u53EwFQn2FA3x1IRIGkm6ymAxP+mJk+IXdxtKIi/j48SJadoC6Bh
         0OcHUbfY+E5qK5/HyPHmIgxC10hcGUdETibSLeRlN8PAM+XihK9bZPZdDVBDfZ7534ix
         hWQjf94UWWn84/I2f5HxeBJBl7n5P2eNq7eZ3LRFOJtaJapwxiFs46D26X9goWSoUlJY
         o7QqUkifyj/PJdwd7N4En9Fg2mqMmI83YuusIxH8aHaMott1PnvdjVUSCdRxDqbMDujk
         6ZMKULLj5WDHdwC77LJU9fFHOjWJ6vMJof0zj12+jZF5EVheMrrgItysn8vTcwQhimY5
         n+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=voWdC+EmtQNr66ZM3yr4qbq+boeE2fF1DJk/pbOxntM=;
        b=fN2tuTG9A3M8UDcpAd0rdwl8odUofE7Xho3nWcyx+7da3WCTdHgW5lM7VAsle7UdmH
         3yjQlr1ACmVR/w2w0cd3J30eg8SlT05lIvYsTaUA3AWV7dkzChsa5IuHX33179phlddV
         MKWVl5TNXB+korcEZn/hpPLNSkhXrQ4Rz/J0zs98DPU2//PYxShQo2Um3ScEW40o54a3
         okXk2+qETgx4sx6cDOk+4RRUYDgD3aASsl/k0aTCeQRcPkWjtx0fYjw3S9b68zc2IRbR
         yIARHwhYiUwBnBgBhv2o8MJB5ebEyfILtilqgwIs4one8LZohQs9spQpR3tfah2DMPdr
         Gzow==
X-Gm-Message-State: APjAAAViX/xcsf52TdbFljrODwgi/HLXvcBeyHzTaKaGj/WNY4oXXAxT
        9TfSy6hPFaIfU+STPx8Yj70=
X-Google-Smtp-Source: APXvYqwzpHbMBEeW4ZvUXvT2db4ov8mIy4/5/qFTHYMQUCPdCSizUEwnUgJY0HvuUaC8BQy6GE9jbA==
X-Received: by 2002:a2e:894a:: with SMTP id b10mr11732411ljk.99.1560325592233;
        Wed, 12 Jun 2019 00:46:32 -0700 (PDT)
Received: from localhost.localdomain ([193.211.7.147])
        by smtp.gmail.com with ESMTPSA id h11sm2961610lfm.14.2019.06.12.00.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 00:46:31 -0700 (PDT)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     sds@tycho.nsa.gov, paul@paul-moore.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Janne Karhunen <janne.karhunen@gmail.com>
Subject: [PATCH v2 1/2] ima: use the lsm policy update notifier
Date:   Wed, 12 Jun 2019 10:44:56 +0300
Message-Id: <20190612074456.2504-2-janne.karhunen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612074456.2504-1-janne.karhunen@gmail.com>
References: <20190612074456.2504-1-janne.karhunen@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Don't do lazy policy updates while running the rule matching,
run the updates as they happen.

Depends on commit 141a61ce6c60 ("LSM: switch to blocking policy update notifiers")

Changelog v2
- Rebase to 'next-queued-testing'
- Use memset to initialize the lsm rule array
- Don't duplicate elements that are immutable during the rule copy

=========
Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
---
 security/integrity/ima/ima.h        |   2 +
 security/integrity/ima/ima_main.c   |   8 ++
 security/integrity/ima/ima_policy.c | 116 +++++++++++++++++++++++-----
 3 files changed, 106 insertions(+), 20 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 18b48a6d0b80..579544527246 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -155,6 +155,8 @@ unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 void ima_init_template_list(void);
 int __init ima_init_digests(void);
+int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
+			  void *lsm_data);
 
 /*
  * used to protect h_table and sha_table
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index af341a80118f..a7e7e2d7224c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -43,6 +43,10 @@ int ima_appraise;
 int ima_hash_algo = HASH_ALGO_SHA1;
 static int hash_setup_done;
 
+static struct notifier_block ima_lsm_policy_notifier = {
+	.notifier_call = ima_lsm_policy_change,
+};
+
 static int __init hash_setup(char *str)
 {
 	struct ima_template_desc *template_desc = ima_template_desc_current();
@@ -622,6 +626,10 @@ static int __init init_ima(void)
 		error = ima_init();
 	}
 
+	error = register_blocking_lsm_notifier(&ima_lsm_policy_notifier);
+	if (error)
+		pr_warn("Couldn't register LSM notifier, error %d\n", error);
+
 	if (!error)
 		ima_update_policy_flag();
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index fd9b01881d17..e1550859f870 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -250,31 +250,113 @@ static int __init default_appraise_policy_setup(char *str)
 }
 __setup("ima_appraise_tcb", default_appraise_policy_setup);
 
+static void ima_lsm_free_rule(struct ima_rule_entry *entry)
+{
+	int i;
+
+	for (i = 0; i < MAX_LSM_RULES; i++) {
+		kfree(entry->lsm[i].rule);
+		kfree(entry->lsm[i].args_p);
+	}
+	kfree(entry);
+}
+
+static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
+{
+	struct ima_rule_entry *nentry;
+	int i, result;
+
+	nentry = kmalloc(sizeof(*nentry), GFP_KERNEL);
+	if (!nentry)
+		return NULL;
+
+	/*
+	 * Immutable elements are copied over as pointers and data; only
+	 * lsm rules can change
+	 */
+	memcpy(nentry, entry, sizeof(*nentry));
+	memset(nentry->lsm, 0, FIELD_SIZEOF(struct ima_rule_entry, lsm));
+
+	for (i = 0; i < MAX_LSM_RULES; i++) {
+		if (!entry->lsm[i].rule)
+			continue;
+
+		nentry->lsm[i].type = entry->lsm[i].type;
+		nentry->lsm[i].args_p = kstrdup(entry->lsm[i].args_p,
+						GFP_KERNEL);
+		if (!nentry->lsm[i].args_p)
+			goto out_err;
+
+		result = security_filter_rule_init(nentry->lsm[i].type,
+						   Audit_equal,
+						   nentry->lsm[i].args_p,
+						   &nentry->lsm[i].rule);
+		if (result == -EINVAL)
+			pr_warn("ima: rule for LSM \'%d\' is undefined\n",
+				entry->lsm[i].type);
+	}
+	return nentry;
+
+out_err:
+	ima_lsm_free_rule(nentry);
+	return NULL;
+}
+
+static int ima_lsm_update_rule(struct ima_rule_entry *entry)
+{
+	struct ima_rule_entry *nentry;
+
+	nentry = ima_lsm_copy_rule(entry);
+	if (!nentry)
+		return -ENOMEM;
+
+	list_replace_rcu(&entry->list, &nentry->list);
+	synchronize_rcu();
+	ima_lsm_free_rule(entry);
+
+	return 0;
+}
+
 /*
  * The LSM policy can be reloaded, leaving the IMA LSM based rules referring
  * to the old, stale LSM policy.  Update the IMA LSM based rules to reflect
- * the reloaded LSM policy.  We assume the rules still exist; and BUG_ON() if
- * they don't.
+ * the reloaded LSM policy.
  */
 static void ima_lsm_update_rules(void)
 {
-	struct ima_rule_entry *entry;
-	int result;
-	int i;
+	struct ima_rule_entry *entry, *e;
+	int i, result, needs_update;
 
-	list_for_each_entry(entry, &ima_policy_rules, list) {
+	list_for_each_entry_safe(entry, e, &ima_policy_rules, list) {
+		needs_update = 0;
 		for (i = 0; i < MAX_LSM_RULES; i++) {
-			if (!entry->lsm[i].rule)
-				continue;
-			result = security_filter_rule_init(entry->lsm[i].type,
-							   Audit_equal,
-							   entry->lsm[i].args_p,
-							   &entry->lsm[i].rule);
-			BUG_ON(!entry->lsm[i].rule);
+			if (entry->lsm[i].rule) {
+				needs_update = 1;
+				break;
+			}
+		}
+		if (!needs_update)
+			continue;
+
+		result = ima_lsm_update_rule(entry);
+		if (result) {
+			pr_err("ima: lsm rule update error %d\n",
+				result);
+			return;
 		}
 	}
 }
 
+int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
+			  void *lsm_data)
+{
+	if (event != LSM_POLICY_CHANGE)
+		return NOTIFY_DONE;
+
+	ima_lsm_update_rules();
+	return NOTIFY_OK;
+}
+
 /**
  * ima_match_rules - determine whether an inode matches the measure rule.
  * @rule: a pointer to a rule
@@ -328,11 +410,10 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
-		int retried = 0;
 
 		if (!rule->lsm[i].rule)
 			continue;
-retry:
+
 		switch (i) {
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
@@ -353,11 +434,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		default:
 			break;
 		}
-		if ((rc < 0) && (!retried)) {
-			retried = 1;
-			ima_lsm_update_rules();
-			goto retry;
-		}
 		if (!rc)
 			return false;
 	}
-- 
2.17.1

