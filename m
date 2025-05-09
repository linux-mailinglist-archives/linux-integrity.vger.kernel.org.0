Return-Path: <linux-integrity+bounces-6169-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96197AB0DFA
	for <lists+linux-integrity@lfdr.de>; Fri,  9 May 2025 10:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD10F1C00196
	for <lists+linux-integrity@lfdr.de>; Fri,  9 May 2025 08:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC2427603F;
	Fri,  9 May 2025 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSGrhc3c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EE42749CA
	for <linux-integrity@vger.kernel.org>; Fri,  9 May 2025 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781075; cv=none; b=Xdkz8in3aVq/9QGQphzaxG3Y73XauBHr8eqdx/od61kMZvrP16OIkzk+78zZ3W2T4unwg7OZP2ovji4hoCoV23NDHkSC4zYpERhktRyBlMiYIeeAQdt6trcx+CsGzN/aKqi6oRu0xWut0uDxr4+lRQG53ZVwqYKaA/Hu71MbCic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781075; c=relaxed/simple;
	bh=OQERegVmsM9QvVsX1j9lmHiktOMTs/IV5jXHkAbPRL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZBwQUV0MBgVJNNfOIg/Eg3Ax0b8olGSjtTL1C3S8Uu8Su7GXHRc6oI+KYiKbLNprbhBBU51LPJ+1SbfojaCMXXp+htUi3qAnc2LT3dCQ1Uvyh2AUxZNJOgE9fwQkvZMa6Npr0NHB2t0xncoTiNI5i9/sqYGNt05Kzwqy/RjRTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YSGrhc3c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746781072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6gkeb/9Kdfy78P2DpuPGWOQmqeRSDCl/s8JKK0Bwndg=;
	b=YSGrhc3caM3RxHiK2Hzvl8JfAr/og/VoqNfowYbZfrYzFK9QKE+OWJf9VwlW6tXMzV+bqC
	9TXa/hZoymg9lulWmEP6itc2n4S1AntHRGzEZ6FWtJNdupSxWJi+D+w3ANRRPbPKvtl3l7
	E7cRj3ZWDYKfKMEe2PdrhLTLNh8jklI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-8jIpncQVOGOJwU-O0FSsAA-1; Fri, 09 May 2025 04:57:51 -0400
X-MC-Unique: 8jIpncQVOGOJwU-O0FSsAA-1
X-Mimecast-MFC-AGG-ID: 8jIpncQVOGOJwU-O0FSsAA_1746781070
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-acf16746a74so200267866b.0
        for <linux-integrity@vger.kernel.org>; Fri, 09 May 2025 01:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746781070; x=1747385870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gkeb/9Kdfy78P2DpuPGWOQmqeRSDCl/s8JKK0Bwndg=;
        b=P1Zr+gUhhbwbzfyFeltD+VsXvvYyuSgZ0lvhxtPMCi53yRS+0iFn6LNAy0/XCZv7G9
         0S99++bK1tZxqLcIIlC9mpxRdRMdc+XUYiTYvHgegh/RMjtwPGdxY5sg8pDnpMBDnw6e
         g8FW1yEpl7CRMpyfFLCiNBo+D0RoAqOXfPLrkk9OSh1yS+j6t2GBMsLILxWXiJy0ZU2Z
         op6NDnvwaeVKtUS8n2oqKSc1eT+EQHq31qTj1DCeNGJF08A0hDRVasuyzIlaI5aji4H/
         S0dw2D7fluFtLC1QeXjUh3YUx4RS8vXRFsBVhMNDszD1qpeZPKpeAcadeNzKEtNNwr2w
         f2dA==
X-Forwarded-Encrypted: i=1; AJvYcCUUCmDB7jZTPP2K+hhsZJdoRubPDt97c51RHaGTT0PkjZ8o60/nYa3HDXH15jUqUWNADu+WbR/vkZWQyn9+Wfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWSNGCLCqak3z1qNA6gkwTAGpFfz3uGDSfkEWrWBbm7qCDkhMf
	0GXEbrqGh/EtsXh4Qfz7uvRXp8Zy45o3G0PQQeaiePVmCyqkk8JaryYlCt9M3qy6ypoufDmtUqH
	9SnvKEG7kTYBnRKytJzeMvu0GGjOTqX0Giv22DMZIWimqpA3DRRqBbu1uyBikqIsPxA==
X-Gm-Gg: ASbGnct6Hw73AUkYrL5ceRulc+BgpvWyqF+II8qgwq7A2JxVJb+j8YNXEzXOW6Yhy55
	tetDlywQVgKJ1KSckbMcHxWJP9a9Y56rdG6AU4+EJb5uKxYKq4/U8wsRmsCeleCThkfI+TM3uLG
	Eq2QWPPVI67naexRKb+NWaRGoCeduD14a4WnzH6NPtVDnAIQZU38sI5qzM7fNbLaWa4GLzjlpNY
	GeUpz9TLaoQy2TF26QpJsv5nHcbnaLYLPuiTMcwIdKftiR1hPg5gapsIoru/6xEpsM8p4JNiuAk
	1BZTqD1SD5NW3OGdd0P78p1Avg==
X-Received: by 2002:a17:906:ba90:b0:aca:cda4:9aae with SMTP id a640c23a62f3a-ad21927d0d6mr208672266b.37.1746781070379;
        Fri, 09 May 2025 01:57:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm/6oRhoG7o/lfsJVdPERf6/D/JJirfP83vdMoj15DtJopabMpuCr2u+MViV0A2cvILTEMug==
X-Received: by 2002:a17:906:ba90:b0:aca:cda4:9aae with SMTP id a640c23a62f3a-ad21927d0d6mr208668366b.37.1746781069774;
        Fri, 09 May 2025 01:57:49 -0700 (PDT)
Received: from localhost.localdomain ([193.207.182.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad219348781sm119504566b.61.2025.05.09.01.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 01:57:49 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Naveen N Rao <naveen@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	linux-integrity@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicholas Piggin <npiggin@gmail.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 4/4] tpm/tpm_svsm: support TPM_CHIP_FLAG_SYNC
Date: Fri,  9 May 2025 10:57:13 +0200
Message-ID: <20250509085713.76851-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509085713.76851-1-sgarzare@redhat.com>
References: <20250509085713.76851-1-sgarzare@redhat.com>
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
v4:
- reworked commit description [Jarkko]
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


