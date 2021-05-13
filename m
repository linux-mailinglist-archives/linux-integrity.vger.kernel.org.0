Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3438E37FEDF
	for <lists+linux-integrity@lfdr.de>; Thu, 13 May 2021 22:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhEMUWs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 May 2021 16:22:48 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:36170
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232555AbhEMUWr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 May 2021 16:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620937297; bh=0WWcwuwGjN8XC9PA6SxswcZEHx4sWKSep230V5PI4fc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=FNvRNE1VUwtgVFrYGImHg96cGeOsdcGMOCK8gc1u+Aly3+bVUPCAyYnUZYUS9iEdAITxCUD1U3qR3D2RZIJxKeLMVqeSL+ppRhCGCJwGUJzE5v25cWHublKQ6weKxbbXxOlm6Txo5t42mFvgFIUNOqWcVomdmZOewx5gDviXPsYKzCU4zIPskh5Zwyw3tCegG5evxpMv0hXCfUuiyE4dMgKew71T0KUvoME9+gL3HXbIFXaoO9wx6AvjR+DXNcw7Wl4qg/pJ4AFwnsoG/pbjP/Hkn8hKBJqT2LvqpkCvtAVmbTu2M4O5QuRMK3GV1pF/9shd/w8qrFAKIcJRhWlKLw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620937297; bh=uYHXWQUZ3oupDcT3yb+kqHjWYt7LPeJbIhqTUiGgl0N=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XnNeT3SBQ2e6fAXcr4sWC1pVyOmeSDr4MKaW/9OnKOWRCWnybkUW5z1mXjiSMg10RAnMuo6sJVmJQpWaLWGreyjiZLVZH0WXB5UsIPkuXKxwaytJkpzRSTdCRYzNMOQp7xKWFQiSIaOB1pNZ5u6YTF1LoMbo/Gy4XsXRix5ShDjH5+Zsx/93ARY0browm1wzq3XGXH8+h9UOUpPc3U0RUUk0D04nyG28vrSaQj0qMw2Ls5mTrjSPSKzvMPHhXSFNpG1e4ofUcxlPEHSvOiP88SkwGKeNZAkBgAtGo5rWi6suNEA5zQ6LVGKYP2NOEg5dBxcN18tVQY3LD5/EpYLuWg==
X-YMail-OSG: pcZpkisVM1kdsNfxhV.fBkJQTCPcAVIf3tXzmrwSj7p7YddoIDXeZj4al3jOS_Z
 V_vAONui18HGqxUiuMtYn8llkAY6Egqq1CxLCvxkPKVzHw6lwvAVXIiIkzoD1XkfJrob4bVwdrUE
 wNGVuT6sPp9T907AYp2Wr0kcep8iOgWMyHZSleIvcVwR73M5DH4OFZmaA1QkgSupq1uAPaq.Wro7
 YNH5D7_3611OzlhIUQ1UpM1Xs4_pQo_WL6eYk9VrziXelfXCJv97iKiqtfFfs._59byaI2Mgz.bx
 zQ7xCstY1RKj8zo0lPR5s2Ukt5oidzFaQzNbbij9H4Bi1i66DOIwKwOA2k1YkX766tPG1BR8DoJb
 p9Gmni0aDNet11.CTuQwxaqOmTS4PTSJlmtM1nnI1s23xU5zYZKIFAlPk80KUwvlUE2.n8b1s3xv
 n7GtfmPccKSs04lSF0OaEqKkqNEauK6eg9IFmlIL9Yipk8SoY5D.fhxL.nkH6mrn2ql8t1hPMyqa
 aZ3jGHrS1nhJQ1_TtkI9UUAAVLmAacWmTNf7y6OBd66ZuZP7HUK5wJu88RpA7bx7s9XVy7CzB8CY
 pckjBIX7xYxmCxC1Zo47sKPhSCDdPe9byqDKJ35DMMuNtP7E2Utw99qpjif7sSCs41sXm9CuhlOt
 813YmIMAiPXoCoY04PmJCbAMTWS14FQGDiCcND.k40NSMpdfULaAZnLmN9MT5oqPah38CJbROR_W
 eLXTsgRtIcZEwgM3HZ62J26iH8TqG4e623PvcfUVheafcQhTBhWakFcFoULndGN.00UWpmDgpYxK
 4JiJ6AsM8Y5qKBM2V1PBvPMZd6bVEJLNDYMXOJPCV5eiqgWid5InyIkuGAK770DMtG0SXsc6Pvts
 Ja0d6aBTvpTYmfOTlFAqCwHlL7waDfrVReYhOtXNgy.KEsRPMxEty6QksKtVx.UdtVik_YSUx6F.
 OWTfu_iHxBgitkb_PhvKW9Jkoecr4A0nKPOJNdvdulZvLgoSb4Kg3JCE4dARktuJe8zZ9wUXKqeW
 Q.dwBH9FL8UfTmCoWnxSl5RVPSnr5xBuRxSmKN3Lzxe_seqa5skMjxo6QNCgiLk6NFn05M6GFV4A
 I9Qv_GzB.Fpc_ibgDjKUSlBufZNhC6wG0h8CweORPcTNx8blMM4ooo9Z7iTIkoU0aBMrz6XHviNo
 xtOYRcFSbSxxgC1Z8mith_v3G0y_IkJYO5V8ETa5hYIPC37_VUZXWS5UMsRO07Ew.6T4JS4p80X5
 Uip1Q_rOiDacX5F3kCR6ETMXtSAtKIGNVz2_GEDEYFI3VEgToSIwZ9KFaxttiv6opJKesb.L5I_P
 LoPPZiV97BG2c9ydMpQg_FiVjJYiqdbTQkVq1k3man2ZzDO8fLeNpXs7BFL1NazS.OqOVVZ3Kpfu
 AiD8cfwN4bhCb.wvxSphH5n_YVBzwjl53hfkr7UtmypyI5mamKBs8hlvKFwRZZ7HgUv5zCKPpdpv
 obxHk8Fa2_Fr.8Fm.VCO4TcHxfBMK3xe_oJC.RjndRdbkmjeAcVEH_OF5Wbxw1NYg3s1tsWAEFZn
 fl7R7QXGX03sV0Qrv03Cgzx6VEJp6vvjAvmwkHjG69pAFndeNnJVjYjN9Ei.rOnSiX5tXVjrTu5D
 j.LWNRXTugLGx1i87VGj6X1gyNbX962eEd7vjC.DQGM9fuwHqAlSmjKMXEqJmKxlRK4Urgf1BT6L
 6EC5G6NgkHw63Ts4khhAfNc0EE0Ms1FBAPgrdvVAxbRbjVhuAwtyyrb.Ocmort4MtucpXbZjklmG
 SgWKv6ShXevXGfizLp_m_XQlDrUdXWdM75CHpdKKyZs3XfIOdFB9tLGa.2CvAoGCccvsdNDbStgl
 b2Iwuz2WBbh9DKxyeyfmudkrguBWbo3VJdPIcJYejabg0KZBuhexUE.xFizXddM8wJr7ghGbFlCx
 3gtLMuIaZnKDUy9p3rQbhjS4U21Qsuxs4uDXdvJrOqw.mkeM0D5YjrOYbWwoFk0ojW52bxkL4Djg
 KzQBVguy8IEI9fD2cTvnuJHf26xu_jGobwAzQ4D4F7xSRov6E6bt.zXDTEf9_DYGIVzwjmPk2Q13
 NX9scnkUSo3oM_w1sFTGacbKZ0mIZJ62ffyvW95kFKiyBpQF1EHXehyi3TY07NK9S4ukY7TJEi5x
 .7HEzrpbB.3p4MxflpCB9iWstqXw3YmInEa1.6xO9OZg5igw_Q_K3pyT0tBe8UedvhJWdMYb0.yK
 0TKnIHT2YiZyBvSssvE8iGJbdkPM4l7.IdUpLwo1hMWsf_S1w7zjGX5WBfxWZYwMj.MMK9UHCfaI
 3KebMcb_cQ70d7tmQnjVvv9katnUbplrpVJ4wvTfHpmkjjbB1Ew9.sgPTFEKQ5SI04wTdtUQ3j4Z
 UmUynfvGzFpQmKvrF_sjSZkUNbb4D3skK3NS6umNPotbY9am7AJPGzsrdTYb.5pyNsw5_uebBR50
 PZ_wnu43mFaHanMZM6tR_dnu3wl4aMBK.hT1JmHiOgijDfHumLmGhRTbWmTy5IKAmpdi4vBwkmlC
 _acam4xnjwvLJiLtYeOcJ0wgMg.aKfFjavD4nc9kDGS31XYUJnLX158xhP2HlALXlhEgBNgvb12x
 4pxWFgOCss2P53SbZ2ckX0RvaBmAakCKgVXfHSTMihM4ZcuWHDHM0rOAhOMHJHk0Y6ekF1wpF.9B
 gf7D48q0uFGktYenBuLAY2UL8HuDQ5ax6qCLEzZ2m3dW8dGnmjy8JCyVqwm1PPBEUNJkYjBrEY5r
 x4JV3f3oWMRDsWECWVZVezO6bMLhMzX00IxAOEZ_1tUoN._GQYFS_Xo5T._pXjVGVGquxXr6duP4
 KW35XDipABjk4sg1hksfPhabZWbnUEcyUNBzdM3B5Vm5vMX3CmioTlr3kW3P_BO4RrsUOu4EYGWB
 xzAGjTvsJHW3A16R3EO5XHqJar.trF6NKLpA6Cor18b2s8tdaY7pRSiSDk92iUjYKbvw.2VyVb90
 ckY5mdySnMEw1pikLiM.EU0Bapf.touQceV5ndQolBwcHMoTSlhDFAX2mvmYmJ.m6coLKkYnkuqw
 YfNZPEa.EuRCglnW2zVN16wkvyonVWESLWYZ2FusDgTN5SBFMVqISmKrlIDMF2QntGrS7iGZ5NCc
 lW2Iw4bn0FrozdWKtyHD3Jtq0mqfrTwVEh.WtVEAbWnuDuQPynOtPPRW0l_0ZRsJMFmKhrt7ojj.
 buJIGNNdJ53XY00_uQ6.T5AnfkqfbVQ9UhRJwUWScSule8lnbuQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 May 2021 20:21:37 +0000
Received: by kubenode549.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d3f3576f9dc925e37a27218e0790434c;
          Thu, 13 May 2021 20:21:32 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v26 12/25] LSM: Use lsmblob in security_cred_getsecid
Date:   Thu, 13 May 2021 13:07:54 -0700
Message-Id: <20210513200807.15910-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210513200807.15910-1-casey@schaufler-ca.com>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
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
index 54f4a4ead69f..f5407a85641e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1796,10 +1796,16 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
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

