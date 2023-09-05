Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEEE793041
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Sep 2023 22:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243649AbjIEUr2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 Sep 2023 16:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbjIEUr1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Sep 2023 16:47:27 -0400
X-Greylist: delayed 551 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:47:24 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746C0132;
        Tue,  5 Sep 2023 13:47:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AFBC433C8;
        Tue,  5 Sep 2023 20:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693946293;
        bh=ZdKKXxNVL93aojzTyABniVfuVm9QwnA2/7jIrE8SvO8=;
        h=From:Date:Subject:To:Cc:From;
        b=ktbG4NFZfPjXeyrBiFLg2RqCZhqdh6Qq0gXqdIgK+QGq+z0TxWDI5dkc7CZ0dOcu8
         dKZSfWD0ZpAkKvn8qwRjR+mrrEwWmPCnyejA71JGhpM++Ni1EFWeOV2bUHA3cqc0Yd
         rsi/6jzRiyOnLv12AmEIGBHq/feyyuJEWQeMnjIcTppHYw9RtuQfy7GkWgK9+nwFIR
         nzW5B4J5hRAJZVHcZmnFVXV5BHXMyCxhS/v/qR6r5apJMn0ylxM+C+Y4/SqxjKp6it
         hBOGtcU00V6dhocWdCy5p68tQjwVFZZXUwCk1fPtx6OOtudbvGrcVhvIDB2aTxjSYZ
         V3CLFI8n6rWUA==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Tue, 05 Sep 2023 13:36:11 -0700
Subject: [PATCH 5.15] of: kexec: Mark ima_{free,stable}_kexec_buffer() as
 __init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-5-15-of-kexec-modpost-warning-v1-1-4138b2e96b4e@kernel.org>
X-B4-Tracking: v=1; b=H4sIADqR92QC/x3MwQ5EMBAA0F+RORtpMbLrV8ShmDLZbCutIBH/r
 nF8l3dB5CAcoc0uCLxLFO8SdJ7BuBg3M8qUDKUqK/VVhISa0Fv88ckj/v20+rjhYYITN2NjmqH
 +2ErxYCEda2Ar5/t3QIUm6O/7AVpLx191AAAA
To:     gregkh@linuxfoundation.org, sashal@kernel.org
Cc:     stable@vger.kernel.org, robh+dt@kernel.org, frowand.list@gmail.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3423; i=nathan@kernel.org;
 h=from:subject:message-id; bh=ZdKKXxNVL93aojzTyABniVfuVm9QwnA2/7jIrE8SvO8=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDCnfJ265Msdk7j5jmS83suPC+sTj71kINK3/+Hoh043Cm
 d5WLvO0OkpZGMQ4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEfs1h+B9dO/mC1xd9vc4J
 6yOSONlUvweZsRTU9omniz59Z5BjsJyR4c63ZYqR3wyckgod1mR/6Fxl8EtNjWPi0SfbbjsfPWT
 CyQgA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This commit has no direct upstream equivalent.

After commit d48016d74836 ("mm,ima,kexec,of: use memblock_free_late from
ima_free_kexec_buffer") in 5.15, there is a modpost warning for certain
configurations:

  WARNING: modpost: vmlinux.o(.text+0xb14064): Section mismatch in reference from the function ima_free_kexec_buffer() to the function .init.text:__memblock_free_late()
  The function ima_free_kexec_buffer() references
  the function __init __memblock_free_late().
  This is often because ima_free_kexec_buffer lacks a __init
  annotation or the annotation of __memblock_free_late is wrong.

In mainline, there is no issue because ima_free_kexec_buffer() is marked
as __init, which was done as part of commit b69a2afd5afc ("x86/kexec:
Carry forward IMA measurement log on kexec") in 6.0, which is not
suitable for stable.

Mark ima_free_kexec_buffer() and its single caller
ima_load_kexec_buffer() as __init in 5.15, as ima_load_kexec_buffer() is
only called from ima_init(), which is __init, clearing up the warning.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/of/kexec.c                 | 2 +-
 include/linux/of.h                 | 2 +-
 security/integrity/ima/ima.h       | 2 +-
 security/integrity/ima/ima_kexec.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 3a07cc58e7d7..d10fd54415c2 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -165,7 +165,7 @@ int ima_get_kexec_buffer(void **addr, size_t *size)
 /**
  * ima_free_kexec_buffer - free memory used by the IMA buffer
  */
-int ima_free_kexec_buffer(void)
+int __init ima_free_kexec_buffer(void)
 {
 	int ret;
 	unsigned long addr;
diff --git a/include/linux/of.h b/include/linux/of.h
index 140671cb746a..6f15e8b0f9d1 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -574,7 +574,7 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 				   unsigned long initrd_len,
 				   const char *cmdline, size_t extra_fdt_size);
 int ima_get_kexec_buffer(void **addr, size_t *size);
-int ima_free_kexec_buffer(void);
+int __init ima_free_kexec_buffer(void);
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index be965a8715e4..0afe413dda68 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -122,7 +122,7 @@ struct ima_kexec_hdr {
 extern const int read_idmap[];
 
 #ifdef CONFIG_HAVE_IMA_KEXEC
-void ima_load_kexec_buffer(void);
+void __init ima_load_kexec_buffer(void);
 #else
 static inline void ima_load_kexec_buffer(void) {}
 #endif /* CONFIG_HAVE_IMA_KEXEC */
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index f799cc278a9a..f3b10851bbbf 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -137,7 +137,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 /*
  * Restore the measurement list from the previous kernel.
  */
-void ima_load_kexec_buffer(void)
+void __init ima_load_kexec_buffer(void)
 {
 	void *kexec_buffer = NULL;
 	size_t kexec_buffer_size = 0;

---
base-commit: 8f790700c974345ab78054e109beddd84539f319
change-id: 20230905-5-15-of-kexec-modpost-warning-6a6b48f30ebf

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

