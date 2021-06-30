Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07C43B7C8F
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 06:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhF3EYp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 00:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhF3EYp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 00:24:45 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6EBC061760
        for <linux-integrity@vger.kernel.org>; Tue, 29 Jun 2021 21:22:16 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h4so961773pgp.5
        for <linux-integrity@vger.kernel.org>; Tue, 29 Jun 2021 21:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JILowffZiEdxLwNd8JOkLE5f9H6/vmrDtU2B6gkKYN4=;
        b=aHQZ22aYqGc50qSfas/w2uVbl45y3ESjzPD6vkUCw6562MgA5mU4CHiWhW2KVlPQNi
         be/ZiOjKSdha0tZ8rZzxFlHQ+W55ajxwmVYsSnKGILD6m+q3eG6TgEdSPc/Bv4Mxquo/
         2bHUCP4QaCMEiNS22l40sz3vhB3RP1wI4td/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JILowffZiEdxLwNd8JOkLE5f9H6/vmrDtU2B6gkKYN4=;
        b=D3WYdd25zeaULd5NGU8eA8e6LRvnr5Po3ch/NP2ELE209JvPBEFOd0Yz7qnba7etQi
         4V+je1o8iyDv2ZGrmxlLjtCskUoxUZi0XdptO4jh5b+HuRGJJgkKHZaMyxq9iYk/CGDz
         zGPxPdyrZYOC0bqmu7YW9fz1SmG7Nm14hbZ3AbNTUK1hoWLqb5xsSa310874Nv3qSOMI
         63xSPVSQAZrjbEu/5eYGR052zpPGgDmmINfNvsU1u6s15snwcoeTaSPbEhYhPEmR3Hl6
         S70sjr8J3AJqp8bS9/ES48/l4VbmbzwpRXX4Pg3wfdXqANBbEwf+S1/JwCfIORNoZRxo
         w4Nw==
X-Gm-Message-State: AOAM530kwF0tMRhzjJG7oft9JTD3sx/zwM5bqvrYtm6JUqMwgAj0fmmc
        57koUs/RRdrxF63y7WOhhA7nnA==
X-Google-Smtp-Source: ABdhPJwLr0O8iXW8osMlyw9V7F/X0xgdGDkui+buGAl72ndqlSi1RPLGva+7yI15/a/85lyAD9PZZQ==
X-Received: by 2002:a65:610c:: with SMTP id z12mr32473839pgu.453.1625026935576;
        Tue, 29 Jun 2021 21:22:15 -0700 (PDT)
Received: from hao-wu-dev.colo.rubrik.com ([104.171.196.14])
        by smtp.gmail.com with ESMTPSA id y13sm19920184pgp.16.2021.06.29.21.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 21:22:15 -0700 (PDT)
From:   Hao Wu <hao.wu@rubrik.com>
To:     hao.wu@rubrik.com, shrihari.kalkar@rubrik.com,
        seungyeop.han@rubrik.com, anish.jhaveri@rubrik.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
        kgold@linux.ibm.com, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, hamza@hpe.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, nayna@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com
Subject: [PATCH] tpm: fix ATMEL TPM crash caused by too frequent queries
Date:   Tue, 29 Jun 2021 21:22:05 -0700
Message-Id: <20210630042205.30051-1-hao.wu@rubrik.com>
X-Mailer: git-send-email 2.29.0.vfs.0.0
In-Reply-To: <20210624053321.861-1-hao.wu@rubrik.com>
References: <20210624053321.861-1-hao.wu@rubrik.com>
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

Signed-off-by: Hao Wu <hao.wu@rubrik.com>
Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in TPM 1.2/2.0 generic drivers")
---
Test Plan:
- Run fixed kernel with ATMEL TPM chips and see crash
has been fixed.
- Run fixed kernel with non-ATMEL TPM chips, and confirm
the timeout has not been changed.

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

