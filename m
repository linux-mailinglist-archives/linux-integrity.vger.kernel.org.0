Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5956186E3
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 19:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiKCSEO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 14:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiKCSD7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 14:03:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DA822B12
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 11:01:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so2536761pjl.3
        for <linux-integrity@vger.kernel.org>; Thu, 03 Nov 2022 11:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lM9Z5v7Eu604CuNLTlsjSA95eezHukKIbUcTBhCY+mI=;
        b=CvFb2x1b3z+i8giCOFLIxOTr2h/EG7j7EOr7ZFJmGhsDpF8OGa6M8BuPcydgaJdIwN
         A12osLRgjAjuT+xh6XMrP3FqWCEwBgabYCyexK4WkbweBlnA/aMbv771mWFp8ujR+YLR
         SFcZhIMdAV5+Bbt+pF9eqILuLuAuvFSKVHTc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lM9Z5v7Eu604CuNLTlsjSA95eezHukKIbUcTBhCY+mI=;
        b=ocn6+VFMsFYErxada2g3jnio8bg4jErukVUKN7ht41l/KlHDdMS0DEKiswyOJNLn1A
         9BS2DgS+ZFo7We2nJPDFpF5P4EvYUSHUwogD08AhCMCafXdHdJ1hJQPsJx8H+TH3RBuW
         FTbcXQvQpD9hNYF4b37oeYdx/rustyiEpezvfmvK7JahRk2bijt8/gZumHlY0jWnf1d8
         /NYUg4Js6+Q7wFzH7RsFIdcNS/yTk9IUNH4U1z4J3Fhw6m/8Ss8dblUMgvj8ITZFaRhX
         MU2nWNQSDF+bpSY3Opaj3hwK8aO2luBoib6DHu1L1I5OLl+JXRPKl2g0Ty/8E5ojxjr1
         PpAg==
X-Gm-Message-State: ACrzQf3UDTV6sygVaIoeshfx9IoDCp7U4iQ+/ZByUU7qfv1hxH0zq1Cv
        3AYzwPxHXXk7e6XlyrYv0qlgKA==
X-Google-Smtp-Source: AMsMyM4BFtMIHZPkyPImjndEgL8twoWmXUd1CLFYolLyArfMGqdQQ5DZVSgLhAeK40Pvt2w0iVF0AA==
X-Received: by 2002:a17:90b:1918:b0:213:d97c:c6c9 with SMTP id mp24-20020a17090b191800b00213d97cc6c9mr24352877pjb.198.1667498498208;
        Thu, 03 Nov 2022 11:01:38 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.45.28.95])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709027fcc00b00177fb862a87sm1000277plb.20.2022.11.03.11.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:01:37 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        gwendal@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Evan Green <evgreen@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, axelj <axelj@axis.com>
Subject: [PATCH v4 01/11] tpm: Add support for in-kernel resetting of PCRs
Date:   Thu,  3 Nov 2022 11:01:09 -0700
Message-Id: <20221103105558.v4.1.I776854f47e3340cc2913ed4d8ecdd328048b73c3@changeid>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103180120.752659-1-evgreen@chromium.org>
References: <20221103180120.752659-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Matthew Garrett <matthewgarrett@google.com>

Add an internal command for resetting a PCR. This will be used by the
encrypted hibernation code to set PCR23 to a known value. The
hibernation code will seal the hibernation key with a policy specifying
PCR23 be set to this known value as a mechanism to ensure that the
hibernation key is genuine. But to do this repeatedly, resetting the PCR
is necessary as well.

Link: https://lore.kernel.org/lkml/20210220013255.1083202-2-matthewgarrett@google.com/
Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v4:
 - Open code tpm2_pcr_reset implementation in tpm-interface.c (Jarkko)
 - Rename interface symbol to tpm2_pcr_reset, fix kerneldocs (Jarkko)

Changes in v3:
 - Unify tpm1/2_pcr_reset prototypes (Jarkko)
 - Wait no, remove the TPM1 stuff altogether (Jarkko)
 - Remove extra From tag and blank in commit msg (Jarkko).

 drivers/char/tpm/tpm-interface.c | 47 ++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-cmd.c      |  7 -----
 include/linux/tpm.h              | 14 ++++++++++
 3 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1621ce8187052c..886277b2654e3b 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -342,6 +342,53 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 }
 EXPORT_SYMBOL_GPL(tpm_pcr_extend);
 
+/**
+ * tpm2_pcr_reset - Reset the specified PCR
+ * @chip: A &struct tpm_chip instance, %NULL for the default chip
+ * @pcr_idx: The PCR to be reset
+ *
+ * Return: Same as with tpm_transmit_cmd(), or ENOTTY for TPM1 devices.
+ */
+int tpm2_pcr_reset(struct tpm_chip *chip, u32 pcr_idx)
+{
+	struct tpm2_null_auth_area auth_area;
+	struct tpm_buf buf;
+	int rc;
+
+	chip = tpm_find_get_ops(chip);
+	if (!chip)
+		return -ENODEV;
+
+	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
+		rc = -ENOTTY;
+		goto out;
+	}
+
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_RESET);
+	if (rc)
+		goto out;
+
+	tpm_buf_append_u32(&buf, pcr_idx);
+
+	auth_area.handle = cpu_to_be32(TPM2_RS_PW);
+	auth_area.nonce_size = 0;
+	auth_area.attributes = 0;
+	auth_area.auth_size = 0;
+
+	tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));
+	tpm_buf_append(&buf, (const unsigned char *)&auth_area,
+		       sizeof(auth_area));
+
+	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to reset a PCR");
+
+	tpm_buf_destroy(&buf);
+
+out:
+	tpm_put_ops(chip);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(tpm2_pcr_reset);
+
 /**
  * tpm_send - send a TPM command
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 65d03867e114c5..303ce2ea02a4b0 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -216,13 +216,6 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 	return rc;
 }
 
-struct tpm2_null_auth_area {
-	__be32  handle;
-	__be16  nonce_size;
-	u8  attributes;
-	__be16  auth_size;
-} __packed;
-
 /**
  * tpm2_pcr_extend() - extend a PCR value
  *
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index dfeb25a0362dee..70134e6551745f 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -219,6 +219,7 @@ enum tpm2_command_codes {
 	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
 	TPM2_CC_HIERARCHY_CHANGE_AUTH   = 0x0129,
 	TPM2_CC_CREATE_PRIMARY          = 0x0131,
+	TPM2_CC_PCR_RESET		= 0x013D,
 	TPM2_CC_SEQUENCE_COMPLETE       = 0x013E,
 	TPM2_CC_SELF_TEST	        = 0x0143,
 	TPM2_CC_STARTUP		        = 0x0144,
@@ -293,6 +294,13 @@ struct tpm_header {
 	};
 } __packed;
 
+struct tpm2_null_auth_area {
+	__be32  handle;
+	__be16  nonce_size;
+	u8  attributes;
+	__be16  auth_size;
+} __packed;
+
 /* A string buffer type for constructing TPM commands. This is based on the
  * ideas of string buffer code in security/keys/trusted.h but is heap based
  * in order to keep the stack usage minimal.
@@ -423,6 +431,7 @@ extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
 				size_t min_rsp_body_length, const char *desc);
 extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 			struct tpm_digest *digest);
+extern int tpm2_pcr_reset(struct tpm_chip *chip, u32 pcr_idx);
 extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			  struct tpm_digest *digests);
 extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
@@ -440,6 +449,11 @@ static inline int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx,
 	return -ENODEV;
 }
 
+static inline int tpm2_pcr_reset(struct tpm_chip *chip, int pcr_idx)
+{
+	return -ENODEV;
+}
+
 static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 				 struct tpm_digest *digests)
 {
-- 
2.38.1.431.g37b22c650d-goog

