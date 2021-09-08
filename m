Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8194036BD
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Sep 2021 11:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351349AbhIHJS1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Sep 2021 05:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351327AbhIHJS1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Sep 2021 05:18:27 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD93C061575
        for <linux-integrity@vger.kernel.org>; Wed,  8 Sep 2021 02:17:20 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r2so1917714pgl.10
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 02:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zznc1mnS/7hkRDJ5Bmw9r3IOkxNwKeBpz4BZ7mYkFZ8=;
        b=LV3vwjDoobMuVcgWWWj0+4d/hfCQeB2V/7OR8Hdbmh0KSnqhux/MwoOsLok/aSZFWZ
         Uap+uDTsCKWmQ3So7hTiUmQZj8IL0Ur1JhatWPIQRxpS3HwfXjcAZ4krU3o4wI8MMmzy
         lBL5tOWfKC0FiHHBCOq2Z+enIIuptGTOghM+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zznc1mnS/7hkRDJ5Bmw9r3IOkxNwKeBpz4BZ7mYkFZ8=;
        b=gJCLvZrAmmdSZaRO60+UyOXT+zVytIm1vgsUkcAL5ClkFmaG3aj3y+Vx2rgB6YLmVc
         1IVXBrbi0ciKouPbC43XxhREkj6s+qO5RniHSHu0Bf/pYZHnj13Ip+to9Bjsss29fVh2
         xQi+AKyqKusRJCBTJwiHohmxJLySM0CkR8Aizq3U9KLGNlAvYaz+0RXjjjdAa1B72g/N
         dDUqND26DAR5voby+JUtNSgr+CV1s9T6gLKBRCgKzX8EDrfHJb2KfGyHQ2vNJ15ILAuX
         l1qrnnY6Oj+ellpMZPb6F5HeCKTkR1vMKDL1FpyCQZgjIxh9BQn48Nv5EgZsVHmzL6cF
         2DPg==
X-Gm-Message-State: AOAM531kcmGzmr/GTaQAZHuuKT/ZZZgkubLjJgvAVEiBg0Hcp+amF5Hm
        kDS2hQFCPMJcbKYd+gCJ4dWtqA==
X-Google-Smtp-Source: ABdhPJzbVHlnP9agF3dtp9gCwlIioSXbsDQEvKro2lzQTaKezi7BgdrmWLjNpA0IyA39dlpANB91yw==
X-Received: by 2002:a63:e613:: with SMTP id g19mr2799828pgh.12.1631092639351;
        Wed, 08 Sep 2021 02:17:19 -0700 (PDT)
Received: from hao-wu-dev.colo.rubrik.com ([104.171.196.14])
        by smtp.gmail.com with ESMTPSA id w11sm1736408pfj.65.2021.09.08.02.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 02:17:19 -0700 (PDT)
From:   Hao Wu <hao.wu@rubrik.com>
To:     hao.wu@rubrik.com, shrihari.kalkar@rubrik.com,
        seungyeop.han@rubrik.com, anish.jhaveri@rubrik.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
        kgold@linux.ibm.com, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, hamza@hpe.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, nayna@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com
Subject: [PATCH v6] tpm: fix Atmel TPM crash caused by too frequent queries
Date:   Wed,  8 Sep 2021 02:16:46 -0700
Message-Id: <20210908091646.95106-1-hao.wu@rubrik.com>
X-Mailer: git-send-email 2.29.0.vfs.0.0
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

Test Plan:
- Run fixed kernel with ATMEL TPM chips and see crash
has been fixed.
- Run fixed kernel with non-ATMEL TPM chips, and confirm
the timeout has not been changed.

Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in TPM 1.2/2.0 generic drivers")
Link: https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.109645-1-hao.wu@rubrik.com/
Signed-off-by: Hao Wu <hao.wu@rubrik.com>
---
v6:
- Address nitpicks comments

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

