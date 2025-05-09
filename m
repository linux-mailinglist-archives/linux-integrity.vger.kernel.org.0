Return-Path: <linux-integrity+bounces-6167-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E151EAB0DF3
	for <lists+linux-integrity@lfdr.de>; Fri,  9 May 2025 10:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D75522361
	for <lists+linux-integrity@lfdr.de>; Fri,  9 May 2025 08:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6467B274FFA;
	Fri,  9 May 2025 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xkcm7+71"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37AD274FF1
	for <linux-integrity@vger.kernel.org>; Fri,  9 May 2025 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781062; cv=none; b=uJLjoJkN0PmXNClQJur8X801eTgM1u0YdDAiMnK6sSMeGWS9AzHzKWx7sF/8ftYxaipGbJWOxmOqKONbhkgvO3ZA5mjHNrzAkiZU8/fjyVTux1nlKdXc7FiIQ/kP7EiRp0GIJRNz3Rg/+dGMbawZn9FEFWJVmrvgVNnw3Shj6iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781062; c=relaxed/simple;
	bh=zRCxlcH/ra8GADDFcLT7DJcTWYPmd55lgBOJaTcmkfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgpNBNx3BtZEWriPdrO2CwedM/mdyfHoH6W0h0l3LYEdPFvwH2nvmvrAOC9VfZRLK/zr2JaJduL8K3eonNxSej28QJ26j7bujYcy4u73rHRF12FuInJ/yCZQPWGg5nbxtRdiByK+PgU+uh8fqA73/a4eazhE9C9bvws3bYaqvQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xkcm7+71; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746781059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDWPbShizfOGB/EjWmdUWFa8dOmwyE7Lp4wOXMg3HCo=;
	b=Xkcm7+717ETGEMWDHOyOKnc1CUuNL0fX1Vci9rTMBEaV2TVOQa2Rp/7evXZZCt3bGT1N0k
	c3yBQ8lTWCPlx/r/z/MpZI9thvAf3feEZqgTIE+Htrs1boR0h66BdPA1N58ARh1pE8j5k/
	5P9x4JnhSr06IRf4bH1D1RQPoUMSiTY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-tXYfEdZ5NL2zm5FQs2hLkA-1; Fri, 09 May 2025 04:57:37 -0400
X-MC-Unique: tXYfEdZ5NL2zm5FQs2hLkA-1
X-Mimecast-MFC-AGG-ID: tXYfEdZ5NL2zm5FQs2hLkA_1746781057
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-acf00f500d2so148341466b.2
        for <linux-integrity@vger.kernel.org>; Fri, 09 May 2025 01:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746781056; x=1747385856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDWPbShizfOGB/EjWmdUWFa8dOmwyE7Lp4wOXMg3HCo=;
        b=QG5XbPif/UrKz4c5zVJR+7qgMDXGq+ghGzZ75grFGcYa2d2QX8TN0g/bAqv4iuYyCB
         hQeYWJmVDsCRcO4BdTfUsNtP4mCq5oJkVNL6SoyEtU77YgErVm0BlFU3vI/rAFgKjOZI
         PCFBOrAx7pw8Rkf0Ktu32BOEXsaJxo7lbY6AmOv1JkapqNh9FuaWnShy+kGqGcq3OalC
         ldsAWjmgMusgNfx7Opd8H8wq/vftck5p81vvzdz6Gd5n0D0dfi3nOH2OYy2QoN0S1A4d
         9SJpCDft0CfgprEfDxUow/HPMpsWI8istajZ/O6lw8sSJpd32Z/tw3D3a7McAZufAEag
         4pig==
X-Forwarded-Encrypted: i=1; AJvYcCVja0ta58hgzplmhYDOvbkSvU5CwScmI5aLVvBoZxuDtA9ZIXbNWWIt/G7OU+FmDF/N4X/BQWhidkLTvGsF+nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIEgFcDq3ksO8FiGI3XNSgR7aUf71J8QFrkdNLhmEUI+susZnN
	CsOgR54tdM6g1W8NmlmufrdgFsAOWpJvPupAY1i9VlqZrx+Mii0HCvKBy8Em+8iZfcwEEvvh/OX
	iZuwiK2FhQjm24p0CFk3trxvIo/0vpMJ8Gm0Atu1ORsrKTbJ2cZZLHRjsp493reo9bg==
X-Gm-Gg: ASbGncuaV+U3IoR9pSJglnGoe626rfQk+aRzDrWymV3WXaPOIw/lwZ8ny4X4o+eryhY
	WCbwOz1Wco0XqRL7DKlwmGsY5muSOfxSBfbGqkvg4F/TlDuRmvHoQrMLsLz26ZSkS1ADT2kdDMH
	VJbdSAHdLOlEIg5aCKJaBcIu0wEv5KjQ9M2HRZ8j3XfKnuuU/IdGd8DzWM/ugrUxR20jOmWC7ck
	nXo5PPXw5+EdX1ZPapFL2CuH6myfLy/hzUSOQtXGReE5IANvDIK8hM2XRf7pRTbXFbSJqKXyAEr
	sZYL3HydG/AU2aJ68lQ/jjnnLQ==
X-Received: by 2002:a17:907:6d17:b0:ace:d442:e3a0 with SMTP id a640c23a62f3a-ad2192800admr253473466b.39.1746781056571;
        Fri, 09 May 2025 01:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWC2UI3h5FxOwhQZy5rykHQm7izno8puX6wcw4GMYOzhRsRbgt+ZXqQ0AfZuUWsqn/llgi1A==
X-Received: by 2002:a17:907:6d17:b0:ace:d442:e3a0 with SMTP id a640c23a62f3a-ad2192800admr253468866b.39.1746781055796;
        Fri, 09 May 2025 01:57:35 -0700 (PDT)
Received: from localhost.localdomain ([193.207.182.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197bd37dsm117478266b.124.2025.05.09.01.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 01:57:35 -0700 (PDT)
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
Subject: [PATCH v4 2/4] tpm: support devices with synchronous send()
Date: Fri,  9 May 2025 10:57:11 +0200
Message-ID: <20250509085713.76851-3-sgarzare@redhat.com>
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
index 7ac390ec89ce..681661c93869 100644
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


