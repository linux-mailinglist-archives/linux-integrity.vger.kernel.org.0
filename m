Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74FC626558
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Nov 2022 00:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiKKXTy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Nov 2022 18:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbiKKXTp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Nov 2022 18:19:45 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AD27BE42
        for <linux-integrity@vger.kernel.org>; Fri, 11 Nov 2022 15:19:44 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id g62so6080440pfb.10
        for <linux-integrity@vger.kernel.org>; Fri, 11 Nov 2022 15:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWKuj/eVGsjPGfeZMJPQpDngtMSO4dbOJNBV15jTv7M=;
        b=DG5hhRv0qxpc7vpB6DKVxAhYG849dFoxC467fVtkgj9mQ+rEHe+uxo7VDd5tqqgZ4B
         syFdacQkQxC7N0D+1/2pJVqQtIVQ3QUgQDLUjhIw2Gb4aOCjP3+C7voHAKPTHl2tVovY
         3sclybeIlhlxTczEC23A8WU+cHFp2XaGHWAro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWKuj/eVGsjPGfeZMJPQpDngtMSO4dbOJNBV15jTv7M=;
        b=rbSqZLeZuNRNRwkPXPKuCQkOrJc5USsGoXtOTynrFOZBRJm5rFFaxWBkXLT6qpDuz3
         rkIloGssk5QnCFltPcRz6dKxmWkh0GDJhKDTv5XRUykM69zMwryJD0Chok4JrYW3H1j2
         wqnBNd2DBNrhlvIvUGf0FwIXTHqdyJGOBzz8xxcg8EkmLvFOjRKoee4krlh3ucGWaX8D
         7d7s3kvaol7HmsRBk99gU8B0JPnW6hT4P/uWAPDkXd1pgBK0MNq4KfoYOF0EP41MCyly
         6RshacMC2/F7YkdkfTWOCnrmT0Og3AV4eHcmfvADSvx7OfS+5gIKOo/CEX33vK9Vqhaa
         5o9w==
X-Gm-Message-State: ANoB5pl5a6HN8w0iyjWg/DmbcKl49PH/dPusAHJtZhpXwLCjPHQYyYHN
        sVaakIgd/KxvzE2Lug/UPJp4DA==
X-Google-Smtp-Source: AA0mqf4apev+7yemozCqhWY2HYZ232GudZiX3kIrKOTN5nVHHyyj9U9lRgP09L/K5/0G3oTIvRNplA==
X-Received: by 2002:a63:ce56:0:b0:457:e41:c767 with SMTP id r22-20020a63ce56000000b004570e41c767mr3478159pgi.244.1668208783934;
        Fri, 11 Nov 2022 15:19:43 -0800 (PST)
Received: from evgreen-glaptop.lan ([98.45.28.95])
        by smtp.gmail.com with ESMTPSA id x128-20020a623186000000b0056da2ad6503sm2106900pfx.39.2022.11.11.15.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:19:43 -0800 (PST)
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
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH v5 03/11] tpm: Allow PCR 23 to be restricted to kernel-only use
Date:   Fri, 11 Nov 2022 15:16:28 -0800
Message-Id: <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
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
Co-developed-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Evan Green <evgreen@chromium.org>

---

Changes in v5:
 - Change tags on RESTRICT_PCR patch (Kees)
 - Rename to TCG_TPM2_RESTRICT_PCR
 - Do nothing on TPM1.2 devices (Jarkko, Doug)

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
 drivers/char/tpm/tpm-dev-common.c |  6 ++++++
 drivers/char/tpm/tpm.h            | 12 ++++++++++++
 drivers/char/tpm/tpm2-cmd.c       | 22 ++++++++++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 927088b2c3d3f2..e6d3aa9f6c694f 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -211,4 +211,16 @@ config TCG_FTPM_TEE
 	  This driver proxies for firmware TPM running in TEE.
 
 source "drivers/char/tpm/st33zp24/Kconfig"
+
+config TCG_TPM2_RESTRICT_PCR
+	bool "Restrict userland access to PCR 23 on TPM2 devices"
+	depends on TCG_TPM
+	help
+	  If set, block userland from extending or resetting PCR 23 on TPM2.0
+	  and later systems. This allows the PCR to be restricted to in-kernel
+	  use, preventing userland from being able to make use of data sealed to
+	  the TPM by the kernel. This is required for secure hibernation
+	  support, but should be left disabled if any userland may require
+	  access to PCR23. This is a TPM2-only feature, enabling this on a TPM1
+	  machine is effectively a no-op.
 endif # TCG_TPM
diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index dc4c0a0a512903..66d15a2a967443 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -198,6 +198,12 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	priv->response_read = false;
 	*off = 0;
 
+	if (priv->chip->flags & TPM_CHIP_FLAG_TPM2) {
+		ret = tpm2_cmd_restricted(priv->chip, priv->data_buffer, size);
+		if (ret)
+			goto out;
+	}
+
 	/*
 	 * If in nonblocking mode schedule an async job to send
 	 * the command return the size.
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index f1e0f490176f01..7fb746d210f59d 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -245,4 +245,16 @@ void tpm_bios_log_setup(struct tpm_chip *chip);
 void tpm_bios_log_teardown(struct tpm_chip *chip);
 int tpm_dev_common_init(void);
 void tpm_dev_common_exit(void);
+
+#ifdef CONFIG_TCG_TPM2_RESTRICT_PCR
+#define TPM_RESTRICTED_PCR 23
+
+int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size);
+#else
+static inline int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer,
+				      size_t size)
+{
+	return 0;
+}
+#endif
 #endif
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 303ce2ea02a4b0..3bc5546fddc792 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -778,3 +778,25 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
 
 	return -1;
 }
+
+#ifdef CONFIG_TCG_TPM2_RESTRICT_PCR
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

