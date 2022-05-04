Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4718551B462
	for <lists+linux-integrity@lfdr.de>; Thu,  5 May 2022 02:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbiEEAB3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 May 2022 20:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353758AbiEDXZG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 May 2022 19:25:06 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2345B4EA17
        for <linux-integrity@vger.kernel.org>; Wed,  4 May 2022 16:21:28 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id k1so2831248pll.4
        for <linux-integrity@vger.kernel.org>; Wed, 04 May 2022 16:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/bX1FiUp+UXF1R/ucItf2yovaC0Dr0ZWprZl8Gow/hg=;
        b=H7uAXX+8UrTfaoj6jJ4T4S903eK2xrBpejUgd0XcPHClwajSPh1J/aWR8AmCKonyFI
         x93TZEM+VSClZmLfJXVeXdyVNxQ8muYN5L0iS6NMu5DPns3E41vI4Ca/Ksc19s3InH8P
         bDO8idk93HMu83Hg0e7DlJoFJqDrRRbelN/SM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/bX1FiUp+UXF1R/ucItf2yovaC0Dr0ZWprZl8Gow/hg=;
        b=TDvO5XmzofWqFzIv5ROPFPCWhNYUNnhhvHdfgx0616uKWWA9MfjcZ82c8YSKhTTRzv
         0+/HDigNm9iQXZIxKyPu6NVL/cL8HjjKmmF7wkmRfTkcWv0FxZMGKQH2avPBmnAQGHIk
         rQWWKY+/5DuiLfeGYS39zr/BUzVZrs/vFZgjzv+YJGKhdJkEv/49jCbTBg/f4ol6nU/3
         qeTtrYkrvlQsCwKq3GQqFZAxt3i2VvxszpgYkr5TNlp7WTsX0/JRtD8zN1BPgGw2gVPW
         4RZ8x46WN3aojkAECBXyXoHkQR1w/uKt+T0zUAj0xSamEUz5VKSATzZjYv4FJSSIKbAw
         F9xw==
X-Gm-Message-State: AOAM532i+qTtSjbbU9rlz96GTOvECxyoqPYY6M2YTLM4crqv525uvuzb
        VgPPgkDI7CGrU3qatGlLp+yVqg==
X-Google-Smtp-Source: ABdhPJzIljgYByrncIBlTw4znRoTwmkRze5mnuoJstLv4PglGih2PJvq68h2B/pV3ziLv6dbJjADpw==
X-Received: by 2002:a17:90b:4b4c:b0:1dc:4c07:aa63 with SMTP id mi12-20020a17090b4b4c00b001dc4c07aa63mr2329251pjb.237.1651706487656;
        Wed, 04 May 2022 16:21:27 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.47.98.87])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902f78c00b0015e8d4eb2d6sm1901pln.288.2022.05.04.16.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 16:21:27 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Garrett <mgarrett@aurora.tech>, dlunev@google.com,
        zohar@linux.ibm.com, jejb@linux.ibm.com,
        linux-integrity@vger.kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        gwendal@chromium.org, jarkko@kernel.org, linux-pm@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Evan Green <evgreen@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH 02/10] tpm: Allow PCR 23 to be restricted to kernel-only use
Date:   Wed,  4 May 2022 16:20:54 -0700
Message-Id: <20220504161439.2.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220504232102.469959-1-evgreen@chromium.org>
References: <20220504232102.469959-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Matthew Garrett <matthewgarrett@google.com>

Under certain circumstances it might be desirable to enable the creation
of TPM-backed secrets that are only accessible to the kernel. In an
ideal world this could be achieved by using TPM localities, but these
don't appear to be available on consumer systems. An alternative is to
simply block userland from modifying one of the resettable PCRs, leaving
it available to the kernel. If the kernel ensures that no userland can
access the TPM while it is carrying out work, it can reset PCR 23,
extend it to an arbitrary value, create or load a secret, and then reset
the PCR again. Even if userland somehow obtains the sealed material, it
will be unable to unseal it since PCR 23 will never be in the
appropriate state.

From: Matthew Garrett <mjg59@google.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>

Signed-off-by: Evan Green <evgreen@chromium.org>
---
Matthew's original version of this patch is at:
https://patchwork.kernel.org/patch/12096491/

 drivers/char/tpm/Kconfig          | 10 +++++++++
 drivers/char/tpm/tpm-dev-common.c |  8 +++++++
 drivers/char/tpm/tpm.h            | 21 +++++++++++++++++++
 drivers/char/tpm/tpm1-cmd.c       | 35 +++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-cmd.c       | 22 +++++++++++++++++++
 drivers/char/tpm/tpm2-space.c     |  2 +-
 6 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 4a5516406c22ed..627d636de327bd 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -199,4 +199,14 @@ config TCG_FTPM_TEE
 	  This driver proxies for firmware TPM running in TEE.
 
 source "drivers/char/tpm/st33zp24/Kconfig"
+
+config TCG_TPM_RESTRICT_PCR
+	bool "Restrict userland access to PCR 23"
+	depends on TCG_TPM
+	help
+	  If set, block userland from extending or resetting PCR 23. This
+	  allows it to be restricted to in-kernel use, preventing userland
+	  from being able to make use of data sealed to the TPM by the kernel.
+	  This is required for secure hibernation support, but should be left
+	  disabled if any userland may require access to PCR23.
 endif # TCG_TPM
diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index dc4c0a0a512903..7a4e618c7d1942 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -198,6 +198,14 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	priv->response_read = false;
 	*off = 0;
 
+	if (priv->chip->flags & TPM_CHIP_FLAG_TPM2)
+		ret = tpm2_cmd_restricted(priv->chip, priv->data_buffer, size);
+	else
+		ret = tpm1_cmd_restricted(priv->chip, priv->data_buffer, size);
+
+	if (ret)
+		goto out;
+
 	/*
 	 * If in nonblocking mode schedule an async job to send
 	 * the command return the size.
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 72b6c0873852c6..a2131311fa5447 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -228,6 +228,8 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
 unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm2_probe(struct tpm_chip *chip);
 int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip);
+int tpm_find_and_validate_cc(struct tpm_chip *chip, struct tpm_space *space,
+			     const void *buf, size_t bufsiz);
 int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
 int tpm2_init_space(struct tpm_space *space, unsigned int buf_size);
 void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
@@ -243,4 +245,23 @@ void tpm_bios_log_setup(struct tpm_chip *chip);
 void tpm_bios_log_teardown(struct tpm_chip *chip);
 int tpm_dev_common_init(void);
 void tpm_dev_common_exit(void);
+
+#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
+#define TPM_RESTRICTED_PCR 23
+
+int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size);
+int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size);
+#else
+static inline int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer,
+				      size_t size)
+{
+	return 0;
+}
+
+static inline int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer,
+				      size_t size)
+{
+	return 0;
+}
+#endif
 #endif
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 9b9ad1fc20ccfd..d404f4092eec8b 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -840,3 +840,38 @@ int tpm1_get_pcr_allocation(struct tpm_chip *chip)
 
 	return 0;
 }
+
+#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
+int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
+{
+	struct tpm_header *header = (struct tpm_header *)buffer;
+	char len, offset;
+	u32 *pcr;
+	int pos;
+
+	switch (be32_to_cpu(header->ordinal)) {
+	case TPM_ORD_PCR_EXTEND:
+		if (size < (TPM_HEADER_SIZE + sizeof(u32)))
+			return -EINVAL;
+		pcr = (u32 *)&buffer[TPM_HEADER_SIZE];
+		if (be32_to_cpu(*pcr) == TPM_RESTRICTED_PCR)
+			return -EPERM;
+		break;
+	case TPM_ORD_PCR_RESET:
+		if (size < (TPM_HEADER_SIZE + 1))
+			return -EINVAL;
+		len = buffer[TPM_HEADER_SIZE];
+		if (size < (TPM_HEADER_SIZE + 1 + len))
+			return -EINVAL;
+		offset = TPM_RESTRICTED_PCR/3;
+		if (len < offset)
+			break;
+		pos = TPM_HEADER_SIZE + 1 + offset;
+		if (buffer[pos] & (1 << (TPM_RESTRICTED_PCR - 2 * offset)))
+			return -EPERM;
+		break;
+	}
+
+	return 0;
+}
+#endif
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index c0806b4447c8b2..439e26336923df 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -802,3 +802,25 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
 
 	return -1;
 }
+
+#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
+int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
+{
+	int cc = tpm_find_and_validate_cc(chip, NULL, buffer, size);
+	u32 *handle;
+
+	switch (cc) {
+	case TPM2_CC_PCR_EXTEND:
+	case TPM2_CC_PCR_RESET:
+		if (size < (TPM_HEADER_SIZE + sizeof(u32)))
+			return -EINVAL;
+
+		handle = (u32 *)&buffer[TPM_HEADER_SIZE];
+		if (be32_to_cpu(*handle) == TPM_RESTRICTED_PCR)
+			return -EPERM;
+		break;
+	}
+
+	return 0;
+}
+#endif
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index ffb35f0154c16c..6f51cd92c6400f 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -262,7 +262,7 @@ static int tpm2_map_command(struct tpm_chip *chip, u32 cc, u8 *cmd)
 	return 0;
 }
 
-static int tpm_find_and_validate_cc(struct tpm_chip *chip,
+int tpm_find_and_validate_cc(struct tpm_chip *chip,
 				    struct tpm_space *space,
 				    const void *cmd, size_t len)
 {
-- 
2.31.0

