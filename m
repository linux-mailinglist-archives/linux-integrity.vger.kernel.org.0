Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B968D648640
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Dec 2022 17:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiLIQJX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Dec 2022 11:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIQJV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Dec 2022 11:09:21 -0500
X-Greylist: delayed 67 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Dec 2022 08:09:18 PST
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4155D6277;
        Fri,  9 Dec 2022 08:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1670602157;
        bh=SACuZ9qQZKFkIBEj5nHX9mpXGYN9nESZN0qGMbrT3zI=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=WAI0Q4XJqH6gwOseZhyBSYync/4JuGdOsZ4hZ3bsx8Jm+3MTeuIhOfz2kpzeMbtZm
         MtuV3Dn4sQpmxnMhgBuSVNBSoU/FQ68VAFAcx1sBmdgKIqID9lSbRuuCKR70rbRc7r
         QQwiPm89d3Ra6aPsDQDbyT7ClUFSsMs9b5Is4+og=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id F0B691281045;
        Fri,  9 Dec 2022 11:09:17 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AGWXrmwOh_sM; Fri,  9 Dec 2022 11:09:17 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6555112803C0;
        Fri,  9 Dec 2022 11:09:17 -0500 (EST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org
Subject: [PATCH 05/11] tpm: export the context save and load commands
Date:   Fri,  9 Dec 2022 11:06:05 -0500
Message-Id: <20221209160611.30207-6-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221209160611.30207-1-James.Bottomley@HansenPartnership.com>
References: <20221209160611.30207-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The TPM2 session HMAC and encryption handling code needs to save and
restore a single volatile context for the elliptic curve version of
the NULL seed, so export the APIs which do this for internal use.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm.h        | 4 ++++
 drivers/char/tpm/tpm2-space.c | 8 ++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 24ee4e1cc452..a5fe37977103 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -237,6 +237,10 @@ int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space, void *buf,
 		      size_t *bufsiz);
 int tpm_devs_add(struct tpm_chip *chip);
 void tpm_devs_remove(struct tpm_chip *chip);
+int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
+		      unsigned int buf_size, unsigned int *offset);
+int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
+		      unsigned int *offset, u32 *handle);
 
 void tpm_bios_log_setup(struct tpm_chip *chip);
 void tpm_bios_log_teardown(struct tpm_chip *chip);
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index ffb35f0154c1..d77ee4af9d65 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -68,8 +68,8 @@ void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
 	kfree(space->session_buf);
 }
 
-static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
-			     unsigned int *offset, u32 *handle)
+int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
+		      unsigned int *offset, u32 *handle)
 {
 	struct tpm_buf tbuf;
 	struct tpm2_context *ctx;
@@ -119,8 +119,8 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 	return 0;
 }
 
-static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
-			     unsigned int buf_size, unsigned int *offset)
+int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
+		      unsigned int buf_size, unsigned int *offset)
 {
 	struct tpm_buf tbuf;
 	unsigned int body_size;
-- 
2.35.3

