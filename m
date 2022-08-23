Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE5659EF31
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Aug 2022 00:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiHWW0g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Aug 2022 18:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbiHWW0G (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Aug 2022 18:26:06 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D31883D4
        for <linux-integrity@vger.kernel.org>; Tue, 23 Aug 2022 15:26:01 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id 2so14090352pll.0
        for <linux-integrity@vger.kernel.org>; Tue, 23 Aug 2022 15:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=WIOol7YbT4z3LRgf9Kpb9QMDaKLDbVhOqJugQnw6+ko=;
        b=ZXgKtPx0JfYsDQTu5hMi3HUEndF0L04/qeujoXTgzSgG2Xl7sh33ko8V7cdEjo1nVC
         bYmutAMToTWucYQKv0lOFSPmp+LC1f40+S9h9MjVXXNIGJDEor8aYn+ZEBJpXWEHv/C3
         ZSrQts009grCuGapxCYN89LaAE72xoit+1Y9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WIOol7YbT4z3LRgf9Kpb9QMDaKLDbVhOqJugQnw6+ko=;
        b=P+Fpre4Gq483f6HNr+91Im/4Vn/6yR4QdRr9R+8ed0XQhJRzxVsLkdeeS/VwW9DuEl
         0n13TUylQuUwuFnb8v848+lZWwRZ51bE7VPBCOmbb0PlXlPOoj6I9mWzTD4qmBDRtkPF
         0p1eU4RhwL38GgiZLe2zU51Ys75zdWRaNapdNQOjbBU6GoJnECzL+ka0MD287KumhnF2
         FphzWAuI2wY2Do0uSeEF4ecWhY7GJB7WtIvhvPUF9kVZ7ZibzWRypr/jM31BnKVZUUpB
         e3knxiY4OESgH9eX3lFNTDe0KZkRHwLBYnP1zaewslAzzPNc63WwIRDYC8DKDlUyEMB+
         xozA==
X-Gm-Message-State: ACgBeo1e0sxI6vtBPv8p/AB5Llx+zMTL6qYV+9EMlJhSHoKSd99ECE3J
        2397+H2nnWUmU3nZpAbun8LrLA==
X-Google-Smtp-Source: AA6agR6txvcbCAEYZHTxlQ0dngpEzx0AFF5OSLln0IKFXrEGog3tbioXmlkM1G9kM0VxALwzRGjyOQ==
X-Received: by 2002:a17:902:7602:b0:172:a064:4a2f with SMTP id k2-20020a170902760200b00172a0644a2fmr25874719pll.56.1661293560871;
        Tue, 23 Aug 2022 15:26:00 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.45.66.167])
        by smtp.gmail.com with ESMTPSA id f76-20020a62384f000000b0052f20d70845sm11256292pfa.150.2022.08.23.15.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 15:26:00 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, apronin@chromium.org,
        dlunev@google.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        corbet@lwn.net, jejb@linux.ibm.com,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Evan Green <evgreen@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH v2 02/10] tpm: Allow PCR 23 to be restricted to kernel-only use
Date:   Tue, 23 Aug 2022 15:25:18 -0700
Message-Id: <20220823152108.v2.2.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220823222526.1524851-1-evgreen@chromium.org>
References: <20220823222526.1524851-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes in v2:
 - Fixed sparse warnings

 drivers/char/tpm/Kconfig          | 10 +++++++++
 drivers/char/tpm/tpm-dev-common.c |  8 +++++++
 drivers/char/tpm/tpm.h            | 21 +++++++++++++++++++
 drivers/char/tpm/tpm1-cmd.c       | 35 +++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-cmd.c       | 22 +++++++++++++++++++
 drivers/char/tpm/tpm2-space.c     |  2 +-
 6 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 927088b2c3d3f2..4483b61a428b11 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -211,4 +211,14 @@ config TCG_FTPM_TEE
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
index a80b341d38eb8c..077c3ca0a127ba 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -229,6 +229,8 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
 unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm2_probe(struct tpm_chip *chip);
 int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip);
+int tpm_find_and_validate_cc(struct tpm_chip *chip, struct tpm_space *space,
+			     const void *buf, size_t bufsiz);
 int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
 int tpm2_init_space(struct tpm_space *space, unsigned int buf_size);
 void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
@@ -244,4 +246,23 @@ void tpm_bios_log_setup(struct tpm_chip *chip);
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
index 8ec743dec26544..318e75ae42fb85 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -845,3 +845,38 @@ int tpm1_get_pcr_allocation(struct tpm_chip *chip)
 
 	return 0;
 }
+
+#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
+int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
+{
+	struct tpm_header *header = (struct tpm_header *)buffer;
+	char len, offset;
+	__be32 *pcr;
+	int pos;
+
+	switch (be32_to_cpu(header->ordinal)) {
+	case TPM_ORD_PCR_EXTEND:
+		if (size < (TPM_HEADER_SIZE + sizeof(u32)))
+			return -EINVAL;
+		pcr = (__be32 *)&buffer[TPM_HEADER_SIZE];
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
index 69126a6770386e..dbf7f5552c6782 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -821,3 +821,25 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
 
 	return -1;
 }
+
+#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
+int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
+{
+	int cc = tpm_find_and_validate_cc(chip, NULL, buffer, size);
+	__be32 *handle;
+
+	switch (cc) {
+	case TPM2_CC_PCR_EXTEND:
+	case TPM2_CC_PCR_RESET:
+		if (size < (TPM_HEADER_SIZE + sizeof(u32)))
+			return -EINVAL;
+
+		handle = (__be32 *)&buffer[TPM_HEADER_SIZE];
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

