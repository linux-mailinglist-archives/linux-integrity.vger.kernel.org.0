Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551A228C263
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Oct 2020 22:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgJLUad (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Oct 2020 16:30:33 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:45995
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727484AbgJLUac (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Oct 2020 16:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602534631; bh=c9QxPSRYew/TgR3Tcb5aaNmfUC65ALc8a3jjxyue+y4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=AJrgxvsZJTAtKMLCtY5l5LKrN4QLT7yYUW/ox9jNuUAYbBEhaI5Omf71EJlKsy+UeVqgmhCcHA0JGwx0YwQNneTjF1sUkiqceIoq92UKpfLJb4iMsAeOcsfdA25PBsRMGFfR3l2ubtdo7vG5nLW0kzL28bmEWhNlUqYHs7oilt0yNqCJgrKft9F5vq4JHVrbc/cStyH5vGTSM2drWkpseoaiTyNtR4H1xIuyftRMNWjhS+mTLfodvATW7WLU2qn97cKbAsNhq9tAfr142wiJorgPDvBQNkHilfvhOQTAATLu/0Xo1YPAmWK0WPuNaExSh0L3ItoIQ83RjfM4Y6KTvw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602534631; bh=OgiruolM6qyH678sI5tqEO/hXXCXK9HzMLk4e6AKFtY=; h=From:To:Subject:Date; b=nk3aY1W+fg9GcyP6LVrGjvW+lH4/ItQ63lsXJDqwQktne+5FqaYqTLr4kat2Tf0Gr6Q0slKelDY311KCzh+TCb64aOMZ/PiVVCeleqZ7+i8JgORTEZwcIHDm67UiEHX3tWP6yYHjew7fCwlwt0jrsZxI7KNZ3SudLDSuG1BYqDU/9cSWteha0nAGjvCoLEJyUi4E4R0ld1rEaD1d6Y+prloYkztxNEXQVISOh+9yRIckAeUlstIzR1fiIYXD/nZKNfwVCoqz8+WpPc/7lps0jJv+AtSiHviMCPTnMPCrhxueog3Fh9lC0pq3OJAqT2G/2eFiW3nYV7St2IKNoKb0Sg==
X-YMail-OSG: x1gysS4VM1lXNkheK78iSvTstYVBGkrVOMAw82hbrbso5umwXBrMGYXd6e8ykFq
 MX3uXNe7OPFudAupTbtCPvzNASdhuLcMTbJt8.EUW0SUrtSSJdDZg16x8NRkGEQ6fCNKbfN4mLTQ
 Pi2aiBwBwOIaslJljjWfPy3Zw.GedKaHgTQYvMNq46J0KPX44EDcuKyVbSTctN1xkRlESjnRW6M0
 rIgnyP4pzjy_GQuRSwhxZr.wReQ10Z1nvYBW75EhXr6hIt_QO2cyBIPnjqHBUAAh4rWlGFYmQRTt
 y.34HPo6m7cnBTXhsfsBPXnUIwZCBpGEruQnSNyD_WpdGPaLZKq9ofaZOi2YPRrOweRsxt4mq6uO
 EzNXz881r1l_6LbsL3Nzh1pmP7N6VbKBPS83C70VaQ4tk4olEOqkaiyShSzoZVx2b1cP71lEPou1
 M0QvGGr25_Kwe4qvTLwfFzxGgJOEE6IuOS6I1gIvHe4aI7gLX27BiPKz8UwFGrTvvC4dZczupaKu
 vXQW6MNfRfPtVVKMp2euzqPayW98_b1Yxzwgo83d9KDrUHN7gPSrvS.Qpt6muPOuWExpi8dISJzF
 zVgrfYoh70VpvakIdRhQ_lfGn.okrn096wwn4nU_fTqYrzNVDAO17lrLgtW3l451HgCbSTxjHXoQ
 xTEeMqq1FmtbEXGVw5lOwMQ3eOUWKWZlR_82JY72pVJ0sikJNqkim8T4R.UDx9HlUMo3EZqMu_GA
 IhOtc2C4QxfL.fDON8QVBypVPl.6Gfw2Be82HYjZ.IXhj6eW.6qsfw.OhSbh7or01RRZR633TEZE
 1Ne.qmTBg6EPhPO.awuSXWOhn94pif2H1vyLmQCQ3mpFqX5HdN5tGtlWbPtUikWkn3qUpzbQNHwN
 0VCSh0vW9VGpThl9sXffWPelatvGPixFujw6D2H.7YCIGHh7AYNciL7GYA45La69MK0ZHxWU7fth
 nGvcfgeEXXG0c9cxoR9kRwBlws3_ph2j7I92wLUXElH6b9u6v3jsSa2i9z4mn2DvlayQJI4.xFgr
 0t6HmMZr9RhB7RSH1c.FRgxzl9qLqh8p3EYB7wo5GOdbqc0TqkHPbrbNef49Mhe1.42jkGHpR0d_
 Tcpd74FmF_Z3sR9VJpPkgki8.MvxwytrXAQ2z8uKAxoVdYKdXgjVLNhhkB.CY3GB3XJOGTbpKOIM
 lju1NO1JezmrJc57ximlIS_fF6WoQPVlRje_b70_aCrZzmlVxlZr8aEWCA2fUc8saImiYCxK7uuM
 .ytQD3yExxb63hCKSLdDIX8MH1wEwxvOJGhjF.JJbXFGwWOkuZSdQISzkabdadO6j94nicAOyT6J
 IfBGvnLN.7ldH.mVgh9FuEeYqu7kohC_QTMubfLvMhq01TEvqvq0ZQruX2.C_lNiMItgKP0clWx1
 FkRLe7jkWQ9gr3Lx2EGa58zNFBqAJOSbv_OYTXBUvKLhd0lXFJ_KoR_CO6tzLI1hhUz9jyn1EtIk
 se1IcADrNyMiFpGJJWni3Tz_UKafqTDwBrXxWhz8LE.pxyM9_BMLb5VD_NUm93c7.5dVS3X7UPQR
 ScDqOb4OS51fn4PGYTvVRstRUSHx0.h8ikRaycUA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2020 20:30:31 +0000
Received: by smtp416.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d3bc5fa7a9d74428badbf4fd18883a9a;
          Mon, 12 Oct 2020 20:30:27 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-integrity@vger.kernel.org
Subject: [PATCH v21 10/23] LSM: Use lsmblob in security_cred_getsecid
Date:   Mon, 12 Oct 2020 13:19:11 -0700
Message-Id: <20201012201924.71463-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201012201924.71463-1-casey@schaufler-ca.com>
References: <20201012201924.71463-1-casey@schaufler-ca.com>
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
index bcea823774cc..183c95b527a1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -462,7 +462,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
 void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
-void security_cred_getsecid(const struct cred *c, u32 *secid);
+void security_cred_getsecid(const struct cred *c, struct lsmblob *blob);
 int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
diff --git a/kernel/audit.c b/kernel/audit.c
index 0f7cadd5221a..88b55b42756e 100644
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
@@ -1442,29 +1442,21 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
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
@@ -2350,7 +2342,6 @@ int audit_set_loginuid(kuid_t loginuid)
 int audit_signal_info(int sig, struct task_struct *t)
 {
 	kuid_t uid = current_uid(), auid;
-	struct lsmblob blob;
 
 	if (auditd_test_task(t) &&
 	    (sig == SIGTERM || sig == SIGHUP ||
@@ -2361,9 +2352,7 @@ int audit_signal_info(int sig, struct task_struct *t)
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
index ddc22878433d..ec0cfa7364cc 100644
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
@@ -329,7 +330,7 @@ extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
 
 extern pid_t audit_sig_pid;
 extern kuid_t audit_sig_uid;
-extern u32 audit_sig_sid;
+extern struct lsmblob audit_sig_lsm;
 
 extern int audit_filter(int msgtype, unsigned int listtype);
 
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index b58b0048702a..b15222181700 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -113,7 +113,7 @@ struct audit_aux_data_pids {
 	kuid_t			target_auid[AUDIT_AUX_PIDS];
 	kuid_t			target_uid[AUDIT_AUX_PIDS];
 	unsigned int		target_sessionid[AUDIT_AUX_PIDS];
-	u32			target_sid[AUDIT_AUX_PIDS];
+	struct lsmblob		target_lsm[AUDIT_AUX_PIDS];
 	char 			target_comm[AUDIT_AUX_PIDS][TASK_COMM_LEN];
 	int			pid_count;
 };
@@ -993,14 +993,14 @@ static inline void audit_free_context(struct audit_context *context)
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
@@ -1009,9 +1009,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
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
@@ -1582,7 +1581,7 @@ static void audit_log_exit(void)
 						  axs->target_auid[i],
 						  axs->target_uid[i],
 						  axs->target_sessionid[i],
-						  axs->target_sid[i],
+						  &axs->target_lsm[i],
 						  axs->target_comm[i]))
 				call_panic = 1;
 	}
@@ -1591,7 +1590,7 @@ static void audit_log_exit(void)
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  context->target_sid, context->target_comm))
+				  &context->target_lsm, context->target_comm))
 			call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
@@ -1769,7 +1768,7 @@ void __audit_syscall_exit(int success, long return_code)
 	context->aux = NULL;
 	context->aux_pids = NULL;
 	context->target_pid = 0;
-	context->target_sid = 0;
+	lsmblob_init(&context->target_lsm, 0);
 	context->sockaddr_len = 0;
 	context->type = 0;
 	context->fds[0] = -1;
@@ -2435,15 +2434,12 @@ int __audit_sockaddr(int len, void *a)
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
 
@@ -2459,7 +2455,6 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
-	struct lsmblob blob;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2471,9 +2466,7 @@ int audit_signal_info_syscall(struct task_struct *t)
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
@@ -2494,9 +2487,7 @@ int audit_signal_info_syscall(struct task_struct *t)
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
index 9ad475f6fca5..97b26c425ac5 100644
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
index 91e51ae759b9..ce220810e7f9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1692,10 +1692,16 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
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

