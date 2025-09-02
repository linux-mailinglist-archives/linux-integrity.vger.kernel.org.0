Return-Path: <linux-integrity+bounces-6979-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 954B2B40C02
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 19:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C9C1B653EF
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 17:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F3E343D8E;
	Tue,  2 Sep 2025 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="V+m5fPMU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA5F34320B;
	Tue,  2 Sep 2025 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834027; cv=none; b=l4PATobA7fQs7r7DglN0BlH7ZgOC4w4wRhp2mXHnJ8Gz/1ZgJmcjD9E5OKUnGadpcvRdmbtB/t52oyi8fExbxe/T4wYRv7ogKxjvw6fw3TXsReTmlz88djB0mLnf6eFRDzGLt6FPi4mJhZV1ZtbXeVbaG9fPR+bxE26rAn2leBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834027; c=relaxed/simple;
	bh=n/1wJvk7cUxtUo5D3CLr0c9F7ji6NEtrrTkQ7t0O2oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHDSkq9x0LLx1EvmRSL4sPKghGdZ+FfsahNDort0f6Nlm2g+uSbpkyt1Nq1VCnkvSRZp6oc5HHfQWFVZa9bsXL8wmCDGUhlfHLztec6XrPdBebvpJY5wEPSarPct+U+FTAHNoqXlSiSq7T9R00Rsf5YAnZS/duku/2Sz279eivQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=V+m5fPMU; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jeuRux8KutMZCxL3uAp/qcVlCoRxYUQEyQCWvID7MmY=; b=V+m5fPMUYmoWvPw4Kr2JBSUuny
	gr+qx2BHxCXtrhcuvvlvzc4zRXOhKaXigw0rfycilaWUez6zC3G/wOAyOafSSsnQsKgWr+7RHTW2S
	w0uBVd2vFTbSIU/TRW1y2j08sniYKcDCWpeT8Oy0t/0bLr7pOKRQmVuIp1Qk4L3HzLb9nrVY4ec/E
	/LhrX1zSBAp4OIa0QWEQFfSfx6tH6SIALbKNfsrPle1OqV3+1OQxfBpSGZTSOp7IWTfPVrH3K/+AU
	0sP+cn1WE9xB3gsvzqkNvDxom6wHn5b8FqISCpLBLAYQRH/VYA0dobWpWzo0l97G6aeREDMmgkQ/T
	IEmXmbzg==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1utUmd-002QYv-07;
	Tue, 02 Sep 2025 18:27:03 +0100
Date: Tue, 2 Sep 2025 18:27:03 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] tpm: Remove tpm_find_get_ops
Message-ID: <659c2a453908ba98ee6481c25ab878a65133d3af.1756833527.git.noodles@meta.com>
References: <cover.1756833527.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756833527.git.noodles@meta.com>

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


