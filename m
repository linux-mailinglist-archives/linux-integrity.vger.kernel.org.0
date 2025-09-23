Return-Path: <linux-integrity+bounces-7249-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC32CB96F5A
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 19:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E4E19C71C7
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 17:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A348E2773EF;
	Tue, 23 Sep 2025 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="j6ru4rbx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFED025EFBC;
	Tue, 23 Sep 2025 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647417; cv=none; b=E8gKM9l23/Sm7Jxm+40awkLYz9mAm6yC8OKkIsrg1SsZVzYXVJxxo35rGJDbF20T3cGm9zWmJkEtUDAXrODKqXWMCf80IRwJXyrBkJE6vCWdGvzqGI5Y5Cg+jeWD/mi5ajpNbPJ9D0cIpPur8R04HLnGbETl4pG1r3P3MWzjNpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647417; c=relaxed/simple;
	bh=n/1wJvk7cUxtUo5D3CLr0c9F7ji6NEtrrTkQ7t0O2oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fnap1chr13cMrT88Pu/4ZdYLeRf5Sg3qHP38WbmsvVn6lfrmDDcuAxf8nUzy645k8xsGL3ft9/2r+JaaKv2wgny7i2mQmYOUFVZk4yc40YbTGoYAqtUSSL5XRknT8+B/7z9/xDJJKNP5NwnmVw51VVOHvleQp7FfzK+9mef/cv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=j6ru4rbx; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jeuRux8KutMZCxL3uAp/qcVlCoRxYUQEyQCWvID7MmY=; b=j6ru4rbx1ifBBCWD19tb/l3e5L
	HiBWVS3ugYUngbYGfbra66QwVxCjKMp5z3yJzKNO/R9lKnPhRNk8/xQF7JSCVOLtrPttQ/3ttDonu
	wGQG206bIJmeYh4Ng7V78+q3CYskPBTHE1Uq/76yYg3gFjpO4hiojiGx7b41ySaoQyKOBClTbq4ts
	zYMNlMVRnNWBIceSuLH/CwDVCNopvVJ8lETqZ+i54AhxFyWTMwcWX8MebA5pukiXa357cCxDR+v/d
	mXJgCTUnFWI/87nhaJWXNDfZXzuo+jVXrqZweq//rq3Awl5JhSx0KLBK9xusck+kIC6wRwM3dLhm4
	ysestk5w==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1v16Wp-00CZlE-0x;
	Tue, 23 Sep 2025 18:10:11 +0100
Date: Tue, 23 Sep 2025 18:10:11 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] tpm: Remove tpm_find_get_ops
Message-ID: <99f6216783c4c1c71668ec951cfd8f73bbf93bc6.1758646791.git.noodles@meta.com>
References: <cover.1758646791.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758646791.git.noodles@meta.com>

From: Jonathan McDowell <noodles@meta.com>

tpm_find_get_ops() looks for the first valid TPM if the caller passes in
NULL. All internal users have been converted to either associate
themselves with a TPM directly, or call tpm_default_chip() as part of
their setup. Remove the no longer necessary tpm_find_get_ops().

Signed-off-by: Jonathan McDowell <noodles@meta.com>
---
 drivers/char/tpm/tpm-chip.c      | 36 --------------------------------
 drivers/char/tpm/tpm-interface.c | 20 ++++++++++++++----
 drivers/char/tpm/tpm.h           |  1 -
 drivers/char/tpm/tpm_tis_core.c  |  3 +--
 4 files changed, 17 insertions(+), 43 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 8c8e9054762a..ba906966721a 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -230,42 +230,6 @@ struct tpm_chip *tpm_default_chip(void)
 }
 EXPORT_SYMBOL_GPL(tpm_default_chip);
 
-/**
- * tpm_find_get_ops() - find and reserve a TPM chip
- * @chip:	a &struct tpm_chip instance, %NULL for the default chip
- *
- * Finds a TPM chip and reserves its class device and operations. The chip must
- * be released with tpm_put_ops() after use.
- * This function is for internal use only. It supports existing TPM callers
- * by accepting NULL, but those callers should be converted to pass in a chip
- * directly.
- *
- * Return:
- * A reserved &struct tpm_chip instance.
- * %NULL if a chip is not found.
- * %NULL if the chip is not available.
- */
-struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip)
-{
-	int rc;
-
-	if (chip) {
-		if (!tpm_try_get_ops(chip))
-			return chip;
-		return NULL;
-	}
-
-	chip = tpm_default_chip();
-	if (!chip)
-		return NULL;
-	rc = tpm_try_get_ops(chip);
-	/* release additional reference we got from tpm_default_chip() */
-	put_device(&chip->dev);
-	if (rc)
-		return NULL;
-	return chip;
-}
-
 /**
  * tpm_dev_release() - free chip memory and the device number
  * @dev: the character device for the TPM chip
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index b71725827743..8f65dc06a157 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -313,10 +313,13 @@ int tpm_is_tpm2(struct tpm_chip *chip)
 {
 	int rc;
 
-	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
+	rc = tpm_try_get_ops(chip);
+	if (rc)
+		return rc;
+
 	rc = (chip->flags & TPM_CHIP_FLAG_TPM2) != 0;
 
 	tpm_put_ops(chip);
@@ -338,10 +341,13 @@ int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 {
 	int rc;
 
-	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
+	rc = tpm_try_get_ops(chip);
+	if (rc)
+		return rc;
+
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		rc = tpm2_pcr_read(chip, pcr_idx, digest, NULL);
 	else
@@ -369,10 +375,13 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	int rc;
 	int i;
 
-	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
+	rc = tpm_try_get_ops(chip);
+	if (rc)
+		return rc;
+
 	for (i = 0; i < chip->nr_allocated_banks; i++) {
 		if (digests[i].alg_id != chip->allocated_banks[i].alg_id) {
 			rc = -EINVAL;
@@ -492,10 +501,13 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 	if (!out || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
-	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
+	rc = tpm_try_get_ops(chip);
+	if (rc)
+		return rc;
+
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		rc = tpm2_get_random(chip, out, max);
 	else
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 7bb87fa5f7a1..9c158c55c05f 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -267,7 +267,6 @@ static inline void tpm_msleep(unsigned int delay_msec)
 int tpm_chip_bootstrap(struct tpm_chip *chip);
 int tpm_chip_start(struct tpm_chip *chip);
 void tpm_chip_stop(struct tpm_chip *chip);
-struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
 
 struct tpm_chip *tpm_chip_alloc(struct device *dev,
 				const struct tpm_class_ops *ops);
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 4b12c4b9da8b..73b94f4daf4b 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -265,8 +265,7 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
 
 			/*
 			 * Dump stack for forensics, as invalid TPM_STS.x could be
-			 * potentially triggered by impaired tpm_try_get_ops() or
-			 * tpm_find_get_ops().
+			 * potentially triggered by impaired tpm_try_get_ops().
 			 */
 			dump_stack();
 		}
-- 
2.51.0


