Return-Path: <linux-integrity+bounces-5344-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8667EA6A9D6
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 16:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AAA28A6951
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 15:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D22E1E98F9;
	Thu, 20 Mar 2025 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+B8bvW2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA5922370C
	for <linux-integrity@vger.kernel.org>; Thu, 20 Mar 2025 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484289; cv=none; b=YkCxs3IvRIPnxCaJ/ibuYpugZZK8tL5uM8bjxLu2AnobuKSvOUw/YlkBtqWwcHop+aHdOsXCXWBb9LdFFWH1D6gPhhtETZT4rUD7A9V/zYkbd5owEQUxM2Zd96l7hvWJ08j6ZEoP9ySOy4FckxcRqrmvBs6ev4lI4y5FnLb3WLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484289; c=relaxed/simple;
	bh=myzODkLCXU9k+CNuyKZbtSDZie+rrUzmakLImNhXOvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfB+KnJ/mN9QMHwZo+uJZaomWzTiIoBmqMUy4QPEJnY8rC4og4audwio3wQB+Sky9xhkJJGOn31lU4v7vbEP2LDj310/F8ePLfPeg+/IZpSRcICRjEaaj/Fsa/r6MALtGdeV6b67m3busTz7fAqDm0EEWWki4hsnF4gxNYwuQ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+B8bvW2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742484287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2gxWk7Mqfo6u16dcSf4IdAvykfJIBF0LRh5CbMS2gE=;
	b=Z+B8bvW2HepaL+7hA4sJzp89vpj9xA+8vzc6oWXnunGMCdIu/iCDX1ac+Y30FG8HxUjOr5
	VEcwPCgF2BkEUrdi0JtHFLkGAOzptE4Sb6QL/3X5spsycBaCmygRU6AQkG6ZPAvnbSLOpS
	lKPSRB3Z9CsoLAj6pSzgClbTsXea8OA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-sWd0ZQihOf-XFga-gLyfng-1; Thu, 20 Mar 2025 11:24:45 -0400
X-MC-Unique: sWd0ZQihOf-XFga-gLyfng-1
X-Mimecast-MFC-AGG-ID: sWd0ZQihOf-XFga-gLyfng_1742484285
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43947979ce8so4271695e9.0
        for <linux-integrity@vger.kernel.org>; Thu, 20 Mar 2025 08:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484284; x=1743089084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2gxWk7Mqfo6u16dcSf4IdAvykfJIBF0LRh5CbMS2gE=;
        b=lG05QPe9pFndMpkGic/MqGPqampSqpLiAHRsroFU2AEUlljXkiZUrApm/RGJ+gJVgw
         4X+HZChe8rNk+p0DInQYlmsiMPzOvTceOpU2dzLC4bw8tvqPyoYQYJFJw2VZRULyrXpl
         ic1A9EUyjUSjxb5oPXpQmbQ864r+iz2ePqCIknS9sIfv7wChZjh7Do2ZVUUsv6KU6w4U
         /LKXQwQwmMvsLAIFna6TNIkvndw6C3USRqcunI29AYwcNpLwMXtZMAHAIvUzxJkAZUaa
         HNaxM5BV4wo341+a+Yjt9LrBUIa9aYHQ+HWd0SrK4hKL0H7fr8Y7gY+LBaqPs2IlkD1Z
         otyg==
X-Forwarded-Encrypted: i=1; AJvYcCVURcAhLA2vZti8MHsBlEmRRORcg+8AcH6U4ASkW5MhyZVXDkJISU9z6JkPin1qaz72xvMxcIcysOrCns5VjqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuqt9wOEdYOYM6b47gmSylcynmZF91p4aPWpdy//tG69M9nZQT
	D5zDMn75bQopjpU1eDnnL16C16E9qawCBJaCRL8d8K1bUTEIC9tM4oPPIf5zKpY0DTx0N5rWCft
	l7jHGuIWFc7hMweQikGNZkEG6RYHbsXT5pJoHmsaosfe9LwfEWyCImeRu66G++mrb/9Z9u0ifiQ
	==
X-Gm-Gg: ASbGnctGukAmIWhocKjUR6zI9JnQyFCUmKeiI3RKRKGJYFk9RpC4CmLVOUOmjwiVofo
	Hoat1PWRDeLtmJ5LtpiO0HqF679fIwcvrsxypOa/6OmmH6zBAfNscZtU9zd3aGvKIn3vKBTzgDf
	si4vt0KHxDrLk5cQ2y6DKXkunbcZTZQgSV+oyjYKR0Bb5jr1LzeuExEPHjCQkhGqEuJ7FiYLL/q
	453X2kV5EUr4KvIJCqw7hDS1we7wplZD4qMPPQNoALJAAs8Djfj6/FhK/IWjjMaus0DAHNSGb/n
	NMNh/KW1OeJqF1Dl8jS+SejNZoBihEoT/iYNWHgZRXxKgVa7Och5xNO4LnO0+YvIDg==
X-Received: by 2002:a05:6000:1a8b:b0:391:6fd:bb65 with SMTP id ffacd0b85a97d-399739b4dbamr6532452f8f.9.1742484284382;
        Thu, 20 Mar 2025 08:24:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8AHddaOw437CUySFfwsnP8Hprx1HumUa59qJL3ncy08x6hV7c2+DaL0UrDROuWkbDQnZ/yg==
X-Received: by 2002:a05:6000:1a8b:b0:391:6fd:bb65 with SMTP id ffacd0b85a97d-399739b4dbamr6532410f8f.9.1742484283787;
        Thu, 20 Mar 2025 08:24:43 -0700 (PDT)
Received: from stex1.redhat.com (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fceacf3sm974085e9.3.2025.03.20.08.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:41 -0700 (PDT)
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
Subject: [PATCH 1/2] tpm: add send_recv() op in tpm_class_ops
Date: Thu, 20 Mar 2025 16:24:32 +0100
Message-ID: <20250320152433.144083-2-sgarzare@redhat.com>
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
index 6c3125300c00..4e796b8726b5 100644
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
index f62f7871edbd..7f4e01790352 100644
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


