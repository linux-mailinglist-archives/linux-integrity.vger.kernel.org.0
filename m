Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4ECC4738FD
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Dec 2021 00:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244315AbhLMXzF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Dec 2021 18:55:05 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:34888
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244313AbhLMXzF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Dec 2021 18:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639439704; bh=v2ArQcc4YgITLhmh4+LVreIOeftCXoVuskiPNB9noNI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=nPYiCZxMvYag9EIHbYJMkRB7ReRZKD22ueb+ta5A6hR1vEkOf3I7zfIeLy4ec27Yh9d/I3o42kV2NUcgQL4BwspmDEPt4pEWaZT0mgaKM3Sm0ZLTCltc64KEsCiK5jTnJIKtuN4gMy7QTINMeiHSzJQsDDzsfRrTADDtKjmHMVibnMjTfyWB7RtKt1CvHsAZGbXiKXaA7CUbomAM5xK8jQiifbEv9tksnTgpBa4soLQ+M2xViV6UTfyjuo5W5zGSfkNL09fbzO0ePHkYjUKL1rS83ZDf9bOAirrAN73Ai0vahpBrPUNwE3aWRz0M6SgYRxqEGydrANP6SIfRo/YZcg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639439704; bh=FLz2twA7hGTRRCzOuwo2f1c7jpAhX1CAHrIOzxRGMI2=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=mXtQPkp4VLDbXviYgo1c3VbefHPqz9hy1Sqt8899Pk1nvyL2AQpNzag1l+fd50JHneUW2dPYN6F60UCT7amrjHS3VyhTkP272QPbIr7ke/IuYWpiggK0i1d+L+4s2vQUOwW4KfKak2a/osqn99lQFRytFkKRfQXhCci2+pne4mI692txmrwAxMuy9g9lYc82s9+LJkLDZfGgT3Th1DUfiXx7LwZ9sZBhB9EjecWbSelP+i+FWVR8tJWEgtvcoTq6EI1IlH0FtIiDt8bdQKdcNSHhiXaavwTiNK4TvKVbYmCILPgiPROyMktSIVJ8h1ba54NTPxnQSMbw7g9UIr10AA==
X-YMail-OSG: v9GoCdkVM1myh1lIkfIO2XXQ_HxQLRAmdKkYI20nV0lBxBcpV9R3KXmJkLT5mVQ
 iNcqT7PL2vhx9yxCCXuJYO.JZz9qbcn7QCDnPoL3QVyK.TfAoAoUfONGUxZD0uBjgpEQh172RVRT
 xZLxeGOXi7uZIfmCTtAtCWLDtrruPhiBVIXJCFlewVkGhSvPUQ9WTcXYKLNdtCztDMqrNcjYLYbN
 2SEs6_24pIn.q_WFQA_nuhahqpu9iozmMeMKbSWORxFLFhWgErueFxCPrcNMpbzpQK0JGTAAz4A8
 stVSi5aMQH0mmAij5t8QYCcuZtROlbFMV4Va0UKnrvkcDgckj7Q5EYwCF1OiNtm5vLczuERyvtYp
 K_W79GQ8bDnn6c4QE0wQdG0Jg0YC4WSP.jUeG.ure2vjXY1hiecFzjtfv2nlHA.S0lOH8CNULfrY
 9ujqngbwVqS9QjHSzgyKiNCvwL83mMCHplHu4_QhxknhLmLJ3T8yGdmWWZj0OszoXhAX1TLVUJVB
 IoD6T9wG9GvOzAllAwQ3KNUSklaD5iY7pjsCtu2TyvIyvOgOowe3sycaRYxGt3Iw9suYfDcBNvwz
 SP8MPoNiPvAWYKi6H4xS6pTgGWsDszdNtiyIKQ7YIhexfBPwC_4BykCz7tcXD8E0TnOHasvxcdCt
 zfOETb0CblpHpqB83bcH86.ZqxZeSE2Cckica_ZR7kMRgC4_EmFFjENuGf6Mgtrjtv6BWPsA3i1u
 bILfN6fMl_18s_baWe416E0Y9ZIVD8TxBiuPgiMZs8CsbeSnara3ba_KQrivkfHaAuOKaJELat8k
 3HbdsWC5UzXqBhnhiXXdThy.MhA_YIyiK80fmAndKzi2ss.3zvd.hBYP3cJUyDynFKqgYl5KeggM
 reWyX8Hb.aqs_bMqLui00CexV4K0510jUgxaW11N07rH5dVK8186kVCDOpxhwz_1eH4B6MSq5s43
 BV5Wge7uzTdYEudmMZOvfx6UFi8EC5yJ39gD5yLiUwQwbOp9Y7l8yiT4bAtmJ_GwrVcXGrBobsQ4
 knYYyuE5DdIRC0Lmo1ZfiQOY90GYIBdEUg_Vyti_7EEZkqIe30c.Jczb7Tv7bu7k6GgCEKkMr8XD
 jLxFc5sHfqBNg5hz0TM5pt8XXxiS0_WHOBSJu0Kxa79fknh1ao4ndLI1G.9dBO5GQvsmQWyOOah0
 h7dCW1o43zg6p48GC8pJOl6d18Z2va.n3RmQa0DHptEtCX.f2tb7ta38tt.Vk1QtEDIuhIOWnZw2
 .TlQLvZJ3SF3cV8NtdSj2q51zY23QCenbydy5VEge2VnBaYDxhCe8UwQrG9BTHp.p.llDu1fSEF3
 gCyv6RDuwJhTjRwmzeiv021ZOUCepHVR.7aNmbh.r_6r6lAxn9yfo0gD_qmQd9E5KwquTx9kxl89
 qxGz3yjFtRAzKhGJhGPanw2X_h4P3MgRwatnfpvdjoIG.6BOL7WGjUSRiyHS2JWFwz4rATSGgVXo
 NL9pL9UcliRBUYiAaX5GieaV6euDzihj19r3aF4hR.PhLz5dCxAPZennUcbvmdH0R3SLNC82QFXm
 8kObtDqaaIejOLGFiWFBnxo9WXXVum..3oKwBVMPQtQvei0w319Yeld1fyKJJIFG70qvPiZWLnP0
 VVDmrOfD7mcm.hxdm4PwVaAFrIPjz7ReVpWEQFP2TSB679lcMKVteImiWmhNt38K_ktHkij_TRig
 epHoIac9Z9f4z6kDA3ccGOMK89xEegETjLHXyRYepEf5i0hXjVD84TIpLsvltzmHvaxQ4bmG3iod
 LI_Iz4KMwJ9VGz5xjzjlLtGGJLMfAdNCokNjNxpCHSxj_TGgfHMvH._CzS6qpSMm.W4NPsfuUzF.
 6ZUIfqhP5Eo4.SKE8ES22561a0Hs6Ns9xw4neTdxrqOMwVsOpALM_Gjy9bkUTMK5yMgAs4K2sfsW
 Lb8W_qyPccFIy9jiTUq6m.flHNLwLZdOX99NvIgTb4GVoqq9irPC8zLTDPbokK7.z9h99U1yuKJw
 C.WCNyCwhwGIAOe7.JHsO2EXt9Em0pIhqWfVEFOj3NJK0MVQqLF89eqbzPkw7_d3HI2jV2tCkpMw
 xOfbmlrk.LqJyR_yDSX55YaYjpEAeXDwkr_HIeiR8f3aww0DGuZV5RExb_hwFQloQlHomUtqWYGL
 M552EMTtFg2GGvpUBk_.b.BY6lY03ucLFTJjibYwN94H4OAm71e1ULu4E57l2nd9qyile39CMVOw
 LASg3GC1xjUtkMeN1Q8Ci3TrMX1u_LKjUbfIJ4peqTPwTmZ0PSPPEZ9UrhWiLoctabjgRT8VxPbb
 m3bjHVGD0T0btmH_h1Dlxe7dqnITHFvpB7BtbrKwC3nRCgnkJ
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Dec 2021 23:55:04 +0000
Received: by kubenode530.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 938d4f01cf5160466ca0a1e860c118e1;
          Mon, 13 Dec 2021 23:55:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v31 13/28] LSM: Use lsmblob in security_cred_getsecid
Date:   Mon, 13 Dec 2021 15:40:19 -0800
Message-Id: <20211213234034.111891-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234034.111891-1-casey@schaufler-ca.com>
References: <20211213234034.111891-1-casey@schaufler-ca.com>
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
index 916a42c68b58..27b53e5f71a1 100644
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
index 3433850a3f9e..3b653fe331dd 100644
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
index 34cec4cd3dbf..930254bca7b5 100644
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
index 57423c92589d..0e17620a60e2 100644
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

