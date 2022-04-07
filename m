Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1082E4F8972
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Apr 2022 00:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiDGVbZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Apr 2022 17:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiDGVbW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Apr 2022 17:31:22 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE831A592D
        for <linux-integrity@vger.kernel.org>; Thu,  7 Apr 2022 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649366958; bh=aMpe5IBXKVs52J+BeZDj/JSO/Nm2DAXFZfK3V8Fxhf0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=nWFQCaSHp4QJpucpDanyhPm1CbAuEd4mo3srwQtZ8Sb5XVZSyKG1TWHd1owcVyze7cD4P/pea/lwNbWC+zmvQjHhibSJgkfa0BEz2t6+VDqYs2NyarfOfEHr7OmOUfsgaAw3v6YbSNik+bLhpADNKfHQiS5K01YJW/0/qHmD2uzUf84aR2IwqAq6iXrXQRSeoeEMuccqRhXsrx7HUvziSYsaCU77cQWwG4bYcA7lPag6OhQgUDcBClkW8mA80zAXdDo3Qh+kF5FIKJthMXT7GrWBtZyBc0d8+ZiafIqhs746E45cjAi1DC4amXrBClZ5Eosp6woF6ekVw5XPn4WGsQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649366958; bh=MIIPcIFNzT9Vq2DyLgF+V0CNc1MNOTZmKqrm0YZBBrB=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XI3MdpxlW13GuT14T1owv/DXqgkb4szAbC+qH7wFiD1bY+eVcVs+yFd8bbmgyLwC5BhMTFwT/5bWJtAhdmmk1sGivZ2z7fBUlH6I+gkpmv+fHuAerKiao/Ie/z59fcigz7YSxvZAvRU4eRJaqG/YrPEI66l8Z/cd1KtOBdeKyRTVIq12s8oeZ6wPf/U8c2axays5zMpIiP/CW8/UMQCUog01QVeQZ5vcpwuHCd5DyfE1goDPccYpXz4DcykXcV2kCdlzJ4keGaEqFZKfD187xblov25Mxt24yOsX+UzZ4tXuO1lVIXI23nOA2K+KdfvmiR5f3zV7NOM/QSFpi80Ocw==
X-YMail-OSG: 8RFfN2IVM1kdZ_Z_.6nXz_OMb669EzyNIdj.J6uxl21mVMFuUThm8MkYN0J5K0y
 B0.3x1RL5Vo6K7tDSeN9bT6jx1D9ofywqSJ6P4ttn4FChqFNvn.sU2rMZFMYtTNdiXJnrE4HMgb2
 9JJpC0F1gtnC94.7v9aq8VpLaySd3QICD3Le15HoltHIewluO4W_O7zrwSAN9L64tZrCQH9tNpLb
 9Pp8TYqtTXYodwykulN2fDAD7yrYCLX7Vgrqs3EMxZjxNnPp7cp4bJn_M3FoIew0VImGbtL39WNu
 Ul4YFVXG6YSyzP8CEHg5HlLQlsha94u9Pb_wVUt.KDyrNqH5.tAVRYzipir29J7uV8Tnn3vAWHjv
 Q54DzEEQG_osSmk9Ff8Wd6V1sIQmGuAJxFbgCBTV3CdKzJ.NALzjWU0H49EWlEqi5nXPYTMY1rpN
 zv4r_Vmqdo7rSn9hAHofWeU7ISHJ0pZa1iEz_venq5yEMCZzz7BUU5RPSDaKmpPxc30SFaYCkVYL
 r0zRwvsL40M_Xswn_F.ChrUsfNwxbByj05m00t7iXbVogr1onLIIYr08W1fbjfvXuQDqXzg02DkL
 SMjcSNeASgtD.4Q8YwoESVhMXTClKZyFFYkQ34PKo7Smdcaj0laBKn7a.vUXZJbKK0zEUXH7mt3J
 mU6UIG_5KpnjfzIKawYDyTFNJMZL4n7CduEchngj5dV3u7tY3pqSfKqaUQ.DSyAZMY88xx7ak8v4
 SMEqZUoyK8LNvbSM5wDb.IIYfR6tU8ofmg62Hl5cAFs_HVmDUPckAJnYlQhYpF1K15NIKK5ahxGp
 Cd76QBcCaheTJeH8LUePNzRtP.bBqh0n4EwaFibqB.f8qn0RzHFVHWHl9vi5A7Ux.QfBSH4cgRx9
 1K0oEetwsE_TACERM7L20rbAmZ78RMDzjqcBQ6rxpGYyk3mQwfuNnjZFHcjEDB8qsf_B6ipTNW5m
 XUSRmuQENF8K92KHfU1oD8yg2Jj_TQLGuCJc1tlVD.eRWEEO7NIslQvcOR71Gfx_7QKfXaJb7LcH
 znDFiUEiNpigDssqwyU5kh.glLPQNhvEj_ymhBX8J1NRdYgSy2pC.IPL10npFQBbPmX_szYaQAVU
 ukZ_WgoDXprdR3lDF1fWn.xgrcp.bKpp8iVDxobY4fTSN9YZouy.FlwjhN2cBiotuu8YFWSSxXa1
 xcz_dwGdLzydzWdjaPrCKSbL4IFgm1.Wr9IngILSahiM2YHsgNMJCir1FOdZCu04RgBeuaWA4k7.
 FCmY9ekFOU.nGB1hs6OSXfWdH8Uv4DI68eGu2_9_c6djbEwmQyHgdJTiR1Uo.XPdCkcy3wJxZ88R
 yLnMpQUR9KdtpJ13EMUCaYPcqp6ilDIKa7LsSjF.ku24LzHTCUDNuspodNhUOkqqTDlxogTBnxkv
 6me_ex.Y0Z.PgzyRjdZbfrIBgDqWxXmJZ3m_JkI5xTDLxlaYAiBC.tKEjHGUCybMDTCAYN7_rCwt
 GMRvCo2tdhitWk6Lp_bro_BIpZz2SboLt3dchnpQDjx6SRS_HmIWknh5FzcOarePhZfYvNGmgudR
 qYtBovA71nAiHPOczwDpqAnCBqISqAiTWh258YckzAFXF9QcjNIwadzG_vg01oYwLOgoY5FUdOvN
 S8_Ofwvfb7t0BZmSORLd.m2kKG4_AxIOzChgE5.F3vV8GlE9P3xWt9hUZBZUXnweyTC8AFNoEugS
 7Ms1lPFugEtyuGi1o9gO_Q1DBOyUcy1Z0krJadj5z3DRHVMvdIZGsRMoD9wIQUbl9MOCA1wScdmW
 KUb3vSKbskmvEAJs9dgIz8547gjiqQVsjMfmK7n3E_GS1SYq_HDGz6HoU683CeIUDYQXRDn4EQEA
 R5Kh1n9qrWuX3ZPKd5FuUEmdzAQk84qPnW0kefsboARpaYV5Et8WdhfWOMGiJ66k1Exgcjy81viI
 H7XWzMamrEveZFAFlTEq6cE7nqKHqf5xjQrgTuuWNTJwa1hUdZRIR_nQnaaB2MkDUABWQAjpoImb
 vMym3ecIzIRSz0XsRncpR6q5sfaGeu4_1PiD2ElT2WS_n9tpV0et_S48mRJ6M1aMN_6lwVtq11Ot
 oiWVlF.FPAeiJAEfJNG3zCRfOXhd_qmmtKw_2L7KUL3U2XUNXqxxTplMyYatI7fHg4Laq8_2shOw
 tbhCVx0nljWLModi4uK0i7RvRyF5dplu5ha_Yta.PpyDH9DaabVMVDYU4xf6LUpQxhOOV3ZAGrtG
 YCYqD2VDlXTwoHFWL9zqFmaTqXKnaK2bjuYugH4W64lNyBZrLGG4mzx5Ju1iM2xDs60bJ2Iz4Kms
 pYA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Apr 2022 21:29:18 +0000
Received: by kubenode520.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5dcb49a390aaddbe04fc320d63f58082;
          Thu, 07 Apr 2022 21:29:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v34 13/29] LSM: Use lsmblob in security_cred_getsecid
Date:   Thu,  7 Apr 2022 14:22:14 -0700
Message-Id: <20220407212230.12893-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407212230.12893-1-casey@schaufler-ca.com>
References: <20220407212230.12893-1-casey@schaufler-ca.com>
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
 include/linux/security.h          |  2 +-
 kernel/audit.c                    | 25 +++++++----------------
 kernel/audit.h                    |  3 ++-
 kernel/auditsc.c                  | 33 +++++++++++--------------------
 security/integrity/ima/ima_main.c |  8 ++++----
 security/security.c               | 12 ++++++++---
 7 files changed, 36 insertions(+), 59 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index bae8440ffc73..26838061defb 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2982,18 +2982,8 @@ static void binder_transaction(struct binder_proc *proc,
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
 			return_error = BR_FAILED_REPLY;
diff --git a/include/linux/security.h b/include/linux/security.h
index 44c92e1aedf2..e36d7f35b228 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -483,7 +483,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
 void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
-void security_cred_getsecid(const struct cred *c, u32 *secid);
+void security_cred_getsecid(const struct cred *c, struct lsmblob *blob);
 int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
diff --git a/kernel/audit.c b/kernel/audit.c
index 0a7869c9c9ad..2b670ac129be 100644
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
-		audit_sig_sid = blob.secid[0];
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
index fbc0895a1a93..2b27ef99f0f6 100644
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
@@ -2759,15 +2758,12 @@ int __audit_sockaddr(int len, void *a)
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
-	context->target_sid = blob.secid[0];
+	security_task_getsecid_obj(t, &context->target_lsm);
 	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
 }
 
@@ -2783,7 +2779,6 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
-	struct lsmblob blob;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2795,9 +2790,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getsecid_obj(t, &blob);
-		/* scaffolding until target_sid is converted */
-		ctx->target_sid = blob.secid[0];
+		security_task_getsecid_obj(t, &ctx->target_lsm);
 		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
@@ -2818,9 +2811,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
-	security_task_getsecid_obj(t, &blob);
-	/* scaffolding until target_sid is converted */
-	axp->target_sid[axp->pid_count] = blob.secid[0];
+	security_task_getsecid_obj(t, &axp->target_lsm[axp->pid_count]);
 	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2d99cb996d5f..33cf3432a796 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -487,7 +487,6 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
-	u32 secid;
 	struct lsmblob blob;
 
 	security_current_getsecid_subj(&blob);
@@ -497,9 +496,10 @@ int ima_bprm_check(struct linux_binprm *bprm)
 	if (ret)
 		return ret;
 
-	security_cred_getsecid(bprm->cred, &secid);
-	return process_measurement(bprm->file, bprm->cred, secid, NULL, 0,
-				   MAY_EXEC, CREDS_CHECK);
+	security_cred_getsecid(bprm->cred, &blob);
+	/* scaffolding until process_measurement changes */
+	return process_measurement(bprm->file, bprm->cred, blob.secid[0],
+				   NULL, 0, MAY_EXEC, CREDS_CHECK);
 }
 
 /**
diff --git a/security/security.c b/security/security.c
index 297a6be2e23a..2ad0d4eb24b3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1816,10 +1816,16 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
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

