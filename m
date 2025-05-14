Return-Path: <linux-integrity+bounces-6211-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FBAAB6D2E
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 15:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B131B6053F
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 13:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966F01A2545;
	Wed, 14 May 2025 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/3Yq8jt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A6127CB33
	for <linux-integrity@vger.kernel.org>; Wed, 14 May 2025 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747230417; cv=none; b=pCDPwia9XRrZ6GxQdkUV0zwBSwkWXmFIlwiT6m1zI945qPMSOKQDZh5Lqyb/GSyJn3G2zmECLww4nBPcNmHjebPW6FyoPMFyq6VZ3V04tv83O++ErVYKUmYC9IQLzk9Ke97iQU4SoNyH7ABg55ioOc4nAwgiyQVL0csIdJj55KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747230417; c=relaxed/simple;
	bh=ha8DqHOX2rnYJ73/d/pv6dX8MWM3OBUeyEKEBtDXY4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClIRfSw5AUMZ2o8BxZkX/URM4UU4dikprs7UR1bAyaXTLdtC3QQetSKnhjmGYeViPP13mtwX81GPdqu06hZmfeimXLVHHbhK93UWoDbN4w0i/XZelNI7X/ZJ0STJbUDZRxYw9dqpevgstKWIEelb63TrjVhgxnHjuqf1YSoUGWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/3Yq8jt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747230414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HM3A1DQYgNN+uT3lHR2nzVPEIJjvspM419SembxT0i4=;
	b=U/3Yq8jti42hV/wcrg/iZ6qnAItuoj3ZjxA5MCy13+NuF0GUkb5L8OUtUJKFBFID4bCxlt
	SPsWn682bZNoN+xWw6xRehMt+wotYNLSWoYwI3D5WL9k4MBRr3ULIHg36j+0RQPCn9EsFN
	dOzA3vx1E3Zyylz+CufjrPSgufE5nxY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-2GFxedZ5PKCPEiOf1Ahb6g-1; Wed, 14 May 2025 09:46:53 -0400
X-MC-Unique: 2GFxedZ5PKCPEiOf1Ahb6g-1
X-Mimecast-MFC-AGG-ID: 2GFxedZ5PKCPEiOf1Ahb6g_1747230412
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so39831915e9.1
        for <linux-integrity@vger.kernel.org>; Wed, 14 May 2025 06:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747230412; x=1747835212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HM3A1DQYgNN+uT3lHR2nzVPEIJjvspM419SembxT0i4=;
        b=A3k2EnLMbK7e1S+vx5ro6uADKTeQiYcgcQt427MpWR4FHbc+hyF4Vr8WAvym3FADtC
         DODaB1oMw90XA18YNdvLjbMNEiNLmnoa/XhlmBhl3EVbIKpGw7sa0yYCYnijpsBYWjnV
         7TWFjBJA3n6reJ0n+rX0hPaebPhy6YdRWtuYbv5iLwt4/qZvKNKo3MfikGE+WpbS4pHJ
         icHiiKUwVN7YBVVmT69PtCJ+Q4RbKAhRyaCjai6O2GG7/kjXLWnwl7sKUQ8a+pG4RCX/
         BZaqTrmJlVaAzAIUj1wI1vqZvuSkZ2rP796mrFmOcAmr45VNSS0//Kasjfw6Rl1YDiLL
         Tg5A==
X-Forwarded-Encrypted: i=1; AJvYcCV1mCVBcjBODtejGJXTapYhwjMHy/6XUHPoJPgLFsoMrZHcnboU45FWqC4oCwaf4a77RYrOnP3NfEaFsNup3uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIFNgl9BviscTDx1CmoGVAAEIx23GtfJMZKtwtB0KGOR3zbb0n
	KMeBh5V+aktoONt5/VjDjeMyK2EZKNX/CUsFffsEoh+72U7CTlRbYjxeDsdApcgXTMn7erUu9Rn
	G2G6A0joW9VFbzcopHMkwlUg2B9qtp6VLrouZ4DloQ4DQPhUUpMqlbnXm1glI4JX6+Q==
X-Gm-Gg: ASbGnct8bxXQA5d1kFrmvEDWfj9B9e4MJYR3LeaURUgLsFgauTyZU5PlEDtX5TR6+2k
	wy6KOD8d+7sZfNKMhBRJ5y2nnjMoa+iJ/IspM+PuEX3cvTJ061zMXoAxwmzx8t/a2pPgHeK6zTY
	kYUD6DtvKJuWgH+TX0fmDbTLkbqVzQ7cRask5EbZ2YWVRGdvU7wsZtRxy4Vs+uDAQ7l7yTB/v87
	2XrjNG1L1CBQGQISyltYilFCKfWAKEX7XikauzC/tCwqNcuAEtkq/LvlJQqRQHfHMMP7MUlnYMb
	Njh2HSn35jb3097HEr4=
X-Received: by 2002:a05:6000:4285:b0:3a3:447c:c341 with SMTP id ffacd0b85a97d-3a3496c20bbmr3094551f8f.27.1747230412068;
        Wed, 14 May 2025 06:46:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH78JQgYCZi7PAI6RbgXsNStikuLBd+X8aPd5vCyBuwPC57MACif1PRt1AJ3M7lUf2aeHKigg==
X-Received: by 2002:a05:6000:4285:b0:3a3:447c:c341 with SMTP id ffacd0b85a97d-3a3496c20bbmr3094514f8f.27.1747230411506;
        Wed, 14 May 2025 06:46:51 -0700 (PDT)
Received: from stex1.redhat.com ([193.207.148.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2a07sm20175282f8f.50.2025.05.14.06.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 06:46:50 -0700 (PDT)
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
Subject: [PATCH v5 2/4] tpm: support devices with synchronous send()
Date: Wed, 14 May 2025 15:46:28 +0200
Message-ID: <20250514134630.137621-3-sgarzare@redhat.com>
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

Some devices do not support interrupts and provide a single synchronous
operation to send the command and receive the response on the same buffer.

Currently, these types of drivers must use an internal buffer where they
temporarily store the response between .send() and .recv() calls.

Introduce a new flag (TPM_CHIP_FLAG_SYNC) to support synchronous send().
If that flag is set by the driver, tpm_try_transmit() will use the send()
callback to send the command and receive the response on the same buffer
synchronously. In that case send() return the number of bytes of the
response on success, or -errno on failure.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v4:
- added Jarkko's R-b
v3:
- fixed comment style [Jarkko]
- renamend `out_send_sync` label to `out_sync` [Jarkko]
---
 include/linux/tpm.h              |  1 +
 drivers/char/tpm/tpm-interface.c | 20 +++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 10917087b70e..33f2aa1a75ea 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -351,6 +351,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
 	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
 	TPM_CHIP_FLAG_DISABLE			= BIT(10),
+	TPM_CHIP_FLAG_SYNC			= BIT(11),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 816b7c690bc9..512882ac0db1 100644
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


