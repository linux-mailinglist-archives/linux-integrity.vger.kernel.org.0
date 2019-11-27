Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06C2510BEA1
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 22:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfK0Vhe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 16:37:34 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:36599
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727768AbfK0Vhd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 16:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574890653; bh=FxnCQxjFzK/30a/DWvCMMePbAXkF7qoEi76eerowyV4=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject; b=CByKdgj9+UZp4uLhXyH+z16ZfIqatRbMfUDTy0n7xAWOteoJJDy7p4ZgNchgE2vCHNpJm/yNHeTLRDcLV+6uSRMoEdmaBgDUI7GjLwGrdHiMHnUIUfYQscSExUEx85GWOvcQWPyZCABppZAaW0IwDdzxwUs8JqkP0XW8Ns8eXKKnJ4dUEeGb9anheyCnsdeZkn8d/htKAUFe3OrtuMk9p3A9Nr4Ogai8ET53izstd11CM0PLMfkPymBZTAjkXSLNVTwvPI7CLrHpKEJVXq2Ah1GfH8v17hT/5WAx98Co0DGI4hi8/pJOnPuGSFUezLHr6hQ06AX4SnEXZ3C9Dghssg==
X-YMail-OSG: 1.nB6fkVM1kIgtgW01XDZFxIBlgIUp1Wv9Y8H5.ENBb15relLpcwmxOOXz33auk
 ka4xaXHNFjJhTsEXYu.TDxng482_55Iyh1cYwyG1vGv1AOzJwjyvB5hMZ20RnMjCJ.0R9eZnbNIq
 Ta0.bN7dGx4d4DgYc.akzAISiyNR9Z5eYAU1Ck9jyVOF6kt9LVV4SROtQl3I9odkk1qiDNjdmGo6
 aM3jscL6dkSWO62im9GW2g522APWzyJIvihviaDcrN5.N9wHe2VZngiLNvD0hW0igXX2jdsWHMRp
 f6XKfgbVFftkvH81cpbpH.ycveIzhrHEqV7yiKwYdS6XrFrxtU8kbBh162n14VvXtuu1D.YHUsKH
 36mthRx56nCzL7AOBhhIZyolFIatxrttY3Jv4FKWKRAzNroljotSq5krqHaySfmSczzzXO6uVjsB
 oBlYvPBDHcnyx0KQfS0dCOGI91wDf5lAnzbNowkgwEEu_3omjhgJlKuh4exd6Be2xjYXHKcqBTsA
 OTgiFE8nU6L7bPn1nKelsa5pVgGpRaQjjDb7oQ5ob8GBfiFdwT50OUv7vmQuy70Cdtu713AvZC36
 WEZ1Y9zZ.hUxxjyxYmbF8CXSw7RpCquB1kRs_5NHi6uO3Q9q8zJLbBo3Z5DBQPWc5TUbxxce27am
 yH4AddDMCd5PwfdnKOxXTnjqICbz09eJOtPN94DiQXG.rM_hlSZkzMqKo5GMdr8Zygyly0uQQiVO
 1XqWck1DKjGqFSYfFnILc4aRoWiBmRsuw21D0ojheXkMvJ8R7K2jcOceLEAwj0AEEeVPcwLSxL6R
 .L_xJwheHo.LhnuLvzVV8DGfQmuxBgzfCgbHAi.8z88fSvgKQoAXXvK9KDeQCExtsosWharOGnRx
 s7AXP_O5nB6JW0hXCUp9XmhxDvrVHaXST1a8u2hNzOgJafobsk2do4dk799Cg3TaKATqXm2pwkMa
 mHjgxHQjQQL.iX5G1lS48hhkiez9UFVE0gFLtx31k08hkM2dKbKqGzc_rjyH7jV34VdlsOZ9bLB5
 vP.KMhGiECyHr8KZHnxEou.Za.dQe8u2fgI1dzVVy5vvP8yymgbzuTtCmdd5FIVunx2PWefSEcuJ
 XxLsYj96uCagL72UdmKOT1ZYHz8raOj3VsU3okajXoJy0fZd8gX12IXFAVRza5vnyWpdtZMVDOrw
 zLGwUPVRd7Me1L_t4k7TQsubRL57Iy10I7rCNp8HIPasNaGCZDhboAPj5edfuv3up4TUsv0tpv7k
 zqqI9LXldhZx1oPAU7uEhn5Y458foJ3HvljW4dTo3XB0dDijPYeJq7bFc1EgN2kRPJMVpF20HS24
 jlrlmyU9jNygjT8Y2mTZg415PZKrYeMNAL9mTGfoxCSBCaysHvCS9DVyTTLhPe94iCA_E3gzi_ub
 sXGBJ9_GvRJvtjqy4PFiA_hunr4pkkY5X6e3hv3pHjwYhvw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 Nov 2019 21:37:33 +0000
Received: by smtp418.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7ae6d5325a27611baf4cae658f88f94c;
          Wed, 27 Nov 2019 21:37:29 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Subject: [v11-ima PATCH 03/25] LSM: Use lsmblob in security_audit_rule_match
Date:   Wed, 27 Nov 2019 13:36:56 -0800
Message-Id: <20191127213718.18267-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127213718.18267-1-casey@schaufler-ca.com>
References: <20191127213718.18267-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Change the secid parameter of security_audit_rule_match
to a lsmblob structure pointer. Pass the entry from the
lsmblob structure for the approprite slot to the LSM hook.

Change the users of security_audit_rule_match to use the
lsmblob instead of a u32. In some cases this requires a
temporary conversion using lsmblob_init() that will go
away when other interfaces get converted.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h            |  7 ++++---
 kernel/auditfilter.c                |  7 +++++--
 kernel/auditsc.c                    | 14 ++++++++++----
 security/integrity/ima/ima.h        |  4 ++--
 security/integrity/ima/ima_policy.c |  7 +++++--
 security/security.c                 | 18 +++++++++++++++---
 6 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 4942a3af46a8..ef936b608865 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1834,7 +1834,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -1850,8 +1851,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 	return 0;
 }
 
-static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
-					    void *lsmrule)
+static inline int security_audit_rule_match(struct lsmblob *blob, u32 field,
+					    u32 op, void *lsmrule)
 {
 	return 0;
 }
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index b0126e9c0743..356db1dd276c 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1325,6 +1325,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
 			u32 sid;
+			struct lsmblob blob;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1355,8 +1356,10 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
 					security_task_getsecid(current, &sid);
-					result = security_audit_rule_match(sid,
-						   f->type, f->op, f->lsm_rule);
+					lsmblob_init(&blob, sid);
+					result = security_audit_rule_match(
+							&blob, f->type,
+							f->op, f->lsm_rule);
 				}
 				break;
 			case AUDIT_EXE:
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 4effe01ebbe2..7566e5b1c419 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -445,6 +445,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
@@ -643,7 +644,9 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_task_getsecid(tsk, &sid);
 					need_sid = 0;
 				}
-				result = security_audit_rule_match(sid, f->type,
+				lsmblob_init(&blob, sid);
+				result = security_audit_rule_match(&blob,
+								   f->type,
 								   f->op,
 								   f->lsm_rule);
 			}
@@ -658,15 +661,17 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
+					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
-								name->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
+						lsmblob_init(&blob, n->osid);
 						if (security_audit_rule_match(
-								n->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rule)) {
@@ -678,7 +683,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				if (security_audit_rule_match(ctx->ipc.osid,
+				lsmblob_init(&blob, ctx->ipc.osid);
+				if (security_audit_rule_match(&blob,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index df4ca482fb53..d95b0ece7434 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -381,8 +381,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
 	return -EINVAL;
 }
 
-static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
-					     void *lsmrule)
+static inline int security_filter_rule_match(struct lsmblob *blob, u32 field,
+					     u32 op, void *lsmrule)
 {
 	return -EINVAL;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index f19a895ad7cd..193ddd55420b 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -414,6 +414,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob blob;
 
 		if (!rule->lsm[i].rule)
 			continue;
@@ -423,7 +424,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = security_filter_rule_match(osid,
+			lsmblob_init(&blob, osid);
+			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rule);
@@ -431,7 +433,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = security_filter_rule_match(secid,
+			lsmblob_init(&blob, secid);
+			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rule);
diff --git a/security/security.c b/security/security.c
index 5f503cadf7f3..7c386cbe4cf3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -439,7 +439,7 @@ static int lsm_append(const char *new, char **result)
 /*
  * Current index to use while initializing the lsmblob secid list.
  */
-static int lsm_slot __initdata;
+static int lsm_slot __lsm_ro_after_init;
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
@@ -2412,9 +2412,21 @@ void security_audit_rule_free(void *lsmrule)
 	call_void_hook(audit_rule_free, lsmrule);
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void *lsmrule)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
+					       field, op, lsmrule);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 #endif /* CONFIG_AUDIT */
 
-- 
2.20.1

