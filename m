Return-Path: <linux-integrity+bounces-5869-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0833FA88664
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Apr 2025 17:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5FB1893429
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Apr 2025 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E338AD21;
	Mon, 14 Apr 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmAjw0qe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEAC274FDD
	for <linux-integrity@vger.kernel.org>; Mon, 14 Apr 2025 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642658; cv=none; b=OOamRO6W+MPiwz1cFa5oZtRqEh1kClnKwXVwmO4MI0/k8H+UiNmiP7xcB7sseCIanno38TT5rCcGl43zbMPAwV84lX0AxEigGCB9kgvjQIWKR7Nnls8lJR6kE2KXyHuhErqBF6i0OfuyUI2vVf8rxJtSo3cT/cYjXRiA3QRFda4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642658; c=relaxed/simple;
	bh=5uey/9jBuQQ0FWhgq32xA/AF8acy1iMqMDMOkX+Q4lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPus3rAfDa/oqw2BXz8R5F4Ysxb8KZQXxyV4EcMTB+U3cVl0GRCyktrNZEePOjZgv8rukcoFpre+J+8YZ7MhN4Nr1vPzBa1yEc9KUm29Mk9vNUNcvgA857mF12qEOecjIzcB9mJfehkNXPtwFpZCB/VaqTnV3yOXl2LlBy+C/+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SmAjw0qe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744642655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5sa1KMzPVUbpw2KNCiE/Fawx4j9zSiPJcyY6hcGjqFI=;
	b=SmAjw0qeqIUu2EF+eByzCgFnDdH69Y6XPNuhx03CVuPJ6r/cb2fjx+7pesP9px2Nv7p6G/
	YKly0gXhTOBbw6MJtd1w+Iag6O3dkBj1FliCeyJgfCDlmiKmk1Li3yc9x/AAHFvRLTRz53
	AeYV0B7PyEwRU+owPqI2PTyj8+CTJ+U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-Iu8YSyvqP2yqEVkO_es_oQ-1; Mon, 14 Apr 2025 10:57:34 -0400
X-MC-Unique: Iu8YSyvqP2yqEVkO_es_oQ-1
X-Mimecast-MFC-AGG-ID: Iu8YSyvqP2yqEVkO_es_oQ_1744642654
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912d9848a7so2692860f8f.0
        for <linux-integrity@vger.kernel.org>; Mon, 14 Apr 2025 07:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744642653; x=1745247453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sa1KMzPVUbpw2KNCiE/Fawx4j9zSiPJcyY6hcGjqFI=;
        b=Zzn/RHL02UZNDcDvGmV2g3XQGbumLbe7f/c1/KwIR6aUrS1liMmBtjhtUYgzavVHFZ
         d3te806pFRwI9pwUfBGsXJKCmvjaosP6i4aURLPXHeEY29q+j2MNLO3ceNc7MhYJyHzz
         8aD5alwP0oHA0UBR8+J8lUHy+sLOHJLnD5f0qOk/Qcw7fMuJUIPIpa7Hxa/nqHlTJFXm
         iXL/VYtjLyue8BRhRpek1TKtpt9s4GBlCJqBvHjgN1cucLHG9uVF2dyUzmxMh+oFgLbt
         HgWq+9lbQHQcq7O2xJDn3ABshc9REyhcJJ7qYb+lKpTGikaRcIpQ+D8+Xm61qeOOptr+
         W3aA==
X-Forwarded-Encrypted: i=1; AJvYcCWNQ2nFLT/220Q983ToYW7kz1r7oi1WUBBXLOzKy3Pw2sBfNvIJZgTbdYw/T+2NgHiZKx9CSj+jO2GuedetMe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFl4NakWtcU5KGaPRuMIg91QFyoCPAIjAy9CsNJWJm232W20MN
	I3r563GFRZ2IYZOS9kgjup5vTMCwgbv6rDh93AWBklsSROhkbFyCec9bu5hJGM3i0n5V7NwseD2
	5y8jkbOmXWPtKfhDZYrJkhuBY3wxKIKAoHXCUA/v8+WaoESGTuW4XRZVOGkRt1muFng==
X-Gm-Gg: ASbGnctlUi+BGZKH+eETZsyhYPbGjUHcDA8jA7C993SJMBsAKVee3V9GLzpkGz2h0+d
	BTY8G6omGMxFGvrWnLSIzb0/GF+DF8/HO3Q2Wtgqs+t5nJB/xI9FvMFRGKsgWQVM8jqhztblh7B
	z/uHDXxhbD3r2rIMAtEIRR8DuK3UYny0SZOIVTabCxI7GbeOfIAd8bigLXkllXdDQv8v/mQIoX5
	Sv8jUqlr/SX/FB2Ul9WzMPT12kpsZ+XxaUa90S3zr6NdKvYmYIkQiQcwGguzyFONo4nAuanXRcv
	DAl5RsMkZryU7j0RJYSJtNCQ
X-Received: by 2002:a5d:5f56:0:b0:390:e535:8750 with SMTP id ffacd0b85a97d-39e6e48846dmr9576041f8f.9.1744642653501;
        Mon, 14 Apr 2025 07:57:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUePoA8CXCKRWtYvnKKIInk/j0CbqjuJ2mLiXYjmccJQ4ZcE+fLBnmyZcdyCqfwL3pNjKyHg==
X-Received: by 2002:a5d:5f56:0:b0:390:e535:8750 with SMTP id ffacd0b85a97d-39e6e48846dmr9576006f8f.9.1744642652841;
        Mon, 14 Apr 2025 07:57:32 -0700 (PDT)
Received: from localhost.localdomain ([193.207.151.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43cdfdsm11483858f8f.61.2025.04.14.07.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 07:57:32 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Peter Huewe <peterhuewe@gmx.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sumit Garg <sumit.garg@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 4/4] tpm/tpm_svsm: support TPM_CHIP_FLAG_SYNC
Date: Mon, 14 Apr 2025 16:56:53 +0200
Message-ID: <20250414145653.239081-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414145653.239081-1-sgarzare@redhat.com>
References: <20250414145653.239081-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

This driver does not support interrupts, and receiving the response is
synchronous with sending the command.

So we can set TPM_CHIP_FLAG_SYNC to support synchronous send() and
return responses in the same buffer used for commands. This way we
don't need to implement recv() op.

Keep using the same pre-allocated buffer to avoid having to allocate
it for each command. We need the buffer to have the header required by
the SVSM protocol and the command contiguous in memory.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/char/tpm/tpm_svsm.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
index d3ca5615b6f7..db1983072345 100644
--- a/drivers/char/tpm/tpm_svsm.c
+++ b/drivers/char/tpm/tpm_svsm.c
@@ -25,38 +25,32 @@ struct tpm_svsm_priv {
 	void *buffer;
 };
 
-static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t len,
+static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t cmd_len,
 			 size_t buf_size)
 {
 	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
 	int ret;
 
-	ret = svsm_vtpm_cmd_request_fill(priv->buffer, 0, buf, len);
+	ret = svsm_vtpm_cmd_request_fill(priv->buffer, 0, buf, cmd_len);
 	if (ret)
 		return ret;
 
 	/*
 	 * The SVSM call uses the same buffer for the command and for the
-	 * response, so after this call, the buffer will contain the response
-	 * that can be used by .recv() op.
+	 * response, so after this call, the buffer will contain the response.
+	 *
+	 * Note: we have to use an internal buffer because the device in SVSM
+	 * expects the svsm_vtpm header + data to be physically contiguous.
 	 */
-	return snp_svsm_vtpm_send_command(priv->buffer);
-}
-
-static int tpm_svsm_recv(struct tpm_chip *chip, u8 *buf, size_t len)
-{
-	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
+	ret = snp_svsm_vtpm_send_command(priv->buffer);
+	if (ret)
+		return ret;
 
-	/*
-	 * The internal buffer contains the response after we send the command
-	 * to SVSM.
-	 */
-	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, len);
+	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, buf_size);
 }
 
 static struct tpm_class_ops tpm_chip_ops = {
 	.flags = TPM_OPS_AUTO_STARTUP,
-	.recv = tpm_svsm_recv,
 	.send = tpm_svsm_send,
 };
 
@@ -85,6 +79,7 @@ static int __init tpm_svsm_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&chip->dev, priv);
 
+	chip->flags |= TPM_CHIP_FLAG_SYNC;
 	err = tpm2_probe(chip);
 	if (err)
 		return err;
-- 
2.49.0


