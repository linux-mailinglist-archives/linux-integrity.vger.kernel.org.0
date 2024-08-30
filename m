Return-Path: <linux-integrity+bounces-3433-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE949965416
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2024 02:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35BF1C22AE0
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2024 00:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1178E3224;
	Fri, 30 Aug 2024 00:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fjINa+IM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC263FF1
	for <linux-integrity@vger.kernel.org>; Fri, 30 Aug 2024 00:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978257; cv=none; b=RMGQUIeLkNnq7ONmkHMKLcRnPSL5uXcz6sEsE7T1wsFnKReGOcEsccc/erkXnpEvPoQhIpp2mwZ2PA/czowxlxoO3azq6bk1yu68A0Gs6Wihz+KkxagUkqaRvidnZmmtSEwg77o46ZTlBTc65VuMxXxZgCxnc1mLykkJa19dqdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978257; c=relaxed/simple;
	bh=g0IbyVcXzElD46BdZgUbwao4FNE+T2asoW1w/oO2hMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kW10cGA6FNdF7ZnkHt3TfBhTx+RTaa+F9JOMUS3e91h15O4zmW74lmHlHyDaJeuqRWH4LHVWUjWE3hlvuTDKnUmt1WjXda/hbPDx3L1UbUMwlpGyfpPWTUcccvcAOp/YnJpYyHQwGopnpi2llNuKD23t0u4GqAvbExJvr+UmDvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fjINa+IM; arc=none smtp.client-ip=66.163.187.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978253; bh=NaArIe63sY9q+u/KXmksG/ULfNEUdomxSXmKu+yH4Z4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=fjINa+IMKfV/KSBPoi8FxwQ3Tpbw/hTjSLkx9VsXhL2RgQlwqQzlugZtH7TqDQXma1ugjCXtAZ1ta+tgsG/JXsAGM7MEOCQEzkyC+CrSBKzFn/ZXeLD71+sEeCFFB50W3cDL+nsUeNdbK7Ig9adh3TrhonsgvsEbr1xudHpwQemgKYjubJ8ACA9lNCtvPfoC/uv8lv+v2lntOoU37aAaOtZpLkPRGaJq2Tj6skO/oWY1urhMRxghBCNHA0zMQfKt5R91IGKjS867JkcJ7cwsmk0VTLc71SqvHk8RCoSh8C35yM8W61crRRazphZW00LjaXzU5OVl6SbeVfKMqkHegw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978253; bh=gI2eqUBpoLQ83XiDtZlVQd0tsaggeW2Ev8z4VGvS1fR=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=l5YydsWndkQY9OqojBM6m9tKYwuPKiwkXgLVT2vRwGk8KxHma7yLyebqi3cTwtYoDipP5CYtUaZVHkekWYn1EzRwZGlkm8+JorfN7Q9FG4gIwGYg8WVVmPoKWKiOeY/XNsCrm74BpVopTCOOoJkDNEOCbletpwZ82ukd2J4dNOHS6cwfxBHBJnsZWTXrcfJg3gskKT4kmLjsiZ0SZpmpiJSzxJLSYIdi47OHRLsEg8schHDb1YXtWODZNWpYfwG5Tlynm+QlJ6uMaevloLqu3UzJVFCfAP3v68w2+userRs7QApOK2+pGS/+pUfKIhx2tL9vItMt3YJex2oB3/6rEQ==
X-YMail-OSG: 1wEW6rUVM1nbikoZohQppaOpKqy_NKPc5WaLPUDL6BKOi_moqho4uQfsfwxfM9A
 WK3Cz4U56tCvXOsPDCGtJT._CkHFDiRcCJBNiWKghSF6Pb9SWE_ISWlMS8HBsf8MhtfCPzFFOVDO
 2jse_D2pAtT6HGIS.GzhEpwYfJjt84ha7t80VOSr.4I8sJpzlKmKVWpdX3CO45TKanDC7eK.XH4k
 4ZCCwaaKbEJf9LHwN146BWV6MHfGzoXKsDlV.iiYZCjCpO09HcyGzJeExA_ZI.XcuoGBmd4kbIxE
 xNfmLyz0DCLcoQDu.rtdNOBc5_YOhPsjBlHZCQbTTnr57c3jx6gUshClf9JYY6CxUmb5wcWuts7z
 IWvhl8SZ02q_pe8cgaeM3Oj4h4YIRA0okwoX23c85A6eu95bE1T_D1MeldK_iz_R.L9BkPWrU8oc
 C6bBKFCniFxd5pLgTy4GMMsqqEgfVxtq.IgIoyJxGVAIWebxG_.iJ4SQtu94tbrdiRDez1jtFW8n
 7pJCqEwUdVtGk46OdBl53N4x26f03IyIPaopeiM_x4u9rXMsWYCViG9Vz4TM3KV5NuXTHN6MGl.u
 fsAH2hEiyExg26h2ibccEMo1Kjj6AzA_tHRPcr_MekqUxbLjkTYe2yujJ.ObjLnSTrspxcV5lwoB
 1PQQiJN8HYU7f_1zRTR9DZZha4UK9NLEVYh9XVTCj_OBQfjJWmdMFMyaKLl7bAQmxG9Byh8KQNo4
 VcRLjZJN5e8faeNhSqnBACQ3T2q_k.A81wrOVNyT6KDuyoqpQZuDCKzrSIv1vhhL0IfwiyPSN2ou
 Gg0.ge5STjvgHL91XyUYxlnr6J7M.NYhrZ47iwYOZxAUMUV4u3HKorEEV0tA99xSqbpFyBhgdxyu
 AhNsnFwLjPWIzoA8CBhBRan7ofL75QqkVI2cQJftOmGmbDPHj2VnWgxBIy3u61ckcME8aQOVhCdE
 mXtQiaFWsWoBMMH0cVLijvIiegH09hf0xBBKdkIvZWimTo0mmFa4lZC0yLCH6lRVpkSh2xyflEyU
 JHlLhxIFHFIOtsaxES.jRFKIytWUyz_0EXDUoJzPKVGm0QpB8zaigwxuvd3zviSM4CDDsYTBaKww
 ltjIxEx2ImVoXoP6hcpjcDNEKhg.DqQ2IWNZ0FvsgfZQ7WRoe5nwrGzzPgBLffHrGJvXC.gj_YJY
 ST2CHNYDXVCpo3.eD1cmAM0AenDcPKf76K6rbFqJuqznLX8G1L.vhGwaSjnCUKcA7DmI5xVSi63V
 vppXBdTuJSGuqjRwJ0VlECShw4i9RlNXohpXppFE2DzG05HMaSdzn8WSbWZBG1SfUydk0tQlOKhp
 bUV0ZuujoDxo0Oh.saghh1DEYX4NOPBW2S_0SzRzAh0uvJ831XPxHHs8bVjZ2S88cycyTZi3wkX6
 VZ04Th4_wiNmIHPtpMAn.0OI1JG7AV0WEcYAWox4.SwKXN6Ycc69B8mcR6HKMs0B_MIvVQYoByiL
 2eElNHyGhuBZ0wt6dTvaymC.M7_w0W6pd7xpXQTpaqjOFkV7xRTSgcRMUg41bxdzpSj7w0os.FHZ
 xtSGR6d_P26GBGuIzlDyCxFb9kjDjT98opnvnEFFy130poj8HkoI4JgrDKF3dowMC0U_7QIM3EFO
 wPQ5B8GJrRRTyA.rFy7lkYxzaxCOYd7dEgxUFV0rtr3wXv3iPCSZgg56siImVFE_pkL5C4oNi2wm
 JP4RwnC2e7VcX5bJ6GfHlpsXu.N_mgkr7Ny.tWpW_d9tQM58aWMYegSalII2m03e43vJ52ZiV5Ay
 LMxCKsi8khYVSw5._4xqULEs.PNb9Gigr6iB4BtYifDt.tt6dR8JDel0MfE21riPnh1GxcqB_KW6
 DbrGaFjA44xDL2OGO5l2BFtcx9S18GLSMLm4XmlG24mKx3vC3TXmRm6JME4hLX.r4kdacGL09XNJ
 mRUjWH53N4iUpvSiMTZp9dG00ZSLAWaaFUq3Zd.P1bBEwk32hMFm.cJ1OTWRUaRdOR3VCRoI8muG
 nGpJ.rKJgeJ78F8OtrRcM5Man7ztFypnnYhgAgn49CFEelZb3Dvq2LJC7YCO2NvZh1odgz8cCN5y
 IbfE5w_uDcLFJMCWzw58.dZBSzHwG3qTaYNQo2MrDVD8ehp0KfRI_eT_4kxX8wK7I5SwGQj8TkiO
 .gETpBhuXxvzqrfr2lOfq9UPgDw9414wJN8KQ7oXuJ9PSpxSY3cjEQpgxoF5r9EpwJZDoqm0N3nS
 L8kzuLBrbsCS1MeE3l5_jjV_RZskMuBeUlMZEa7sHBsL.c.FJBjU9jH3q9T.4jZrJ_5DSjL279oy
 rr9jG82T3phdcQ3AX6siNGYTfsBxuGAm2fRw-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b54358f2-c6e7-4040-a8ca-a6b1a30e7f7f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Aug 2024 00:37:33 +0000
Received: by hermes--production-gq1-5d95dc458-jflr5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f4d7fb0b22ad2b46e66df0183031cfdb;
          Fri, 30 Aug 2024 00:37:29 +0000 (UTC)
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
	selinux@vger.kernel.org,
	mic@digikod.net,
	linux-integrity@vger.kernel.org,
	audit@vger.kernel.org
Subject: [PATCH v2 07/13] LSM: Use lsmblob in security_current_getsecid
Date: Thu, 29 Aug 2024 17:34:05 -0700
Message-ID: <20240830003411.16818-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830003411.16818-1-casey@schaufler-ca.com>
References: <20240830003411.16818-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the security_current_getsecid_subj() and
security_task_getsecid_obj() interfaces to fill in a lsmblob structure
instead of a u32 secid.  Audit interfaces will need to collect all
possible security data for possible reporting.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
Cc: audit@vger.kernel.org
Cc: selinux@vger.kernel.org
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
 security/smack/smack_lsm.c            | 25 +++++++-----
 16 files changed, 139 insertions(+), 108 deletions(-)

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
index 370ca7fb1843..fcacc59faf33 100644
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
- * @secid: where to put the result
+ * @blob: where to put the result
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
2.46.0


