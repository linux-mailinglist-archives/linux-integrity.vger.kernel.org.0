Return-Path: <linux-integrity+bounces-6483-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BE9AE1B95
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 15:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1433BA47E
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 13:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882F7295DAC;
	Fri, 20 Jun 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frlGxrUK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D834B28DB58
	for <linux-integrity@vger.kernel.org>; Fri, 20 Jun 2025 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750424927; cv=none; b=aQMXKpJnoL9S9aKPH6tJ49rfTo4bqte8/QaERIGzImPz3iNKAOlsMoDbUeI7VL/V2VPOi6m/PpoZGVfuZ9kvr7j5HPwsMepEqBRZU4iR1CeklQMDa+OWyjl6wIuMeXec8+C9atgTtEPoOa+EGMKR97kQU2NMx9FueQS2b7dYfBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750424927; c=relaxed/simple;
	bh=SGqgKoG22b6C1KUVZdjUSTs2kaB+RNsW6eQB1XhBn8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwqhtlVZ/lW3ajKNMvXBz5fQve1l400FOWEwCpyrUJ0fup/d/suLMw84ij4vcL9bQm7mC/pbdX6R4haBD006tkGQTrU3grJldY4i55S9rfTN7KhbxS6PyZrog2xtzoBp7UXswqYzoh7sSfca2VAX2LEvwdjOCG1X8JtDMaLHdyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=frlGxrUK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750424924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mU6fRW0bf+EYAAFC1zO6IHYHxJSiouX7LXjrsfJfSvc=;
	b=frlGxrUKJkbYSodhcVpo9m8it9Ms71r5/TqLn+K++JNc3LxegtNx3UUhlzZxZK+XTNVQtU
	4QNfI3FApJUIjuFiWuNXSoNeahbWYkEEbBG6TMFcgO28ezEGXW+JDwuGe0vAIiQqYSruns
	4RlcaCarFd1oKKNO6FYbv+z19kX73Gg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-0JVzGnl5N9SVFtXy2Y6b6A-1; Fri, 20 Jun 2025 09:08:42 -0400
X-MC-Unique: 0JVzGnl5N9SVFtXy2Y6b6A-1
X-Mimecast-MFC-AGG-ID: 0JVzGnl5N9SVFtXy2Y6b6A_1750424921
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a54a8a0122so932874f8f.2
        for <linux-integrity@vger.kernel.org>; Fri, 20 Jun 2025 06:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750424921; x=1751029721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mU6fRW0bf+EYAAFC1zO6IHYHxJSiouX7LXjrsfJfSvc=;
        b=s80Hc5hLkE6OuZs0lRrh0vLn/L2OIEnpCBLDE2CdrgnffmiepBXQjPtcSwXfdO6Vdn
         ZgkcpGNyXe0g8ENC0GkRTa5WPKLXX/6oTVoehjqYTn2Pu97g5Ct/pc6tG0/TmFgIRDsl
         OUR/3fKOzbXP7orNe7CjYWFw2KANNDs9znI2BT35G1SybIcXDFPTIItwbnz5s7WmCgzY
         CzHoTLh+Yfcz5WHLTFJSG1bDTvxXFyOg8FStPKbbE0ftsHs7aPdqiCAtjCfZIk4BD0gU
         QzH2RTPfiMtUJUPmjLtfOuXX4u7rrvDGr+vW+iCo4DQcR/fuKd8muHuUU6ZFNYkZoClr
         FaQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy8duGkLhjltSJRykI16g16CkUs7MaZ12dbt7Ha4thix0IJErEezDch7K5JrDVMwl0jH4j8J+jSNBeSBJw6Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3NjFYdj3VAk1DhSXaPqF+meOiEahxAsyx1YmYHhEWCXzCVdpH
	vihkysquI96QLuFtVTDEKtWPiFkmRSealdeYHRYtRd6X7jPSGNvhrry5XkzyGEFKBZ11cuWa3yM
	Nq5LZmDOt8kfEMMmXVhHMQrucNprv4lCn0DbwmsKixAefRutpg3OTsnyNj6UJAdmArg4JwQ==
X-Gm-Gg: ASbGncs1yGJDjo8p01N+gcmxdU1pkSEdxqiVgXzdFTVbF4uTBBo9BoanbHyIuzcQuHj
	gD4uA+sMU9Exu19hRa+4mM0JRXdiAIuT6DOxLbjDoJNHivq00h/jhelnPeMO+FswyauQgCmhwoi
	ew6AoS+z8PPZXfQh6mDme0w2BAuo9/skxMKTZFQ8LRVthaNFZIyD/A8/p1MLdNBuGoVqNYI61sD
	wl/fQPFIAst/6944Q1k4PVPtlx4QtYVM3QU38lLEbptlKSQ5bGvJopxGKAZHIkCk6FvwGT2lAmj
	nVq3LDtN4rA+iVB2yYFUtzFu3SHH0O0W04Y=
X-Received: by 2002:a05:6000:2dc4:b0:3a4:c909:ce16 with SMTP id ffacd0b85a97d-3a6d12e8b9amr2295005f8f.49.1750424921116;
        Fri, 20 Jun 2025 06:08:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMsc23lsWWlIHXqE+KHJfC+ZldUu1vo9dW8yxZbj2jYFLBGKoFW23IJVfV5e9H69ci92Gx7w==
X-Received: by 2002:a05:6000:2dc4:b0:3a4:c909:ce16 with SMTP id ffacd0b85a97d-3a6d12e8b9amr2294941f8f.49.1750424920468;
        Fri, 20 Jun 2025 06:08:40 -0700 (PDT)
Received: from localhost.localdomain ([193.207.146.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f1815dsm2006309f8f.28.2025.06.20.06.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:08:39 -0700 (PDT)
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
Subject: [PATCH v6 2/4] tpm: support devices with synchronous send()
Date: Fri, 20 Jun 2025 15:08:08 +0200
Message-ID: <20250620130810.99069-3-sgarzare@redhat.com>
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
index cafe8c283e88..804fbbe3873d 100644
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


