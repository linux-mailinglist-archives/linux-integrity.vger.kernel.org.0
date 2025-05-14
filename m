Return-Path: <linux-integrity+bounces-6213-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D265AB6D31
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 15:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B870C3AB4B1
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 13:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809D727B4EE;
	Wed, 14 May 2025 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FmgYhhnP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9D127AC39
	for <linux-integrity@vger.kernel.org>; Wed, 14 May 2025 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747230433; cv=none; b=m+JrksRHFjkjaa0vUZe6hpVpz521taR+KszQwhgmivaAMyHo3wb1pytzgKsNwNsz6FQJqa10bezQ7F1iU+eIpRN+lJIyDAcmZgNUOFbqLRcBjG7fFFc4rUITE3lEEaDd3/CGrOT+hBNyhCMrhM2ZW6oRXrFlQUI0PQybnwdmaws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747230433; c=relaxed/simple;
	bh=r704CciIs6S8l1HQAxMJ8T5ehpg4WbCdT2WeOTpKhmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBFVu3tl5238R08Qw7c33plrQGfIamVo+dJoqC9XRv3xwvA0pVuqHCye2346r9YOpJ4IKz3Ck5QVmJ6f6uzm9gSWdIHPNroo9mgdy2hN9EzXBY5Xu9gDuC+ZPiwYmjycjGvCU9Yuuq5mjeLmhXtaI8lk1ksSD0/gxbFVd8mWSSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FmgYhhnP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747230430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dM1iIgQEOaOLBHShUWBj9x+RovZVG7Za/6uALilylTw=;
	b=FmgYhhnPiqYtp65Cn3n+JlomuP0/8PLLaiOEam5+ssZ3pvptRumKSr4/6/wO/U7t8zg97m
	/aa5spLpf+TNUyQwZIXgpwf16YL2DE3nWozWIuMl9/pXhSblfX+E5K8XZki2ViNVsjKZ9d
	vWHsF87C8suyqpZ4jewvAUTuJjcqSrw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-UBgcJcaXOR6aF0kr1kI0lA-1; Wed, 14 May 2025 09:47:08 -0400
X-MC-Unique: UBgcJcaXOR6aF0kr1kI0lA-1
X-Mimecast-MFC-AGG-ID: UBgcJcaXOR6aF0kr1kI0lA_1747230428
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso5147045e9.0
        for <linux-integrity@vger.kernel.org>; Wed, 14 May 2025 06:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747230427; x=1747835227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dM1iIgQEOaOLBHShUWBj9x+RovZVG7Za/6uALilylTw=;
        b=JlVnXKzp3Du9VYfRmwTO73CIor8h8B97xm/HNz5622NXZrCXmFpUwFIPU2uWqVzxOU
         /kqtM0D+8lH0321t9VhcMGtUSu9uuWaReOsyI15CdJXSBGyRWZeZCd1sVzewpboEtXkZ
         EzsCDpuV5nTfOmoVGSb3s9qjUtf25GrXYgtUm7LIxBfMU18X84jR2P1640TtiIh2rKmI
         B8x+qk7s9u5NXNj+2mHU8L/8kyit5D5DJyQRbyKAWJsC5WmREd+5xlYzHs991j149djB
         X9VUJ8zexucWg5sxt8QwpwDUM+0GT2RFudaXfIzT+WQ1rxSCxEVyvw/wLugmqqG6CEku
         gxPg==
X-Forwarded-Encrypted: i=1; AJvYcCV76g/g5tlIQFDWP6z7iSmogXG0iuFcSYFGTwMO1UNcZh4wu6BmU5xNAyPomHaAPfcxDsMYBF+bqAjgrfoK9v8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Z424IMwkhWvyCROrH8Ri7urlKieF/q2J7auob5pR8IfjdAfx
	hkVahbV60+Zywlxjg4AUTtnsB1gwyWbILTqSWc2HpakC5T00Axswhn39KsNQuoi8ruzPdgx2afS
	amcF5KrwV0PhPF/5iu+okvUvHDUlgaRU90ILnlcLBeO/0bwuzVtegaKPO3NmM1sMovQ==
X-Gm-Gg: ASbGncvYSpnbFBoS037nZh04ugfCdlFGU9wZUba2me4No+e51R0O6P9wmjYlcTBS+1B
	0ZFWiEG4wLivFr4W1GWUN7jeKjDKgIiEungjRRKOTgLLk5yhvYzpGGRBwknx+0KFWoBYs590hFp
	WrofWWosmJdvoCDg2htN24GOP9CmI/fJPFYmz4wFaqqaQfkNkD6r6/HYe9kjN1MNFN2y1/BTQeX
	3ukhSfqjuEZFHpOlwWAt1IgygFs6/KsZ07Z/QENrpDI2GYgZGiHxP1WNCO5OueOg00LWAgScaS9
	BdeG3lAIsQHosjnVyx0=
X-Received: by 2002:a05:600c:4f53:b0:439:8878:5029 with SMTP id 5b1f17b1804b1-442f1a0d906mr28926315e9.2.1747230427579;
        Wed, 14 May 2025 06:47:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQcNilqw5pw/zInUa+0ub8X2j9IE5W786j2MgQiDjsofCPC9ebkToa0QhXEfe/ocJNSBGqaA==
X-Received: by 2002:a05:600c:4f53:b0:439:8878:5029 with SMTP id 5b1f17b1804b1-442f1a0d906mr28926015e9.2.1747230426999;
        Wed, 14 May 2025 06:47:06 -0700 (PDT)
Received: from stex1.redhat.com ([193.207.148.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3380615sm30931135e9.16.2025.05.14.06.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 06:47:06 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	linux-integrity@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 4/4] tpm/tpm_svsm: support TPM_CHIP_FLAG_SYNC
Date: Wed, 14 May 2025 15:46:30 +0200
Message-ID: <20250514134630.137621-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514134630.137621-1-sgarzare@redhat.com>
References: <20250514134630.137621-1-sgarzare@redhat.com>
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

Enable synchronous send() with TPM_CHIP_FLAG_SYNC, which implies that
->send() already fills the provided buffer with a response, and ->recv()
is not implemented.

Keep using the same pre-allocated buffer to avoid having to allocate
it for each command. We need the buffer to have the header required by
the SVSM protocol and the command contiguous in memory.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v5:
- changed order and parameter names to match tpm_try_transmit() [Jarkko]
v4:
- reworked commit description [Jarkko]
---
 drivers/char/tpm/tpm_svsm.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
index 0847cbf450b4..f5ba0f64850b 100644
--- a/drivers/char/tpm/tpm_svsm.c
+++ b/drivers/char/tpm/tpm_svsm.c
@@ -26,37 +26,31 @@ struct tpm_svsm_priv {
 };
 
 static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
-			 size_t len)
+			 size_t cmd_len)
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
+	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, bufsiz);
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


