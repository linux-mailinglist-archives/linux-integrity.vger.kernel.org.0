Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DD9503123
	for <lists+linux-integrity@lfdr.de>; Sat, 16 Apr 2022 01:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355739AbiDOV3U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Apr 2022 17:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355186AbiDOV2q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Apr 2022 17:28:46 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89EC3A18A
        for <linux-integrity@vger.kernel.org>; Fri, 15 Apr 2022 14:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650057894; bh=aMpe5IBXKVs52J+BeZDj/JSO/Nm2DAXFZfK3V8Fxhf0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=mbyd71uz8tHpXrxo0JSsy+uWdrTuG4F53NWuJ0hgLvjCLMqtpKk/5+S8Mu6ixG6YwSrMHyud7lP220gu6Vg+8qthen50WPxlaBHMvSzzFkixdHNCKVf5WjQxzwcnKGQnoQfmEhshTer/cSbwcWgrZOl6aM+VCHtlnIVwfN+mMn0svT4rUCpHFipVROQoLJa3+ndLgWw6CGms1+alK2vCAoixNJLuYD7SyhO48pgudOxPNtm1iiKGkxSAXtiNBPWyt1g4RGAzFO5UBvuVIRrD/u7UeCTPrY73WYYGpD4IVEa/WL3kjecoK6GaDEUtVCcAr9xecAfCSzkkJOOCySRLmg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650057894; bh=OS4cjMjFDC4/shQR1f0uohf6WBVizwrKJWUmwwuUwcz=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=gt8qosHsbLVeJUcNyDtziCzVfuUvUxyMmZXNPl2VPvXFjMZFHBJpWdRJWEAEENb5NioRcQB6vy8aWu7NMzOtR3F0vhJHTfSUEWJ7gfNqkUcgHAH2YDCUvoWgClEpX+Rd7NBzalG4fzAlC29MIBScNQYELAgZOAB3W50qepVmPIfMvSHiURNVPFCcEFN1O+kh9xwb7Mqew0+WM5jB5nL7de5kDuSYTN752U0OqUQjymEL7SmpbSf1lJpwwPW/fSM7c1XylMH1mbIoyfgRfck+ooQinov7UB45HDjt0wmjQteMHcmySfeudEURqxSgDGpw34PBqp/xzAUzBcSAiv1uPA==
X-YMail-OSG: eilk7uYVM1kMPhR_wGqSwrbx8qoHYXX4H2cem3tt5KIxor32CoCkMI7OUq1kFfX
 IotQFbSK87Bq4AR1O1iV5iFQLu00.hzbOSnP1Q5XASYV4wNM25_pweSLbgJwL2t9mHhOxA2JxStY
 JMwJRfDp0lki4jPEtyLgv6E9ZwMUqzmwryUf12Rodb2H2ipaBrGYEpqjXJjIEtqCI5i41maCIQCn
 UXg9HyjrltXyCDUAbIthH4IOc1onBIXucUAEiCLnB66OlmieQgvnAnMxdP6hQrSyBazbMmpPuwOF
 AmNKERJDZFyvMwg0jbRzte70YDSWYnyqmz8gjYKMdens.xHpLiYa3NLimuu3BZjeYC4eY_FX.6vC
 JSU7.TggrDJ8uJLvRF1t3qDz0qpOEItp2mNKykfsgnePQA6C4Ee3jlLLzgSRRv0GmbKc4f8zpVUZ
 rjmtUeK86HMKUpS1jRlHNmc6paeaK3nz339uJY1RmZn0wRuoDXkuZxopZFkHMuwM0Ts1nMYDRRLP
 5dYUn_N5HcYerA_RoqyO49sfJeMGQku2WW2NG_6TkpRAfIuoD0E_efmxXUcVYLDLurDDz55gi1Yb
 IKiWTkzzTG5MBR7g2Mk2kQcioY5kiqIEwMeuQRbNNNimRb8RQpYpBbiAinWoeMUNmAjoCdFFn6Qb
 o9wWWHKu7UvTZDKdOceFZDO5fWmZHv9N_fkY8eYMQ534RaYYrSNJSc05xLviGdHVyG8kMKDCj1ir
 5iU7JTPToG6ZSR7Eo2gSnjGXV3rJx3KJRz.WpioySE_TC0HOlIEk6T46iSiG_t_VknGXQKg7HLFh
 dwhMPaSeQYTD_3c6Xm99MIIxfhvPFP0flX6YfFGlo2UVP8NMRRzQB5Inu0KAlHNUF_xxr6RhXtbu
 Nvf.aAO_TMUXDxKv_bQhm020pmQUVWrOqn.kOgXdi4Ut1Sf2WLTfqGLHussbd7Lda.4ZoxR_BRwk
 0ze92Fc6U2.foaFXFbkzojx1O8a26Ah7vg.xUVkPF5s96_HWZY46AGfZszqyUzZUOfQQ8uFOuhXB
 TpN2293419GmVmjzEazZMu24DZmu_hO5wh.Ps0cp_2dLPcTZnlV2nTAZS9mZMzSzOkptNVhNwDl1
 VMANeRUisj4XYZNRZvTFGEU_XxAUokWgTyinPvNzN3Z5hLMmDwWJWpgKxai0UK1G_WuwiXVx0_xF
 HMkd_373rPan1.LKI4EHG_aebs9vc7XpHaSrvh8BAmlxUQ.l1sQxijG5jKjBDBOgpDQWiyafHmIW
 9gCgoz3CyNiB3Lg2f9KhkT11mUnOTOQjtEX3wVdlRzomD.K147Hb1r011apLE8lZ1ks0QoR63sd9
 4N_jclzJaTG4gM05vSgGrj.yC3.nPLWkULRYYDEQYuSm_fa7SPH9y0WgEDBAYQYR2qldmomrYUH1
 MP7SqUPodhg8y9KRX12j6y4cSQlc_.GlEpjVdMA0ylgW_iA4z8Jw7M8Ysw9THQadH1mCZhAD0V5b
 Xned.JIciuZTDOfMNUR3rPv3qsAX004wJ4JwQbflzt2AemJzApBxlwFQljnOMhat9YDlDi.tP42E
 s2WIkx2wuGZJ7TlPVrbjGirCBPRhQdfrp2n8JOSfYtOyErUCbJdQUfCEen0ERePN0xuixAsiSQgI
 nbqbW1vklT8htFd4ABSQR4fISKLVvqaUueZ9.cnRD9aXXTeMoVZIAkepN81NkzjPav_E.eCizFai
 7I2Hsa38ScOo0X2SXvuSDRytavpRaONZm646gshDJRWvHimtVe9ImeKu1mB26O4YUPTdhz2wnhGB
 qpGWZL0WpdlauKKHAT_6bKhCSJzPRgtpFIQvjZ3Aa6DNsruQEbeDjq6NTfgwNU7MDfKVc1nUDGW5
 aN_YiWZJ941815UZrsANTrq_k21p9BR94czzFbDGkHorQkWGEoZSaZ2YvLTFy8efIMg0v_q6.g50
 aDmzRo1A.YRY_8KvUYVPdT2yvN5DgwfFQsMu_FnbRiI_7o5S4RBuHyPtfsXj6kvkkVJBVfyqg5Sh
 K3_C74y8xd2RBLaiXcobNuRqfrUVI1OHlcVA3eEwrQsXzPGkE_5zmon6sW2gCJvRTUnfcrZ94nca
 LNpdYrfqWbPErn8Z6mriGj4sEOWAx10Uev7F9NhRzSJ_pcIn9NGdUO9UtrMQxa8CH1CIIc.naWn7
 UK4qKRxhhfDry1d6ozvkudQby2mkpboTssa.LsdS2kOeFllnvYbh0AO1gl8hO.91vpyt8QHL5era
 j_K8Ww50UBydI0JiIa7kCjN7_lJbhRMhA7mK2d3zb6SXSwPmIEzU1ZV1TZVbLKGynBhOhYVdmIA5
 HZGfQdkcYwbG7clQ0APuI9hAvBN9WFQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:24:54 +0000
Received: by hermes--canary-production-bf1-5f49dbcd6-vddpd (VZM Hermes SMTP Server) with ESMTPA ID 7e2b2946fba71fdc86673e46e490ef4f;
          Fri, 15 Apr 2022 21:24:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v34 13/29] LSM: Use lsmblob in security_cred_getsecid
Date:   Fri, 15 Apr 2022 14:17:45 -0700
Message-Id: <20220415211801.12667-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415211801.12667-1-casey@schaufler-ca.com>
References: <20220415211801.12667-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
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

