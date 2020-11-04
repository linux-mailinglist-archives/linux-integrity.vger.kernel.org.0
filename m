Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2421C2A7341
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Nov 2020 00:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733013AbgKDXxm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Nov 2020 18:53:42 -0500
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:36185
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732679AbgKDXxm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Nov 2020 18:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604534020; bh=ociN9rc5MgUa54JEw2DtkHS55iR7GBeupgmmWIRrLO0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=K/xk7WPryeEg1wXQzeD3lxKb4q8JJVR5QA+ua/tFXCPwS+yGlTZuHmZQsIVbRKFqNCAmkpYTNmB0/6mucGyzK9IjpT6H8/hjICamMQL/drJClfp65bk//o389iSWN0RkNH6i/+5fSCndgOgELYgawhLmus2BfF5xL2AvcWPwCBdz+mvpynEPz9/xGbc99jvjo8llPOR+Wtt4aIU1FfoDopUem9fsH2IuCrrWiCTq7msD4L2eZHkCFYMacqHZBsLjFphOx2pG7a+W2ZQoxhGdaYpcSjQPBxIh08r9JXcMe2c/SW4UfI5lBeT2TiwtEShqRe1i0iL9+6jIVPhY1KlLqQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604534020; bh=M0LMp5BGVBkAGkqRU0Uj/I53D6Bfmwio5eOyHGTy6XK=; h=From:To:Subject:Date; b=LRcaPbHr4kphvzPpz9n50SPLYCVVTZIyeJl2gNf2rGFUZVhQG1SXlCs/9mCIfINeduskOoWGRare8KVWFKLbM5TPcCTuYOW2JZ35N53sxCyz6xbhCb+MhVWwXQnofqTSGQi2jnXzMpRFseqIi5er53xvTzLFt58XV9fa95EmGhYDlrJWDvdhch18/37egqVGhFBcP3UnptQ9uM+3rsYkEvwYYIfvJwdP81KdSk5NKjy6G36BO37S7IrkrYA2YgQ9Y0fEPhgeOvFl5zsqmftFHC4f7VlTbkGSM06vUwPk13oXtAbgQeXyoaqDuZ+NQW4okBD/U4Jo9wCgEE2WTQPb2w==
X-YMail-OSG: 5kmfQlUVM1kjxbm0RK9DBE6l5pKbQX.ayIPrEKGyRVHInNE.9Rm.Z2ZDU5w7d_o
 Ff9dem6eqj_6GlJubkd1aErzHrxikmr55.Kim.qg1L5K1xLvV3LariZvhaZthGO4C9OmsXrlBvZW
 wdtTs0xXGxrq8kcNbQbZiEf7pn72qRfn922Cip5m4lC93gtiiftoX9DQa_m0IidF0O.zPSDp7NDW
 Hus9LvD8OT3z4o6g3VjME7hkn_pjgGMUvvxSsFlXFN4VwE2abh5WdGAJDY8QHUl9vXSUDVz6JKML
 meK8MESJnnompj_H17A7Da_wsA4iqFeF0I17PMQl68lhyolxThj3yJECJ3ggEHv9S0YmPnnGYTwC
 tltBHjGt0ovktc_i4206QAglWFliATV0PschL7e7TaAr9N2R2JpIxF1UAv.jR_EIsuiLP9sP_Bbd
 gTFITRuEMslRy89xNyTXelJW1.fbT7PQYAcoBaGcvK8D90Ez46vxQIBCQ1c5AjWgJFS36_OMEG.t
 ICjDbytdxdScDYvRf.m.Tke86y52NjS5JxsCZdN3gozpA0YVpcWwLJsFr4AXj7bsuPzXrh90MN4O
 362vH4HM9gWR1jvpOlP0PAL1pwb7apY.k2d920x9BjkJQ6uMqCW.Pqf1nuBsKKjMMRK9jSr0aWjN
 228vn_rtjRxtYhRMHWtfRwVsP00Vi_khlfkLNTOTZGGfJ7q1oCdatIPRcAPakO..5Ufmf70TrQKD
 zrDQmwbGBQW.Pe48v7xUga0n9doYkLcmYnn_808Igl.rw4i1lLe2636kEX3idq67wTEeQoLXHmlT
 22Jx0i8hmVIc9UL5WpN66vu5UTzvmk9Wmvx3GZb6WsEoDBfDTQgWMGEA4WBO581cK7VocNLMsVUW
 jX1dsKUDgkGCAs_o88bk7Y6CjfpSkcm5.y2ZnzpYGLEA._tMkA3kcg7AKaTNLEwoSfZcLtPNYm9X
 QLNOiUo_2xiPd3bRPxyL6oXl5oKXAuiL4NLQ0IUgkI4uM81kui8UF2kVBgLOYCZNTk58FvO6mAVt
 m7LADK_HrOp_6B7u2L47XUAJQ6Fnmhn447h8zgdwH.hY5H5UBnmILrzk7NkR52jRBjq.juwQLMXE
 8tyocVSKuFEGoF.6HG7sqT6eLydHazTIDCXw_bo4ZE34_JaztwWMvSA2truQ4SwS81Jpn4J2HPze
 bgFDAOvTVNeF8h54gj8XZXu0Ewp1HP8tq2MM9rQEawqYjxI4XNeBMZc6RSSyRmsen0iGkyVkJ.3p
 Ht34n8gvB9Sichxz5PQw2w4UwsuaqmMsbSe_1eJo8h1wzcc6iClrCOPK463SOiv0id_9KFMAOJH5
 iJ91Vd.u5w.qTINRgjwnOSqmpA05oB2b18xce02_7g8ScAwQm79IuvMKWU7MdUwvUDtqJTx8WS3Y
 8gNCt2Lo_WGZtIwI_NJGRb2aq0XumaFzm0vnKM_m95G4isgzB2_bFteMo8jv2iyhsfSsvORxdzCB
 bMhVNAQdAVgic3RglUyDbdvkaxrhhXb94sVmZpg1weHCSkr7cVS_w2epeF6V.fpn..0._PktowK2
 N2p36sf8.IMXzAGAOzKqMzR_zCw0jxVN46du4IsdDu8m5V1_5QPAYDl4BAobM0Npk82tJQjuNSzj
 R_eVtv__CjOh6d0BLFEATSk9xRt__9qyfhXDy7lyvpmSb9nITMjx7ysca838ZYU9Jd7XDfA0KvUk
 wrNtkKHJ3aufpAI4S8HZYdR6pMZIMtUt774n9aZBJVTzoz6EopQD1WXqjOqG2ENH_LOAomzXqem.
 lwlIiu7pKLDG6pujKwddYIhzMmEv1AjBjZ3v0QstrK3MBMNZFGMvOIyptshX9nTuD7.WLOed2yIA
 o1B1.DAJRDp0cSC6OoxEVVXVQ9VFs_aa1aBI2C.ogvmrFHgmCuJQnZVzxIxJZj8jPvQgK7IHwP3I
 Lmelr7FF3M5TAX6ogdQJAI7sMH9Od_4YIIQpFtqjDwm4XdUXJZ0BGGJvdB8gGGCH9M.vvu9Qhmc_
 63eoJVW0xyEGLhYq4pTH07ZTE3k.AVmGgIXgKAUBWlzP1B._7i93NXfLznvfTbSOQrQ941jxvF_h
 _HdkgKhDPjjCfbyoWqivg4mvehSIHSLV480VAf0tP0jPDMQIXOcwtqcAwSDt1E1_JnUc2TYrxdmo
 BC5.G1XqP.XltCot2YmWFl3aJ31yCH5nYw64HnWSRaQXpkRx6OOZ7bGuQCfa5XR3EIYvUMKC.zPQ
 yH7q352DTwshAyBwnV9769oBTWRfcVjAW495B9t5UuxSqA99tB1nVfg7Tili5gGTe.egOInLju7Q
 vZNMmYK5OGlRQWVOqqANp2wn0Hxxiftg9ye1310.TIEPX76ZESUVmXRgpvp.goXvhgzQRzNvOg3L
 .sSSVsPNz6_eqN_W0NjbA.CL_N7A1s.FUIGe9DPQ1SL6wipt15jKvo8SyPRASv1GecMPXt4zZkn2
 CYqG8NcQECLfTIHyg3r8Hwr_OW34LeCOvt7EWkK9FOXn_IbtGika8uGn.vW8t8EHRD62IrfqF81_
 581hgKEX3346QJz.4qO5fzJZszd57jcDgoJogmI0PMim2XOuOkF2H9PBYBtysEHkkAQl86dpQ6XO
 USqJtjqAFreMhiHofejBuPb3oqY3Qg5JkHgcgYYZ2wkpel0Bx5tJWL44aKEiPsHBcsultw1MsN.z
 BqzC9aPhaPcI.5j5zo2fYQq5THgiTF2EaCHbE91eF_qin.t4G41.HZhOlOjHKmuWY0vNn2uud63H
 DcoopBy7AhWzdpmENE4abL9GCs3JZoOCZ22gD6PRzV3lO5vFXuZ5fS4nC1qviEH.J1Ywo_Rq8sJx
 AYSv6p.XVCojDC73.5..ii6wHYN5uSFF5Oy.qWWCm.aQZP_5UX4GNsEb1ZAuHU7P15mXIZy.Jvem
 vY3p2KlvheT3fDS4WaImZVDGyruVkJfLc6gIUt0gzLt2Rd2kYgNv2b5izOFoFb26WQl2ZEQFe3GW
 l7ai3fFHARRsGol07q8qQ3EiG4QUVW8S_zzce41TePe0BATeAXkfbMUDuKPgM4OobWyGIqQcrSS1
 LwuRVoj1cr9EWUeKTnpbVGEHxvZepj6OQTGWToYMf1fFlp5Lb1yT1YAT5SGhEkE9lEKRPCjSGzT2
 r5fzOfPZQQ19fzEmaY7QjSOX9rCNa7mI_nvaRXZovXcAgCboc3L72CbLX6x4uTQOv5AJuLxlfB15
 PZY_t63atLpmTLrsjagpu792eUneX.rdXK.exjGmdTNp9dPhqLD913fS0bSvU2Px9m1b5uNi0Atj
 26dXckv449jqx9j6WIWdZcqjeLVmE1sGt.wDzPiwW0mLNI9OHnqsLLva1OcW_wwBM.8mJSN0Y3Ye
 8YjwvYalYWxI5NxHIfO2f_Jq9hb1jOhclbQN.ipuXRNpZrBCMVbO8aRv.fzO.FzesrkT_YEmC9tp
 lnwLrET8HU8OFbIHMY_w2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Nov 2020 23:53:40 +0000
Received: by smtp418.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID f73babc1cd8e7bf5e99016dd2688bf1a;
          Wed, 04 Nov 2020 23:53:37 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v22 10/23] LSM: Use lsmblob in security_cred_getsecid
Date:   Wed,  4 Nov 2020 15:41:01 -0800
Message-Id: <20201104234114.11346-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201104234114.11346-1-casey@schaufler-ca.com>
References: <20201104234114.11346-1-casey@schaufler-ca.com>
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
Cc: linux-integrity@vger.kernel.org
Cc: linux-audit@redhat.com
---
 include/linux/security.h          |  2 +-
 kernel/audit.c                    | 25 +++++++----------------
 kernel/audit.h                    |  3 ++-
 kernel/auditsc.c                  | 33 +++++++++++--------------------
 security/integrity/ima/ima_main.c |  8 ++++----
 security/security.c               | 12 ++++++++---
 6 files changed, 35 insertions(+), 48 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index a7968dde27c6..dacd64d2d141 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -463,7 +463,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
 void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
-void security_cred_getsecid(const struct cred *c, u32 *secid);
+void security_cred_getsecid(const struct cred *c, struct lsmblob *blob);
 int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
diff --git a/kernel/audit.c b/kernel/audit.c
index 9e3eec0a9c29..1f987ac23e90 100644
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
@@ -2349,7 +2341,6 @@ int audit_set_loginuid(kuid_t loginuid)
 int audit_signal_info(int sig, struct task_struct *t)
 {
 	kuid_t uid = current_uid(), auid;
-	struct lsmblob blob;
 
 	if (auditd_test_task(t) &&
 	    (sig == SIGTERM || sig == SIGHUP ||
@@ -2360,9 +2351,7 @@ int audit_signal_info(int sig, struct task_struct *t)
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
index 3b9c0945225a..ce41886807bb 100644
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
index c9f1f6bddab5..e2fd092a1023 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -469,7 +469,6 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
-	u32 secid;
 	struct lsmblob blob;
 
 	security_task_getsecid(current, &blob);
@@ -479,9 +478,10 @@ int ima_bprm_check(struct linux_binprm *bprm)
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
index f3f6caae392f..78aeb2ae7010 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1693,10 +1693,16 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
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

