Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7D94A7C5E
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Feb 2022 01:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343727AbiBCAIp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Feb 2022 19:08:45 -0500
Received: from sonic312-31.consmr.mail.ne1.yahoo.com ([66.163.191.212]:35203
        "EHLO sonic312-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232876AbiBCAIo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Feb 2022 19:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643846924; bh=wg/PA+wYiVPS2PsI9ZmOeIOSjgBmdcwIjtBH2wMtzN4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XJrQqnTe+RrpIAAb3Z5mHass1WwFbzq7MwsGSIYdBh3sYqyCU+KEACtP2YSc7SaELTy5/nzDVP8cNrEJ1cHpmtN9BGuIecxrW86F7VCx+NcXcPNnmBwIyERbjJ3gx2BBSk7jRQ3HOv/3PaDdSk5n3C2YVoCPaFjnENaGrhfyRCjfj/kLB/YXS+9mLewN2UsJSst9KD5M7GEX24O9SuSIZEW3Wtu44fjE7MNF+gfR25xYxAIvnBgRiD8LS8zoWCqzoPRvhz+ZiATcpVQ2EMwuyKkqH+z+N+r1DMqs8n79CdARiIRp7wt/47DwocSOMqjPwQX+5YE2rDM4/mwAFosFew==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643846924; bh=PpkZijOtx2b2q0jSkVkhViW8Lz/PHx80bwGTddy1r1p=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Nrh/6Uf11fZE+UX62sVLTWNp6GKpne5gZkMl4ZIC8kR5dyYGOrOaQ02O1rmqqsEDm8yw1GXB54iuTeg8a4K9S2GEiPjT0BXcsJKbQEqr0MbL8Lv4EPanNzBaKsqKTQTZ2WEmaNu1IxZe3yy/yDd4lQu6CECfi0sGUfH34jnOtPrl08AUKPZcDv7wQz7oeoR/eSDuAhyo5JCtknH4B9/wW80FyEqyg+sB7benXVnUZ2onG3yVBqA4p3JJA/6ryKGME6C3EayxzpEy1y8oA9uifatrTSmP3NwyT1bb4mCoNpsbXvsgBkRoZTqAg6nccujv5+vwb1FlBjvCrpPOc1EUjw==
X-YMail-OSG: LBE0pocVM1nwsT9cZnWgjpKGIUmfdMMNcFI4oQpjYBMfgEm0Ku_G_YJTDXGQaP.
 xZHjSXMTQ4hYKL3HG7Eb0mKZAszQT5volm1ttVxNcLWjCCKq1rOReoRY_JoWPXcg6neoBcJbZs3T
 OELeO.h4bq3CWYvwLV9aH9xu1GYWEckSKkzK5FVd2aCc9F9qEHDkMvR6g8ow6dsrF3w7fTRKxwGe
 .svDTXhwuncqgca7D7bcRgAzM_igJFEhrM56EYjKJqPQd2M5OGYQobsnkUKU1M.HvRhVkKVax4Za
 TSVZGikjfSu6fYUuiVvASTbHv8oaXmgnjNLyFjgwcPsV9Fp5P0IyDCMaDHb0QBDml_WjeFm7vxo5
 3LX_q9bewVkCAG2T1ZQzXqa8OADpSeP8b8awIgPQneYiEXUOADiFbv65b9neBeHnSNe_9YN9lFEB
 ZxW4jMp3voNVpZ8JkaOStsMXvon_qKYhRIzHRLXWibzykUJkXc5MkrWpG.lxMksoS2wOuQ1OYehM
 ZuqEADYV8_MXD912_6Lb4cKSuz9Zz0v2TtRpRcbr_a9jmxUyyAu12uqbbfQqSwA51LJIE9oYGT55
 UsowqZi.pi0PM9tXqqpL7dU2dfQlB6iLFCjeObDHRCE59jIa7Mp9R.Wi1wPwh027Wqqw5HtawJGX
 6EWn3FxaK8BSHn_kSsBfniU9Hf.bTWmAobxCS7pCfbGi3ge7gPGoLjuYmNEa8kNIAA90ZNEums80
 Tj5tKNX9UxCzJ7xmyMeJ.xl5byeurcOsdCQPPE35xrIAHWP8fH9y6iK2Y..7lRRl5daQ1wPPPk..
 1PWAQyiZ_hozM8CkrdVlLez2FfvRPwPriVeCyUR6xWmLMsRPWm.P0.RLzZZLemM0tSUr9THsVAM2
 cuJ4vtZUAAwdLM2uxMcVqIGcuwFWbIV6nP.E219V0scH4blKj1Fh71cGpBHJ6FV.F4X_qONY2Kqm
 r8xgEhIgGPpp1LwOEL2B0NH_xts8Q9mW6NZ.S75wiLac1mjCVwKqumLJ5fUmLFt45QOz4MU00Y76
 UZKKfc7F3oaFKX4G6G5017y4UzpFxu5tTvbjLPzXNR8m2EX30c.PfrBzdzvMyCo8Xbb5v2Dnffb.
 .tC17Il8Pv6o6jbBTbWTt5da8gBIiTs3hLYwTxlyQJA_4fPfa2GvDpwO3I3jBwRZS0O2ekvj.Nqq
 eSm2yv8qfc.8gGxuPEJL7ZbBqNZeGoo2OT_6JVOKdeFxlXsQ5eHU7tBXdoZSz6Cul9swAD7oEdJd
 orrznMwK3fUYLXCodbUULmki4true4UL03EAIHYioDxHwb6kchr33Kh5_SqX7I48pwm3S6n5ZDvc
 B3.AHN6.kZvlvbt2fdMhcLP12qmffeL8x8VT4Q4vSDoUySaWe.sAxAQL736hYnLclQkwnrFCwbmY
 QZyb3RvCizIoq9pJx_I.iddIMetqf6X5eoCkbwXBRTUgYsHLzh4tePXmg1wusoSUCc1SHwcoFgcL
 U4qjRYoF8j5grOYyGsmSaFoPRdfb3kmUKO.WBOf0zc5XAtGVTQUvFKXRhxooQ2eoicFqRkuZ0GZE
 gX.PldRXY6zv6lz6lPBkoK51oZLdV8lhAAW5LAMBbN.vCWs36xcU50u24Ubkvond69ULDS4TnAw9
 f9UGHsoLUagy1iF5ld6NZnKeQiHsFMwgKepiY8C1p83DeBbTBFeXnseetoCPuOrnYTOAM9_KxReM
 2J.neVMWGzcFi.nt9ckiJhwEvEeJUMyKPqLOXB_pCsKtmEyK2GtCFrQclSMiu03YYMeryX_G9pZw
 Ra2K_umNgHaMxDrqTGY7xFlQrTQpbMY3nDtqge7Bd_BZ8g.KoKhRqoJeKlwU1xWXDqVenTKqFt_u
 EQtjAD22_crQTyTKlGUhrQGHWpYHKYUAmSWRhHbu8m1ZBEuLvEScofNBrdqBb00PfIb_zy6nxsTX
 Xgv4GKNW.QYLjCAdQSSTk4gVLuqRv.FN3zPcERD8AKgXrMksQJyIMS21qXEQwb_a.tc9Y0Ck25Yp
 NnhOwWJPgbkukFX27La0iQGG0aeCHCS_AWVdwV13_J3_iV.AHlJgIvs10kwi4Ny9XjkaspebTisi
 wt_05UDNN.BSDVDspWq7cjrwqCmMg4AZc46CXjrhzpxJ7CK3EXgAt8n5zRzPxN8dzwIt1bZxvxu0
 Ea65qLn.35hYPTjXsEFsLOa10pJ7u9wk3DwQ9Z4FAIm2j9libOVThXPSNgVg75SWO0kZFArwdCTD
 8Hs_UL.bId_no4yS1TpY6zeszwGB7JYUah8BQsnM74buT18psSjPDaqzUe2XvVJUMT240tqO3IkQ
 NkQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Feb 2022 00:08:44 +0000
Received: by kubenode522.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5459f2ad3ddb3315291f4b33cd876728;
          Thu, 03 Feb 2022 00:08:38 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v32 13/28] LSM: Use lsmblob in security_cred_getsecid
Date:   Wed,  2 Feb 2022 15:53:08 -0800
Message-Id: <20220202235323.23929-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220202235323.23929-1-casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index b0d1abd082a8..821e6011c8fe 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -482,7 +482,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
 void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
-void security_cred_getsecid(const struct cred *c, u32 *secid);
+void security_cred_getsecid(const struct cred *c, struct lsmblob *blob);
 int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
diff --git a/kernel/audit.c b/kernel/audit.c
index 17ac6e74b5bd..c7cd039e258b 100644
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
@@ -1439,29 +1439,21 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
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
@@ -2368,7 +2360,6 @@ int audit_set_loginuid(kuid_t loginuid)
 int audit_signal_info(int sig, struct task_struct *t)
 {
 	kuid_t uid = current_uid(), auid;
-	struct lsmblob blob;
 
 	if (auditd_test_task(t) &&
 	    (sig == SIGTERM || sig == SIGHUP ||
@@ -2379,9 +2370,7 @@ int audit_signal_info(int sig, struct task_struct *t)
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
index c4498090a5bd..527d4c4acb12 100644
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
index 6cd15abb99c7..c4c3666576c3 100644
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
@@ -1762,7 +1761,7 @@ static void audit_log_exit(void)
 						  axs->target_auid[i],
 						  axs->target_uid[i],
 						  axs->target_sessionid[i],
-						  axs->target_sid[i],
+						  &axs->target_lsm[i],
 						  axs->target_comm[i]))
 				call_panic = 1;
 	}
@@ -1771,7 +1770,7 @@ static void audit_log_exit(void)
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  context->target_sid, context->target_comm))
+				  &context->target_lsm, context->target_comm))
 			call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
@@ -2707,15 +2706,12 @@ int __audit_sockaddr(int len, void *a)
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
 
@@ -2731,7 +2727,6 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
-	struct lsmblob blob;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2743,9 +2738,7 @@ int audit_signal_info_syscall(struct task_struct *t)
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
@@ -2766,9 +2759,7 @@ int audit_signal_info_syscall(struct task_struct *t)
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
index 6abbaa97bbeb..93c6addd8389 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -486,7 +486,6 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
-	u32 secid;
 	struct lsmblob blob;
 
 	security_current_getsecid_subj(&blob);
@@ -496,9 +495,10 @@ int ima_bprm_check(struct linux_binprm *bprm)
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
index 0253c925a272..27154c39d109 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1803,10 +1803,16 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
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
2.31.1

