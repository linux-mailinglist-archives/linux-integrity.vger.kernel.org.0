Return-Path: <linux-integrity+bounces-2342-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 734018BDECF
	for <lists+linux-integrity@lfdr.de>; Tue,  7 May 2024 11:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 991BCB20AF0
	for <lists+linux-integrity@lfdr.de>; Tue,  7 May 2024 09:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0C0150984;
	Tue,  7 May 2024 09:42:35 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD3114E2EF;
	Tue,  7 May 2024 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074955; cv=none; b=q4/5spE7t0A/M3lMkDhbFco1+oHXYIuu4SXhs3GIL2Gg9VZC9B5qFB4+U00x5ORE6yEoLcHzjJJRaQSPFI3fcSmAvQwGzQflcU7+1OgkgqNP1uhIDpj0Ge2+oK01dIdQ8iVEOhmbCxfzTgFi4P12Rgcu6LATjxOiCg08FG6HdiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074955; c=relaxed/simple;
	bh=VdSWCPQAIn9GwQc51HcOBACWo1FZmzZEpgWE+jpnrXM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nSeKooPUsDGlZKkfdH3Fl0iepDK6vLzUIkci7LqRuyzcfI3/aHjJEKhSsE/HsGAiaC5UFIh+Z1ZH8DVTlu4SUA4JRopT41SxTioKcSUtxza9qlGuOwbjjt2JAcVv82JM5iW2B7aLmqmedVFwvqq04iHPssJF9ye9k8TLc3RDCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VYYFB1DP5zCrNJ;
	Tue,  7 May 2024 17:41:18 +0800 (CST)
Received: from dggpemm500024.china.huawei.com (unknown [7.185.36.203])
	by mail.maildlp.com (Postfix) with ESMTPS id C513B14011B;
	Tue,  7 May 2024 17:42:13 +0800 (CST)
Received: from huawei.com (10.67.174.60) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 7 May
 2024 17:42:13 +0800
From: GUO Zihua <guozihua@huawei.com>
To: <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>, <jmorris@namei.org>,
	<serge@hallyn.com>
CC: <linux-integrity@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH] ima: fix deadlock when traversing "ima_default_rules".
Date: Tue, 7 May 2024 09:37:14 +0000
Message-ID: <20240507093714.1031820-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500024.china.huawei.com (7.185.36.203)

From: liqiong <liqiong@nfschina.com>

[ Upstream commit eb0782bbdfd0d7c4786216659277c3fd585afc0e ]

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

Addition:

A rcu_read_lock pair is added within ima_update_policy_flag to avoid
suspicious RCU usage warning. This pair of RCU lock was added with
commit 4f2946aa0c45 ("IMA: introduce a new policy option
func=SETXATTR_CHECK") on mainstream.

Signed-off-by: liqiong <liqiong@nfschina.com>
Reviewed-by: THOBY Simon <Simon.THOBY@viveris.fr>
Fixes: 38d859f991f3 ("IMA: policy can now be updated multiple times")
Reported-by: kernel test robot <lkp@intel.com> (Fix sparse: incompatible types in comparison expression.)
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 security/integrity/ima/ima_policy.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 1c403e8a8044..4f5d44037081 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -210,7 +210,7 @@ static struct ima_rule_entry *arch_policy_entry __ro_after_init;
 static LIST_HEAD(ima_default_rules);
 static LIST_HEAD(ima_policy_rules);
 static LIST_HEAD(ima_temp_rules);
-static struct list_head *ima_rules = &ima_default_rules;
+static struct list_head __rcu *ima_rules = (struct list_head __rcu *)(&ima_default_rules);
 
 static int ima_policy __initdata;
 
@@ -648,12 +648,14 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
+	struct list_head *ima_rules_tmp;
 
 	if (template_desc)
 		*template_desc = ima_template_desc_current();
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, ima_rules, list) {
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 
 		if (!(entry->action & actmask))
 			continue;
@@ -701,11 +703,15 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 void ima_update_policy_flag(void)
 {
 	struct ima_rule_entry *entry;
+	struct list_head *ima_rules_tmp;
 
-	list_for_each_entry(entry, ima_rules, list) {
+	rcu_read_lock();
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 		if (entry->action & IMA_DO_MASK)
 			ima_policy_flag |= entry->action;
 	}
+	rcu_read_unlock();
 
 	ima_appraise |= (build_ima_appraise | temp_ima_appraise);
 	if (!ima_appraise)
@@ -898,10 +904,10 @@ void ima_update_policy(void)
 
 	list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
 
-	if (ima_rules != policy) {
+	if (ima_rules != (struct list_head __rcu *)policy) {
 		ima_policy_flag = 0;
-		ima_rules = policy;
 
+		rcu_assign_pointer(ima_rules, policy);
 		/*
 		 * IMA architecture specific policy rules are specified
 		 * as strings and converted to an array of ima_entry_rules
@@ -989,7 +995,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
 
-		if (ima_rules == &ima_default_rules) {
+		if (ima_rules == (struct list_head __rcu *)(&ima_default_rules)) {
 			kfree(entry->lsm[lsm_rule].args_p);
 			entry->lsm[lsm_rule].args_p = NULL;
 			result = -EINVAL;
@@ -1598,9 +1604,11 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
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
@@ -1619,7 +1627,8 @@ void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
 	rcu_read_unlock();
 	(*pos)++;
 
-	return (&entry->list == ima_rules) ? NULL : entry;
+	return (&entry->list == &ima_default_rules ||
+		&entry->list == &ima_policy_rules) ? NULL : entry;
 }
 
 void ima_policy_stop(struct seq_file *m, void *v)
@@ -1823,6 +1832,7 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
 	struct ima_rule_entry *entry;
 	bool found = false;
 	enum ima_hooks func;
+	struct list_head *ima_rules_tmp;
 
 	if (id >= READING_MAX_ID)
 		return false;
@@ -1834,7 +1844,8 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
 	func = read_idmap[id] ?: FILE_CHECK;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, ima_rules, list) {
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 		if (entry->action != APPRAISE)
 			continue;
 
-- 
2.34.1


