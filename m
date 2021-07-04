Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA953BAAAC
	for <lists+linux-integrity@lfdr.de>; Sun,  4 Jul 2021 02:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhGDALA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 3 Jul 2021 20:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhGDALA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 3 Jul 2021 20:11:00 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231EDC061762
        for <linux-integrity@vger.kernel.org>; Sat,  3 Jul 2021 17:08:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l19so2860068plg.6
        for <linux-integrity@vger.kernel.org>; Sat, 03 Jul 2021 17:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=p7u9bMbb1aQFfjY7HAl5HJbI9KQrEnfvLO8s4eHJE04=;
        b=YgNTR2oD7TyN6QWv/QPRcr/y3yoARqSo1Chxm+Ay1yZIhBwHpfM106cUFujNu87bdm
         THsEDi/eQyUij4D3Pzt2hys+5hDw7CkBNSt1XKX2WX2u95hc/puI8DK9u7qKnJtB68UN
         fda1Kzbc7Syn/xgCuJauRpgEGqHqxxVzUc3bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p7u9bMbb1aQFfjY7HAl5HJbI9KQrEnfvLO8s4eHJE04=;
        b=Adj7vJVStsr7VBUqy0rt3cqfUUYJVp8L9/bpLKxxEc+cxTHHKmHHO+o7vMtiIusG6Z
         SBEWKBnJpXhiuYWbCvxND7plDyvBvPKNJZ0ye5lpBoNIDl01OEYU2p28QglX9rfU1PRa
         VoX+/2xBtnBncswhxriwIVSm/nxRtEhBjF95J/rgZG5psxpoUdhiygOVFs8elcOyPfju
         w+BhtayFqMVlykbUfbAKjqYNxtgI+ha7zMgNrzrROJh4WvTQ7zxKie/U0/mVkuQzzYPe
         Inpl5MMscEHWj10tebnQnu3dmoXA1qOHNbZJ1f4SeBY2v3emWfqv/evZvSHKVgW5Ngkl
         Hu4g==
X-Gm-Message-State: AOAM532dNBKLRHR1TiQa16h4q/9SZ3YB/3j7RkWRN72iLRSO/WBpF07+
        xlT5QaaWOGbONVrC87fMwnKoeQ==
X-Google-Smtp-Source: ABdhPJz9pQ9UOaBVgaSUc1cDMdWLnHGeXv1wJkoma/1vkDT7XP2miEMK532wV4aoUvhSmBaqDr87KQ==
X-Received: by 2002:a17:90a:5306:: with SMTP id x6mr6783599pjh.59.1625357304192;
        Sat, 03 Jul 2021 17:08:24 -0700 (PDT)
Received: from hao-wu-dev.colo.rubrik.com ([104.171.196.14])
        by smtp.gmail.com with ESMTPSA id u21sm7720711pfh.163.2021.07.03.17.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 17:08:23 -0700 (PDT)
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
Date:   Sat,  3 Jul 2021 17:07:54 -0700
Message-Id: <20210704000754.1384-1-hao.wu@rubrik.com>
X-Mailer: git-send-email 2.29.0.vfs.0.0
In-Reply-To: <20210630042205.30051-1-hao.wu@rubrik.com>
References: <20210630042205.30051-1-hao.wu@rubrik.com>
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

Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in TPM 1.2/2.0 generic drivers")
Signed-off-by: Hao Wu <hao.wu@rubrik.com>
---
Test Plan:
- Run fixed kernel with ATMEL TPM chips and see crash
has been fixed.
- Run fixed kernel with non-ATMEL TPM chips, and confirm
the timeout has not been changed.

 drivers/char/tpm/tpm.h          |  6 ++++--
 drivers/char/tpm/tpm_tis_core.c | 23 +++++++++++++++++++++--
 include/linux/tpm.h             |  3 +++
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 283f78211c3a..6de1b44c4aab 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -41,8 +41,10 @@ enum tpm_timeout {
 	TPM_TIMEOUT_RETRY = 100, /* msecs */
 	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
 	TPM_TIMEOUT_POLL = 1,	/* msecs */
-	TPM_TIMEOUT_USECS_MIN = 100,      /* usecs */
-	TPM_TIMEOUT_USECS_MAX = 500      /* usecs */
+	TPM_TIMEOUT_USECS_MIN = 100,	/* usecs */
+	TPM_TIMEOUT_USECS_MAX = 500,	/* usecs */
+	TPM_ATML_TIMEOUT_WAIT_STAT_MIN = 14700,	/* usecs */
+	TPM_ATML_TIMEOUT_WAIT_STAT_MAX = 15000	/* usecs */
 };
 
 /* TPM addresses */
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 55b9d3965ae1..ae27d66fdd94 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -80,8 +80,17 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		}
 	} else {
 		do {
-			usleep_range(TPM_TIMEOUT_USECS_MIN,
-				     TPM_TIMEOUT_USECS_MAX);
+			/* this code path could be executed before
+			 * timeouts initialized in chip instance.
+			 */
+			if (chip->timeout_wait_stat_min &&
+			    chip->timeout_wait_stat_max)
+				usleep_range(chip->timeout_wait_stat_min,
+					     chip->timeout_wait_stat_max);
+			else
+				usleep_range(TPM_TIMEOUT_USECS_MIN,
+					     TPM_TIMEOUT_USECS_MAX);
+
 			status = chip->ops->status(chip);
 			if ((status & mask) == mask)
 				return 0;
@@ -934,6 +943,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	chip->timeout_b = msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
 	chip->timeout_c = msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
 	chip->timeout_d = msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
+	/* init timeouts for wait_for_tpm_stat */
+	chip->timeout_wait_stat_min = TPM_TIMEOUT_USECS_MIN;
+	chip->timeout_wait_stat_max = TPM_TIMEOUT_USECS_MAX;
 	priv->phy_ops = phy_ops;
 	dev_set_drvdata(&chip->dev, priv);
 
@@ -983,6 +995,13 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 
 	priv->manufacturer_id = vendor;
 
+	if (priv->manufacturer_id == TPM_VID_ATML &&
+		!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
+		/* If TPM chip is 1.2 ATMEL chip, timeout need to be relaxed*/
+		chip->timeout_wait_stat_min = TPM_ATML_TIMEOUT_WAIT_STAT_MIN;
+		chip->timeout_wait_stat_max = TPM_ATML_TIMEOUT_WAIT_STAT_MAX;
+	}
+
 	rc = tpm_tis_read8(priv, TPM_RID(0), &rid);
 	if (rc < 0)
 		goto out_err;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index aa11fe323c56..171b9102c976 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -150,6 +150,8 @@ struct tpm_chip {
 	bool timeout_adjusted;
 	unsigned long duration[TPM_NUM_DURATIONS]; /* jiffies */
 	bool duration_adjusted;
+	unsigned int timeout_wait_stat_min; /* usecs */
+	unsigned int timeout_wait_stat_max; /* usecs */
 
 	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
 
@@ -269,6 +271,7 @@ enum tpm2_cc_attrs {
 #define TPM_VID_INTEL    0x8086
 #define TPM_VID_WINBOND  0x1050
 #define TPM_VID_STM      0x104A
+#define TPM_VID_ATML     0x1114
 
 enum tpm_chip_flags {
 	TPM_CHIP_FLAG_TPM2		= BIT(1),
-- 
2.29.0.vfs.0.0

