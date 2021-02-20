Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A8132028D
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Feb 2021 02:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhBTBeb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 20:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhBTBe2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 20:34:28 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8BCC0617AB
        for <linux-integrity@vger.kernel.org>; Fri, 19 Feb 2021 17:33:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id f81so8787627yba.8
        for <linux-integrity@vger.kernel.org>; Fri, 19 Feb 2021 17:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=y0augfXTryPPckNIjyG37nVNdhig6ZbrGk3G+Se0bhk=;
        b=RAnSVHS6Smj0l3LTFE/vx6JcAMiDFRCoCBnWUB8vImivgo1DTitkKgcGHqMjwAJw/O
         txIgPqjTqa5i4y7plNhFKxAOjXZ8FqAPcnC1jxvxhEqDXMk3kcqnC0fP9TLI25gVJUXK
         ddHY50qffEoya6LEsxV2vjOe6YrzC22XhdLQxxrKho7+T0KrN7kp1rjJhsyKoU/cKfYb
         TEn1URRMkGXIyknaMegtLk6tmlOfKyVP5pr7+ftAFXeT0hi4EscWeLB1AHcTBFFNiuzt
         LWSmztlO4C9ylDtqEpai3Jw11CILCmSXimM0qGQkwtnWxlfXul5qzttJBxAyTWmez48Z
         zDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y0augfXTryPPckNIjyG37nVNdhig6ZbrGk3G+Se0bhk=;
        b=DBtjztcd0lnVJ9fIBdrvFvcBaGpiH0iEbJNDtfji+gqqRND8weFvhLSlZZbxojbKGi
         3rRZ88SvZ/zgY8yQVNlEWSWzwP1PCfyxewyAS+0iEA62Cy266R/WSqbdYi20Wq8szcHo
         EYB6N4Rpm1cHonv31pkw8HhAcwHnZgRMuRRxwkwM4uSAprjUkihvbiWaXprngrbpEOUi
         7ll1HUDoqLRLz2cTNU8m092g5widq/Z10V8c/rBS4WfGesgZjVvGMZNl7jA/AISTBEAn
         t6ZHiervU6YclEfyF+OBwd1CbFDO75yHkdiJXh1PPx8rlz28vOOkoqgTtYxOOlu8ivfW
         hqQQ==
X-Gm-Message-State: AOAM531zG49lEXbgeATBoIg2AQjXab8SBQrh9St9xcX/xYf8o9VJpFKp
        xx8yUFjTbs47lUjXNnJm8JQezBzP5pgITB9miDlqwA==
X-Google-Smtp-Source: ABdhPJytRkNN3Yr0iLNpnA3MzM1hsHO7gs7Uv3eNdAOwxj6Y/9Z3hSrHrL2ZuhfAoEO1BriPoncl5gzOqTYtEKVrKpRP2A==
Sender: "matthewgarrett via sendgmr" 
        <matthewgarrett@matthewgarrett-tmp.c.googlers.com>
X-Received: from matthewgarrett-tmp.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1081])
 (user=matthewgarrett job=sendgmr) by 2002:a25:9383:: with SMTP id
 a3mr17879351ybm.215.1613784789563; Fri, 19 Feb 2021 17:33:09 -0800 (PST)
Date:   Sat, 20 Feb 2021 01:32:48 +0000
In-Reply-To: <20210220013255.1083202-1-matthewgarrett@google.com>
Message-Id: <20210220013255.1083202-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20210220013255.1083202-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH 2/9] tpm: Allow PCR 23 to be restricted to kernel-only use
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org, zohar@linux.ibm.com, jejb@linux.ibm.com,
        jarkko@kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

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

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/char/tpm/Kconfig          | 10 +++++++++
 drivers/char/tpm/tpm-dev-common.c |  8 +++++++
 drivers/char/tpm/tpm.h            | 21 +++++++++++++++++++
 drivers/char/tpm/tpm1-cmd.c       | 35 +++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-cmd.c       | 22 +++++++++++++++++++
 drivers/char/tpm/tpm2-space.c     |  2 +-
 6 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index a18c314da211..bba30fb16a2e 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -190,4 +190,14 @@ config TCG_FTPM_TEE
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
index 1784530b8387..d3db4fd76257 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -193,6 +193,14 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
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
index 746f7696bdc0..8eed5016d733 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -232,6 +232,8 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
 unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm2_probe(struct tpm_chip *chip);
 int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip);
+int tpm_find_and_validate_cc(struct tpm_chip *chip, struct tpm_space *space,
+			     const void *buf, size_t bufsiz);
 int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
 int tpm2_init_space(struct tpm_space *space, unsigned int buf_size);
 void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
@@ -245,4 +247,23 @@ void tpm_bios_log_setup(struct tpm_chip *chip);
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
index 36990e9d2dc1..2dab1647d89c 100644
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
index 9609ae8086c6..7dbd4590dee8 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -795,3 +795,25 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
 
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
index 784b8b3cb903..76a993492962 100644
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
2.30.0.617.g56c4b15f3c-goog

