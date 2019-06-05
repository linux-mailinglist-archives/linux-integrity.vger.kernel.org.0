Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA0E358A9
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jun 2019 10:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfFEIgy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jun 2019 04:36:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35051 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfFEIgx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jun 2019 04:36:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id a25so18472176lfg.2;
        Wed, 05 Jun 2019 01:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yAY2x4M2ZvsX6SGgora+JblNOtjrwOO5ndy8yz8Qmbo=;
        b=btfdArMixbJhY0rY55lpebP2t5pQVRlneqmBJA+qulOEK2S9fIZLAAqmt+Ln/5a5/R
         f1lTFe8gvrImCn/mSemvyL4DnlBREwrZ/dn71rb8gzTO3Mu/dx8FIvN4p7oF9nm5CT39
         hLLp688CR7tZaxE1GqYCE+4WpyiqVgH2KPaSiB3TiWcwqf4x7We95z0EuGxvLCxzsP/J
         0KkNmhdqr4XK6EU8m9pt5Es2UyQlVuugA6XbATZZwJ5c0XfdIUJZcZ9JPO9hx/u6Eb9X
         WHHr6OPfLvbe/R/cDmOQ46EI2zmeHM/M/BCqcVj/iIYis0GqFX7zvjiP4LK3AaMWeCYi
         2H7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yAY2x4M2ZvsX6SGgora+JblNOtjrwOO5ndy8yz8Qmbo=;
        b=tmcHM01X6zo+Ld/PfroUrkbePdKh9LNcrso/xvNV/z4jcve3BYXgAJo5+tLJnCh6w+
         NxnvWaO+6NJYAA3tQnXsrdmqRM4ZHGBiormj1rKz1H3O08hV2oAUnxTUTN20VTsYwsEq
         VrxWnsQ7SBRNTKzVjQr4ogKBaVE0R5bt2e+5FK6oZexQ+2AhH38G4TR54ETnYjQtW6nX
         lgYg65fJUy8QByX6rVK/ZV8u0HBTmAUObRyRjEwobw37hXfzTFaFkenQwLrlDgYDv2eM
         i7cAhRE1+DY5P23CFzPFRyCk+x30g6S2XaRmGRSYvGnMT0mVD62VjGpe46YdhH8QGT1y
         sDRQ==
X-Gm-Message-State: APjAAAWqGb02gPC0p/0n4/x/sAdXbpsD5Sp/Vk5wk0JmCwu0onEzRkaT
        IPpDo4tqfJoQXSV2c0qVWVFg8iHfkro=
X-Google-Smtp-Source: APXvYqxRG47fyEfSM1m6YuO3gyrNyVx9PH54Z9AZVprfYBL7Q0cyFuPJZb7lRV1Zl0i+xjSeo5E6Ww==
X-Received: by 2002:a19:521a:: with SMTP id m26mr4683740lfb.134.1559723811337;
        Wed, 05 Jun 2019 01:36:51 -0700 (PDT)
Received: from localhost.localdomain (mobile-user-c1d2e6-229.dhcp.inet.fi. [193.210.230.229])
        by smtp.gmail.com with ESMTPSA id t21sm1392637ljg.60.2019.06.05.01.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 01:36:50 -0700 (PDT)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     sds@tycho.nsa.gov, zohar@linux.ibm.com, paul@paul-moore.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Janne Karhunen <janne.karhunen@gmail.com>
Subject: [PATCH 2/2] ima: use the lsm policy update notifier
Date:   Wed,  5 Jun 2019 11:36:06 +0300
Message-Id: <20190605083606.4209-2-janne.karhunen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605083606.4209-1-janne.karhunen@gmail.com>
References: <20190605083606.4209-1-janne.karhunen@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Don't do lazy policy updates while running the rule matching,
run the updates as they happen.

Depends on commit 2d1d5cee66d1 ("LSM: switch to blocking policy update notifiers")

Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
---
 security/integrity/ima/ima.h        |   2 +
 security/integrity/ima/ima_main.c   |   8 ++
 security/integrity/ima/ima_policy.c | 124 +++++++++++++++++++++++-----
 3 files changed, 114 insertions(+), 20 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d213e835c498..2203451862d4 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -154,6 +154,8 @@ unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 void ima_init_template_list(void);
 int __init ima_init_digests(void);
+int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
+			  void *lsm_data);
 
 /*
  * used to protect h_table and sha_table
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f16353b5097e..9e3ea8a3f2db 100644
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
@@ -621,6 +625,10 @@ static int __init init_ima(void)
 		error = ima_init();
 	}
 
+	error = register_blocking_lsm_notifier(&ima_lsm_policy_notifier);
+	if (error)
+		pr_warn("Couldn't register LSM notifier, error %d\n", error);
+
 	if (!error)
 		ima_update_policy_flag();
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 1cc822a59054..7129dc4cd396 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -249,31 +249,121 @@ static int __init default_appraise_policy_setup(char *str)
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
+	kfree(entry->fsname);
+	kfree(entry);
+}
+
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
+	memcpy(nentry, entry, sizeof(*nentry));
+	nentry->fsname = NULL;
+	for (i = 0; i < MAX_LSM_RULES; i++) {
+		nentry->lsm[i].rule = NULL;
+		nentry->lsm[i].args_p = NULL;
+	}
+
+	if (entry->fsname) {
+		nentry->fsname = kstrdup(entry->fsname, GFP_KERNEL);
+		if (!nentry->fsname)
+			goto out_err;
+	}
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
+			pr_warn("ima: rule for LSM \'%d\' is invalid\n",
+				entry->lsm[i].type);
+
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
@@ -327,11 +417,10 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
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
@@ -352,11 +441,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
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

