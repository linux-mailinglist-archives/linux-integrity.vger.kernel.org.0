Return-Path: <linux-integrity+bounces-5661-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 421BDA7F7F7
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 10:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17387189DB24
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 08:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE44B263F4D;
	Tue,  8 Apr 2025 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ra7NiWGY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145BD264611
	for <linux-integrity@vger.kernel.org>; Tue,  8 Apr 2025 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744101151; cv=none; b=GxQNFioi4wqFJw1BhqKZoHKewaZ2kC6CoLFv4mXj5IhhfuyJsaYH7Ul3p/SHAd9pev8OAFq+Ml3aG4eNqK7PImGwLLfalPmn3HNw0ff+znSkwudCb6WPNaGFnS4kPPJRFRkXn5ye8g6m9VrgIPEIt0jFMXZIvdQNctC+SZ/G6Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744101151; c=relaxed/simple;
	bh=U1qC/sy3KM3pFlSOrOxYv2VmI/J+Xj4HkqFlDY7nkB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oybUemCMZAWjlISjzOTyUbEGP7ItA2Qc66m6wb5wxUYNghbqJyKrIUzjiOZohrFebMt0c1LRA3n32b6omYnJU9vVTe49JiBUJ/+8W9ZMTyW03DYQPMzhM+ezd8Y6sIrDZfYn51nNht2Qt44DyV8T9YAjAvkVa1nkjxTuKaHPyIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ra7NiWGY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744101149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jjogm03xe8uH9FEbFpCE/wwTjsk8lbbHkAYLp5l0W8=;
	b=Ra7NiWGY0V4yEsseV5LOEAtiUvOTi+cknemd1ClGoKoo244WO5z3bkB9TiJoyu4OpVSeJd
	1x4Ji27kZQtk1zEEJ6gUxFUXkPvAff8AIro/Zrmcm7Go7r0ziH1D8Bi79+bS9uTJz8ujk7
	BAMgEZqq62VPgdeRMljK2BRClxjHyrg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-jWz-R_FOOCWHf4yHIUVw4w-1; Tue, 08 Apr 2025 04:32:27 -0400
X-MC-Unique: jWz-R_FOOCWHf4yHIUVw4w-1
X-Mimecast-MFC-AGG-ID: jWz-R_FOOCWHf4yHIUVw4w_1744101147
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so43657795e9.3
        for <linux-integrity@vger.kernel.org>; Tue, 08 Apr 2025 01:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744101147; x=1744705947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jjogm03xe8uH9FEbFpCE/wwTjsk8lbbHkAYLp5l0W8=;
        b=vaj6eIufdaUq4A/0+I121cB9OZiLIL+WlJZgFoPzn3KA9kydXkOB9przgB/YtRcKPV
         c/czuDbpyH83D8ok1ErL/UE0/FJvOVZo2UJclhYqjhOGi77GJk6oBKd2FFCUAO8YMz1H
         RkqfHE/e2bG2mAUBN65bgzsHYg03i9ryTCczC+TNyjTaSTTOBs/X4kAswl9+ucWjmn4M
         lwZXDj+Qr3ACen9HvpddOAZTqjpx9op9Jux39L//R4NN1v3JcDVpE0MODDLIxYCNvjTq
         vNcq0GskG9TFlUuo4WSgezdzWVCSkPMqN/x/NW2whRcRr9BcgqB1Eo5gCCdKQOl1mEsF
         fnsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq5n/Ua93nxyqV8cZni0r/rXuz/Cx0wVkAOg2Khwk8eLxqR3w4MglOoK9apqUx7VuxzWrXtPAfK2/fIFj6Xpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqmWTNyQGuQ9TPAgCDWXwiNl19xwoMd75Qd5/MnMIT3z8vZGaZ
	goQZ9/oTASB/5WulWopW+OgNAJLW9BZNRYoIRDMwYGRdAiMKt6Q2oUplk58pBNcPThlYM+MSCia
	vlxzJUK5Mi+06DXSGtcT9LQkOg48TI4+pqobYQLPeQAnoCjo8HofI5MWgFY6CesS9RQ==
X-Gm-Gg: ASbGncsBSAP2GfI06tlnip36ZSyrpYb4liTCraBxxC0vT/626wYK0HB1weSyYFTcuES
	AVo3+US4Qsnpl4hE8sG1vYnHS3Q2icQ8Gy0i9tYFC2q+IbvTkxwGVQgIpZlvQ4A1Ln/i2sSCOjl
	LqnN4pfnxI2d0czbPk7/KqNjKNvWizIi4P0WyVdLrsZ10TUMFT17rPzELBz8dQLpigZxXIJ7CLy
	9DFod3sojdn+j4WYo9gbfWkmrKjSOePS/Sd91dQQ8L5TRTV7FZPJJPfQNlSL5JbpWkMGjJQEOu6
	GmwKKZsiwhDZC2tFtPaDZ72KUyRGBvB37QTwwPGemBDyD+HSZ1rGHDo/bIFQ9FI6Pw==
X-Received: by 2002:a05:600c:3489:b0:43c:f87c:24ce with SMTP id 5b1f17b1804b1-43ecf9c77ecmr122637485e9.21.1744101146620;
        Tue, 08 Apr 2025 01:32:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO0mHtfU6tjdIaTwIU3mFKYSEAXTq1PTv+mq26VUWkOFRfaSqPIV+zWD9QaZteOnlwamweeA==
X-Received: by 2002:a05:600c:3489:b0:43c:f87c:24ce with SMTP id 5b1f17b1804b1-43ecf9c77ecmr122637075e9.21.1744101146092;
        Tue, 08 Apr 2025 01:32:26 -0700 (PDT)
Received: from stex1.redhat.com (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d661sm14565216f8f.66.2025.04.08.01.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 01:32:25 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org,
	Jens Wiklander <jens.wiklander@linaro.org>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sumit Garg <sumit.garg@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 3/4] tpm/tpm_ftpm_tee: support TPM_CHIP_FLAG_SYNC
Date: Tue,  8 Apr 2025 10:32:07 +0200
Message-ID: <20250408083208.43512-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408083208.43512-1-sgarzare@redhat.com>
References: <20250408083208.43512-1-sgarzare@redhat.com>
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
don't need the 4KB internal buffer used to cache the response before
.send() and .recv(). Also we don't need to implement recv() op.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
@Jens @Sumit can you test/review this patch again since we changed the
core a bit adding TPM_CHIP_FLAG_SYNC instead of send_recv() op?

Thanks,
Stefano

v2:
- set TPM_CHIP_FLAG_SYNC and support it in the new send()
- removed Jens' T-b
v1:
- added Jens' T-b
---
 drivers/char/tpm/tpm_ftpm_tee.h |  4 ---
 drivers/char/tpm/tpm_ftpm_tee.c | 64 ++++++++++-----------------------
 2 files changed, 19 insertions(+), 49 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.h b/drivers/char/tpm/tpm_ftpm_tee.h
index e39903b7ea07..8d5c3f0d2879 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.h
+++ b/drivers/char/tpm/tpm_ftpm_tee.h
@@ -22,16 +22,12 @@
  * struct ftpm_tee_private - fTPM's private data
  * @chip:     struct tpm_chip instance registered with tpm framework.
  * @session:  fTPM TA session identifier.
- * @resp_len: cached response buffer length.
- * @resp_buf: cached response buffer.
  * @ctx:      TEE context handler.
  * @shm:      Memory pool shared with fTPM TA in TEE.
  */
 struct ftpm_tee_private {
 	struct tpm_chip *chip;
 	u32 session;
-	size_t resp_len;
-	u8 resp_buf[MAX_RESPONSE_SIZE];
 	struct tee_context *ctx;
 	struct tee_shm *shm;
 };
diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 637cc8b6599e..b9adc040ca6d 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -31,46 +31,18 @@ static const uuid_t ftpm_ta_uuid =
 		  0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x96);
 
 /**
- * ftpm_tee_tpm_op_recv() - retrieve fTPM response.
- * @chip:	the tpm_chip description as specified in driver/char/tpm/tpm.h.
- * @buf:	the buffer to store data.
- * @count:	the number of bytes to read.
- *
- * Return:
- *	In case of success the number of bytes received.
- *	On failure, -errno.
- */
-static int ftpm_tee_tpm_op_recv(struct tpm_chip *chip, u8 *buf, size_t count)
-{
-	struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
-	size_t len;
-
-	len = pvt_data->resp_len;
-	if (count < len) {
-		dev_err(&chip->dev,
-			"%s: Invalid size in recv: count=%zd, resp_len=%zd\n",
-			__func__, count, len);
-		return -EIO;
-	}
-
-	memcpy(buf, pvt_data->resp_buf, len);
-	pvt_data->resp_len = 0;
-
-	return len;
-}
-
-/**
- * ftpm_tee_tpm_op_send() - send TPM commands through the TEE shared memory.
+ * ftpm_tee_tpm_op_send() - send TPM commands through the TEE shared memory
+ * and retrieve the response.
  * @chip:	the tpm_chip description as specified in driver/char/tpm/tpm.h
- * @buf:	the buffer to send.
- * @len:	the number of bytes to send.
+ * @buf:	the buffer to send and to store the response.
+ * @cmd_len:	the number of bytes to send.
  * @buf_size:	the size of the buffer.
  *
  * Return:
- *	In case of success, returns 0.
+ *	In case of success, returns the number of bytes received.
  *	On failure, -errno
  */
-static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len,
+static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t cmd_len,
 				size_t buf_size)
 {
 	struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
@@ -82,16 +54,15 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len,
 	struct tee_param command_params[4];
 	struct tee_shm *shm = pvt_data->shm;
 
-	if (len > MAX_COMMAND_SIZE) {
+	if (cmd_len > MAX_COMMAND_SIZE) {
 		dev_err(&chip->dev,
 			"%s: len=%zd exceeds MAX_COMMAND_SIZE supported by fTPM TA\n",
-			__func__, len);
+			__func__, cmd_len);
 		return -EIO;
 	}
 
 	memset(&transceive_args, 0, sizeof(transceive_args));
 	memset(command_params, 0, sizeof(command_params));
-	pvt_data->resp_len = 0;
 
 	/* Invoke FTPM_OPTEE_TA_SUBMIT_COMMAND function of fTPM TA */
 	transceive_args = (struct tee_ioctl_invoke_arg) {
@@ -105,7 +76,7 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len,
 		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
 		.u.memref = {
 			.shm = shm,
-			.size = len,
+			.size = cmd_len,
 			.shm_offs = 0,
 		},
 	};
@@ -117,7 +88,7 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len,
 		return PTR_ERR(temp_buf);
 	}
 	memset(temp_buf, 0, (MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE));
-	memcpy(temp_buf, buf, len);
+	memcpy(temp_buf, buf, cmd_len);
 
 	command_params[1] = (struct tee_param) {
 		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
@@ -158,17 +129,20 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len,
 			__func__, resp_len);
 		return -EIO;
 	}
+	if (resp_len > buf_size) {
+		dev_err(&chip->dev,
+			"%s: resp_len=%zd exceeds buf_size=%zd\n",
+			__func__, resp_len, buf_size);
+		return -EIO;
+	}
 
-	/* sanity checks look good, cache the response */
-	memcpy(pvt_data->resp_buf, temp_buf, resp_len);
-	pvt_data->resp_len = resp_len;
+	memcpy(buf, temp_buf, resp_len);
 
-	return 0;
+	return resp_len;
 }
 
 static const struct tpm_class_ops ftpm_tee_tpm_ops = {
 	.flags = TPM_OPS_AUTO_STARTUP,
-	.recv = ftpm_tee_tpm_op_recv,
 	.send = ftpm_tee_tpm_op_send,
 };
 
@@ -253,7 +227,7 @@ static int ftpm_tee_probe(struct device *dev)
 	}
 
 	pvt_data->chip = chip;
-	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2;
+	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_SYNC;
 
 	/* Create a character device for the fTPM */
 	rc = tpm_chip_register(pvt_data->chip);
-- 
2.49.0


