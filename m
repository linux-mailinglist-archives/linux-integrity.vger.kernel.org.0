Return-Path: <linux-integrity+bounces-5223-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D79DA5BD1B
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 11:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A855A7A40A6
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 10:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DBC22FAF8;
	Tue, 11 Mar 2025 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFz1DLLO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251451E2606
	for <linux-integrity@vger.kernel.org>; Tue, 11 Mar 2025 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687311; cv=none; b=BB9g2IFzMSmnWfRzxd7kneZm8HapS2zao/cMkv88g6LxZqZqpP02ZkxSSB7qbuuzyEql+qmWrAP911entwURAk9PjeODdOrm7/ft9s79y8s9FzTUAWkCiZaIkWRnw95BwFvDkxLfPEYtcnecjE4T1n05CaW837LybhCfiS1zbks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687311; c=relaxed/simple;
	bh=tmLfihRSJ8aDEwLZQLrfPa2kgVJ8yB6EH9+mM+3ad6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvvPtSqU1ML3TZ2cZ9Wxc/4NgtLnKIOF0z+xYxF2+pwOnSMvZhhnU8R+RtQDI5DuxLS1ajDGmMn5dJzdjlVjTeAySdkiGzFz3xXDXd6mjb30gAvwPVpfDNVKJJEszKqsJrA3GcteD/MzO1x8bVIZn+U8Htnv7idmxr1RqTJwZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFz1DLLO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741687309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t42YH129GwFgWuMlejLOiuh/mbs5CWsg7YDBlF++gYY=;
	b=KFz1DLLOAn9vKbjdA8kP8TbSm+qvT1tHmxXQSnLlRswEwCuh3P8YCG202H3kcJH+3zhsGO
	ocVDSBE3geKsU19QjJcLwDbRtb9NyfNyBQnr1713+GmXnH/E+4j2AwEF0b7YG8gvOMmSDE
	ODF8oAc59jywwlsfXvjJWo+RZ4sFWmU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-DWDvL6ICNW-nIW9NGXE-zQ-1; Tue, 11 Mar 2025 06:01:47 -0400
X-MC-Unique: DWDvL6ICNW-nIW9NGXE-zQ-1
X-Mimecast-MFC-AGG-ID: DWDvL6ICNW-nIW9NGXE-zQ_1741687306
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac1e442740cso478998966b.1
        for <linux-integrity@vger.kernel.org>; Tue, 11 Mar 2025 03:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741687306; x=1742292106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t42YH129GwFgWuMlejLOiuh/mbs5CWsg7YDBlF++gYY=;
        b=nZHIVEJuNQRH8O2EwdXDRYicyk7fyMbw17tD2sYyfQVcSutCRYctPd3ktk5aB55aFp
         FLWjQUy36CUZhbNUmjq5di3YHUES+mX63CeqRFpMPYKyJvlXUGMxF/aZX8emMzRcNppa
         EtGR/nz8KxCry/b3JiYQDDoAAXP3Y7U9BwlnPklu0/qDpcAsvNNTDyQrb3Cxp5TLafHF
         PMof6Zg1ixqzPoWzLFI93E6agPzwtIGeTVvA9057G5BGYhWmaFd2vTj+U+3yXqyV2P3X
         FPcgA4Kv8n7W0LNlPKagb5DoRIRO6grHU7osMPcxBqlIkKc4QTWwIYCEsIy+s5VtB3mL
         UBag==
X-Gm-Message-State: AOJu0YxNwrV8ef8S5YzTyisB7oghRi1zT0advqPjPeH1S8Sq6Ybx8aYD
	v2cEq0y8ZB0UvB1TpJh1Z92QeMXNFLfeluIqikxYBqtnRQ95zPjn9yUK+oQPtCLVvdGg8xem5zj
	/KUN3puP9jMssCIa+1osmVS1o7821Ytg8SyM6c6xTtS9dTQMgxNCiA+XxNOMpfLnnAw==
X-Gm-Gg: ASbGncsnReaLrDl+bt/++xB8FGaisggigl8t/WDwlPYbcReNENDGQxfqMfasR+n+WHe
	ylHG1xJOcClBDgvjiF5xremCMX+p42k5FeJ2JRvG8oQtgSGuWfHdWxUT2/rOrTxQ5QCiXTW7Ung
	uS7lPWe60QNELvm6eT1oGBC1azld23lfvQO8BObQ+o1GERWKmaVCL5DUifR2pGBaQ9UBO8Wliqc
	Mdde3FOda0jVM3tB0RsTWukxmT4VJeoWjjs7Uq1Wzize6LhzOXqXWj3PYBNHxJE2/RU1JW7Lnaf
	dhVG8Zs7CH+gCqh8nZIWFINOd+sINF+Ag8dpaFfQqWGm+oL/qcg47osPmy1lHjGG7d8p6VZb
X-Received: by 2002:a17:907:828a:b0:ac2:c424:c316 with SMTP id a640c23a62f3a-ac2c424cd75mr129985666b.57.1741687306210;
        Tue, 11 Mar 2025 03:01:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMJt108SROCVxYPGya/bj/Hfjcf3W0nRTrMsVifumnlQBsPRx2yIzQLmb7aDWeXBKljmIlkw==
X-Received: by 2002:a17:907:828a:b0:ac2:c424:c316 with SMTP id a640c23a62f3a-ac2c424cd75mr129971366b.57.1741687304300;
        Tue, 11 Mar 2025 03:01:44 -0700 (PDT)
Received: from localhost.localdomain (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac27d922c58sm519476466b.40.2025.03.11.03.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 03:01:43 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 1/3] tpm: add send_recv() op in tpm_class_ops
Date: Tue, 11 Mar 2025 11:01:28 +0100
Message-ID: <20250311100130.42169-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311100130.42169-1-sgarzare@redhat.com>
References: <20250311100130.42169-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices do not support interrupts and provide a single operation
to send the command and receive the response on the same buffer.

To support this scenario, a driver could set TPM_CHIP_FLAG_IRQ in the
chip's flags to get recv() to be called immediately after send() in
tpm_try_transmit(), or it needs to implement .status() to return 0,
and set both .req_complete_mask and .req_complete_val to 0.

In order to simplify these drivers and avoid temporary buffers to be
used between the .send() and .recv() callbacks, introduce a new callback
send_recv(). If that callback is defined, it is called in
tpm_try_transmit() to send the command and receive the response on
the same buffer in a single call.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/tpm.h              | 2 ++
 drivers/char/tpm/tpm-interface.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 20a40ade8030..9baf10240a3d 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -88,6 +88,8 @@ struct tpm_class_ops {
 	bool (*req_canceled)(struct tpm_chip *chip, u8 status);
 	int (*recv) (struct tpm_chip *chip, u8 *buf, size_t len);
 	int (*send) (struct tpm_chip *chip, u8 *buf, size_t len);
+	int (*send_recv)(struct tpm_chip *chip, u8 *buf, size_t buf_len,
+			 size_t cmd_len);
 	void (*cancel) (struct tpm_chip *chip);
 	u8 (*status) (struct tpm_chip *chip);
 	void (*update_timeouts)(struct tpm_chip *chip,
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index b1daa0d7b341..9a6e4b320a8f 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -82,6 +82,12 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 		return -E2BIG;
 	}
 
+	if (chip->ops->send_recv) {
+		rc = 0;
+		len = chip->ops->send_recv(chip, buf, bufsiz, count);
+		goto out_send_recv;
+	}
+
 	rc = chip->ops->send(chip, buf, count);
 	if (rc < 0) {
 		if (rc != -EPIPE)
@@ -124,6 +130,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 
 out_recv:
 	len = chip->ops->recv(chip, buf, bufsiz);
+out_send_recv:
 	if (len < 0) {
 		rc = len;
 		dev_err(&chip->dev, "tpm_transmit: tpm_recv: error %d\n", rc);
-- 
2.48.1


