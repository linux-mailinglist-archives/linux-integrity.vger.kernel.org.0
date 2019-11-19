Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF41102E7B
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2019 22:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfKSVqT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 19 Nov 2019 16:46:19 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:40377
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727532AbfKSVqS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Nov 2019 16:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574199976; bh=nTAPx/fjQVqMX27cfMvcQ9mzjwgWmVxFhIf02x5QyQI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=LHRYxu1PX+HMqwY4aCzrZsy6zIQAMXTlIHaMGnRwly8SchPVkZwsLGNfIpbHqZOZgE9x4B/fdpAYU4C4VJxj/Xq5ZvEmx013mxTWCJHrf10AfjZK9JJWfafw355i1p6HD3vQOITJUh01vOCaUzFs3CgyPNLbH0RFFTk7Zjt38vrLiySsyEbdvhUugsEQzZaxIMLNeNQAL5lMYpqkBQkn8+rwoe8ruvSkoMeLEmdlpNIBEk0ETuiv9ul5jeVs9m99W6q3KjiVbyiDp8e1kdutoGpOkfPF8nHQzb1bVVs/Py/7BpdE8VIBU1Vx/SYtYGanH06fHKHodsLkAoCxGxTXsA==
X-YMail-OSG: 3EYhlXIVM1mdQFrmDdAdm_n5bd4mAXI6FfOdwCESiDw5uVq6zCfs2Yoy.jSml0T
 We2d4G7XGG3lbiIOTQbfYIARyk21d0AQJwUR3OVsw8yVzY9H20zjJ5rMZOiqSDkgEZ2xug1lZvCw
 GK2BOku7m5TZU2Zm2IZS_0Xsw5m0p1JxoRQItyxb3zmVVJurhaPIgUitc8vxxCwUj_vnH8hthPSU
 LmtJ.BOF1sjuAws49aTbKOVWUaypqcQFK.oju2Kmn_r3U9thxb1trwfvup9sA43XkPUPR8kqgJ7N
 6W4ld7j.jIxjjfdgSxGSlX6mKfjmjlfRfy86LOE6gKHoEKO6qWwVmItjUrD73ATl656Sl6k0LszD
 Bue97l0b.XkPz0EUcaBkZcIWG5Fq.eLfPTvujN2IPS4rXahoXSfuhgRj4jCAL_R34.Ql9wLpY4aa
 5lBTs7W0Hpleos9ujR.GAnlNiWtX_ivRHTwVaen7bCjEva98ImkkfTrokzr0RDE8wLzUujUv7ty5
 rZuHBUJSMNVBBHhwemD40.wMgHpjoaYpJWmCQ.aDzc95YZ_72jEWkYW539Bl6Bb7eXI6gRd0FHQm
 GziZlA9HJbVg_dXOTKSi.FCYlGrqCYbocnkeSdixTMndJn7VBadI6x3m7fAivjsEZix4qmMeBsxj
 kcuyOKDryoBMMRRnHkSGahOXZQijzPwFseRafAMZ9PFYyC3vvqTyTKKfr2W1wmwf3Pxt.kzvmaUd
 5VvubRObu1ghiKjzpNmuLJkpzaojC.FD.6Cebnsv7SIqQX_.LOEjM_Kbv09NWQpGrAptbvI8iBof
 F2frinBJB8U1dyVlq5ZAK7Ar18pLjp3a7m8PJ6fOo.ge1LTgkrXhJaUwtmuzHMZG_R6NwXmWeCzo
 m8VEsyii5oooEjdf4rEyMdTyu0Jn2uNfACecMsAMaR2ujZ9gA6UNInLCokq4JnvYUjsPu.c0quK6
 xuoFPHZALgSXUIYVEe9FfiNfyFG_Jd3ZD2rghspFSkvIP.kiLv0g4cBnBumQaXoXKgf9hUVX52dm
 4CVdS_p3UtD0IrOsfINUftsLMz6nuxsCuAZwFyrMnuLCAx.39Cuszw.e.1zkviReFadfJDdL6bjp
 o0MCpV7euigpP3QqNinpsV7TofWIFfKohBler67veIowhwxcHq82D3aWsck8a_4e8Uyhpr.NjSST
 YyOXGxSwsVw2UttJNjzw4NrwBPaTNNuOpyvMOFZLQYhYHm4Wd7DNTc9M2HjCosXM1Bz1V8iTEaK8
 U6ASuMxoWSfY4e6faEII3c7BiGR21KYtjP_idliOSW8dcYNhprLfSBMhX1wJj46DALJ0IJYeLmI6
 2FkljiHbSAv35qB2H7rLSluloUYHns83L5Q40bEz_6pqehj2eSlQ_sUL2sFs0FoV.tlrRCx2ZNCU
 rIEBZk_5cuspTQVdC_GG.RGyPFZvfpmOr.t4siNUEsy980So-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 19 Nov 2019 21:46:16 +0000
Received: by smtp421.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ee2e3e844c72ed99628860647e58ca83;
          Tue, 19 Nov 2019 21:46:14 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com
Subject: [PATCH v11 11/25] LSM: Use lsmblob in security_cred_getsecid
Date:   Tue, 19 Nov 2019 13:45:59 -0800
Message-Id: <20191119214601.13238-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191119214601.13238-1-casey@schaufler-ca.com>
References: <20191119214601.13238-1-casey@schaufler-ca.com>
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
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: linux-integrity@vger.kernel.org
---
 include/linux/security.h          |  2 +-
 kernel/audit.c                    | 19 +++++++-----------
 kernel/audit.h                    |  5 +++--
 kernel/auditsc.c                  | 33 +++++++++++--------------------
 security/integrity/ima/ima_main.c |  8 ++++----
 security/security.c               | 12 ++++++++---
 6 files changed, 36 insertions(+), 43 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index a845254fc415..f7bc7aef95cb 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -434,7 +434,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
 void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
-void security_cred_getsecid(const struct cred *c, u32 *secid);
+void security_cred_getsecid(const struct cred *c, struct lsmblob *blob);
 int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
diff --git a/kernel/audit.c b/kernel/audit.c
index fd29186ae977..ba9f78e36d1e 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -124,7 +124,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
 /* The identity of the user shutting down the audit system. */
 kuid_t		audit_sig_uid = INVALID_UID;
 pid_t		audit_sig_pid = -1;
-u32		audit_sig_sid = 0;
+struct lsmblob	audit_sig_lsm;
 
 /* Records can be lost in several ways:
    0) [suppressed in audit_alloc]
@@ -1416,23 +1416,21 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	}
 	case AUDIT_SIGNAL_INFO:
 		len = 0;
-		if (audit_sig_sid) {
-			struct lsmblob blob;
-
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
@@ -2274,7 +2272,6 @@ int audit_set_loginuid(kuid_t loginuid)
 int audit_signal_info(int sig, struct task_struct *t)
 {
 	kuid_t uid = current_uid(), auid;
-	struct lsmblob blob;
 
 	if (auditd_test_task(t) &&
 	    (sig == SIGTERM || sig == SIGHUP ||
@@ -2285,9 +2282,7 @@ int audit_signal_info(int sig, struct task_struct *t)
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
index 6fb7160412d4..af9bc09e656c 100644
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
+	struct lsmblob   target_lsm;
 	char		    target_comm[TASK_COMM_LEN];
 
 	struct audit_tree_refs *trees, *first_trees;
@@ -329,7 +330,7 @@ extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
 
 extern pid_t audit_sig_pid;
 extern kuid_t audit_sig_uid;
-extern u32 audit_sig_sid;
+extern struct lsmblob audit_sig_lsm;
 
 extern int audit_filter(int msgtype, unsigned int listtype);
 
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 5752e51883d5..c1e3ac8eb1ad 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -112,7 +112,7 @@ struct audit_aux_data_pids {
 	kuid_t			target_auid[AUDIT_AUX_PIDS];
 	kuid_t			target_uid[AUDIT_AUX_PIDS];
 	unsigned int		target_sessionid[AUDIT_AUX_PIDS];
-	u32			target_sid[AUDIT_AUX_PIDS];
+	struct lsmblob	target_lsm[AUDIT_AUX_PIDS];
 	char 			target_comm[AUDIT_AUX_PIDS][TASK_COMM_LEN];
 	int			pid_count;
 };
@@ -957,14 +957,14 @@ static inline void audit_free_context(struct audit_context *context)
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
@@ -973,9 +973,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
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
@@ -1546,7 +1545,7 @@ static void audit_log_exit(void)
 						  axs->target_auid[i],
 						  axs->target_uid[i],
 						  axs->target_sessionid[i],
-						  axs->target_sid[i],
+						  &axs->target_lsm[i],
 						  axs->target_comm[i]))
 				call_panic = 1;
 	}
@@ -1555,7 +1554,7 @@ static void audit_log_exit(void)
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  context->target_sid, context->target_comm))
+				  &context->target_lsm, context->target_comm))
 			call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
@@ -1733,7 +1732,7 @@ void __audit_syscall_exit(int success, long return_code)
 	context->aux = NULL;
 	context->aux_pids = NULL;
 	context->target_pid = 0;
-	context->target_sid = 0;
+	lsmblob_init(&context->target_lsm, 0);
 	context->sockaddr_len = 0;
 	context->type = 0;
 	context->fds[0] = -1;
@@ -2384,15 +2383,12 @@ int __audit_sockaddr(int len, void *a)
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
 
@@ -2408,7 +2404,6 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
-	struct lsmblob blob;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2420,9 +2415,7 @@ int audit_signal_info_syscall(struct task_struct *t)
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
@@ -2443,9 +2436,7 @@ int audit_signal_info_syscall(struct task_struct *t)
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
index cac654c2faaf..305a00a6b087 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -408,7 +408,6 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
-	u32 secid;
 	struct lsmblob blob;
 
 	security_task_getsecid(current, &blob);
@@ -418,9 +417,10 @@ int ima_bprm_check(struct linux_binprm *bprm)
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
index bd279a24adfc..3aba440624f9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1615,10 +1615,16 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
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
2.20.1

