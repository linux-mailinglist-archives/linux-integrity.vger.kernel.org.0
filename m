Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CFE5FE55B
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Oct 2022 00:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJMWhB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Oct 2022 18:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJMWhA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Oct 2022 18:37:00 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C6726116
        for <linux-integrity@vger.kernel.org>; Thu, 13 Oct 2022 15:36:58 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f193so2802673pgc.0
        for <linux-integrity@vger.kernel.org>; Thu, 13 Oct 2022 15:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceH/RO/hzWXDxSnFXezZugzYqMJL0QzXH8UIXIXwz2A=;
        b=RdhSRBgdbmEcHTzPfBXbR/j//1diduAVoeDH1mUi7dimeFgOmnh8JxLdvqI6aFAqBz
         +W54LtdTNlzsY0BuVAZcaQ18xSVO9N4yN4MAX4tdqqKJ7gE+3ebIB5Mxixuf0FmFxpfX
         1xPv6UCAlHueIHgZUQRe7YD+3yXNAwKrcBkjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceH/RO/hzWXDxSnFXezZugzYqMJL0QzXH8UIXIXwz2A=;
        b=MNSsa/veOLFxCu4dvfjREkxLn2xQEuwUsZrZmg1sA+3w7axP/W0W4Wlhv74pg+5IhY
         TSSJcOX1KBi84vpDB/bE7JElXVrxzdX8e9wdbbBWj1uuG88xKzOOMKaXnykAm+I3BIRF
         FYd9YaSdMnHfXmplMyU0pCJZ+d2cTrUw/x7AqbQJA+P/2OswpNiTsXrNxAGVDK32QyKC
         HzeFQR5L2+SPbbf9KSs1ZUuol8pr4tRTmXURkrgfLCb50nHg+FCfeRvla2QRm0KlUtPl
         Qj0pAx2KVHQ2qGgmnTS24TPz34Oa9vZhL9hcF/KAd88trFYlrIz78ouqKMECirXf6Cyw
         T/HA==
X-Gm-Message-State: ACrzQf0DC+9ouHj4pUiZvYRDZ29KP0KkhKAMkLxqz7bR1+ri9n4dDRGR
        Zn2sOLYUZfPP2DZ2NucW1qaIRyLAFwQX8A==
X-Google-Smtp-Source: AMsMyM5yQgu7plQb5tA8UN7RTNMLDoQSRx/AdI4uSOPG/bXTseMCJK5g17Varuq0uDdYUYmvddK0dA==
X-Received: by 2002:a63:1162:0:b0:450:a0e9:c996 with SMTP id 34-20020a631162000000b00450a0e9c996mr1848284pgr.140.1665700617354;
        Thu, 13 Oct 2022 15:36:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t21-20020a635355000000b0043c9da02729sm210127pgl.6.2022.10.13.15.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:36:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Borislav Petkov <bp@suse.de>,
        Jonathan McDowell <noodles@fb.com>,
        Takashi Iwai <tiwai@suse.de>, Petr Vorel <pvorel@suse.cz>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 3/9] ima: Move xattr hooks into LSM
Date:   Thu, 13 Oct 2022 15:36:48 -0700
Message-Id: <20221013223654.659758-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013222702.never.990-kees@kernel.org>
References: <20221013222702.never.990-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7063; h=from:subject; bh=UwVZQhUAV34kLZLvWg3gW0Y3AxAoqPtrDDTwL+QIuyQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjSJMEHh/BpJ8T/UrB3miOUYuzJYjTTQP/es9Hk0XI dfZG4xuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0iTBAAKCRCJcvTf3G3AJpZ/EA CGzX2dABmN4vM8z88raKKj3Nl+cOZLLMTHDR3tYm9/U+nievEWZnBIMlbRSDXwjwhv8yOEwkXHomUz EOhnf8FmyzCzjBzXnEacLLLfu6c+5Saz5VuJI11paPu8IUUHHbI8A2c2OOjXaunaJ0pNAuWBpzwIjJ nSNOFNj20t+3vJ/urzKa9/Pqyg8zDHFD9qqpqaBtGGoUwjY3m7XrMqpeKtruZlJUoixyAKUCBR2G+E qW868F9IuhZf12kNaRzP9ehAlWXDreKSeD9GCy8U4uy/FxHNU0llHWLXPJlznr6rSrOov5sVsAOh4Q 92NaFx4RN8V24y4Bkgxkr36IkQ+5+x4uVSNvPGIUVme+c2kVGxGFf9Z5IfDxgYkbyPBl64CF3alsB7 9Jcz7EIvyrYTFXKJapKa3vqpUrdC7L1TJrBfC8OGD2a3nk1E/Z73ZX6TKvIDfOwqY+0SP9s+ptf76q F1AL5hiY+SDsmrM8Q1aWF+Z95WVrcbfNJNezm6/hS9xn3IEeeEdiDeugPyFCMHbzxJ4Zu+GXw+rgPB aoYvjD+300H3Q//lbzYWmc3NCxS0rEwy44q2AQ+r+uqoAMcaa3j3YrJdYPCRearUIv1xpNBoeAzUtb Lr7vob6z1IlkP5lAd+cjBvbd9IbQKJNYK/WtqiqjtVs8HzFa6aaYPjxGpRYw==
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

Move the xattr IMA hooks into normal LSM layer. As with SELinux and
Smack, handle calling cap_inode_setxattr() internally.

Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jonathan McDowell <noodles@fb.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Petr Vorel <pvorel@suse.cz>
Cc: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/ima.h                   | 16 ----------------
 security/integrity/ima/ima.h          | 10 ++++++++++
 security/integrity/ima/ima_appraise.c | 19 ++++++++++++++++---
 security/integrity/ima/ima_main.c     |  4 ++++
 security/security.c                   | 10 ++--------
 5 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 3c641cc65270..6dc5143f89f2 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -135,9 +135,6 @@ static inline void ima_post_key_create_or_update(struct key *keyring,
 extern bool is_ima_appraise_enabled(void);
 extern void ima_inode_post_setattr(struct user_namespace *mnt_userns,
 				   struct dentry *dentry);
-extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
-		       const void *xattr_value, size_t xattr_value_len);
-extern int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name);
 #else
 static inline bool is_ima_appraise_enabled(void)
 {
@@ -150,19 +147,6 @@ static inline void ima_inode_post_setattr(struct user_namespace *mnt_userns,
 	return;
 }
 
-static inline int ima_inode_setxattr(struct dentry *dentry,
-				     const char *xattr_name,
-				     const void *xattr_value,
-				     size_t xattr_value_len)
-{
-	return 0;
-}
-
-static inline int ima_inode_removexattr(struct dentry *dentry,
-					const char *xattr_name)
-{
-	return 0;
-}
 #endif /* CONFIG_IMA_APPRAISE */
 
 #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index be965a8715e4..15a369df4c00 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -168,6 +168,16 @@ int __init ima_init_digests(void);
 int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 			  void *lsm_data);
 
+/* LSM hooks */
+#ifdef CONFIG_IMA_APPRAISE
+int ima_inode_setxattr(struct user_namespace *mnt_userns,
+		       struct dentry *dentry, const char *xattr_name,
+		       const void *xattr_value, size_t xattr_value_len,
+		       int flags);
+int ima_inode_removexattr(struct user_namespace *mnt_userns,
+			  struct dentry *dentry, const char *xattr_name);
+#endif
+
 /*
  * used to protect h_table and sha_table
  */
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index bde74fcecee3..ddd9df6b7dac 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -744,8 +744,10 @@ static int validate_hash_algo(struct dentry *dentry,
 	return -EACCES;
 }
 
-int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
-		       const void *xattr_value, size_t xattr_value_len)
+int ima_inode_setxattr(struct user_namespace *mnt_userns,
+		       struct dentry *dentry, const char *xattr_name,
+		       const void *xattr_value, size_t xattr_value_len,
+		       int flags)
 {
 	const struct evm_ima_xattr_data *xvalue = xattr_value;
 	int digsig = 0;
@@ -754,6 +756,11 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 	result = ima_protect_xattr(dentry, xattr_name, xattr_value,
 				   xattr_value_len);
 	if (result == 1) {
+		result = cap_inode_setxattr(dentry, xattr_name, xattr_value,
+					    xattr_value_len, flags);
+		if (result)
+			return result;
+
 		if (!xattr_value_len || (xvalue->type >= IMA_XATTR_LAST))
 			return -EINVAL;
 		digsig = (xvalue->type == EVM_IMA_XATTR_DIGSIG);
@@ -770,11 +777,17 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 	return result;
 }
 
-int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name)
+int ima_inode_removexattr(struct user_namespace *mnt_userns,
+			  struct dentry *dentry, const char *xattr_name)
 {
 	int result;
 
 	result = ima_protect_xattr(dentry, xattr_name, NULL, 0);
+	if (result == 1) {
+		result = cap_inode_removexattr(mnt_userns, dentry, xattr_name);
+		if (result)
+			return result;
+	}
 	if (result == 1 || evm_revalidate_status(xattr_name)) {
 		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
 		if (result == 1)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2cff001b02e4..b3b79d030a67 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1089,6 +1089,10 @@ static struct security_hook_list ima_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_post_read_file, ima_post_read_file),
 	LSM_HOOK_INIT(kernel_load_data, ima_load_data),
 	LSM_HOOK_INIT(kernel_post_load_data, ima_post_load_data),
+#ifdef CONFIG_IMA_APPRAISE
+	LSM_HOOK_INIT(inode_setxattr, ima_inode_setxattr),
+	LSM_HOOK_INIT(inode_removexattr, ima_inode_removexattr),
+#endif
 };
 
 void __init integrity_lsm_ima_init(void)
diff --git a/security/security.c b/security/security.c
index 8f7c1b5fa5fa..ca731132a0e9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1349,7 +1349,7 @@ int security_inode_setxattr(struct user_namespace *mnt_userns,
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
 	/*
-	 * SELinux and Smack integrate the cap call,
+	 * SELinux, Smack, and IMA integrate the cap call,
 	 * so assume that all LSMs supplying this call do so.
 	 */
 	ret = call_int_hook(inode_setxattr, 1, mnt_userns, dentry, name, value,
@@ -1357,9 +1357,6 @@ int security_inode_setxattr(struct user_namespace *mnt_userns,
 
 	if (ret == 1)
 		ret = cap_inode_setxattr(dentry, name, value, size, flags);
-	if (ret)
-		return ret;
-	ret = ima_inode_setxattr(dentry, name, value, size);
 	if (ret)
 		return ret;
 	return evm_inode_setxattr(mnt_userns, dentry, name, value, size);
@@ -1396,15 +1393,12 @@ int security_inode_removexattr(struct user_namespace *mnt_userns,
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
 	/*
-	 * SELinux and Smack integrate the cap call,
+	 * SELinux, Smack, and IMA integrate the cap call,
 	 * so assume that all LSMs supplying this call do so.
 	 */
 	ret = call_int_hook(inode_removexattr, 1, mnt_userns, dentry, name);
 	if (ret == 1)
 		ret = cap_inode_removexattr(mnt_userns, dentry, name);
-	if (ret)
-		return ret;
-	ret = ima_inode_removexattr(dentry, name);
 	if (ret)
 		return ret;
 	return evm_inode_removexattr(mnt_userns, dentry, name);
-- 
2.34.1

