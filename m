Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C62D10BECB
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 22:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfK0Vii (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 16:38:38 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:40116
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728869AbfK0Vih (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 16:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574890716; bh=AqABZKrHoJ2O/YxWBBlyrWT0dGVssWeBH837HbXrHjo=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject; b=LD7C4PMJgr4D39SLX27It2wrZ0hIes9EVQCFYakEHG0D4EEMD2hNs3NQOVTcv6YtFsQWU2qJxOoLjRGfx4tvc4QcNQtxgCnpk2cYxWBO4o7U6Np7Jac9I+Wi1qH5IaP8b+lXP/ykophoE6FAXaMNsugHx8EITmY6UFSRqPuysmd/52SOtCFE0J46uJsiE8dOu28RvXv2St2P30BQf5pPCpxP+YURe7UMSESZiBlPeconojNng1Hj3GgVuHgyE2nAjLTgD82ZWTiJQwcDJg6aEFn057hRIoc7NQ1/LS1B0J9tzx6+lF2KWaGXPQbeOZaXkPg4z9/wV4KsqAAsJ//O2A==
X-YMail-OSG: 3ArfUIoVM1mv10sYvxRuwyoWXf3d5tZlNfjE2CF8OPTxWnQUSFB0z0DYILor5Mi
 cUj4ON1.jJ4vqMwQAMtzz68wJdh6pitLChlxgXoTiqJntfJ9PIeslYOqUC1LW.Oi8upZmr4QJG33
 hLJ4Cpn1AHFi237pCty9rLBHAKl4GIInAbh5P1dtn1ZYj3Dm7op32OPiRVKlEzH8v.apWRsS2.Mt
 V70xNjKnuGDVDUJHRnyzLzLMqp6SQZj4l37Bzjw7k0hTxSzRg0fMDRouGzdslReg4MSFcmkZoOWX
 UWO_aV_e.hI7dqGIfhQ3YeAW61wHi5c26vEjSO_.dLeSe8h6npC5z.2_ri5ZQs5_1PWyzA0Y8dkH
 qJFoeHmDH_A4IZD92k_oosXJ14_vJa9rlI478orDiQSJfmGRw3844b_hO5yjDv8Dj7oYAfcUiYij
 dVakqF1YSrO8RRwiM1ZbbD_vfy4GeBatbJpom6IAwO_ZePzJfr6VuZ6iLt_dkSEtjjFmWqjzJGfx
 9CbMmzXQbhX3LpwmZ61nyEHFKJvW0LQ6thHiKC4u_JdH_YaDUvUxrcsgthR9kXpJkBEb.C7u6TOj
 88jck8_J06gOfweTAX.naQbJIMhKemmt.oe_y5WwQgU0peaGDNuT4jD3NJIA3rAeFjh3DCNio4FE
 AavFhrihgSdaJtLg2eLp1QKF0s.rMHyPLQIyD7aJ4tqCnWRZvbhjq_fCRWV50zX5a630t9uYY6vk
 kKbRDyfDZT_oNE42KViH0UKGUqs9UBwGrLHTp5E9MBF5nRiqO8toM9L5_eqbYSOtuI1gQodSYUgV
 ew76tQ3p2EIdT8LEHKHokC205IAbIMWkPhc8eeensNZv_9280Ijw_xSXb2W6cYu69_W50Cyy0r6o
 p981JHnTneIVak5cMFGcyAcJhRc4GyyogLR5EjiwTKTxPRTnaJr044nLdMif0XEeZx8IGoG6LdDL
 S66UrmLUbV0WpB.GT1zkaZll.AuzpM_D_quyfQ7.KJNQBxWmHjw.jjl8pQhtaUuEAM58ad..H3zF
 5b2NOi9IAbWT4eQWlbfyMEQEHwBkbIyywAUmRXrX95R2kMIJIeUr5Q7aVOdnCEjXI_RUjMm7WGdT
 Q7oQf1bWutI7Eh2fQPGH28WTMcA5Fib1dTQWQp8oOTj1ZWGXq3n79dD2FwoatMvPMtuPtluvUCYB
 AvXzikQ0O18xgf9UVyruq1Kpix42zehxK7bKu1aC5dBN5gM.yiTTJXkiewqEFC.NPmgeUWFOHcGK
 EuRfjRH7zv6uv85ZdsX9v7sefX.mPXxs4yWU4fC9BC8bxxm4YnC5YDdL483WRBExcoq4LvH2dbw6
 fGRNSSADZ8zFQ0jIPR04kuzj4ijwxBIraxNKn6ZzJ5FhqsSs4snPmTd9xUvdHAn50g.duawp.JzY
 HZL3zLEF3BfMNpp_QPSvLTilq33vgjoSJKqOEPvDA.9MRjXpKtLU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 Nov 2019 21:38:36 +0000
Received: by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 72ca864344900cd3d0f08cb3c371d2b9;
          Wed, 27 Nov 2019 21:38:29 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Subject: [v11-ima PATCH 22/25] Audit: Include object data for all security modules
Date:   Wed, 27 Nov 2019 13:37:15 -0800
Message-Id: <20191127213718.18267-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127213718.18267-1-casey@schaufler-ca.com>
References: <20191127213718.18267-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When there is more than one context displaying security
module extend what goes into the audit record by supplimenting
the "obj=" with an "obj_<lsm>=" for each such security
module.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.h   |   4 +-
 kernel/auditsc.c | 110 ++++++++++++++++++++++++-----------------------
 2 files changed, 58 insertions(+), 56 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index af9bc09e656c..c9f1e1641542 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -78,7 +78,7 @@ struct audit_names {
 	kuid_t			uid;
 	kgid_t			gid;
 	dev_t			rdev;
-	u32			osid;
+	struct lsmblob		oblob;
 	struct audit_cap_data	fcap;
 	unsigned int		fcap_ver;
 	unsigned char		type;		/* record type */
@@ -152,7 +152,7 @@ struct audit_context {
 			kuid_t			uid;
 			kgid_t			gid;
 			umode_t			mode;
-			u32			osid;
+			struct lsmblob		oblob;
 			int			has_perm;
 			uid_t			perm_uid;
 			gid_t			perm_gid;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index e0dd643e9b13..0c071947c2b3 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -659,17 +659,15 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
-					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
-								&blob,
+								&name->oblob,
 								f->type,
 								f->op,
 								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						lsmblob_init(&blob, n->osid);
 						if (security_audit_rule_match(
-								&blob,
+								&n->oblob,
 								f->type,
 								f->op,
 								f->lsm_rule)) {
@@ -681,8 +679,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				lsmblob_init(&blob, ctx->ipc.osid);
-				if (security_audit_rule_match(&blob,
+				if (security_audit_rule_match(&ctx->ipc.oblob,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
@@ -956,13 +953,57 @@ static inline void audit_free_context(struct audit_context *context)
 	kfree(context);
 }
 
+static int audit_log_object_context(struct audit_buffer *ab,
+				    struct lsmblob *blob)
+{
+	struct lsmcontext context;
+	const char *lsm;
+	int i;
+
+	/*
+	 * None of the installed modules have object labels.
+	 */
+	if (security_lsm_slot_name(0) == NULL)
+		return 0;
+
+	if (blob->secid[0] != 0) {
+		if (security_secid_to_secctx(blob, &context, 0)) {
+			audit_log_format(ab, " obj=?");
+			return 1;
+		}
+		audit_log_format(ab, " obj=%s", context.context);
+		security_release_secctx(&context);
+	}
+
+	/*
+	 * Don't do anything more unless there is more than one LSM
+	 * with a security context to report.
+	 */
+	if (security_lsm_slot_name(1) == NULL)
+		return 0;
+
+	for (i = 0; i < LSMBLOB_ENTRIES; i++) {
+		lsm = security_lsm_slot_name(i);
+		if (lsm == NULL)
+			break;
+		if (blob->secid[i] == 0)
+			continue;
+		if (security_secid_to_secctx(blob, &context, i)) {
+			audit_log_format(ab, " obj_%s=?", lsm);
+			continue;
+		}
+		audit_log_format(ab, " obj_%s=%s", lsm, context.context);
+		security_release_secctx(&context);
+	}
+	return 0;
+}
+
 static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 kuid_t auid, kuid_t uid,
 				 unsigned int sessionid,
 				 struct lsmblob *blob, char *comm)
 {
 	struct audit_buffer *ab;
-	struct lsmcontext lsmctx;
 	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
@@ -972,15 +1013,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
-	if (lsmblob_is_set(blob)) {
-		if (security_secid_to_secctx(blob, &lsmctx, LSMBLOB_FIRST)) {
-			audit_log_format(ab, " obj=(none)");
-			rc = 1;
-		} else {
-			audit_log_format(ab, " obj=%s", lsmctx.context);
-			security_release_secctx(&lsmctx);
-		}
-	}
+	rc = audit_log_object_context(ab, blob);
 	audit_log_format(ab, " ocomm=");
 	audit_log_untrustedstring(ab, comm);
 	audit_log_end(ab);
@@ -1207,26 +1240,14 @@ static void show_special(struct audit_context *context, int *call_panic)
 				context->socketcall.args[i]);
 		break; }
 	case AUDIT_IPC: {
-		u32 osid = context->ipc.osid;
+		struct lsmblob *oblob = & context->ipc.oblob;
 
 		audit_log_format(ab, "ouid=%u ogid=%u mode=%#ho",
 				 from_kuid(&init_user_ns, context->ipc.uid),
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
-		if (osid) {
-			struct lsmcontext lsmcxt;
-			struct lsmblob blob;
-
-			lsmblob_init(&blob, osid);
-			if (security_secid_to_secctx(&blob, &lsmcxt,
-						     LSMBLOB_FIRST)) {
-				audit_log_format(ab, " osid=%u", osid);
-				*call_panic = 1;
-			} else {
-				audit_log_format(ab, " obj=%s", lsmcxt.context);
-				security_release_secctx(&lsmcxt);
-			}
-		}
+		if (audit_log_object_context(ab, oblob))
+			*call_panic = 1;
 		if (context->ipc.has_perm) {
 			audit_log_end(ab);
 			ab = audit_log_start(context, GFP_KERNEL,
@@ -1366,20 +1387,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (n->osid != 0) {
-		struct lsmblob blob;
-		struct lsmcontext lsmctx;
-
-		lsmblob_init(&blob, n->osid);
-		if (security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_FIRST)) {
-			audit_log_format(ab, " osid=%u", n->osid);
-			if (call_panic)
-				*call_panic = 2;
-		} else {
-			audit_log_format(ab, " obj=%s", lsmctx.context);
-			security_release_secctx(&lsmctx);
-		}
-	}
+	if (audit_log_object_context(ab, &n->oblob) && call_panic)
+		*call_panic = 2;
 
 	/* log the audit_names record type */
 	switch (n->type) {
@@ -1929,17 +1938,13 @@ static void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
 			     struct inode *inode, unsigned int flags)
 {
-	struct lsmblob blob;
-
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &blob);
-	/* scaffolding until osid is updated */
-	name->osid = blob.secid[0];
+	security_inode_getsecid(inode, &name->oblob);
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
@@ -2285,14 +2290,11 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
-	struct lsmblob blob;
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &blob);
-	/* scaffolding on the [0] - change "osid" to a lsmblob */
-	context->ipc.osid = blob.secid[0];
+	security_ipc_getsecid(ipcp, &context->ipc.oblob);
 	context->type = AUDIT_IPC;
 }
 
-- 
2.20.1

