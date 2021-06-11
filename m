Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D023A3878
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Jun 2021 02:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhFKAUC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 20:20:02 -0400
Received: from sonic312-31.consmr.mail.ne1.yahoo.com ([66.163.191.212]:34278
        "EHLO sonic312-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230230AbhFKAUB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 20:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623370684; bh=QcmBvyghnNW+rToo4Rc/+kkvndAHfhPIxrKbojPolNs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=nkWfQM4PBUe9aSgS36jPS05QeRRNyakVD8fGTXUrxMcD5szytM4gKjj3z6SL1su5eKa90/gMA0yE7+XwnsA4XeF7YH0L2113x2OUfQmNkcONputa7Eslb12273Blv667OEGu2cfCC5LzB1HIqdU6IRHeRVgem50QhQcmwumYUCqeQ6hVA6jr0TW5eXDkR7z4fgf7f6TzJ1ao2VygG59NsbuBH5mSbH2rtbSMTPVenXdAqkYGC6odmlJV4CnWfrV+LjSU3gH1ak6pdvIwVL5L0ap6VOiwm/pwXqbTWay/aYnQDwp5msOzOQl5W7Ky6T2V2pAwtRC7Idn43azeyvr+8w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623370684; bh=1vpXTU8YWfpLndmGX6/qCfP/Z8tfMW76GeIxqq0An6v=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=OSLU0npdf3IVhL6ewEKJchQoaxwnzZSJWGAkD841G/u2zJP/svmUNIpoqCSrIwadQHG7pFBRL5qrXAt8ZrBewLeantJWK/XQyRkZ0ckblbRG6At+W97VIULqQFko4O3BNH9cZ1HtR9udNrv/EtWpPKWQeOK42PnnXfv3RqrlgaaRiH+gCstNyKDqbY6JhUu94vuLbs2XZ1jGrAxXCBl4sHXO7iGDfr/B7O15/SQaFQVUAFSFDrgsmk4RMoOC9qsa9qouWVPtMUES1VKb6OU//fc6fCtp3BBbi842dI9K1m8zPFA/TO1AiZCDe3DXpEmrlAV+RWat1EBRVxSbVoYRKA==
X-YMail-OSG: 4vE9ieAVM1nVdHXwn3yv4.V1U9YyJrwJYiQ5hB8ljnlPxUCXK2YBMyRcINeJkUu
 EviPMtGvG98uNThc3elof3piZW4Rae3Y26d5CV.qKE9.oj4DlqnMPZFTnongigxwQ7wnOxbaoqMI
 LlUPrGdukl1i5wx6g41jCRLMvEhswqhbzKCYn5KSCqfPgSSZQwut3zGGZc00nJEeD6W3rnxli4fC
 40F3jHtFruNrVamjjnt.iw0CL27vK1vItWE_Wud9JETJtBFTO7c7rsVvNIX_WFpoB9uPYjoHT00y
 UUKoYFWpgVNDW26QLcM8083IN3B8OP9LGXSZdYqTU8SZyebZj01GYRQVDQj7dxwdiTFWguuTzY1c
 4o1vgdq2Lx.VTHCfLAEgosiziYV_vwAhp2ymFisGO8WCJTx26avQNLjZnlPNLzmJCTHWk02AvnjQ
 nc.wYDKL.A5f05UKWLzKqATpKQ_x671jPgX6TSsfBKdfd3yzfGl9B.0qcg6PdBlzRBpvQF8qTkrl
 mudrp72NszEZ0aSPmbCPXZ_9HeC9V5rDxXWHjUYSrb.SVxIXLvOspaFvkFq8powr9V_7R1mIAx4q
 dTq4RXY_Ck5AdwT.stf2PL2KDmmK6Bd7gZ6R.jxAkP7OYKF4jDCgC9w9prwRClcB2P2RsIMji8v8
 D3115T4p7MG99KsupB8XjJRjS3gxcklEuYQmJp7Vb7FiEiC1GKZnvI20OPYi3SWX3SIlLpdAukmw
 d0G07U_6g.8krF1hfYWXxtoor8jOKu57Uvd8uZEdPvBjSUvQAALXQ6ck8oy2svHj0egy4PeYwJWS
 xM0_Qbni8Sv.M8PYiHxok_nS0aGzJHjlhjWsYK3LwYd93nHxK1yXQrZ2COL3FZpgw4K.tjXK4TIG
 TQw3qPCKD2_2FI0rOPVWhVeMIFvEpxat9.V2qwsw4qHk3X7Jf78JnYXU1yt5Ufkm7VCGSww3PHo.
 bLP.Bps4D6Xxa1E9OPMDEPvfi7eU9qOybIu.GsR_vlADDukwOCpFXbMPoIWPhtemS7iiBQf0v.wI
 k8T39wnRvDR0YyBwXAq8rPcWWbAJc7WkpzDpYvdLwzqE3prGvxXGEhgmqELtah3Vm3ve.FUFwBg7
 poPnGiCQ4oeKQk.xGi0ji9m8o7hZzyZnqzvo0cgaAF1jylZ70EPjo7_SSgBwpv7Iobe_IiZKvmYh
 1jVIoZc5BCtkiOicG1RLyPP9.QAMdm5YGAOqSFdxbfEUgAYeTX5fyIX2ciF_8DwA09jBG0X7ad1n
 5deYMWQA132e.dBKnv00mXCvcBCwjSm_xA2k.FFomBvJIalfI4obfDFioIW3ekWUpmz7elEOnAGR
 mnWdijMqisW6J0YB2BJYEBJOVTe3uiljTVSApz.Y8U_w3wh37gjwNQFCuadG23_b5jQ5t7.mLnya
 JDoS76n2IkAxRRAP36oUgIFvlT8spcjx4ROITj_7t2f2zCukwhZQEoqe1s03bwmiWbTgEtYH1xoR
 8qV1wHf33rDi93hiLLVwNoiWIdJJQBQGils12qfpbh4DlXbcIRo8bDtx9Nbv0KHR4yNF6B59ACXV
 jhXi1dxKi4KUQ5BcLV1V66di2XdcnpbUou7romH7BFrNf1RxRBZ8os7kHBvtNyJYQj4cdvSBSRuv
 8LR.eaXEG4V7a6O0rcbPH9iE_wWYg0E0FfnQv6KUDxJxYf0XZRaOZcGr2RPz94s3FQpgLI.9dZMR
 EVPWie5ImRNU4TDTANK3Fla2TO8awIs.6Rqy_0xyE9TJ0YiqTkPBLNR65npnDJmNPHw40dIFRszc
 K8kwHGYhcvk1eDG_Vg.ouWaBK73Z_CRYt4typ7o1vUcNuotNF5fiuZPVSxLu1t5kBMLf4feWcuOf
 KiGIdicGm6sAs1e.ddkB_zRX.yDYkDd3IcLxqsWh86xwtq3HPzE8nijxryNkzI9Gmdx0NPhp7YOT
 10XuM_il0itKfqFSOKnD2cVta.Q_LMdPEHi_cp8pTeCY28kTSUgX.acvFZ6UAenSa.a5dcVNkcQP
 XEcGOawR7jFqNDdzNQ_8sSfaOYfJF6z.rDMUOotbBhru1UlbysSr2R176uhjjW1Ul3uo2yik68Ri
 XcGUCmajuSW_GKhE1RfZKsFMb7a0POJNfTBHysqgndUM5qeUcEBDcmTRFqmD9vXM8NwnPE8Ey8pC
 mJlGfJRAQD5UPPqgHK8DWdK7sFP7_ESdvLXGcnbl_ZaT3567MLgL1N9JbiAWxXJrujpaYuthMHru
 QMxQ9GuTTOinlbsAxpGRwbCwCNrL77BGrYkdsBKd.eSFeNLSsb44lU2XMgqCMKihtHC_Q7v0YTSP
 KZ_So4jk7mQ9kPB0jkoT5lpp85NvhNA_3UHpEUqAt964jXgv6On4j37BeAGabdRKbX6rR94M8iAu
 3AxRJfbLPzoCapGM51.NZHfFu2UhUh_qP636tru_3QknyME4Lax_cDHMWKznwj9pDzZ8oOzNDDaU
 bGkLFtbRwkpslMJWET1Wp5FlJpH5QFb80yo_bIgBP4XH0aNi5NZpM7tjSP46iwgSY3IiwF8mKaTF
 6uSjcFnyYwovVlp.pYO3LkK87IFT34sRhyFc7bgztz7x_ek6fnrUZnETcNGMvDj0BBFXIK16ScLf
 mk3FJ8KTaOjzUcgHNXevsmFFxM4sOpuXghOKNmYUwSewwsXwTYi2p1WhCb0iIp8vhWfXDpjFLCF0
 Fxo73a9NptEI3AKrPgp8WpT5eYmwMjJ.FJ8kKfIuxh3JctxwQ02JLcSX05WA0xPUOt7gqJNxS44s
 _QZUm.fLyKgqwQZLLFY.YrX5bRDF3zb4He3JSYwyNmA6CB5g115PP4csBQJqFT7UY_LosFs6TFH4
 TXiJiP1_Ba8tdasU_Dm8sKa1pzwwYKCyWLblIX9xbtb6bexGoaqyaFVb3hR8Kxz1W1pL0oh6D9Id
 t.SQG7V7VXA9boP.7UJ0Vmw1PysXEcMkirgcOZ60vw_QgsjzSC2iPk9_JxOMAvo2tpCMuM9bjRl_
 czZG2gE0Bao9eyocMPofG3fRBkVVYKKr.kTpPxJhbgaRzPpvgd9DKE1_g2.SC7yDVkBtwzDAHLdm
 rh8ekcr5IQ5avVHWkFJjdmZ1fzFc07Oua2SDmcQErjdsyJ_Stm_Dl_fG4zWXEvC8Ku5ygxwJeOJ1
 hpJa.DcMcvGwuT4LQ2fRJMixwmnmKTfyhnQ3iAndct3ODFSU3nzL4ERHTsNOAzEBo0uXAmv46eG4
 oCfL1g092mz_QTGSoL5Pb4zqziLE8tAztL2p2x3ax8W3YyH1y
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Jun 2021 00:18:04 +0000
Received: by kubenode505.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 518b25f8368d1c84579dcba5a91cd921;
          Fri, 11 Jun 2021 00:18:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v27 12/25] LSM: Use lsmblob in security_cred_getsecid
Date:   Thu, 10 Jun 2021 17:04:22 -0700
Message-Id: <20210611000435.36398-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210611000435.36398-1-casey@schaufler-ca.com>
References: <20210611000435.36398-1-casey@schaufler-ca.com>
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
 kernel/auditsc.c                  | 34 ++++++++++++-------------------
 security/integrity/ima/ima_main.c |  8 ++++----
 security/security.c               | 12 ++++++++---
 6 files changed, 36 insertions(+), 48 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 64f898e5e854..c1c31eb23859 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -481,7 +481,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
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
index 1522e100fd17..23a85a470121 100644
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
index 6684927f12fc..573c6a8e505f 100644
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
@@ -991,14 +991,14 @@ static inline void audit_free_context(struct audit_context *context)
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
@@ -1007,9 +1007,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
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
@@ -1580,7 +1579,7 @@ static void audit_log_exit(void)
 						  axs->target_auid[i],
 						  axs->target_uid[i],
 						  axs->target_sessionid[i],
-						  axs->target_sid[i],
+						  &axs->target_lsm[i],
 						  axs->target_comm[i]))
 				call_panic = 1;
 	}
@@ -1589,7 +1588,7 @@ static void audit_log_exit(void)
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  context->target_sid, context->target_comm))
+				  &context->target_lsm, context->target_comm))
 			call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
@@ -1765,7 +1764,7 @@ void __audit_syscall_exit(int success, long return_code)
 	context->aux = NULL;
 	context->aux_pids = NULL;
 	context->target_pid = 0;
-	context->target_sid = 0;
+	lsmblob_init(&context->target_lsm, 0);
 	context->sockaddr_len = 0;
 	context->type = 0;
 	context->fds[0] = -1;
@@ -2319,6 +2318,7 @@ void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
 	struct lsmblob blob;
+
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
@@ -2417,15 +2417,12 @@ int __audit_sockaddr(int len, void *a)
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
 
@@ -2441,7 +2438,6 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
-	struct lsmblob blob;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2453,9 +2449,7 @@ int audit_signal_info_syscall(struct task_struct *t)
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
@@ -2476,9 +2470,7 @@ int audit_signal_info_syscall(struct task_struct *t)
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
index 9d1ed00eb349..b3e00340a97c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -470,7 +470,6 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
-	u32 secid;
 	struct lsmblob blob;
 
 	security_task_getsecid_subj(current, &blob);
@@ -480,9 +479,10 @@ int ima_bprm_check(struct linux_binprm *bprm)
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
index c6de5200c467..c2a5c50e913b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1798,10 +1798,16 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
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
2.29.2

