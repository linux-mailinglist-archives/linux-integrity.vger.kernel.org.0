Return-Path: <linux-integrity+bounces-6482-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A791AE1B96
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 15:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C05E189BA1F
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 13:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176DD2949F1;
	Fri, 20 Jun 2025 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N71AIUXq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB67A28D8E5
	for <linux-integrity@vger.kernel.org>; Fri, 20 Jun 2025 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750424917; cv=none; b=R4RT9412pqjNc+67EgRuYhob93vYOKNLMhtMPOEcQ7/zWp1zyKARzai3n5EUaHLK6zsm6aQqig7dXx6/x7I5Pnhug4ohKq4MLtiZfxpWv/qJquibt8CXTOxeHBwUztxF6kMjq61u44WiHZLjFWlmx1xi5cXEbjbLBNyxyCmENp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750424917; c=relaxed/simple;
	bh=i7tXRCnPRdUdAT+EmhRgszotMvR34gc5K5tGeRzHLB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFS5PhXAmjuKLTEm732ynigeudQ8NWQJ25pXP9r3F8Vz5rGxrjyvEeoeAhy1qWHHgyGaQivs4pZYPGRr13288/yhyopMiXullWRCCLzv3QylfIC/8V2IXIKwJ0aKnD4IPVnBgT5XTCvIICJ6tzbvTyRtSRt4YJpocI50GN/WS28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N71AIUXq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750424913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezIfyKMqmi8MNNCRDVQN8O5HYYRxZnjdWUIPGqn9wXY=;
	b=N71AIUXqv99o/Kwg/cApMwVDgdBpWufm154yL6kSGfFmwbe5kRQqlxG81pokVKZd482Uso
	oD+VfmfOM3qR+wTDcV9zmjby5LWbMCXD4n8yeLxUXT4kFXYsRfyc8Mkdaz9l9qrl54w6BD
	OomPnRLxe0skNg9vV3qFkHPWPsk6xuI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-Lfn9LGRyNCm_uF9pY1ncMg-1; Fri, 20 Jun 2025 09:08:32 -0400
X-MC-Unique: Lfn9LGRyNCm_uF9pY1ncMg-1
X-Mimecast-MFC-AGG-ID: Lfn9LGRyNCm_uF9pY1ncMg_1750424911
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so1303775f8f.2
        for <linux-integrity@vger.kernel.org>; Fri, 20 Jun 2025 06:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750424911; x=1751029711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezIfyKMqmi8MNNCRDVQN8O5HYYRxZnjdWUIPGqn9wXY=;
        b=IHLtK0msJKeKDJfJkeEl0Oi4HtCMptcZhEy/FdkIlkNg24NA3zoZ38cc4AolTPHqDI
         G33okgRF7i7k8rhQUO/9P0tqKqzz4lw2H6fQB03pAdhmuIewa1wCLUmQklBo+dfEAo4h
         dju2SXB+4z2IFmPC9RsOWNfkp6tACTQRyQALfeSpqGW4bIfnYSsaP/qtRqa9ODH63i5O
         nVVwrlplrpkrbfBNmRWl/JjdWm01EC3vbqFZkLqRo9pEIpU/fM5Y8NSvu8Z0FkrcXil1
         sTJ2qvOdfzeFqN6nWaaCyNt1wOJZnskIYMGLaETd/vMyM3Op+ZpUEIivLmImQyogWj+7
         cWZA==
X-Forwarded-Encrypted: i=1; AJvYcCUlC+6Ofbt0D2gdVI47mmr5arkSlzhqmDmjxb0Plutl98UegXZ0DpcmPeXwAmLWkwRUWiTPIMzjuc3gGD4k0Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBdabEZoLKUgYvC+eTrajOaZj/ZnjNFdP10hHscdbTS/IKE1/U
	+IjrmzTNEN03TkNZjXo9dgtx+5qESt4r2Mmv5hvmY/08ui0ZMgWvv5atUTK9uraBtwC8bpuK8Ur
	lz+wHMIEOf0R479HtBp80HYpCr1eA2tpEfTTRKcrloJ0Rc9m1fE51CzSq6op9b3KnMP0XXQ==
X-Gm-Gg: ASbGncv+90SYTP2SmVE5TxCwPLfrubYzKWc+JY3twH19F8mvaTPkpPU0noiSfs86Xl5
	anXxcalaQ8G2yZd/RmY0lN6jMHFbj6MVuucjQEQXcRsiDRGLh8UTBNJa69oj6dAcZ7fL2DUYE5H
	GS5RkBkrquz9eJtRzDrplvyh7xlNdCVYG7z5tgDqHXCL5fvzvoUeqBAgqif+SIHUzxJuqgQmgMv
	O4syeAmGbNp9ZgoPP3NUkTOuvcbRQwAaE8S2H7tUqAeGEpxZuBey34o56wY2fkA1/DSXblPKnH6
	FeduutYD0Qq89AKm3Tt4XcdcnGk2Dw5FRTA=
X-Received: by 2002:a5d:6f1d:0:b0:3a4:cfbf:5199 with SMTP id ffacd0b85a97d-3a6d128a528mr2333085f8f.9.1750424911096;
        Fri, 20 Jun 2025 06:08:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVteHr1FIrY8/qSwd48lo3QtMnrsPzMApwNUlMupCTfSXDonW8PLKYWmOuMcFpb18eyXIO/Q==
X-Received: by 2002:a5d:6f1d:0:b0:3a4:cfbf:5199 with SMTP id ffacd0b85a97d-3a6d128a528mr2333014f8f.9.1750424910350;
        Fri, 20 Jun 2025 06:08:30 -0700 (PDT)
Received: from localhost.localdomain ([193.207.146.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f18a29sm2080273f8f.36.2025.06.20.06.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:08:29 -0700 (PDT)
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
Subject: [PATCH v6 1/4] tpm: add bufsiz parameter in the .send callback
Date: Fri, 20 Jun 2025 15:08:07 +0200
Message-ID: <20250620130810.99069-2-sgarzare@redhat.com>
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

Add a new `bufsiz` parameter to the `.send` callback in `tpm_class_ops`.
This parameter will allow drivers to differentiate between the actual
command length to send and the total buffer size. Currently `bufsiz` is
not used, but it will be used to implement devices with synchronous send()
to send the command and receive the response on the same buffer.

Also rename the previous parameter `len` to `cmd_len` in the declaration
to make it clear that it contains the length in bytes of the command
stored in the buffer. The semantics don't change and it can be used as
before by drivers. This is an optimization since the drivers could get it
from the header, but let's avoid duplicating code.

While we are here, resolve a checkpatch warning:
  WARNING: Unnecessary space before function pointer arguments
  #66: FILE: include/linux/tpm.h:90:
  +	int (*send) (struct tpm_chip *chip, u8 *buf, size_t bufsiz,

Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v5:
- changed order and parameter names to match tpm_try_transmit() [Jarkko]
v4:
- rework the commit description [Jarkko]
---
 include/linux/tpm.h                  | 3 ++-
 drivers/char/tpm/st33zp24/st33zp24.c | 2 +-
 drivers/char/tpm/tpm-interface.c     | 2 +-
 drivers/char/tpm/tpm_atmel.c         | 3 ++-
 drivers/char/tpm/tpm_crb.c           | 2 +-
 drivers/char/tpm/tpm_ftpm_tee.c      | 4 +++-
 drivers/char/tpm/tpm_i2c_atmel.c     | 3 ++-
 drivers/char/tpm/tpm_i2c_infineon.c  | 3 ++-
 drivers/char/tpm/tpm_i2c_nuvoton.c   | 3 ++-
 drivers/char/tpm/tpm_ibmvtpm.c       | 6 ++++--
 drivers/char/tpm/tpm_infineon.c      | 3 ++-
 drivers/char/tpm/tpm_nsc.c           | 3 ++-
 drivers/char/tpm/tpm_svsm.c          | 3 ++-
 drivers/char/tpm/tpm_tis_core.c      | 3 ++-
 drivers/char/tpm/tpm_tis_i2c_cr50.c  | 6 ++++--
 drivers/char/tpm/tpm_vtpm_proxy.c    | 4 +++-
 drivers/char/tpm/xen-tpmfront.c      | 3 ++-
 17 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index a3d8305e88a5..cafe8c283e88 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -87,7 +87,8 @@ struct tpm_class_ops {
 	const u8 req_complete_val;
 	bool (*req_canceled)(struct tpm_chip *chip, u8 status);
 	int (*recv) (struct tpm_chip *chip, u8 *buf, size_t len);
-	int (*send) (struct tpm_chip *chip, u8 *buf, size_t len);
+	int (*send)(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+		    size_t cmd_len);
 	void (*cancel) (struct tpm_chip *chip);
 	u8 (*status) (struct tpm_chip *chip);
 	void (*update_timeouts)(struct tpm_chip *chip,
diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index c0771980bc2f..2ed7815e4899 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -300,7 +300,7 @@ static irqreturn_t tpm_ioserirq_handler(int irq, void *dev_id)
  * send TPM commands through the I2C bus.
  */
 static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
-			 size_t len)
+			 size_t bufsiz, size_t len)
 {
 	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
 	u32 status, i, size, ordinal;
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 8d7e4da6ed53..816b7c690bc9 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -106,7 +106,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 		return -E2BIG;
 	}
 
-	rc = chip->ops->send(chip, buf, count);
+	rc = chip->ops->send(chip, buf, bufsiz, count);
 	if (rc < 0) {
 		if (rc != -EPIPE)
 			dev_err(&chip->dev,
diff --git a/drivers/char/tpm/tpm_atmel.c b/drivers/char/tpm/tpm_atmel.c
index 54a0360a3c95..f25faf468bba 100644
--- a/drivers/char/tpm/tpm_atmel.c
+++ b/drivers/char/tpm/tpm_atmel.c
@@ -148,7 +148,8 @@ static int tpm_atml_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	return size;
 }
 
-static int tpm_atml_send(struct tpm_chip *chip, u8 *buf, size_t count)
+static int tpm_atml_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+			 size_t count)
 {
 	struct tpm_atmel_priv *priv = dev_get_drvdata(&chip->dev);
 	int i;
diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 876edf2705ab..ed97344f2324 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -426,7 +426,7 @@ static int tpm_crb_smc_start(struct device *dev, unsigned long func_id)
 }
 #endif
 
-static int crb_send(struct tpm_chip *chip, u8 *buf, size_t len)
+static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 {
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
 	int rc = 0;
diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 53ba28ccd5d3..dbad83bf798e 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -63,13 +63,15 @@ static int ftpm_tee_tpm_op_recv(struct tpm_chip *chip, u8 *buf, size_t count)
  * ftpm_tee_tpm_op_send() - send TPM commands through the TEE shared memory.
  * @chip:	the tpm_chip description as specified in driver/char/tpm/tpm.h
  * @buf:	the buffer to send.
+ * @bufsiz:	the size of the buffer.
  * @len:	the number of bytes to send.
  *
  * Return:
  *	In case of success, returns 0.
  *	On failure, -errno
  */
-static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
+static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+				size_t len)
 {
 	struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
 	size_t resp_len;
diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
index d1d27fdfe523..4f229656a8e2 100644
--- a/drivers/char/tpm/tpm_i2c_atmel.c
+++ b/drivers/char/tpm/tpm_i2c_atmel.c
@@ -37,7 +37,8 @@ struct priv_data {
 	u8 buffer[sizeof(struct tpm_header) + 25];
 };
 
-static int i2c_atmel_send(struct tpm_chip *chip, u8 *buf, size_t len)
+static int i2c_atmel_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+			  size_t len)
 {
 	struct priv_data *priv = dev_get_drvdata(&chip->dev);
 	struct i2c_client *client = to_i2c_client(chip->dev.parent);
diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
index 81d8a78dc655..bdf1f329a679 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -514,7 +514,8 @@ static int tpm_tis_i2c_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	return size;
 }
 
-static int tpm_tis_i2c_send(struct tpm_chip *chip, u8 *buf, size_t len)
+static int tpm_tis_i2c_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+			    size_t len)
 {
 	int rc, status;
 	ssize_t burstcnt;
diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
index 3c3ee5f551db..d44903b29929 100644
--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
@@ -350,7 +350,8 @@ static int i2c_nuvoton_recv(struct tpm_chip *chip, u8 *buf, size_t count)
  * tpm.c can skip polling for the data to be available as the interrupt is
  * waited for here
  */
-static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
+static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+			    size_t len)
 {
 	struct priv_data *priv = dev_get_drvdata(&chip->dev);
 	struct device *dev = chip->dev.parent;
diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 76d048f63d55..4734a69406ce 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -191,13 +191,15 @@ static int tpm_ibmvtpm_resume(struct device *dev)
  * tpm_ibmvtpm_send() - Send a TPM command
  * @chip:	tpm chip struct
  * @buf:	buffer contains data to send
- * @count:	size of buffer
+ * @bufsiz:	size of the buffer
+ * @count:	length of the command
  *
  * Return:
  *   0 on success,
  *   -errno on error
  */
-static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
+static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+			    size_t count)
 {
 	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
 	bool retry = true;
diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
index 2d2ae37153ba..7638b65b851b 100644
--- a/drivers/char/tpm/tpm_infineon.c
+++ b/drivers/char/tpm/tpm_infineon.c
@@ -312,7 +312,8 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
 	return -EIO;
 }
 
-static int tpm_inf_send(struct tpm_chip *chip, u8 * buf, size_t count)
+static int tpm_inf_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+			size_t count)
 {
 	int i;
 	int ret;
diff --git a/drivers/char/tpm/tpm_nsc.c b/drivers/char/tpm/tpm_nsc.c
index 0f62bbc940da..879ac88f5783 100644
--- a/drivers/char/tpm/tpm_nsc.c
+++ b/drivers/char/tpm/tpm_nsc.c
@@ -178,7 +178,8 @@ static int tpm_nsc_recv(struct tpm_chip *chip, u8 * buf, size_t count)
 	return size;
 }
 
-static int tpm_nsc_send(struct tpm_chip *chip, u8 * buf, size_t count)
+static int tpm_nsc_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+			size_t count)
 {
 	struct tpm_nsc_priv *priv = dev_get_drvdata(&chip->dev);
 	u8 data;
diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
index 4280edf427d6..0847cbf450b4 100644
--- a/drivers/char/tpm/tpm_svsm.c
+++ b/drivers/char/tpm/tpm_svsm.c
@@ -25,7 +25,8 @@ struct tpm_svsm_priv {
 	void *buffer;
 };
 
-static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t len)
+static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+			 size_t len)
 {
 	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
 	int ret;
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index ed0d3d8449b3..4b12c4b9da8b 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -580,7 +580,8 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 	return rc;
 }
 
-static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
+static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+			size_t len)
 {
 	int rc, irq;
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index 3b55a7b05c46..fc6891a0b693 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -546,13 +546,15 @@ static int tpm_cr50_i2c_tis_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len)
  * tpm_cr50_i2c_tis_send() - TPM transmission callback.
  * @chip:	A TPM chip.
  * @buf:	Buffer to send.
- * @len:	Buffer length.
+ * @bufsiz:	Buffer size.
+ * @len:	Command length.
  *
  * Return:
  * - 0:		Success.
  * - -errno:	A POSIX error code.
  */
-static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
+static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+				 size_t len)
 {
 	size_t burstcnt, limit, sent = 0;
 	u8 tpm_go[4] = { TPM_STS_GO };
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 8fe4a01eea12..0818bb517805 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -321,12 +321,14 @@ static int vtpm_proxy_is_driver_command(struct tpm_chip *chip,
  *
  * @chip: tpm chip to use
  * @buf: send buffer
+ * @bufsiz: size of the buffer
  * @count: bytes to send
  *
  * Return:
  *      0 in case of success, negative error value otherwise.
  */
-static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)
+static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+				  size_t count)
 {
 	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
 
diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
index 80cca3b83b22..556bf2256716 100644
--- a/drivers/char/tpm/xen-tpmfront.c
+++ b/drivers/char/tpm/xen-tpmfront.c
@@ -131,7 +131,8 @@ static size_t shr_data_offset(struct vtpm_shared_page *shr)
 	return struct_size(shr, extra_pages, shr->nr_extra_pages);
 }
 
-static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
+static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+		     size_t count)
 {
 	struct tpm_private *priv = dev_get_drvdata(&chip->dev);
 	struct vtpm_shared_page *shr = priv->shr;
-- 
2.49.0


