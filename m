Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61961505B6C
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Apr 2022 17:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbiDRPnO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 Apr 2022 11:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345261AbiDRPlz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Apr 2022 11:41:55 -0400
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CCE32EC3
        for <linux-integrity@vger.kernel.org>; Mon, 18 Apr 2022 08:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294385; bh=+DjS+Z0uL4cNU4DjtqD4pPkF56b3LF6vmgGemSjTWFo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=F2CkevcxcocDQIISoTA6Z7lL979cn8L7/XXZY1aLN2JAtWbVhwuL34viSPv4P8NcqloHzJCtzqAQ6aKMIHsXpcacScn4JHAbmUKJlyN4vhXjT/h1vtc6hQlYuTrrPRdqrcIi3ANX6IPfa+QzeKdkUBWMld0ITXTBJ9gztnLvgdJh0fz9HW2iUk/9Z/ZsXAjSUWGIUdFEu1lYD83ME6Z44ryMV+CwAt1NAmftAlZH0PqcZh9A6cS/NES8BUbXqpCz4louxaPPOs1fT45D9F3iX3dVYTvQb7wB0hYNtZa1TI0B7eHrzrbVMGBO3vWUPJxMWL4ZelWCe5E5v4WvkaPfAg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294385; bh=8At39DzCrqcCa5Ki2YxsXXIodNjBWIdV1TSEdKkBL9V=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SVGm1Q/iQHsnolCEV1JgTW42IlJS9cpsM0/Xr6b3YZQH8+xncTqnbyoD2IcTGVapywshle3WyLcVXK1DHvhYaAw+Mr17/8l+5g09+jao0ta6XyxCXMHftPCR2NbMA8Lm7PsaQSYtoipZS3RnfSDvfmfDfbMFtcSsvT1p1XyFU7EKdfTFYveGa2KOAucdp1n0d2OdeqiVwGRBc1ERzuo30akG36CgHjwVmD7K4+LQm7FV6iUNitlk37lQ66Qowt4/TPNfR7307GbMxbine1sbvuAdJCz/YL0v/TEfhEIT92JiPArAm24h6HUznSNFVoF1h7TZWponF8i6P/uLlYlqdQ==
X-YMail-OSG: 6cvjZi4VM1kgP9tDSYQSE3NvQuBXzYfLPoo7y.uuXQZPVn8P5.ZJwbw2xkWtmA5
 nu2JanvM_6.qN3t4JXtXrEnLu_pxMV052n7Tf0PzrC5zoyUQaCxb3qvHH_57YLCoMmSHEjLluRSA
 VhtM5HkbQJH7vRzSxKOqFPoJlbT3CFPzOgwkIObxyrZoInKU.WvMlt9uC6BaowkP51etUBraSEpt
 TKULiECAdOOTcliDdWbpmxhBNaan8vfg2DmL8Mj9Mz9KLXd3dZUNBKvQxuDv9Be4UjkB3x9QEJO5
 AaSiRDy4O_yLqZ0nk_yE_n.7djhND4zuteKqyKJIy_SRn8AF6UW_Gi45ZHm5RSvA05l0dQIZKkgq
 2eOFfgBPAvG1T.oRN0Nb7j486avEoIJrss0b0LLaSZHgY4nXu0YyNo8ZCfQ5Brq6DmVd4r.uu74G
 Z6Ir5nn_2xXG7EBw1RqlQ003u6ekYdd_m7TFY_nCOuwe.I3roWS_ZqT_s6xOEsj_JI7Z01NYdxlR
 uecFOTqEbSVnhUxMxeqKJ0VkICqrmrfHV56cwni9QFOC.5Q6H__xZhCEuXLNSLkGF8yFX6fmZW9Y
 wUNvnj55fFRTWUBhbYyT_O1cBdTRKjHK3t6E9NJ1jg.ImeDpBm_91LudMehDLMZgHHn_tKM9KNb_
 yGyMn7r7bjSh6xFCoZYHh49boNTyMTDU2fY0F0f0AxpJ0wMffKe3_1y6CvdVaipuPMhA4v.hd.pk
 yO6NnvaARCQ6OOt8uqb59C52W4X5iYazegpRSOf7wy_t.0kW.pDdJPJ1IqOFLjFKkq4bxvOpyMZr
 cCBXLQKt6hneSPaT99fxbx4JHGj995UWjdW7MbSmyfyp5BRveTV66C9.j8Zldtr9bry7kLCv8e8V
 ZnL8UUWeqxTvepzlFal5HcSSFRrrpLvjwUXFPnfejp.AT_KBWSgnxmjfIYnpkD31smFjARZYeQxk
 _nXWlgi1VJ2K9EhUxk3_tkIA3WuaaUZR.Uj1CzlyFKhW8FbPenAyEAq0XppfN1oxb4wFFfMwbfR1
 m_SKASuomRMzw5kmBfMWvEoLDnosIC_W9.KeqAqGFMQM3m1tnSuo1cmFmQkj.rqqrFUyCLAw4Up3
 zgnowaw94fvh.i8gKY2ClMtSy75T2dGBLxd.yFUY6vHsfd.DJL_c1CCbzMt32c1wOXQOxTB0ljOs
 YtMLwjdJ3gp0V27JiajxDEcjRMDsNzXbEGHC9mWKbGVDSqLIRLmpKMramWmUWkWlAsR2tdzHfjsI
 _57NiSwlVD5ZgwP5Yu9P_Qkvi4sAC9KdWoNe11OFk.KbV8yGe.4_E6A03FJpog3.hs2ZUaIgehC9
 dL2MX3YhdWsp9gbFAezWGSD4Em3dqrUdT9c4K3wmTNaATmgsK5sA4UffaKy0WCX818PWkgVDGEvI
 EQ7Xmed9g1qoMCqFzFgMevOC24Vpao9taFTCNpLCjaW9X6ndq.mAgc3UZ.PXUidg6fwD7xsdSivx
 JJPlOX7YnvWkqxETDmeETEubX_YPFILPWQ2Jamltr3DEMTG29qomVaMNJ.YiEpIbxXHx_XzD9EWn
 c6DY7.0Xchm3Fzec1N76g5ND_Nu2882wsa2EDAOuEkLMi83x3g92oMMfQiPhDB3UVYm0qbUn9Riq
 DaShhF_aKfXs7qF_vtssNCUOLVn3LCY8.Hoxg7kxvBB3e7e2xziBzt.ikRkn_OQvIR_nkopP2PcX
 mDDN4AB2ez_rD.KbGI8DljB6NReROUC1z7AxwBDIVofSQdTCdxz4A.NYTDrRRxk5uNa89XscwI0v
 RBbZNzyoJkA89ZlJS7wwKgYNS5mDUe7Kfnf1jzqckN16ZBKF0dVfp_KbVhq_o4i0SQXM6BToqJLK
 1eJdoV2FzNncMT0wzzj0aGWQJ3si4u6pb4kuS5ptIWlmcRxvP6ywdaYaDRI08DTqbjD_7VUWo8HV
 6qIu2b.CHdSePDRdlp0ogUfXF.SUlKSZZ5bJdYuFkf.Wn5EMnBLy9egeYcHoYhnisc6QrGOlJaF3
 F5SPu5v95EWGofyP6Z0Siw9SYzmOtHfILR5XjCJnn7jXyrkRXZ1nsqQ6T05jB46sPmL6CMBYPo52
 0u_wvWwHn3NwPr2emtoRNj7M3yXVH9pB2pUDzLLT8iva.U_YnquGctpBZIgDFwZ30WgjJKBLKP2f
 cS4eBQ10WVtybwdnzG.oUZHOhILgiyvpAZSLGjsM1cM6MjZPhM1qPMjnPQOEXnROlIRS2Y2FOEEd
 76UNDqlHXwoMQrcwTYK3h7qHcJoFfcxA0_tUW3xceUmHSYBVYckx67esmGTko6XU6kWrIEP7fECJ
 Hxnli82worcDckPoh0b4RbYGLaDZXMUWyVx8RAb8LPtLAeKHb6IfnljAXGG8nYhzIKxbKNtZSEQp
 O9dvv5Vxu
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Apr 2022 15:06:25 +0000
Received: by hermes--canary-production-gq1-665697845d-srvxf (VZM Hermes SMTP Server) with ESMTPA ID facb0f2176037c185ff3b4e507d76c59;
          Mon, 18 Apr 2022 15:06:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v35 13/29] LSM: Use lsmblob in security_cred_getsecid
Date:   Mon, 18 Apr 2022 07:59:29 -0700
Message-Id: <20220418145945.38797-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418145945.38797-1-casey@schaufler-ca.com>
References: <20220418145945.38797-1-casey@schaufler-ca.com>
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
 include/linux/security.h          |  5 +++--
 kernel/audit.c                    | 25 +++++++----------------
 kernel/audit.h                    |  3 ++-
 kernel/auditsc.c                  | 33 +++++++++++--------------------
 security/integrity/ima/ima_main.c |  8 ++++----
 security/security.c               | 12 ++++++++---
 7 files changed, 38 insertions(+), 60 deletions(-)

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
index 781b1a2374c0..fa413a5a2ccb 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -501,7 +501,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
 void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
-void security_cred_getsecid(const struct cred *c, u32 *secid);
+void security_cred_getsecid(const struct cred *c, struct lsmblob *blob);
 int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
@@ -1141,7 +1141,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline void security_cred_getsecid(const struct cred *c, u32 *secid)
+static inline void security_cred_getsecid(const struct cred *c,
+					  struct lsmblob *blob)
 {
 	*secid = 0;
 }
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
index fb8c4c61189d..52ea8da8462f 100644
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
-	context->target_sid = lsmblob_first(&blob);
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
-		ctx->target_sid = lsmblob_first(&blob);
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
-	axp->target_sid[axp->pid_count] = lsmblob_first(&blob);
+	security_task_getsecid_obj(t, &axp->target_lsm[axp->pid_count]);
 	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 3d8d9162a5e3..b9ef0f493041 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -489,7 +489,6 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
-	u32 secid;
 	struct lsmblob blob;
 
 	security_current_getsecid_subj(&blob);
@@ -500,9 +499,10 @@ int ima_bprm_check(struct linux_binprm *bprm)
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

