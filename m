Return-Path: <linux-integrity+bounces-2340-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A958BDE31
	for <lists+linux-integrity@lfdr.de>; Tue,  7 May 2024 11:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45924B20B37
	for <lists+linux-integrity@lfdr.de>; Tue,  7 May 2024 09:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F8114D70F;
	Tue,  7 May 2024 09:29:10 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E1D6E61B;
	Tue,  7 May 2024 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074150; cv=none; b=mwMPDC4YnCmv5H5Ktgt8NCbLh4pvWjUBklwtsu1KEzQEZVK2VFQZ6yh/8zFQB7GtcUtiZzhzqMg48Z13eYc51s42JZcKVxw+zAm6m8GMzbV+zorE3lBnttLYaupdL9eWtuyzTZIjTD/5DvPVWnCjonsVPbfjmFdTIHuYZeDpM4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074150; c=relaxed/simple;
	bh=35twsSiMDlm/W87ud83BDqRk6dzvwB3GRw0RWgmTKdA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=puntpwB1P4R1jgm7QiolNUxhywz6GQSXfK0IUGC9HP8W65GzT7yjyb/lMLbIDAO3+cgyU2IRvYqTebCWNDo0w8saJVQf185yYVS1UW0JE6mpHjo7G+qXmKBS01y4LWgHeMifSR7tSelxn3wUAzANnGymsJw524NKHEYzQDwDUTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VYXbX2mH8z9v7gQ;
	Tue,  7 May 2024 17:12:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 0A35B1407FB;
	Tue,  7 May 2024 17:28:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwB3YydN9DlmpJ6tBw--.32254S2;
	Tue, 07 May 2024 10:28:57 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	john.johansen@canonical.com,
	stephen.smalley.work@gmail.com,
	casey@schaufler-ca.com,
	eparis@redhat.com
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guozihua@huawei.com,
	omosnace@redhat.com,
	audit@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	selinux@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH] ima: Use sequence number to wait for policy updates
Date: Tue,  7 May 2024 11:28:31 +0200
Message-Id: <20240507092831.3590793-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwB3YydN9DlmpJ6tBw--.32254S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurW8Wr48Zr48ZF4kKr13CFg_yoW7JF1xpF
	Wvga4DCF40vFWI9r4xC34UZw4Y9F18ur1Ut3s8W34aywsxAr10gF18tFy2va4fGrW5Cr1f
	XF4YgrsYkw1jv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0bAw3UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBF1jj5kT+gAAsX

From: Roberto Sassu <roberto.sassu@huawei.com>

Maintain a global sequence number, and set it to individual policy rules,
when they are created.

When a rule is stale, wait for the global sequence number to increase,
which happens when the LSM policy has been fully updated.

Finally, restart the ima_match_policy() loop, which should not encounter
the stale rule anymore.

On policy update, already increase the rule sequence number, so that a wait
can be implemented for the next policy update.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_policy.c | 65 +++++++++++++++--------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c0556907c2e6..4f8275e216fe 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -51,9 +51,12 @@
 #define INVALID_PCR(a) (((a) < 0) || \
 	(a) >= (sizeof_field(struct ima_iint_cache, measured_pcrs) * 8))
 
+DECLARE_WAIT_QUEUE_HEAD(wait_queue_t);
+
 int ima_policy_flag;
 static int temp_ima_appraise;
 static int build_ima_appraise __ro_after_init;
+static int global_seqno;
 
 atomic_t ima_setxattr_allowed_hash_algorithms;
 
@@ -122,6 +125,7 @@ struct ima_rule_entry {
 	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
 	struct ima_rule_opt_list *label; /* Measure data grouped under this label */
 	struct ima_template_desc *template;
+	int seqno;
 };
 
 /*
@@ -442,6 +446,8 @@ static int ima_lsm_update_rule(struct ima_rule_entry *entry)
 	if (!nentry)
 		return -ENOMEM;
 
+	nentry->seqno++;
+
 	list_replace_rcu(&entry->list, &nentry->list);
 	synchronize_rcu();
 	/*
@@ -497,6 +503,8 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 		return NOTIFY_DONE;
 
 	ima_lsm_update_rules();
+	global_seqno++;
+	wake_up(&wait_queue_t);
 	return NOTIFY_OK;
 }
 
@@ -560,18 +568,16 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @func_data: func specific data, may be NULL
  *
- * Returns true on rule match, false on failure.
+ * Returns 1 on rule match, 0 on mismatch, -ESTALE on stale policy.
  */
-static bool ima_match_rules(struct ima_rule_entry *rule,
-			    struct mnt_idmap *idmap,
-			    struct inode *inode, const struct cred *cred,
-			    u32 secid, enum ima_hooks func, int mask,
-			    const char *func_data)
+static int ima_match_rules(struct ima_rule_entry *rule,
+			   struct mnt_idmap *idmap,
+			   struct inode *inode, const struct cred *cred,
+			   u32 secid, enum ima_hooks func, int mask,
+			   const char *func_data)
 {
 	int i;
-	bool result = false;
 	struct ima_rule_entry *lsm_rule = rule;
-	bool rule_reinitialized = false;
 
 	if ((rule->flags & IMA_FUNC) &&
 	    (rule->func != func && func != POST_SETATTR))
@@ -642,7 +648,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 				return false;
 		}
 
-retry:
 		switch (i) {
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
@@ -663,27 +668,13 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 			break;
 		}
 
-		if (rc == -ESTALE && !rule_reinitialized) {
-			lsm_rule = ima_lsm_copy_rule(rule);
-			if (lsm_rule) {
-				rule_reinitialized = true;
-				goto retry;
-			}
-		}
-		if (!rc) {
-			result = false;
-			goto out;
-		}
+		if (!rc)
+			return false;
+		else if (rc == -ESTALE)
+			return rc;
 	}
-	result = true;
 
-out:
-	if (rule_reinitialized) {
-		for (i = 0; i < MAX_LSM_RULES; i++)
-			ima_filter_rule_free(lsm_rule->lsm[i].rule);
-		kfree(lsm_rule);
-	}
-	return result;
+	return true;
 }
 
 /*
@@ -741,12 +732,12 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		     const char *func_data, unsigned int *allowed_algos)
 {
 	struct ima_rule_entry *entry;
-	int action = 0, actmask = flags | (flags << 1);
+	int action = 0, rc, actmask = flags | (flags << 1);
 	struct list_head *ima_rules_tmp;
 
 	if (template_desc && !*template_desc)
 		*template_desc = ima_template_desc_current();
-
+retry:
 	rcu_read_lock();
 	ima_rules_tmp = rcu_dereference(ima_rules);
 	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
@@ -754,9 +745,18 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, idmap, inode, cred, secid,
-				     func, mask, func_data))
+		rc = ima_match_rules(entry, idmap, inode, cred, secid,
+				     func, mask, func_data);
+		if (!rc)
 			continue;
+		else if (rc == -ESTALE) {
+			rcu_read_unlock();
+
+			wait_event_interruptible(wait_queue_t,
+				(global_seqno == entry->seqno + 1));
+
+			goto retry;
+		}
 
 		action |= entry->flags & IMA_NONACTION_FLAGS;
 
@@ -1153,6 +1153,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 			result = 0;
 	}
 
+	entry->seqno = global_seqno;
 	return result;
 }
 
-- 
2.34.1


