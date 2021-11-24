Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6285145B186
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Nov 2021 02:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239489AbhKXCBJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Nov 2021 21:01:09 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:39843
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239560AbhKXCBH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Nov 2021 21:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637719078; bh=SaFxVnogzJCq2k92oJIkP1y5i7oZ2jbyQ0ExTgBRwoE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=VsuByuzNiePh+HXwk4zu3+KvcANeHpivUTWC1xyHAY+lo2dwWoNUQs/tu6/cjZfQ1PtPpF9KltZHdUgbXYz1748VYS99Sro7QOOT7gsuIPrh0pOKMdbwzMIptVpLmfYhxzXJXIRKk/405NTu1Yt1TnWeuldcIQaGJVUxFsh2WH+hYcF8Px6T4JwKIwHGZGMxNnAhQLtqv+ukB+jS19DzA39VerHwTr9Fu+iPrPUEl1i/7tKNSLRkaOuhRDXEcuH3u91BarNkq1WrkqhpUwn0Mc4HdnAROF+rPTP3k74VON7MwhjZpeBQKhg+FzxY5VmxEIkKjljpB5aiH0XUNl1oZQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637719078; bh=3SwvkznlKQgH48hA1kOckf3NZlCA5/C9CZBFkyMOy6v=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FePZWN/OsHPokmVZBDGiOrzn6O19kNuk2jL8LcjwasiZxdHENSLctLZ2phVgm1D+ZC/IGR2oFh4/svuGH4oX7Ef2CZXZNC7vmyv5Y7/tYbODPJlFBPWeUapBCiXVMMsBk0f3wJ2QOBENLahVK3FAquPXhskj+zVVbKlPSW6jQXE/Ev/7ak6G7Q4PVQr9m8LfDCdV33Z6wVuzpnlRc+oAjGqIfd5SfYTbgX9Jp/OH9g8KSJcSbZ9dSfvd/gsEqK90sFa8RlyVS9vixI/3DnsvV9s/WrUeAXmN4XHqY5WLHOlztwOiP4MMd5eG6UBR5fy4lz/x+/Nx4fl4IG+DEylZxw==
X-YMail-OSG: DpqoLzYVM1kTH2C3DkX_NfQ0Q2.fl.Wcgi.cFGyJxEJX1ziXmkMSOh.KtBB5hD1
 kWDDE.R_hSORliPWQGXm1JQ0J1Hsc18gDEJo3xMjOgGandhtyUTUCAzn9mpLpyQhFxV5eTLKz89o
 deGHoPYqGo.7r0IzhhX.QRNEnfCDJhnk0IRn448uPv9Bv.EP7ymDw_mi5mAcLC0.DKmhN6HaTW2O
 DOWUjx5gHm1lYieCqCqInwopI29.NCepjoCrjDUeSVqH6md.wQ2bjUAYNy0Oqo6iO9QsHSXw1_Wb
 PJfjxrXqta5j8knBOBLsHduTB787idqNZYoQW96QgN2h5CkIuzbW4ckVKCTyaV3ow.._KvXD4v27
 E_6MS5pCVt0zoVn6_k8Ungxtgr2bMiGNowK__FaMJo7w5ygMa_tDLhZ0CVE6h.t6xz0qseVRtF8g
 lG7yvt2W_Vg.d30buJoConrOhmXHnB9DA5bzmSMxczB0pVLUpH3oyKQZpepP5agQXJCTjuZw.9n.
 oK6gcaWcURF9Th8A3t9pqI3EZZzX7PCAeZ7de7Ienz52.NQeFqc.9NbCxUAakLzw0z9WxTDhUa5P
 2iQRg1SWeGdgMDw_ht9uLh9ps0zcoz9KM.xWRhZcm9gOOtcwFxN2HcTpZE5Q5O1ik9lnI1nRjm2M
 YBVZ1mEqvDNKRfL6_E2ftc_sl5VCugjNvA59KQeE2WGzjpYoE32U4N99clhUwrBCpEiS6lIGtC.I
 t7OVdLy_lSSMilG74j3z_rO3YvPIP8ywQA.fqf.4iPRNttx0VTOLTtHLsqET5YW_8CRdpTuWJShU
 jP.LMxvCYAjvWmE2bSfurDsNFXKLE.LtcPFQUxH.e5ap7.pQX_vK7bDjexnJe9MXsf8XlOQUvi.i
 Q2.MxmITnCWYLe9hNjjM.KTxNnCorUJIxfYfXaW2kFGBaKH0SvdzRW3GXIaEHKhXOCOGDzddy_B9
 kiM5kOJRIlfatsKI05UUEYg5UnAHpTr88Q6ct1.FOAfSKhQAMzYo0xrFQxyzKbdZizBmh0uQla29
 zn7OfdRTpr.Jn33ws_iU1iHJSVAXh87f3AqmmX3vXeOcvVo1Idqt6vAn8BAExPvf_ieXUFFW9_3R
 jY0RXMulg6LV9lF1lpakD2IWhUZV5rFHxGY7oeZfcDOENdWAqkDeLqiBXppGRgSvnJhcUt.VnwEZ
 m1lmybg_uZUoAPn3xldZBnxVlw6aWzgdwfgqq0.xX.SXPNr6Temj84Uhrxj0sK50xNJ2GldIXPO4
 tRHaBTvI6zT5Z5fSna6qYg85n7EQJC6cjD_fjWSRQbPUWz8kdJZUepO.XOQqP3H3BjhvylbBzwxd
 bBnlYesyvvUen1oeD8JJO4CRVDiQsPpR8iVHUk.4MnmVrJs6fRt4eUrD.gbnEui_TVxmX5KV_FHK
 bYo8nQFA_5Ea5KGGO9aW60wWcCke3NWc_wX3z5PUM0ZXpPuImRkHTqC6WX9QZT1K8QPTwUlCTAQS
 j3g50uxVESUxzQ5fWmW1UkvMhlbQnKYGBNKVOAQAZoKz3kRJ425dimnUbf0X8.euvV9tX5jBOwdT
 X7a4wixhG07q2XDncutx43ZXPRJ16HTANM2ElSBQ4Om_nNkxHTBTE1yjYA_NzP3QAMCNLWg3QD8h
 I5bgu1ALvNYSfr62wQPj0bAlLORM0U2ujlvc74RZ5BukLrJ1gBIt1k619px5JcAEabH3qWlysODC
 3IgATvTe3_oOUiNUc2f.UqnNT3VUKLKA5f.OKokN.6J67uAi4KvS8HzYINTluwsozVn6spiZ1VLs
 D5uxAVEEKmKLyyNCJIGxcERzgRlA3XUNsyHectfKCo0IXsAq.ujERkmCY4kw0MIGTUIGLK5cz4L8
 vQuSeKce2gotjmcWfyTUdRughH0cg7WRI1i0XhTIvJgdjFyb.TI_AnyaZAS__50ni6ebUrxE1KOW
 ny5YgFmWMUURCBanEWqlHpxsRh0q0AMOSwc1YNIQJdszxoDPb5tCrIifgbAxdcC71grkSlVzIzWg
 _4rSp3r1ryJ9BSTzQKhKIk_ZcR8M7fHQt3zS0v7c9wXeQOVbv8ZETijX4tVg_c3Aes9lT_MLiddf
 s4wRzeUjZ2jQNDtZX7u2DkCMefifHohXCcijElaAY0pa60iRcWAWRGsbXXU6yTZQWtq2VX8QlmWo
 dUPDPNj3JpS8KkbvqYhTcFrUd_RecAWDXQkq3NsmlQvmQO1WOfCPNG3Pn53QEmZg04smHhITMbXo
 SqSXmigbLrWvFcy2JA9fMwwjLld6W4y0LSIUDYp.h85dPr5pHMRg1vbwZdGEB2tX8zFo-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Nov 2021 01:57:58 +0000
Received: by kubenode551.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID fc90a0548d4652347091e08d13a1c44d;
          Wed, 24 Nov 2021 01:57:55 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v30 13/28] LSM: Use lsmblob in security_cred_getsecid
Date:   Tue, 23 Nov 2021 17:43:17 -0800
Message-Id: <20211124014332.36128-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124014332.36128-1-casey@schaufler-ca.com>
References: <20211124014332.36128-1-casey@schaufler-ca.com>
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
index 780c7e265f3a..2be77ae9ca52 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2720,18 +2720,8 @@ static void binder_transaction(struct binder_proc *proc,
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
index f324acc2c029..5271b2f4dfca 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -484,7 +484,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
 void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
-void security_cred_getsecid(const struct cred *c, u32 *secid);
+void security_cred_getsecid(const struct cred *c, struct lsmblob *blob);
 int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
diff --git a/kernel/audit.c b/kernel/audit.c
index d92c7b894183..8ec64e6e8bc0 100644
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
@@ -1441,29 +1441,21 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
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
@@ -2352,7 +2344,6 @@ int audit_set_loginuid(kuid_t loginuid)
 int audit_signal_info(int sig, struct task_struct *t)
 {
 	kuid_t uid = current_uid(), auid;
-	struct lsmblob blob;
 
 	if (auditd_test_task(t) &&
 	    (sig == SIGTERM || sig == SIGHUP ||
@@ -2363,9 +2354,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		security_task_getsecid_subj(current, &blob);
-		/* scaffolding until audit_sig_sid is converted */
-		audit_sig_sid = blob.secid[0];
+		security_task_getsecid_subj(current, &audit_sig_lsm);
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
index 3123c97d13b3..7d256fb2ec03 100644
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
@@ -1009,7 +1009,7 @@ static void audit_reset_context(struct audit_context *ctx)
 	ctx->target_pid = 0;
 	ctx->target_auid = ctx->target_uid = KUIDT_INIT(0);
 	ctx->target_sessionid = 0;
-	ctx->target_sid = 0;
+	lsmblob_init(&ctx->target_lsm, 0);
 	ctx->target_comm[0] = '\0';
 	unroll_tree_refs(ctx, NULL, 0);
 	WARN_ON(!list_empty(&ctx->killed_trees));
@@ -1107,14 +1107,14 @@ static inline void audit_free_context(struct audit_context *context)
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
@@ -1123,9 +1123,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
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
@@ -1753,7 +1752,7 @@ static void audit_log_exit(void)
 						  axs->target_auid[i],
 						  axs->target_uid[i],
 						  axs->target_sessionid[i],
-						  axs->target_sid[i],
+						  &axs->target_lsm[i],
 						  axs->target_comm[i]))
 				call_panic = 1;
 	}
@@ -1762,7 +1761,7 @@ static void audit_log_exit(void)
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  context->target_sid, context->target_comm))
+				  &context->target_lsm, context->target_comm))
 			call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
@@ -2698,15 +2697,12 @@ int __audit_sockaddr(int len, void *a)
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
 
@@ -2722,7 +2718,6 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
-	struct lsmblob blob;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2734,9 +2729,7 @@ int audit_signal_info_syscall(struct task_struct *t)
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
@@ -2757,9 +2750,7 @@ int audit_signal_info_syscall(struct task_struct *t)
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
index c327f93d3962..1a4f7b00253b 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -486,7 +486,6 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
-	u32 secid;
 	struct lsmblob blob;
 
 	security_task_getsecid_subj(current, &blob);
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
index 54b5dbe63265..f7af2444fcc3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1800,10 +1800,16 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
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

