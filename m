Return-Path: <linux-integrity+bounces-3512-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9E39742C7
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 20:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447D91F2842E
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 18:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512441A76BD;
	Tue, 10 Sep 2024 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MLBQ3iYF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679031A4B64
	for <linux-integrity@vger.kernel.org>; Tue, 10 Sep 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994406; cv=none; b=PhaFGkdyWKVG5rTEzDnm1amCkJorV7wKHAmJqLENOfhYeMXU2dz356AzwD/LAqgEJy/nDEwUeJzFqUP198Zijl+MdzqsIN7EIiitMojJwXlwf9DYPc06ZSVhSSq0y88YYejNvq6WUWavHYDJpnwp7S13xgREfJaMaGiota4xBtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994406; c=relaxed/simple;
	bh=cLI3aKf+4jLGtNwJ6c6JZmiMRAyr0hjuM2LtPmh5hG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiYxqjpkvdoy2vI3OpVFyvbSrlEJ8VGn+ZNCUcBZJqytRQWlPp99tLu2a0knsMl3du7e45gAEQervxkIHhEBo23fNumBD3/D9HTKK2SOBTzu35msULQC5GVKgd1b5hAcPY7GdAqgKLyuHT7m2mRzXuqUrm7LgrHO4aIIszGgHvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=MLBQ3iYF; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725994401; bh=roEXD5uoszGAHqWo6NbdEc1ATm+VzTvo0S9RDjTnkBM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=MLBQ3iYFegNfPOsMyv5bcH+oRftQRICTFtQA9Bwn8KJDNgeCXixkFhZoGaeF2Mpax4JPMUJFcm6gDwAKM80xz1ozC6EcmTmA5Zv8lFb3pKfujbddda3AgaSwlXghEzwoWQ7z9uhZ/8kL8Qi5n9dv5kKzl5qDLq49GenswgkPcjuLouRat+t+LNF5y1XP3X/uLy4BCzB04/WInVIS/5IGuZP8Hh7aeLmC4kuxf6SzdyqmCYb3dr39wOoZLkcPpPxQwpaRtYHRw353nZLB/4OZWpq+ydbB7t97wn3QbAW2SCMeMmvgGHxt7xScHo2ARwqLZIoHfMaueXBbeGryCsOcBw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725994401; bh=eWtP57zi7lrKnvSi/zHMx9o53i84jt+Jis3dBlCzIs7=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bMKHNCPk3WW6Sud7YWI7I34bIy6fVUtYOUQaENgQN7Xwk8KiVnHfNrdX0yzBlzb0r8TAl2LjlvmOuRdVtDyoLWdJqBAEE3D74odUmPdyQkRVZqr/O7bYeUEFSjrRb1PH9HEP3uVGRXRnmAnfPzDcxhKDvZyzAXnNY+TnH8haeCu1ZqhrpqkqbQs0shnYCFOHC7syygbJ14ftrzDdwa+Z2j8vdcytHghPAGwylLRW7wr1i14kaXVS807aIcH+nuNEJLSf2WeUzpcDTGfT8wLz45Nllw7+8BE7ir5oiitEtM5P+FjKM17G8ZoPZwCVTgj+ocyak6fPIeJQcjRO7CGTqA==
X-YMail-OSG: 8BFFVDMVM1n12u7XppaBGidVuNG4bDRIoBvu8lwN9cpmWwR1.nLMKe5DHYLO247
 YG4AddTC01McK.S4uc3iefTpglrFyeAiqmwlRNWSo4NeYD8_1vEKXjKhRyIRsw8Aa8YshPTPg3d5
 hBpkjWOIrNg4N71WrGycoyCxXih_i574BGlDJ6OJZVz34SZmOnv3Dvjf0_50OghLrE100U6f8HrF
 OPXDcRHDMXm5x6MsthyUuDYOYxv2d5wD_cdCLe9AM5922xnhfJ6A8GiD14s4prnnLtGP90Jnpqhy
 JYDgxXri0Iv5RD91.ct1cdiyPc5VMHtwijdqcef4IhLzwEOb6bapNp2zsqZip5IeaN.KM4AebjGp
 MX.LIa0kUQmsfrzzLlePtljCUTP2gWQIvlRQAwjpA5dX3nBFgVsmR6.z5laaQITGwsJEKd4LEd9E
 BOreEYyF7WGXgz5llZmXTgF6yq9JieA9tXWMmYHvhmJz_jw6DpwZ0OZbv_kLJT3gXS96HyqjbYB9
 bttRn9bJSu5l8YG94hOBn7beYeyjG8.CdbSZN99LIPxg8jz8X8WZyC8YDfhEI2beDx.J1pDpeQ8.
 0klP2QRdo59hJgJTT3dTCtvRd.nllci6v2te_wuW3xt.KB68op5Yifh425DGvaFfkgRsCwMasdJj
 xQGxklvZx1DPjU3hyKB6RZy.nmo9ne96gPyJMNNlEXVgnTkRG3hr7a5oTMkDbGqHSVEmxgyGEE2O
 cnCS4Dbw08BrLq1Wzw12gUw5TFDOC90Uign7qxN29DcagVqvWMwj8jZJN.r5crOflV_sm8oL9l2i
 2.Du3xExRbtGVz5o7PvPMptL.MyIqVj00..04AJoq5Zc6gzjPpvu6LPaToNlOlrDT6mz6kdsDW7N
 hHiHUHNrmDUB1R6XKwk.lxD_ckyP7XNQ4M5aUG2oyTOk0gwwXz2eE61FdwwwvIY9zUsazOpNmhlz
 7OSjWVW2a2Fm.dxOKo4k.st1KK1r3e5UfyyyQDgK79aEXlJBkdcWZN9HJwP3FVuTX3vtK3xP3Ocy
 xjfcPJwFxFy6zdFSbx2hjJOtnEHOOlwesU2tH2BB.yZyY8SNJ0v61wbRlzRLyLlVux7OCXJefpST
 oo5zPWY7KtEF5z1cvTrug4bl__kCrIM3Ca_TkuuCzurRUMIskgfJku7Ce3_XCcYLIpkOzRKaL6rG
 419QN1Wgu0M5.lB6nvkU6Y2Xpy5ZwAatpvHg3EAUPbcU6hDY7lzHL0PPIHZpyNTEgBSYRt7Cq9CC
 GShBW1.iCBy8kavjw.m9sduv8DwP.mBeCUEch0C2tekFeuJNI5bekdSCStMHzZ1TInVXwfeQbxfo
 Mgnq9GxlBDXrCtVJjF2eH4eac4A9qg8D_knaH.usGMZEWxYK6Zie_X3x2byuwXZM8_hQPfwBs9Nh
 u_os2uTPmaMgAS9AwyB1Ww9gwHWwNcUNuCEUWcDeQGeiIWRR.TKG8fRO2VyCuUMvggvkIIdFyWTV
 4bWx.qYveE0QTRD6A3ysk_4oueC2pfRplMB.F9t6rP0NaBbfuoxj5LvrZBh6JRAOOEZ8hUGxzx_s
 _1GaPYRjkB9udEonLK9izFqyjqqDTKD.G7lyTGTao6CK1ZNJ.h9gjaXSAhJisuvkkr4CdUNNAMAE
 _d52ISN0oLPUgRH2sZp4o7kTpbHzggMJIEUgSybAVdh3nDUxIg2ESFdD61HwQ2yw4.r.fKUQPLfN
 6bXmbuup6xSnDL3pmqdkSpCq24zFShrThBGBy.B6ObIqXl8Q4AJ.IY_mS7l5OMHX2qSyQCZQDdRL
 vQQmRPYOSZpqHKhIY5p4BwLyHtCOgKbteOVxqjHe..j5KerKifbpw1DBTxpKqRx7jOWpae5_x5nr
 1yrWCYnqhV.y8ypk8PlS0fwVHEzuRRamMYJbTw3STx7EUSPUh_M8mh7WYwc9e_Qjwozeb95_EXLv
 T.rFws1Ad4kX8n4Q1oXUfivGbHkQUa5zoS9_IK11CRkLOgBHgq5EqKwAqy2l5_py7b8XsykWrj0i
 uUm5CdtdmE6wz3BH5.u40ZRxfyh0Pl7ww_CnGm4K.KnWdZGRoXHAAsrFNGrjkGiTK6H3KjAAad5v
 EpL.HmSFzT41FaxsJY9tsCiu5eDJ3KbNwLQCE0haRFX8iTBoUbua0DvsmQZo2YD2lfPl8KCrHqyU
 aw1YtI95ArN9JqEnKHk5n19am_jAwxpNchiKmShgnXPiKVLWLAeZeL_4VOPsMq7GQMpY4DY0ahfN
 WOh5w1RA5ggY.N5M7KgTtcxHdZ9w3BVhZiiU06npTw3ALA42.EhCGpxKGMGA-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 06cbb0af-efb0-40b5-a83d-9fb6ea77838b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Sep 2024 18:53:21 +0000
Received: by hermes--production-gq1-5d95dc458-4tw7n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bfec55394db9c3ecf7e1196118de0a4c;
          Tue, 10 Sep 2024 18:43:13 +0000 (UTC)
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
Subject: [PATCH v3 07/13] LSM: Use lsm_prop in security_current_getsecid
Date: Tue, 10 Sep 2024 11:41:19 -0700
Message-ID: <20240910184125.224651-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910184125.224651-1-casey@schaufler-ca.com>
References: <20240910184125.224651-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the security_current_getsecid_subj() and
security_task_getsecid_obj() interfaces to fill in a lsm_prop structure
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
index 315bbe1f63fc..e53d29c3ca1c 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -232,9 +232,9 @@ LSM_HOOK(int, 0, task_fix_setgroups, struct cred *new, const struct cred * old)
 LSM_HOOK(int, 0, task_setpgid, struct task_struct *p, pid_t pgid)
 LSM_HOOK(int, 0, task_getpgid, struct task_struct *p)
 LSM_HOOK(int, 0, task_getsid, struct task_struct *p)
-LSM_HOOK(void, LSM_RET_VOID, current_getsecid_subj, u32 *secid)
-LSM_HOOK(void, LSM_RET_VOID, task_getsecid_obj,
-	 struct task_struct *p, u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, current_getlsmprop_subj, struct lsm_prop *prop)
+LSM_HOOK(void, LSM_RET_VOID, task_getlsmprop_obj,
+	 struct task_struct *p, struct lsm_prop *prop)
 LSM_HOOK(int, 0, task_setnice, struct task_struct *p, int nice)
 LSM_HOOK(int, 0, task_setioprio, struct task_struct *p, int ioprio)
 LSM_HOOK(int, 0, task_getioprio, struct task_struct *p)
diff --git a/include/linux/security.h b/include/linux/security.h
index c8f020cf2a84..07c0e635f124 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -492,8 +492,8 @@ int security_task_fix_setgroups(struct cred *new, const struct cred *old);
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
 int security_task_getpgid(struct task_struct *p);
 int security_task_getsid(struct task_struct *p);
-void security_current_getsecid_subj(u32 *secid);
-void security_task_getsecid_obj(struct task_struct *p, u32 *secid);
+void security_current_getlsmprop_subj(struct lsm_prop *prop);
+void security_task_getlsmprop_obj(struct task_struct *p, struct lsm_prop *prop);
 int security_task_setnice(struct task_struct *p, int nice);
 int security_task_setioprio(struct task_struct *p, int ioprio);
 int security_task_getioprio(struct task_struct *p);
@@ -1278,14 +1278,15 @@ static inline int security_task_getsid(struct task_struct *p)
 	return 0;
 }
 
-static inline void security_current_getsecid_subj(u32 *secid)
+static inline void security_current_getlsmprop_subj(struct lsm_prop *prop)
 {
-	*secid = 0;
+	lsmprop_init(prop);
 }
 
-static inline void security_task_getsecid_obj(struct task_struct *p, u32 *secid)
+static inline void security_task_getlsmprop_obj(struct task_struct *p,
+						struct lsm_prop *prop)
 {
-	*secid = 0;
+	lsmprop_init(prop);
 }
 
 static inline int security_task_setnice(struct task_struct *p, int nice)
diff --git a/kernel/audit.c b/kernel/audit.c
index 70f76fed254b..399f66557dfa 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2179,16 +2179,16 @@ void audit_log_key(struct audit_buffer *ab, char *key)
 
 int audit_log_task_context(struct audit_buffer *ab)
 {
+	struct lsm_prop prop;
 	char *ctx = NULL;
 	unsigned len;
 	int error;
-	u32 sid;
 
-	security_current_getsecid_subj(&sid);
-	if (!sid)
+	security_current_getlsmprop_subj(&prop);
+	if (!lsmprop_is_set(&prop))
 		return 0;
 
-	error = security_secid_to_secctx(sid, &ctx, &len);
+	error = security_lsmprop_to_secctx(&prop, &ctx, &len);
 	if (error) {
 		if (error != -EINVAL)
 			goto error_path;
@@ -2405,8 +2405,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		/* scaffolding */
-		security_current_getsecid_subj(&audit_sig_lsm.scaffold.secid);
+		security_current_getlsmprop_subj(&audit_sig_lsm);
 	}
 
 	return audit_signal_info_syscall(t);
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 5b47571ae4ee..7589845cb9ee 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1371,8 +1371,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
 					/* scaffolding */
-					security_current_getsecid_subj(
-							&prop.scaffold.secid);
+					security_current_getlsmprop_subj(&prop);
 					result = security_audit_rule_match(
 						   &prop, f->type, f->op,
 						   f->lsm_rule);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 3e051014484c..b976b88c19c3 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -470,7 +470,6 @@ static int audit_filter_rules(struct task_struct *tsk,
 {
 	const struct cred *cred;
 	int i, need_sid = 1;
-	u32 sid;
 	struct lsm_prop prop = { };
 	unsigned int sessionid;
 
@@ -675,15 +674,14 @@ static int audit_filter_rules(struct task_struct *tsk,
 					 * fork()/copy_process() in which case
 					 * the new @tsk creds are still a dup
 					 * of @current's creds so we can still
-					 * use security_current_getsecid_subj()
+					 * use
+					 * security_current_getlsmprop_subj()
 					 * here even though it always refs
 					 * @current's creds
 					 */
-					security_current_getsecid_subj(&sid);
+					security_current_getlsmprop_subj(&prop);
 					need_sid = 0;
 				}
-				/* scaffolding */
-				prop.scaffold.secid = sid;
 				result = security_audit_rule_match(&prop,
 								   f->type,
 								   f->op,
@@ -2730,12 +2728,15 @@ int __audit_sockaddr(int len, void *a)
 void __audit_ptrace(struct task_struct *t)
 {
 	struct audit_context *context = audit_context();
+	struct lsm_prop prop;
 
 	context->target_pid = task_tgid_nr(t);
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
-	security_task_getsecid_obj(t, &context->target_sid);
+	security_task_getlsmprop_obj(t, &prop);
+	/* scaffolding */
+	context->target_sid = prop.scaffold.secid;
 	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
 }
 
@@ -2751,6 +2752,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
+	struct lsm_prop prop;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2762,7 +2764,9 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getsecid_obj(t, &ctx->target_sid);
+		security_task_getlsmprop_obj(t, &prop);
+		/* scaffolding */
+		ctx->target_sid = prop.scaffold.secid;
 		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
@@ -2783,7 +2787,9 @@ int audit_signal_info_syscall(struct task_struct *t)
 	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
-	security_task_getsecid_obj(t, &axp->target_sid[axp->pid_count]);
+	security_task_getlsmprop_obj(t, &prop);
+	/* scaffolding */
+	axp->target_sid[axp->pid_count] = prop.scaffold.secid;
 	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 9996883bf2b7..5925f48a3ade 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1534,11 +1534,14 @@ int __init netlbl_unlabel_defconf(void)
 	int ret_val;
 	struct netlbl_dom_map *entry;
 	struct netlbl_audit audit_info;
+	struct lsm_prop prop;
 
 	/* Only the kernel is allowed to call this function and the only time
 	 * it is called is at bootup before the audit subsystem is reporting
 	 * messages so don't worry to much about these values. */
-	security_current_getsecid_subj(&audit_info.secid);
+	security_current_getlsmprop_subj(&prop);
+	/* scaffolding */
+	audit_info.secid = prop.scaffold.secid;
 	audit_info.loginuid = GLOBAL_ROOT_UID;
 	audit_info.sessionid = 0;
 
diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
index d6c5b31eb4eb..39f4f6df5f51 100644
--- a/net/netlabel/netlabel_user.h
+++ b/net/netlabel/netlabel_user.h
@@ -32,7 +32,11 @@
  */
 static inline void netlbl_netlink_auditinfo(struct netlbl_audit *audit_info)
 {
-	security_current_getsecid_subj(&audit_info->secid);
+	struct lsm_prop prop;
+
+	security_current_getlsmprop_subj(&prop);
+	/* scaffolding */
+	audit_info->secid = prop.scaffold.secid;
 	audit_info->loginuid = audit_get_loginuid(current);
 	audit_info->sessionid = audit_get_sessionid(current);
 }
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index ad2499bff591..824a85d2ee85 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -982,17 +982,24 @@ static void apparmor_bprm_committed_creds(const struct linux_binprm *bprm)
 	return;
 }
 
-static void apparmor_current_getsecid_subj(u32 *secid)
+static void apparmor_current_getlsmprop_subj(struct lsm_prop *prop)
 {
 	struct aa_label *label = __begin_current_label_crit_section();
-	*secid = label->secid;
+
+	prop->apparmor.label = label;
+	/* scaffolding */
+	prop->scaffold.secid = label->secid;
 	__end_current_label_crit_section(label);
 }
 
-static void apparmor_task_getsecid_obj(struct task_struct *p, u32 *secid)
+static void apparmor_task_getlsmprop_obj(struct task_struct *p,
+					  struct lsm_prop *prop)
 {
 	struct aa_label *label = aa_get_task_label(p);
-	*secid = label->secid;
+
+	prop->apparmor.label = label;
+	/* scaffolding */
+	prop->scaffold.secid = label->secid;
 	aa_put_label(label);
 }
 
@@ -1518,8 +1525,9 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(task_free, apparmor_task_free),
 	LSM_HOOK_INIT(task_alloc, apparmor_task_alloc),
-	LSM_HOOK_INIT(current_getsecid_subj, apparmor_current_getsecid_subj),
-	LSM_HOOK_INIT(task_getsecid_obj, apparmor_task_getsecid_obj),
+	LSM_HOOK_INIT(current_getlsmprop_subj,
+		      apparmor_current_getlsmprop_subj),
+	LSM_HOOK_INIT(task_getlsmprop_obj, apparmor_task_getlsmprop_obj),
 	LSM_HOOK_INIT(task_setrlimit, apparmor_task_setrlimit),
 	LSM_HOOK_INIT(task_kill, apparmor_task_kill),
 	LSM_HOOK_INIT(userns_create, apparmor_userns_create),
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f17213520c36..791f71036893 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -369,7 +369,7 @@ static inline void ima_process_queued_keys(void) {}
 
 /* LIM API function definitions */
 int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
-		   const struct cred *cred, u32 secid, int mask,
+		   const struct cred *cred, struct lsm_prop *prop, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
 		   const char *func_data, unsigned int *allowed_algos);
@@ -400,8 +400,8 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
 /* IMA policy related functions */
 int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
-		     const struct cred *cred, u32 secid, enum ima_hooks func,
-		     int mask, int flags, int *pcr,
+		     const struct cred *cred, struct lsm_prop *prop,
+		     enum ima_hooks func, int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *func_data, unsigned int *allowed_algos);
 void ima_init_policy(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 984e861f6e33..c35ea613c9f8 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -165,7 +165,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * @idmap: idmap of the mount the inode was found from
  * @inode: pointer to the inode associated with the object being validated
  * @cred: pointer to credentials structure to validate
- * @secid: secid of the task being validated
+ * @prop: properties of the task being validated
  * @mask: contains the permission mask (MAY_READ, MAY_WRITE, MAY_EXEC,
  *        MAY_APPEND)
  * @func: caller identifier
@@ -187,7 +187,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *
  */
 int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
-		   const struct cred *cred, u32 secid, int mask,
+		   const struct cred *cred, struct lsm_prop *prop, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
 		   const char *func_data, unsigned int *allowed_algos)
@@ -196,7 +196,7 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 
 	flags &= ima_policy_flag;
 
-	return ima_match_policy(idmap, inode, cred, secid, func, mask,
+	return ima_match_policy(idmap, inode, cred, prop, func, mask,
 				flags, pcr, template_desc, func_data,
 				allowed_algos);
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 656c709b974f..884a3533f7af 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -73,13 +73,13 @@ bool is_ima_appraise_enabled(void)
 int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
 		      int mask, enum ima_hooks func)
 {
-	u32 secid;
+	struct lsm_prop prop;
 
 	if (!ima_appraise)
 		return 0;
 
-	security_current_getsecid_subj(&secid);
-	return ima_match_policy(idmap, inode, current_cred(), secid,
+	security_current_getlsmprop_subj(&prop);
+	return ima_match_policy(idmap, inode, current_cred(), &prop,
 				func, mask, IMA_APPRAISE | IMA_HASH, NULL,
 				NULL, NULL, NULL);
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f04f43af651c..254ab465a4a6 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -206,8 +206,8 @@ static void ima_file_free(struct file *file)
 }
 
 static int process_measurement(struct file *file, const struct cred *cred,
-			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func)
+			       struct lsm_prop *prop, char *buf, loff_t size,
+			       int mask, enum ima_hooks func)
 {
 	struct inode *real_inode, *inode = file_inode(file);
 	struct ima_iint_cache *iint = NULL;
@@ -232,7 +232,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * bitmask based on the appraise/audit/measurement policy.
 	 * Included is the appraise submask.
 	 */
-	action = ima_get_action(file_mnt_idmap(file), inode, cred, secid,
+	action = ima_get_action(file_mnt_idmap(file), inode, cred, prop,
 				mask, func, &pcr, &template_desc, NULL,
 				&allowed_algos);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
@@ -443,23 +443,23 @@ static int process_measurement(struct file *file, const struct cred *cred,
 static int ima_file_mmap(struct file *file, unsigned long reqprot,
 			 unsigned long prot, unsigned long flags)
 {
-	u32 secid;
+	struct lsm_prop prop;
 	int ret;
 
 	if (!file)
 		return 0;
 
-	security_current_getsecid_subj(&secid);
+	security_current_getlsmprop_subj(&prop);
 
 	if (reqprot & PROT_EXEC) {
-		ret = process_measurement(file, current_cred(), secid, NULL,
+		ret = process_measurement(file, current_cred(), &prop, NULL,
 					  0, MAY_EXEC, MMAP_CHECK_REQPROT);
 		if (ret)
 			return ret;
 	}
 
 	if (prot & PROT_EXEC)
-		return process_measurement(file, current_cred(), secid, NULL,
+		return process_measurement(file, current_cred(), &prop, NULL,
 					   0, MAY_EXEC, MMAP_CHECK);
 
 	return 0;
@@ -488,9 +488,9 @@ static int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 	char *pathbuf = NULL;
 	const char *pathname = NULL;
 	struct inode *inode;
+	struct lsm_prop prop;
 	int result = 0;
 	int action;
-	u32 secid;
 	int pcr;
 
 	/* Is mprotect making an mmap'ed file executable? */
@@ -498,13 +498,13 @@ static int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
 		return 0;
 
-	security_current_getsecid_subj(&secid);
+	security_current_getlsmprop_subj(&prop);
 	inode = file_inode(vma->vm_file);
 	action = ima_get_action(file_mnt_idmap(vma->vm_file), inode,
-				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
+				current_cred(), &prop, MAY_EXEC, MMAP_CHECK,
 				&pcr, &template, NULL, NULL);
 	action |= ima_get_action(file_mnt_idmap(vma->vm_file), inode,
-				 current_cred(), secid, MAY_EXEC,
+				 current_cred(), &prop, MAY_EXEC,
 				 MMAP_CHECK_REQPROT, &pcr, &template, NULL,
 				 NULL);
 
@@ -542,15 +542,18 @@ static int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
 	u32 secid;
+	struct lsm_prop prop = { };
 
-	security_current_getsecid_subj(&secid);
-	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
-				  MAY_EXEC, BPRM_CHECK);
+	security_current_getlsmprop_subj(&prop);
+	ret = process_measurement(bprm->file, current_cred(),
+				  &prop, NULL, 0, MAY_EXEC, BPRM_CHECK);
 	if (ret)
 		return ret;
 
 	security_cred_getsecid(bprm->cred, &secid);
-	return process_measurement(bprm->file, bprm->cred, secid, NULL, 0,
+	/* scaffolding */
+	prop.scaffold.secid = secid;
+	return process_measurement(bprm->file, bprm->cred, &prop, NULL, 0,
 				   MAY_EXEC, CREDS_CHECK);
 }
 
@@ -566,10 +569,10 @@ static int ima_bprm_check(struct linux_binprm *bprm)
  */
 static int ima_file_check(struct file *file, int mask)
 {
-	u32 secid;
+	struct lsm_prop prop;
 
-	security_current_getsecid_subj(&secid);
-	return process_measurement(file, current_cred(), secid, NULL, 0,
+	security_current_getlsmprop_subj(&prop);
+	return process_measurement(file, current_cred(), &prop, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -768,7 +771,7 @@ static int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 			 bool contents)
 {
 	enum ima_hooks func;
-	u32 secid;
+	struct lsm_prop prop;
 
 	/*
 	 * Do devices using pre-allocated memory run the risk of the
@@ -788,9 +791,9 @@ static int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 
 	/* Read entire file for all partial reads. */
 	func = read_idmap[read_id] ?: FILE_CHECK;
-	security_current_getsecid_subj(&secid);
-	return process_measurement(file, current_cred(), secid, NULL,
-				   0, MAY_READ, func);
+	security_current_getlsmprop_subj(&prop);
+	return process_measurement(file, current_cred(), &prop, NULL, 0,
+				   MAY_READ, func);
 }
 
 const int read_idmap[READING_MAX_ID] = {
@@ -818,7 +821,7 @@ static int ima_post_read_file(struct file *file, char *buf, loff_t size,
 			      enum kernel_read_file_id read_id)
 {
 	enum ima_hooks func;
-	u32 secid;
+	struct lsm_prop prop;
 
 	/* permit signed certs */
 	if (!file && read_id == READING_X509_CERTIFICATE)
@@ -831,8 +834,8 @@ static int ima_post_read_file(struct file *file, char *buf, loff_t size,
 	}
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
-	security_current_getsecid_subj(&secid);
-	return process_measurement(file, current_cred(), secid, buf, size,
+	security_current_getlsmprop_subj(&prop);
+	return process_measurement(file, current_cred(), &prop, buf, size,
 				   MAY_READ, func);
 }
 
@@ -967,7 +970,7 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 	int digest_hash_len = hash_digest_size[ima_hash_algo];
 	int violation = 0;
 	int action = 0;
-	u32 secid;
+	struct lsm_prop prop;
 
 	if (digest && digest_len < digest_hash_len)
 		return -EINVAL;
@@ -990,9 +993,9 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 	 * buffer measurements.
 	 */
 	if (func) {
-		security_current_getsecid_subj(&secid);
+		security_current_getlsmprop_subj(&prop);
 		action = ima_get_action(idmap, inode, current_cred(),
-					secid, 0, func, &pcr, &template,
+					&prop, 0, func, &pcr, &template,
 					func_data, NULL);
 		if (!(action & IMA_MEASURE) && !digest)
 			return -ENOENT;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 22a62e675ebc..a96dc3ff6aa0 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -557,7 +557,7 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
  * @idmap: idmap of the mount the inode was found from
  * @inode: a pointer to an inode
  * @cred: a pointer to a credentials structure for user validation
- * @secid: the secid of the task to be validated
+ * @prop: LSM properties of the task to be validated
  * @func: LIM hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @func_data: func specific data, may be NULL
@@ -567,7 +567,7 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
 static bool ima_match_rules(struct ima_rule_entry *rule,
 			    struct mnt_idmap *idmap,
 			    struct inode *inode, const struct cred *cred,
-			    u32 secid, enum ima_hooks func, int mask,
+			    struct lsm_prop *prop, enum ima_hooks func, int mask,
 			    const char *func_data)
 {
 	int i;
@@ -658,8 +658,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			/* scaffolding */
-			prop.scaffold.secid = secid;
 			rc = ima_filter_rule_match(&prop, lsm_rule->lsm[i].type,
 						   Audit_equal,
 						   lsm_rule->lsm[i].rule);
@@ -723,7 +721,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @inode: pointer to an inode for which the policy decision is being made
  * @cred: pointer to a credentials structure for which the policy decision is
  *        being made
- * @secid: LSM secid of the task to be validated
+ * @prop: LSM properties of the task to be validated
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @flags: IMA actions to consider (e.g. IMA_MEASURE | IMA_APPRAISE)
@@ -740,8 +738,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * than writes so ima_match_policy() is classical RCU candidate.
  */
 int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
-		     const struct cred *cred, u32 secid, enum ima_hooks func,
-		     int mask, int flags, int *pcr,
+		     const struct cred *cred, struct lsm_prop *prop,
+		     enum ima_hooks func, int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *func_data, unsigned int *allowed_algos)
 {
@@ -759,7 +757,7 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, idmap, inode, cred, secid,
+		if (!ima_match_rules(entry, idmap, inode, cred, prop,
 				     func, mask, func_data))
 			continue;
 
diff --git a/security/security.c b/security/security.c
index 410bf69af427..1e603e055c9f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3373,33 +3373,33 @@ int security_task_getsid(struct task_struct *p)
 }
 
 /**
- * security_current_getsecid_subj() - Get the current task's subjective secid
- * @secid: secid value
+ * security_current_getlsmprop_subj() - Current task's subjective LSM data
+ * @prop: lsm specific information
  *
  * Retrieve the subjective security identifier of the current task and return
- * it in @secid.  In case of failure, @secid will be set to zero.
+ * it in @prop.
  */
-void security_current_getsecid_subj(u32 *secid)
+void security_current_getlsmprop_subj(struct lsm_prop *prop)
 {
-	*secid = 0;
-	call_void_hook(current_getsecid_subj, secid);
+	lsmprop_init(prop);
+	call_void_hook(current_getlsmprop_subj, prop);
 }
-EXPORT_SYMBOL(security_current_getsecid_subj);
+EXPORT_SYMBOL(security_current_getlsmprop_subj);
 
 /**
- * security_task_getsecid_obj() - Get a task's objective secid
+ * security_task_getlsmprop_obj() - Get a task's objective LSM data
  * @p: target task
- * @secid: secid value
+ * @prop: lsm specific information
  *
  * Retrieve the objective security identifier of the task_struct in @p and
- * return it in @secid. In case of failure, @secid will be set to zero.
+ * return it in @prop.
  */
-void security_task_getsecid_obj(struct task_struct *p, u32 *secid)
+void security_task_getlsmprop_obj(struct task_struct *p, struct lsm_prop *prop)
 {
-	*secid = 0;
-	call_void_hook(task_getsecid_obj, p, secid);
+	lsmprop_init(prop);
+	call_void_hook(task_getlsmprop_obj, p, prop);
 }
-EXPORT_SYMBOL(security_task_getsecid_obj);
+EXPORT_SYMBOL(security_task_getlsmprop_obj);
 
 /**
  * security_task_setnice() - Check if setting a task's nice value is allowed
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 10c7fc61a786..ebab856c8748 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4161,14 +4161,19 @@ static int selinux_task_getsid(struct task_struct *p)
 			    PROCESS__GETSESSION, NULL);
 }
 
-static void selinux_current_getsecid_subj(u32 *secid)
+static void selinux_current_getlsmprop_subj(struct lsm_prop *prop)
 {
-	*secid = current_sid();
+	prop->selinux.secid = current_sid();
+	/* scaffolding */
+	prop->scaffold.secid = prop->selinux.secid;
 }
 
-static void selinux_task_getsecid_obj(struct task_struct *p, u32 *secid)
+static void selinux_task_getlsmprop_obj(struct task_struct *p,
+					struct lsm_prop *prop)
 {
-	*secid = task_sid_obj(p);
+	prop->selinux.secid = task_sid_obj(p);
+	/* scaffolding */
+	prop->scaffold.secid = prop->selinux.secid;
 }
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
@@ -7240,8 +7245,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
 	LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
 	LSM_HOOK_INIT(task_getsid, selinux_task_getsid),
-	LSM_HOOK_INIT(current_getsecid_subj, selinux_current_getsecid_subj),
-	LSM_HOOK_INIT(task_getsecid_obj, selinux_task_getsecid_obj),
+	LSM_HOOK_INIT(current_getlsmprop_subj, selinux_current_getlsmprop_subj),
+	LSM_HOOK_INIT(task_getlsmprop_obj, selinux_task_getlsmprop_obj),
 	LSM_HOOK_INIT(task_setnice, selinux_task_setnice),
 	LSM_HOOK_INIT(task_setioprio, selinux_task_setioprio),
 	LSM_HOOK_INIT(task_getioprio, selinux_task_getioprio),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 7926f40bc7db..03d0ac37b210 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2239,30 +2239,35 @@ static int smack_task_getsid(struct task_struct *p)
 }
 
 /**
- * smack_current_getsecid_subj - get the subjective secid of the current task
- * @secid: where to put the result
+ * smack_current_getlsmprop_subj - get the subjective secid of the current task
+ * @prop: where to put the result
  *
  * Sets the secid to contain a u32 version of the task's subjective smack label.
  */
-static void smack_current_getsecid_subj(u32 *secid)
+static void smack_current_getlsmprop_subj(struct lsm_prop *prop)
 {
 	struct smack_known *skp = smk_of_current();
 
-	*secid = skp->smk_secid;
+	prop->smack.skp = skp;
+	/* scaffolding */
+	prop->scaffold.secid = skp->smk_secid;
 }
 
 /**
- * smack_task_getsecid_obj - get the objective secid of the task
+ * smack_task_getlsmprop_obj - get the objective data of the task
  * @p: the task
- * @secid: where to put the result
+ * @prop: where to put the result
  *
  * Sets the secid to contain a u32 version of the task's objective smack label.
  */
-static void smack_task_getsecid_obj(struct task_struct *p, u32 *secid)
+static void smack_task_getlsmprop_obj(struct task_struct *p,
+				      struct lsm_prop *prop)
 {
 	struct smack_known *skp = smk_of_task_struct_obj(p);
 
-	*secid = skp->smk_secid;
+	prop->smack.skp = skp;
+	/* scaffolding */
+	prop->scaffold.secid = skp->smk_secid;
 }
 
 /**
@@ -5147,8 +5152,8 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(task_setpgid, smack_task_setpgid),
 	LSM_HOOK_INIT(task_getpgid, smack_task_getpgid),
 	LSM_HOOK_INIT(task_getsid, smack_task_getsid),
-	LSM_HOOK_INIT(current_getsecid_subj, smack_current_getsecid_subj),
-	LSM_HOOK_INIT(task_getsecid_obj, smack_task_getsecid_obj),
+	LSM_HOOK_INIT(current_getlsmprop_subj, smack_current_getlsmprop_subj),
+	LSM_HOOK_INIT(task_getlsmprop_obj, smack_task_getlsmprop_obj),
 	LSM_HOOK_INIT(task_setnice, smack_task_setnice),
 	LSM_HOOK_INIT(task_setioprio, smack_task_setioprio),
 	LSM_HOOK_INIT(task_getioprio, smack_task_getioprio),
-- 
2.46.0


