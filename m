Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1958253310
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Aug 2020 17:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgHZPLf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Aug 2020 11:11:35 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:42289
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728068AbgHZPLc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Aug 2020 11:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598454690; bh=r3sLcbESGwE+s2XO4zqNwPIPI9k9iv2eH6+MkG2oZGk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ZWWA8/zPe/W6RXWPg5mZisJ1F7QPanODJhOtKsJ8uIopZHRbNDvLG+JQ8NVpd9AsxTidIun3tcp9IWV7ZbCjYho3OVsmP403gb/LRk4S1AeGjykhsn26uJhHIcXNqCOh0rHOOm+sQK9mzLLn+sSz84VO7nvRfaS/DrvX1aw4ckOdu49IMZ5GfgyeEHG4Y/RuAyxxrO3uC4amLh2Vw4ajYDdcppvBdUMuY4O8l4OvofcYfqqUbuoH6v2GqHvPAJsDx2oQYPzHpKdZfKLaN3LCFb/kLQxxEHcIEMefwM7hQaK4nReXRl5fEIIyu0H0vBDPzLwMLkgP1Z7GmmPm+9aq/g==
X-YMail-OSG: DIgtfw0VM1kSmXzBLiWU2LO7NqJ55CrFyswx3xYNUfC1pGWqNOUu9Wz3DqTjvD6
 KcVpzQMM1R7DEydRgZ0PC3fpI_.DAsr5NGGUXxwGefb1Cv_2fXorJ4jhH4T0pt5CIirtBy9VCe6I
 z92Z5I9zkOO8.26qkQHo2B0D7ZiLW8D_xMw2_DKLGk.wZrTdQemEOoQzzBZfkbVWg4q7XHI.cg31
 rMPsvJehitLvvFU1GTTFLW5HoM2D0INdkUe1LBuFPLEs2QjMLAgUMgX9TJdKt03RRcmhtNSSwGR4
 9djwv.Qm3Ju0TA_HS8cp.fS5ITu.TWRiAQvru7lHicgu3OOxLjomaaHMvbYjenNTld.YRjwK7cJe
 N.uYGUMeRpzEP04HXy.WBV1o.f.dZ.A1XUziqhN0rOZGtIJIjwkfFK_BlV2t9Q1CEf4wYGl3m3t.
 TrvbNwQOUUo1L2Ccd29L1KgUh66od0qrBRQD72ODIVXkyolgg9Sy2XtjSj6UFSK3MZoHRPS4UYB4
 qRxyomWqEolMQeCJ3wnhEIzWFE6M8Ppy2BmQMEZD4G1eyQZJQzMxi9L9zxcnkdcEs2LbiLlqyC_W
 KKTbTRGq0vifLQJu4.07mOUH0ahYfWGMN3LWM6Q6rLNELpByn3QZPgbm9z2ULGFEb4RoZIdHZ5zQ
 a0u2DsmeqDr_1A9SAL.XmzI5p849nAKWBw6VRYUksSxWwYGXOZQXXIGTm6N7pAUYpcNf3caZbNqW
 oCe0gpdlYKAw3jrC6bHkLGVzBJ.Frk1yPZH2kSoBk04NQLufE5cOFjzUYoQvGyYp3cz5kXV5MqmS
 P31Ou7m1ed.z5OsLtElfHHlJ_hwHsrFvrl0sZA.axEzRCX5krKTqoe.Nb4vPjMuUzNwLIGsQjEw_
 ki87mX2L.64.tBt.5b7hreJCcK4C2wdl7IdUSBbZNB_UoSkbSTsEh5h4t35uE9qoBXjwC.benY3g
 etJ.3R1nfIP9d3ynx.D_ZGy9gVg9fU.tV1cItfUtsrm7mg4k_KQDYahg0RTwvCsb0iKlWN6yWqGZ
 EYZPoPhwL6EayiOrKNb0e5Z5h0nwsD05VPEqjDPyqImbK4OLQLEGqrEZtDYxvnp0OYqA5OXNUzAq
 f_Jo_mvkZTuGgC6AO42ekT54OeDQWKUSGc.a6.rTjdmTQHkacCT7gt0h4slmUnGfbnX4vJTZX_WU
 _McUEnVtNSppXsFHSGdcEB6qINP2czAedWVMjAA6J_aVth3WVE_VbRRhFe4_3tNnCbjA8l7OwZq9
 JIA0h2m93VoDl2hVQ3FK3.Pma9uIWhPccnfDc5Y_YHskRFCGhXHKoyfYHxoH22PEVtNET07G5zMb
 3B7_a4Ur6EZlrkXW6fh5WjKv0ki.eltB6DD93Zpxb83ebtRry.bHAd3P8FSrLglmRi7WnmFJb38I
 Q3ONWTc.ko8d8eKeYnBWWidLzY6m6Fqk3lNwYpVhvx0jB2_3tTznXnC9hG2iTI6Pj3rNw3adEBR8
 4AyfI3nQH2tXo8XbLv2MNhHKLzXTxDawAnpyHPZtm_nwSlqNWUYlGaXMLniUIbLdkuBDSRz8rAXT
 BGWLQZxT2Miwe4wnujmYGB1KYnyk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Aug 2020 15:11:30 +0000
Received: by smtp411.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 973f7b0f4b25de49786483548626dc45;
          Wed, 26 Aug 2020 15:11:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-integrity@vger.kernel.org
Subject: [PATCH v20 09/23] LSM: Use lsmblob in security_task_getsecid
Date:   Wed, 26 Aug 2020 07:52:33 -0700
Message-Id: <20200826145247.10029-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200826145247.10029-1-casey@schaufler-ca.com>
References: <20200826145247.10029-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Change the security_task_getsecid() interface to fill in
a lsmblob structure instead of a u32 secid in support of
LSM stacking. Audit interfaces will need to collect all
possible secids for possible reporting.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: linux-integrity@vger.kernel.org
---
 drivers/android/binder.c              | 12 +------
 include/linux/security.h              |  7 ++--
 kernel/audit.c                        | 16 ++++-----
 kernel/auditfilter.c                  |  4 +--
 kernel/auditsc.c                      | 25 +++++++-------
 net/netlabel/netlabel_unlabeled.c     |  5 ++-
 net/netlabel/netlabel_user.h          |  6 +++-
 security/integrity/ima/ima_appraise.c | 10 +++---
 security/integrity/ima/ima_main.c     | 49 +++++++++++++++------------
 security/security.c                   | 12 +++++--
 10 files changed, 76 insertions(+), 70 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 40e5e2f5b516..1d9b0e385cd0 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3110,20 +3110,10 @@ static void binder_transaction(struct binder_proc *proc,
 	t->priority = task_nice(current);
 
 	if (target_node && target_node->txn_security_ctx) {
-		u32 secid;
 		struct lsmblob blob;
 		size_t added_size;
 
-		security_task_getsecid(proc->tsk, &secid);
-		/*
-		 * Later in this patch set security_task_getsecid() will
-		 * provide a lsmblob instead of a secid. lsmblob_init
-		 * is used to ensure that all the secids in the lsmblob
-		 * get the value returned from security_task_getsecid(),
-		 * which means that the one expected by
-		 * security_secid_to_secctx() will be set.
-		 */
-		lsmblob_init(&blob, secid);
+		security_task_getsecid(proc->tsk, &blob);
 		ret = security_secid_to_secctx(&blob, &secctx, &secctx_sz);
 		if (ret) {
 			return_error = BR_FAILED_REPLY;
diff --git a/include/linux/security.h b/include/linux/security.h
index 5f38bde9162f..56702d17c0c0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -477,7 +477,7 @@ int security_task_fix_setgid(struct cred *new, const struct cred *old,
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
 int security_task_getpgid(struct task_struct *p);
 int security_task_getsid(struct task_struct *p);
-void security_task_getsecid(struct task_struct *p, u32 *secid);
+void security_task_getsecid(struct task_struct *p, struct lsmblob *blob);
 int security_task_setnice(struct task_struct *p, int nice);
 int security_task_setioprio(struct task_struct *p, int ioprio);
 int security_task_getioprio(struct task_struct *p);
@@ -1142,9 +1142,10 @@ static inline int security_task_getsid(struct task_struct *p)
 	return 0;
 }
 
-static inline void security_task_getsecid(struct task_struct *p, u32 *secid)
+static inline void security_task_getsecid(struct task_struct *p,
+					  struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_task_setnice(struct task_struct *p, int nice)
diff --git a/kernel/audit.c b/kernel/audit.c
index 605f5125c844..0f7cadd5221a 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2137,19 +2137,12 @@ int audit_log_task_context(struct audit_buffer *ab)
 	char *ctx = NULL;
 	unsigned len;
 	int error;
-	u32 sid;
 	struct lsmblob blob;
 
-	security_task_getsecid(current, &sid);
-	if (!sid)
+	security_task_getsecid(current, &blob);
+	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	/*
-	 * lsmblob_init sets all values in the lsmblob to sid.
-	 * This is temporary until security_task_getsecid is converted
-	 * to use a lsmblob, which happens later in this patch set.
-	 */
-	lsmblob_init(&blob, sid);
 	error = security_secid_to_secctx(&blob, &ctx, &len);
 	if (error) {
 		if (error != -EINVAL)
@@ -2357,6 +2350,7 @@ int audit_set_loginuid(kuid_t loginuid)
 int audit_signal_info(int sig, struct task_struct *t)
 {
 	kuid_t uid = current_uid(), auid;
+	struct lsmblob blob;
 
 	if (auditd_test_task(t) &&
 	    (sig == SIGTERM || sig == SIGHUP ||
@@ -2367,7 +2361,9 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		security_task_getsecid(current, &audit_sig_sid);
+		security_task_getsecid(current, &blob);
+		/* scaffolding until audit_sig_sid is converted */
+		audit_sig_sid = blob.secid[0];
 	}
 
 	return audit_signal_info_syscall(t);
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 15a7fb80d6a7..31732023b689 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1330,7 +1330,6 @@ int audit_filter(int msgtype, unsigned int listtype)
 		for (i = 0; i < e->rule.field_count; i++) {
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
-			u32 sid;
 			struct lsmblob blob;
 
 			switch (f->type) {
@@ -1361,8 +1360,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_isset) {
-					security_task_getsecid(current, &sid);
-					lsmblob_init(&blob, sid);
+					security_task_getsecid(current, &blob);
 					result = security_audit_rule_match(
 						   &blob, f->type, f->op,
 						   f->lsm_rules);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 35d6bd0526a2..8916a13406c3 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -473,7 +473,6 @@ static int audit_filter_rules(struct task_struct *tsk,
 {
 	const struct cred *cred;
 	int i, need_sid = 1;
-	u32 sid;
 	struct lsmblob blob;
 	unsigned int sessionid;
 
@@ -670,17 +669,9 @@ static int audit_filter_rules(struct task_struct *tsk,
 			   logged upon error */
 			if (f->lsm_isset) {
 				if (need_sid) {
-					security_task_getsecid(tsk, &sid);
+					security_task_getsecid(tsk, &blob);
 					need_sid = 0;
 				}
-				/*
-				 * lsmblob_init sets all values in the lsmblob
-				 * to sid. This is temporary until
-				 * security_task_getsecid() is converted to
-				 * provide a lsmblob, which happens later in
-				 * this patch set.
-				 */
-				lsmblob_init(&blob, sid);
 				result = security_audit_rule_match(&blob,
 								   f->type,
 								   f->op,
@@ -2440,12 +2431,15 @@ int __audit_sockaddr(int len, void *a)
 void __audit_ptrace(struct task_struct *t)
 {
 	struct audit_context *context = audit_context();
+	struct lsmblob blob;
 
 	context->target_pid = task_tgid_nr(t);
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
-	security_task_getsecid(t, &context->target_sid);
+	security_task_getsecid(t, &blob);
+	/* scaffolding - until target_sid is converted */
+	context->target_sid = blob.secid[0];
 	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
 }
 
@@ -2461,6 +2455,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
+	struct lsmblob blob;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2472,7 +2467,9 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getsecid(t, &ctx->target_sid);
+		security_task_getsecid(t, &blob);
+		/* scaffolding until target_sid is converted */
+		ctx->target_sid = blob.secid[0];
 		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
@@ -2493,7 +2490,9 @@ int audit_signal_info_syscall(struct task_struct *t)
 	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
-	security_task_getsecid(t, &axp->target_sid[axp->pid_count]);
+	security_task_getsecid(t, &blob);
+	/* scaffolding until target_sid is converted */
+	axp->target_sid[axp->pid_count] = blob.secid[0];
 	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 2ebe29ddf05e..f4a6204f4205 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1557,11 +1557,14 @@ int __init netlbl_unlabel_defconf(void)
 	int ret_val;
 	struct netlbl_dom_map *entry;
 	struct netlbl_audit audit_info;
+	struct lsmblob blob;
 
 	/* Only the kernel is allowed to call this function and the only time
 	 * it is called is at bootup before the audit subsystem is reporting
 	 * messages so don't worry to much about these values. */
-	security_task_getsecid(current, &audit_info.secid);
+	security_task_getsecid(current, &blob);
+	/* scaffolding until audit_info.secid is converted */
+	audit_info.secid = blob.secid[0];
 	audit_info.loginuid = GLOBAL_ROOT_UID;
 	audit_info.sessionid = 0;
 
diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
index 3c67afce64f1..438b5db6c714 100644
--- a/net/netlabel/netlabel_user.h
+++ b/net/netlabel/netlabel_user.h
@@ -34,7 +34,11 @@
 static inline void netlbl_netlink_auditinfo(struct sk_buff *skb,
 					    struct netlbl_audit *audit_info)
 {
-	security_task_getsecid(current, &audit_info->secid);
+	struct lsmblob blob;
+
+	security_task_getsecid(current, &blob);
+	/* scaffolding until secid is converted */
+	audit_info->secid = blob.secid[0];
 	audit_info->loginuid = audit_get_loginuid(current);
 	audit_info->sessionid = audit_get_sessionid(current);
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 372d16382960..8a198fc98ffb 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -54,14 +54,16 @@ bool is_ima_appraise_enabled(void)
  */
 int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 {
-	u32 secid;
+	struct lsmblob blob;
 
 	if (!ima_appraise)
 		return 0;
 
-	security_task_getsecid(current, &secid);
-	return ima_match_policy(inode, current_cred(), secid, func, mask,
-				IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL);
+	security_task_getsecid(current, &blob);
+	/* scaffolding the .secid[0] */
+	return ima_match_policy(inode, current_cred(), blob.secid[0], func,
+				mask, IMA_APPRAISE | IMA_HASH, NULL, NULL,
+				NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8a91711ca79b..9ad475f6fca5 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -382,12 +382,13 @@ static int process_measurement(struct file *file, const struct cred *cred,
  */
 int ima_file_mmap(struct file *file, unsigned long prot)
 {
-	u32 secid;
+	struct lsmblob blob;
 
 	if (file && (prot & PROT_EXEC)) {
-		security_task_getsecid(current, &secid);
-		return process_measurement(file, current_cred(), secid, NULL,
-					   0, MAY_EXEC, MMAP_CHECK);
+		security_task_getsecid(current, &blob);
+		/* scaffolding - until process_measurement changes */
+		return process_measurement(file, current_cred(), blob.secid[0],
+					   NULL, 0, MAY_EXEC, MMAP_CHECK);
 	}
 
 	return 0;
@@ -413,9 +414,9 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 	char *pathbuf = NULL;
 	const char *pathname = NULL;
 	struct inode *inode;
+	struct lsmblob blob;
 	int result = 0;
 	int action;
-	u32 secid;
 	int pcr;
 
 	/* Is mprotect making an mmap'ed file executable? */
@@ -423,9 +424,10 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
 		return 0;
 
-	security_task_getsecid(current, &secid);
+	security_task_getsecid(current, &blob);
 	inode = file_inode(vma->vm_file);
-	action = ima_get_action(inode, current_cred(), secid, MAY_EXEC,
+	/* scaffolding */
+	action = ima_get_action(NULL, current_cred(), blob.secid[0], 0,
 				MMAP_CHECK, &pcr, &template, 0);
 
 	/* Is the mmap'ed file in policy? */
@@ -462,10 +464,12 @@ int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
 	u32 secid;
+	struct lsmblob blob;
 
-	security_task_getsecid(current, &secid);
-	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
-				  MAY_EXEC, BPRM_CHECK);
+	security_task_getsecid(current, &blob);
+	/* scaffolding until process_measurement changes */
+	ret = process_measurement(bprm->file, current_cred(), blob.secid[0],
+				  NULL, 0, MAY_EXEC, BPRM_CHECK);
 	if (ret)
 		return ret;
 
@@ -486,10 +490,11 @@ int ima_bprm_check(struct linux_binprm *bprm)
  */
 int ima_file_check(struct file *file, int mask)
 {
-	u32 secid;
+	struct lsmblob blob;
 
-	security_task_getsecid(current, &secid);
-	return process_measurement(file, current_cred(), secid, NULL, 0,
+	security_task_getsecid(current, &blob);
+	/* scaffolding until process_measurement changes */
+	return process_measurement(file, current_cred(), blob.secid[0], NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -647,7 +652,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		       enum kernel_read_file_id read_id)
 {
 	enum ima_hooks func;
-	u32 secid;
+	struct lsmblob blob;
 
 	if (!file && read_id == READING_FIRMWARE) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
@@ -669,9 +674,10 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	}
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
-	security_task_getsecid(current, &secid);
-	return process_measurement(file, current_cred(), secid, buf, size,
-				   MAY_READ, func);
+	security_task_getsecid(current, &blob);
+	/* scaffolding until process_measurement changes */
+	return process_measurement(file, current_cred(), blob.secid[0], buf,
+				   size, MAY_READ, func);
 }
 
 /**
@@ -755,7 +761,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 	} hash = {};
 	int violation = 0;
 	int action = 0;
-	u32 secid;
+	struct lsmblob blob;
 
 	if (!ima_policy_flag)
 		return;
@@ -768,9 +774,10 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 	 * buffer measurements.
 	 */
 	if (func) {
-		security_task_getsecid(current, &secid);
-		action = ima_get_action(inode, current_cred(), secid, 0, func,
-					&pcr, &template, keyring);
+		security_task_getsecid(current, &blob);
+		/* scaffolding */
+		action = ima_get_action(inode, current_cred(), blob.secid[0],
+					0, func, &pcr, &template, keyring);
 		if (!(action & IMA_MEASURE))
 			return;
 	}
diff --git a/security/security.c b/security/security.c
index c74c7722e5f4..01c1561901fa 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1783,10 +1783,16 @@ int security_task_getsid(struct task_struct *p)
 	return call_int_hook(task_getsid, 0, p);
 }
 
-void security_task_getsecid(struct task_struct *p, u32 *secid)
+void security_task_getsecid(struct task_struct *p, struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(task_getsecid, p, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.task_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.task_getsecid(p, &blob->secid[hp->lsmid->slot]);
+	}
 }
 EXPORT_SYMBOL(security_task_getsecid);
 
-- 
2.24.1

