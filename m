Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E33D400DE0
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Sep 2021 05:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhIEDwe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 4 Sep 2021 23:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhIEDwe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 4 Sep 2021 23:52:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D762DC061575
        for <linux-integrity@vger.kernel.org>; Sat,  4 Sep 2021 20:51:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so2210564pjc.3
        for <linux-integrity@vger.kernel.org>; Sat, 04 Sep 2021 20:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5CY/9YetstJevLPZl79eFwhATaREg3GmN1gS7hBxOHY=;
        b=YO4QzZV36M8PlcRbUAKT0NaMrlDSozSSsOFJObwr2AQuwjGBhbm6QTTyDGMqbVGq8B
         /Q/bG10i0bYLCxYMj4zHBlOzIV72jyuYSqxiD2ld8FrUFH5LCkJJwpXyyjUrNDJoPDVp
         p3Vq3AUucAhy5IU2OhbRRNrRGJFpHL6+sBwrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5CY/9YetstJevLPZl79eFwhATaREg3GmN1gS7hBxOHY=;
        b=SSjJ6lJbkZmiN4rdysHM5+g6kUR5Tuuww+0/cDQ2sAgI6y05rBRFD3vNOp38NKs186
         r9CVL8Z2+J3gYlK/UaPQIFUHYHQ/9FflzFHDA4Eay9R4p1IkW7jc7AY0NixT3je7UPAS
         +JTixcVnvGMV/3pyUPwI0W9PCZ9+QM8Z05g8xZ1HFYf4lIm8eWN0x71gpNSSHytJ5C0H
         U/wQHViduiLr/rRzkcNejE2zfs8r5zERh/MWs5jlvSSofFZLTXONNws9Bu532ovrxqel
         QG/dQpH0NiedQvXA+84lbVcBV5iFfw4kwgAHjt0q/SlKiyB32QrxT3zu1lwk5JBtcR4x
         zC4Q==
X-Gm-Message-State: AOAM533JLbZO5r0O6xyXGgoQIEjKUZvhwMDFQne/MnL+enEbftp62h/f
        TjQ6+kwwyxFAa2FFKVKQrC0V0Q==
X-Google-Smtp-Source: ABdhPJzCcjTa35UGEwLdBTZ4deXSPcByYV2GLGPXGGWhW9Jru6QipB41a5Ht9PbaHHnI4q3SrgJUVQ==
X-Received: by 2002:a17:90a:2a88:: with SMTP id j8mr7194163pjd.153.1630813891071;
        Sat, 04 Sep 2021 20:51:31 -0700 (PDT)
Received: from hao-wu-dev.colo.rubrik.com ([104.171.196.14])
        by smtp.gmail.com with ESMTPSA id d4sm3512873pfv.21.2021.09.04.20.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 20:51:30 -0700 (PDT)
From:   Hao Wu <hao.wu@rubrik.com>
To:     hao.wu@rubrik.com, shrihari.kalkar@rubrik.com,
        seungyeop.han@rubrik.com, anish.jhaveri@rubrik.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
        kgold@linux.ibm.com, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, hamza@hpe.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, nayna@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com
Subject: [PATCH v5] tpm: fix Atmel TPM crash caused by too frequent queries
Date:   Sat,  4 Sep 2021 20:51:19 -0700
Message-Id: <20210905035119.15538-1-hao.wu@rubrik.com>
X-Mailer: git-send-email 2.29.0.vfs.0.0
In-Reply-To: <20210814222519.42476-1-hao.wu@rubrik.com>
References: <20210814222519.42476-1-hao.wu@rubrik.com>
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
v5:
- Rename variables according to feedbacks
- Move timeout min/max to tpm_tis_data

v4:
- Move timeout constants to drivers/char/tpm/tpm_tis_core.h
- Cleanup unnecessary inline comment

v3:
- removes unnecessary condition check in `wait_for_tpm_stat`

v2:
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

 drivers/char/tpm/tpm_tis_core.c | 27 +++++++++++++++++++--------
 drivers/char/tpm/tpm_tis_core.h |  4 ++++
 include/linux/tpm.h             |  1 +
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 55b9d3965ae1..29de383aec5f 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -79,9 +79,10 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 			goto again;
 		}
 	} else {
+		struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 		do {
-			usleep_range(TPM_TIMEOUT_USECS_MIN,
-				     TPM_TIMEOUT_USECS_MAX);
+			usleep_range(priv->timeout_min,
+				     priv->timeout_max);
 			status = chip->ops->status(chip);
 			if ((status & mask) == mask)
 				return 0;
@@ -934,7 +935,23 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	chip->timeout_b = msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
 	chip->timeout_c = msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
 	chip->timeout_d = msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
+	priv->timeout_min = TPM_TIMEOUT_USECS_MIN;
+	priv->timeout_max = TPM_TIMEOUT_USECS_MAX;
 	priv->phy_ops = phy_ops;
+
+	rc = tpm_tis_read32(priv, TPM_DID_VID(0), &vendor);
+	if (rc < 0)
+		goto out_err;
+
+	priv->manufacturer_id = vendor;
+
+	if (priv->manufacturer_id == TPM_VID_ATML &&
+		!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
+		/* If TPM chip is 1.2 ATMEL chip, timeout need to be relaxed*/
+		priv->timeout_min = TIS_TIMEOUT_MIN_ATML;
+		priv->timeout_max = TIS_TIMEOUT_MAX_ATML;
+	}
+
 	dev_set_drvdata(&chip->dev, priv);
 
 	if (is_bsw()) {
@@ -977,12 +994,6 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	if (rc)
 		goto out_err;
 
-	rc = tpm_tis_read32(priv, TPM_DID_VID(0), &vendor);
-	if (rc < 0)
-		goto out_err;
-
-	priv->manufacturer_id = vendor;
-
 	rc = tpm_tis_read8(priv, TPM_RID(0), &rid);
 	if (rc < 0)
 		goto out_err;
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 9b2d32a59f67..c33f27c929f4 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -54,6 +54,8 @@ enum tis_defaults {
 	TIS_MEM_LEN = 0x5000,
 	TIS_SHORT_TIMEOUT = 750,	/* ms */
 	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
+	TIS_TIMEOUT_MIN_ATML = 14700,	/* usecs */
+	TIS_TIMEOUT_MAX_ATML = 15000,	/* usecs */
 };
 
 /* Some timeout values are needed before it is known whether the chip is
@@ -97,6 +99,8 @@ struct tpm_tis_data {
 	wait_queue_head_t read_queue;
 	const struct tpm_tis_phy_ops *phy_ops;
 	unsigned short rng_quality;
+	unsigned int timeout_min; /* usecs */
+	unsigned int timeout_max; /* usecs */
 };
 
 struct tpm_tis_phy_ops {
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index aa11fe323c56..12d827734686 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -269,6 +269,7 @@ enum tpm2_cc_attrs {
 #define TPM_VID_INTEL    0x8086
 #define TPM_VID_WINBOND  0x1050
 #define TPM_VID_STM      0x104A
+#define TPM_VID_ATML     0x1114
 
 enum tpm_chip_flags {
 	TPM_CHIP_FLAG_TPM2		= BIT(1),
-- 
2.29.0.vfs.0.0

