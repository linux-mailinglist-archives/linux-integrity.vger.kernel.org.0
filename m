Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8B82102E76
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2019 22:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfKSVqJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 19 Nov 2019 16:46:09 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:38754
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727140AbfKSVqI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Nov 2019 16:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574199966; bh=5GryetjHS9DsS6NvVDShqBlcVkATUSaTt+1DCEu2n9w=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=NmTm9TxoU6vpNZGfPwkKlHGCMnoziafzfl0qX89RRSrVOS9KLzfuBZAnwUOCrBTAssBgngLL8kJ3GNoVt/IEoEQ/H14cTQpl1mBtaDeKxW66eRMhTFZFPZtTQcKuujHD7e1WeVOi8SlpvVnmrY/C3ZWaR5Hk9lMnU5M2U2OYoZvYnFw35697lexVmJuxY2g00cWthESjdOVla7hxqpwq2Q9GIjDDUOjjGRWHlhyBPXjR7D9yxFxthEAI7tCMi79J7roI8lD+jsD/g0vi9e3Eu2Erzd6doAl3qKqsHQZ7QisTU+xU5IK6c8nkvdbRT3ILjCXoT9yxO+jQIYze1KJMAg==
X-YMail-OSG: czr9Sa8VM1k6npVp9Ta1aB_tu3imWkmCwTC2XlCsOrU7PB8BkxWfUJA34LjPlss
 j0d9oe81W64Dha.lwz0Thp.J_kWqCu3G5MwoJmhOQUj7Da4ebEQvmmpFXRbmHywcd6rwwk2HYs2_
 l_ulXI4Of1n6tQ9obw4NfSnuoysHP2RWPHUrW_27IUqobKCSVEiJvOQvdMNvyIRY9pnLaO9DPvNj
 JkijaRYXlPtu3DCJsAzMxhnCu9WlmK_ee5Pw7cSlAn2rYDGJ5_s2qLEIvsLlsRRGdPl604DvzMAI
 A5D1WQkkFPyNSuNj5u1xrLo4qSqQcDPH4kX.HZPFOKV.A9TJJJpsjSocL3ko7lLcJwgQGyKkYNec
 kdHeeN1N7w9Jq_PasSx3W3Ur3VeLgOfzYwcAP90QrIB1LVj4Hll4mRrD7yh23RalS4Q5SKr48q5M
 2i.6AyBr5i_1KR7vgsS3lTtiXpJybKp_6i8pY1_Kp4d5VGGFd5wPK59brT1l7OHWXNE8rMyL8kGS
 TZ8F5pgdZBeCVhVQkA_ZQowGdQimHG_hG5Ek8gtNiiEM8ChP8yd7wX5qb0BrWRActDdaT62WcwIg
 i6BJ8YaE5SgwzRYxLv_p8kg5.K7r.lu7qD24gjoXIGwhx378ho6YUasU.WnCbAijg8vlIldmDJ_w
 XVePkvZ1yEQivCqxn.izJnGMyAHqoNavMbDHDeLFhH9l9MzMMEi9m5s.3LLsf7I.KehiPMHfBWZf
 hb9h.rUK5a17BR6HKOGvqpB9lKhaFxcZIGK0RuCCz2JsOWDh8af7OG1Ok86CwgEgn6WF3YsMVLqi
 HWXCrnjcoyuF.N_Nsr1CkpSVB7AWTdlCjXw3R1tsDPTUPcYwqKjbtdPajk6FJzYcgVCBAi.V1oq5
 b.i1EKsrpLvksYmUOQ7atdlrN5F3TMO4UEPd7oPpQa37jkgJRnm5MBhu2EZgU6khS6UYh5LvoCa7
 FcGJX8fiZZyWDJ.Z_TUoJ5WJi7egPxXJytJl5Frty6ELNzRRAkTTdLIx.U6k7TNnEIA1xaC.uIl4
 supvNsCm_3BMvQh92ABT0G41Vunu9_4z1l0ZhxAbNgRdglJAp7fA3a89a6Ru9jG1e6NqW5MJ8NU1
 5zLlrF4WyAqAbUlaRe6667qSF3NZ8fHXhmfPy0gfWAnyM7rLpNptw_c3fdSDo3zoCqjWYs3gR2id
 CRcqcModBoH5rhCzIwtN3UNo3juIkdG8V1yJvcddo3Ixcne9c1OI.fag0L5kCOOwjBQnJMIXsKrs
 _A3oaWxIXKG0T8nn_a5_soHSDk7EvyfrsNgbP.ZEYPz9jPb71qD520Pj8kmPXCwXPp.CLInGa7wu
 6q8g5i14CQFDBZaMRxE4c44S5h0s.z7wiR24c_kqIH8rJe5fq9hCpmJcB02.3QCiwP1MlYCx7Rij
 qLmpYV68FzWo4v6.pTvEWzshq04pdKY.jvGefrJZGm5p2fv06Meoh5Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 19 Nov 2019 21:46:06 +0000
Received: by smtp406.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 44ccda8ccd0493c5e1e3acd1964ab202;
          Tue, 19 Nov 2019 21:46:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com
Subject: [PATCH v11 03/25] LSM: Use lsmblob in security_audit_rule_match
Date:   Tue, 19 Nov 2019 13:45:56 -0800
Message-Id: <20191119214601.13238-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191119214601.13238-1-casey@schaufler-ca.com>
References: <20191119214601.13238-1-casey@schaufler-ca.com>
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
index 5eced28fa0c9..2df58448f1f2 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1835,7 +1835,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -1851,8 +1852,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index 3689081aaf38..5bcd6011ef8c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -370,8 +370,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
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
index 5380aca2b351..7711cc6a3fe3 100644
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

