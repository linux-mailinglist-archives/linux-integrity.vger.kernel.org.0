Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEEBD332955
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Mar 2021 15:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhCIO4X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Mar 2021 09:56:23 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:46651
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231829AbhCIO4M (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Mar 2021 09:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615301772; bh=O+p6dWZiLzb8GTPf1rVGA6Hwfi8ItL856LdCOZO8xzI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=s6p89uL44ot2tw/7a+okYPI22DlRKmBkClfhcFT4zogRg0muetaUKynB9YYifNhzxRMLNl3kXP8g9hvfvBZQ7qFplbLKWbZnp0ScAd9yriu/MhPoLFcy0L8r6wRTq1mp9nNYs8VR2zv5X1m53CBGRCX3yeoRsFmg4aftqWq03M82+cbPKg4Kq+euRFb/GMpC2j+KLBuBgB8vxMCEpxfio7TVX7Sx+0Rvy+zEgFMy1H4wmiehk41cUhSLS4GDMKb6iStt8okczmqHQMEX+LOwjv9uEMIdGP+Gkx+LmRDiSsr4Y+bUJvp/sFVEzusEOllLehVraLssp+oJTzJAzgUssw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615301772; bh=B1AIaU84PK7tVSPMqsecyTS7jW9lVoYjbjZEi4qDEK9=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=aDXAVU0f+ip33RcpxH80caQNtFrIIXDPTa/n5dpdvoGA0xdaENxVMUmtJSlwM5MxIis3FisU7PZSii+iLmpAdSIHlMZC4qlHzz5IEMUCdf2cpb+wXCtKFOD2pPWFuO+6tXOcl7nCiGMEp20GquT0CUoJcUwrBgeVx6q0M5krOq+OpqWD+LJRRLQlE5ah0XwIe1c1xI5yaiMM2JLL3Gll6HRLkL6XsHNwGrCyh/KKCnmzAdeUqTM9606PxaCDV9/yS3SN8lrWElVkvPBGyucp5Tdqbl6BgGOgG+k5zhXg433+2h5yytPbn020YwYeT9VcRFJEIi45rMKpT5P2VbCPfg==
X-YMail-OSG: YHNh52AVM1mA6uF2CjGTlWaTpMis015__gHWvwnTIBXF2_trUgO4z5ykID2.3Rq
 tbcXu0w5tLI500cVV9FHyxc86uDlP1uJr3qe7lL3jdnD83NMyXqDG19by3OWiilF9BEc1TSSltI1
 OTGRiDTzvcizhAD2p62w5GIvQ80JJHm.D8RTbosnDYZVk0smXBZefogMyBgw4QTqISTjbSv3KHvV
 kOExaAYzcrW4Fu4FOUHFRkF0xNqv9FaDNq4ZPkOzaxFon9sBI6VVDHID_oUJZP8jr1l3Ko3MPgPl
 doVpOhUMoiRtQrJaHNXrUe2gjOU.i16dbl8uX9WySNvzzIpdcLcx_Vhbmky_gxUoB4srDpXXcCzH
 zz13.Isq2OzGvzWU0X2k4fslbgJE_feVy_K8YmbQeGOJ2AzLsZmdUThyncWW7KzSp4_Yir2bZjSR
 okWr6nvUDimt95Lzu_gxCPf6t4b_BBKp8RxUEC8IP_kYphGIXS.RFgk1rtxBBFmbox_.jajy_FpH
 FC96kstOEHd9M1EXWyInA0bgKGFMJE5UWN5_yH3yQgdAVAvAjdkbs0L5BzwQcCVm3gNh7qK7Yymc
 iFcIAEaygvZmJQU8r5OO.GDS7O35hD4XEpXBJKSL9gK2e7CNFo1598qHhtmkNGiTNEZX0dVc15jJ
 x.f66VEd6IigZVHy5VBpW_vBBj3zHAd49N6_.7.htJ1CH7k9BcTksY01Ak85St9GQiy_qb79sjNs
 6IdTRiWBoDXHNym2hfXe_JbTEjLQQAgJ.18GwAmhq6rRDTumHhbnsVhBvPV01kciAjPdUolzoD5m
 mjIfIl3fCCz_bPYekXi08lhj9LWLcz1LosuY5r0iUNuVKX73kyCbxa6i78zu1EilIGZJUvWog6J1
 c9jLawcF2yxeBGCrBIYA6sGYn_xvbIYA.rEsWQADuux9.A8Cbxd0393OieWiZxr.rTzaOc0VvY70
 lPwmqQy4NCH2SajZGUDnGKVJbuGZsN5xOH5vyeprAugTbIA2PR8npozfeNQ.pTbXLwNCgftxhr75
 ujNfgxKsHlzxsGtuyi0wnNEd0S58kh1PS7KM8YgSilaGNfkHAdy9wLqRKiN925p9lAZoPeM.qDOp
 LDo5RjyVSCGqgr8maHN9PN74yCn9JMCKhsnkCNdwlfbCaIO0gWX4enjqK1TQPPNPwPFJUh2sUVjt
 LgW_udFdzlFnIeiPVtb1nmgFn6oZv68EEcr9sd5kh2ib.cE4V.6mGw3ZpzFbiNJkTaBDY6CGira6
 fssPHPKmzDy1UFnxW6VMsncnqMnqt9BkM0lMUsU8WZr7HI9Y8mNCjHlbHYqa7cjBUJw.hjUfTllQ
 CIkxNamCfFlzAJpphoho3vfBCvaiq4IQJJZayrW.IolI6LrQfC_n4PD_RTX0LGGJBh8NUNj96ZfC
 .gWPV2WHlDgseQsAgS1kAAtlWlhjlG9g3N2W_6FwHghnYQzMf70hsWif_I_G0gt8I3nHT8ZtNmA7
 K.CjesO4_QqymeN0.LR1b.OhfjHKeph4cV1ningnvkpV6nv.ZgdkzQQnUryj4XQYIrJm9NvIlKe0
 xwh7zOsKk4UT9pZqmOs7lEdlv3RYBkj8CoV6vGQoA2g9Ed0EF5NVSKriOY5jEy3RCs_.MxdXFIEE
 wjvdOXQ0WTvItnnzIlB4iLmHaNJmjzUFgsdaUvVbLilHUBVTm25Glmz_uQj.jUoO4Q9Cc27y2y5V
 .DE09LgNmsH.XT8ExfnYiy2JKQfmWmPk0J7wYW3R6pEs9Sw_T8DPR.5twtKV7uAtBeWVSGk6ZBmt
 C_dvN6cUq04SZdAsv3LFkIMwyOvRQo4X5RWhq8HQOf.LAREcS7Wzbz6JO0y2DO8TsoxsxbEixrx3
 aoS6w2ssl9Qr_EG_kbeHSFDh9vinvbdWkSaJ7zlJ9aSl8l.kWacOS88PLgc_jcuZJh12Q5Hi.qaq
 yRGw7P_qWcpp3fw.tJ6pk2mdSY4Bnvs1qxOahiwYBKCEocqcb0Zf927M8QdFHkb0czz7fbw1tQ38
 ZLfgFTJUIIYQZYf3ih2Y6X0BMLGaEb.6CsjQ_S3GYnvSmC5vyag.lWQKg.jnknETo8AZPHzRHRSH
 4bIiHdGWu4LNWfE.pyfJ3s2jqazTmGiW4W2Qx6pgif5pKaWOTejetBrpH3mnhXKgSvbzQcDwTR.1
 ClrzJc0wm3z5RjbApa_uwRyKHFEl39Ny4R_DeEM39ASdh79Zkj9dhhtzqbqBfyTUT5x1JZm94QCx
 utY9rywgNB02UTlEYMeEToAvrTXy812kanPxNpO98yDm6pRVHDZ9t2ECWoPJP3.AQZki5373EYio
 rfK70deDCjhlzKA27KqaRBPcTY2IEzStKTedK09e67KLnWAk919eC321VVhWJcMw8rY89E55XMzV
 NxDN_o8TMDag9qILOH7u1Fb06HCJuEsRHx5ZNmXLtOWglxZdSw50.CkFZ98nxQv2ND5z63cDk3tl
 VzhSB.igP0MO7FobHguyj1f0qgmbFHUwP4UTHkOKKqKDOhFXKa4hWBd3t7DfPcb7rVzo4JzuRDB7
 pAuUHEaUiEwJ3siPLsIOXASkvdDJy.xTGvzUPkZgMhHmYMxkB5Dh3H2mAkZdiXLSqooTWOlfeu14
 M.6psRd8HP1gNkodqmlLuH083NWZ9k0kB1q6ozVTdxmofOjdh_3BtocksMS7Nh0jXDLw7Zy80dG3
 Dc9LMdzi6TpqPH5g8hi3UjKqd1XgUsrxB4oSLoaWiuTMsvbg8uRbUUZslMiwIkuww0J_YX7cxtcz
 XgUYqmv1EWNdCa3Ow9u9BDS6LrhWqhJ3WzKqM2gHxIPrQX0CjhxuhoO2kX_1XyxdqCiC7DDHNFUB
 FgocxKgorF3cr8EBvR_SVb2vgK4O4QNvlcukbFN4tRHHAj2.UNyCUzs_f6rONl1vTyDqdpshf3Pr
 ZMmdwr6p9Ehpt8l_FX_him7mS2iso26.pH8enkxDXVI1Xg8yWPWbI7f5qV8wGiGvCvNx349nsrks
 yDLSAq0BMjeC4_BA14fZAM4_3ta8_sc2TKdzoBgEMMOT30Am5LxTMcE7zM.TLHXhsUz3PvLggZmq
 9U0v80IELqSPB4T0jRrB07MQqFA6r3NnzOJHbnUxBkS8.BGdO37DkFbuikvZ2X13xy5UBJDzeEVF
 huGZSQCNeWbnsHeDwMyJmlXSfDt.UFAIcO0Xvhlub2hx4swlLrS1wHKxYv8LwirWGFqU_AOB9AQz
 iVzz_rJaWzc26qesOfew-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Mar 2021 14:56:12 +0000
Received: by kubenode525.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0ac1cd410e593f27049cb4773eb5c00f;
          Tue, 09 Mar 2021 14:56:07 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v25 12/25] LSM: Use lsmblob in security_cred_getsecid
Date:   Tue,  9 Mar 2021 06:42:30 -0800
Message-Id: <20210309144243.12519-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309144243.12519-1-casey@schaufler-ca.com>
References: <20210309144243.12519-1-casey@schaufler-ca.com>
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
index 6fa19899903e..175c8032b636 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -479,7 +479,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
 void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
-void security_cred_getsecid(const struct cred *c, u32 *secid);
+void security_cred_getsecid(const struct cred *c, struct lsmblob *blob);
 int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
diff --git a/kernel/audit.c b/kernel/audit.c
index 70df7ac1b357..c06133104695 100644
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
index 59cb2c4ad149..768989b2f09e 100644
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
@@ -2421,15 +2420,12 @@ int __audit_sockaddr(int len, void *a)
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
 
@@ -2445,7 +2441,6 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
-	struct lsmblob blob;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2457,9 +2452,7 @@ int audit_signal_info_syscall(struct task_struct *t)
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
@@ -2480,9 +2473,7 @@ int audit_signal_info_syscall(struct task_struct *t)
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
index 360c5e3760cc..5a6ba57beef3 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -470,7 +470,6 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
-	u32 secid;
 	struct lsmblob blob;
 
 	security_task_getsecid(current, &blob);
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
index 54bca6d52ab7..0d9a4b50f252 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1752,10 +1752,16 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
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

