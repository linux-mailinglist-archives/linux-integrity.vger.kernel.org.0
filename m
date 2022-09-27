Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657825ECDBC
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Sep 2022 22:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiI0UFs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Sep 2022 16:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiI0UFU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Sep 2022 16:05:20 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E4E1DB567
        for <linux-integrity@vger.kernel.org>; Tue, 27 Sep 2022 13:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309064; bh=BtRtW9ZVkdHuXaIG0T6nfDaE6FbjRi+Nx2a1Gnk4big=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=RZfPUwYyqSE3cxK2bTNlPa1s5T2pQL7EVUNDNJoFOW6rOYigyuiENgsecASN5mO+mnIzcr0VPMNubHnJY+CwFs7eLyxgZtyD+B/udeqUrYKogSzJYRAXOOOJRd/AjTB9Jq1iSEGMoFkGt7Tnj112iXuFxOUM/3U+WUdNUJgoO0kOIZkgZruV1Wm2DNov+3kGlNSiiwHVdqE0+qpuTpCGzqi3wyxtF8mumltA2lMACm0vk4dEoO3LuS940GBW4YTNaxlcioZ+dICb7hpNo/fb39hlfUrnOQilafXs1TL7KkxmJb15DzguVY7q3Vyn6zQOlPfOeFeWyd4ofmfOPhBgjQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309064; bh=JQbB1U7IL3ukRIw9Desv9ad/QYbicfH4SidUDFFhN/w=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=NYFlBDGFTppcrflC2tEC6G8Ww45N13IxHMYK6niRBojv5fXAqDol5Dw4sN6MsJJrAOm1/4Zj0oGhXTPGYTV7o6ayRXQKLJ2HGeaf1a5/Qx1T3jobA/Ni0RfO9SnP1HDsch/LjQqCkhA8kc72SL+Rpxvdz1k2Isc/y8Rl7j6fjheqQY7r06EMIzTeiEDt4wAtbTQVglvYNczhKvEZpUQElIeSqz2Y2YGMMpgSDIvK5METZj8jEUIgwJ1fAUBzPQAM8IfpXuGqwlUwwHMLC93u40QKQ9G/z9vk2HFSJePRcvrSRignNYue1A0r0/U93iV7St5663OAfHVAiccmZZaj2Q==
X-YMail-OSG: Bti8MMYVM1nlD8H2Flb2sR5hxWUhNKapqLDDVNRV.S86758tZSZMf3tbIwGlzZ1
 cSPBkBs40NZk6seKVAZ.F6g9xvP7T0E1Z0Ovd.OQIyC72RLyCEZcb.y7Try.LBVdx72qRBkti6DE
 CE6XXSxeaeeTgcWJ3jMMaRsIZUJ4LrnX2GbUCTLYUYJ7SGUFyXn2ENIAj3tfl.SGJ0l0bOa95vLY
 2._npJRQAHv9MVF2KDrjEPiyZx3.o8COKhiGwHElQiw7HbZljMDZIgfRzR.6oA7g9cpnI6edlCHe
 rqqx8_YFO1gn4Sa4h5xOjEn7cz1XHViF.0XRVrfnvgmT5WpDAxwChgypF.HM7pdLg.pu0rKqkxav
 uWuxZUih_BLyAzvAqbiYBPZOaMeIOqAgwgFTY9X2iZfw.uWCM8rn3sw1xA86fTzd5mlBwA84pPIN
 eEv6we1bZQWQB3F2svE_ILoFRN9NaxJ6iy5iDh049Cd2vlis_83KV0LV1MGMwIpqRVaOWYFHG2Mi
 JMRjNDQybURt6ptkc12TA42Z8wZsAt3ZWeSwyU5I9XjZse1N.qEEZsX83ZC8C.dMcIlm8PJVIikP
 kEwQz29mZOPLo0DkcKvgRD4R5i2mldECkKd_W56z3IN7w.hqri74tEAOYKtOel0x0QQGUTzHhQTN
 e_CrqBTMNFpvYoni9rZ4lK1jmu9Y_MtIDQFNKQ8_EhZY9YIDeLIVzzsQM7XiRndUsCW0gn.w7esx
 3vwTtgdLaiSsHZ86oCKZCWVLE6fzU4DGQGIaMdA8tObEFGw51_j4otF4yXQ1GMgFFtI3zYUmRNK1
 wxq4Hi22GiTfuI_U9SQW5NIFAXRb6h9fbhCsXQkHtHpUmi630A7Bsoq2KgJ62U2p7LXrKBkg2C2A
 uJwDz.r6kUf9CTBjlfKXgNQDZf3.yERCCsGFon_9_4Y.R6m4QJfILJ0QQRWlS.LLpB7EFOEWurl7
 aPqceU0aOXMnP41GwuxhLYUNh9fbuEfAOJYzmGlmaKfXXOYpyAKaHAwLG.nTfyHjQANyI0cA.v2d
 LCKOTt.UJ1DVzAhxpTL1ks16VLKRlmgkeMYayW.qU0J0dCuG5GUGHLHHCSF0IiE68PnWaR3QRhxa
 UvZwpOlYCJPEIfeN.FiCOSCHpUkdajeOyE9jkiykOgoOWZu5VJobVbRIb_NrmBh6tGmmF3_f1AQj
 rQYB6AXlKNZPg.ND5XXpCOhZnltBAgPZ6n1NHkIaU1h9cM1DKxnJ.ppkEdSx6p2p4SzTdcOBJnbo
 afDZuEY90vdcmZLShIQqgOprcHCWdttokMujW4Krua6sDoO7xyEgMDvYDmO2d93PX2KNT9UZ4EG6
 djfjr_lbLVKbBKQf5cZiYL5y3gpu_4tB5WHC4Esnd6qbA.Uifq5PwoWgzo0dD2kHp7QcmBeSIe7j
 3M4uXtM3QYXT6ZiJ65x0jn1einI9gzf4NCxDsiOKIdxYxt0XaHXQvagVDySUxPfudVt5S3V1D2bE
 DB8r7bgZDKXrkqxsVZcOcsURBMBNcUK28KkXYsqCO5YC9VYAUMfAzYVHm2AWn7l7hLMN5os_9XC1
 3S6lA6Eqm4SxRUcrPmwr7ybFiuLppcKhWrcaJFhgUfluD2KvsGsB3mlvBWqZTUeyRQNJ30xdgw.a
 SmKjd5Xbuj47MYkdsuLrpjUOm2YcX_ZypPuQJhgix2cYbX9EVcmBUZXviny6bzCGSzc7HirX294p
 ujD_5mdtz3iR1NPm.G4ymsXziR.FgPcH_7EmmuKKhgdAvoakX9q_uj9usW4T00vAV4Qwg.DQUOi7
 9e2zKDWjr2DoxHReFeRT3474ZLordsCeP6EY7n7huxtqv4xk8QIt.nKXGwEd6yLepwLF4xNiX16a
 kEezMAeL0i3Kc1APg217_AZvoS42G9rseKrKkK0v4k7S4ur7K0v5EO6x9SWk2JgXucTJcUICVETs
 Dv4cPWBog3GjGb9o6FExDqA8vC3ocnJOQoreqTXlUl_rzwkQdSCZzE0Ll6vAa0v5ZkUpnYp5W2PN
 eh7dtYMeD_N9U1tG6hgw9nDZIC4dUXLNbsdmHK5uA63g425hsduSyCyPHDR8VrcpbSX2kIh3E4_U
 xky4w.wEy_R.fEe_sO_Q34wJHhCd8phlW9dDF7KwIHwECMAAGc9F71oBj1PKpRFz3OgZX_rz3Osu
 0ImChPYwpaGBFZEFik6PFWjYw_FpxGGhFc7VzdHzcFlhN.yk1drIRHOGXRQS_SC.lJAkid4xq7SY
 ZaMgc0BLhrZIEa5.uxu18vSisyNmoIiw5H.etlvgnhKhB0Zc2HcTz4eMj8Be5526ZcfaTgXRZnP5
 n1Jb9SSA674Fo
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 20:04:24 +0000
Received: by hermes--production-gq1-7dfd88c84d-mgq76 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 59c24ac7dff90509b43b845d0fe4485e;
          Tue, 27 Sep 2022 20:04:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v38 19/39] LSM: Use lsmblob in security_cred_getsecid
Date:   Tue, 27 Sep 2022 12:54:01 -0700
Message-Id: <20220927195421.14713-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927195421.14713-1-casey@schaufler-ca.com>
References: <20220927195421.14713-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
 include/linux/security.h          |  7 ++++---
 kernel/audit.c                    | 25 +++++++----------------
 kernel/audit.h                    |  3 ++-
 kernel/auditsc.c                  | 33 +++++++++++--------------------
 security/integrity/ima/ima_main.c |  4 +---
 security/security.c               | 12 ++++++++---
 7 files changed, 36 insertions(+), 60 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 0ab1d5179fc4..6e1e35de1fcb 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3171,18 +3171,8 @@ static void binder_transaction(struct binder_proc *proc,
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
 			binder_txn_error("%d:%d failed to get security context\n",
diff --git a/include/linux/security.h b/include/linux/security.h
index ca5dcaee7c23..9f80b685542d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -521,7 +521,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
 void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
-void security_cred_getsecid(const struct cred *c, u32 *secid);
+void security_cred_getsecid(const struct cred *c, struct lsmblob *blob);
 int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
@@ -1162,9 +1162,10 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline void security_cred_getsecid(const struct cred *c, u32 *secid)
+static inline void security_cred_getsecid(const struct cred *c,
+					  struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_kernel_act_as(struct cred *cred,
diff --git a/kernel/audit.c b/kernel/audit.c
index 4e13e48afc06..3d026013e6eb 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -125,7 +125,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
 /* The identity of the user shutting down the audit system. */
 static kuid_t		audit_sig_uid = INVALID_UID;
 static pid_t		audit_sig_pid = -1;
-static u32		audit_sig_sid;
+static struct lsmblob	audit_sig_lsm;
 
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
index ad5f33af3b50..092aba46a9b3 100644
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
@@ -1091,14 +1091,14 @@ static inline void audit_free_context(struct audit_context *context)
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
@@ -1107,9 +1107,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
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
@@ -1789,7 +1788,7 @@ static void audit_log_exit(void)
 						  axs->target_auid[i],
 						  axs->target_uid[i],
 						  axs->target_sessionid[i],
-						  axs->target_sid[i],
+						  &axs->target_lsm[i],
 						  axs->target_comm[i]))
 				call_panic = 1;
 	}
@@ -1798,7 +1797,7 @@ static void audit_log_exit(void)
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  context->target_sid, context->target_comm))
+				  &context->target_lsm, context->target_comm))
 			call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
@@ -2740,15 +2739,12 @@ int __audit_sockaddr(int len, void *a)
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
 
@@ -2764,7 +2760,6 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
-	struct lsmblob blob;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2776,9 +2771,7 @@ int audit_signal_info_syscall(struct task_struct *t)
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
@@ -2799,9 +2792,7 @@ int audit_signal_info_syscall(struct task_struct *t)
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
index 25870eb422d9..ecaa0b96bb26 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -488,7 +488,6 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
-	u32 secid;
 	struct lsmblob blob;
 
 	security_current_getsecid_subj(&blob);
@@ -497,8 +496,7 @@ int ima_bprm_check(struct linux_binprm *bprm)
 	if (ret)
 		return ret;
 
-	security_cred_getsecid(bprm->cred, &secid);
-	lsmblob_init(&blob, secid);
+	security_cred_getsecid(bprm->cred, &blob);
 	return process_measurement(bprm->file, bprm->cred, &blob, NULL, 0,
 				   MAY_EXEC, CREDS_CHECK);
 }
diff --git a/security/security.c b/security/security.c
index 563452000729..80133d6e982c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1829,10 +1829,16 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
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
2.37.3

