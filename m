Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F43C30F97
	for <lists+linux-integrity@lfdr.de>; Fri, 31 May 2019 16:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfEaOEP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 May 2019 10:04:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46941 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfEaOEP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 May 2019 10:04:15 -0400
Received: by mail-lf1-f65.google.com with SMTP id l26so7974616lfh.13;
        Fri, 31 May 2019 07:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NbiFOXPIgLQl8X4RPOXyYI26kwMW4SPGkalTFBiRZ70=;
        b=DsDJ/R5syVbbBzUegwP9YPJCreqBZD4YX6TDNd2S1lE+3vnZkJ+L3BwzzMbCOm6Y9u
         GxTayoeoJIU4SG3p8edN2dwYKuKLU7b3JedDnvp5advMX/y+Hy78LyIMApCxsTpz1z0h
         gVZqZCtSP51XD+s+6quoOXY3nrQm/1CHqUeXC9khCAkf1iOSc7KENq1RvHhku8vbGZIo
         DuSTsHEMzMGniXiisWit+QIcXyJm8l0AKawQwnec0HjXXbPvxIGVgNVCX2TOmZsVU9rI
         XW3Ai4/0Kg9cUUPtInjvrgioxTSrt8Uxx3f6ptm+SIBsxZloXrybEqWpRkbatZvc5t/N
         GFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NbiFOXPIgLQl8X4RPOXyYI26kwMW4SPGkalTFBiRZ70=;
        b=fOEk4PUaGJ9YDqZCB30/T43QI7oJQ/GzlSE8FN5IMylw0qdxliYNWLPa35vXgRwuL/
         3iloqU9PNThj57jjZsPgU5dErIDcLI9C+2Gcx/Bnm8jgatqryKjcZB3fbInsYgi0BCc8
         AnamG5kXD2eDD28eBE7UjuonJy56KrG5agBVqhjgkAKthwcOutVp8kaVdjZB3bQSBEuD
         H8K1XxlQQIzxZScxIh2LqoD/yx4tUAG2Y6/OrmAtg8mx5VS7eGQmFQUJT3Lj0cOzfLj+
         YXpU2Rbd6kEuWa27l2XDoXPYwt46EHKnD9RIk6pXbp/dU6sDFyYjU3Z/81aV5lwlzCzr
         KMig==
X-Gm-Message-State: APjAAAWPAkPLo3IWJGAEnPZ/WDzpeYmxgDcV5iRFharVElMRR0HQwOFe
        cisUXzX12C0Cz9UgCfhUX0pPGeT7uoY=
X-Google-Smtp-Source: APXvYqxBCKqkK0/ycIl6x26U+uJ74w4gr3ePPAhUqv9OuTLs3y2WzkKqv/jkbOG/+uPUfrj56/+nYw==
X-Received: by 2002:ac2:5621:: with SMTP id b1mr5460421lff.27.1559311452507;
        Fri, 31 May 2019 07:04:12 -0700 (PDT)
Received: from localhost.localdomain (mobile-user-c1d2e5-213.dhcp.inet.fi. [193.210.229.213])
        by smtp.gmail.com with ESMTPSA id d15sm670412lfq.76.2019.05.31.07.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 07:04:11 -0700 (PDT)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     sds@tycho.nsa.gov, zohar@linux.ibm.com, paul@paul-moore.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Janne Karhunen <janne.karhunen@gmail.com>
Subject: [PATCH 2/2] ima: use the lsm policy update notifier
Date:   Fri, 31 May 2019 17:02:37 +0300
Message-Id: <20190531140237.9199-2-janne.karhunen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531140237.9199-1-janne.karhunen@gmail.com>
References: <20190531140237.9199-1-janne.karhunen@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Don't do lazy policy updates while running the rule matching,
run the updates as they happen.

Depends on commit cda44589be1c ("LSM: switch to blocking policy update notifiers")

Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
---
 security/integrity/ima/ima.h        |  2 ++
 security/integrity/ima/ima_main.c   |  8 ++++++
 security/integrity/ima/ima_policy.c | 44 +++++++++++++++++++++--------
 3 files changed, 42 insertions(+), 12 deletions(-)

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
index 357edd140c09..f9629c5e1aee 100644
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
@@ -593,6 +597,10 @@ static int __init init_ima(void)
 		error = ima_init();
 	}
 
+	error = register_lsm_notifier(&ima_lsm_policy_notifier);
+	if (error)
+		pr_warn("Couldn't register LSM notifier, error %d\n", error);
+
 	if (!error)
 		ima_update_policy_flag();
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e0cc323f948f..4201a21ff42f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -252,12 +252,14 @@ __setup("ima_appraise_tcb", default_appraise_policy_setup);
 /*
  * The LSM policy can be reloaded, leaving the IMA LSM based rules referring
  * to the old, stale LSM policy.  Update the IMA LSM based rules to reflect
- * the reloaded LSM policy.  We assume the rules still exist; and BUG_ON() if
- * they don't.
+ * the reloaded LSM policy.
  */
 static void ima_lsm_update_rules(void)
 {
 	struct ima_rule_entry *entry;
+	void *rule_new;
+	char *lsm_new;
+	char *lsm_old;
 	int result;
 	int i;
 
@@ -265,15 +267,39 @@ static void ima_lsm_update_rules(void)
 		for (i = 0; i < MAX_LSM_RULES; i++) {
 			if (!entry->lsm[i].rule)
 				continue;
+
+			lsm_old = entry->lsm[i].args_p;
+			lsm_new = kstrdup(lsm_old, GFP_KERNEL);
+			if (unlikely(!lsm_new))
+				return;
+
 			result = security_filter_rule_init(entry->lsm[i].type,
 							   Audit_equal,
-							   entry->lsm[i].args_p,
-							   &entry->lsm[i].rule);
-			BUG_ON(!entry->lsm[i].rule);
+							   lsm_new,
+							   &rule_new);
+			if (result == -EINVAL)
+				pr_warn("ima: rule for LSM \'%d\' is invalid\n",
+					entry->lsm[i].type);
+
+			entry->lsm[i].rule = rule_new;
+			entry->lsm[i].args_p = lsm_new;
+			synchronize_rcu();
+
+			kfree(lsm_old);
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
@@ -327,11 +353,10 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
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
@@ -352,11 +377,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
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

