Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2555FE56A
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Oct 2022 00:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiJMWhO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Oct 2022 18:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiJMWhH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Oct 2022 18:37:07 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4F7196B42
        for <linux-integrity@vger.kernel.org>; Thu, 13 Oct 2022 15:37:03 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pq16so3285267pjb.2
        for <linux-integrity@vger.kernel.org>; Thu, 13 Oct 2022 15:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=th8D9izQjJ998cI4/KZV6eZrR/ZwkBVpvdjFCGv+/SY=;
        b=oFkXChlXsxAQj3qYnpkg6w5DgXNz015acDxzTjiFNg+LPH4YFf92tFiNq4ILnZ5rcm
         K3clpPlkpKwoIQHEettguvBV3del7f89KcoavahMxa6b2QTiXUdmY3ocXpTyN4+3xWMK
         jQIjOmzIQzSGzLhrORBO/14AVFbusiMzsb3S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=th8D9izQjJ998cI4/KZV6eZrR/ZwkBVpvdjFCGv+/SY=;
        b=Qwsiin0lezUHUGAPpWURPzxWPnuGylxI62mw5lqrlWzFFgqWRcw1U2nfYTEHk4UQ1O
         20iIYD1572YyTJjyijdHjNk2xygWGZ6AusB689EHrvapjhEBFtNNeXgBbnVvEI3t/e5e
         U7sQCqTM+yR+0Rv6n88+voM7xCRyVDqASj4STIlUs03uVSh8q2zeKvkMlRS3utmPxuTa
         fZthhr6MDKTrw/fzyoil8cmLjzJfDjx9Ys8u2Hzbw23TYlpUQ724favdU9mBqOj2gvXR
         ksbO62fxFO9oTg9FjGaOLJ1cVSN2iq/UG6XhuVWO4tTIocUJktzN/d4KZgucp2tMIV7A
         pA+g==
X-Gm-Message-State: ACrzQf1HWrBf9pvlmas4kp6lLjDu+DtB3anpbDaM3iJ3NsKt4KO03aou
        zcEJcS2EqznQ2AyiFS5vFkZf/Q==
X-Google-Smtp-Source: AMsMyM7tkx1yJHuadWcKXwPV4On6zhRvtyoz+baP5KndPSoG2rbNgBdgDCGHyqjuRTZm/+LgVODdCg==
X-Received: by 2002:a17:902:e806:b0:181:ebae:3ec3 with SMTP id u6-20020a170902e80600b00181ebae3ec3mr1980728plg.26.1665700622253;
        Thu, 13 Oct 2022 15:37:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w2-20020a62c702000000b00562f431f3d2sm210782pfg.83.2022.10.13.15.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:37:00 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 8/9] integrity: Move trivial hooks into LSM
Date:   Thu, 13 Oct 2022 15:36:53 -0700
Message-Id: <20221013223654.659758-8-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013222702.never.990-kees@kernel.org>
References: <20221013222702.never.990-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4421; h=from:subject; bh=7RyqoeAwl+CutBMqosFojTLcMBHMS4XEBmxI0jo4aFA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjSJMFaAp8ZLEl5taZLtxuA8Zx52dQdOpANz9PD0qy VL3NtaGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0iTBQAKCRCJcvTf3G3AJmDRD/ sGbgLjktgWkI9wVyG3hDP77jeZhaQHdStjWDHx6ecJa2lN/99sa8q6HtTYZWdm4T0fCfe5Q4qnD7z1 x5AR3/XV/qu6daTmfLuNpw4bTa6e9JXdjF1IogdsY84KxiiPv+l0Xfaoz16seZkRLWVammSxE/HyCA PdyZFCVy26Txvk5ACr4uI/1/M8Fy44cQFEgmlGf6soXGSRrQ8QK8xSBGLPugaexsT31/uww4f3lWin LxWBZmdWAnlbLl64IVofxF79qApzSX3+arh8wVl4nPLARJlC50nqaCnMZDKV1xGKUYU1eIjw9KxG3i 7jdDYHnP6d3rQTh5z99hPcv9oq2vip7hulX/lSYzKRZ/b9dmBAWnHPW8NYAP3iV9BoFZq/GTG2v/xp lnaCanFIfe/KCZS2w4wCEZpPmOVpchqiJ93O94AbpZ4zkdldPW3K9p0VoJKjcAniGDg9Xno2g7bVs0 YGLQ+cgp7NhiKjk520yyUpO9evF8lJhvYleFH9zTspxMeeBxC8XM79h5Vq55Ln0moqIlgGl9Pu1pwM NxcBaMQdwesGAqSTG++wsXi3vOaogZEw/7QUCPnXEw92OwhSFWYgGffJtMPIgw44YpkmYwkOAaRuKh q7uepCQceWY6ZotfI49P1IDKJ7oE8dKO04WpFF4dbcS7EwEJNyd7k9ylJgtQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move the integrity_inode_free and integrity_kernel_module_request hooks
into the LSM.

Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/integrity.h      | 19 -------------------
 security/integrity/iint.c      | 11 ++++++++++-
 security/integrity/integrity.h |  1 +
 security/security.c            |  8 +-------
 4 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index 2ea0f2f65ab6..c86bcf6b866b 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -22,7 +22,6 @@ enum integrity_status {
 /* List of EVM protected security xattrs */
 #ifdef CONFIG_INTEGRITY
 extern struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
-extern void integrity_inode_free(struct inode *inode);
 extern void __init integrity_load_keys(void);
 
 #else
@@ -32,27 +31,9 @@ static inline struct integrity_iint_cache *
 	return NULL;
 }
 
-static inline void integrity_inode_free(struct inode *inode)
-{
-	return;
-}
-
 static inline void integrity_load_keys(void)
 {
 }
 #endif /* CONFIG_INTEGRITY */
 
-#ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
-
-extern int integrity_kernel_module_request(char *kmod_name);
-
-#else
-
-static inline int integrity_kernel_module_request(char *kmod_name)
-{
-	return 0;
-}
-
-#endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
-
 #endif /* _LINUX_INTEGRITY_H */
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 4f322324449d..dea4dbb93a53 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -142,7 +142,7 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
  *
  * Free the integrity information(iint) associated with an inode.
  */
-void integrity_inode_free(struct inode *inode)
+static void integrity_inode_free(struct inode *inode)
 {
 	struct integrity_iint_cache *iint;
 
@@ -177,12 +177,21 @@ void __init integrity_add_lsm_hooks(struct security_hook_list *hooks,
 	security_add_hooks(hooks, count, "integrity");
 }
 
+static struct security_hook_list integrity_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(inode_free_security, integrity_inode_free),
+#ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
+	LSM_HOOK_INIT(kernel_module_request, integrity_kernel_module_request),
+#endif
+};
+
 static int __init integrity_lsm_init(void)
 {
 	iint_cache =
 	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
 			      0, SLAB_PANIC, init_once);
 
+	integrity_add_lsm_hooks(integrity_hooks, ARRAY_SIZE(integrity_hooks));
+
 	integrity_lsm_ima_init();
 	integrity_lsm_evm_init();
 
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 3707349271c9..93f35b208809 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -237,6 +237,7 @@ static inline int __init integrity_load_cert(const unsigned int id,
 #endif /* CONFIG_INTEGRITY_SIGNATURE */
 
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
+int integrity_kernel_module_request(char *kmod_name);
 int asymmetric_verify(struct key *keyring, const char *sig,
 		      int siglen, const char *data, int datalen);
 #else
diff --git a/security/security.c b/security/security.c
index af42264ad3e2..60c0ed336b23 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1036,7 +1036,6 @@ static void inode_free_by_rcu(struct rcu_head *head)
 
 void security_inode_free(struct inode *inode)
 {
-	integrity_inode_free(inode);
 	call_void_hook(inode_free_security, inode);
 	/*
 	 * The inode may still be referenced in a path walk and
@@ -1723,12 +1722,7 @@ int security_kernel_create_files_as(struct cred *new, struct inode *inode)
 
 int security_kernel_module_request(char *kmod_name)
 {
-	int ret;
-
-	ret = call_int_hook(kernel_module_request, 0, kmod_name);
-	if (ret)
-		return ret;
-	return integrity_kernel_module_request(kmod_name);
+	return call_int_hook(kernel_module_request, 0, kmod_name);
 }
 
 int security_kernel_read_file(struct file *file, enum kernel_read_file_id id,
-- 
2.34.1

