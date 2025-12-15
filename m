Return-Path: <linux-integrity+bounces-7994-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54968CBEA60
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 16:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B24D3007683
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 15:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A218734106A;
	Mon, 15 Dec 2025 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DEg+dULy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80168340A6B
	for <linux-integrity@vger.kernel.org>; Mon, 15 Dec 2025 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808288; cv=none; b=eHMV/WdQb2dPRs+twpItRcVe2/i2uGIqAWxBNmjcUjgzLl7OMEu46oGcjhvYm9L567q+TGUcqKJ/6tdOoQ5Xgbx/2RpAbWLYxWigHUUAqc4IVskxhk/o3yDjrJ1iz/dG0EuUAqg2kvQOm1NgdxxbSIB0a/DHTbSBCYgrYrJqJuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808288; c=relaxed/simple;
	bh=2qrjsylMFa+SF9mw2N00GCNY0QrYs1HpZggQBT0ZSoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czsdNUocE3qaiKosWjwXHc/94PFlpPlJWz5Rk0Dqi8IEdFSBVIaG9QScrJYRdHmizu02NcILuHQl0xDiI3YtFXhvbMvhhJKue94ljswcNta5Z6A/JM9a6qrIyswo3+JquUUqppEY+8O+IzP+EvBALH7i9jjETEYZ69pTVxHDxtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DEg+dULy; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b727f452fffso540290566b.1
        for <linux-integrity@vger.kernel.org>; Mon, 15 Dec 2025 06:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808285; x=1766413085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yBB10wIDhntVhF7Adi7eu+afyFDfQDzYe1DB3rR/Q0=;
        b=DEg+dULyuiSawNLqDUWOk0sBimSO4cini80bKuQroBmoyPs2ifn4wk1fyM32x5jVQn
         YqNOWJ6slYUY4uzdMf5nTM5qpjNwTzf97Kq9603te3kJTdOnXFX6SQSNSKBYMLFbyFwF
         W3IxskTPCNWHxKHbXMz0tvwizUyGv6/gXCdPMJviC1KybAxYuCCPRCFV7g/+9i3F175Y
         /L+/vwYt7DwY/mOMrXWswNQ/bcP+q8ToCy1IXnUP6NiqfAw3JVI8kY/ph6h4zirCeOjS
         6PWvNhQYHAuiJ6oaHzV/tGCVCviahxp6mnJdWg6LLPXiUQwC8ZcqnSVmsnasgb5/A/go
         6fEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808285; x=1766413085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2yBB10wIDhntVhF7Adi7eu+afyFDfQDzYe1DB3rR/Q0=;
        b=tTQi46tOCMgIyXFBgpMJ0Al6zsUjERyYhdyVFSOuhKGROghxn/dGMfrIUk/1KFrQJQ
         C0NxTko9HB17HyIIYLn6URDw/o/qUrdhjsJpEmgLQSecPOUM8iL6KLK6wdjUEGOEN27W
         2mMttIsY9/IC3hbbigg5wxmWA/XGSLEhI0GYtMEfc15UaT7Knsreu8ZWZZfGX0gMJ3E8
         1rYDDPTMrDqlw6ivVEhkimkvyCSzyaIKJs7zQUoAvCjDq61NVsrhB7XHCB87xIz2aSRy
         saPByF4ID9cp6vsccUkSLTsINW9gV6DT13v7yar2uF96WBrk7/mzLT/T0KBNP46AqT4r
         GipA==
X-Forwarded-Encrypted: i=1; AJvYcCUFlL/pVe02R3S5m0FR8oygx1eS8Qjg8bHRo4mSeg4tBPiDd6nRuqA1KQjT3CoYpeCv68CDiwwwohNJN+/Us7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqvlTFwFbr3mJGiMcQj23+azTUSoVJRPirrQOk8waMXy8fUjUK
	3o4P+IGWSAbmRIhSLno3E7WhfD8G6/GdrxQ4Q20do99GiZlihC/Tk5cLMUN91m0Z+6k=
X-Gm-Gg: AY/fxX7JLo9B1TGsue0nJRl28Zg+WKK92fRwtRPo8ceFJ2TtBV6dE8GfCTDLAy9wbgt
	yeLrBv9sOBltBpeBQZRI0vbSVcb83flTfJzx2brioiDcqTAVLitpJ2HiWtHlByqnVfWWTHy29vG
	OVk2NKkb05FKeVdubr2KkFkLfUeI0MzgaQDaU8YSke/XgfQBUrz7NTwrrLGL16fgG8gQi3lVKJx
	cg+0Bezx+wD2Bp46tQHrCuOwIHpRIAfJHGAV6m/+wrv4pqZ+sBFqzsPnxZ17TCbotlchxiIqEga
	ovjCBepEAxuZWxo/sgLcJPKizBVBWD2tuZ5MCL3ILlExLHxYAeOPnopu16aeYa0wE8pOkJbIruR
	s3XOWVDg1fWh0hMLeCuKCpatUq4iy3xpCYIenenG94GjgRQ8AnZHE8rPjmLMGvOP5m5KHFMIGCb
	YogY78gacPwnhxmzWRz6h+UHfgjONE8xmqhotE/XVOOI5A+rEfAgzmP2ygSg==
X-Google-Smtp-Source: AGHT+IFo9FOJaDLcFkLTxYDl5ZKYhlEDF+L2OGvBOrKgVtsuxe0NnsUtGKir1wRggxQLMFuuLtm7wg==
X-Received: by 2002:a17:907:d17:b0:b72:6a39:49e6 with SMTP id a640c23a62f3a-b7d217ed7b0mr1542327266b.18.1765808284912;
        Mon, 15 Dec 2025 06:18:04 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa5191fasm1381389266b.33.2025.12.15.06.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:18:04 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Sumit Garg <sumit.garg@kernel.org>,
	linux-integrity@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v2 17/17] tpm/tpm_ftpm_tee: Make use of tee bus methods
Date: Mon, 15 Dec 2025 15:16:47 +0100
Message-ID:  <7bb98eeb8a478ca69344499f2e58016bbf787313.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2647; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=2qrjsylMFa+SF9mw2N00GCNY0QrYs1HpZggQBT0ZSoQ=; b=owGbwMvMwMXY3/A7olbonx/jabUkhkwHidK6wz4Hj+uVpPCJP5L6dz43PaivJl/576HsdzNjg k+37LfqZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAiV9vY/3CuuRiqe+tigNLE zW45WUxXPM81bz1gJrHHjzPDZK1B5bmtKv0qDikNS332dTGsMM//cnzPnpCOHQ7b4s7nH6mRmNy h2Mr/K351jGpfltHDY9ILs3wuRTxbu+Ii42WVR1GT2ty3suyNDFdYEn0110V2pcbl/dKPN87dqd tVumRqJ1e5zFVJJyuxd7a/HVIFc3OEoyM+20c+1czzlzAT0W24NKnw5VERz6W8h1/u7+zpUwk4I 2Adqs7xJPfTFi+zWTVPpngmFjzIfuiumqiWvGEeo8SL9W9dCiPecLhITH/aEhMUOelChlO7fWOt mVtRUWyZW5roy12OJz7cMP9TLG3FZ6Uj0jzlQpXK+psA
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The tee bus got dedicated callbacks for probe and remove.
Make use of these. This fixes a runtime warning about the driver needing
to be converted to the bus methods.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index e5fbc70b0eca..20294d1953a3 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -169,7 +169,7 @@ static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
  * Return:
  *	On success, 0. On failure, -errno.
  */
-static int ftpm_tee_probe(struct device *dev)
+static int ftpm_tee_probe_generic(struct device *dev)
 {
 	int rc;
 	struct tpm_chip *chip;
@@ -251,11 +251,18 @@ static int ftpm_tee_probe(struct device *dev)
 	return rc;
 }
 
+static int ftpm_tee_probe(struct tee_client_device *tcdev)
+{
+	struct device *dev = &tcdev->dev;
+
+	return ftpm_tee_probe_generic(dev);
+}
+
 static int ftpm_plat_tee_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
-	return ftpm_tee_probe(dev);
+	return ftpm_tee_probe_generic(dev);
 }
 
 /**
@@ -265,7 +272,7 @@ static int ftpm_plat_tee_probe(struct platform_device *pdev)
  * Return:
  *	0 always.
  */
-static int ftpm_tee_remove(struct device *dev)
+static void ftpm_tee_remove_generic(struct device *dev)
 {
 	struct ftpm_tee_private *pvt_data = dev_get_drvdata(dev);
 
@@ -285,15 +292,20 @@ static int ftpm_tee_remove(struct device *dev)
 	tee_client_close_context(pvt_data->ctx);
 
 	/* memory allocated with devm_kzalloc() is freed automatically */
+}
 
-	return 0;
+static void ftpm_tee_remove(struct tee_client_device *tcdev)
+{
+	struct device *dev = &tcdev->dev;
+
+	ftpm_tee_remove_generic(dev);
 }
 
 static void ftpm_plat_tee_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
-	ftpm_tee_remove(dev);
+	ftpm_tee_remove_generic(dev);
 }
 
 /**
@@ -335,11 +347,11 @@ static const struct tee_client_device_id optee_ftpm_id_table[] = {
 MODULE_DEVICE_TABLE(tee, optee_ftpm_id_table);
 
 static struct tee_client_driver ftpm_tee_driver = {
+	.probe		= ftpm_tee_probe,
+	.remove		= ftpm_tee_remove,
 	.id_table	= optee_ftpm_id_table,
 	.driver		= {
 		.name		= "optee-ftpm",
-		.probe		= ftpm_tee_probe,
-		.remove		= ftpm_tee_remove,
 	},
 };
 
-- 
2.47.3


