Return-Path: <linux-integrity+bounces-6075-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1358AA44A0
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 10:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29CB3B546C
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 08:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7121EF36C;
	Wed, 30 Apr 2025 08:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rty926Vx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851912629F;
	Wed, 30 Apr 2025 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746000050; cv=none; b=A1K7Utqmo/z6lFUbmL4tH8IYoZmv2JvVI6x3XS34JgLbsXKt+8O0JcyeMOQ/BqbMyP24vzoc/5GdjAyy264u5ABm/CcaZLSvXdFudSDNkwDM1SerKquqbOShjnyN5EQmZL6AukQHqD3aMADoyhlBS8F356XatE9xnIzMfPEIeck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746000050; c=relaxed/simple;
	bh=YmiCW6q7DJwXf/OrdKqtYEugswdEJMRSv9cvj3V7CA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZDyiXM3P9AiMBexZ0W4zDBQZ42WCu3iw8e2fm40zuZmSfdBXr9BCdbLmf7HDVnupnryxrno6Blgg6zlzakELaCyCrugzvVIVDep9jfqBWbGXUnlOZWpyxxgdn6dCy/MdhtJT8R5FBqdZRO3Q2DGxeoglZT+AxzBQc3fn8i8WJus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rty926Vx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfe574976so47884935e9.1;
        Wed, 30 Apr 2025 01:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746000047; x=1746604847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9K6mDCECT8W3Bovw6myYDbhmO8/mbagCIk0F1CteZwg=;
        b=Rty926VxVvsySFTXWzBpPYm6Ch/Npog9O0cHX1FXuVdGAhfCzq739aS9MFV4G2HzR9
         tJ0PM6P3/eFu3aZt2/ZWI5JcsolpFn3VwUoh3h3lLpf4vIloYP6C/YIq8O/oEtT7I93+
         GOigyXbFxdjb0Abd1V4AQYrosLUvkNvi7yqe31nXqx6U/ryqeiSWMf0gm+2j4uG36Ltp
         l1BY8XKaPF35k1TSjX2oV7IxFdo34Yy9e5F42q4XKCCdd6m9WrToUtHrLSUDLg5xVLHC
         GaD+QwZjx/4jk6ItwJ3Mu1/GQ4BaLc6vZVrBmf6g60+AiPuj++PLOJ26bLeMK/AIZ2qH
         /zVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746000047; x=1746604847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9K6mDCECT8W3Bovw6myYDbhmO8/mbagCIk0F1CteZwg=;
        b=iQme3y4lyDqEN0KjesPFMi0C5D84jtAQiOOwya/8G6blCTZhxYA2RNNXTnKQeYZbkJ
         wH3yANtnfR7aH5Iuvd3CSXazR1oJ+Fv6sobJX24mAl7t1fedp4PTkdI3ADZJD8CMnVyW
         3mIqFnatzKd28wpotLtLUlDCw6ribVuMTR6764ST7Px5OkMv68ahn1aL8Rvz+Wx9SSVw
         6cyeAlX9y2Dw9N2yjmzisOLqJZPcuv6CWUFm006cTvVmO25EB7/Yi4R6r4gTEnTqmZPw
         rKj6fkpkd8nHQY+g8+8vgKdN2DJNkR+x3TMSdnfdR+kSim5UTdgNAuemV9/ssBe9nnPI
         +MPg==
X-Forwarded-Encrypted: i=1; AJvYcCXAaqvYZnmtfK3BW6bTMGCR9v/TnuyMyrODucqc8Ny3ttHnU7Yc3s5P7mVtum4s171EPiYnhqV/naFnEDPjlEo=@vger.kernel.org, AJvYcCXqr81048WROV9veVgua8teQ220zIwZtf7BlB76bOR/e0EJVGAezigFBvQnDh38bO8Z9qSEa+YPA3Dfp4kw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ipc0sjLKT2Ex29i2xtsCe7wNFjGYCYK46S1yLqrE9ABBXJoS
	ZzRZVocUtqFxA5383BtQTjFqhKOL5376naiJLM96hIpvBawcPFGv
X-Gm-Gg: ASbGncsR1PZc0PtAUfdmqFDT6KT+/8k0Y9Ms7INvdibkL95ux7YQTQ5FvApL/XOJleG
	f24pz6xg0Q0ZzvbyXPBSyIIawJTqoMwyWcz34c9js/+Gbpq5Degsb8KoA8MhPpnEF9Fd4vo4heA
	5NBwqC2lntutAGdmhh54LPUN4Xcr4YupObNSIkyySkRfIkjeLkstka6bLNU67z4xs3MLKuTvG/B
	49fbOO4VTZ7CLhpB7EQ+Mf6Zle4IQ3YrVFHA0KIt5ZuZnMdsa1TTQ7oiAXNNqUW/bPTFAyfZiXN
	tb2Lx8bIcbTRVm8I4a0vYAovCviBscJ5OtrdAtvJpg==
X-Google-Smtp-Source: AGHT+IEk1a/o7E5nFPRynA4tKzjO97Pglf5ne9r4g+R9H1XPl6ea21/dzuWLNACGIfTAB9iVw9P43A==
X-Received: by 2002:a05:600c:a4e:b0:43b:c95f:fd9 with SMTP id 5b1f17b1804b1-441b1f30682mr18772175e9.5.1746000046481;
        Wed, 30 Apr 2025 01:00:46 -0700 (PDT)
Received: from localhost ([194.120.133.25])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-441b2af2922sm15356535e9.17.2025.04.30.01.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:00:46 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: remove kmalloc failure error message
Date: Wed, 30 Apr 2025 09:00:37 +0100
Message-ID: <20250430080037.848396-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The kmalloc failure message is just noise. Remove it and
replace -EFAULT with -ENOMEM as standard for out of memory
allocation error returns.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---

V1: remove trailing space after \n
V2: remove entire message, originally just removed a trailing space
V3: replace -EFAULT with -ENOMEM

---
 drivers/char/tpm/eventlog/tpm1.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
index 12ee42a31c71..773e9e537991 100644
--- a/drivers/char/tpm/eventlog/tpm1.c
+++ b/drivers/char/tpm/eventlog/tpm1.c
@@ -257,11 +257,8 @@ static int tpm1_ascii_bios_measurements_show(struct seq_file *m, void *v)
 	    (unsigned char *)(v + sizeof(struct tcpa_event));
 
 	eventname = kmalloc(MAX_TEXT_EVENT, GFP_KERNEL);
-	if (!eventname) {
-		printk(KERN_ERR "%s: ERROR - No Memory for event name\n ",
-		       __func__);
+	if (!eventname)
 		return -EFAULT;
-	}
 
 	/* 1st: PCR */
 	seq_printf(m, "%2d ", do_endian_conversion(event->pcr_index));
-- 
2.49.0


