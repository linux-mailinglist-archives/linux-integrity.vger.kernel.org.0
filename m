Return-Path: <linux-integrity+bounces-6309-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A35AC4F25
	for <lists+linux-integrity@lfdr.de>; Tue, 27 May 2025 15:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46FE61882260
	for <lists+linux-integrity@lfdr.de>; Tue, 27 May 2025 13:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B7F26FD95;
	Tue, 27 May 2025 13:01:15 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54221E4BE;
	Tue, 27 May 2025 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748350875; cv=none; b=WkG8ozW4z+RGBRNWXlihqzZgR6W43FEKu/CB5e+8VdJkE3tiOBEYCpTJwePpQkco7SuDuXiW37DPd8Z8Pz6WId7zHdrX3AaOCoeK8dTKnzdsdS3azd5rHj76dKCcl0fleiA6OlUdoDlreSLrK+HWLcV6maIq1+fgadWQ8zHfviU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748350875; c=relaxed/simple;
	bh=e3RWz1HSsecBHl0HCS04IuuI1P7LdQRmuFIuAJ37OuU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qr7DgzeqYDmxtrfGtuTHliMPNNlL1oALlacG+6Q7YkzkLEGF5ILEDA6e4D1WqHuLD7ckdd4RpDi61AQ4B+xRH6PSml1O0TE26Tas0PX9zuOoHqdLgoaIlN2epJhPL/UBU49EHVePGWKE5+Irtlo1Nf+4us1ErH1OyK9YZzW6AkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4b6CLv6wFDzvX0T;
	Tue, 27 May 2025 20:56:39 +0800 (CST)
Received: from kwepemh500010.china.huawei.com (unknown [7.202.181.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 585DE180492;
	Tue, 27 May 2025 21:01:04 +0800 (CST)
Received: from huawei.com (10.67.175.67) by kwepemh500010.china.huawei.com
 (7.202.181.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 May
 2025 21:01:03 +0800
From: Zhao Yipeng <zhaoyipeng5@huawei.com>
To: <zohar@linux.ibm.com>, <roberto.sassu@huawei.com>,
	<dmitry.kasatkin@gmail.com>, <eric.snowberg@oracle.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<janne.karhunen@gmail.com>
CC: <morgan@kernel.org>, <lujialin4@huawei.com>,
	<linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ima: prevent concurrent list operations in ima_lsm_update_rules
Date: Tue, 27 May 2025 20:51:03 +0800
Message-ID: <20250527125103.751077-1-zhaoyipeng5@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemh500010.china.huawei.com (7.202.181.141)

The current implementation of IMA policy list replacement via
list_replace_rcu may trigger general protection faults under concurrent
load policy operations. This occurs when a process replaces a node in
ima_policy_rules list and sets old->prev = LIST_POISON2, while another
parallel process still holds references to the old node. Subsequent list
operations on the poisoned pointer result in kernel panic due to invalid
memory access.

To resolve this, introduce a mutex lock (ima_rules_mutex) in
ima_lsm_update_rules() to protect. ima_update_policy() also use the
ima_policy_rules. Introduce a mutex lock in it.

Fixes: b16942455193 ("ima: use the lsm policy update notifier")
Signed-off-by: Zhao Yipeng <zhaoyipeng5@huawei.com>
---
 security/integrity/ima/ima_policy.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 128fab897930..d27e615e97d5 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -471,6 +471,8 @@ static bool ima_rule_contains_lsm_cond(struct ima_rule_entry *entry)
 	return false;
 }
 
+static DEFINE_MUTEX(ima_rules_mutex);
+
 /*
  * The LSM policy can be reloaded, leaving the IMA LSM based rules referring
  * to the old, stale LSM policy.  Update the IMA LSM based rules to reflect
@@ -481,16 +483,19 @@ static void ima_lsm_update_rules(void)
 	struct ima_rule_entry *entry, *e;
 	int result;
 
+	mutex_lock(&ima_rules_mutex);
 	list_for_each_entry_safe(entry, e, &ima_policy_rules, list) {
 		if (!ima_rule_contains_lsm_cond(entry))
 			continue;
 
 		result = ima_lsm_update_rule(entry);
 		if (result) {
+			mutex_unlock(&ima_rules_mutex);
 			pr_err("lsm rule update error %d\n", result);
 			return;
 		}
 	}
+	mutex_unlock(&ima_rules_mutex);
 }
 
 int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
@@ -1038,9 +1043,12 @@ int ima_check_policy(void)
  */
 void ima_update_policy(void)
 {
-	struct list_head *policy = &ima_policy_rules;
+	struct list_head *policy;
 
+	mutex_lock(&ima_rules_mutex);
+	policy = &ima_policy_rules;
 	list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
+	mutex_unlock(&ima_rules_mutex);
 
 	if (ima_rules != (struct list_head __rcu *)policy) {
 		ima_policy_flag = 0;
-- 
2.34.1


