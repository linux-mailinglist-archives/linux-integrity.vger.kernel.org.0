Return-Path: <linux-integrity+bounces-5345-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AF1A6A9D8
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 16:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15D74856BA
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 15:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F20225407;
	Thu, 20 Mar 2025 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9yRUTBC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B1A225390
	for <linux-integrity@vger.kernel.org>; Thu, 20 Mar 2025 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484294; cv=none; b=o2vAJnU/81vsvT+Ye+8kBdO+HHO5xISLYOejVcqyKeUjbpCipeyKEQymyalswd9fEGt45xZK53E7u5skzKVJTzV0OrzGxJWA0BxNWtEYujYZj4p9qLsi9XoiQ4NwuZENp3ztvDOGkwDUVoJHHCugDDwdgdLRxe/tKOpxrf5P4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484294; c=relaxed/simple;
	bh=g4RPUZRhEKRMyhPXxt52DPRnTykDaR6zChIBlW+Qmgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2cx6ulo/dCRfnYau7zFVPsD0vyL7RUh/PjmqHJN1iyTxqoVclwGPGS7R+6lg+4T4oUVgX477JFDb3CBZhI3SOVER22AyFooAKQcmZ3mgkuH6zH78eGqazWYfOStadyl0Ow65veCzt8nn41LDTHjG9i9kQvvG97zt+y1+MGun90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9yRUTBC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742484291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yioIqwyRNktB570CWxQShNY2aa9MHytbuEloZKE867c=;
	b=V9yRUTBCP+1B681wFSavfYSw09tRS7ggQZ42ysTiA807lL3X4WlBG8Czyljxl0ocBq0/Ky
	YdXUP1uDMo1k6RTKmPnRg8tYEAI+vInzAnNwZoMpf8y0DtVSOJCAJApetISvqVn9W44IDF
	CpLQmBpAOlCf7gkjubu4QoX14g7hiz8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-8_7CfENNM_KnePl52doukw-1; Thu, 20 Mar 2025 11:24:50 -0400
X-MC-Unique: 8_7CfENNM_KnePl52doukw-1
X-Mimecast-MFC-AGG-ID: 8_7CfENNM_KnePl52doukw_1742484289
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-391459c0395so482455f8f.2
        for <linux-integrity@vger.kernel.org>; Thu, 20 Mar 2025 08:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484289; x=1743089089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yioIqwyRNktB570CWxQShNY2aa9MHytbuEloZKE867c=;
        b=Pk8PHK76Pqg1FJSzHLlzEfTIytROiHt6NHAE3mFujclCTwOo9tu2iCou7V6K4CkQky
         IUbZjWnaAZzcGh1+SBtqcbLLd670ZZH63Hgymw4Mpro/LVgZL+B6hJXkbUcVdb4p1E+d
         rMyJOb2+ptC9gcZvZxDGBF9SflvdEItB6gmXrnYxwGO7QjSn5Qygp9NCdGmK2B4JZBzt
         UedjsT2HjVFrMQgBxXY9IxwmfuyYFpwwj7NyslC6sgZzNeUOwmPWGkfLyHVqGNdum8hx
         rrCh+U6JurQ4YzhWUciSgaMD5bdztsUHmurYRdQQs3CgR9RCwFKMGfdA4PHadfhuB/Gd
         HrIg==
X-Forwarded-Encrypted: i=1; AJvYcCULw2xmu8+wQ97TDuDYs4oXd8QQza3bzpRK/iXmKuiaX1DWvi0yrpTTa8MrIn1z9bFN2G0TutYLtGuYpFOuv1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWv+yZq7FOVpruENNXb3rUKZWwC8VZElFj7eBlcnO8cIKpC8a2
	G8irOjJK03+/5zlI/qvDrt5clFjJXoolpcxrcjZDi9wf/gKr+FjU3MF3+6bQMJbB3Bx4mWZblHl
	KfsAOwEHxcYZh2ZK98oKc8GJPQ8RGW5+vNiOaUqhG46QnhHeMYzZ6l8AG7SCPey8UUA==
X-Gm-Gg: ASbGncv1PLtf4riDULOMCDiGhQHziw7PbUEGJ5tN6UB7Bcc8aafFvpCSwPW1NuUouAJ
	HOu18STiCJB3RJ2kEJSDrOsGEhca09ypg86RkHPb0qXKSEa9GCqfueYX8071h0+8cqjcACYgF+/
	/hLesm0wk99IWUOvUMahtjNszUS+XulZuiZiFTxYcMsVNPvZOWGUArTF2jbfwD3zU6xrjlWe23A
	Al9lPQlLiayc0/TyZLvRuUvvB7cEFQOoGm9YwbyHIrnRisnI/dPhApKSPgTn2elhZ5Nac7RDoMK
	5dUCaRl5DY641DTAh/m98/2x+F+eaa9uQUPMgGkvf2o30mlTXI/VnsM76uEz7I8IeA==
X-Received: by 2002:a05:6000:2a1:b0:391:2df9:772d with SMTP id ffacd0b85a97d-399739bc3e3mr9121707f8f.13.1742484288704;
        Thu, 20 Mar 2025 08:24:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsZCQ96rJTuI4SZzGz4Gt0x28H9R4KlQj4xs1HLrIN99bxNODuDiSb+OtUpfwiJ5Z1a97P0g==
X-Received: by 2002:a05:6000:2a1:b0:391:2df9:772d with SMTP id ffacd0b85a97d-399739bc3e3mr9121661f8f.13.1742484288105;
        Thu, 20 Mar 2025 08:24:48 -0700 (PDT)
Received: from stex1.redhat.com (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb8c2sm23582679f8f.85.2025.03.20.08.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:47 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 2/2] tpm/tpm_ftpm_tee: use send_recv() op
Date: Thu, 20 Mar 2025 16:24:33 +0100
Message-ID: <20250320152433.144083-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320152433.144083-1-sgarzare@redhat.com>
References: <20250320152433.144083-1-sgarzare@redhat.com>
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

It used an internal buffer to cache the response when .send() is called,
and then return it when .recv() is called.

Let's simplify the driver by implementing the new send_recv() op, so that
we can also remove the 4KB internal buffer used to cache the response.

Tested-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v1:
- added Jens' T-b
---
 drivers/char/tpm/tpm_ftpm_tee.h |  4 --
 drivers/char/tpm/tpm_ftpm_tee.c | 86 ++++++++-------------------------
 2 files changed, 21 insertions(+), 69 deletions(-)

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
index 8d9209dfc384..d472199c0a7b 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -31,45 +31,19 @@ static const uuid_t ftpm_ta_uuid =
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
+ * ftpm_tee_tpm_op_send_recv() - send TPM commands through the TEE shared memory
+ * and retrieve the response.
  * @chip:	the tpm_chip description as specified in driver/char/tpm/tpm.h
- * @buf:	the buffer to send.
- * @len:	the number of bytes to send.
+ * @buf:	the buffer to send and to store the response.
+ * @buf_len:	the size of the buffer.
+ * @cmd_len:	the number of bytes to send.
  *
  * Return:
- *	In case of success, returns 0.
+ *	In case of success, returns the number of bytes received.
  *	On failure, -errno
  */
-static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
+static int ftpm_tee_tpm_op_send_recv(struct tpm_chip *chip, u8 *buf,
+				     size_t buf_len, size_t cmd_len)
 {
 	struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
 	size_t resp_len;
@@ -80,16 +54,15 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
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
@@ -103,7 +76,7 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
 		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
 		.u.memref = {
 			.shm = shm,
-			.size = len,
+			.size = cmd_len,
 			.shm_offs = 0,
 		},
 	};
@@ -115,7 +88,7 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
 		return PTR_ERR(temp_buf);
 	}
 	memset(temp_buf, 0, (MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE));
-	memcpy(temp_buf, buf, len);
+	memcpy(temp_buf, buf, cmd_len);
 
 	command_params[1] = (struct tee_param) {
 		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
@@ -156,38 +129,21 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
 			__func__, resp_len);
 		return -EIO;
 	}
+	if (resp_len > buf_len) {
+		dev_err(&chip->dev,
+			"%s: Invalid size in recv: buf_len=%zd, resp_len=%zd\n",
+			__func__, buf_len, resp_len);
+		return -EIO;
+	}
 
-	/* sanity checks look good, cache the response */
-	memcpy(pvt_data->resp_buf, temp_buf, resp_len);
-	pvt_data->resp_len = resp_len;
-
-	return 0;
-}
-
-static void ftpm_tee_tpm_op_cancel(struct tpm_chip *chip)
-{
-	/* not supported */
-}
-
-static u8 ftpm_tee_tpm_op_status(struct tpm_chip *chip)
-{
-	return 0;
-}
+	memcpy(buf, temp_buf, resp_len);
 
-static bool ftpm_tee_tpm_req_canceled(struct tpm_chip *chip, u8 status)
-{
-	return false;
+	return resp_len;
 }
 
 static const struct tpm_class_ops ftpm_tee_tpm_ops = {
 	.flags = TPM_OPS_AUTO_STARTUP,
-	.recv = ftpm_tee_tpm_op_recv,
-	.send = ftpm_tee_tpm_op_send,
-	.cancel = ftpm_tee_tpm_op_cancel,
-	.status = ftpm_tee_tpm_op_status,
-	.req_complete_mask = 0,
-	.req_complete_val = 0,
-	.req_canceled = ftpm_tee_tpm_req_canceled,
+	.send_recv = ftpm_tee_tpm_op_send_recv,
 };
 
 /*
-- 
2.48.1


