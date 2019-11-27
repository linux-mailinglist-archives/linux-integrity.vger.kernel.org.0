Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76AB910BEA2
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 22:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfK0Vhf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 16:37:35 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:38188
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727231AbfK0Vhe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 16:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574890652; bh=LSyAt2WeuO6hSQ9OiEuek7yB8izNk5GHg6KqQuMX7GI=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject; b=iWdpzPnFQSYSS7FzC8x+y8CB2hlycWUM0lKRMCR98PuxS0CtiMwxT1+ia3CISiKV9ikDONZmBNrMQaGlLiuaRv624weLF011zWh9S/fiVq64HEisqWMbfPs7z9mhnMkB3uut4o8rvGxQg0rZ0oECzccc9YGPlOCWr5yJacYJhADrnYDqtJjD9ZwWfS3F8cxTPvXfzQ0/u5nskU514m3Q7exS6kKWD9TZq18Nnigo05cHHD95jvyGoeu5aNLrBQP/LNpC0nPVFynLfJdhQj3U+vH7/ZLY1hGDYhUyrvcVNvLGEIhvMXOgdQTBg08pFIZq94GESYx0Nsk8SNKJnmOJOw==
X-YMail-OSG: r_4K2jkVM1mhTGWyFXb795pL9zAVlm__erQhdruzdNgSvqWXdHUMNek8BeGgPhw
 PooHTRv.kMhhiJFhFOsvnEK4RWJeW5GdoRtRggyBGMAyRIyUBQ_CAsrUaULd5BX3_W1W_u5VsyHx
 ZU7t2XdzSrTWGJHX_4XEHm2ZsNgLd0ki3_JR3ddjFOgh1_Tk3nLlnGVBgRO3n5YJxneRiGB1yFAZ
 HM78Y0Rj_y42ZS2_bufflYLNO.PcrRFHfhk9918bQAEFtn4LJOxS2lqbHaHQSeH.T2A4vMGIf8Cq
 6quR3detz4KnxsuNv67csN4K4lLLNUzxpv05biD0x4hSlw7iTYzTrt6nsVfcXWU75ZdVox4jBvQE
 CLeqIpE2pXSGOpUSB3JnnZDrjwfh1iaUCAyuNO7WFntt27fgs1uTKcCF0SISX0fTU3JYi1ScZeYg
 mt6RhG3crSzLJWx11FfCrG86LoYYllqD3wcZKgoR4Sp1t.Vx8vnurRHCoIIKXmJM8ZNY8IJFKAqs
 VvjOS9WdGWneXUS_lzaz5krRWI1uqHd69ITdpV2_bRfMV75AZc.A9S7a8x1GfP31NwvDlbXJsum9
 OnwYGKRJR8u.JtjBJ7cSWCmcwA8UDxMhxfVymysCshk6nDRIBwXBBtHu8RsrJJX0iOqyWAISwKXZ
 8iCwpe.bALw.6ZInfO6fZx8gtX.VjA757O9zFmZ8_h6VXS3jXyxDGIAlSJSptUhy94JrK.Cl4gt8
 kN05AX0pQVtH9hr8rOQkJDibn3oq32AkmCgiGez5k.4bdvRtiMaNqxeMqI2ZMxj77yP.avH9cYAS
 v5tTnYk4Fz27GKRybjs19sAtuQpKAZvXrsz7K3ita5cxN.ucYQaMp.iO7rE4hHwKQzGbRbEqx1rk
 HzT04svzNM9VfcBODNkx08Fb7h6RkcfNLUSdyvkTihU2LThq7fiGNVwKdejt5ED_reyQFtq2fKF3
 i8Szjgve1y1exu8HSOagzjGulQMTDyR__uE9nG4vL57WQIWk71va362NoUYKs_khRebHmvjm3f9X
 L2Ho4fbNIyeINmRebtD2gwaTAmv_m0DJDv773DVBoywiQuhfj0BGun2FsZrTk9CyvLMU4mG6LBhC
 Bi.VtRkLHiN3j3aumAPheDR3EkwMYsuqosSlQ2uf5CzH_ISzdSSIUcIC6R2n_DdV31jF8y.maGbe
 h3.VbAGLOc556lm8I51lJMGXGigUpGpkECPuI2COXyJ4CJ1BPm4JBdNwyKE_bu3yMiKDu2eO6lxH
 3B8iHAM95ojM0R4vDQrn6J_bSvI439WDX7euf1c5L3Ur5lh1oPi6IyjIkMHpbCVFuXMfibPXWbls
 lhhc7BTIYGuvVZUCtjriiZD9GiGLSPmmwWMIzSpaSwH5rt9a.Kvg5UhwtusSjsNpYiCMCvHeLHH.
 heYiTzTnigNyaUBKRlp_6EHnsEZl3X4WpD7Qaz9ybu460gklt
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 Nov 2019 21:37:32 +0000
Received: by smtp418.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7ae6d5325a27611baf4cae658f88f94c;
          Wed, 27 Nov 2019 21:37:31 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Subject: [v11-ima PATCH 04/25] LSM: Use lsmblob in security_kernel_act_as
Date:   Wed, 27 Nov 2019 13:36:57 -0800
Message-Id: <20191127213718.18267-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127213718.18267-1-casey@schaufler-ca.com>
References: <20191127213718.18267-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Change the security_kernel_act_as interface to use a lsmblob
structure in place of the single u32 secid in support of
module stacking. Change it's only caller, set_security_override,
to do the same. Change that one's only caller,
set_security_override_from_ctx, to call it with the new
parameter type.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/cred.h     |  3 ++-
 include/linux/security.h |  5 +++--
 kernel/cred.c            | 10 ++++++----
 security/security.c      | 14 ++++++++++++--
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 18639c069263..03ae0182cba6 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -18,6 +18,7 @@
 
 struct cred;
 struct inode;
+struct lsmblob;
 
 /*
  * COW Supplementary groups list
@@ -165,7 +166,7 @@ extern const struct cred *override_creds(const struct cred *);
 extern void revert_creds(const struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
 extern int change_create_files_as(struct cred *, struct inode *);
-extern int set_security_override(struct cred *, u32);
+extern int set_security_override(struct cred *, struct lsmblob *);
 extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);
 extern int cred_fscmp(const struct cred *, const struct cred *);
diff --git a/include/linux/security.h b/include/linux/security.h
index ef936b608865..503058f1de8b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -434,7 +434,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -1040,7 +1040,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index c0a4c12d38b2..846ac4b23c16 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -732,14 +732,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
 /**
  * set_security_override - Set the security ID in a set of credentials
  * @new: The credentials to alter
- * @secid: The LSM security ID to set
+ * @blob: The LSM security information to set
  *
  * Set the LSM security ID in a set of credentials so that the subjective
  * security is overridden when an alternative set of credentials is used.
  */
-int set_security_override(struct cred *new, u32 secid)
+int set_security_override(struct cred *new, struct lsmblob *blob)
 {
-	return security_kernel_act_as(new, secid);
+	return security_kernel_act_as(new, blob);
 }
 EXPORT_SYMBOL(set_security_override);
 
@@ -755,6 +755,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsmblob blob;
 	u32 secid;
 	int ret;
 
@@ -762,7 +763,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsmblob_init(&blob, secid);
+	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index 7c386cbe4cf3..dd6f212e11af 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1615,9 +1615,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-int security_kernel_act_as(struct cred *new, u32 secid)
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob)
 {
-	return call_int_hook(kernel_act_as, 0, new, secid);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.kernel_act_as, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.kernel_act_as(new, blob->secid[hp->lsmid->slot]);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
-- 
2.20.1

