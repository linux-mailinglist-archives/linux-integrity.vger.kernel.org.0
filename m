Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7D6626551
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Nov 2022 00:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbiKKXTn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Nov 2022 18:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbiKKXTl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Nov 2022 18:19:41 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE97A82912
        for <linux-integrity@vger.kernel.org>; Fri, 11 Nov 2022 15:19:39 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id 4so5420346pli.0
        for <linux-integrity@vger.kernel.org>; Fri, 11 Nov 2022 15:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fr3KqrR46I1TnqFXZVSBV9KcBJWHB5lW47NuOMIe6Kk=;
        b=TV4EU4JIzkszLwQNfRm+P5TnhnItkPJOEjY4rAmAajz9txzwm6xt4+NYH2crlM6d97
         0XN8wUcgTzH/Rmc4eYujoWf4Iz2lK+XbxAUKbPTbajP/3f3c+JFqX7hI0SUkOTQQCKNz
         DwkuLEpR4rFKGgke4f4YqBnhJMPZ/H5tKBR4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fr3KqrR46I1TnqFXZVSBV9KcBJWHB5lW47NuOMIe6Kk=;
        b=PvsE+555nxs3jesRdmKVdxLNmpEJKHBEAS7Oy74QE+5HiCwa2UlVjuZZbNDJv6TCS1
         cyQY98UUYmRwSWLCGaUjbc4/hZHrq+1SyGyzwN7dqxZdeYdVEq06X3vTG3Uqo3Otx0vI
         7YsLLsivoCEUGcD0Inf7l+d/E2izLhO/M4u6CNkrr/NjDTJztUBMmzyh2col+MUqgvoz
         1f4tiaB2F5miyZtzmsKPdNwAdkoansQuP0RxlKmqKZOK3KPX3Gv9J7P/p24nYOjttYjg
         8N6H8PaA/6TXdK5pjaMH8hmlpThBXfXoouIpRlK4rjRqBkz+q1G4jibs23EPUbe8C4C7
         ByPQ==
X-Gm-Message-State: ANoB5plSwdnQfrg1Y3+/PI1AKuLNUDK/HboJM9WtRCYqdGg0W6zugOGU
        SM59rbUQx4YOH84m66+Zz7F+Kg==
X-Google-Smtp-Source: AA0mqf7+t7S3vNxBH2mfuS1kAi4QpIdzaJ0IpVcNZ05WpJR5cgfA8ciMrm1rEjyzG+NvDRONRFDvWA==
X-Received: by 2002:a17:902:9894:b0:188:9ae7:bb7d with SMTP id s20-20020a170902989400b001889ae7bb7dmr4568122plp.113.1668208779383;
        Fri, 11 Nov 2022 15:19:39 -0800 (PST)
Received: from evgreen-glaptop.lan ([98.45.28.95])
        by smtp.gmail.com with ESMTPSA id x128-20020a623186000000b0056da2ad6503sm2106900pfx.39.2022.11.11.15.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:19:39 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, jejb@linux.ibm.com,
        Kees Cook <keescook@chromium.org>, dlunev@google.com,
        zohar@linux.ibm.com, Matthew Garrett <mgarrett@aurora.tech>,
        jarkko@kernel.org, linux-pm@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, axelj <axelj@axis.com>
Subject: [PATCH v5 01/11] tpm: Add support for in-kernel resetting of PCRs
Date:   Fri, 11 Nov 2022 15:16:26 -0800
Message-Id: <20221111151451.v5.1.I776854f47e3340cc2913ed4d8ecdd328048b73c3@changeid>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221111231636.3748636-1-evgreen@chromium.org>
References: <20221111231636.3748636-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add an internal command for resetting a PCR. This will be used by the
encrypted hibernation code to set PCR23 to a known value. The
hibernation code will seal the hibernation key with a policy specifying
PCR23 be set to this known value as a mechanism to ensure that the
hibernation key is genuine. But to do this repeatedly, resetting the PCR
is necessary as well.

Link: https://lore.kernel.org/lkml/20210220013255.1083202-2-matthewgarrett@google.com/
Co-developed-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Evan Green <evgreen@chromium.org>

---

Changes in v5:
 - Change to co-developed by Matthew (Kees)

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

