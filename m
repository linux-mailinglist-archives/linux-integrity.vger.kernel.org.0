Return-Path: <linux-integrity+bounces-6484-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDE0AE1B9E
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 15:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D36A1C2063D
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 13:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819C529899A;
	Fri, 20 Jun 2025 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPZi3w+N"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B6A28C01C
	for <linux-integrity@vger.kernel.org>; Fri, 20 Jun 2025 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750424935; cv=none; b=t60hkJeZ1ur5DlPYy4qpnVL+ibP9omVKD4Dj7oNNMnGhuWYBvoxuYoUBJiO2LlvEuxKlHyBviItZTEbWLkKQzEqBk4GSNAcTwyqmaUtjmATL4Ivy87bTg9t+w5Slz855Kpvim/nriAQkS9dm8vqQ50kWk3E9/ia3fxWMnG1J+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750424935; c=relaxed/simple;
	bh=upRLbOWOTskpWJQ5/croZAO1F99vBYZo3efafwHLVVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+SfOLHjwXheTQjTfXoW9pIU35udJtkNaih0OHEWHnyaPK3tJqX8NPl87+bu4iTFIrY75ZVZi+CtLeCg63cKtIOTmCY8ZvWBpjTFY4bKISK1T52Rc+XlQqQnoPMgJi7Q3uJlekbWfvd0vMUeyA2EBHLuUVbbpp840p9t6xPpR2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPZi3w+N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750424932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VsEn91YkrzZR4A/Mgdq4+jTVTrvyIrxkItYrsxgKtg=;
	b=LPZi3w+NrGXt3j6d1vGC6r5avU3eAGyKTsrh7m9EIeFzU6JiCoXPOq5BDvxr4GMpW75mmM
	3Fby8yUc2gExa3SVohkg+Nkql18bg/t+PjURvTHMOB2D+Z0d7VOjVW5xXnHIJqW1GJwZ91
	qOaCPEd9jD2AXKPn+yV/ROUryLWd1MI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-AKfinSPAMQae-BoVXTm3Jg-1; Fri, 20 Jun 2025 09:08:51 -0400
X-MC-Unique: AKfinSPAMQae-BoVXTm3Jg-1
X-Mimecast-MFC-AGG-ID: AKfinSPAMQae-BoVXTm3Jg_1750424930
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a578958000so715400f8f.3
        for <linux-integrity@vger.kernel.org>; Fri, 20 Jun 2025 06:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750424930; x=1751029730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VsEn91YkrzZR4A/Mgdq4+jTVTrvyIrxkItYrsxgKtg=;
        b=tvK3IWy9RkG4MnS1mfhEHa171KjJUib97PFo8jZte7an7blITmd9E7M2fxQhJlV6Wg
         ktm98LbBSkVBirRIKwyK1FgZbmASrMTFwzNScY8GneWpM0ybVtSFwBPc/6X8yF34HXz/
         rcpM8c3d4ur1IyRoik0exhwGkYYeUzG1Ykxd+3/R3I1sl54Rhxtoo4YZejhAaL0LUQjb
         KwC8CxKebvLyPmcrn1Fj+2YRNrfk5RkXqeqEelzHnP9JktbX+6ed/y5r93dsF6iO7/YN
         1tCkcWUUyn1dshxa4hjJOYt6AVq22ptfNTsKS6JHiiW25FB8zlPVtCx4QyQhv7fMs0OK
         T/MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrvE2vwuy9FQKQlLH/Ls0YIuddIJWuYZoR+iZETSrkMNYegZD2FG/50Rpqqe3QCOip4yraFVubCUAPlyhECtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAGAPknAeE9Y5pRNJ68JwOIaVRZ1DrP2Y+iwhEut2vk1ZQv1d1
	5YUeJq3FR8p8LGUIWBWpt0aYZEl7kwHADY5Cxp+nPO0Fu4ZKB+bNIWhz7NBUjhJenqVAVAVSQNT
	0TXKT9OeJ8n0CDduHohAmbpJsY9cxMyAKtdn/U+f1Ujir9EYAO64BKjniRk5AMgBNSrajKA==
X-Gm-Gg: ASbGncvJgmd25CqgmwKv9uJbd2awABucQ/VnlVrzsJazUiRxzXru6rEawZmQmnkxKPj
	MxLi44R5H7HO3X0bnOriC3TcetPjLkEfGkIMNj0pyAiQAUNNjebmZOK8Toymj1WMH4uQYN2pwPG
	0oTfpHppbR9OxEoNzLfwiqCka20SiSxCe3Vh3jurQxBcr0DLc8wAL0VfitdF8gbHfdCKgcO2XBR
	heBhT2NnBw1Fr52VmmSc8BIRS4v3/qT6VfmBtn64MmO8joTiU8hqWCzG8Gws1iiR76gUa5MZ76N
	SMZv5H3cXZjAEt0umpVi8gwkjhxF7emWp/U=
X-Received: by 2002:a05:6000:2484:b0:3a4:ddde:13e4 with SMTP id ffacd0b85a97d-3a6d12eb394mr2179380f8f.58.1750424929609;
        Fri, 20 Jun 2025 06:08:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6J1XzXAkrwIk+wJqXhYpgZ7P5H+/wRdPeseCTHYPIt8eTkRipb+nkvNVEX6eFh42F8eJ+sA==
X-Received: by 2002:a05:6000:2484:b0:3a4:ddde:13e4 with SMTP id ffacd0b85a97d-3a6d12eb394mr2179299f8f.58.1750424928851;
        Fri, 20 Jun 2025 06:08:48 -0700 (PDT)
Received: from localhost.localdomain ([193.207.146.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d11909f4sm2017336f8f.88.2025.06.20.06.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:08:48 -0700 (PDT)
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
	Stefano Garzarella <sgarzare@redhat.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v6 3/4] tpm/tpm_ftpm_tee: support TPM_CHIP_FLAG_SYNC
Date: Fri, 20 Jun 2025 15:08:09 +0200
Message-ID: <20250620130810.99069-4-sgarzare@redhat.com>
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

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v5:
- changed order and parameter names to match tpm_try_transmit() [Jarkko]
v4:
- added Sumit's R-b
- reworked commit description [Jarkko]
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
index dbad83bf798e..4e63c30aeaf1 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -31,47 +31,19 @@ static const uuid_t ftpm_ta_uuid =
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
+ * @buf:	the buffer to send and to store the response.
  * @bufsiz:	the size of the buffer.
- * @len:	the number of bytes to send.
+ * @cmd_len:	the number of bytes to send.
  *
  * Return:
- *	In case of success, returns 0.
+ *	In case of success, returns the number of bytes received.
  *	On failure, -errno
  */
 static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
-				size_t len)
+				size_t cmd_len)
 {
 	struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
 	size_t resp_len;
@@ -82,16 +54,15 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
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
@@ -105,7 +76,7 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
 		.u.memref = {
 			.shm = shm,
-			.size = len,
+			.size = cmd_len,
 			.shm_offs = 0,
 		},
 	};
@@ -117,7 +88,7 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 		return PTR_ERR(temp_buf);
 	}
 	memset(temp_buf, 0, (MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE));
-	memcpy(temp_buf, buf, len);
+	memcpy(temp_buf, buf, cmd_len);
 
 	command_params[1] = (struct tee_param) {
 		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
@@ -158,17 +129,20 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 			__func__, resp_len);
 		return -EIO;
 	}
+	if (resp_len > bufsiz) {
+		dev_err(&chip->dev,
+			"%s: resp_len=%zd exceeds bufsiz=%zd\n",
+			__func__, resp_len, bufsiz);
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


