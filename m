Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1180B6186E9
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 19:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiKCSEs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 14:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiKCSEE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 14:04:04 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710EF233AD
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 11:01:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so1137828pjs.4
        for <linux-integrity@vger.kernel.org>; Thu, 03 Nov 2022 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgNHjxBxYUWB/PCbKrlrwrwc9VDJqlW54PKdqCwW8ic=;
        b=AStpaMSzeObtZoItnIgikawKuuo5Qq71b1rLR3rkcbld1k90YwIpcDKtGID+9H3Wxv
         mIkg68yA2nOb1F042C3Gf6qWKKYczZzj0+RfL1qnS2jhStKdZN/l3jY/d76fv4Jv5xT+
         2oHWymVaZW0NMQTpKgdvsa1VfM2CLlGnYdLxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgNHjxBxYUWB/PCbKrlrwrwc9VDJqlW54PKdqCwW8ic=;
        b=mSWx7tU4wfcBUW24b0Z5jowsgiSNxt1qFW+FFAu2ac/AnBUWTJ7fqUEWV/IaPO2NyS
         4Lutcg0nBbo4f9T5N63weZjEmrdF1pkrgWCTovQ+0cZvzLePdTtH3i7reIWmqcjAttke
         w9uOLbjF6kcBJcv3H4Soou3hsa2WJktNrIHIkdA7yBFDY93V3YSmt2OuOTY1vyRaWXrq
         WPOxzz785i3LfAzlW9bFgjaNABFcw68sH/Vzy6NW/F+5t9rndL6Lo94X7Z6BuSgZTKTI
         yU8RVKSD8piZhUUHTuaIx44Qa9s5JwUXQax7aDezKN8AQGOXtFWmRBRXssPX91h7p+zF
         VXIA==
X-Gm-Message-State: ACrzQf12oGl2UtiJMhEB/q3y0PVWtT3TbLg52tivp23vSVm+YiqLigjf
        JQSvo5Di19j2V5akSOAhQJs1VQ==
X-Google-Smtp-Source: AMsMyM7klMwRzFRi1wf5io00iXyMCbSIKPI7ThN1LZsPqMDPIRHMOxaEDuixIyR7R/CPv5Fs/C86zA==
X-Received: by 2002:a17:902:8e84:b0:178:57e4:805b with SMTP id bg4-20020a1709028e8400b0017857e4805bmr31426128plb.144.1667498502037;
        Thu, 03 Nov 2022 11:01:42 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.45.28.95])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709027fcc00b00177fb862a87sm1000277plb.20.2022.11.03.11.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:01:41 -0700 (PDT)
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
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH v4 03/11] tpm: Allow PCR 23 to be restricted to kernel-only use
Date:   Thu,  3 Nov 2022 11:01:11 -0700
Message-Id: <20221103105558.v4.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
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

Introduce a new Kconfig, TCG_TPM_RESTRICT_PCR, which if enabled
restricts usermode's ability to extend or reset PCR 23.

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

This Kconfig is only properly supported for systems with TPM2 devices.
For systems with TPM1 devices, having this Kconfig enabled completely
restricts usermode's access to the TPM. TPM1 contains support for
tunnelled transports, which usermode could use to smuggle commands
through that this Kconfig is attempting to restrict.

Link: https://lore.kernel.org/lkml/20210220013255.1083202-3-matthewgarrett@google.com/
Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v4:
 - Augment the commit message (Jarkko)

Changes in v3:
 - Fix up commit message (Jarkko)
 - tpm2_find_and_validate_cc() was split (Jarkko)
 - Simply fully restrict TPM1 since v2 failed to account for tunnelled
   transport sessions (Stefan and Jarkko).

Changes in v2:
 - Fixed sparse warnings

 drivers/char/tpm/Kconfig          | 12 ++++++++++++
 drivers/char/tpm/tpm-dev-common.c |  8 ++++++++
 drivers/char/tpm/tpm.h            | 19 +++++++++++++++++++
 drivers/char/tpm/tpm1-cmd.c       | 13 +++++++++++++
 drivers/char/tpm/tpm2-cmd.c       | 22 ++++++++++++++++++++++
 5 files changed, 74 insertions(+)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 927088b2c3d3f2..c8ed54c66e399a 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -211,4 +211,16 @@ config TCG_FTPM_TEE
 	  This driver proxies for firmware TPM running in TEE.
 
 source "drivers/char/tpm/st33zp24/Kconfig"
+
+config TCG_TPM_RESTRICT_PCR
+	bool "Restrict userland access to PCR 23"
+	depends on TCG_TPM
+	help
+	  If set, block userland from extending or resetting PCR 23. This allows it
+	  to be restricted to in-kernel use, preventing userland from being able to
+	  make use of data sealed to the TPM by the kernel. This is required for
+	  secure hibernation support, but should be left disabled if any userland
+	  may require access to PCR23. This is a TPM2-only feature, and if enabled
+	  on a TPM1 machine will cause all usermode TPM commands to return EPERM due
+	  to the complications introduced by tunnelled sessions in TPM1.2.
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
index f1e0f490176f01..c0845e3f9eda17 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -245,4 +245,23 @@ void tpm_bios_log_setup(struct tpm_chip *chip);
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
index cf64c738510529..1869e89215fcb9 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -811,3 +811,16 @@ int tpm1_get_pcr_allocation(struct tpm_chip *chip)
 
 	return 0;
 }
+
+#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
+int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
+{
+	/*
+	 * Restrict all usermode commands on TPM1.2. Ideally we'd just restrict
+	 * TPM_ORD_PCR_EXTEND and TPM_ORD_PCR_RESET, but TPM1.2 also supports
+	 * tunnelled transport sessions where the kernel would be unable to filter
+	 * commands.
+	 */
+	return -EPERM;
+}
+#endif
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 303ce2ea02a4b0..e0503cfd7bcfee 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -778,3 +778,25 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
 
 	return -1;
 }
+
+#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
+int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
+{
+	int cc = tpm2_find_and_validate_cc(chip, NULL, buffer, size);
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
-- 
2.38.1.431.g37b22c650d-goog

