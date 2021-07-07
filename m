Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A473BE220
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 06:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhGGEeb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 00:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGGEeb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 00:34:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E366AC061574
        for <linux-integrity@vger.kernel.org>; Tue,  6 Jul 2021 21:31:50 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h1-20020a17090a3d01b0290172d33bb8bcso2927329pjc.0
        for <linux-integrity@vger.kernel.org>; Tue, 06 Jul 2021 21:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Yroo/BzqH2aLS6Myicr5Yf0JBKLQgDIY+e4M3yTtl3U=;
        b=YGRgq0LfohAA+G56vhLlRABAmfTs2s8M9h7cXZVQVCMcQGnX1HmYbsXlRv6rgg4q+m
         E27g2cGACYkVZSf3GUCQnh+18cIkCbu1Y7dVmDS8Ov1+DJ0BMwwDZhcz2VukF0pseIrH
         znrAPMLIJmF0/oqeEsIe7exWoNeHQlE6i56Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yroo/BzqH2aLS6Myicr5Yf0JBKLQgDIY+e4M3yTtl3U=;
        b=BRGO39guX83dGe4okVFn0dlLvOTinST5X6LjaSFQEhfiME31I7MCncJwXxaGnuybvA
         m8CAju1X3pk2hLOMWRUu8srrD3a/WXafBQPsa72IdUBz02JZYbRITQMLdRG7jKwHyI0G
         Vz8qo/5zgzDiYL9W+jpy1JZr21Nvn111PtGKuC9KIVjfvZDqI2fwVc8SOxZW0EbLfFgv
         f0uSVBu45ePw2UFIoA8qG7e1JF48LXEmXb1NtMsfDr9mxZEPbYR3j2ZMY3/MvOflwo32
         v+eLCn6nqn44Wni28nTaOnVBjETjw0nRXEKmi2JyD0GMwdzk8M/v4WgWFvS0tjoe1sDg
         GESw==
X-Gm-Message-State: AOAM531B6o7VHVHTNriyjOWRutP63qCmlBM9ouaQGuTqJoTe0hW+GND3
        ZarbMBiGOO9MItw7CEgKK5ZrPA==
X-Google-Smtp-Source: ABdhPJz1TPAyx7YOeKOpuWy0udifGET4mnnkRGmEevwfqQb5PDtVnh8KX5iyMznCwS0lU4ZhGvPg5w==
X-Received: by 2002:a17:902:760e:b029:126:d03c:9632 with SMTP id k14-20020a170902760eb0290126d03c9632mr19684667pll.80.1625632310248;
        Tue, 06 Jul 2021 21:31:50 -0700 (PDT)
Received: from hao-wu-dev.colo.rubrik.com ([104.171.196.14])
        by smtp.gmail.com with ESMTPSA id z20sm21484172pgk.36.2021.07.06.21.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 21:31:49 -0700 (PDT)
From:   Hao Wu <hao.wu@rubrik.com>
To:     hao.wu@rubrik.com, shrihari.kalkar@rubrik.com,
        seungyeop.han@rubrik.com, anish.jhaveri@rubrik.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
        kgold@linux.ibm.com, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, hamza@hpe.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, nayna@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com
Subject: [PATCH v2] tpm: fix ATMEL TPM crash caused by too frequent queries
Date:   Tue,  6 Jul 2021 21:31:35 -0700
Message-Id: <20210707043135.33434-1-hao.wu@rubrik.com>
X-Mailer: git-send-email 2.29.0.vfs.0.0
In-Reply-To: <20210630042205.30051-1-hao.wu@rubrik.com>
References: <20210630042205.30051-1-hao.wu@rubrik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Since kernel 4.14, there was a commit (9f3fc7bcddcb)
fixed the TPM sleep logic from msleep to usleep_range,
so that the TPM sleeps exactly with TPM_TIMEOUT (=5ms) afterward.
Before that fix, msleep(5) actually sleeps for around 15ms.

This timeout change caused the ATMEL 1.2 TPM chip crash,
and the patch here is to fix it in the master branch.
Crash signature is as follows:
```
$ tpm_sealdata -z
Tspi_Key_LoadKey failed: 0x00001087 - layer=tddl, code=0087 (135),
I/O error

$ sudo dmesg | grep tpm0
[59154.665549] tpm tpm0: tpm_try_transmit: send(): error -62
```

With at few more changes after 4.14, the timeout was
reduced to less than 1 ms today in the master branch.
- in 4.16 commit cf151a9a44d5 uses `TPM_POLL_SLEEP` instead of
  TPM_TIMEOUT for `wait_for_tpm_stat` and set `TPM_POLL_SLEEP` (1ms).
- in 4.18 commits 59f5a6b07f64 and 424eaf910c32 further
  reduced the timeout in wait_for_tpm_stat to less than 1ms.

This patch is to fix the TPM crash for ATMEL 1.2 TPM chip.
We specifically use 15ms timeout for the ATMEL 1.2 TPM chip
in wait_for_tpm_stat, but keep the timeout for other chips
unchanged. The 15ms timeout was the timeout
works for ATMEL 1.2 TPM chip before 4.14.

Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in TPM 1.2/2.0 generic drivers")
Link: https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.109645-1-hao.wu@rubrik.com/
Signed-off-by: Hao Wu <hao.wu@rubrik.com>
---
This version (v2) has following changes on top of the last (v1):
- follow the existing way to define two timeouts (min and max)
  for ATMEL chip, thus keep the exact timeout logic for 
  non-ATEML chips.
- limit the timeout increase to only ATMEL TPM 1.2 chips,
  because it is not an issue for TPM 2.0 chips yet.

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

