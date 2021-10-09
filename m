Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5B142790C
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Oct 2021 12:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhJIKlG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 9 Oct 2021 06:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhJIKlG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 9 Oct 2021 06:41:06 -0400
Received: from ha0.nfschina.com (unknown [IPv6:2400:dd01:100f:2:d63d:7eff:fe08:eb3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B936C061570;
        Sat,  9 Oct 2021 03:39:08 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha0.nfschina.com (Postfix) with ESMTP id 8DEB8AE0E44;
        Sat,  9 Oct 2021 18:40:50 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha0.nfschina.com ([127.0.0.1])
        by localhost (ha0.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FtkZCRRlX7cL; Sat,  9 Oct 2021 18:40:29 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by ha0.nfschina.com (Postfix) with ESMTPA id 28FD7AE0DE1;
        Sat,  9 Oct 2021 18:40:29 +0800 (CST)
From:   liqiong <liqiong@nfschina.com>
To:     Simon.THOBY@viveris.fr, zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ima: fix deadlock when traversing "ima_default_rules".
Date:   Sat,  9 Oct 2021 18:38:21 +0800
Message-Id: <20211009103821.51767-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210918031139.22674-1-liqiong@nfschina.com>
References: <20210918031139.22674-1-liqiong@nfschina.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The current IMA ruleset is identified by the variable "ima_rules"
that default to "&ima_default_rules". When loading a custom policy
for the first time, the variable is updated to "&ima_policy_rules"
instead. That update isn't RCU-safe, and deadlocks are possible.
Indeed, some functions like ima_match_policy() may loop indefinitely
when traversing "ima_default_rules" with list_for_each_entry_rcu().

When iterating over the default ruleset back to head, if the list
head is "ima_default_rules", and "ima_rules" have been updated to
"&ima_policy_rules", the loop condition (&entry->list != ima_rules)
stays always true, traversing won't terminate, causing a soft lockup
and RCU stalls.

Introduce a temporary value for "ima_rules" when iterating over
the ruleset to avoid the deadlocks.

Signed-off-by: liqiong <liqiong@nfschina.com>
Reviewed-by: THOBY Simon <Simon.THOBY@viveris.fr>
Fixes: 38d859f991f3 ("IMA: policy can now be updated multiple times")
Reported-by: kernel test robot <lkp@intel.com> (Fix sparse: incompatible types in comparison expression.)
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_policy.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 87b9b71cb820..12e8adcd80a2 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -228,7 +228,7 @@ static struct ima_rule_entry *arch_policy_entry __ro_after_init;
 static LIST_HEAD(ima_default_rules);
 static LIST_HEAD(ima_policy_rules);
 static LIST_HEAD(ima_temp_rules);
-static struct list_head *ima_rules = &ima_default_rules;
+static struct list_head __rcu *ima_rules = (struct list_head __rcu *)(&ima_default_rules);
 
 static int ima_policy __initdata;
 
@@ -675,12 +675,14 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
+	struct list_head *ima_rules_tmp;
 
 	if (template_desc && !*template_desc)
 		*template_desc = ima_template_desc_current();
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, ima_rules, list) {
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 
 		if (!(entry->action & actmask))
 			continue;
@@ -741,9 +743,11 @@ void ima_update_policy_flags(void)
 {
 	struct ima_rule_entry *entry;
 	int new_policy_flag = 0;
+	struct list_head *ima_rules_tmp;
 
 	rcu_read_lock();
-	list_for_each_entry(entry, ima_rules, list) {
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 		/*
 		 * SETXATTR_CHECK rules do not implement a full policy check
 		 * because rule checking would probably have an important
@@ -968,10 +972,10 @@ void ima_update_policy(void)
 
 	list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
 
-	if (ima_rules != policy) {
+	if (ima_rules != (struct list_head __rcu *)policy) {
 		ima_policy_flag = 0;
-		ima_rules = policy;
 
+		rcu_assign_pointer(ima_rules, policy);
 		/*
 		 * IMA architecture specific policy rules are specified
 		 * as strings and converted to an array of ima_entry_rules
@@ -1061,7 +1065,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
 
-		if (ima_rules == &ima_default_rules) {
+		if (ima_rules == (struct list_head __rcu *)(&ima_default_rules)) {
 			kfree(entry->lsm[lsm_rule].args_p);
 			entry->lsm[lsm_rule].args_p = NULL;
 			result = -EINVAL;
@@ -1768,9 +1772,11 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
 {
 	loff_t l = *pos;
 	struct ima_rule_entry *entry;
+	struct list_head *ima_rules_tmp;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, ima_rules, list) {
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 		if (!l--) {
 			rcu_read_unlock();
 			return entry;
@@ -1789,7 +1795,8 @@ void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
 	rcu_read_unlock();
 	(*pos)++;
 
-	return (&entry->list == ima_rules) ? NULL : entry;
+	return (&entry->list == &ima_default_rules ||
+		&entry->list == &ima_policy_rules) ? NULL : entry;
 }
 
 void ima_policy_stop(struct seq_file *m, void *v)
@@ -2014,6 +2021,7 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
 	struct ima_rule_entry *entry;
 	bool found = false;
 	enum ima_hooks func;
+	struct list_head *ima_rules_tmp;
 
 	if (id >= READING_MAX_ID)
 		return false;
@@ -2021,7 +2029,8 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
 	func = read_idmap[id] ?: FILE_CHECK;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, ima_rules, list) {
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 		if (entry->action != APPRAISE)
 			continue;
 
-- 
2.25.1

