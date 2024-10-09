Return-Path: <linux-integrity+bounces-3775-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F802997337
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 19:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738181C222BF
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 17:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4301E1327;
	Wed,  9 Oct 2024 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bD7xpXz4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5C51E04AE
	for <linux-integrity@vger.kernel.org>; Wed,  9 Oct 2024 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495355; cv=none; b=K9bspBLKj83A/xg/wGrIhCFcLOLF5ILzBjCZVbctxo4qA9mNCENErKm6LT4ZPezXdo0D9goKrOPX3U0nOsurs9qYOYPzQNRSQ336BUw2LLToXOdBEi5ckoVbJKClBYvLikjXP8QJxXvhVd0gSh362AWQsUy5jroIc2Zz0U7dIDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495355; c=relaxed/simple;
	bh=vI/KtDb/Q5HuZSYihR4Tw8nHAj69pfOU6/bAMMsgkOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqEGxXAI7siKWDFh0r6la2Ey/U4+uxr4aiR4Dt8zQdGRBP1sP1VY+YhSEVrQsiKNreMej2vVezxOYulfvANDQDt6UylMX97UZTmmsZJk9A5VTMxqe8hpkbH3WhqJIuPPTKH163IlDcD0UJEjtovLquJ6i8+T8jQ85N8sifY5EcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=bD7xpXz4; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495352; bh=yWZJMVK1UkNKcLb5fb2Tu7Uy+QV20ZmGPbjZRVxv1RU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=bD7xpXz4j3J0Nfi3aB1oSrzpBOPSiom3zRirUwPuzNDyMV9+5T5PsBO5Fwo1dJx7zVs5+y22hCzft6D9j6r8wZM+qSkwBpdNKw4pfG/x7KZiXCkT2UNCbLM/zaLO4V+wb3NVT9dubMMVCGbTDXqE/ouJEEzfERHZ5oWiOdajaaWUN0MEcxx0WBW1uJ6kpDpjCGEiuLLxIYxOaVWzxsvIehtqrng9sGPXZIpkkfNCgDwcJiBfazgesegXgQwSPx7Ed5iI/gnyJU70gpADDaeNjUgn3/tCnXv7I+8t9EWo7JETB1TdXbOdIWDZ2Auzyw0BmaD+jdz+U4w1RvB75ad61g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495352; bh=1hVpS8GA6RWf++kM+qbXfjHxNAiYQGKXApTld0xNAWU=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ny5dwCdtNkT+CTjPWUSWIlugt+zS+k2KgsHDtflGB8dq7vy5mlokzT9txZ/WiIPplVHOq8qvmMU5YSESDHnLP27jQg7AkhjdoPyVdiN6e57JCz8+8qo9aSuCu/AgvpGIklvFjjuxURflebljc/weDqMXHsSvEG/rUpMHGOmBA/JszjZde87MHzG1kIdE/By19AkkClSOuPl34UJ7ZsAS897/sBuJukwK9G9L4WRx3X/BsozUOBQuOxyWnS5qjSY/uDez+y/w667pVx5IQkNFR2uItLIOBd1sWh8dPFtpOApv/VtjxOO6gGGdlGVroAB9oLWlKq7rDi+OqKsXi+SVew==
X-YMail-OSG: UCgrDJEVM1kkYE4lQGVD_c_ClAEaK8XWrS2zQfwSnUxfdsp_jRWh0emdqqsb1Il
 NalNQQtYEs7AX3uSKBsUQkFDiBwAYhCTF6GVBjaPp5CJg97dwB3dQELkVIHVQEB7KXRc5DTJuF1x
 33LzgyjNdxbPvBWOjwQJxHOSWMb.GyA3Y2zzkQ73UeCUcJGD1RXIEMEXMPUG9XwWLtlPmQ.c7nLf
 bbwlIRw.r.BzGjeatKMEWQH.tG346rP6Kh63WPzt30_tLXPBjTSuw31ccttbmuB6YNyHkbJS9n.C
 r7vu2VOToDavCctXpUt84jSJh_zYQVGGK1eBJX9uyjtGPTAHPlpH_KcBPkl9Is2.YQef1TkRdeAw
 zPqyo2sSw0uIl4ktvoEcW9J1UVqWJgON4VLEtMdTgOCpxdUSyXxwpnUK5FNpr8gGPMADG.OILTh6
 RagT1J4RgceT59W75wxu58cgg75mhRCNHe40s.njjKAKqOk0XVm7YNfKzXvyiwNFbLEkK9W.JApc
 sXmpxbq.fP7NNRfkUk15rsMAoNAFU6Vdg28AUI7qvqDczYfreeuOFiHr6S4NyRu.0MA_auHTaXQF
 ksS2Ys_O3KsgLQWLgKJXzYPhxR6e0guxLpZn8dLpgZ1lrhXPpq5Y52XVALTyc7YjPrIe0tWEDBYm
 ZfVC_b0vQMxOCVSAl9ho1KNzSJsYug.RcMgsMMTgwlgzAQgmuciHC5g4psxXe3XiEhkJs2bsw6xt
 wVOtxVIksEJVFOFfjScn6mPlTw8A7YbI2kUdWqa1MHNNOEW8IwGKPtdtDpJqDtEqVxKxK6666bQv
 YoZGPJZ5K3qT0tCmQ6vERuUQthIw5CpR8_Zgz10XXLLxkWs96M0QXbDsQRYcPBbIWCQxuA4azzwv
 nuwsX9UkUUKNTHB3AxEXrcYmVnprUG4xlkqence6Ec9kqByCHjmnr670MSQmJamWeO_pCqgb0jJb
 l9o27_FymGlYLCBTvbaMd5HeYWgScbi9st4pzi_o_GXpcJArNvE82PD24CFoG_OE_RfKRsid.uxY
 7_atxGVmsTKouMiHFZo0YPl6y9snGImv6ALB6rF6hwbqINb_dlKSGn0q1PGHsXInRpklhlKB_e16
 P18XP29oe4y2wTjIRBTDIfowseoj4iH2QSyjYLfQtFvBXbR5pY1f8bTZeR5rqlG6Fvh9peLgW5ZS
 W5J._54JVkeK5ld1QOqj.9.ztsVB.4EMyM3jdqBKN_4v8NDMLT8ZJWkn4hMh4QvaYC3fIWCXiCNG
 ZxPyf0amvvVehKwMhGbrgkXIvSy3OjNDI9HxxWGuy5ZnrQYXaeQCP3.CQJCuMKfqR0SD_AkUg0om
 buooruitx7JXQvaxXErepb1ry5Uzfi.lHP0_E0a481_iNsdcYXcV2Zcthq38Rcr6R4kJwMk4_EUL
 RkA3EPYfCLJx0WKQDkcrr7AdN0pf4yz6FVuM0aw3IKzmKui6ZATdZhRRNC_6yvTuTq.ZUPRYbO8b
 7Le2YnocLBjRkUQyXxP_zjXa_MLhW8jjUQ3gisNXl.DaxdzPpNe6OfyG7U0Aga0F0twD9d8VJKOK
 TW0HyOpdV18.wpLkTxgS9TKBO5f9B3MdpeTism.7eT0N4VL7ryfhWoQfekgOZKhbXdKBvojNQ.GE
 wVbcNub_ZZbCfk31y9KuLcDQO8jXvHZd5LoY8DhslmMnqHsJULgLyUXgEdlaWy8k6oQsw5w9.WJ6
 kaVFRxCv_SRSmoXstN0vXMKBWoXE7CYX0jyhKhG6UL8Bfjs64lf_5Ityr0YOtjj1JwTu6kR.EF_v
 g32uEr1gikbuc5uwR2Ih1pGs1R_ylqC.j9yKKC8iKkcMSnyzY9EYs83meU9mGDZDTW5D62Lz5Bro
 IQDQ8hr8.tnESfDa0_8vKeFV8hwqgwDVs2G94bZIWOlwdjnAgivbUR2Q_knaxi7H41TYVlG3qE_d
 GxcYEUuWwJl5dWI2.5VimRWrPMpEbK23FbPnNPgHr.0NW7_9wewNggpNK_68JzVGga9pcevXkTKo
 FP__AM6ROAqbp9iSJ4cog3KQE1MacdoaPXu8o1C1dWXmXqlkFQjEvaGEvUl30mjah4Dc9GwWGGwT
 SnwyFsS3H_fGnvQIk2wizsmcipkkyFmsVeqZyigGpV8P6LkkKu0m7svnL5w.FaZRtDW3SDDuxrHg
 oEVAujVwz8SBvWwKTpTgdpZ9CBcb04zOE.oZadcAerd8l5WiSQHoSMptlkbiVrI2Clvb0kwXyq4t
 hl7o941SahAuEPDEHsaxDOeNn.PCMWkBcukr6a_lDNq2pLifJW2JY1CSBTcl0IAet8lMdix7gddM
 Av.eC3wogwi7tuWEOPiQvhsJ1F60QX_5.rVfgohg58Pm.57bPDQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4762dc73-d0e5-40aa-b744-42b9cdfb572c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 9 Oct 2024 17:35:52 +0000
Received: by hermes--production-gq1-5d95dc458-rvnnh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 502c2859a32e83ed73c2b19ff921ebf0;
          Wed, 09 Oct 2024 17:35:47 +0000 (UTC)
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
Subject: [PATCH v4 10/13] LSM: Create new security_cred_getlsmprop LSM hook
Date: Wed,  9 Oct 2024 10:32:18 -0700
Message-ID: <20241009173222.12219-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241009173222.12219-1-casey@schaufler-ca.com>
References: <20241009173222.12219-1-casey@schaufler-ca.com>
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
index 23ad7e4f8c67..eb2937599cb0 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -218,6 +218,8 @@ LSM_HOOK(int, 0, cred_prepare, struct cred *new, const struct cred *old,
 LSM_HOOK(void, LSM_RET_VOID, cred_transfer, struct cred *new,
 	 const struct cred *old)
 LSM_HOOK(void, LSM_RET_VOID, cred_getsecid, const struct cred *c, u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, cred_getlsmprop, const struct cred *c,
+	 struct lsm_prop *prop)
 LSM_HOOK(int, 0, kernel_act_as, struct cred *new, u32 secid)
 LSM_HOOK(int, 0, kernel_create_files_as, struct cred *new, struct inode *inode)
 LSM_HOOK(int, 0, kernel_module_request, char *kmod_name)
diff --git a/include/linux/security.h b/include/linux/security.h
index 2b19ef5d799c..acd2e5d1b0ff 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -488,6 +488,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
+void security_cred_getlsmprop(const struct cred *c, struct lsm_prop *prop);
 int security_kernel_act_as(struct cred *new, u32 secid);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
@@ -1229,6 +1230,10 @@ static inline void security_cred_getsecid(const struct cred *c, u32 *secid)
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
index 553a6f54a1e2..91154bb05900 100644
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
index 5e76e35dda09..0003d5ace5cc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3272,6 +3272,21 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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
index a9f8d10062b5..438dfa17faae 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4037,6 +4037,13 @@ static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
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
@@ -7203,6 +7210,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(cred_prepare, selinux_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, selinux_cred_transfer),
 	LSM_HOOK_INIT(cred_getsecid, selinux_cred_getsecid),
+	LSM_HOOK_INIT(cred_getlsmprop, selinux_cred_getlsmprop),
 	LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
 	LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
 	LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 5c3cb2837105..52cc6a65d674 100644
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
@@ -5132,6 +5149,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(cred_prepare, smack_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, smack_cred_transfer),
 	LSM_HOOK_INIT(cred_getsecid, smack_cred_getsecid),
+	LSM_HOOK_INIT(cred_getlsmprop, smack_cred_getlsmprop),
 	LSM_HOOK_INIT(kernel_act_as, smack_kernel_act_as),
 	LSM_HOOK_INIT(kernel_create_files_as, smack_kernel_create_files_as),
 	LSM_HOOK_INIT(task_setpgid, smack_task_setpgid),
-- 
2.46.0


