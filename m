Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A371455DED2
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jun 2022 15:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242852AbiF1BFu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jun 2022 21:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbiF1BFn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jun 2022 21:05:43 -0400
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BDCFEE
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jun 2022 18:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378341; bh=aUnTdpDgNfpHhclDAMeUWOwCLH0k3UygXUV58NHvsUA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=d017HsEMpayT3UqPUWaBrQz77Al/hEdlU0DiMBSaUsQPJA/jIdIkSdDGN8FIClyrjpSs4F4JmPVmzClgpDbjBV2v+8JBAR0gU+ddlINZKb4MVZgq83KB+f78t0v9U+0hoWsy9o5mU/BUgWbe88LS7Vz0fLrslQML6dr8ze3I5ex+B67jhD4cWM8XMRsBX8SS27sOgC3H86Fq+6sInrpuG3TnzDIeq2N18JmQYvJy5tVEk/IwHQPE66Di0Wutny7QVtV1rWyM5g+yrzq1zhCkBAE4BgRf22039pCIi1vN4ozmh+MQVKi4ZfA+p4I7Ed6835XiOCmsN1cUZabm0YBIMA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378341; bh=RCdaXJyOUa70W4/U9RPtLhEXmHwN2j2js3Byb72Y3Id=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=EETdhhvYX50iIOnmOsiq2zhEafTHzYOPY013ugpB+b3CGIH4OFp2c2V0rKLEKZQDgw2gjK2eFQZGEnT6NhI5XsA7VXxmxiDgoO9zgaDBpM7oJzQchpyaiGXtx/VyUJUYGi3a2rok08RsHyfeYFwlCqit7AF/Ab1rI+VU1jm3nfmXwHi02pNvob3lYPRAjX28Jr07imBxF9dn02l8/Vgedm4QJfB+7inWrStIAPqUWC/MKC7698v2/uNtykMZ/Fw53yZxAtB1t4gDuSJxs21xRUdySJm3E+Ek0OY/vzsZzmduvMo45mgC3mZH6HEy8qEn3+AAvcwtETVmyy5w4NqU8Q==
X-YMail-OSG: 0auG2OoVM1mqB9wdPVaRUoL0NiS3TajwBV.yATIAeenCY6h7vKdAfzyXOcElPx4
 DufDh371j2U_wivoReF2zrc0RGVn._3QOXq3apu7ogqLKOOaJbv0di9xbcSD23VDjSDAPt2x3XXb
 XSaERb1AVr2tst0t7QQXxrG6ZjAlP_mQ6uPfFWLK2nU87IMfDlr2ySU0L7swKCPvnsTKEBIK_MMQ
 f8HvOx9khGcTW.iTrszE_dgE6H6glXcjdUJLWaUizS_NSctzb9hOMOHLkuG25JCGRUcQmRbXYXW2
 QOy.wsd4tsWVvn1Ylbg4vp_Z7q4O_AGPBpv8gPT1G6DpSg0hwBwkSCUiGAQFrc6HLCEmB9ou5Zzf
 Qj6XSCHot5sdN5C7qH0UnqFMPbMI8dj5cRcIYjFhd__Uu86C7oJN_5AmUtL_ANbozTu5phY8O2km
 xYAh7tXuRHs7qZ57wcUSWEjSmq9ZF4zcZkfHwNVYNkWDbg1Xdb0vloWahCLkztCkSc9XOdUSVc9n
 DK.ajCm02.L9X62VSb1vJeVOEsYNbRwf3oh9mEwIngE_AWiU5a1.wDWjD0_D91U.jcZxkYKF50q1
 rFy2OZmvi6mIgZ42YBvMj5hXqz6XrB22Re1VMZFRFoWTzn2xRkLMiH0quPL6G8dA6gx50oO7GimQ
 1RtVBYpg26sKjYEQmNgRDMNwPFJyLU8w4CVdXZHoIfLEEp1siI5M35PQuMCJ6NYODi7VNgDQsKWo
 XuHx.bXPePYo9NV3T3nVgAu0_kd7SH.Q7M_kixKuTL4Gwgd8pYLsCgBgnWMTBvUnp4ZBgShCBY60
 fBjmwYxJIJ.DBq1FWjhN5cW5RQnw01sBc6I1iCCOij2BVk3_nXb8g7gUwBuo.ZqGbFKENQq4J8EW
 nWNHbz0nkGXfQZS_G.dS5jj5meGEKyWJyS2v8ZoENegVHt9pmvBGgxUS83daHeRWy989uZYpXlQn
 KtRH3c86cK1vDlWzoBntwp9qUK1oftqrbGSmzEpK1GT4Z2eIztCKSEl7vQc33ZigrnPKq._3jK3S
 D6zNjDL5_P4BarFl479mZvCOmzU8FfH4HCuhpIy1tMXNPvOVvEtU9YMxt11tm_NMNUIn01._WhuU
 hN4nGUPhkK7I7SRGe5d1lkEG9QFafTp4wlbdPiu_J_kMT2Ds0NLVEIRbrNH2YoMIEB_8k_8eVDCe
 pdwKaN4_7rufxHfna.i9orPVEpld9LZmzi4BS_261mjUFnCF860nniAuP65LT4VejPxX4LqoAujV
 znSa.OmVH4RMJnzsKAiJfhkL3kpUjWVKabfCU.DXI5qiN839sgX1U1c.c7iqffBDR0IN9FPx20RM
 H34yNUEYJi1XI9qhfYkrlxnqjp3Xa8chdIg3SsnEd6Rt7KMdo9fefq.oxMGfClA57fmH_yEQO0Tj
 MDktYQwUuQQK2bvt5T7BOGwX1NqtBCs47atS_5BsjoyTjWpm9DIvArN7CsTmllSDKmNbtb5U_d2g
 jXtkg3LHVQ6jNoUt3DQeOiFqSLIx_lVHCnYI.6hLeMWxio926RpQX7.XUHSUS5ngs8I83f3HuI97
 rcw0BosTKlCt9swzl_eSwAtB3OQb5vxQvv.Iq6t6JFdwzWugDjiVf.dH5_7.6Nx37Lw4b4A7gN3_
 LjUIukVgQMfig2siMkyMuLWOD4QMB5TyNKBByKBH6H0hSPPkxCsDU.__Qw4IRGxFzhjHndOk9F.d
 y.APN6jlcPKQt7yZAMsehwF7f50Z7kIr8J.m.GlvD9WymQY0Oadwpq35ZMbO2uAxKjoaRObW0F2j
 WDhjTt3Scymbbf5..MaBzDvoKw13.MjwMZmWx1WQ2LlJX3OE29gd_0PwZZiHKFUZt6CmWTcRj0_W
 AGY1B.P7dlzcH9xmSrxFbp6p0OT0lBUePqfpL2d6sabbfqcNDsO4zd48mveiLvAdYX3uVfvAVV.V
 .0zhQkiml8647A2RoQlo_tQ08W8LMcnnlx_X.4kaMXxHbLKrVnZtIXCKtbrxdbg4.KBtUsVMEbs3
 uIjt2ej84M3uDMehTC0aGNLP3WiICT26Xc8V1AYS3ieMvJisT8THD.SwtUZGU_48PsYEgA6VQq92
 OvD1jZHz5.kGVZenVOZVKt8V5HI97yI46kWrtqXrP9YiLFjPxsOWZUILQYO8wv4LwM8HFEK6.eQX
 dhP3FDpgObqo98ElXdZW6h31QnyLUCG7yi0c2gsQGq0U_Y3D86x623ieF8TfBzWXoO9XXefOJxmN
 AO6ee1rWPMvMQdaVpGNAjwXgiknsOaor0UV8iv.Puh1bgM7gNP37OX.dIQLDvgbEXnmrkebTMH4_
 4Q5lGX0_bWGjcseyUBQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:05:41 +0000
Received: by hermes--canary-production-gq1-677bd878b7-pqb8m (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e262426b02cfbecf0124eb7a5c5aa81b;
          Tue, 28 Jun 2022 01:05:36 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v37 13/33] LSM: Use lsmblob in security_cred_getsecid
Date:   Mon, 27 Jun 2022 17:55:51 -0700
Message-Id: <20220628005611.13106-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628005611.13106-1-casey@schaufler-ca.com>
References: <20220628005611.13106-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Change the security_cred_getsecid() interface to fill in a
lsmblob instead of a u32 secid. The associated data elements
in the audit sub-system are changed from a secid to a lsmblob
to accommodate multiple possible LSM audit users.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-audit@redhat.com
---
 drivers/android/binder.c          | 12 +----------
 include/linux/security.h          |  7 ++++---
 kernel/audit.c                    | 25 +++++++----------------
 kernel/audit.h                    |  3 ++-
 kernel/auditsc.c                  | 33 +++++++++++--------------------
 security/integrity/ima/ima_main.c |  5 ++---
 security/security.c               | 12 ++++++++---
 7 files changed, 37 insertions(+), 60 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index f25a867063e5..c2f71c22a90e 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3056,18 +3056,8 @@ static void binder_transaction(struct binder_proc *proc,
 	if (target_node && target_node->txn_security_ctx) {
 		struct lsmblob blob;
 		size_t added_size;
-		u32 secid;
 
-		security_cred_getsecid(proc->cred, &secid);
-		/*
-		 * Later in this patch set security_cred_getsecid() will
-		 * provide a lsmblob instead of a secid. lsmblob_init
-		 * is used to ensure that all the secids in the lsmblob
-		 * get the value returned from security_cred_getsecid(),
-		 * which means that the one expected by
-		 * security_secid_to_secctx() will be set.
-		 */
-		lsmblob_init(&blob, secid);
+		security_cred_getsecid(proc->cred, &blob);
 		ret = security_secid_to_secctx(&blob, &secctx, &secctx_sz);
 		if (ret) {
 			binder_txn_error("%d:%d failed to get security context\n",
diff --git a/include/linux/security.h b/include/linux/security.h
index a478faa6124e..61d5f23103b1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -503,7 +503,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
 void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
-void security_cred_getsecid(const struct cred *c, u32 *secid);
+void security_cred_getsecid(const struct cred *c, struct lsmblob *blob);
 int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
@@ -1143,9 +1143,10 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline void security_cred_getsecid(const struct cred *c, u32 *secid)
+static inline void security_cred_getsecid(const struct cred *c,
+					  struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_kernel_act_as(struct cred *cred,
diff --git a/kernel/audit.c b/kernel/audit.c
index 2834e55844db..f67f1eb7f4fa 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -125,7 +125,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
 /* The identity of the user shutting down the audit system. */
 static kuid_t		audit_sig_uid = INVALID_UID;
 static pid_t		audit_sig_pid = -1;
-static u32		audit_sig_sid;
+static struct lsmblob	audit_sig_lsm;
 
 /* Records can be lost in several ways:
    0) [suppressed in audit_alloc]
@@ -1463,29 +1463,21 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	}
 	case AUDIT_SIGNAL_INFO:
 		len = 0;
-		if (audit_sig_sid) {
-			struct lsmblob blob;
-
-			/*
-			 * lsmblob_init sets all values in the lsmblob
-			 * to audit_sig_sid. This is temporary until
-			 * audit_sig_sid is converted to a lsmblob, which
-			 * happens later in this patch set.
-			 */
-			lsmblob_init(&blob, audit_sig_sid);
-			err = security_secid_to_secctx(&blob, &ctx, &len);
+		if (lsmblob_is_set(&audit_sig_lsm)) {
+			err = security_secid_to_secctx(&audit_sig_lsm, &ctx,
+						       &len);
 			if (err)
 				return err;
 		}
 		sig_data = kmalloc(struct_size(sig_data, ctx, len), GFP_KERNEL);
 		if (!sig_data) {
-			if (audit_sig_sid)
+			if (lsmblob_is_set(&audit_sig_lsm))
 				security_release_secctx(ctx, len);
 			return -ENOMEM;
 		}
 		sig_data->uid = from_kuid(&init_user_ns, audit_sig_uid);
 		sig_data->pid = audit_sig_pid;
-		if (audit_sig_sid) {
+		if (lsmblob_is_set(&audit_sig_lsm)) {
 			memcpy(sig_data->ctx, ctx, len);
 			security_release_secctx(ctx, len);
 		}
@@ -2392,7 +2384,6 @@ int audit_set_loginuid(kuid_t loginuid)
 int audit_signal_info(int sig, struct task_struct *t)
 {
 	kuid_t uid = current_uid(), auid;
-	struct lsmblob blob;
 
 	if (auditd_test_task(t) &&
 	    (sig == SIGTERM || sig == SIGHUP ||
@@ -2403,9 +2394,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		security_current_getsecid_subj(&blob);
-		/* scaffolding until audit_sig_sid is converted */
-		audit_sig_sid = lsmblob_first(&blob);
+		security_current_getsecid_subj(&audit_sig_lsm);
 	}
 
 	return audit_signal_info_syscall(t);
diff --git a/kernel/audit.h b/kernel/audit.h
index 58b66543b4d5..316fac62d5f7 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/audit.h>
 #include <linux/skbuff.h>
+#include <linux/security.h>
 #include <uapi/linux/mqueue.h>
 #include <linux/tty.h>
 #include <uapi/linux/openat2.h> // struct open_how
@@ -143,7 +144,7 @@ struct audit_context {
 	kuid_t		    target_auid;
 	kuid_t		    target_uid;
 	unsigned int	    target_sessionid;
-	u32		    target_sid;
+	struct lsmblob	    target_lsm;
 	char		    target_comm[TASK_COMM_LEN];
 
 	struct audit_tree_refs *trees, *first_trees;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 1d223176285b..fa3cfe569ce2 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -99,7 +99,7 @@ struct audit_aux_data_pids {
 	kuid_t			target_auid[AUDIT_AUX_PIDS];
 	kuid_t			target_uid[AUDIT_AUX_PIDS];
 	unsigned int		target_sessionid[AUDIT_AUX_PIDS];
-	u32			target_sid[AUDIT_AUX_PIDS];
+	struct lsmblob		target_lsm[AUDIT_AUX_PIDS];
 	char 			target_comm[AUDIT_AUX_PIDS][TASK_COMM_LEN];
 	int			pid_count;
 };
@@ -1018,7 +1018,7 @@ static void audit_reset_context(struct audit_context *ctx)
 	ctx->target_pid = 0;
 	ctx->target_auid = ctx->target_uid = KUIDT_INIT(0);
 	ctx->target_sessionid = 0;
-	ctx->target_sid = 0;
+	lsmblob_init(&ctx->target_lsm, 0);
 	ctx->target_comm[0] = '\0';
 	unroll_tree_refs(ctx, NULL, 0);
 	WARN_ON(!list_empty(&ctx->killed_trees));
@@ -1116,14 +1116,14 @@ static inline void audit_free_context(struct audit_context *context)
 }
 
 static int audit_log_pid_context(struct audit_context *context, pid_t pid,
-				 kuid_t auid, kuid_t uid, unsigned int sessionid,
-				 u32 sid, char *comm)
+				 kuid_t auid, kuid_t uid,
+				 unsigned int sessionid,
+				 struct lsmblob *blob, char *comm)
 {
 	struct audit_buffer *ab;
 	char *ctx = NULL;
 	u32 len;
 	int rc = 0;
-	struct lsmblob blob;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
 	if (!ab)
@@ -1132,9 +1132,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
-	if (sid) {
-		lsmblob_init(&blob, sid);
-		if (security_secid_to_secctx(&blob, &ctx, &len)) {
+	if (lsmblob_is_set(blob)) {
+		if (security_secid_to_secctx(blob, &ctx, &len)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1814,7 +1813,7 @@ static void audit_log_exit(void)
 						  axs->target_auid[i],
 						  axs->target_uid[i],
 						  axs->target_sessionid[i],
-						  axs->target_sid[i],
+						  &axs->target_lsm[i],
 						  axs->target_comm[i]))
 				call_panic = 1;
 	}
@@ -1823,7 +1822,7 @@ static void audit_log_exit(void)
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  context->target_sid, context->target_comm))
+				  &context->target_lsm, context->target_comm))
 			call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
@@ -2765,15 +2764,12 @@ int __audit_sockaddr(int len, void *a)
 void __audit_ptrace(struct task_struct *t)
 {
 	struct audit_context *context = audit_context();
-	struct lsmblob blob;
 
 	context->target_pid = task_tgid_nr(t);
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
-	security_task_getsecid_obj(t, &blob);
-	/* scaffolding - until target_sid is converted */
-	context->target_sid = lsmblob_first(&blob);
+	security_task_getsecid_obj(t, &context->target_lsm);
 	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
 }
 
@@ -2789,7 +2785,6 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
-	struct lsmblob blob;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2801,9 +2796,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getsecid_obj(t, &blob);
-		/* scaffolding until target_sid is converted */
-		ctx->target_sid = lsmblob_first(&blob);
+		security_task_getsecid_obj(t, &ctx->target_lsm);
 		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
@@ -2824,9 +2817,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
-	security_task_getsecid_obj(t, &blob);
-	/* scaffolding until target_sid is converted */
-	axp->target_sid[axp->pid_count] = lsmblob_first(&blob);
+	security_task_getsecid_obj(t, &axp->target_lsm[axp->pid_count]);
 	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5d6029ac52f0..ecaa0b96bb26 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -488,7 +488,6 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
-	u32 secid;
 	struct lsmblob blob;
 
 	security_current_getsecid_subj(&blob);
@@ -497,8 +496,8 @@ int ima_bprm_check(struct linux_binprm *bprm)
 	if (ret)
 		return ret;
 
-	security_cred_getsecid(bprm->cred, &secid);
-	return process_measurement(bprm->file, bprm->cred, secid, NULL, 0,
+	security_cred_getsecid(bprm->cred, &blob);
+	return process_measurement(bprm->file, bprm->cred, &blob, NULL, 0,
 				   MAY_EXEC, CREDS_CHECK);
 }
 
diff --git a/security/security.c b/security/security.c
index ad1080e01ba8..6df37398cfd8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1810,10 +1810,16 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
 	call_void_hook(cred_transfer, new, old);
 }
 
-void security_cred_getsecid(const struct cred *c, u32 *secid)
+void security_cred_getsecid(const struct cred *c, struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(cred_getsecid, c, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.cred_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.cred_getsecid(c, &blob->secid[hp->lsmid->slot]);
+	}
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-- 
2.36.1

