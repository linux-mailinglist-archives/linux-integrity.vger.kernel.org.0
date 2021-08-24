Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982073F5A47
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Aug 2021 10:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbhHXJAY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Aug 2021 05:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhHXJAX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Aug 2021 05:00:23 -0400
Received: from ha0.nfschina.com (unknown [IPv6:2400:dd01:100f:2:d63d:7eff:fe08:eb3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A159CC061757;
        Tue, 24 Aug 2021 01:59:39 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha0.nfschina.com (Postfix) with ESMTP id 236DFAE0DE1;
        Tue, 24 Aug 2021 16:59:11 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha0.nfschina.com ([127.0.0.1])
        by localhost (ha0.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 50kMs7wlv5m9; Tue, 24 Aug 2021 16:58:49 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by ha0.nfschina.com (Postfix) with ESMTPA id DA820AE0DBF;
        Tue, 24 Aug 2021 16:58:48 +0800 (CST)
From:   liqiong <liqiong@nfschina.com>
To:     Simon.THOBY@viveris.fr, zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com
Subject: [PATCH] ima: fix deadlock within "ima_match_policy" function.
Date:   Tue, 24 Aug 2021 16:57:47 +0800
Message-Id: <20210824085747.23604-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210819101529.28001-1-liqiong@nfschina.com>
References: <20210819101529.28001-1-liqiong@nfschina.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When "ima_match_policy" is looping while "ima_update_policy" changs
the variable "ima_rules", then "ima_match_policy" may can't exit
loop, Finally cause RCU CPU Stall Warnings: "rcu_sched detected
stall on CPU ...".

The problem is limited to transitioning from the builtin policy to
the custom policy. Eg. At boot time, systemd-services are being
checked within "ima_match_policy", at the same time, the variable
"ima_rules" is changed by another service.

Signed-off-by: liqiong <liqiong@nfschina.com>
---
 security/integrity/ima/ima_policy.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index fd5d46e511f1..e92b197bfd3c 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -662,12 +662,14 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
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
@@ -919,8 +921,8 @@ void ima_update_policy(void)
 
 	if (ima_rules != policy) {
 		ima_policy_flag = 0;
-		ima_rules = policy;
 
+		rcu_assign_pointer(ima_rules, policy);
 		/*
 		 * IMA architecture specific policy rules are specified
 		 * as strings and converted to an array of ima_entry_rules
@@ -1649,9 +1651,11 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
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
@@ -1670,7 +1674,8 @@ void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
 	rcu_read_unlock();
 	(*pos)++;
 
-	return (&entry->list == ima_rules) ? NULL : entry;
+	return (&entry->list == &ima_default_rules ||
+		&entry->list == &ima_policy_rules) ? NULL : entry;
 }
 
 void ima_policy_stop(struct seq_file *m, void *v)
@@ -1872,6 +1877,7 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
 	struct ima_rule_entry *entry;
 	bool found = false;
 	enum ima_hooks func;
+	struct list_head *ima_rules_tmp;
 
 	if (id >= READING_MAX_ID)
 		return false;
@@ -1879,7 +1885,8 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
 	func = read_idmap[id] ?: FILE_CHECK;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, ima_rules, list) {
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 		if (entry->action != APPRAISE)
 			continue;
 
-- 
2.11.0

