Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E95219517
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jul 2020 02:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgGIA36 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jul 2020 20:29:58 -0400
Received: from sonic311-23.consmr.mail.bf2.yahoo.com ([74.6.131.197]:32837
        "EHLO sonic311-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbgGIA36 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jul 2020 20:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1594254595; bh=ZlBFPeu5wVE6resxT6H5YEyWB23kg44YVcW9YXGNix0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ZoiStpYlthR2Zd5YerLCNPCcqRF39WczJMSo2UBcHdRaRwee7ZyMEMHz8IaZ3vV8r5TceynpCLkm+BJ6JHkuRSk02iD4R0G+jMlImgog0HnoTm2kdsHL0JhHmo68BY1+HaJXXcrKQC58ImcfIbQLrf8O9vRwYGl9fwIscUYiNP0YCGXpHkm7fV54uhjRAe2yxIDy4oJKfzYm6QXUpPC7ZXZ/eATIxIJ6kt8hV2cmWv+hgmHy+z5lh9yYd5iJeNcAT0ZjfB6dAVLLC/bQakw93/Uxil07ONNea3p4AHBzI7rVr6zXyaCLQ/MSVzwtJu+Nqwj5IUP5arbOKLomP0sJXA==
X-YMail-OSG: HQPPjhgVM1lRb5HMtCJNfdus4RNCb5lxYUWPDNg0Pxnu9LgV7n3h0A5_ToM4ugp
 3ynNf97xL_aOy0VLRx2kDoUxzjx2G89DtWxINFdIlg9cu.AsHI754OfLtvBlr4R2bZtGJKhieA_R
 LOHc85CHw2WS40rj_QdCgjQR7u9FpBT7_bV2arFgN4vsfxGc0J5YPpZFHtsCmOCPo6Thq9XYnl_C
 podxl4D9iCDdW6luRbHzcPc3ZfO9MqPyxDPjSqiOEuBumsGSSKtiD7tX2ulfSWjxVx6YJaPcvLaJ
 nE0N9r9t8x7NnctVwNnNuwe3v9XekhED5QzurFey9wZCZlOfIskR85LBFl6560xe1tayDG.D9NJv
 k2M303uLqEOMkUaJtINGfz2ficHWdTJtp48Lfw_P4BAJrzSYwS_.ZZA.9tE_vgObnZWz9FtnED9V
 CMtJyzUucAUGYT4UCpqlM7FUnsd1U.1q_zHWFCgLmPfShya_H8IDwdYxg5rgfrnUn0hbDXEctLr2
 6B9LRyi1W3NgUJhcHF.CVq5sxW69o8iQWSEBz2vP.6pPiZX3GQqM5h365lqQ75h9jhCXudYMsbQH
 JK72XG96fdsGMk9nF6RvsKQHJdAzgpckFnZY63r66Kh34skI6HB5dDmm42iU7L2mHnj94WhMC68K
 o1e7jVHoTO7SH8QSWqR5e3X7nMkOElxco1OSZDJ_K7VKF9wmXt01pgNGnZF8o.NlRFbfwMpp4T.m
 DRiSfvuwbfUOd6Zb3xGgHc0tbWXqmSAmaMMJKcbQ1ir6oT6_oD9kJXLpc54WQQqZC9NtuyLF4LLG
 O9Ys7Qo7dzuZEkH3tRSyvzu39NPiUA6cwNy1Nk4HkGpukdpPz1H.s7teGCiE77IA3sgE5OxCNkH.
 APrUdPeIwc4zl8laSrXvGe90S.ZSekE1OBVJFIjnXUrpNokMm8WeLRwmHHMFadXd98NuWjKdjVjL
 uts1LJ6k6lKj_CJQsFVh5W39TG4Rh60Hb9Fg70mQ_JNUpTDh1P0pxzVlJX2SUrsr2SLtnGaruzQK
 jwnRHaig24AcPXaxhZlCEslKPlIZE2cE7ubVVfjEaVJtI3pL.rcXzM5iK4Ja3ShUG_H0kdx3Jvti
 026BOqK8CiVRvsrkm0WDMYn_SE9TjA49fLfas4eRTdWQcj26wPk0OG2y0gJGCWFfWy.bQMIo1VMc
 f72czdbM.UNUnhTeslcUiLNqF_r1QU9yTGh2g.CnP4v4VmNQSIxGgeNhrRDhSO9lmu8eAAeBsQkG
 Ep_atEmqRv1qcMgZ2bmvfJuTTNUyxiclhccgVBDuhKSsCzjYt.o6AmBUFMIcKVAS3ruJ8ZbW7WcW
 zXesQ1GhT.QKIXCZXUHJ7LNpo.9Bkfe8saYVA0NLoEhQd0.5xfqENvGI5H1Uz06k7Q7e0Pb5JxKI
 gyIgAS32uYjhzUZ2Jdk.CEJ6PdQWRzwgPgg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Thu, 9 Jul 2020 00:29:55 +0000
Received: by smtp430.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 47705178d6378453aa2757a44f144c61;
          Thu, 09 Jul 2020 00:29:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov,
        linux-integrity@vger.kernel.org
Subject: [PATCH v18 11/23] LSM: Use lsmblob in security_cred_getsecid
Date:   Wed,  8 Jul 2020 17:12:22 -0700
Message-Id: <20200709001234.9719-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200709001234.9719-1-casey@schaufler-ca.com>
References: <20200709001234.9719-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Change the security_cred_getsecid() interface to fill in a
lsmblob instead of a u32 secid. The associated data elements
in the audit sub-system are changed from a secid to a lsmblob
to accommodate multiple possible LSM audit users.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: linux-integrity@vger.kernel.org
---
 include/linux/security.h          |  2 +-
 kernel/audit.c                    | 25 +++++++----------------
 kernel/audit.h                    |  5 +++--
 kernel/auditsc.c                  | 33 +++++++++++--------------------
 security/integrity/ima/ima_main.c |  8 ++++----
 security/security.c               | 12 ++++++++---
 6 files changed, 36 insertions(+), 49 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index b804bf896552..84ad4404f7c1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -461,7 +461,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
 void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
-void security_cred_getsecid(const struct cred *c, u32 *secid);
+void security_cred_getsecid(const struct cred *c, struct lsmblob *blob);
 int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
diff --git a/kernel/audit.c b/kernel/audit.c
index 9861e1e11a4d..ff381344f950 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -125,7 +125,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
 /* The identity of the user shutting down the audit system. */
 kuid_t		audit_sig_uid = INVALID_UID;
 pid_t		audit_sig_pid = -1;
-u32		audit_sig_sid = 0;
+struct lsmblob	audit_sig_lsm;
 
 /* Records can be lost in several ways:
    0) [suppressed in audit_alloc]
@@ -1430,29 +1430,21 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
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
 		sig_data = kmalloc(sizeof(*sig_data) + len, GFP_KERNEL);
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
@@ -2336,7 +2328,6 @@ int audit_set_loginuid(kuid_t loginuid)
 int audit_signal_info(int sig, struct task_struct *t)
 {
 	kuid_t uid = current_uid(), auid;
-	struct lsmblob blob;
 
 	if (auditd_test_task(t) &&
 	    (sig == SIGTERM || sig == SIGHUP ||
@@ -2347,9 +2338,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		security_task_getsecid(current, &blob);
-		/* scaffolding until audit_sig_sid is converted */
-		audit_sig_sid = blob.secid[0];
+		security_task_getsecid(current, &audit_sig_lsm);
 	}
 
 	return audit_signal_info_syscall(t);
diff --git a/kernel/audit.h b/kernel/audit.h
index f0233dc40b17..6ab012e5fe98 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -9,6 +9,7 @@
 #include <linux/fs.h>
 #include <linux/audit.h>
 #include <linux/skbuff.h>
+#include <linux/security.h>
 #include <uapi/linux/mqueue.h>
 #include <linux/tty.h>
 
@@ -134,7 +135,7 @@ struct audit_context {
 	kuid_t		    target_auid;
 	kuid_t		    target_uid;
 	unsigned int	    target_sessionid;
-	u32		    target_sid;
+	struct lsmblob	    target_lsm;
 	char		    target_comm[TASK_COMM_LEN];
 
 	struct audit_tree_refs *trees, *first_trees;
@@ -337,7 +338,7 @@ extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
 
 extern pid_t audit_sig_pid;
 extern kuid_t audit_sig_uid;
-extern u32 audit_sig_sid;
+extern struct lsmblob audit_sig_lsm;
 
 extern int audit_filter(int msgtype, unsigned int listtype);
 
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d3e1bea08da0..82d60474098d 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -112,7 +112,7 @@ struct audit_aux_data_pids {
 	kuid_t			target_auid[AUDIT_AUX_PIDS];
 	kuid_t			target_uid[AUDIT_AUX_PIDS];
 	unsigned int		target_sessionid[AUDIT_AUX_PIDS];
-	u32			target_sid[AUDIT_AUX_PIDS];
+	struct lsmblob		target_lsm[AUDIT_AUX_PIDS];
 	char 			target_comm[AUDIT_AUX_PIDS][TASK_COMM_LEN];
 	int			pid_count;
 };
@@ -975,14 +975,14 @@ static inline void audit_free_context(struct audit_context *context)
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
@@ -991,9 +991,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
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
@@ -1561,7 +1560,7 @@ static void audit_log_exit(void)
 						  axs->target_auid[i],
 						  axs->target_uid[i],
 						  axs->target_sessionid[i],
-						  axs->target_sid[i],
+						  &axs->target_lsm[i],
 						  axs->target_comm[i]))
 				call_panic = 1;
 	}
@@ -1570,7 +1569,7 @@ static void audit_log_exit(void)
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  context->target_sid, context->target_comm))
+				  &context->target_lsm, context->target_comm))
 			call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
@@ -1748,7 +1747,7 @@ void __audit_syscall_exit(int success, long return_code)
 	context->aux = NULL;
 	context->aux_pids = NULL;
 	context->target_pid = 0;
-	context->target_sid = 0;
+	lsmblob_init(&context->target_lsm, 0);
 	context->sockaddr_len = 0;
 	context->type = 0;
 	context->fds[0] = -1;
@@ -2401,15 +2400,12 @@ int __audit_sockaddr(int len, void *a)
 void __audit_ptrace(struct task_struct *t)
 {
 	struct audit_context *context = audit_context();
-	struct lsmblob blob;
 
 	context->target_pid = task_tgid_nr(t);
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
-	security_task_getsecid(t, &blob);
-	/* scaffolding - until target_sid is converted */
-	context->target_sid = blob.secid[0];
+	security_task_getsecid(t, &context->target_lsm);
 	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
 }
 
@@ -2425,7 +2421,6 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
-	struct lsmblob blob;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2437,9 +2432,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getsecid(t, &blob);
-		/* scaffolding until target_sid is converted */
-		ctx->target_sid = blob.secid[0];
+		security_task_getsecid(t, &ctx->target_lsm);
 		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
@@ -2460,9 +2453,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
-	security_task_getsecid(t, &blob);
-	/* scaffolding until target_sid is converted */
-	axp->target_sid[axp->pid_count] = blob.secid[0];
+	security_task_getsecid(t, &axp->target_lsm[axp->pid_count]);
 	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 772d9f20ab5f..e70d8626208c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -463,7 +463,6 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
-	u32 secid;
 	struct lsmblob blob;
 
 	security_task_getsecid(current, &blob);
@@ -473,9 +472,10 @@ int ima_bprm_check(struct linux_binprm *bprm)
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
index e6121eac138a..6ba3990a455b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1677,10 +1677,16 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
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
2.24.1

