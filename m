Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384DF5457F3
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jun 2022 01:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiFIXIe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jun 2022 19:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345902AbiFIXIc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jun 2022 19:08:32 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A3627FC5
        for <linux-integrity@vger.kernel.org>; Thu,  9 Jun 2022 16:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816109; bh=11nX3+bjsQCrKDSQyT3f/+AsP8uF2MtdhVcpcGXGytE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Ic7mXe/u8uneaKOUvV5GXsQyfavhvU/tRsm4bMAzZ4LtAXwkF1304PWLDb7sTl7ooe7KW1A9RetE1JLH6YIdZ09AiLnEQQ2ovYfLfKx8E3XHA2fXTnzokGDvqLMpNzhJMJH3pRmp8xS3ZBvTxVUIrADIYdCiBe5ampetGxbROsGA1Ds7Zp9DmLu6C89htcV14mVO60V0PTEaF9NPlUHx+EhIBw75QKU+4ZOI3y1hDRKX9HvAFbIB0oSQoMJ97OmAbvxHlORREVP4jmKKYtAmcNtSbQxpnwp7b84t/XTEVk/w4kTWBgevzLID88SFYMzUD/GJ7733R5fs2cUhcl5EvQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816109; bh=/JWDOPx7f4ru/maHxzBAOxmGr8CuzHtiM058CYNvzIo=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=jgUsnTC0eoocU3l/cbIlXZ/WX9T64fpJeJeUNiafDUypn9OqYW4ePg7WMFkYQPsOUdefN1U/RkPlhdKV85Y1HJiQxwsy7P6o1kK1eJx4U2XefC8gZ+wOD8qlHFYNGKx120LzmmTERHNQQJJXh6jj4Dp9OQ4et7OlV0kh06zfsB0Swmrged/S46Ps9pPgX2Jq+AD1uHxTSXny6FBcrNTFrhu938dj9zbeyimZ7DngPYhqqeRk7Jta1ZqmTJc1MLawwUfBXQR0p2+l+W0R+6hbFZ9ZNaf6B/qOhMcOhtd2q9b/R4jSSe/ZzicP2qn9ptOXQ8q7PB0Ru6AW3yW9MKg/Cg==
X-YMail-OSG: HjYCsC4VM1ml6wdNSSdKe.epHhaY_SLgoUkKeZJ8WWkh8M.C5zLJ9H3DMoSFZFW
 0c0cbvtt0Hzc0T..Sz8oGaRpt00vW2dU2jAWG_UhSDUfdtjKz50IqvgEqdP4pmHPNy8Z2RM4afjK
 gEUe_wgjZRbC.O9EiLhJhASdWVrg4LHbjz6JYcFDFsZW.DESoL_xqIVXCEeuN4aDguYkMfCsQ0J8
 YZiag8Y_q_mDLqSTl8ea.Va7SJ_VMQCWkb4k6MjzCbQRFbIZpnklSA9GY85Ve_o3eRy6BJTKjDOI
 GeEcwh4zE1v7MDim0H3g6PpQ0KVtKINgWyYJGEmmXlFJ2lL0j9N9vgEIxgZ_UkKe1DXCTQKwM1mF
 1jI2l6lQG2SenlRpR3ZrHequx7Cj78vTbVXYCwJyHTcu_Phmp4NVoMVzNtgSwoe27Va.xeQqdZxz
 oQf0Fw4I0T8jBxIAIsx29Lri4MaCG82vXnZc6QOmVbZBbbDo9jHyMcwzrPG75YnVkmF8XwjcQt3U
 PHqGoyt9CZ4OeiWjwbjv.vXJPqmx.MeZR.nX_eVP53Ytj4dbTa2obR684ip4V_hRE5ptkVFn2KjW
 rJARSKwYfyy9wENfRBwBVSFiDFhydQbX8mZEM_irnATTKlTdixIquzsFvJDv6CcKERNkOHRNC3OQ
 JYaOGj8WEPRcoyGCEjHWKmmrt7WCP8h3eligPiPymiDnugu05kMAV_DkFF2vPjVDyePA5WX3bXmE
 z1atRofQQvkK2IGXMm6jQ6HXoPSMMt.F54PBGP7dJ6_oRbhAIVM_rgilQKq99ycMyw7CCfexeW8F
 lK_m8Yj5jgklSQ6hsUDw2bsFeGIpRnAEVTsPsZHy9rfTXHQpPpUERcZDGcHKNuJcdgaNqxT45SRI
 Z.zKa9Gqma8n1Kco5mRm6mKp5fVln21keJumleE2.jDgl5X0FEV2NECfRSyisG5oaQ1KYq40BQ5G
 F.x3EW4AnK.WNJDqatrFl8EoLTNa3wVoKXuPZydTG3JwwFbvkKwzgSgsN1WS8lsrKPoF_f0uIiuR
 PmQCjlNarViszo1cAqjUmSrpY4l6z4S7CBCL_9VbasJzUZayMokA9AHwu6jsiV3rEyNzKzA1Mm1H
 LLLN0nV.yCYIohfhXIsNdItgDhKAhXL7gU9mdgMY6kpboLAigFkKF3oUk4a0hfsMJlw93GFT.87o
 _OKbeIMSjiTpM5q3WsngOrsONC3lCdq_0k66TKIoPSpDGXJHQ5efq3UVq1nCeZa9l30jOB5_7ig1
 GjvLFeezN.TUaT3hHg5bwKexzh11SgNmt7gnSLhqUY3hn2hZc92k_tgByVDR1Mkf3BhshOTuPYCn
 BD8JlLBva2UUOOvg0PVtiTRpqQ7BcZUWDtbGi7jS9pfA_jnbOekL9PjME6zBOVnNrB_9R.FE790I
 q2zG22XMA7.Cygro3f33qq5tpSnKoD0zYzSyai72_EymEMgGXAIK2CDZf0MK4d2wPwqQIX2zhRAf
 NxvdJUCP7qRNro763n.A_yDul.TkbXfYiGtZMbWOdkWMAaqOxFc3c8jiW62khcBp7uBs_TZ2fKdf
 7_crv9N.5pvKLuwlbXrXk6X9XTQ66TrQOFQmsXtl9dktuSnE0jpdR9dxPQeLgzQquh0t7RoRhvq_
 X1UP0ao4uN40EsUhMgzdYWENn3iv27VPK1XeF2iRO060KOjaEA3G0OIgcE_7V7dQvNjjJQ0G3Vdd
 6Ti.mQk6mxODHmahq0iPBvJOa_fCFICqEz5UX7.GEN2csxs3_JcKwILsoqqVhfKpiV3_1ACU14Rw
 _qOXZzfAyr5RgQ2wW3zdiizRB10wCLg14jwMn7exMqwBGUTfhRXTyOUNN7w6UfpxExHNUnC6sKsl
 6CyUWwryf_d6jompNuaVXUrhkZTzCDUnEBTlSs4XBAMBptZjdg86qb4MfWFhCzJfIvj3PHPU3_zJ
 AfXqoo.T5TgiiQSm4XqiTWA5Plf6XaUIKRcTsWJ4dEF8vdgTywOBkHuKFM1evcbr_qt06IApKeSq
 9cO_m.iCnAXZ9n0vvIqj7IlHLwdnOYzAHgmeL0u7_f0CBQRZyFb8iyaZtEVN0K6uit2lxW790NmI
 I0z5Cah3lRIXRgtmjefzpX6yvuQK9oShVnc4Z7rBSzG.lgXkpouFPSznUMbH15MtiXOFeSEoykbX
 83Ka_oXBg0uPoAPA7kfgaDiu26O4xNpV9Z4UTlAKV3rOZwOuz4k7dS4IpfRF_mJ9U5e9mEBnnVtk
 NUUWqsp.I0O1AocVC0oVGcY4TCJK7AvpjlveFyftEW_V_LmzYIRYM.jB0lOYGa_N.gswxLQSnlb6
 heIfKwgwNXLRd5tcY6qMzqjp0LT28
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:08:29 +0000
Received: by hermes--canary-production-gq1-54945cc758-dgl4g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 81d1362bb2f9321f75335da17974ee85;
          Thu, 09 Jun 2022 23:08:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v36 13/33] LSM: Use lsmblob in security_cred_getsecid
Date:   Thu,  9 Jun 2022 16:01:26 -0700
Message-Id: <20220609230146.319210-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609230146.319210-1-casey@schaufler-ca.com>
References: <20220609230146.319210-1-casey@schaufler-ca.com>
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
index 2834e55844db..2b670ac129be 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -125,7 +125,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
 /* The identity of the user shutting down the audit system. */
 static kuid_t		audit_sig_uid = INVALID_UID;
 static pid_t		audit_sig_pid = -1;
-static u32		audit_sig_sid;
+struct lsmblob		audit_sig_lsm;
 
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
index 2d1dd5af8a00..030f6e84026e 100644
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
2.35.1

