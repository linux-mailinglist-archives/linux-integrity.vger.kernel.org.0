Return-Path: <linux-integrity+bounces-3379-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A97E95E4D5
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Aug 2024 21:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4D41F2239B
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Aug 2024 19:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C271155730;
	Sun, 25 Aug 2024 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QvB9dgVR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B0E383BF
	for <linux-integrity@vger.kernel.org>; Sun, 25 Aug 2024 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724612754; cv=none; b=rYwAqylG3LXzJUcVP3EGGcpDqJJa6OMFu8Acle6YaOmz1dbV4qiEdZHqBmchHQE9mh38YCcVWoWd+WQkp5CeAQvOcaPM36hzbNFIr+TvBQhvUi7e2qZ6DDayhzFviJ50PMZGjAoaHoy6O80Zz6Vlq21RQL2nYk0XrXkXk7znUpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724612754; c=relaxed/simple;
	bh=oS4ZKgqz9//3muPGOBBnc9SqEjiXgb/+ybKxmtrL2bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRPw1J7D/TJYNMQf2mUWtlo4EKCCBXCzGA9hm6K609IsdHGDs3ArYK9GX2OVs0jLiYkj7eKw/E+8bqTEEtlCXaKfj3hO7X5cE6L+VBW3IEhQ841Wl+uKB4IyRDnlNL0aRdFiVXOklvKGqNAgNp5wfEypDCxYY49L6mXHSnzJydA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=QvB9dgVR; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612752; bh=zrmc58a7ZdlMz3l1WQTsW0UY2cl2P2DiPjn4O0pUS3Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=QvB9dgVRqa0D121ON1BU7S88f5PTRY2h0ixvTZILYZAKsBaCeoO9LfvWgnPZmzZDXnUFYFX3seVnEJZsNs1kayAofEolV3+ZlVIRNL2JVhOmXM0/cHgkTnL3//HboJ+3QzBG9FANP3PcLBqnnRAOM4LrSi/+W6ogq+h1086mHVJjnz0dYLJFFoR9ykmTsVdas9zrzau2SCN0LmDOISvy+jIuqJsq/dnh6DzmQgo7IqQKXxRGgLCsiq5WX90Th7oKF2ZI+5RKAZ9t95j09kqNKQt/x91iDXMbkWL0b/f5saytwwGjfHeQwE+nT9a4krBl2X3TsuOyjGBql8DIOdXMfw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612752; bh=ZJRpmjZM9x1ZsVVTsKFGJ/2jzoCkFAqRFoaCeptmDx1=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=RkKp4NIub9g5LCIPgp6AemrAEWBdrywBboxz1V5nbJYQojdCQFHuuQTp3AYEC9aJDIta1Cfi9VfJqiFST/Nqi/CtvahHXlLQPi3EFvpomnWB5LMhHyeVlWlzTg7iDuyobn/aM56lGA4C6fp4UMNVpBMvUeAp/g3mXUWFIh0CGZXRM1EFIvgCumdtMnyvdlt7PlhYxCBadBeZa/58YdbCDiny5K+8oJh+iRDqTaB4MF2MWX5c6xNyZOWbiSh+cYDdUnIJ9MIcfuDHMBy/CC+RJpEu0EyoZYqW9wYphU9CysaBPioGU0MFgI6UQLl6o8TOomeQQG04VEHeX4QRp+kKzw==
X-YMail-OSG: Oai66qoVM1lat2uz2LtH7JKKiQS3emW3Gh8P5jhAE_ciinge5vGadrqRpIbWihD
 W37RsU1ewU1EQbf4jy2Jy39Z_UA_S9Wlu9RaLhb3PMVMw_r_qa7Qvk5w.XgsFL_EOu5sGZmwdLWb
 CJRiM978uQbGY4TF33qY6Dma3bOmnFzb8tKZyhtYgwTGMsbWcknoCddqsbJY5XiR7G0Gns_SCVx4
 3mnx2QxFPGJMAu2v9Kq0817zZFCn4qluTCR9pbwIZKzgroa33VwexDDraLUFKai7WPzRhSkPfvk9
 LeYUPqnzZhECbizEJ9illxpu74.D9qCFQekRDm14dUWtVa6YBLZXLpFvKcG2i5okP_XQANdvnkNg
 MFkY4VnNvcJhMjAEwxu8Hz8rfuZMxul6odU9jhx9aytA7rXuQWYbH8icMXkRCzlqEkQ9Y8tx5GDC
 iWmj0RvcCoo6peXDibBzcGwLim0rR0oDvavtPHMalbZ1x5blsagzR6Fk11Rp195ZCG6ob8.HEPXv
 brULEZcXhNtB0ZtqIwmFL9RvlB0oJ.LOQkjXEA.lCBcxlAc9M0osumIwieKoDO5MuZo4WnrjYkNj
 am.B_9JIpPFz96BhwTBAV2.hZjX3XVSPewvqYVtSeLJAkq9CXtgd_x9vFoUINIn20pMTVFKZPBsz
 jkjkONXeShATh6k9p6ULly4RuuNhp0rBVpBYuctUSrsF4kjL.AxGIDuo2X9P.j7beLAcPgnDR084
 OBB2e.CQUId9eRiDnNg8smQre8FmNGicMLnQ_eBpvx9yDhA0OllzxIllcjj5ZiPHRF0F.CSQYIof
 WZ_gKDdy5B1_ZSxYIc91gGCd25DFryfWtQYLCBmEhUJT1fkoiwnMxSd0cVatOcO5mBw3BV7qFRhO
 Iq0WfxH2Y.hWIaOv17eTPai9InsgL59dwuN0FPWtZBixeAgCEs7_WhqeTVydHxZZhtrnQSFDV_z7
 z1NKlnJeVez8BLe_mgfA1VoD3MfnuZdYh7SBB00.K9Q6LDZ5MoqYSOtWPQM_vYB24ErvOaSVK6_p
 zqPwhF5lVzWYfgoajPK3kdKFjBzcZNxg95HzR4aCUYu2zKKmBt5gvTsiEVUxdmU7h0ooj1rluMYu
 VWDmFZrhtgEz5l6COw6YvSFnnRc6XEg5J4vhLDaAFVgGHJey8MgCh_zrtGsktc3.W_Lle8OBOGVq
 NhM0GbC.dEAdLhbkt7Qb0CLrqfSrjSUY3c2IZPHcr33Va9HEN3Q1VFMBAsOa2F_usoxVb6XFues.
 sipC_j1gLX7V7.Neh3b6j1ucdMEzW25U4wqLFRM0h_t8AkkIfaWNCa45wkhyREMJE9CmzCWNqmjw
 EX_3Z58tgSOltm0uaihyCLW_TBeZ5qkHk4s0CLfS63_q_3ZSJtSpHc7liVS4Bmbm3QPCi2Mp1TyS
 rVwu3K6Bk1yDrkSQ8DzSSrHZjttZ3S4aBRtLSlx6R10xq0kzFrpVqfI1EU_ruqJcQfrhSA_2vAtW
 f2AHicYfWpUpqqnkW.KOwNZG4l1Lf.0KSkoI3g0aEKPbKZUfY49bucQW.P13Sqivmt_C4iGWk4a3
 xYej.e5e.7uHkLNKwtDr1cFproMpRQWMyk98sJBv7.3P7v0tnZxgwVJ3tJ86C.TWiIdGtJPpViXU
 NygLZK41X8rMot4GC0nOImiaMs2gPDlsrm2ll2ew0mbDF1UKFpXCkOvWe2YDdEvKdljNhHeUulUl
 n06.QcNUuulCoykXOz22Gh4tBc8lmTRQYuLXMy0K2DgTpkN1xuO65zdRqA1AiEkAXvhtEEm0yVg6
 0nVDEkYltqF5C0DgkpnO7nzE7MS5QJgszFuJo88o35gIidOIzRPsp9s7wJ83PKRw0qsb_Wo1iigq
 BnSVg_GkAMLGrAL3dTfYMff1sRT30_61KgDs7X9.W2xhLdeeWXjdoxLmPJObB1xdzE.g_3jev2VC
 zdfytEZ2AyWDpml7sNey.KWtfElQCQjRlcme0PuSuIdyfhJXmub3.qx.GcZ0FUN7zIjFMsdWF8Bp
 s6cRMSxho3s.hKCRo3WnlrOhUiD.ppdZoaq2JuPv7d1DchD3QLfVGgaiYr1jLY2dWCcjh0JDGQW6
 9bioQJVIml1tynaleWnnvf276J1XqDILczqyDl7avFp5WuJd54GwGIkpxr5Fuqv.lQOw7A0c9DIt
 jOTK9si40UHg92JXxvUqqxGA.gnPPwb.ZaXiXuXuk.GAiOV.8QALVBpBM31jQieOSVk_5.ewpee8
 NaLIO.jW2G1.XJV0T4h8EXXzVRC.NaTkzAW08HcpgW3K7p_u_J7cBir1O386YsBtGLAihuDDj8iy
 RkuyYHTCu13lNuIdSDNPmgMxGTU8sVvxkgPK249nDYeppphny
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 405856c9-7671-48b7-ab9f-f7fcc43c38db
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sun, 25 Aug 2024 19:05:52 +0000
Received: by hermes--production-gq1-5d95dc458-m8nfd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fa6d7487ce614a4db5b8d88c90575908;
          Sun, 25 Aug 2024 19:05:47 +0000 (UTC)
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
	audit@vger.kernel.org,
	Todd Kjos <tkjos@google.com>
Subject: [PATCH 10/13] LSM: Create new security_cred_getlsmblob LSM hook
Date: Sun, 25 Aug 2024 12:00:45 -0700
Message-ID: <20240825190048.13289-11-casey@schaufler-ca.com>
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

Create a new LSM hook security_cred_getlsmblob() which, like
security_cred_getsecid(), fetches LSM specific attributes from the
cred structure.  The associated data elements in the audit sub-system
are changed from a secid to a lsmblob to accommodate multiple possible
LSM audit users.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
Cc: audit@vger.kernel.org
Cc: Todd Kjos <tkjos@google.com>
---
 include/linux/lsm_hook_defs.h     |  2 ++
 include/linux/security.h          |  7 +++++++
 security/integrity/ima/ima_main.c |  7 ++-----
 security/security.c               | 15 +++++++++++++++
 security/selinux/hooks.c          |  8 ++++++++
 security/smack/smack_lsm.c        | 18 ++++++++++++++++++
 6 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 4fd508841a6e..4bdd36626633 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -215,6 +215,8 @@ LSM_HOOK(int, 0, cred_prepare, struct cred *new, const struct cred *old,
 LSM_HOOK(void, LSM_RET_VOID, cred_transfer, struct cred *new,
 	 const struct cred *old)
 LSM_HOOK(void, LSM_RET_VOID, cred_getsecid, const struct cred *c, u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, cred_getlsmblob, const struct cred *c,
+	 struct lsmblob *blob)
 LSM_HOOK(int, 0, kernel_act_as, struct cred *new, u32 secid)
 LSM_HOOK(int, 0, kernel_create_files_as, struct cred *new, struct inode *inode)
 LSM_HOOK(int, 0, kernel_module_request, char *kmod_name)
diff --git a/include/linux/security.h b/include/linux/security.h
index 4fe6f64cc3b4..111c1fc18f25 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -473,6 +473,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
+void security_cred_getlsmblob(const struct cred *c, struct lsmblob *blob);
 int security_kernel_act_as(struct cred *new, u32 secid);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
@@ -1192,6 +1193,12 @@ static inline void security_cred_getsecid(const struct cred *c, u32 *secid)
 	*secid = 0;
 }
 
+static inline void security_cred_getlsmblob(const struct cred *c,
+					    struct lsmblob *blob)
+{
+	*secid = 0;
+}
+
 static inline int security_kernel_act_as(struct cred *cred, u32 secid)
 {
 	return 0;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d408a700fe6f..8171da96a4a4 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -541,8 +541,7 @@ static int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 static int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
-	u32 secid;
-	struct lsmblob blob = { };
+	struct lsmblob blob;
 
 	security_current_getlsmblob_subj(&blob);
 	ret = process_measurement(bprm->file, current_cred(),
@@ -550,9 +549,7 @@ static int ima_bprm_check(struct linux_binprm *bprm)
 	if (ret)
 		return ret;
 
-	security_cred_getsecid(bprm->cred, &secid);
-	/* scaffolding */
-	blob.scaffold.secid = secid;
+	security_cred_getlsmblob(bprm->cred, &blob);
 	return process_measurement(bprm->file, bprm->cred, &blob, NULL, 0,
 				   MAY_EXEC, CREDS_CHECK);
 }
diff --git a/security/security.c b/security/security.c
index c2be9798c012..325030bc7112 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3153,6 +3153,21 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
+/**
+ * security_cred_getlsmblob() - Get the LSM data from a set of credentials
+ * @c: credentials
+ * @blob: destination for the LSM data
+ *
+ * Retrieve the security data of the cred structure @c.  In case of
+ * failure, @blob will be cleared.
+ */
+void security_cred_getlsmblob(const struct cred *c, struct lsmblob *blob)
+{
+	lsmblob_init(blob);
+	call_void_hook(cred_getlsmblob, c, blob);
+}
+EXPORT_SYMBOL(security_cred_getlsmblob);
+
 /**
  * security_kernel_act_as() - Set the kernel credentials to act as secid
  * @new: credentials
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f5d09beeef0f..076511c446bd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4029,6 +4029,13 @@ static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
 	*secid = cred_sid(c);
 }
 
+static void selinux_cred_getlsmblob(const struct cred *c, struct lsmblob *blob)
+{
+	blob->selinux.secid = cred_sid(c);
+	/* scaffolding */
+	blob->scaffold.secid = blob->selinux.secid;
+}
+
 /*
  * set the security data for a kernel service
  * - all the creation contexts are set to unlabelled
@@ -7240,6 +7247,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(cred_prepare, selinux_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, selinux_cred_transfer),
 	LSM_HOOK_INIT(cred_getsecid, selinux_cred_getsecid),
+	LSM_HOOK_INIT(cred_getlsmblob, selinux_cred_getlsmblob),
 	LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
 	LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
 	LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 8cda7dcf30e1..dbcf1c65da3c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2150,6 +2150,23 @@ static void smack_cred_getsecid(const struct cred *cred, u32 *secid)
 	rcu_read_unlock();
 }
 
+/**
+ * smack_cred_getlsmblob - get the Smack label for a creds structure
+ * @cred: the object creds
+ * @blob: where to put the data
+ *
+ * Sets the Smack part of the blob
+ */
+static void smack_cred_getlsmblob(const struct cred *cred,
+				  struct lsmblob *blob)
+{
+	rcu_read_lock();
+	blob->smack.skp = smk_of_task(smack_cred(cred));
+	/* scaffolding */
+	blob->scaffold.secid = blob->smack.skp->smk_secid;
+	rcu_read_unlock();
+}
+
 /**
  * smack_kernel_act_as - Set the subjective context in a set of credentials
  * @new: points to the set of credentials to be modified.
@@ -5150,6 +5167,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(cred_prepare, smack_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, smack_cred_transfer),
 	LSM_HOOK_INIT(cred_getsecid, smack_cred_getsecid),
+	LSM_HOOK_INIT(cred_getlsmblob, smack_cred_getlsmblob),
 	LSM_HOOK_INIT(kernel_act_as, smack_kernel_act_as),
 	LSM_HOOK_INIT(kernel_create_files_as, smack_kernel_create_files_as),
 	LSM_HOOK_INIT(task_setpgid, smack_task_setpgid),
-- 
2.41.0


