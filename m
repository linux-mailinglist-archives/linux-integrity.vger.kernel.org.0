Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F00A3C3B18
	for <lists+linux-integrity@lfdr.de>; Sun, 11 Jul 2021 09:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhGKHy0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 11 Jul 2021 03:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhGKHyZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 11 Jul 2021 03:54:25 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE85C0613DD
        for <linux-integrity@vger.kernel.org>; Sun, 11 Jul 2021 00:51:37 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so10817724pjs.2
        for <linux-integrity@vger.kernel.org>; Sun, 11 Jul 2021 00:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+/XwTXtJe406Ri1SYdn31wQdGbviZ9dYbipKy4kCoSE=;
        b=JogbfXSBrTraCLmNsqn7i2zqOPpyKfwhDHF/UQD5Zbw1wdSmFroqJZbSW6KYM/KSON
         tRoVaYJdYYxBa1vXsGZvb1Trs4/6VRGjfzRg3u2fZIxHc5DPd1dHxGZ4nerQrJw7BR1V
         KLkVpLnb8vn4A8Ou0xHQuMzayTFJauaWQlIUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+/XwTXtJe406Ri1SYdn31wQdGbviZ9dYbipKy4kCoSE=;
        b=t3qT0WW4xWpl+lWvhP2Cr7+WKARwE9/WRZcm+YaNbf3Fpjmu+ol1FykniB43mDv1uc
         oW+Mt2hJwug4xzhffU33shaVdZSUbBUYvICbvMicW1WLj2/ZPXKmROd8oQt2Hasndeq9
         20V4LR2h1deNBcZICkLoBAVIB6k626hWBrs+rtRF8v4CSKy2R6mzoLtIIYtbrfBEEQA3
         snW11N2Udzzr4yiWV6D/KfT12FL3btKLZqBI4Q1dSHmTN3TrKtpT+iBq8+uT6F1/mT1n
         lBtwh+JQXqDWOd8ML4hl0ZcoOUtFT3jJ4N9HNrPcNVIryK3dSCVAC/6i2n3JyOG89NOc
         fUCQ==
X-Gm-Message-State: AOAM533/2N7S8bOXgN1Y16MXo/SFwfwIfTvJ/MHY1QhkPBBMEbC81zo1
        L/X0+hKXlic/D07eChgNsGBScw==
X-Google-Smtp-Source: ABdhPJygMLuMm0kDnDA/ZSL0ftHyXA6wt9BdEGUDR4MVA5oVSy0MZW0DCa4uvlLl4lNO3Buu3rEwow==
X-Received: by 2002:a17:902:830b:b029:12a:dd1b:74bf with SMTP id bd11-20020a170902830bb029012add1b74bfmr10518741plb.44.1625989896645;
        Sun, 11 Jul 2021 00:51:36 -0700 (PDT)
Received: from hao-wu-dev.colo.rubrik.com ([104.171.196.14])
        by smtp.gmail.com with ESMTPSA id i24sm12055069pfr.56.2021.07.11.00.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 00:51:36 -0700 (PDT)
From:   Hao Wu <hao.wu@rubrik.com>
To:     hao.wu@rubrik.com, shrihari.kalkar@rubrik.com,
        seungyeop.han@rubrik.com, anish.jhaveri@rubrik.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
        kgold@linux.ibm.com, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, hamza@hpe.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, nayna@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com
Subject: [PATCH v3] tpm: fix Atmel TPM crash caused by too frequent queries
Date:   Sun, 11 Jul 2021 00:51:22 -0700
Message-Id: <20210711075122.30056-1-hao.wu@rubrik.com>
X-Mailer: git-send-email 2.29.0.vfs.0.0
In-Reply-To: <20210709044028.77278-1-hao.wu@rubrik.com>
References: <20210709044028.77278-1-hao.wu@rubrik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The Atmel TPM 1.2 chips crash with error
`tpm_try_transmit: send(): error -62` since kernel 4.14.
It is observed from the kernel log after running `tpm_sealdata -z`.
The error thrown from the command is as follows
```
$ tpm_sealdata -z
Tspi_Key_LoadKey failed: 0x00001087 - layer=tddl,
code=0087 (135), I/O error
```

The issue was reproduced with the following Atmel TPM chip:
```
$ tpm_version
T0  TPM 1.2 Version Info:
  Chip Version:        1.2.66.1
  Spec Level:          2
  Errata Revision:     3
  TPM Vendor ID:       ATML
  TPM Version:         01010000
  Manufacturer Info:   41544d4c
```

The root cause of the issue is due to the TPM calls to msleep()
were replaced with usleep_range() [1], which reduces
the actual timeout. Via experiments, it is observed that
the original msleep(5) actually sleeps for 15ms.
Because of a known timeout issue in Atmel TPM 1.2 chip,
the shorter timeout than 15ms can cause the error described above.

A few further changes in kernel 4.16 [2] and 4.18 [3, 4] further
reduced the timeout to less than 1ms. With experiments,
the problematic timeout in the latest kernel is the one
for `wait_for_tpm_stat`.

To fix it, the patch reverts the timeout of `wait_for_tpm_stat`
to 15ms for all Atmel TPM 1.2 chips, but leave it untouched
for Ateml TPM 2.0 chip, and chips from other vendors.
As explained above, the chosen 15ms timeout is
the actual timeout before this issue introduced,
thus the old value is used here.
Particularly, TPM_ATML_TIMEOUT_WAIT_STAT_MIN is set to 14700us,
TPM_ATML_TIMEOUT_WAIT_STAT_MIN is set to 15000us according to
the existing TPM_TIMEOUT_RANGE_US (300us).
The fixed has been tested in the system with the affected Atmel chip
with no issues observed after boot up.

References:
[1] 9f3fc7bcddcb tpm: replace msleep() with usleep_range() in TPM
1.2/2.0 generic drivers
[2] cf151a9a44d5 tpm: reduce tpm polling delay in tpm_tis_core
[3] 59f5a6b07f64 tpm: reduce poll sleep time in tpm_transmit()
[4] 424eaf910c32 tpm: reduce polling time to usecs for even finer
granularity

Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in TPM 1.2/2.0 generic drivers")
Link: https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.109645-1-hao.wu@rubrik.com/
Signed-off-by: Hao Wu <hao.wu@rubrik.com>
---
This version (v3) removes unnecessary condition check
in `wait_for_tpm_stat`.

Test Plan:
- Run fixed kernel with ATMEL TPM chips and see crash
has been fixed.
- Run fixed kernel with non-ATMEL TPM chips, and confirm
the timeout has not been changed.

drivers/char/tpm/tpm.h          |  6 ++++--
 drivers/char/tpm/tpm_tis_core.c | 14 ++++++++++++--
 include/linux/tpm.h             |  3 +++
 3 files changed, 19 insertions(+), 4 deletions(-)

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
index 55b9d3965ae1..2de1f71e8ae1 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -80,8 +80,8 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		}
 	} else {
 		do {
-			usleep_range(TPM_TIMEOUT_USECS_MIN,
-				     TPM_TIMEOUT_USECS_MAX);
+			usleep_range(chip->timeout_wait_stat_min,
+				     chip->timeout_wait_stat_max);
 			status = chip->ops->status(chip);
 			if ((status & mask) == mask)
 				return 0;
@@ -934,6 +934,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	chip->timeout_b = msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
 	chip->timeout_c = msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
 	chip->timeout_d = msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
+	/* init timeouts for wait_for_tpm_stat */
+	chip->timeout_wait_stat_min = TPM_TIMEOUT_USECS_MIN;
+	chip->timeout_wait_stat_max = TPM_TIMEOUT_USECS_MAX;
 	priv->phy_ops = phy_ops;
 	dev_set_drvdata(&chip->dev, priv);
 
@@ -983,6 +986,13 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 
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

