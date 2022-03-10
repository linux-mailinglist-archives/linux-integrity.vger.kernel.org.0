Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95AE4D55F8
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Mar 2022 00:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344998AbiCJXyP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Mar 2022 18:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344980AbiCJXyN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Mar 2022 18:54:13 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA43C14FBD4
        for <linux-integrity@vger.kernel.org>; Thu, 10 Mar 2022 15:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956390; bh=GO/Bqxwgc9VQWSjrcC6II8HoCihtitHg+71BIsNkOkg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=bcribzaxukC//3I43/UEOxJtsaOp4Wrt36CinOvSDlTRKw2L+HF1xUxbajY6bOtv1mo7gFJkKhrhmQ10jNIaqL/Cmrx5cIstFivUzaK5/ERi0G7CLXBwgVmNYuvNOtOtD/5cbWKyFNkkiGHPZCBhq8KwxGh5e9j75ARhpeDTmujbZOVo4o5tqRYAU0jyvEIAbbi0GMSGlvNzTcZY6ZkpMlivSjbBCLBawtamLVz/QUsJDcB5IVNP3vX+RnKFBFL1BNn0fnXsiniNBL4lZ+B82Nfs3Evv66rnaClF9sxUT+ibZrlJe3dpSA6XSM9bO22JqY9yhzEYzOR1ZNuFwlVbGg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956390; bh=j/dTt1Kuc63+yIrAWM78sgq5GtPXFBERyH8Dj0q3xw0=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=N/BPgceDDuGpnWlovQHVyrOcwkEuhQvmz0SIidArqzpSHtCxjFecD2EQyAY4TSC62JidrzbH2s8DxGWoNwj9U/qGeLbQvg6Dt7Nk3V4QE4e+nJOkpSE/4DKLM02nzRpC3RIAmIsw7/LoLkXUy8C/jAdlAU9PVbGL165r5eYYjr4DB53WngCHA+E88px5P2G2IkpYt80IOw8/EPjLNVGdgVknfaIsliEpxQRQhYZzcb9uXTLchX9Qvj1VmAWHRCO7geV8ZJgHhw5OegpvR8sAx5VFFMRTBIjWotzjvCpKmruJHbPvan6pd8mS1YkqIxeJmeVwsCdIIGYePJfMrAoBaA==
X-YMail-OSG: aZ.0F7QVM1mM.6wziF2fr4zOpZHqxuFodqH_5qUEAYuTQZTi0rftXiQ7yImRaP1
 CJlMTSt0US3guItLiPMVydBGe7gU2xAcuvwx1UDm5Yvc_csLo4KfVHm_F4FzHOvUhhcT.jZ8z6Pq
 DE22oSUlCvnO5sX3LXeJL7K52tw7gDi9dcwIva4XbxsB6ssKlv8nLZTTrymEtyhdDZ7jm1yY4u34
 OC7MazEowaQEocXI8Xh75BvrNw7hfXVeRXrFrvMlRKc428k8.1ySjCIuvTGP8d1xEnccEFSd..t3
 Ui3H5bKHcvmZnSdGo.B7l.NIKIsGfbCXAPadfiNytFxXBnmL.L6zLglpJ2VQL4vmaTZnq5qYY7D6
 wWuDFCJcdqzrVTIq1VbVt9aHm8MHEAE_szHOuZaR71msR0gOedVm9tdlDutYL3qjDT.Njq2Nu.Tj
 J6SNslxW0NngnCaKRn.tuyCW58A1wdqKr._GkeEyurZ2uGMwQtimaHEnuEAj.N2mvAYumCNHl84t
 lmw3ER55TiyOD8cwstNP3a2bfLljAc1yOLpI6hEPVLASQhUc5dUSCzBOvRiC79hJ8E5XntcTfWH7
 MTRCkJ_xoUq.GdC_GIZaFolAFLiGfYdUyyDFVZ9ZFoKtN25CTgy4i4E4it5zXMF4aOrmaU1KAL4s
 33ED1NysFVGXA6qhqtkzgJLvX8WBIKD0WTtHpwor_Sfo3Bibf6LuNOPjEOPK5_dmmqOLgNtb479l
 2RrRxq4AtWwFGu.pKxzF1tG2CFOsG4ry6VtC5LYvPcTZX9xaGbOSP7xSJ3KvlMJDCRRTo34a3VHk
 0LQ5dvfr3n6qMcWZtvE60pd_Kk0bwCyCblwda3uqII2.Y1rpfBa3uvSEqOtndIchUozsyA4ZKxR_
 PFk6sqWY11SYYKJ4kP4aFg8rZF3oVDUUpViME.NB7WIvlg_LwyEM3ila2ioagJ.ackkukOwqhpjB
 pUJGwUYSgMcWxOHJwB73oP9vDPHTtETHQvfmD7xfzQX3zz.xBOqWLH3t4s.mXMKMw8HCc162j.Oe
 jJxbQ.qN.1K_sI5h1HZ_4zaLz4p6ENK3GR3.MKhTz8LfIeFTsCkzh1nmMlEKY31rikQvwJNWoPIc
 9.il258YKJO1i1E3K3h_gWLHwDBl9ijkHODkP6qk4kVK.qxiJ3jjYjp_hrG3xmDRQHI8NKgkZeCX
 pWZUbyyBoaSqVyTihVRDOOk9TCFMbDj6G7Hgk7R49qdAC4FNdFI5VxtcTq6ZEiK_FsOc0kwY2MXE
 hFLebJJZS7i3QGyq7C3c68DqLgZoDq70cS7Q0GPupZP_H5sRVTVm8lEgg99zaCaf6LX9KJ1FJmGw
 krRr7.DV0X2R2Qw4jEFIEQqaSGW6GQFjkbuzkuhkdlyr_qJRUD1uXo5Vzwa8FxDqnRUeIWctrJUe
 W4e1.KwYe.1d9U15VJ6DQNotKcpZPdpQf.TYK6pHyQcW7BSNew43erNX2P_BZk_hKTMWv7pcPC7k
 2CYfyiXuSTduNBssahtBNk6BiCcBR044bbr8G4reAoY2vqYjWZe1HY3SJHHVm80lUZ926eyEpOCf
 bqR4cZriYDn978XkPQft0ibR4gH296mx3HH2J61svYGIels7xgF5MLAcMmszjcUDqpUKx4SjPYgv
 RtZgMmqpULqgtACjWMd.ODUx2FXKbGZDCUBhWTO7REATFt__RZtymf6qrBHiH9KIKze75qatHaBM
 IvMmgfzLd7rWFflSCVq_jZ2N.OtDCGwdvYnQgQ_s9eJ6gDEUYrx4xu9LAAdRXKr8tfsKQlmgFLdn
 Nsqyfl4HHYXNhc53sFyLFtt_tVwjEVbBhHs6N_giCK67Q7xVA0nywjg0Wiit3XM_YJ.xEmeC.HNa
 GU68DHonNO.vAoeTLOt27JsKhlExcg0tF_bCkbllwpSRfkgGDy419Kpa6ItOXIBoDauumDNDm1cQ
 NxUJx88DRYSMzninHW7sKFXjcUtZVwzSaWmHslg7nqkqoaDwvgJ5r30sUNbSXPgocsxxQs8aMY_C
 e9eihdFokL7KIH0iULCHLCER_pnBWVriPN_44XM7h6CPFTcV2yWXkHCev_FVaKLTvB8q.kNR7oou
 HIVqyK05wBXQqEKvSI72N0KkttSRmpx1nbFEE0gJdVM4xZ80heLXKqFvDXfBzpfjxtBTkJIXA6fB
 ai2HnYzr1LbVBlGJZjgIFfMxl1zKp93umivtKaFmyzLxG.pKRkzC8kQUPYOlj5KnMhqUyjZhXvWP
 4GFM40B8A4Xp894RRPn9aYumbqvjHMpvRzHBktZL0p_YUoBRZW002upvU3DEIyXrpoDE8f99E0q5
 S
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Mar 2022 23:53:10 +0000
Received: by kubenode525.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5fda70cf8d38a19ec9bc1b4fcf47812c;
          Thu, 10 Mar 2022 23:53:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v33 13/29] LSM: Use lsmblob in security_cred_getsecid
Date:   Thu, 10 Mar 2022 15:46:16 -0800
Message-Id: <20220310234632.16194-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220310234632.16194-1-casey@schaufler-ca.com>
References: <20220310234632.16194-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 6fc573d2c253..955f75fc1007 100644
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

