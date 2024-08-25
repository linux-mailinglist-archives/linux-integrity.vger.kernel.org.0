Return-Path: <linux-integrity+bounces-3377-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE5E95E4CC
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Aug 2024 21:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A621C21559
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Aug 2024 19:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C05440855;
	Sun, 25 Aug 2024 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WZhSaTzW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A7E156678
	for <linux-integrity@vger.kernel.org>; Sun, 25 Aug 2024 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724612658; cv=none; b=j6jgnzxNUQnwhHIkaI6aaE/6fZkVEg1M9hoc8JwDSg8lU2oCq3AU87dZZXIxD1Np6xs61X4qWU2otLkwltcxV6ta7sMdUUmHnmK3KxW+hxqFoWiev/ANEdv0CoB4DGfsbaEQTOQgvZJvWZMWMD7w3TAl7dNBJFxKY7eV6OqA7bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724612658; c=relaxed/simple;
	bh=9zYQ3GW3YC4yN93W1YD9IafWkuGNE4K/c19lroiqBRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6Fb9vwFYcJe8RirGcNfR0owEanezwhJSM9TzX/hooAitvz32hivpoeQcokExyZLllAv0LfZnVBVZnCSKksfj1NQ/EfSEuV77mzLlBjnRXQXSZEDEOs/m+OJeMXbcGnBhdvIiEGyLIvrYpTKmZ8xgcaxArhp4GNakQUDu7qTrLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WZhSaTzW; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612655; bh=yFoDbiXxMQOSPnSs0v9vLpOXlKAcud/ulSsZq5Pm96c=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WZhSaTzW+H4xunnu+/XULo/zm3QPc65u7pm+hBNyLOuH54oDGtKuMnfBJfPE/9iE2k2RYBLuC9yfge6db0PNrIrgj9j8+V/njVROHprba/DSwwOCIrdlsaeDWvFshrCmgcxap4n/+e4gf7Yufjeq9ZN87lFVLfOUfSz9WWTgl/hSNFjkpfZIZxKY3J70h4cNajDWsJYUWAiyrJlG4csKvImOKZyYC8+jztBXZz4Yi5f3v3HvYoxEUAs99ZVBhIB08TMLIRmQu08N2Z3m5Dv4IjZzAyNZn5nY3S2PMQ8jh8Iz4GbLw76UPleGdXdvWtIB1/Vh0Wu/3jSkorOmLqADtQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612655; bh=E8MEH9vAPlvutJTzqXmGmco+4+kX+QQcLbXk4E7RnDF=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=TedHqyw8NglzMg0xs6tzVKtuerZU/zAfMRiLKC+KEeX0ZQGECE91aKcNAKD9J6urG1FPlj7U8Zla+5xCvej4qv6SyGyAqIqjJSSWCwDi5PyzbWbVxBIGPoVQqWMbNuXOFvBKlxniQcjXAebgDZNj79B+VNfKueDYO2Ug+B5t7JQbr36UffIyBt0cerCLdp9Fc+0He+CaVfSRunu0WEWin1+BuIFf8HQy+uql4l9dkYnOVGMrBXNaJkprZlKIQBAJtAt2TSnzSvRPah/HRc2znsSlRgQ+yRKMX9ltLY9VY4TQNE5PjGoyrsd/LvcZwKBqRKWhf0naNWD2/Hur4iUZyQ==
X-YMail-OSG: xSCC63IVM1lIKnY.a6SvDJTl7mIv906mDR_lncrUi7_HnK4.0IOQLKPRvIDGPRj
 cccRX5tIIZ9IR4juM9rw4Ur1Kp.BpuHAkeWngiRSB.pR_qM.mZZFLfQRMfEa2tBUtm1vWcfPbF7O
 EZfA408KdP_hnuCA6sKS6z0dSSe0ajTiUXRGtR3wMBJ_1o8ojLn857Le0T0uOZ6xWwt0VFxGXdsU
 TisdB6lMCoskU9v6Cijd3mWYhYAbZ3BZ34IAb0hXyXyfS.bEpiZyVvDuambeGvzOkoCxGQ_vFbtu
 VcIBjipol.IeGQF9UQxg2NZBSC1kUpvx10qCgLWCpR3sQg38kdrGOj2WRycPLPpmgRHJJ0uJ3RMN
 bRi.u5wGl8M7V1p5POlo6E0E5Bhd1yPm_0V9S.V5S5.hWC4bOdGD8QekqwJ3ZzCDdPK_4oFC6sf7
 wSatyyE4rV6Qwy5t5mY.R9VlIHuRdgIYdL2J88N1NVuALd1R_5NJM.nVQ.c7yHEqtn7p9imUZxKW
 vOmq1.Jt0l_1mYBSdDWmxbmQi.OFI2Af795WCwUamC8KQiSrrCJ6JoT5_KfKVn_F13yIj2lUrdU3
 iiCRHxPtFOlWDDWKqkPLQNAen1pfYWKFcoiIfNGaAnzazh2qo69vhjrF_Hq8R5L4xB_20SPtfstO
 qKnOmnzniAqO.l_qidDZx61h727cV_FYPaVjxrLU4m0AqUxCe8C7imOG7iNc1JG0.MQnoq8nlmpz
 FBOBJps91jPhqrTcAxL8WhaIdljPtr1Mj4f2L912Xv74PIX2jWB8SKH7PpRls44otGSrOD0NFt4V
 kyLcr2hFhEdzl1ST60xIosz09n.AkuBhK9oqV5Foqtw8PLdUFeMrOAlKKhtvceZTxDASaQvCyhT7
 fPY6OspjYYnbrq96tuQ8XsmgyRmMiXeIwxNgTZToCllWth9fWzCspzP56G7z_BlcIkLFMqBJRBUa
 sUPFXD21PQh1AMpTSxjGZZJ66.9Dedoe29GhubnFqMTlIMthP2.XKsqHk_Ux4IblW.ZUrl7I_e.M
 F.NJ6uSSnJqgZlo_Y4GHIrdob0jd4UcgKBD9Lh6IKgP1Cr4CXimHiTfHZ7LdYZJQiUKpFoV5USGF
 sv7.NIizuBnI7MFWo4qEMCgEAK4I1sWSyAxBK134gevhwmAIu81Yr66Zx8PEg6TptTF0sXVdf7cm
 vdVl1Z9Z8RyCuBQGrCDIswBaRyZ24B32fjUeOoLKCWmlgSx8Grp5r1iu9hklL45bh398na_WsoLh
 vP0PLiHQN7fpXqh3_5vABon1GyTpLmPJS6DmA6jNawoKDktJE0HhMVa9SGl3oMtMP9OI8IHrq1ib
 HXdG0QPyyDzismOtu0wYLBP2uOOL.SzLPbMe4Zo5ZUEImwd4PNeTCP17FUBvGxHSi6yCHb34Ewq6
 whL8t2ZFB75WmpSI5TUV8MEP_GrUX9csZAHlR07wbAlXHkT5CwzLfJLbItA4eIvNmDYRaOd2gHK_
 LSmhB_.XGr.TkqAfaUdEFc75G2uQm8FQU6KhW3cKV_IVwXpW0OnhsB6jFVK3.rioBABz9NxyAt9u
 .os4SDF91_LPk.z.mZSw5h28ILBp4hIU.XS4PwQNNAnnhiJuyiNpHzYEE0ndTAWm5dIFvz9B2JVl
 1AHGjDj8phansJy1CjDYQ3PULv6vbaYE5GFpnLigTaxPGaZBPWhAu.gwf2UD8MDtlqqH4YhrP899
 Ex.EuBpIgHmuoMs4J.gxtAJOCIXX509GOWPDfQEXUBmBQaHImU8tVexbJ.cvTH5.UIiP2CWOidr3
 akaUp5mvk78SzPGW8GdzppTswAd.pQG0CqPsWOp8TiddNTgDaMuDTX5GuddSC6GnpBowr3pPl749
 g3qQQihG4N6620v2ByU8iROvqX.0a7qgHZO.cYqThN8gJRPEiTveIGdokD3vqCqluAAIkzD9MPkg
 7DZldi4lcis1IDKEhn2BFiaVjMmOe5d2I4.NQBk3kyAwfA_25zGDu2jiEwubRlRUna.9IDjODoT0
 D.zeZpJnPsWEQejkUgBEnHHLx4zQ1g9moQ_6Ff_FHHZt00A.POOhUJ.EfDJ41AnqQc3.l0dO696C
 UBZRGeH1LYM.9sP34HxDCRbsyxhTtw2Lpv.FmnYxskDeyE6oSl5H5mE8Tvd4dtzydVFoYA74WU6A
 BcDHWOlTjUcsG9k72Xxzmm4eMwGKcMPlvYC74BhXanDTbnGiHfRZS5s3r4GhqdAOXkTdmwKCa2zN
 t0__EwXoJ7WPD5b6FxZBxjXhwaeAH2BNrkZ4_jRWqQelqzTQpqHBdhU3cdWUdO8YHLRkgOs5KKwl
 FI4SOUwY5LvLqEU2L4c.N2SHlry8.Tq5a3nbj9g--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 334e4785-8bab-496c-bfa0-430875829517
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Sun, 25 Aug 2024 19:04:15 +0000
Received: by hermes--production-gq1-5d95dc458-dxlpk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID acda3a00d6062e816b69b20719962769;
          Sun, 25 Aug 2024 19:04:10 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	mic@digikod.net,
	linux-integrity@vger.kernel.org,
	linux-audit@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH 07/13] LSM: Use lsmblob in security_current_getsecid
Date: Sun, 25 Aug 2024 12:00:42 -0700
Message-ID: <20240825190048.13289-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240825190048.13289-1-casey@schaufler-ca.com>
References: <20240825190048.13289-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the security_current_getsecid_subj() and
security_task_getsecid_obj() interfaces to fill in
a lsmblob structure instead of a u32 secid.
Audit interfaces will need to collect all
possible security data for possible reporting.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-audit@redhat.com
Cc: netdev@vger.kernel.org
---
 include/linux/lsm_hook_defs.h         |  6 +--
 include/linux/security.h              | 13 +++---
 kernel/audit.c                        | 11 +++--
 kernel/auditfilter.c                  |  3 +-
 kernel/auditsc.c                      | 22 ++++++----
 net/netlabel/netlabel_unlabeled.c     |  5 ++-
 net/netlabel/netlabel_user.h          |  6 ++-
 security/apparmor/lsm.c               | 20 ++++++---
 security/integrity/ima/ima.h          |  6 +--
 security/integrity/ima/ima_api.c      |  6 +--
 security/integrity/ima/ima_appraise.c |  6 +--
 security/integrity/ima/ima_main.c     | 59 ++++++++++++++-------------
 security/integrity/ima/ima_policy.c   | 14 +++----
 security/security.c                   | 28 ++++++-------
 security/selinux/hooks.c              | 17 +++++---
 security/smack/smack_lsm.c            | 23 +++++++----
 16 files changed, 138 insertions(+), 107 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index c3ffc3f98343..06c60f1aefa7 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -232,9 +232,9 @@ LSM_HOOK(int, 0, task_fix_setgroups, struct cred *new, const struct cred * old)
 LSM_HOOK(int, 0, task_setpgid, struct task_struct *p, pid_t pgid)
 LSM_HOOK(int, 0, task_getpgid, struct task_struct *p)
 LSM_HOOK(int, 0, task_getsid, struct task_struct *p)
-LSM_HOOK(void, LSM_RET_VOID, current_getsecid_subj, u32 *secid)
-LSM_HOOK(void, LSM_RET_VOID, task_getsecid_obj,
-	 struct task_struct *p, u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, current_getlsmblob_subj, struct lsmblob *blob)
+LSM_HOOK(void, LSM_RET_VOID, task_getlsmblob_obj,
+	 struct task_struct *p, struct lsmblob *blob)
 LSM_HOOK(int, 0, task_setnice, struct task_struct *p, int nice)
 LSM_HOOK(int, 0, task_setioprio, struct task_struct *p, int ioprio)
 LSM_HOOK(int, 0, task_getioprio, struct task_struct *p)
diff --git a/include/linux/security.h b/include/linux/security.h
index ebe8edaae953..b28f2f7fe4ef 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -492,8 +492,8 @@ int security_task_fix_setgroups(struct cred *new, const struct cred *old);
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
 int security_task_getpgid(struct task_struct *p);
 int security_task_getsid(struct task_struct *p);
-void security_current_getsecid_subj(u32 *secid);
-void security_task_getsecid_obj(struct task_struct *p, u32 *secid);
+void security_current_getlsmblob_subj(struct lsmblob *blob);
+void security_task_getlsmblob_obj(struct task_struct *p, struct lsmblob *blob);
 int security_task_setnice(struct task_struct *p, int nice);
 int security_task_setioprio(struct task_struct *p, int ioprio);
 int security_task_getioprio(struct task_struct *p);
@@ -1268,14 +1268,15 @@ static inline int security_task_getsid(struct task_struct *p)
 	return 0;
 }
 
-static inline void security_current_getsecid_subj(u32 *secid)
+static inline void security_current_getlsmblob_subj(struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob);
 }
 
-static inline void security_task_getsecid_obj(struct task_struct *p, u32 *secid)
+static inline void security_task_getlsmblob_obj(struct task_struct *p,
+						struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob);
 }
 
 static inline int security_task_setnice(struct task_struct *p, int nice)
diff --git a/kernel/audit.c b/kernel/audit.c
index 9dac776b60a7..97c0dea0e3a1 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2179,16 +2179,16 @@ void audit_log_key(struct audit_buffer *ab, char *key)
 
 int audit_log_task_context(struct audit_buffer *ab)
 {
+	struct lsmblob blob;
 	char *ctx = NULL;
 	unsigned len;
 	int error;
-	u32 sid;
 
-	security_current_getsecid_subj(&sid);
-	if (!sid)
+	security_current_getlsmblob_subj(&blob);
+	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_secid_to_secctx(sid, &ctx, &len);
+	error = security_lsmblob_to_secctx(&blob, &ctx, &len);
 	if (error) {
 		if (error != -EINVAL)
 			goto error_path;
@@ -2405,8 +2405,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		/* scaffolding */
-		security_current_getsecid_subj(&audit_sig_lsm.scaffold.secid);
+		security_current_getlsmblob_subj(&audit_sig_lsm);
 	}
 
 	return audit_signal_info_syscall(t);
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index c4c7cda3b846..06309227a0eb 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1371,8 +1371,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
 					/* scaffolding */
-					security_current_getsecid_subj(
-							&blob.scaffold.secid);
+					security_current_getlsmblob_subj(&blob);
 					result = security_audit_rule_match(
 						   &blob, f->type, f->op,
 						   f->lsm_rule);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 94b7ef89da2e..1f05445978f9 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -470,7 +470,6 @@ static int audit_filter_rules(struct task_struct *tsk,
 {
 	const struct cred *cred;
 	int i, need_sid = 1;
-	u32 sid;
 	struct lsmblob blob = { };
 	unsigned int sessionid;
 
@@ -675,15 +674,14 @@ static int audit_filter_rules(struct task_struct *tsk,
 					 * fork()/copy_process() in which case
 					 * the new @tsk creds are still a dup
 					 * of @current's creds so we can still
-					 * use security_current_getsecid_subj()
+					 * use
+					 * security_current_getlsmblob_subj()
 					 * here even though it always refs
 					 * @current's creds
 					 */
-					security_current_getsecid_subj(&sid);
+					security_current_getlsmblob_subj(&blob);
 					need_sid = 0;
 				}
-				/* scaffolding */
-				blob.scaffold.secid = sid;
 				result = security_audit_rule_match(&blob,
 								   f->type,
 								   f->op,
@@ -2730,12 +2728,15 @@ int __audit_sockaddr(int len, void *a)
 void __audit_ptrace(struct task_struct *t)
 {
 	struct audit_context *context = audit_context();
+	struct lsmblob blob;
 
 	context->target_pid = task_tgid_nr(t);
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
-	security_task_getsecid_obj(t, &context->target_sid);
+	security_task_getlsmblob_obj(t, &blob);
+	/* scaffolding */
+	context->target_sid = blob.scaffold.secid;
 	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
 }
 
@@ -2751,6 +2752,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
+	struct lsmblob blob;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2762,7 +2764,9 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getsecid_obj(t, &ctx->target_sid);
+		security_task_getlsmblob_obj(t, &blob);
+		/* scaffolding */
+		ctx->target_sid = blob.scaffold.secid;
 		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
@@ -2783,7 +2787,9 @@ int audit_signal_info_syscall(struct task_struct *t)
 	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
-	security_task_getsecid_obj(t, &axp->target_sid[axp->pid_count]);
+	security_task_getlsmblob_obj(t, &blob);
+	/* scaffolding */
+	axp->target_sid[axp->pid_count] = blob.scaffold.secid;
 	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 9996883bf2b7..7f38dc9b6b57 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1534,11 +1534,14 @@ int __init netlbl_unlabel_defconf(void)
 	int ret_val;
 	struct netlbl_dom_map *entry;
 	struct netlbl_audit audit_info;
+	struct lsmblob blob;
 
 	/* Only the kernel is allowed to call this function and the only time
 	 * it is called is at bootup before the audit subsystem is reporting
 	 * messages so don't worry to much about these values. */
-	security_current_getsecid_subj(&audit_info.secid);
+	security_current_getlsmblob_subj(&blob);
+	/* scaffolding */
+	audit_info.secid = blob.scaffold.secid;
 	audit_info.loginuid = GLOBAL_ROOT_UID;
 	audit_info.sessionid = 0;
 
diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
index d6c5b31eb4eb..40841d7af1d8 100644
--- a/net/netlabel/netlabel_user.h
+++ b/net/netlabel/netlabel_user.h
@@ -32,7 +32,11 @@
  */
 static inline void netlbl_netlink_auditinfo(struct netlbl_audit *audit_info)
 {
-	security_current_getsecid_subj(&audit_info->secid);
+	struct lsmblob blob;
+
+	security_current_getlsmblob_subj(&blob);
+	/* scaffolding */
+	audit_info->secid = blob.scaffold.secid;
 	audit_info->loginuid = audit_get_loginuid(current);
 	audit_info->sessionid = audit_get_sessionid(current);
 }
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 050d103f5ca5..877c4e809ae8 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -982,17 +982,24 @@ static void apparmor_bprm_committed_creds(const struct linux_binprm *bprm)
 	return;
 }
 
-static void apparmor_current_getsecid_subj(u32 *secid)
+static void apparmor_current_getlsmblob_subj(struct lsmblob *blob)
 {
 	struct aa_label *label = __begin_current_label_crit_section();
-	*secid = label->secid;
+
+	blob->apparmor.label = label;
+	/* scaffolding */
+	blob->scaffold.secid = label->secid;
 	__end_current_label_crit_section(label);
 }
 
-static void apparmor_task_getsecid_obj(struct task_struct *p, u32 *secid)
+static void apparmor_task_getlsmblob_obj(struct task_struct *p,
+					  struct lsmblob *blob)
 {
 	struct aa_label *label = aa_get_task_label(p);
-	*secid = label->secid;
+
+	blob->apparmor.label = label;
+	/* scaffolding */
+	blob->scaffold.secid = label->secid;
 	aa_put_label(label);
 }
 
@@ -1518,8 +1525,9 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(task_free, apparmor_task_free),
 	LSM_HOOK_INIT(task_alloc, apparmor_task_alloc),
-	LSM_HOOK_INIT(current_getsecid_subj, apparmor_current_getsecid_subj),
-	LSM_HOOK_INIT(task_getsecid_obj, apparmor_task_getsecid_obj),
+	LSM_HOOK_INIT(current_getlsmblob_subj,
+		      apparmor_current_getlsmblob_subj),
+	LSM_HOOK_INIT(task_getlsmblob_obj, apparmor_task_getlsmblob_obj),
 	LSM_HOOK_INIT(task_setrlimit, apparmor_task_setrlimit),
 	LSM_HOOK_INIT(task_kill, apparmor_task_kill),
 	LSM_HOOK_INIT(userns_create, apparmor_userns_create),
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c51e24d24d1e..64bd77aa28e9 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -369,7 +369,7 @@ static inline void ima_process_queued_keys(void) {}
 
 /* LIM API function definitions */
 int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
-		   const struct cred *cred, u32 secid, int mask,
+		   const struct cred *cred, struct lsmblob *blob, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
 		   const char *func_data, unsigned int *allowed_algos);
@@ -400,8 +400,8 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
 /* IMA policy related functions */
 int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
-		     const struct cred *cred, u32 secid, enum ima_hooks func,
-		     int mask, int flags, int *pcr,
+		     const struct cred *cred, struct lsmblob *blob,
+		     enum ima_hooks func, int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *func_data, unsigned int *allowed_algos);
 void ima_init_policy(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 984e861f6e33..896cf716dd6d 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -165,7 +165,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * @idmap: idmap of the mount the inode was found from
  * @inode: pointer to the inode associated with the object being validated
  * @cred: pointer to credentials structure to validate
- * @secid: secid of the task being validated
+ * @blob: secid(s) of the task being validated
  * @mask: contains the permission mask (MAY_READ, MAY_WRITE, MAY_EXEC,
  *        MAY_APPEND)
  * @func: caller identifier
@@ -187,7 +187,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *
  */
 int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
-		   const struct cred *cred, u32 secid, int mask,
+		   const struct cred *cred, struct lsmblob *blob, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
 		   const char *func_data, unsigned int *allowed_algos)
@@ -196,7 +196,7 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 
 	flags &= ima_policy_flag;
 
-	return ima_match_policy(idmap, inode, cred, secid, func, mask,
+	return ima_match_policy(idmap, inode, cred, blob, func, mask,
 				flags, pcr, template_desc, func_data,
 				allowed_algos);
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 656c709b974f..b0db2f38efc6 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -73,13 +73,13 @@ bool is_ima_appraise_enabled(void)
 int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
 		      int mask, enum ima_hooks func)
 {
-	u32 secid;
+	struct lsmblob blob;
 
 	if (!ima_appraise)
 		return 0;
 
-	security_current_getsecid_subj(&secid);
-	return ima_match_policy(idmap, inode, current_cred(), secid,
+	security_current_getlsmblob_subj(&blob);
+	return ima_match_policy(idmap, inode, current_cred(), &blob,
 				func, mask, IMA_APPRAISE | IMA_HASH, NULL,
 				NULL, NULL, NULL);
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f04f43af651c..d408a700fe6f 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -206,8 +206,8 @@ static void ima_file_free(struct file *file)
 }
 
 static int process_measurement(struct file *file, const struct cred *cred,
-			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func)
+			       struct lsmblob *blob, char *buf, loff_t size,
+			       int mask, enum ima_hooks func)
 {
 	struct inode *real_inode, *inode = file_inode(file);
 	struct ima_iint_cache *iint = NULL;
@@ -232,7 +232,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * bitmask based on the appraise/audit/measurement policy.
 	 * Included is the appraise submask.
 	 */
-	action = ima_get_action(file_mnt_idmap(file), inode, cred, secid,
+	action = ima_get_action(file_mnt_idmap(file), inode, cred, blob,
 				mask, func, &pcr, &template_desc, NULL,
 				&allowed_algos);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
@@ -443,23 +443,23 @@ static int process_measurement(struct file *file, const struct cred *cred,
 static int ima_file_mmap(struct file *file, unsigned long reqprot,
 			 unsigned long prot, unsigned long flags)
 {
-	u32 secid;
+	struct lsmblob blob;
 	int ret;
 
 	if (!file)
 		return 0;
 
-	security_current_getsecid_subj(&secid);
+	security_current_getlsmblob_subj(&blob);
 
 	if (reqprot & PROT_EXEC) {
-		ret = process_measurement(file, current_cred(), secid, NULL,
+		ret = process_measurement(file, current_cred(), &blob, NULL,
 					  0, MAY_EXEC, MMAP_CHECK_REQPROT);
 		if (ret)
 			return ret;
 	}
 
 	if (prot & PROT_EXEC)
-		return process_measurement(file, current_cred(), secid, NULL,
+		return process_measurement(file, current_cred(), &blob, NULL,
 					   0, MAY_EXEC, MMAP_CHECK);
 
 	return 0;
@@ -488,9 +488,9 @@ static int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 	char *pathbuf = NULL;
 	const char *pathname = NULL;
 	struct inode *inode;
+	struct lsmblob blob;
 	int result = 0;
 	int action;
-	u32 secid;
 	int pcr;
 
 	/* Is mprotect making an mmap'ed file executable? */
@@ -498,13 +498,13 @@ static int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
 		return 0;
 
-	security_current_getsecid_subj(&secid);
+	security_current_getlsmblob_subj(&blob);
 	inode = file_inode(vma->vm_file);
 	action = ima_get_action(file_mnt_idmap(vma->vm_file), inode,
-				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
+				current_cred(), &blob, MAY_EXEC, MMAP_CHECK,
 				&pcr, &template, NULL, NULL);
 	action |= ima_get_action(file_mnt_idmap(vma->vm_file), inode,
-				 current_cred(), secid, MAY_EXEC,
+				 current_cred(), &blob, MAY_EXEC,
 				 MMAP_CHECK_REQPROT, &pcr, &template, NULL,
 				 NULL);
 
@@ -542,15 +542,18 @@ static int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
 	u32 secid;
+	struct lsmblob blob = { };
 
-	security_current_getsecid_subj(&secid);
-	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
-				  MAY_EXEC, BPRM_CHECK);
+	security_current_getlsmblob_subj(&blob);
+	ret = process_measurement(bprm->file, current_cred(),
+				  &blob, NULL, 0, MAY_EXEC, BPRM_CHECK);
 	if (ret)
 		return ret;
 
 	security_cred_getsecid(bprm->cred, &secid);
-	return process_measurement(bprm->file, bprm->cred, secid, NULL, 0,
+	/* scaffolding */
+	blob.scaffold.secid = secid;
+	return process_measurement(bprm->file, bprm->cred, &blob, NULL, 0,
 				   MAY_EXEC, CREDS_CHECK);
 }
 
@@ -566,10 +569,10 @@ static int ima_bprm_check(struct linux_binprm *bprm)
  */
 static int ima_file_check(struct file *file, int mask)
 {
-	u32 secid;
+	struct lsmblob blob;
 
-	security_current_getsecid_subj(&secid);
-	return process_measurement(file, current_cred(), secid, NULL, 0,
+	security_current_getlsmblob_subj(&blob);
+	return process_measurement(file, current_cred(), &blob, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -768,7 +771,7 @@ static int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 			 bool contents)
 {
 	enum ima_hooks func;
-	u32 secid;
+	struct lsmblob blob;
 
 	/*
 	 * Do devices using pre-allocated memory run the risk of the
@@ -788,9 +791,9 @@ static int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 
 	/* Read entire file for all partial reads. */
 	func = read_idmap[read_id] ?: FILE_CHECK;
-	security_current_getsecid_subj(&secid);
-	return process_measurement(file, current_cred(), secid, NULL,
-				   0, MAY_READ, func);
+	security_current_getlsmblob_subj(&blob);
+	return process_measurement(file, current_cred(), &blob, NULL, 0,
+				   MAY_READ, func);
 }
 
 const int read_idmap[READING_MAX_ID] = {
@@ -818,7 +821,7 @@ static int ima_post_read_file(struct file *file, char *buf, loff_t size,
 			      enum kernel_read_file_id read_id)
 {
 	enum ima_hooks func;
-	u32 secid;
+	struct lsmblob blob;
 
 	/* permit signed certs */
 	if (!file && read_id == READING_X509_CERTIFICATE)
@@ -831,8 +834,8 @@ static int ima_post_read_file(struct file *file, char *buf, loff_t size,
 	}
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
-	security_current_getsecid_subj(&secid);
-	return process_measurement(file, current_cred(), secid, buf, size,
+	security_current_getlsmblob_subj(&blob);
+	return process_measurement(file, current_cred(), &blob, buf, size,
 				   MAY_READ, func);
 }
 
@@ -967,7 +970,7 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 	int digest_hash_len = hash_digest_size[ima_hash_algo];
 	int violation = 0;
 	int action = 0;
-	u32 secid;
+	struct lsmblob blob;
 
 	if (digest && digest_len < digest_hash_len)
 		return -EINVAL;
@@ -990,9 +993,9 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 	 * buffer measurements.
 	 */
 	if (func) {
-		security_current_getsecid_subj(&secid);
+		security_current_getlsmblob_subj(&blob);
 		action = ima_get_action(idmap, inode, current_cred(),
-					secid, 0, func, &pcr, &template,
+					&blob, 0, func, &pcr, &template,
 					func_data, NULL);
 		if (!(action & IMA_MEASURE) && !digest)
 			return -ENOENT;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 40119816b848..33bdbd031673 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -557,7 +557,7 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
  * @idmap: idmap of the mount the inode was found from
  * @inode: a pointer to an inode
  * @cred: a pointer to a credentials structure for user validation
- * @secid: the secid of the task to be validated
+ * @blob: the secid(s) of the task to be validated
  * @func: LIM hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @func_data: func specific data, may be NULL
@@ -567,7 +567,7 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
 static bool ima_match_rules(struct ima_rule_entry *rule,
 			    struct mnt_idmap *idmap,
 			    struct inode *inode, const struct cred *cred,
-			    u32 secid, enum ima_hooks func, int mask,
+			    struct lsmblob *blob, enum ima_hooks func, int mask,
 			    const char *func_data)
 {
 	int i;
@@ -658,8 +658,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			/* scaffolding */
-			blob.scaffold.secid = secid;
 			rc = ima_filter_rule_match(&blob, lsm_rule->lsm[i].type,
 						   Audit_equal,
 						   lsm_rule->lsm[i].rule);
@@ -723,7 +721,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @inode: pointer to an inode for which the policy decision is being made
  * @cred: pointer to a credentials structure for which the policy decision is
  *        being made
- * @secid: LSM secid of the task to be validated
+ * @blob: LSM secid(s) of the task to be validated
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @flags: IMA actions to consider (e.g. IMA_MEASURE | IMA_APPRAISE)
@@ -740,8 +738,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * than writes so ima_match_policy() is classical RCU candidate.
  */
 int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
-		     const struct cred *cred, u32 secid, enum ima_hooks func,
-		     int mask, int flags, int *pcr,
+		     const struct cred *cred, struct lsmblob *blob,
+		     enum ima_hooks func, int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *func_data, unsigned int *allowed_algos)
 {
@@ -759,7 +757,7 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, idmap, inode, cred, secid,
+		if (!ima_match_rules(entry, idmap, inode, cred, blob,
 				     func, mask, func_data))
 			continue;
 
diff --git a/security/security.c b/security/security.c
index 6e72e678b5b4..b6e28e20ac51 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3373,33 +3373,33 @@ int security_task_getsid(struct task_struct *p)
 }
 
 /**
- * security_current_getsecid_subj() - Get the current task's subjective secid
- * @secid: secid value
+ * security_current_getlsmblob_subj() - Current task's subjective LSM data
+ * @blob: lsm specific information
  *
  * Retrieve the subjective security identifier of the current task and return
- * it in @secid.  In case of failure, @secid will be set to zero.
+ * it in @blob.
  */
-void security_current_getsecid_subj(u32 *secid)
+void security_current_getlsmblob_subj(struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(current_getsecid_subj, secid);
+	lsmblob_init(blob);
+	call_void_hook(current_getlsmblob_subj, blob);
 }
-EXPORT_SYMBOL(security_current_getsecid_subj);
+EXPORT_SYMBOL(security_current_getlsmblob_subj);
 
 /**
- * security_task_getsecid_obj() - Get a task's objective secid
+ * security_task_getlsmblob_obj() - Get a task's objective LSM data
  * @p: target task
- * @secid: secid value
+ * @blob: lsm specific information
  *
  * Retrieve the objective security identifier of the task_struct in @p and
- * return it in @secid. In case of failure, @secid will be set to zero.
+ * return it in @blob.
  */
-void security_task_getsecid_obj(struct task_struct *p, u32 *secid)
+void security_task_getlsmblob_obj(struct task_struct *p, struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(task_getsecid_obj, p, secid);
+	lsmblob_init(blob);
+	call_void_hook(task_getlsmblob_obj, p, blob);
 }
-EXPORT_SYMBOL(security_task_getsecid_obj);
+EXPORT_SYMBOL(security_task_getlsmblob_obj);
 
 /**
  * security_task_setnice() - Check if setting a task's nice value is allowed
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1b34b86426e8..af48b8f868b7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4161,14 +4161,19 @@ static int selinux_task_getsid(struct task_struct *p)
 			    PROCESS__GETSESSION, NULL);
 }
 
-static void selinux_current_getsecid_subj(u32 *secid)
+static void selinux_current_getlsmblob_subj(struct lsmblob *blob)
 {
-	*secid = current_sid();
+	blob->selinux.secid = current_sid();
+	/* scaffolding */
+	blob->scaffold.secid = blob->selinux.secid;
 }
 
-static void selinux_task_getsecid_obj(struct task_struct *p, u32 *secid)
+static void selinux_task_getlsmblob_obj(struct task_struct *p,
+					struct lsmblob *blob)
 {
-	*secid = task_sid_obj(p);
+	blob->selinux.secid = task_sid_obj(p);
+	/* scaffolding */
+	blob->scaffold.secid = blob->selinux.secid;
 }
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
@@ -7240,8 +7245,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
 	LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
 	LSM_HOOK_INIT(task_getsid, selinux_task_getsid),
-	LSM_HOOK_INIT(current_getsecid_subj, selinux_current_getsecid_subj),
-	LSM_HOOK_INIT(task_getsecid_obj, selinux_task_getsecid_obj),
+	LSM_HOOK_INIT(current_getlsmblob_subj, selinux_current_getlsmblob_subj),
+	LSM_HOOK_INIT(task_getlsmblob_obj, selinux_task_getlsmblob_obj),
 	LSM_HOOK_INIT(task_setnice, selinux_task_setnice),
 	LSM_HOOK_INIT(task_setioprio, selinux_task_setioprio),
 	LSM_HOOK_INIT(task_getioprio, selinux_task_getioprio),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 370ca7fb1843..86a370ec54f9 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2239,30 +2239,35 @@ static int smack_task_getsid(struct task_struct *p)
 }
 
 /**
- * smack_current_getsecid_subj - get the subjective secid of the current task
- * @secid: where to put the result
+ * smack_current_getlsmblob_subj - get the subjective secid of the current task
+ * @blob: where to put the result
  *
  * Sets the secid to contain a u32 version of the task's subjective smack label.
  */
-static void smack_current_getsecid_subj(u32 *secid)
+static void smack_current_getlsmblob_subj(struct lsmblob *blob)
 {
 	struct smack_known *skp = smk_of_current();
 
-	*secid = skp->smk_secid;
+	blob->smack.skp = skp;
+	/* scaffolding */
+	blob->scaffold.secid = skp->smk_secid;
 }
 
 /**
- * smack_task_getsecid_obj - get the objective secid of the task
+ * smack_task_getlsmblob_obj - get the objective data of the task
  * @p: the task
  * @secid: where to put the result
  *
  * Sets the secid to contain a u32 version of the task's objective smack label.
  */
-static void smack_task_getsecid_obj(struct task_struct *p, u32 *secid)
+static void smack_task_getlsmblob_obj(struct task_struct *p,
+				      struct lsmblob *blob)
 {
 	struct smack_known *skp = smk_of_task_struct_obj(p);
 
-	*secid = skp->smk_secid;
+	blob->smack.skp = skp;
+	/* scaffolding */
+	blob->scaffold.secid = skp->smk_secid;
 }
 
 /**
@@ -5148,8 +5153,8 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(task_setpgid, smack_task_setpgid),
 	LSM_HOOK_INIT(task_getpgid, smack_task_getpgid),
 	LSM_HOOK_INIT(task_getsid, smack_task_getsid),
-	LSM_HOOK_INIT(current_getsecid_subj, smack_current_getsecid_subj),
-	LSM_HOOK_INIT(task_getsecid_obj, smack_task_getsecid_obj),
+	LSM_HOOK_INIT(current_getlsmblob_subj, smack_current_getlsmblob_subj),
+	LSM_HOOK_INIT(task_getlsmblob_obj, smack_task_getlsmblob_obj),
 	LSM_HOOK_INIT(task_setnice, smack_task_setnice),
 	LSM_HOOK_INIT(task_setioprio, smack_task_setioprio),
 	LSM_HOOK_INIT(task_getioprio, smack_task_getioprio),
-- 
2.41.0


