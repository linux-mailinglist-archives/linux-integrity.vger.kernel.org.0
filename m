Return-Path: <linux-integrity+bounces-5867-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86525A886B9
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Apr 2025 17:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260831942018
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Apr 2025 14:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF5D2749CD;
	Mon, 14 Apr 2025 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvzyCt7g"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775AC25394E
	for <linux-integrity@vger.kernel.org>; Mon, 14 Apr 2025 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642651; cv=none; b=s9R7l0UMKxqAMiqqDRH29P8OctaBJF8rJvKkYOivsaPEHuzBukRy14sFxjiJRBRdULoPjRaI1epZ39EW9D9oz4XKKyv2DJKFWk/vteN6a0eEvFK8vrm4bmMq6WQ8dJw/cd3lF9XCJHaTk3stRU3aKmDGaru+L+MDcXwb9RccVvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642651; c=relaxed/simple;
	bh=R4QnQFcPiz+4K8ZI7WgD12ZMOQhjXOvc9mMXJ8CRwMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jElbOTi77TcSoTp4XwI4ekmgYMnY16uzJ7Wycw8Fgrh+/yNGBOzm8+bTrJqehA3g9jIjch+2jRcsI1XPDa9yQIpkJwXPm3exHSLxc+O6NG/zAsZRlP6WrmYc87Vt3M1js6t39igFQmHk41TeqFL/uzRZoC3NU+mPGdGipNLz7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvzyCt7g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744642648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8R/1ZeDKDjc3H414LGRfrF2tWtTtWCHG2fr+aJnFmy8=;
	b=UvzyCt7g3/pOXYSXOSNh8t3iQY9bMQkCVUcIy8vDw9+R9UyrHRZgAFEYxsF1xP3tYjga5n
	S/qjlMaeJTbIGQlOq/tQ8RyuwljOQpkZD9iiDn9JL8YPUMqLJgoWowo4BiMJ+PawPpsf5K
	Qx4x5YD6USa3a+P4l7Yxbl+ChdYdMDU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-ZSVNiIfHNSCWr9ESr9Nkog-1; Mon, 14 Apr 2025 10:57:20 -0400
X-MC-Unique: ZSVNiIfHNSCWr9ESr9Nkog-1
X-Mimecast-MFC-AGG-ID: ZSVNiIfHNSCWr9ESr9Nkog_1744642639
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39c2da64df9so2514319f8f.0
        for <linux-integrity@vger.kernel.org>; Mon, 14 Apr 2025 07:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744642639; x=1745247439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8R/1ZeDKDjc3H414LGRfrF2tWtTtWCHG2fr+aJnFmy8=;
        b=Dov6//SAgpOTf4U8gGRkj3QTvgi/10LTkw8NId9jQ/8B7c2uPpBayyE+QVvEoKjoc5
         0jyubAUR+zz2PrpC32SiKnnPYyKiCUZRGtgZ7B1UtUKR8yk8VMl+NODnyY/LxdT4xYGS
         JACIMeoIPmXzlXw6pT6Q2Pbp9FLR4JoMVVEPc1zFFXE/Tj8myDl7nTpve8HKUkR7ZN19
         0en5mpOTsXZYHUAyJsnMZ764yn+/Gsp8fzdi34adCqd03JB16vbxz+5crjOaDnum5rks
         pUzkL2ThA5FAWLdhtKOsFVTHVbYoVz5WHYOL9AsEx6easqP+uf4z9ppb3ZE/qktfYOwc
         wk3w==
X-Forwarded-Encrypted: i=1; AJvYcCUyKSfiWAr7JzAl+S3MrigLJHKVA6FIKoCtqeyQkBHmXJuXopFxKfoCCZJbaRfSD1QIZ4CTLQZAFngoqGYkOx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv2+WlD3sm9UjBawvQp/pXR7a349XU/y6he9FvfNH7bVOdC6Ds
	cbGPQiRTJQU8HWW0NnjeQU5lOae6Hc2+Ckjj3Dp/ZoeLTZ8bLBRenzxUDrzbho9r5U28O5ibDv7
	Ja6aOwGfQ7Km5a2qVRvNyE88AdW2/5wY6qUaoIZVUD/209leapQ8mZQpJJq8DnvesXA==
X-Gm-Gg: ASbGncuUNGi14fzxzataHag9WcXKdZv+F6ApZYHSveT5ztuEjqGkRTGWnpbOzA+WTJR
	I+P6g1sPI4H5nFfvXtH/CCgCAALtJqetvdVWWQUDCC2CaoOJAirynYn9hiqz/G8KNBJGODNIcZY
	JIau1Byf+LdKRq6wpX+YtkMlKvI80m0gPswZmj+4LJfJzKh9DZzsj7C68TZWNfQ1hLiD5DM8fdD
	Sm3VHroOXatxSV4gvmI5KPd1W9SF7DBZt8mMY8oIceSkf0Sc1gMB3FayfkfN4ieE3StQztf13GH
	gnsg4eALpg17C55LsTMQP7TY
X-Received: by 2002:a05:6000:1787:b0:390:fc5a:91c8 with SMTP id ffacd0b85a97d-39eaaed2015mr9037549f8f.53.1744642639388;
        Mon, 14 Apr 2025 07:57:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHztG+erjxi0kPl4f2XqgvwdUxEBu7vsO7NjlFZ0D8kctkVzUnk4g2BZgxZgM+ahM52VN9G9g==
X-Received: by 2002:a05:6000:1787:b0:390:fc5a:91c8 with SMTP id ffacd0b85a97d-39eaaed2015mr9037507f8f.53.1744642638681;
        Mon, 14 Apr 2025 07:57:18 -0700 (PDT)
Received: from localhost.localdomain ([193.207.151.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43cce3sm11395582f8f.74.2025.04.14.07.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 07:57:16 -0700 (PDT)
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
Subject: [PATCH v3 2/4] tpm: support devices with synchronous send()
Date: Mon, 14 Apr 2025 16:56:51 +0200
Message-ID: <20250414145653.239081-3-sgarzare@redhat.com>
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

Some devices do not support interrupts and provide a single synchronous
operation to send the command and receive the response on the same buffer.

Currently, these types of drivers must use an internal buffer where they
temporarily store the response between .send() and recv() calls.

Introduce a new flag (TPM_CHIP_FLAG_SYNC) to support synchronous send().
If that flag is set by the driver, tpm_try_transmit() will use the send()
callback to send the command and receive the response on the same buffer
synchronously. In that case send() return the number of bytes of the
response on success, or -errno on failure.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v3:
- fixed comment style [Jarkko]
- renamend `out_send_sync` label to `out_sync` [Jarkko]
---
 include/linux/tpm.h              |  1 +
 drivers/char/tpm/tpm-interface.c | 20 +++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 2e38edd5838c..0e9746dc9d30 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -350,6 +350,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
 	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
 	TPM_CHIP_FLAG_DISABLE			= BIT(10),
+	TPM_CHIP_FLAG_SYNC			= BIT(11),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 3b6ddcdb4051..3dc06836f932 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -114,8 +114,19 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 		return rc;
 	}
 
-	/* A sanity check. send() should just return zero on success e.g.
-	 * not the command length.
+	/*
+	 * Synchronous devices return the response directly during the send()
+	 * call in the same buffer.
+	 */
+	if (chip->flags & TPM_CHIP_FLAG_SYNC) {
+		len = rc;
+		rc = 0;
+		goto out_sync;
+	}
+
+	/*
+	 * A sanity check. send() of asynchronous devices should just return
+	 * zero on success e.g. not the command length.
 	 */
 	if (rc > 0) {
 		dev_warn(&chip->dev,
@@ -151,7 +162,10 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 	if (len < 0) {
 		rc = len;
 		dev_err(&chip->dev, "tpm_transmit: tpm_recv: error %d\n", rc);
-	} else if (len < TPM_HEADER_SIZE || len != be32_to_cpu(header->length))
+		return rc;
+	}
+out_sync:
+	if (len < TPM_HEADER_SIZE || len != be32_to_cpu(header->length))
 		rc = -EFAULT;
 
 	return rc ? rc : len;
-- 
2.49.0


