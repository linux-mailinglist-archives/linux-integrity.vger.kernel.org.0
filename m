Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EFF5EC9FE
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Sep 2022 18:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiI0QuV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Sep 2022 12:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiI0Qt5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Sep 2022 12:49:57 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F2C3C8CF
        for <linux-integrity@vger.kernel.org>; Tue, 27 Sep 2022 09:49:54 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w20so9580176ply.12
        for <linux-integrity@vger.kernel.org>; Tue, 27 Sep 2022 09:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mSKd3PtpzAza9oMdVi8/s+oWI/q2zUDumX4CktWslcw=;
        b=b67lqlqGEJd8Urm2MeXENq+KGhE/5CUpM7BMbT/smTMYSu7lydR58E2kNif6HOpNq8
         S2kYfv0oOKzVjUz0qTHkH8QoWaejmPcZd3lLTh+qy8wL38p2RS3V/L1FWFK9LP2rT/TC
         +xzPW8iTnSn9wfhThuZy6xh0XlKiZG50KFfJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mSKd3PtpzAza9oMdVi8/s+oWI/q2zUDumX4CktWslcw=;
        b=fZnC0vmaRwBpdrgo5ysnF8tjQVMON49+RNBfj5pGvFQD4SLNU3mYjfldYXTV1Tt5b2
         qramYEicTH5VsimjoTgnola6d5/Hg5iRTARa1xE5dJ4bNQfFpdpeIhOfknZga5r6J1ht
         HN7MaJ22q0oIQyj5l+WmDpwEAmQE//AuSSEs3nPGYi3Djf7y/iULDUB32zttqYNfdiXF
         hPX1EKfxaG8/fhB5UsHaGbXqmVVebznE5KrosWJ9gqzS+NVI8vPy1Jfabp8vJRdhAZ8g
         Bj9PC1MMzJax/PCki7WqDZR2xeR4z50u+zMw2Wtd27DVCKQ45c94h7pjZeGdC8rPAhsn
         0q+g==
X-Gm-Message-State: ACrzQf26ENRl6CNDU5FD1AVX8pJ4qJ+1gHCWr5ct1flYiBbF3usFR48n
        Byq+82LooBbPLJwFfW5xARzYwg==
X-Google-Smtp-Source: AMsMyM5Eh2ELgV02M25I9a+o2CFMWuGl/k3EK7tPbtFsYwkayUjDMG3z20vbkDbJBLQYaO7cJOTqbQ==
X-Received: by 2002:a17:902:7081:b0:178:6154:9d79 with SMTP id z1-20020a170902708100b0017861549d79mr28726431plk.79.1664297393524;
        Tue, 27 Sep 2022 09:49:53 -0700 (PDT)
Received: from evgreen-glaptop.lan ([73.231.74.141])
        by smtp.gmail.com with ESMTPSA id p13-20020a63950d000000b00434272fe870sm1753509pgd.88.2022.09.27.09.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:49:53 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, apronin@chromium.org,
        dlunev@google.com, jarkko@kernel.org, Pavel Machek <pavel@ucw.cz>,
        Ben Boeckel <me@benboeckel.net>, rjw@rjwysocki.net,
        corbet@lwn.net, linux-pm@vger.kernel.org, zohar@linux.ibm.com,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>, jejb@linux.ibm.com,
        gwendal@chromium.org, Matthew Garrett <mgarrett@aurora.tech>,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Evan Green <evgreen@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH v3 03/11] tpm: Allow PCR 23 to be restricted to kernel-only use
Date:   Tue, 27 Sep 2022 09:49:14 -0700
Message-Id: <20220927094559.v3.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220927164922.3383711-1-evgreen@chromium.org>
References: <20220927164922.3383711-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Link: https://lore.kernel.org/lkml/20210220013255.1083202-3-matthewgarrett@google.com/
Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Evan Green <evgreen@chromium.org>
---

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
index 9c9e5d75b37c78..9f4e64e22807a2 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -246,4 +246,23 @@ void tpm_bios_log_setup(struct tpm_chip *chip);
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
index 69126a6770386e..9c92a3e1e3f463 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -821,3 +821,25 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
 
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
2.31.0

