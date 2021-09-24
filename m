Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1C5417A90
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Sep 2021 20:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345517AbhIXSJv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Sep 2021 14:09:51 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:38649
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345435AbhIXSJu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Sep 2021 14:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632506896; bh=BAnSfVvP1uRJtdchoIVy7g+glXh9o7BFoC0c4oy2wJY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Us1s29HNIHtfvZjWJbjukP0zrJ5S95h8in/elYo93sfqxqYCx9oHv6o12tXXBfTZVCRizyEtNJ1KFTVRLSaqJosPDSjpwHray2NwEzUq/+Djxj6//gtbRQdwXgNPopSpsoKN8QIveohhoyhm+sZ0qoVutUrTEqiXNLfUhHoEpMUTJ95bG1GktkbAJdZ0mGiEP6saWUtH+LyjndTftPZIMQ8RpEV4P6trwe2zgAia815t4Gijsy59B3L/YrmuYD4yJGt2Bi5H5fp6VpgrsVIz7PM+/S3BnTBPznpwShKt0+YLbclC7sY0o5ZS/hrWB30vpaMLHSyHP3zrsKdPGD6t2w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632506896; bh=2yM6xuhyR0Sknhc2BGrsGom9Tc1BG8VVvye0xl625s1=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Rb0Pbd8lAvIDHKKIf5L4P0i2oMM8+dkmT76TUDMOwBBTJTN+g17bo4vtkfrGqPuXvVyxyZ0QhCs8p8R9ifvzNt0dGD8BDZJo3OHVrbpEHB/ABWW5FvRNDUhdLbfIlcVGEWWixb6P18NTU91dfeBkJvp2rjSQzPTA00NCo8z4xv/3bYT2Zw6SYpLf0QCpgnRhn/WAIPoNidkrgnH55/nCUkI6a5tM5x8KlX6xyv5g8Qbn6V0G/F7nrccHsibVB5ZJ+L9m7zq4mKx/iywg4UvITrWCTwuiswrZF3V3014KsYBWexObT5B3adJkcvfBtUV2Jek9GdHeDforVf1pu+FSSw==
X-YMail-OSG: hLquolUVM1nAWS5IGafv75W9T3PZgW.RDNHQweaq5z9rGoUvH_DE_nUt7kjULvo
 Gh5LHT6Ef31f2MKIjFPGud_XqydbuVPADRTTSGAApPbziPiZo2dACSrSMMchOlN_5BGfV6jlrand
 ihnLFdAcOKPrSvsYQT189F6cQts7xdLWnYSgm7.gmi5Fl7oxMsqYQL4xsz7_fKggUa4.8qNfgQQN
 ZvoF43QijaxCmEz5GIoH6AtpppMtIpWCpuJMuCx6seBwNnVy_gzqFcPWZ4J333OfdWoRPneLe91u
 2_TGm86ZlQaelIRA.sPzXFRJmLHucGxFFH.O8pIQEUm_iH5qk361dtl53sq712FDj2r.2P8PHtl8
 Y85nElxBcDSsQHE3RWRuKo7W3JTHbkeIHYHSxqypdZdkTh7NBcezbF7sHkAdFWJ4N3HY9lCKvX8A
 X_iAEcdU7eMIbIUJIC9SyMM60fV47DpbenZfutmzzXID6zaTXI7.RAzzQe09DBXpm8pvDv9kgBXZ
 ZOJ5bwSi6hYNhGXzy.lXlQSuGd5J4mBIJ2FlaclFn18WaThLD2RydpedhhDsuWEZUEv8I_1hWB9f
 jFVQU84cdL5FGBJMoclFXUuyPJ.i.ATUVs3cB73Do26DhgLm5pWVlhP2Sm8fh4hQx_UWLHITxfYF
 r4d8jOUUUMOhLRt_wD2TnecNez1Rxq00Kskdd0.SAAJ9OTy6.XGDxVv7Q9Z8bN.cLuwjIuV7X.jg
 XVJ6djG.9YvSYqusd8XayanRgE61Aiog8P5.xZpusePRfBI3_Xs7yYcCWcIjP7LC2PmKnSLhsF5e
 EMgr2IiFCLrRkgxYsUsHeFUaW7hLIV_4dO3JTgvijMSMfimaBZ.XGJC36OIY.fa75n1LDQVKer_q
 XMQCPzVdaz1x_CIWtIgQiL56p60t89ZN08QEdfKwqaGU5F_VgeoLyxgaqga9MyvDSwCQzzeqY.l.
 TusfOy2vEBQDuUYyAlf617VGXqnBJra6VufuBURPj5VpxKvX6tPiVHlHJmq39bjqSTdcCXYOFwJe
 PmeVhPmyBjFwNx83Be8NLBj85pppToe8D.SsVCr1jH6SVJepNfj2FtO6PiV0EAzi5V7_uSNCs3Lm
 oGOp3XShzIOBADNgDV7A4Y9SzyblnNLInwfRlhBoyv4DiylDPKOTd3s6VvcwE4rSJBKBMm2hj18u
 DXgK_9UVOWoMll_txcdmF9YnQTk.ClAGGxcYYHHshzeyUjFOKO6HepxcjQGWqBM5GNRe0xW3jKpv
 D13g8rLr7bNuGz4ZpEb5.Jm1Kj3LHf.zo_hDYZwoijHmpFyDtcMTgXmkqUk9U.ktokaCVVo0_phb
 72QAn.5VkjRv_ZzdXOu4di0zYC5Y_sp51K_qjPF.T3Ohhg3P.vUmlx1W2IKiwMQc5AsN1pI3EPWQ
 cnhuIBq_GJ4Jju2xhzaOBWeZRK2qi__KlGzEfcbVKGlMgy3gJWamouztzFwgQyofZTFx20NvN_RA
 5mUHwDlyjUWhV58zb5ZpasczTtIcXcg_USp_H7k37vhxDrWzNVPr37MuNsv1PuTBr1K7zex0W.kT
 nBJXlH93nAMSadBDxediAX6xPKtx2XQZwgCeJYIVPty0F0BdVWoDfxp_pAVVWGGn8oTAw9lux8K4
 FtV6f37Bc7PXgcrOa2Rc5KEgEkJwx_trsPc6J32To5XQk_3P4aH_sYQS_9nqhuoyaOCliEvqlwwW
 XzgrUCskamLfT6MEMO9ELCEbDzpTx4M7CnbAJ7y1LGserVFX6veZZOUk6ZNkoOXj1s.zNV5jOeRV
 57tKb7vO5YBSM0URCfeQRdXOSyDbkTrZdQyB7z73kkE3lr88bu6F9.2n6Eh.xixQAWLuQDYH4cZg
 WeGrXbOpiPOim0bO7nXDoSfKlwKpJNMJ0OxWWcuaV4u03f0jm3Hv7pD0KVyuuyWkh3xXVsbYClVZ
 5kbbghlBja4J0AArx9xAaJaiOegGyhmXCM2T_evcHMhUXI7XQP6E3e2rX7YdHkui7l47ajivrW_u
 DYNpO.erZ4sp0JhayZZFvITlH0l6HC7OoEabqlA8_RglFGtVpMCfAdmzXHOvkwqAqMFEXpol1jMl
 gJgJvT96OX09Qlt.0frMrSHTm9vXPInalNEpPbwbA45EWyLrGXcO7CsycG.D1KTRftvztKRUT8ll
 28VvqTyz_sAfcQiRO1amBlJxgvs7YEqhm9RE70fqsrnpVpvn7JSCMlVMFNPxrCojVxciN.IRsbhM
 hnAKJMJIvu5H6IFo2dDHFS8Z_DORJspxkmIXEp8DdsatjmB3V8cNMYv22MNN2TqM7q7jw2VFsg9j
 Ap0CkX3KuijJAQqPPWMpT6Y73Hv5R9Linm.dU8XOrJXKeYEQAhEZXCQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 18:08:16 +0000
Received: by kubenode585.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID f6139ef9ea109ef4c54f04b259cb9c09;
          Fri, 24 Sep 2021 18:08:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v29 12/28] LSM: Use lsmblob in security_cred_getsecid
Date:   Fri, 24 Sep 2021 10:54:25 -0700
Message-Id: <20210924175441.7943-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924175441.7943-1-casey@schaufler-ca.com>
References: <20210924175441.7943-1-casey@schaufler-ca.com>
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
 include/linux/security.h          |  2 +-
 kernel/audit.c                    | 25 +++++++----------------
 kernel/audit.h                    |  3 ++-
 kernel/auditsc.c                  | 33 +++++++++++--------------------
 security/integrity/ima/ima_main.c |  8 ++++----
 security/security.c               | 12 ++++++++---
 6 files changed, 35 insertions(+), 48 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5a336fa10818..58c853eabcc9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -482,7 +482,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
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
index d6a2c899a8db..d43a08eabd86 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/audit.h>
 #include <linux/skbuff.h>
+#include <linux/security.h>
 #include <uapi/linux/mqueue.h>
 #include <linux/tty.h>
 
@@ -137,7 +138,7 @@ struct audit_context {
 	kuid_t		    target_auid;
 	kuid_t		    target_uid;
 	unsigned int	    target_sessionid;
-	u32		    target_sid;
+	struct lsmblob	    target_lsm;
 	char		    target_comm[TASK_COMM_LEN];
 
 	struct audit_tree_refs *trees, *first_trees;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index dcd1b988a2d3..b5807b9b8a4d 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -111,7 +111,7 @@ struct audit_aux_data_pids {
 	kuid_t			target_auid[AUDIT_AUX_PIDS];
 	kuid_t			target_uid[AUDIT_AUX_PIDS];
 	unsigned int		target_sessionid[AUDIT_AUX_PIDS];
-	u32			target_sid[AUDIT_AUX_PIDS];
+	struct lsmblob		target_lsm[AUDIT_AUX_PIDS];
 	char 			target_comm[AUDIT_AUX_PIDS][TASK_COMM_LEN];
 	int			pid_count;
 };
@@ -997,14 +997,14 @@ static inline void audit_free_context(struct audit_context *context)
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
@@ -1013,9 +1013,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
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
@@ -1590,7 +1589,7 @@ static void audit_log_exit(void)
 						  axs->target_auid[i],
 						  axs->target_uid[i],
 						  axs->target_sessionid[i],
-						  axs->target_sid[i],
+						  &axs->target_lsm[i],
 						  axs->target_comm[i]))
 				call_panic = 1;
 	}
@@ -1599,7 +1598,7 @@ static void audit_log_exit(void)
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  context->target_sid, context->target_comm))
+				  &context->target_lsm, context->target_comm))
 			call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
@@ -1775,7 +1774,7 @@ void __audit_syscall_exit(int success, long return_code)
 	context->aux = NULL;
 	context->aux_pids = NULL;
 	context->target_pid = 0;
-	context->target_sid = 0;
+	lsmblob_init(&context->target_lsm, 0);
 	context->sockaddr_len = 0;
 	context->type = 0;
 	context->fds[0] = -1;
@@ -2434,15 +2433,12 @@ int __audit_sockaddr(int len, void *a)
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
 
@@ -2458,7 +2454,6 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
-	struct lsmblob blob;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2470,9 +2465,7 @@ int audit_signal_info_syscall(struct task_struct *t)
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
@@ -2493,9 +2486,7 @@ int audit_signal_info_syscall(struct task_struct *t)
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
index 5fbcccbdbccd..f5e9f2eaf5da 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1799,10 +1799,16 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
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

