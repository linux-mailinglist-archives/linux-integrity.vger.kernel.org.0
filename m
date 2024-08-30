Return-Path: <linux-integrity+bounces-3434-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD04696541F
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2024 02:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE691F23DB3
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2024 00:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176621D1315;
	Fri, 30 Aug 2024 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QkycgU1r"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B70B1D1300
	for <linux-integrity@vger.kernel.org>; Fri, 30 Aug 2024 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978351; cv=none; b=Uq7gxz4geE8hW8u7w0giKP/JuLz9zz8wEIZhvX3Vac59qGqnziMca/aZqFuDVzwgwCmIdiunadeIv2ZpoFYbgHKEEdSl4Sf/0yOhL8Nfnm2/Iiw2b5E/QW3dPSsO9tyXMuUIntZENbEQBL+UEI77nUWpvYAL+d5FY54LQ2lxbWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978351; c=relaxed/simple;
	bh=yWQqcFo2VEeVFJdxVNiXAR71ak83CpaL8hJJ1XCkjVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sz5SmpfAzr/5/CFk28hGS1MTqzrmTwJ6mruT1SJjVF74pINuJKELsmLAD4YN/VcjgZ0z9f9giNAouAL6SUOtNGrtZ4sdgliKw40MUyvKPw4RmQXr8lHhjeCgeuKbRDbj7Mi/KX6Vw6alCMfTn83/+6b0BOoI4Ytye1sfjWb/dPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=QkycgU1r; arc=none smtp.client-ip=66.163.187.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978348; bh=XdNW91Iw22TanKU9ECNSOgSNyH2hI8Zx0Ag2V/vlglw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=QkycgU1ruNsM4HQ1BTaaAGLHW2Dn3jMERm6gBCGFMWszqf/efCgAXl0Dd7NtwkJpTce8U/xFhZ7VvUagoGGob56ReQg8fhqI5F3zu9vddrgmcz9SPAjBlTUlT1iIDmYf7jDOKq3JHKnbpNj0pw8ugLrEgrp8295Jm+K5lDJlXSU8ao283pA/nNgBB7M1isfz2EcYSxuLuZMD/yJJiQBiJdBI9P17KNa8BhdSIKh817dPUPTeU58TMkUs+Hj+bnBTwS0Gy1AjPocG6LFKXaQPgMGsANQ7Y0xft3YKRG2r/5k5t1CT3CntHoTUXGpQzE9yKHqTTWlXSm7KneE29GJdZw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978348; bh=isLss5h1k+6Q90jLFkNSNmtW+zUiXCDB6SCRyILYX28=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=YgpwR/tjKIKcolmbAbqf34wq941zejzQOfdZaXQhLXrVq8xkd6FcT7sxj4O1A+Ummv4QZJe+Fl0ft58XsYy58UfQIO403T+uHYTPlbgYPrZy3ozBpWObRQOPCY0Ntwti5vcOXZ+AZZotSHZCW2tzISIm3jZGIAlR8be+S/+bUz6u1WtlbKMVQMWWXEWbEbLw3ouDw0fq3IKN2BhtjIELaXxW5du1Va8SL5WfCSdcdso3nb2iRWmO22/uUpFm7DNdfegjX7cOMLkgfu4baPdb3dTRv8AWbFYFJ/D8LQgxZ90rPSaPkOxhVDqPjqYAbrZxRLOPM4Wq49/BivWuQHcRXw==
X-YMail-OSG: Lt5i.OsVM1n9aFZwNhpK_s10Wq3.DVuC_RQcIkkdLGmqFMji7vIZCcU5yO30nB3
 IYN2F4qOSj.5nAUqgyqcDxyFUllHSOVjXq27C5aWf0.9lqf2YDwBNAb4vswOzaXqrwQjwLNHUraG
 2DOz_CH5hKyR5kbPedT1DDZ43coXgEW0wYQg8u7xdpYxum19Pf75UPm_xzAEq9Ov0NhZlnJKT6fF
 9wUtzlQYHGXNUYkV74hW7a_CwVKuZNcuBYPWtKK_DtmO7sxsCBASy9le4WjMeEt3eKVGSgUtEuO4
 2kt4Ijh6SyQ2qCy0TYlTfd_Ixatk5ptvzrb9G5lSLD8YIPmAXD25rLOA7wgmjbBJKJZehXLuRuKQ
 On.W6vdBnJ4PwsAg8X31g9EK1M3xERuSuGrRGba3txHcvxECNjmxAc5gbrINZ1hE4D3ndTOUuTe7
 r9AwjMlgR5WKrUFUM6v7aZrzlkHRqYTNZFRrtVAHAokFb.PBAaYG6I7C7DTOOhjMYGa2MiBOzJhc
 oWduv97PrB_x8P5gZ5JN1rPJQWxYGalW2LjSJ2.wWeS5cwnRDX1t5_Gx1dhhdWGbnHBZpd66Qs3s
 C4DYXQsEgkM52BbpUAIMKJugalsSIDFlttR9xllNiR7nL7z80Ess9hleGnqb_gEm6uwRsqu6VXay
 s8ZqfW9GowbibQa5NGZtEdTTCrPXbFKwo2b_F3bkMtMC8cdiW7PRMUEjV0bMB9uaXYX5E89AI99w
 IFWchKolWiV4Bf2Q6yf5tNUh3c9bHb7VaSpilAii.arDe7IqxGZfAzqAts6AkxpY23RkkGAF5JWt
 pdzo7AZW3MtlN1AdM6bT6ISK72uo8bpk2LnK4NumXL4TL1p2YfCw_Fk_2HNfTcsN35Mfhq1YnUIm
 VZ7lcVxU4y7R2sFGB73D3MPw1c0d_RaWIu3vrP5WyVEp9KesQ8hpeeH0fAS039oLOaUP3GkFHyJc
 smX585yvFvpq3Cdo.8VSfzsI.Eh6x5g5sIUY0GRYE0lf6Mmo846zaXMaKRPCxkgCUx9Y1H9tpXdE
 XZE4Zni3DgkKwawwNjzp1GN9OuVyj4w1PDU6nMpwqkMxOap.qT2O.Fo2x4kQVYaRAIotwaDD0rDu
 JcIlxu0ermU.e630uzmZv.OYaUK9V9eRDhCljuTuuFxbN3nh8Wwjbvsygouo2YkSTqBiVSxvttt.
 BREXEYnOi5EVc96pT8DggxnTmXZBNB_sfBwDNWW2TISjvH8qeAYbVpd13AOuJSSW1sCM_sUoj8dF
 olRmkHn3h0Uf_WJaAL_PcDOhncIVbeQmIDdxGySsbIBcbpi_t6C0xtZtqwpgdN4D_dn9zJKfnthK
 iHyo92tkRl8BanmYo4NeGhuG0urPRd4e752GzzkJvc1EoDn0plv4gsczFeI_TQtsQHQhcODzSeXU
 dOrK0Bqnh7oG9.d7GuQDHK34VC8j5qUYMSMT4_LfNblZkq.CqIa80iDAtyUn33yZZkUugkepzusN
 LeFojrNPfqBDnGdBcRS0UA9gTHyY9YelgyPoEyIpbzcYBlB3WiMz1IUvThZ2ot1woaG.PJoB31_U
 2ADbDgJV0iJayLC_VBhr9QcMHhp1pLr3dl4udrE9OBQop0uc3zpWY3SsFyimL64ApT9LerxYj7tL
 fewRMEXFBQ.U4Lv42PTVZkdqfNJAlvuhWSkk07zOqMPTMFKkxLpwUaQYH1dcJ_Tss7XAJNKC2r15
 eR8Re1g133M2R_6D6uouhFOcr2aSNgVphtot6JSbRMLPAQPf4BVL8VgTB4Yoq6O5N6nO7P5V0bmA
 u9ROlFLj9KKCk.VvLcTm8UBkFyiRJmJ9E0VBGiv67oCqo9dfaehcmJ42CcdbYrD.0IgKXQsCt0iD
 z8aWzG_.j5E1TCG0_hSeRPvqfjadSwbqy5fMsRRu_Zv8WGla_0cWQVDxQWH5LCzpEBmg.rjB_W9t
 JyRc5sltc0Irc2IFH1sio4vyej8rsHJUVVjaubZXtTz.zDW18mVTGZJM9kwRsx15PM5aPdzQL_ad
 GuOVLxdW3WaFbeeZs7CRlhxgOET0UmhUlRokwIkAckQMNu.S6.M.gv.R0nVNrboiZvGIjTPk208v
 AGHnzROcX_nGnsOQ.9xFzC40XoSWupF9pluIytxMCGQLB1sMo13F9_0.c.TZ9DCxKUAN.PB6quPj
 PjGHuqJmFWhmapaJETVH_01qXFl8shIhRjZTc98RhyZtQ0v2D6pPjKcYtFabYAK6hx_oFmYjooKn
 UTSddVMekls.3YUmcM7fjhH_oQDCwgGGO9o.wtgltk.roAmsWjWGbzGGY3NnE_hPVzPqFLoqMsYj
 M4tDbywDjSl2QZwac41Ea.gPrfsCXijE1W8eYB7d23QowfpE-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1e72a095-b931-4a33-b88b-0ef8d1725ace
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Aug 2024 00:39:08 +0000
Received: by hermes--production-gq1-5d95dc458-jflr5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 35a934a1749a25fd4473b6654327c16f;
          Fri, 30 Aug 2024 00:39:05 +0000 (UTC)
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
	audit@vger.kernel.org,
	Todd Kjos <tkjos@google.com>
Subject: [PATCH v2 10/13] LSM: Create new security_cred_getlsmblob LSM hook
Date: Thu, 29 Aug 2024 17:34:08 -0700
Message-ID: <20240830003411.16818-11-casey@schaufler-ca.com>
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

Create a new LSM hook security_cred_getlsmblob() which, like
security_cred_getsecid(), fetches LSM specific attributes from the
cred structure.  The associated data elements in the audit sub-system
are changed from a secid to a lsmblob to accommodate multiple possible
LSM audit users.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
Cc: audit@vger.kernel.org
Cc: selinux@vger.kernel.org
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
index 88e7ac15ca62..a2445e4f906d 100644
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
2.46.0


