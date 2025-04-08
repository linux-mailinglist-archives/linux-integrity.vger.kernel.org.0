Return-Path: <linux-integrity+bounces-5660-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EE9A7F7F6
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 10:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC809189CDED
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 08:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F36C263C68;
	Tue,  8 Apr 2025 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QzYIbl3l"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5481925EFA3
	for <linux-integrity@vger.kernel.org>; Tue,  8 Apr 2025 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744101146; cv=none; b=KTGkR+X5t25wXzoEz1CmS45wK0oAassU8lf1suF9u7OucrIQEr/CLzZN1P84xT19cBik20/zTw/JJb7hnhyJrhEnhG5O2CLvB6pw/w0wUvd70XjMeExqT4/r/ZezVklCZYUgXltkKsbtuqHVY5YkFUsu8sEV9Z5ddYLB/0nCQg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744101146; c=relaxed/simple;
	bh=WvbgwlAGGsl+4IleITMI6e4y/KHe7f57c66lAWpy3NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8iY3SUCDrHb2uVTUOmCyS0w+7UirNOO7wW/KNSCOfr9gs57YzXearuv5IRegokWc3vfVFKl0uOoeREl3DWoyZR7FFKoui7j4aKQP1vkKXDmORAywskQSHWNX49QJE8rif+aHK7RLv6N/vMqvOi0JFSzlMc1s5tjxvgyi1Sq4lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QzYIbl3l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744101144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDE/YZIPCEEz/h330X/plomZy4BudCgqspAc85dgVok=;
	b=QzYIbl3lvtm3aKVhR8N6vqyZcmVUPaBGR6S1oYXEaPRHX7m3zN89lrKRnW5kIiQCIpIv7m
	WUfC3sdtPLnMQ0LSEw0xnHM2yDomt4jA61TGaLhNGxRh3+/eCaKDZLsfStufrVqNTk9YCp
	Hx+fahkvYDTAMfP5iifjmk7w4j62KMs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-dAgLTURlN42sOFiT6-a45Q-1; Tue, 08 Apr 2025 04:32:23 -0400
X-MC-Unique: dAgLTURlN42sOFiT6-a45Q-1
X-Mimecast-MFC-AGG-ID: dAgLTURlN42sOFiT6-a45Q_1744101142
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d51bd9b45so36341515e9.1
        for <linux-integrity@vger.kernel.org>; Tue, 08 Apr 2025 01:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744101142; x=1744705942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDE/YZIPCEEz/h330X/plomZy4BudCgqspAc85dgVok=;
        b=RtlgO5DClv3YKhBJLsrSOl0qY7yXfOvU8Ej/kSHBX++/3AU9i34HLOwTpHGErGwq3v
         jQq/OYCh+4dFUlA/+HkMN23unKnRjFi+wkjC4O26i1eKgXwUIzEeadqsOuydwoy1gcny
         bWEB7XmZ2vibJKqJLE5t5eo+yzIMCdeTi1cN2mvrAgHn0eohiweKX1ZX7QhNzpks4y17
         KApF4dLNzMOnikDt7jar/5CluFA11YIzEZ5mETIqiKnlru8BXyQ5/ojz7D9YDGJV2uGo
         uYYIm9YXpGPRU47AUpBtUIJpXEhdazAn8mP70RzRO1HLglQiVpnsFpKLJtsBsqnGh+PQ
         WBnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNmSo/SqfKw7ZPyDtcLHcDrkYhHikXwOO94pSieHYmx5MNlVw4LhEW0CzJAd3zz5McQo/SYDaWv5pCDQylJcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHXjxv0lza3419KCbMoiiGj4tNxfnr+gh77k4jxdMBq96gWrHi
	K/tHqDICTYat5Ok79ZQm07gkeCyWUaHMFD5k5Qh8c2lfUaJxItEtFSyqdR6TQC4vXEHhyXFsBcT
	1ZFCZk14BygPuN5YaF4Ax1NudZIev3XBupWDVBKKpaW5uG28J0n8qwiAHpRVVhTCb/A==
X-Gm-Gg: ASbGncstBi5EHnUtdBq4ItoCAk7wEV+oCxqi2QQ/qaGrA5bbQXtP5jMqC0XxiRYWDSf
	qpIBIguWgQ3HjYe/xlJYZGT4hfws/mNWT06oG8p/mz7pzV/WO3YcSvV0ZNPylXqX2V4tKCIq0ZF
	txip3Q2zW9JFf9DVCjRxZidNWAghKsLZLqkBe31FuXqXYbKMSy8NctFXLa8xQoBMw+DxUBCYFXJ
	w1kDnHGwzES9AgCZBYHSelZQNDOf9TZHagU9QzpQVbUgpJT0rtYzqJEUBdC3Ru9uWlEVBMUXwmn
	kZH6/V1dlyNoYp0wes6x1fNJOiCJySN9dwD+EHTcNGYmhZ3Ndx0Pwhc2Kp4JJJ52Qw==
X-Received: by 2002:a05:600c:1e13:b0:439:8c80:6af4 with SMTP id 5b1f17b1804b1-43ecf8d0b48mr141342835e9.19.1744101141991;
        Tue, 08 Apr 2025 01:32:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQhp1MgrEqOjc+4MW66KZXrp62NtlwXCuZ1w3QWz8IsRQIARyOk/4wlryzdly6gRSlx08ezQ==
X-Received: by 2002:a05:600c:1e13:b0:439:8c80:6af4 with SMTP id 5b1f17b1804b1-43ecf8d0b48mr141342355e9.19.1744101141383;
        Tue, 08 Apr 2025 01:32:21 -0700 (PDT)
Received: from stex1.redhat.com (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3009680dsm14051923f8f.7.2025.04.08.01.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 01:32:20 -0700 (PDT)
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
Subject: [PATCH v2 2/4] tpm: support devices with synchronous send()
Date: Tue,  8 Apr 2025 10:32:06 +0200
Message-ID: <20250408083208.43512-3-sgarzare@redhat.com>
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
 include/linux/tpm.h              |  1 +
 drivers/char/tpm/tpm-interface.c | 18 +++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

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
index 3b6ddcdb4051..9fbe84b5a131 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -114,8 +114,17 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 		return rc;
 	}
 
-	/* A sanity check. send() should just return zero on success e.g.
-	 * not the command length.
+	/* Synchronous devices return the response directly during the send()
+	 * call in the same buffer.
+	 */
+	if (chip->flags & TPM_CHIP_FLAG_SYNC) {
+		len = rc;
+		rc = 0;
+		goto out_send_sync;
+	}
+
+	/* A sanity check. send() of asynchronous devices should just return
+	 * zero on success e.g. not the command length.
 	 */
 	if (rc > 0) {
 		dev_warn(&chip->dev,
@@ -151,7 +160,10 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 	if (len < 0) {
 		rc = len;
 		dev_err(&chip->dev, "tpm_transmit: tpm_recv: error %d\n", rc);
-	} else if (len < TPM_HEADER_SIZE || len != be32_to_cpu(header->length))
+		return rc;
+	}
+out_send_sync:
+	if (len < TPM_HEADER_SIZE || len != be32_to_cpu(header->length))
 		rc = -EFAULT;
 
 	return rc ? rc : len;
-- 
2.49.0


