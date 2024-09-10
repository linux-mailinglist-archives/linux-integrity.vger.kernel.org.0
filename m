Return-Path: <linux-integrity+bounces-3511-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD30D97427C
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 20:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A4D1F275F6
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 18:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10D81A7AE3;
	Tue, 10 Sep 2024 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tDEDDjrz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7537F1A76AB
	for <linux-integrity@vger.kernel.org>; Tue, 10 Sep 2024 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993898; cv=none; b=D44dnEcksS/cdxKnHenkjF+w0DgYuyTCYAc8XfpQ7WyZVhnsK+5n48FXq2V1xNMDVpntc0svp2Yd3nr33r8WyVNRATrmsATvuubvsyMS5FP/PU/tujBL+5P+whOjdmRreYMDajQfGUiRPjWHQXphfD06TdeYJV/cUE5Lqa9R6qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993898; c=relaxed/simple;
	bh=JBK1O7fXK6QgQ/VoAl2pmxxHL+v5oNMWDFuZVFUUO44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnDZGdW+Ned56WEdGWShIx8jy3V9pznQdqY6EhhRTnC8V80j9+pzwY6sc/gAPu4QvyC0MbUt9lw+HtXeLD31UQ3UdPD8+JOIGaEZHvCg1HmP1Sny5oFsv796ZLxKh+p+uGbonf3fpY+ndLgpi7doygOUnS8vGhsaLxGx+v104JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=tDEDDjrz; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725993895; bh=vy7GpGeQRSJudL4lBO0JXn1r1cbYVq1uqkvmngtU074=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=tDEDDjrzaAtVae8I0cDm2WOaCFdiIXDzY9QtveTX2uBtgXC53v3hhtK2FHMqlUH/BZrjDqmdL6BS7fTx2qVIRyqN48X62hFWtf4PY80vrYUgdTHJ9vDw73GW7BPZiDt7b4WeXcha/HJXHt6q02XXvxXBM6QbmvX0ELr4kTOiTbfrD0CotjPDnMkBjE1kpe7D4eDAEEDmDSmV9rIfG7yRvZF5Q2VvCPI2C/clTPfwfAkzolUUXWc/SKLOTYeOs4YAx0DuE5CUInX/4Se7IDYABrZp6BJnjpD4pJlVJuMrP3HibWeQCgvtzIqWY8RCqZiyGWCqNMI2AuxEyfdL99iPpg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725993895; bh=JKtPrtR1XRhAJr8PvnPXMY0cEAVMwyqQ4u2FSD1pVms=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SWt+cV4LieYrJXmG0aESHk2YKm8BJOne0CoMjTrtjH1nZgmkaJPSxKYcE43ndFiH5mbYMFZtvsZaP7UyPpQqAXhujIId/+ovNWNejkhsXDPvzvtAKvvlHwjRRyZ0PRGwHnwr0e7qcNwAN4fSmbhQ21qCHJ49nvsLE7Bm6tClaX2XYShAmfm+QAl+GEV+S1CbZczoyQprDKNH8lpreFov2tZqW9nvCBVpkUGcFCMI6uLQwCR2Q7OAE7WjQ9IFrLkuUvLpTtsht3rHJt7ulRbmh1tbrS/93w/6uQBtLOTECu0A1tT19yLqgxFY6sPgsjv0OBfGy1W7aDj/M2VzJNcSXw==
X-YMail-OSG: VaM3YXQVM1kY4DlBhIKQOh0niUSKSy22PJ9eUHTc9OCl0lNw3xjABJd8bdIePRT
 W3RBCMOQwFP1ryodHtdplyUhZy5EKCBDN2Gwdk1b67pERq6OfwhOliL4tBggjvMDzzBNR38QjdFd
 82RFvEUMe9ezoWrVeH2VfK4Gs_SVuEGe_jCusLG2wChSFpTLXtyzOPRI4nb.w7XtSWDniFxmtQYZ
 qV.CbM8_VLrsv38Q8PwM89pfF0pgYmwHJRbc4CEdzlg2iKsCym2cW__00LNLJhJJCcbB5XQ1o9iA
 cuug.xz2xxNRpy_dnj5dkvV9DDyZCBFez5xq915I2aFI4nfjIrxMi.0OOnWCDG_kML9cwvXgcBs.
 Rb8gVCaqAt7KL1besrQkZ3kChm9rvoFJl9peJqE2UYYvSLOvZaYRVvCbRcVPliggTlCuqnLqLUCQ
 OOuStl850FjYeb_4FAQOkjuHubkg.JTXjJmiKypJhuVqQE.ROh36VNbW5WIuTI7sjosGKAVyuxfD
 btfFPggU16vYjmgPXGIYh1WCZO4o9OBwGGoZoZe6E8vrs.NflNlrVgcTqXsUyJKmmAnP6MtpIAax
 MqeGgmJK81qtGGLXeGUToDLnH8cWUsMOR8he27c1BEI_4gza43FOKNM.bZODqk1Ww5GYxMWJdfM0
 IFdYMMKYmX9PaeLwhf1TOQlhB6797bosWvQJokXcCceLwSfn167RnyFcdhpNw_eVVGMYikKFAAoc
 hH8yppcF5yxEpTOomirJ1ho2tfDPAj9IyD_LTRKln_utXOaaXcWhivOJ3dM0DTMj77soxEp.gvlS
 wa0ui7gGyu7SVjvhw3IbmH2eSIAQ_qc0ITnvZCvyDIR3UaAAw00bCuihgSAK8bFA8JsUXW7vObLM
 yh7BADJdtjMWHAmNFbncWj1LSOJFJ0.bcKFgEnQoxnIYjKb5Wt73GivVKX2rBfFBUBlJZmTCqus3
 HfRjkQq6PE5r6PjiJlhDub04f7RK9lZlTltG.IxXvFMFwpgfabmUyGN0e8laJY3ld8j1BxRNb0eo
 0NabZY0JdJS_ywmcE_qcZbmgDRVCk3E_tQSfhtBJUcCPt3K7l8Ms7tLaZR6zKSK_sQfWjkxcnAeU
 XAt.Uyu9Bno.lGda2TIJZ7DfF8xYGDkRoDSPrtcNaJb4.ZG.5wXtkKd8uvjHaI2gZUffFmcr0cWd
 FjPHDszApEFv1NPQVh.0IuqcjMcJMdzNbXm2MSIyUqVWNo7MBTYShW15JKl63S_x8vBQG1ANXzZ2
 N4IYawDysmun6kYY4quc3tMjIlxoLY675IZhlYqGKO0bRmmMsTqilWqBKWiaSAXG2HH57r.xFK13
 gEe4AAcYsVts8xv5l_Oh1NQTz6hG54ZhHFUyepdcx_wXy0sm7MdLaJSeCGmq9BE88pFDGP1BwL20
 f24KjwsET7Ad3F63qtFzBBrE87HYOYN3iaZ8YeNOpxbDPic.EJIjea6zy7urHUFvtTFH6MqarMKa
 ldjokJ.oW0EaNn9.M7hwPXj71szdMNz4nhXAUBDmVNsjJ57CtgKGYtZMpp6BT6upGfpdnqsqVqOq
 9CMm7L2cb6Kxw5TXGTdo9gF6figbjL1L2tE9tHMGxMzo1zDnCp.J_UGbgZ0AXHhXzSeJhKu85Ho3
 cE9LpOK6UuaKYVxl_8lht1bfxlRHUrVFr7_2AnpYwmjO_skhrIRGGAsEKS1BTc.g3V.k8MjeBEZE
 yMQ.FTkshmzp07F4DXqeVxmJU3g8eek2F2mPdqxuOvJPZJHAO8XI6cpOAeLO37ZZ89bUj3PlQIMe
 hRWUJq3VKbctDdt0DU1F7u2Umo6lsdNPOPkgsp9mU8pu6UB0XoF0CjgfU.eb81gLSuPsLHRzweM.
 AUa7QSbef8lAThbdU3QOQzY.dEgoOLN_byezO.uaLynj56So96qxBevQ01Dq6lJnWGPgc.3Awpf8
 iNfPbizRDwoQqjooZSNEPR3Z52Oj4uiPZ5jlg8S3trryvnkF3j4TTYJaEEwgxr2JbPdDVhzMaman
 3RMCWQveRe0zE75UfmZOPRAhFUzcow4fa0WksptBvPm1z0cwiKDmqdpv9nHUFZzh4TrKyZQBCVuf
 xfu7m49nRY1g1pf6avZgFjaVWShroG_pVrqQAzcu6kh23ZwX5pC6qYHrr1jl0eLBDqKG_7zEadvY
 XgRLaZhUV1_Bp0JidDrIoCHDzFSkY0MMRKAfSJYO3AG_58OMJKHyL_vsODqnXV1ovQw.CFgh5Eiu
 qmHmFaehmXCIHnmpY.8ATQxPcX8RKAF_FvFUG2Wo77pOWpFTLbnh1jhCkDg3r.1wvutO.Xwoy6ds
 YR1tlM7ve3nhNiq76v0Hx5zaRfXUfKuCaH4v4UIgi8J8b2Q--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 26045f67-62b7-4c91-9a7e-f99aa3966052
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Sep 2024 18:44:55 +0000
Received: by hermes--production-gq1-5d95dc458-s958r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 52d00b93a233ef9d46e84b01a7384b7d;
          Tue, 10 Sep 2024 18:44:50 +0000 (UTC)
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
Subject: [PATCH v3 10/13] LSM: Create new security_cred_getlsmprop LSM hook
Date: Tue, 10 Sep 2024 11:41:22 -0700
Message-ID: <20240910184125.224651-11-casey@schaufler-ca.com>
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

Create a new LSM hook security_cred_getlsmprop() which, like
security_cred_getsecid(), fetches LSM specific attributes from the
cred structure.  The associated data elements in the audit sub-system
are changed from a secid to a lsm_prop to accommodate multiple possible
LSM audit users.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
Cc: audit@vger.kernel.org
Cc: selinux@vger.kernel.org
---
 include/linux/lsm_hook_defs.h     |  2 ++
 include/linux/security.h          |  5 +++++
 security/integrity/ima/ima_main.c |  7 ++-----
 security/security.c               | 15 +++++++++++++++
 security/selinux/hooks.c          |  8 ++++++++
 security/smack/smack_lsm.c        | 18 ++++++++++++++++++
 6 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 75131153f89e..75b3f5c7cb6d 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -215,6 +215,8 @@ LSM_HOOK(int, 0, cred_prepare, struct cred *new, const struct cred *old,
 LSM_HOOK(void, LSM_RET_VOID, cred_transfer, struct cred *new,
 	 const struct cred *old)
 LSM_HOOK(void, LSM_RET_VOID, cred_getsecid, const struct cred *c, u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, cred_getlsmprop, const struct cred *c,
+	 struct lsm_prop *prop)
 LSM_HOOK(int, 0, kernel_act_as, struct cred *new, u32 secid)
 LSM_HOOK(int, 0, kernel_create_files_as, struct cred *new, struct inode *inode)
 LSM_HOOK(int, 0, kernel_module_request, char *kmod_name)
diff --git a/include/linux/security.h b/include/linux/security.h
index 6c50dfd70e81..ed13cf5bbe1f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -473,6 +473,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
+void security_cred_getlsmprop(const struct cred *c, struct lsm_prop *prop);
 int security_kernel_act_as(struct cred *new, u32 secid);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
@@ -1202,6 +1203,10 @@ static inline void security_cred_getsecid(const struct cred *c, u32 *secid)
 	*secid = 0;
 }
 
+static inline void security_cred_getlsmprop(const struct cred *c,
+					    struct lsm_prop *prop)
+{ }
+
 static inline int security_kernel_act_as(struct cred *cred, u32 secid)
 {
 	return 0;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 254ab465a4a6..09ed06598805 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -541,8 +541,7 @@ static int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 static int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
-	u32 secid;
-	struct lsm_prop prop = { };
+	struct lsm_prop prop;
 
 	security_current_getlsmprop_subj(&prop);
 	ret = process_measurement(bprm->file, current_cred(),
@@ -550,9 +549,7 @@ static int ima_bprm_check(struct linux_binprm *bprm)
 	if (ret)
 		return ret;
 
-	security_cred_getsecid(bprm->cred, &secid);
-	/* scaffolding */
-	prop.scaffold.secid = secid;
+	security_cred_getlsmprop(bprm->cred, &prop);
 	return process_measurement(bprm->file, bprm->cred, &prop, NULL, 0,
 				   MAY_EXEC, CREDS_CHECK);
 }
diff --git a/security/security.c b/security/security.c
index 2365626a3365..137ceea105a6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3153,6 +3153,21 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
+/**
+ * security_cred_getlsmprop() - Get the LSM data from a set of credentials
+ * @c: credentials
+ * @prop: destination for the LSM data
+ *
+ * Retrieve the security data of the cred structure @c.  In case of
+ * failure, @prop will be cleared.
+ */
+void security_cred_getlsmprop(const struct cred *c, struct lsm_prop *prop)
+{
+	lsmprop_init(prop);
+	call_void_hook(cred_getlsmprop, c, prop);
+}
+EXPORT_SYMBOL(security_cred_getlsmprop);
+
 /**
  * security_kernel_act_as() - Set the kernel credentials to act as secid
  * @new: credentials
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1db4ecfea764..a523f38faca0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4029,6 +4029,13 @@ static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
 	*secid = cred_sid(c);
 }
 
+static void selinux_cred_getlsmprop(const struct cred *c, struct lsm_prop *prop)
+{
+	prop->selinux.secid = cred_sid(c);
+	/* scaffolding */
+	prop->scaffold.secid = prop->selinux.secid;
+}
+
 /*
  * set the security data for a kernel service
  * - all the creation contexts are set to unlabelled
@@ -7240,6 +7247,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(cred_prepare, selinux_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, selinux_cred_transfer),
 	LSM_HOOK_INIT(cred_getsecid, selinux_cred_getsecid),
+	LSM_HOOK_INIT(cred_getlsmprop, selinux_cred_getlsmprop),
 	LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
 	LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
 	LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 8c362fe2871c..4d236a5ea5c6 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2150,6 +2150,23 @@ static void smack_cred_getsecid(const struct cred *cred, u32 *secid)
 	rcu_read_unlock();
 }
 
+/**
+ * smack_cred_getlsmprop - get the Smack label for a creds structure
+ * @cred: the object creds
+ * @prop: where to put the data
+ *
+ * Sets the Smack part of the ref
+ */
+static void smack_cred_getlsmprop(const struct cred *cred,
+				  struct lsm_prop *prop)
+{
+	rcu_read_lock();
+	prop->smack.skp = smk_of_task(smack_cred(cred));
+	/* scaffolding */
+	prop->scaffold.secid = prop->smack.skp->smk_secid;
+	rcu_read_unlock();
+}
+
 /**
  * smack_kernel_act_as - Set the subjective context in a set of credentials
  * @new: points to the set of credentials to be modified.
@@ -5149,6 +5166,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(cred_prepare, smack_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, smack_cred_transfer),
 	LSM_HOOK_INIT(cred_getsecid, smack_cred_getsecid),
+	LSM_HOOK_INIT(cred_getlsmprop, smack_cred_getlsmprop),
 	LSM_HOOK_INIT(kernel_act_as, smack_kernel_act_as),
 	LSM_HOOK_INIT(kernel_create_files_as, smack_kernel_create_files_as),
 	LSM_HOOK_INIT(task_setpgid, smack_task_setpgid),
-- 
2.46.0


