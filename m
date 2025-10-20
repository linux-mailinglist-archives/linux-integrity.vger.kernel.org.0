Return-Path: <linux-integrity+bounces-7503-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B11BF0E49
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Oct 2025 13:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBFF1892B64
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Oct 2025 11:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273BA25D53C;
	Mon, 20 Oct 2025 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="S5M725Hs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C324A051;
	Mon, 20 Oct 2025 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960585; cv=none; b=VYBxek+ExdUCNQeL32nUzrALfENOkD7O8mD+tmBEtGYp3yzbVy/uwVP940+dwwltpcKdxfS+JzBxWVJqxYnFvmAda+9zm9s1vrCVGJ3mn7Db2CjkH/2Sa7xVQmCYFWn9nbWD53QoJHmfoREBbd+sIgoTPB/cmoW4QkJsh3vSmZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960585; c=relaxed/simple;
	bh=GGhYb32zVcEY/nN0x4vMpsh70d+/Vp6kzB++g286hpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3mzPZymoCDMmmLFHanR9w0eNvfjP8ofLdvfYJCazLbHT04vg2JFIjeB54+mSdlmHCeLBvo657fuF21vE5iadSZltxqVOn/1ZnDH2aqBMlnaWYlfgGLEG02aYe21OX+aowQaeg7fjLnLT8xLknSZn7oK4lMrl7S6flD18rUFkEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=S5M725Hs; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kJknCH3swuMVmZ2WVheIS69zgrozTmIHgxve2G9qddE=; b=S5M725Hsun+a05Acy1ROIsbmGL
	uKSQ1J09CiBPiOOUcpz1xuaODFYj6MSehlK1765j2LeY7a8e1XXMKBh3xqa+/CpkYmIszluP/SEoG
	6MTr09gvIiwVCUwQ7+BEMo0dL5FnGceyf6RHRHZDtu6gSAkWCGEDxCIxYVeIRffxrWA4krEeYNqXm
	n+5WYmLyLqYD4Rn8SuWcaCJF5H6vX2tnAdwszToEXZASU4WgUFP/V1mVzIrzpnQgoMByxwyC2Bsnp
	sztddQ5lL0lyGIfNg6ntPoX5gn0CfNPG8/bKmvOccDUSuIYfLSfsyKLl2rUzqBr7LnUIdzeEemqDM
	FlVF2YxA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1vAo64-00184u-1g;
	Mon, 20 Oct 2025 12:30:40 +0100
Date: Mon, 20 Oct 2025 12:30:40 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] tpm: Remove tpm_find_get_ops
Message-ID: <e8c7c5702dff4e781f21e08c8d49ce305c6b0e71.1760958898.git.noodles@meta.com>
References: <cover.1760958898.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760958898.git.noodles@meta.com>

From: Jonathan McDowell <noodles@meta.com>

tpm_find_get_ops() looks for the first valid TPM if the caller passes in
NULL. All internal users have been converted to either associate
themselves with a TPM directly, or call tpm_default_chip() as part of
their setup. Remove the no longer necessary tpm_find_get_ops().

Signed-off-by: Jonathan McDowell <noodles@meta.com>
---
v2: No changes.
v3: Move to start of patch series

 drivers/char/tpm/tpm-chip.c      | 36 --------------------------------
 drivers/char/tpm/tpm-interface.c | 20 ++++++++++++++----
 drivers/char/tpm/tpm.h           |  1 -
 drivers/char/tpm/tpm_tis_core.c  |  3 +--
 4 files changed, 17 insertions(+), 43 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index e25daf2396d3..30d00219f9f3 100644
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
index c9f173001d0e..f745a098908b 100644
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
index 2726bd38e5ac..02c07fef41ba 100644
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
index 8954a8660ffc..e2a1769081b1 100644
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


