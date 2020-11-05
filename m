Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A37E2A743D
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Nov 2020 02:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387991AbgKEBBP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Nov 2020 20:01:15 -0500
Received: from sonic305-28.consmr.mail.ne1.yahoo.com ([66.163.185.154]:38858
        "EHLO sonic305-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387989AbgKEBBO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Nov 2020 20:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604538072; bh=ociN9rc5MgUa54JEw2DtkHS55iR7GBeupgmmWIRrLO0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Ku47Rc4D2OnyqokF9uDiVHNRxw7wOSEr6lXR2jL2J6IPwmZGS+u3pvLHWeMMW1YXTtb8HpPj06747FizP2VMlJxvAhttimT71fI5WPc8wcD6YM5gej+kQaL2euERjL0hUiLLC/8ugifwZwAoci+d+MVlCnUoOCZqZrynpi8sFi7ZUKyNAs9dumQejBRX+Y00LvqQuqt+F3W0DHYqmLs6g1GeAAldy9Qf/wVSaXo13cIPcnuzSoVdxg5k9rwjsSOF6VEuP74lljXItlStAP1aC/6vjydShBP7iLJbK9+y8r+di1MM7f82L0AwkXVubwo9rGJKFMgO6u8BF6Lk7dzXSg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604538072; bh=AlIW5mwVfXQ/a1sGhqDM1rlgV91nEaTZPugT/ZFjHt1=; h=From:To:Subject:Date; b=lwsaLVeOlk4wotCIpqnqOHaYUt8HeKmyQETgx4SUvAzt7fyctTKDjCMW52q84k8Cyv0dEqW1MkxPcA1vdesZGzfxyys+twqkhExSxGxgHYiB25xnDwkgYkdXCQ4hKiA2t0AQ/g5caLAjsjdqc6fNX+qLIHoKtdqF2iuyy8s44NZEgnyrxPfCNwP+GWfp5w9UkpQeYkKl+RnmEyvZYtv1qpTz0a4VHTOz+52pUsBSHXOEfTVHlX0O57db/+F/tCoAZBboRrXa91BdvSe+R1WnHCbbveeMkkXpFVmVMJ1FD8u+r+deGMEGzIEe+UTjOJqXVaXUlVtT8DWOI/DQhAWErw==
X-YMail-OSG: gvx3nBcVM1mex9lE3KnCbhaX9_mnO3E04XnpFJYyHeeGDsUT_pIoYHJ4m4dCNWP
 duL3r12HIrcEjROKh1iUn.wyt7GE6agVH110z4I26kIeUzOLZU5z4CfoRnsaQQnfZc_KNTxcJ44G
 vpswvnFDfHaLV20J60jof7omU5Hzgf6IgDtU6XwTwb1zvjGJTigsQkck2qdsjwgz3P3ls3OT65i1
 _.SxMb9LCbwGuvcnXqd5SyrxctkpY0g.wDf3j2ZMqmhSHGX2Mc1heN0ITZBSfbhQI6s9uCM8OHEo
 _Fs0AbTr0uLha5v1f_1W9iZbNYpIoyVQJrYMP7oZWycc._WtpEae7rbqngR0lImNaCMAtg3BATBc
 26QEKMuoQf_ZV.I.w_qYak3WyCXuP__ahywl45KnU5TIqgef_mQy82DcTt0vsEar0AtKIiO.1AYt
 8jnlpTVwiq8rysczIhMLiFOXBlUTVzP6NG0PBFc9DugZd4yd.3Rw3j4BIE2wevA0ppsDUVDfSQko
 i3KYPtiBU2JRcJqd9JzGiQC6V6EaGAXv81HY0BJ43ffungL1DDrBdw2RvF_uhydJ3Kvam5ijfKQc
 mVUf2jb1Csfmn4xV6cGBjqT3Nuc7.6JlHYkAPdka3J3vVXxuGynBa9U44I1RODYHQ0QZ1XRp_yZQ
 mJcxFQb3YVoRZhjP63PWkHaL1SIQ8cZeKeOO6OHPDLZMWIRsyfjp9SiibsDE28j3DwAG5cowqgba
 9wqlFneoxc6m_H9N_a5Q8LGpP0fa8Yk9bdWvSgvlsK5MjOqNQNzgkaOXMWNNDKxRVACkBuEaslpp
 WC4F0QarZOobl99TUgbDpVmPRVocBYTDRpKtf.jgNyqgrmE241pSveWWk5xHlqXxgPy3Tg4acKWn
 pMhZXp1YIdMQfuHrgQ731HbjT8EGfF7q1mhTO0.Ve8o71AJK6GDHDC.ckWSI1CtWETsUrX89oDQp
 .gieltMAQ.AZs5IdE0WymdoXTo.DgRvPY0kmG3Bja4IzBUnZU4iLGiKYybOaS68KBwE.Fh6cuX8R
 gG4XYHJUFfg1Bvn5elsPqvod_XQe_E162IAOqGwMw23l4IhffwmqP7wG2.106SBbP1IN9brqsEDU
 9.X8hLLOVHletVEhvv87iSCtAXcqsNGFIybJqnwk_vxybz8azRYrQJYSFpjlsYRTp7mt6vwNbgzl
 3pcK.UvvcYdDU3qBwPjPNvYq5RX9W2t.IxVvDeMr1g_.rYHsDQ5c8zlr6W4K70A7E4V3DZ_RdxUD
 ToSH.OpewEFh8UImveXA8dCIb5mWEzjpMcdK_NaeSusJdC9VwDOBslTUUDD9FvIzNgJDUuxsOINp
 wX5SujF4MR5kQsH.hNWXv8vjmh.zQXHJIK.zMVa_e0_SCIBG38eapaVbtcH3KM5IrbbBlafJ_1ph
 XFo5T0MfYMAXf9TeSRuco0oU7bRKndjHkfMC8J7VUMUflJ.g4vUUtJhdrBk2OEOa88RDLsv9kUdQ
 7lAqWBPHzK_AbwsSTIoj2eGMzQUEo4g64aUmric687GPo3SDo7bjCQjPRCUw3nHVLE.N42ZfLW.X
 7T1xW9VzNumDqFiE9Lb_mDOcoXEVbph5PTRpd44JQUoNA65qhL1Rc0iFL1xQX7qPpMLfBiepciRY
 pi92pw_cnuLStpkY_Qn25t_RPZYkEdD9hP59GcFZRuxbmgibtmEttnHIr7DDk2rcjdocusEFqFEZ
 RthX6otzNZayMeXPSzrNZGOKR24vfzjkcGNeoqkfeSvmNu4Z7_WXFBx1ZilwEOx8lswPU6MehRuG
 Gh0sAZNAxWr5m7iXokt1.76CcgyXEEnLGim4Y1M.1gZz0lSqpLfG9OQB0u4BFhiN_Q1D2nAEqd6U
 prxKxUnkgP3r1b9NR.HiRQH_Ep4GulEOP4Y8HyAK6go1yUsh9NNeLFF.RBJCC_tA4n8D5SUQmo2n
 fIF.RC509PxAOIdtslelTxkMvo1knGySqNfLuwL_b0IFWZaPavRIswJ9DVnSvEKA.4X.7bjwELjX
 F8V8M4LWX5YvHgjcnHJyS7wu0cSQ.7qGUJVVTNTYLZsk6DMxNTGr8UBSqHsuKa85eX2fnFsr.KFf
 PO2D0nyhKMImjVZFdBsi7p_PIDwKPLsQ.tb5ua82BRzZk9I0hooK0bqM8b6fUdzAoRqNtemYrU_s
 C6qYGjXnbtFtTFlN7YPWMHZ7TjTrnMwCZylsKowsCIeEcfhQe8dmfZcqEX07tmvTAsKY5SLq5RXf
 nMvWKRmQuw9eZfc0lv3mq5SUiiHhhWQ.quHq2P.XUZfm3PoN9bF7Ekm535P_MHK2vybI0CfSjhd4
 BL_sTA.a9oMlyseGxf68zTrivRawKniYbg7oNLWOs99WS1eiKaKPXj372ys16uRLQzqt_MiuNaX_
 327Pmgh20UYHzSINLcZx7D8hyqyvyIowb5mjRy6c2L87D3rPkW7NAGYe2ZdpVAzQYv5ABFSjUYjf
 dHffuvgpdXC1gHTh1oMddzIVoqCeDTd_DBWMiJ.J7mfF.xztxdkueXcMIwlOqz3xk2EW_hpdT4Dk
 4Q6sTj2Lz7RtchdPbqMm84tQ_by.l8_t3S.QZP6BpSmnMWq99Ks0Lf49o9ByNXA4jO8ApUCZ__ST
 twgKg.H6.3BpNoj795jwGSStl6ntdEEDK.mNwtpR2V5OqVQb6y4MPgkycflvoOZkb8ZkQIVvSgHI
 hY8LPzSSypEv4Ebc9Z_WROGxJLSZVeqx3hmDOj_ZLkAB0ruGPrQKfVBhiAJ97kPR6h7Zh1ZQsKi0
 SExqxtV1rMdvlzyQs.yfHhREh.1nUh1ZdsyLRNL_6Hz8T87BHL3lV4_Q5g02tmjCT9lyI2MSsIXc
 HY2A441LhWAudWoQo0u09f3pcROCgXIphBNIXJr2QSd7KHDMfwnR.edZGmhw9gikuU3wgOOOK4JJ
 z9pfbe7.nq5LEqZnxa7oMLqPrJjgJXGDyCgqb2IXWaHMO5w7x3rAZP.Xi5P94.1Kya_Mxc9E1gsp
 zBi00Gbt9s_Pl6YDZKeQF.JX.XvKRYqYvW8p8ODAKwf_fvj1T23M2CWTPIYpNGfeOAU59hoS9ccV
 5xva9memHlpVByH8rO5sVNGM_bffTR2fSFkF9KD7Sm5AdCYWt6UZgqYYym.jA0.rLMaSiCowHeln
 OZXvhbUtgmzp2vrGcamrKQmUVJIYron.rH4kO3XfkUP9xRpvhjrCiJV8dnB.wm5d7u7MYYu_umhJ
 Gw3PEmVpE6vHC7dC5ZeNMc0fmurNzkMXGM9B4Rx9bJ.q4c6xANNZOPSOxv1io3Ndgx3ka3aRo60e
 vALEbhtNID9462ApOOC831pNg1pHcROOKFgTuVaf1WC5N4WvxGvvfyVWDR1tjAe1W2k3hb0PqbKY
 kQ2UrVhWpasTjlgXDPUgx4URLiWXcJoDTssvM.KtaUE.XtqDLta9N8igZMh7JwCEmfxUXsMzvOiL
 XeA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Nov 2020 01:01:12 +0000
Received: by smtp403.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5144cd02d3567cc7135dcf2a346fa93b;
          Thu, 05 Nov 2020 01:01:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v22 10/23] LSM: Use lsmblob in security_cred_getsecid
Date:   Wed,  4 Nov 2020 16:49:11 -0800
Message-Id: <20201105004924.11651-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201105004924.11651-1-casey@schaufler-ca.com>
References: <20201105004924.11651-1-casey@schaufler-ca.com>
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

