Return-Path: <linux-integrity+bounces-6485-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854A9AE1B9C
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 15:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DE897B0ED8
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 13:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6C1299AA1;
	Fri, 20 Jun 2025 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYwH43wz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3917928DEE2
	for <linux-integrity@vger.kernel.org>; Fri, 20 Jun 2025 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750424942; cv=none; b=Sob0RiJ+jZgYAq93e80XV8oG5H0gWYqnh57aBSQEFcFEqfDGm2y238+AOMfGyhnIjp3u/cwbaGhEABKlAXnSDSRIY1QTd5dOWRZdJdKYsXjAl84fU6hZgdlKPOiUlVWbAkeSE18ovbxHGuyrmv8sS27BiNt4GUOVj3eogFzPlBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750424942; c=relaxed/simple;
	bh=r704CciIs6S8l1HQAxMJ8T5ehpg4WbCdT2WeOTpKhmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ey4iJsoReK4b6lRm8DFheXkWuwyqXXGQydq7TcUoNP8mDrVZy/9mkZMzNFv8ykdmyZ8ybSBeqD8u50heUCgke14gBRkgetgItXthrhQEDMYADtoKUZCywJIAaWQaaDq/UYVzOy8ngHW8EPq4L/Tb4E8ol1fosFki9F+rm6BSF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AYwH43wz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750424940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dM1iIgQEOaOLBHShUWBj9x+RovZVG7Za/6uALilylTw=;
	b=AYwH43wzpj3b+tIulaSovDTTVS4J3ruRn3RmfL759qMDxGAMpl5G9lmTe+MYv6DbcJpVMa
	AP24oRjVVYqogwHBvxVxEOPt6G/FnVGYX5gvrCKcz0FKezRspUOIowag7yHjd+eznlpy/d
	0JihPkpNAPJKD/jBG6l5lD1wqkTLDXg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-Si9ZIjQ7MN66beEN3psi3A-1; Fri, 20 Jun 2025 09:08:58 -0400
X-MC-Unique: Si9ZIjQ7MN66beEN3psi3A-1
X-Mimecast-MFC-AGG-ID: Si9ZIjQ7MN66beEN3psi3A_1750424938
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a37a0d1005so1125890f8f.3
        for <linux-integrity@vger.kernel.org>; Fri, 20 Jun 2025 06:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750424938; x=1751029738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dM1iIgQEOaOLBHShUWBj9x+RovZVG7Za/6uALilylTw=;
        b=BvZQffRKK+hcnFhfJRizEXDTctp64KKg/MQAvNa5nrQfxnj0MQRRmzmrlcljICZbJt
         Hz40aae/dvG5BcG8gSI47gD1FOMxkMJeSK1fBGGSuse0IdJREaAtzwJD5bYShIPZyA6Y
         AKyPP+SyRCMiKWQFXct0saU6ImEs2Z3cVkmtMatDd9PDCTJFWGTR79entsAeTNtBTKXd
         ESniFlTtBjau+osGvVP2hvydT+zN3eClggBFeH/V4TdReyzLeqqp62XshI2TH6cEH/mR
         7K5xhTk0R2O2Dw620I7nylfmHJDnc69grnsBQSJ5/Cpu1EkTYlywDHLxt1jkWTTq+vYb
         KZtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuqh30nUmee5Ct8AmYW2Bi5c/Zz9TxvY1DJz/a7swE9x26/4ir9Bvhh2sPcgIVuvmBQM+MIcOPbDom6ro1r1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQYWjmcLz0AiQTKk4+xWpBcomJmnjMcWxv/d/xa8aQo8RLvqcm
	6xoW/IFLlhWxSqcLHaluLLvLVGLNPn6vg9yjQ5co2Hsx8ugAwJf6r5vcMaekIo86at++kmjQKjD
	L5VEdcMgpzJiRyF7Me4RCBYOpQKhtJqeyRD2NW40E0mt23ieU0RxlsLTqBelN5bheUOm8cw==
X-Gm-Gg: ASbGncvq/ry2oUOZpBirbfEAiqNghCrGzAG+DuMGYBBfZefbaMsjQTFaOnB5Bo0u5+1
	TVJfH4rHLkFj02/auhKFMRcv4C4ojF5gh+TbWE0PsITZ++ITf/qy8DBm7U8gi4JwOe3Xkt7icz5
	Hz+L07NDL2u+Q4110B9jGdQSUe2p6Ns1zX0B8pfKBVRp3qm5jmmP2gM/v6vsSj/agdiT8IizfzP
	tY19aEPf5xHjnPDxQl1HwoLOOHrYtbFZmeW7Qr/qQp9Oa4ex0jvAfp4+cH3uT89DnXRHyNLkL5B
	YesNIWVngYjQFdw2pA1VEtkyJgH9FnyD14M=
X-Received: by 2002:a05:6000:23c1:b0:3a4:fcc3:4a14 with SMTP id ffacd0b85a97d-3a6d13176fbmr1522859f8f.34.1750424937549;
        Fri, 20 Jun 2025 06:08:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErCfEU/IVq7uI6YOAV42Q6eu/6bPqI5NWLxqRlPFpxO3LmsQRBOu3Tts8nxYdGgHaYTR596A==
X-Received: by 2002:a05:6000:23c1:b0:3a4:fcc3:4a14 with SMTP id ffacd0b85a97d-3a6d13176fbmr1522807f8f.34.1750424936821;
        Fri, 20 Jun 2025 06:08:56 -0700 (PDT)
Received: from localhost.localdomain ([193.207.146.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f18215sm2026391f8f.29.2025.06.20.06.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:08:55 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Naveen N Rao <naveen@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Nicholas Piggin <npiggin@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v6 4/4] tpm/tpm_svsm: support TPM_CHIP_FLAG_SYNC
Date: Fri, 20 Jun 2025 15:08:10 +0200
Message-ID: <20250620130810.99069-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130810.99069-1-sgarzare@redhat.com>
References: <20250620130810.99069-1-sgarzare@redhat.com>
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


