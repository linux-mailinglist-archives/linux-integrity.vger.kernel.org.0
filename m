Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B1C3B26DA
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jun 2021 07:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhFXFgA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Jun 2021 01:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhFXFf7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Jun 2021 01:35:59 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6A3C061574
        for <linux-integrity@vger.kernel.org>; Wed, 23 Jun 2021 22:33:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bv7-20020a17090af187b029016fb18e04cfso4861752pjb.0
        for <linux-integrity@vger.kernel.org>; Wed, 23 Jun 2021 22:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=raGw3kZahHl5zULQLMGCrBiBWW0SZU+L/01w6sUK4HU=;
        b=FPtfc/fRV7vLKWLNKeN2b4NZAZ8yNNDg1QoEL4z9Ad8a1GPRKve/ahMhid5eYhTBNw
         AWF6+8EHHsuGcIDxTPSnyf1u9HgNDcFtBaX5cHjNxjmSsi8K0Zr9+oKN8PaqVta94I5l
         EaVr5oASmYjtDIvn9aK4NGx7alj/11CBRraMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=raGw3kZahHl5zULQLMGCrBiBWW0SZU+L/01w6sUK4HU=;
        b=nJy9gn4js2DedS8ZAwht/h3wgLWCqhQGtG0KdMAeVOLmfhIZNuSD8SDJJCrYayi2Do
         pc11HFU8qzDXoSaiYpEpklvT34AJW7kJlQp9cdwUW+YUucygPlknkPTHsDiczS61dZuB
         jL/lF9DLYw6gX1AruOhStYVQVE5eErtw9A/x8UpJvL0m8aLPpi+3XQ3D97qrECvlc6az
         3diDBX1ZwU2cbP4C2yfd2OGK0YmwoWORrfSYNOieYvtR40waeRXmiAIoFnr0luD7my/Z
         bFjA/k/uWVrJtXi1FRwkJzxkLkYQYFtU0pz8DEhHAusiJFKLbBF40J82+q4ziocDHyyx
         gIhg==
X-Gm-Message-State: AOAM533I+59DAxca8x2yyXDfrnHbnwkbCQS+pyjByseECj5Hm1KUKQzY
        vYPOIeBLPeuHTrDR3kChijZ6Yg==
X-Google-Smtp-Source: ABdhPJwmDUBmpnMbHOfr9AseoUwhPChQTyZ9oF/BrGMzzdNqHdnJjq1/QXivb43oBOXTV0kQ7MwIlQ==
X-Received: by 2002:a17:902:145:b029:10d:c0d5:d6ac with SMTP id 63-20020a1709020145b029010dc0d5d6acmr2734297plb.9.1624512820681;
        Wed, 23 Jun 2021 22:33:40 -0700 (PDT)
Received: from hao-wu-dev.colo.rubrik.com ([104.171.196.14])
        by smtp.gmail.com with ESMTPSA id p1sm1392087pfp.137.2021.06.23.22.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 22:33:40 -0700 (PDT)
From:   Hao Wu <hao.wu@rubrik.com>
To:     hao.wu@rubrik.com, shrihari.kalkar@rubrik.com,
        seungyeop.han@rubrik.com, anish.jhaveri@rubrik.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
        kgold@linux.ibm.com, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, hamza@hpe.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, nayna@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com
Subject: [PATCH] Fix Atmel TPM crash caused by too frequent queries
Date:   Wed, 23 Jun 2021 22:33:21 -0700
Message-Id: <20210624053321.861-1-hao.wu@rubrik.com>
X-Mailer: git-send-email 2.29.0.vfs.0.0
In-Reply-To: <20210620231809.21101-1-hao.wu@rubrik.com>
References: <20210620231809.21101-1-hao.wu@rubrik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is a fix for the ATMEL TPM crash bug reported in
https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.109645-1-hao.wu@rubrik.com/

According to the discussions in the original thread,
we don't want to revert the timeout of wait_for_tpm_stat
for non-ATMEL chips, which brings back the performance cost.
For investigation and analysis of why wait_for_tpm_stat
caused the issue, and how the regression was introduced,
please read the original thread above.

Thus the proposed fix here is to only revert the timeout
for ATMEL chips by checking the vendor ID.
---
 drivers/char/tpm/tpm.h          |  9 ++++++++-
 drivers/char/tpm/tpm_tis_core.c | 19 +++++++++++++++++--
 include/linux/tpm.h             |  2 ++
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 283f78211c3a..bc6aa7f9e119 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -42,7 +42,9 @@ enum tpm_timeout {
 	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
 	TPM_TIMEOUT_POLL = 1,	/* msecs */
 	TPM_TIMEOUT_USECS_MIN = 100,      /* usecs */
-	TPM_TIMEOUT_USECS_MAX = 500      /* usecs */
+	TPM_TIMEOUT_USECS_MAX = 500,	/* usecs */
+	TPM_TIMEOUT_WAIT_STAT = 500,	/* usecs */
+	TPM_ATML_TIMEOUT_WAIT_STAT = 15000	/* usecs */
 };
 
 /* TPM addresses */
@@ -189,6 +191,11 @@ static inline void tpm_msleep(unsigned int delay_msec)
 		     delay_msec * 1000);
 };
 
+static inline void tpm_usleep(unsigned int delay_usec)
+{
+	usleep_range(delay_usec - TPM_TIMEOUT_RANGE_US, delay_usec);
+};
+
 int tpm_chip_start(struct tpm_chip *chip);
 void tpm_chip_stop(struct tpm_chip *chip);
 struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 55b9d3965ae1..9ddd4edfe1c2 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -80,8 +80,12 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		}
 	} else {
 		do {
-			usleep_range(TPM_TIMEOUT_USECS_MIN,
-				     TPM_TIMEOUT_USECS_MAX);
+			if (chip->timeout_wait_stat && 
+				chip->timeout_wait_stat >= TPM_TIMEOUT_WAIT_STAT) {
+				tpm_usleep((unsigned int)(chip->timeout_wait_stat));
+			} else {
+				tpm_usleep((unsigned int)(TPM_TIMEOUT_WAIT_STAT));
+			}
 			status = chip->ops->status(chip);
 			if ((status & mask) == mask)
 				return 0;
@@ -934,6 +938,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	chip->timeout_b = msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
 	chip->timeout_c = msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
 	chip->timeout_d = msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
+	/* init timeout for wait_for_tpm_stat */
+	chip->timeout_wait_stat = TPM_TIMEOUT_WAIT_STAT;
 	priv->phy_ops = phy_ops;
 	dev_set_drvdata(&chip->dev, priv);
 
@@ -983,6 +989,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 
 	priv->manufacturer_id = vendor;
 
+	switch (priv->manufacturer_id) {
+	case TPM_VID_ATML:
+        /* ATMEL chip needs longer timeout to avoid crash */
+		chip->timeout_wait_stat = TPM_ATML_TIMEOUT_WAIT_STAT;
+		break;
+	default:
+		chip->timeout_wait_stat = TPM_TIMEOUT_WAIT_STAT;
+	}
+
 	rc = tpm_tis_read8(priv, TPM_RID(0), &rid);
 	if (rc < 0)
 		goto out_err;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index aa11fe323c56..35f2a0260d76 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -150,6 +150,7 @@ struct tpm_chip {
 	bool timeout_adjusted;
 	unsigned long duration[TPM_NUM_DURATIONS]; /* jiffies */
 	bool duration_adjusted;
+	unsigned long timeout_wait_stat; /* usecs */
 
 	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
 
@@ -269,6 +270,7 @@ enum tpm2_cc_attrs {
 #define TPM_VID_INTEL    0x8086
 #define TPM_VID_WINBOND  0x1050
 #define TPM_VID_STM      0x104A
+#define TPM_VID_ATML     0x1114
 
 enum tpm_chip_flags {
 	TPM_CHIP_FLAG_TPM2		= BIT(1),
-- 
2.29.0.vfs.0.0

