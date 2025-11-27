Return-Path: <linux-integrity+bounces-7704-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE6CC8FBE7
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 18:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA48A3ABFC5
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 17:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E982EDD6C;
	Thu, 27 Nov 2025 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="MIVq0snt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D880B2EFD8F;
	Thu, 27 Nov 2025 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764265390; cv=none; b=MewhSXLO6ylWO0YikFoGGMFI4AzgbSUfsb8RR18noVlGnwyRQo2Jq0lHavQxO3sNM49VHvPpruxV5mD7rlNdTkxLZVtYLJLEcfL5UTX9ehnD5eZUtT/MbGpcaMjezsBeDFswXSkL4cGBwWb2p5O1tjT7HjJzoJoIjlOHYdxSgyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764265390; c=relaxed/simple;
	bh=JuuK9dt0RwhVCyHH4XjPC7KjOchaPXHlGe5Dqh8rv/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WM3vIq4po5Q5NwOFNx4UAEw7mEMOKAQBaSDCINcMOlxaOXRqLMdVjfjMckuO5YEGK3Qjrj4GY9wi2Ddn49KuuPpZ4noD51akX5qaepdgMZqHF1E04GSmNQL/XKArQmR5PRJenye+VffVrOdMckw3bpnfA+t7+MTKvG7OyOyUX3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=MIVq0snt; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=fCgl254ccdh+08DpxRDFQjoRJloyFg/hWgha3lcPjXU=; b=M
	IVq0snthkWQebaXW7a5tF/9tf5p/XWvZ7QxoXzAriVoTR23WYoUFY5ntFkR8HkWfqRyTMAm1wdRlK
	LMw9akrzAv/QVyPUC4eZJ9OaOHkoM1anybkkMvbtOAI7uvUHsGc+xOR5TSxwtF1+dfjy18IUGVsOv
	cG6TNHXunU2Y3sIiLQkfz0ar6XNHmMhSUnZyumbq/Ln3ZeN5heahMOXBRaIp8gzBGaD9/tJceIA6h
	qnWJlDqwr1gz5UBi/D4XyVDgA19twtsPIhx54IIhikQZg7bY4kpoK39GjFO3WMdaEREwk9S/NAR40
	6+OwzCHTqg3LdjGETKZZXOX+Eyvge0TJg==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1vOfO1-003Gs2-1A;
	Thu, 27 Nov 2025 17:02:29 +0000
Date: Thu, 27 Nov 2025 17:02:29 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: Remove tpm_find_get_ops
Message-ID: <aSiEJWcmkADPHEOY@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tpm_find_get_ops() looks for the first valid TPM if the caller passes in
NULL. All internal users have been converted to either associate
themselves with a TPM directly, or call tpm_default_chip() as part of
their setup. Remove the no longer necessary tpm_find_get_ops().

Signed-off-by: Jonathan McDowell <noodles@meta.com>
---
(Separating this out from the exclusive access series, because I think 
this bit is uncontroversial and is a legit cleanup.)

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
2.52.0


