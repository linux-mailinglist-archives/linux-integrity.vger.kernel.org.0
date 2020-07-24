Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D3622CFB2
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jul 2020 22:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgGXUo5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jul 2020 16:44:57 -0400
Received: from sonic311-22.consmr.mail.bf2.yahoo.com ([74.6.131.196]:39452
        "EHLO sonic311-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726438AbgGXUo4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jul 2020 16:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595623494; bh=eNsmyP7MLSBU10jhu6krGBGw9ReNHenWww/zw61E2yA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=VOCHOLPlBLw/Co8wMtjYaP2Q+kJooW0tWgMxet1zdqkZGQD8oTrj2OF1LG4tNZPbiVLLIoBETx7vHsjlxXT0n/NCfXwDyUbttYp2R3YoFG4mTPggcLehpt0I5aWWtEdhhzaEt8npPfwHbFC5uKa5XYGtWLZJNjVxa7EQhv/RN8WuBMd37i79Li7M6YUS46dSvSKSjN4MR9n5Rw/05bcSMOJVGrBAMP2DENGNevoe9Pg9RVK+J9V6zZtQbXlbHnKqma07C+JBq6w4dfsOx1EM4TYlqxe7/7m1AmfsyzWZ1xOOYqtprwh/uD3NwUi00JPSxRIwz3Wyht1bjo6tuIUm7A==
X-YMail-OSG: Gd3ih.AVM1l1L12rppLVOD3XNW.G74BVmqti6oNW1AKhjynTus8Na2H0z8g_1dW
 _5CHno46cCK30fBSEsamEzrDb5WsW8a.KoH5bVlgsNwFdjvdS0JKU2tFkMoxWGLboJoytFVPBk6V
 k6b2wE0GYnxTcFWHp6ZVtdT7eMdQJFHdgWdcH382R1EQIwbVP00.oY1T2Rt7c6QT1HZJdcU6jH_9
 Pers0R7yKZPJs8fItP5opwc_tedCr14IwFm_WH5AlXG_gmjrgPpFo0WDZboH.xCjlijwVdQ3lfGg
 7sRu7vZNl2cU4OWxt9iUH0BjkjGurwqDd1MSaCucN.5jLMnAtGcZ9u3UgVp2dPy93qEXAmBPOsC2
 DlOuZEcVW2KW86ewZuUiqkC_NXFn7yyPFLXF0eR8aZD4BkqBQAJu1r6WKBViT7lI0oJwDRgj_7gf
 jaqfaM0HERyoNe6NmQSUHZyuqWu7zOXB5iMPOAaZulC6K2OobQUubN0KHIU3tNzhxNITWCreW5Wy
 W7lV8y.lEzBrKZSylX1NHdDhfiaNxb1j8eKVabyiU50QJxGejErgmyTxa_slPuxediOi15U_5eMi
 HWZeV8yDt9XJfokIHPAmpQYCkfmZVcRNxU1z655CrS8AkHFplc3SHNZD5rjNX__ffhK801R1kTWE
 8NAz4S23bRGA1Ma4CK6Aa5ZnGbWPiS8xor89ujhHEZdOBqwZIY1jviaf0hCW6RTp9NF5deIlfEqd
 bMhPd6rdqFoS6XcXSwcO48cMZWXdUkBmBoIAO1zLngRINmwPHvqv6tyycMmkapCPV5Rm1uYJ82eN
 7pNr9h6SPJTntjDZRX5pk1_QEfb7s5fAalN3vuRYMVrhp_ZCKkAMBy7BBpviAFje7Zq_ktj0Zupo
 Y4EE4KpZl39nVPDw.L9oI2wcTp4il9feixga_Nk0igvC1JpGrDZV91ySoAkyIOelq2sDHAEXUorj
 bmSREsgfoZM0OT6uAzvdapuqsZg0eu8l6Vz1oRZ_1PpUWu0oRxdzTGCYQwiTZwI5a.vpq1tIHNNL
 2caNmzJI5x2KlbWj3P9E0J0eE9Ev1.XA7HT72nGRi4eMzzl1jxORn2YNKw6mb3f92_cN1NROXI9O
 9I_he4SC6kAagEPTfVeBrWyoTPxVMnwwMWHC_UWApPwdEKqxXvBPVnrnjFiGAXE0IXl0me62ujW6
 8.tLFzBfibjvce_9TXl49zKN9UxQWJm5dTsG7gL76knC6.w_1DMzNKAYEIYExVdhhi4kVcqMaEqH
 R6qnNl.j4UP5zWeaFk2JtgJ4yNr5VW9V55yu4l31z2_MKWODbRqCtc.yrg.xQIi9aTrE7ZprZT2r
 W_0YkSKxAPSXFtcgINp9SZ7GC2BwQ7TMSTAgOGvlXC93d3E9sppocsaHe4c_kBpNLe3IMwQ9b0z4
 8TH7FiaKOE.GDJ3aZzEMbGR601wNiLiBu16OP
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Fri, 24 Jul 2020 20:44:54 +0000
Received: by smtp419.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0275344c7523caf7a30259e92eaa5470;
          Fri, 24 Jul 2020 20:44:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-integrity@vger.kernel.org
Subject: [PATCH v19 11/23] LSM: Use lsmblob in security_cred_getsecid
Date:   Fri, 24 Jul 2020 13:32:14 -0700
Message-Id: <20200724203226.16374-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200724203226.16374-1-casey@schaufler-ca.com>
References: <20200724203226.16374-1-casey@schaufler-ca.com>
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
index d641c6dc5933..c3bac45bbb79 100644
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

