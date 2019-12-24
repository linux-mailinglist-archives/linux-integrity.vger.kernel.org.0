Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A13512A466
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Dec 2019 00:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfLXXPL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Dec 2019 18:15:11 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:42440
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbfLXXPL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Dec 2019 18:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577229309; bh=RkvET4aYIxq2mRrySHB2TvPobGrwSmKRPkZBTjOwhjk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=OYymjGFr/kRz/JzFjrcF6cbAXn8c3Ki1VuROL4gDeYRWrgNR57lmJudPlOj5Wc3T81itCWPac64xW75tOuFxbhKKU07Va3+gxh6xOIpI6c4JBT20T1IBM6HnnEnR/uGsPjlqUO3whtL83PwwZVECDlYzfhLQ8t0ynprdtS4jc22mqxr5cM6BgVrpJ/EhTj2FQcQYKffqhVhx/Z102D+j0ufb+jX9PUZNc+uiZF1INk41y71dp8d8YB6XUU1HRs6DAY6+PAeNGMNjtA/lrRCG8Thuciyj/UC4sM7c/djiKQvmvgKzCC9zuibKLUW+ySVvMTPdAnfNRe+JKJTOu1ythw==
X-YMail-OSG: I3ADwBgVM1k49N9Yt9wsMGx8.AOers5lfiqrjYggJPesJh50Dw5M_sfurdsgkJ.
 BA_A6UJRVoiXD.vOdrGReLKwEOhfpLYRywywiN3lvBVpLuZSgH2k.5HTbuyKZ_WGi5Qy.8Q4jbCc
 Um.2MU.Z16iFh2x4104L0OeI7B8rV0lxXSz080Clew8NJ2H5AwsGXz1WkEYMuD54cJkaCKl8DWWL
 r5dP9_8zp4ZmGbCkZ7bZfB3Acj45pmIgTHebxrE348PVbf._ncQOCpqg9_hDyhQ0FIBPkV1y42Ve
 hsSeyytYTCeyNzaUnJUqGQ.G6l17RB_667eSLZyNSjxGQ7f2cOTKthNGxz5H2LCL7sbKXdBsOW5I
 GWArT3OCHwMwd8TRF9NQGbWNpi1.nq1mUMwjZTNroZhiehfLprFB9rrgIC9PBwH2c5t9K31be8vm
 gnR4RqgsuZ8NEdBlnD_LwrY8T8rI0fSbC99HWb6xuHCNATLUM4J9OKSgZ32MqPSrXUMF5X88UoI3
 8WO5PorbzLxwjadpT3M_BOfMDfqKm22JSc3g1_oX1I1AU86HgchAOrdfHSg.RG5.DeNn25QloiQU
 0tnXpUrOL1Elc8Da8jvjsxJOPaPV.mnaG2y85Hdck5sOFUzsXfZrbtVwHWfIQzmJ0iJisHHjkqUf
 qDD4RVIy8iOrj72O1mbt1dIV3dNVN6y1WZ_IEyInsr3zzX6TcMwuvo7j8VYCbvk_Wfj___G8OVJc
 tUXSfYQ3S0nIagkSVo5ggUWDoP2zB1L3Q8ZNzTW3rPRsJx_5FepFbjRsn2LO3wm0ggXOb8FPqQzH
 c3d2Owl3H5L6Uk3cilKjUaFNJr981a8Vve0puGErRC3RQalzvMd0.aAZx7kMKUvM3gzfFYkYukaU
 gynhem1Negpho.oAT2zJIT3l88SNtajHxcX91GtI43xcKCsolytgck6qxuCTq1QmnPOtEnHcSjdX
 v8SAbyAdP8oSTaxY7ZDxDrUJ0KRisPtcjTC6phYUOkw_vOvRBFULFFAZbIdDg4ss9Sw3NA_QJ.8B
 Xrcw64sJTLc0kiUikXxujx9gbaf2oQfw1fDTgOOj1WqZHkiLhUYTAo7dSCtOUv7oW87N1s5tH3MQ
 jNgWO4co9bCuk.oCuWo4A6m0UCQvbf0BFO6XHxfYVTW15DAmkMVfu_AgyXNdWUw9DSNDNSCVZNBs
 M2IYNi_0CCuBKFijCxioSbDHZMkuNGoqGm.E.gTiF3kelC8swkh4ph3yVYOorhhzoTuF2fEGSQQt
 FSgHG191_M.sv5xDlVnGYNMG3kz6oi63l8ZYDkpt4bJ892q2x4i1SgH2rHydgTgbcZ2aUXY_Abll
 jg9FsSvfz.44HEC7.QK6rYdbnJfYcDS0IPHAhGklu0PV2fzzw4t9CRd.2udpdnl1o..mT0WPxMac
 LdiqVQoMrKVdcVrRu2kQU_Onq_yORQBsN62_ywkkG5R0UI86PgbchTyWu8GTo0w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Dec 2019 23:15:09 +0000
Received: by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0a4610c6957cb28ea900d02e5c3f48e4;
          Tue, 24 Dec 2019 23:15:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com
Cc:     casey@schaufler-ca.com, Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v12 09/25] LSM: Use lsmblob in security_task_getsecid
Date:   Tue, 24 Dec 2019 15:13:23 -0800
Message-Id: <20191224231339.7130-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224231339.7130-1-casey@schaufler-ca.com>
References: <20191224231339.7130-1-casey@schaufler-ca.com>
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
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: linux-integrity@vger.kernel.org
---
 drivers/android/binder.c              |  4 +--
 include/linux/security.h              |  7 +++--
 kernel/audit.c                        | 11 +++----
 kernel/auditfilter.c                  |  4 +--
 kernel/auditsc.c                      | 18 ++++++++----
 net/netlabel/netlabel_unlabeled.c     |  5 +++-
 net/netlabel/netlabel_user.h          |  6 +++-
 security/integrity/ima/ima_appraise.c |  4 ++-
 security/integrity/ima/ima_main.c     | 42 +++++++++++++++------------
 security/security.c                   | 12 ++++++--
 10 files changed, 69 insertions(+), 44 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index cd7a5f446457..a7a3b0737547 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3104,12 +3104,10 @@ static void binder_transaction(struct binder_proc *proc,
 	t->priority = task_nice(current);
 
 	if (target_node && target_node->txn_security_ctx) {
-		u32 secid;
 		struct lsmblob blob;
 		size_t added_size;
 
-		security_task_getsecid(proc->tsk, &secid);
-		lsmblob_init(&blob, secid);
+		security_task_getsecid(proc->tsk, &blob);
 		ret = security_secid_to_secctx(&blob, &secctx, &secctx_sz);
 		if (ret) {
 			return_error = BR_FAILED_REPLY;
diff --git a/include/linux/security.h b/include/linux/security.h
index 61a80afbbdba..b6d5475f8196 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -449,7 +449,7 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
 int security_task_getpgid(struct task_struct *p);
 int security_task_getsid(struct task_struct *p);
-void security_task_getsecid(struct task_struct *p, u32 *secid);
+void security_task_getsecid(struct task_struct *p, struct lsmblob *blob);
 int security_task_setnice(struct task_struct *p, int nice);
 int security_task_setioprio(struct task_struct *p, int ioprio);
 int security_task_getioprio(struct task_struct *p);
@@ -1101,9 +1101,10 @@ static inline int security_task_getsid(struct task_struct *p)
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
index e3e515158295..6ee53e43c986 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2062,14 +2062,12 @@ int audit_log_task_context(struct audit_buffer *ab)
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
 
-	lsmblob_init(&blob, sid);
 	error = security_secid_to_secctx(&blob, &ctx, &len);
 	if (error) {
 		if (error != -EINVAL)
@@ -2277,6 +2275,7 @@ int audit_set_loginuid(kuid_t loginuid)
 int audit_signal_info(int sig, struct task_struct *t)
 {
 	kuid_t uid = current_uid(), auid;
+	struct lsmblob blob;
 
 	if (auditd_test_task(t) &&
 	    (sig == SIGTERM || sig == SIGHUP ||
@@ -2287,7 +2286,9 @@ int audit_signal_info(int sig, struct task_struct *t)
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
index 356db1dd276c..19cfbe716f9d 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1324,7 +1324,6 @@ int audit_filter(int msgtype, unsigned int listtype)
 		for (i = 0; i < e->rule.field_count; i++) {
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
-			u32 sid;
 			struct lsmblob blob;
 
 			switch (f->type) {
@@ -1355,8 +1354,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
-					security_task_getsecid(current, &sid);
-					lsmblob_init(&blob, sid);
+					security_task_getsecid(current, &blob);
 					result = security_audit_rule_match(
 							&blob, f->type,
 							f->op, f->lsm_rule);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ce8bf2d8f8d2..cccb681ad081 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -444,7 +444,6 @@ static int audit_filter_rules(struct task_struct *tsk,
 {
 	const struct cred *cred;
 	int i, need_sid = 1;
-	u32 sid;
 	struct lsmblob blob;
 	unsigned int sessionid;
 
@@ -641,10 +640,9 @@ static int audit_filter_rules(struct task_struct *tsk,
 			   logged upon error */
 			if (f->lsm_rule) {
 				if (need_sid) {
-					security_task_getsecid(tsk, &sid);
+					security_task_getsecid(tsk, &blob);
 					need_sid = 0;
 				}
-				lsmblob_init(&blob, sid);
 				result = security_audit_rule_match(&blob,
 								   f->type,
 								   f->op,
@@ -2382,12 +2380,15 @@ int __audit_sockaddr(int len, void *a)
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
 
@@ -2403,6 +2404,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
+	struct lsmblob blob;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2414,7 +2416,9 @@ int audit_signal_info_syscall(struct task_struct *t)
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
@@ -2435,7 +2439,9 @@ int audit_signal_info_syscall(struct task_struct *t)
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
index 0cda17cb44a0..e279b81d9545 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1539,11 +1539,14 @@ int __init netlbl_unlabel_defconf(void)
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
index 300c8d2943c5..69e549164949 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -49,11 +49,13 @@ bool is_ima_appraise_enabled(void)
 int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 {
 	u32 secid;
+	struct lsmblob blob;
 
 	if (!ima_appraise)
 		return 0;
 
-	security_task_getsecid(current, &secid);
+	security_task_getsecid(current, &blob);
+	lsmblob_secid(&blob, &secid);
 	return ima_match_policy(inode, current_cred(), secid, func, mask,
 				IMA_APPRAISE | IMA_HASH, NULL, NULL);
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d7e987baf127..7c4bfc051ebc 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -384,12 +384,13 @@ static int process_measurement(struct file *file, const struct cred *cred,
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
@@ -412,10 +413,12 @@ int ima_bprm_check(struct linux_binprm *bprm)
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
 
@@ -436,10 +439,11 @@ int ima_bprm_check(struct linux_binprm *bprm)
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
@@ -548,7 +552,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		       enum kernel_read_file_id read_id)
 {
 	enum ima_hooks func;
-	u32 secid;
+	struct lsmblob blob;
 
 	if (!file && read_id == READING_FIRMWARE) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
@@ -570,9 +574,10 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
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
@@ -653,7 +658,7 @@ void process_buffer_measurement(const void *buf, int size,
 	} hash = {};
 	int violation = 0;
 	int action = 0;
-	u32 secid;
+	struct lsmblob blob;
 
 	/*
 	 * Both LSM hooks and auxilary based buffer measurements are
@@ -663,9 +668,10 @@ void process_buffer_measurement(const void *buf, int size,
 	 * buffer measurements.
 	 */
 	if (func) {
-		security_task_getsecid(current, &secid);
-		action = ima_get_action(NULL, current_cred(), secid, 0, func,
-					&pcr, &template);
+		security_task_getsecid(current, &blob);
+		/* scaffolding */
+		action = ima_get_action(NULL, current_cred(), blob.secid[0],
+					0, func, &pcr, &template);
 		if (!(action & IMA_MEASURE))
 			return;
 	}
diff --git a/security/security.c b/security/security.c
index 0d87a2349552..c42573958630 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1700,10 +1700,16 @@ int security_task_getsid(struct task_struct *p)
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
2.20.1

