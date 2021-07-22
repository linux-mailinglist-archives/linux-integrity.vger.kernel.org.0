Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACF23D1B16
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jul 2021 03:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhGVAUt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Jul 2021 20:20:49 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:43417
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230013AbhGVAUs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Jul 2021 20:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626915684; bh=2X8LFvatnxpIK/lrE9liux7oG+mNLt1fOTdrK5/l/pE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=DBqP4303zE4sEGaVpgWNm9lNfaGU9SFfO35YrrZeRllSKJD37pQYe6JdNTHzOXby4hqfBgrmwCF2N94vYc6rnQ10GKHIYrTR/6yToMXLIijdADcAxS9Ah3rdgK9h4qL5mzaizCzS3xuAtBF8mStoLdhHH3CezGtAw69D75jOZE5VMxRK1J6QWwUdi4NG79XViER4FZ+ROdkyziwk8QWx1Ya3UlulIVgqWGaFSiKsz7ygFFVdn5vXsfGdow0Xj+ko0RyKe4pgydKCqCrd/PlGVQkFXLCSuhjb2LkvC/AytyQeXRn2hIB1lpfeYZARXn2mmDjRsiZSNIDTHF9YCS0phQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626915684; bh=+AilvMnDjpXBQl/GogbK1EACpGJY+ej+qXUKeZaFBUo=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=QIH6ZxY44P5imv11JjAefjx7TGcFC6w4qaqySfs98Zl5fTlk0B1TvJjFpZwdh5uXJHV6N9ygCVKS7RugKrJrJ3Lzoq8t+XcwRwOzexqXEWvru74+cXSCXA3NXaSFciylFDtpyF7J3J4cDagXgYWWy/YFbP+YnO2ILc+V8Ma2K5MNZJ3LXS49EoEECrZumDJi6kXlkQoYfnJmxGjeKJJCinYmv3l18R+LpMZQQ/dJKPADAIN7r6s+boh5UrQW9RyMt8c9ZCEvDLdoy5bE7Vs/rZMjxRN9m0Z8p2figKGqB1C0XccHLiFb887/WEQ9/aTQV1qTzwzAv8Z17fx1b/d6cw==
X-YMail-OSG: i4FdoqYVM1knNlIXY8KiFEIdv7SC30Kn7SNJFDRC6Vd7Ds9vjKgWSGLohSaxSWW
 4QUBM3lp4ZJOKiE8BdVmyHqiCcTABZRoRZWbUy4x7GQnYmwCX9TasWjdqjjCAZktKqc7fx7wIzHL
 JoaQqzC0uaylOvdsyliUq16RTUhUsmV.LU1QY44ftHCPQOPMyAMhCnB6Mj_aGckkeWz7ZvaDD2n_
 fDrNLlYTVwbWBBFDnTU5n_S5I2FMKCm_d7zfAvr0VdBoEEudaWlFhIzSKZlIzk4b.ru2hnnBvCz6
 ULgbAjvY0gaNlpkTBcJf6hjy3Zl574MUpBARuQyGNrxxNDXvhW6ACdl4TynixJgBRDwXNpm2ZpNN
 r74fliTEdtK94uhHlF_aPBXo_ZOHyYP5ZxC4CV.Mo9MZZx1yUc_3eoWbdRJwchpUKyjJJcMJLcpT
 vT2Uh3f9O2aiLgYyXiiLo8.7125tAaztWVckWP539dwCfPGFXxOFRlhCkqSVBq9WLCeBIbM_LEQ3
 4LXfNJugOZlKhr.kSrKN9Pe0n5lacxh9PsZELEvF19foewt8oRhPR152Nq2TkYB_i7v6422STiwH
 mdU1Tqphk1z.q892juO7UwnPGs8XjDp8jq7Kh1hRftHVJXQvo7hv2rK5IC3mfE67a52TlUMmZVtF
 HY6KM43TUC7vDpnC65.8DROE.pXS0vn0a09EVlGCNyspfIF2X0QN51sKEGWGfTdseZ7SU_JpxfAf
 00DqUKHEkFEL7V1IJDRtAhy64rqUvbUjS5PlwhloBp2zlp0f1PpBQ2YzJHBF2ZFPh6OlyY64yTIZ
 jGVT8wln7Mrf6wYQksflwOak.tSAS33uZHSwo5QO5csor.g4bonmHefG3nG3t91x9UMqt4vosTL.
 Nr36FvcR0HYutpcx7ymkBeRukB1YSeuj0dY408OwCGuPw5J2VgcSsci.zelANB9sAMt.MN1N2wpU
 3TT1ffIZkwLwNwOodREO3eeeWgta6U9YyQkgyQaKjZdiASuuOxNlLIk6SIYjHTqTeALiofy3Vujy
 U4ZyOwhmHKdwBiHYeTHeMk.GSzrGqRnutqj3tX.7eoK6UOUepn.AxdeZAYD6Tx5Gn7noXgMSI_27
 a86ZiSJJtH1ar9AjFr1o6MynsH7C.7yQRQRAEsMfeaKp3uSSlf5shAqIb3X07GRY24qvK929pCm8
 7XwcvesQvIfny_Mi51DIsOqgzGy56nW2kSmQBOVqxJZo3ltfut7Sa7ffE3iyptP6yNYvO2JbL2co
 x43J0DMxyc5nOxNRjE_puCgN0.KtODrLSpQsIRH9Kr77qi8yrydIbdzy_6Ioc6YYpjpQhaC9bO9k
 ujAxNMQ0o602Y1VO069AJDtpTz5pYhIgfyPWwETpHXfiLN.LbWJAi_jt2wEYBdxCcsh27UrhEYz.
 BhYpklng_.v9wtW3s7sstwYqgFj383TWPe2h0SKt3g5KJgoVgyfnIuCjnAXBLjHR0ze7HooYQUIL
 FfOjzx9jpklQeCc7DFU_5VwyAta44ESTj7ZgUUYVkyce1gnzSxyChaIgWwBFgcdAbFB6ESAy79r8
 v0ozksfsZvhoH5MZTgypve94Gy.jbqgzwze7TbF8VDBL_h40A5gpX.V_8H8v39c280qL70nrdcjv
 bFrVy8ZJ3IrMPVlPvllTOsFrn_6A0IAj2Oi5ASk8QTTwA8tEZ5943WR0O9GUaBcEvan9Oh4nBSL5
 6ozPXtW3rZvdBSpG7LnKDEeq6Dq3SlE2UkIHOE5pCEro1X_N42OPMzXacLpsmCr92E7MwcSMScdv
 S6sBdbTsfyTqbacsw375r_5TjtvfuDBGTRNA6yaGeCUYCe9LkCUvm7oDKP6chugMyCozQAH6Fk.2
 qPUNKjTOJElThJ2Om_8ewxUktcXjmwN7ghiRpOqosO_vvYMSgu9k1FyXiyEIlJaaWHgF2UYyypxo
 jHKCBH8X99ogdoOcs_0FGEMHit58_XLqOAdOPsRvp7v99Gwix6GbjVl2pQ4RfxT0p6qVYQSxBaIB
 8s0zMwH15pMSD21O7ZIi6g9Crn.PVPRvmXnrgyNO0uOVeC2Y8jFxg3OhECHThVs1XFKf7BgfbML.
 gUVLQh.EBXJyvB_6XyCTfmVMXfGaiMmBHK5EhfQhDodd8ihdV1OyC04r9wWkq1.YTv8.OXnlwVh4
 xKNqhuFQ.eWQkvdub7xHbFECpwy1iXcF9mZj7LjyBaYDFP4taSczM.H1JzwmP2DSxbqeXOPc4GPW
 TtNpSx5s.ZpEKDlRDgqrhI7R2wMKll3teDLL7NDKZtZ7elvhKM2qnUfWFyFm2jg83yP_9Yovmgxw
 IDtNWS8UctSRsTmhilQPkebmsgnfQpZuSfgxZDTDujQq9LumPjM71kGuKuMR1G.iKsXGlRWtH28s
 PUtYmn.J.2Y6YQSBUWmHP3RS3lVs3t_R.V_8GlwClWnsWwfOKIGwEc.qn1kTDQL0xCjQdVgobtZN
 _PRP5voV784irw.SzkCUU30vZ2y1CCg4v3QFfk.LCF1EC64K9NkN3ZKbNkA2QBO1Ab1Dh2Sq83JJ
 ZUKBet5xv4rdmyUzx26ktUZ2x3lItJWXI0.Ilv6Ig11QCBmN4SJLP9a08iq8tBHCk5ObIcYuwnLZ
 eapULgZr4dixzYJSZ.NyBLyRjkA8FhwtkLFLTFdNEgWODQpXkEfrQt8iTO_SPjAKfitWosKA69ag
 hERgxHra.EGUIUDo0MDDqQxP60fBqIo0W1HTAsocdazj6gAJejbPTfc1ygsze_xRMglLxaG7hQI2
 2iu6UZ5.i9aF4Xql.oQifgAKHU_mSQrzjFvY8DuiBxWanXEhG_lhlvHDcz7w4KikYBPxc3r_20zK
 IvkSf9dFFeHyeHUk4IOnOq4.zvq01FVQWK6.CxOiEH028ewt306qXGpYL8vfhMen1nSeyANc.dmT
 dzn_SBIYKaw6iNrJr3bnfDe.t6U39v2gHzIfzaEsJvSQchAUA.TwTJaNxQ27zUtfmoLYGkptPXq8
 Se3UG0lvle9EBsf6vyws0jjfww6HjuESCMEd8vp41YIeUcLHj1dzbZCf4Mhs1fSo4Cel14EtUvgD
 gfL65TbLtYHCvq0O2v5nVWJFJzc0IUL5LY_efy7XFsavpPEbRFh2SFp5y1wHq1.HDeFYnjfKTNvd
 E3mXPXsL.6Sk83hl4Eb4zqX6ml.3zyF6VJ6eka4W3D2sw1.CroAygQ9KnITWSDyA-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Jul 2021 01:01:24 +0000
Received: by kubenode511.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 45dfe82e9b3831ed5b3bfa5b74958e01;
          Thu, 22 Jul 2021 01:01:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v28 12/25] LSM: Use lsmblob in security_cred_getsecid
Date:   Wed, 21 Jul 2021 17:47:45 -0700
Message-Id: <20210722004758.12371-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210722004758.12371-1-casey@schaufler-ca.com>
References: <20210722004758.12371-1-casey@schaufler-ca.com>
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
index aa19fa4a553f..cdd8d9122795 100644
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
index b565ea16c0a5..b679517a3030 100644
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
index 29befd24b945..de084954d0b9 100644
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
index da85932a4d53..b4a268c1aaec 100644
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
2.31.1

