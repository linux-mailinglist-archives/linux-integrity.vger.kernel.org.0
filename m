Return-Path: <linux-integrity+bounces-8135-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4446CDE940
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Dec 2025 11:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE1A5300C0F6
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Dec 2025 10:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE44316909;
	Fri, 26 Dec 2025 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwhsPqCT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F24299A82
	for <linux-integrity@vger.kernel.org>; Fri, 26 Dec 2025 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766744650; cv=none; b=dCwQdBWQDEjFT5iXk4EwTJgK7jz6Brx+Sy0enYnaso6K3Ytzx9GDUJhXqkj0NE2VG4CUNl1/aKOecfaN27GZrRCVufUjhRh5he5++m5g/NjTNyOlrC29totP32uoYT/eYEiWlAo6OiBbTdPwneDjO+2nwzksPA1SXVq4qOJGYVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766744650; c=relaxed/simple;
	bh=q54TVE9xxsQky3EH8n2s/mW+Y5L3ExtjjV/hstmghSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SjZs2xAsN8Z5FKV3R8ryDTDyL6eqyhnmAo20+aWT0p4o9nrNpDdDQDsEbqxyLr/k+PhzSFd57m56RlmJtCkKK19MBIYRYGems8yAFFpoglI9/9OZfnhyePNwcTTWZ9uxVEaXkyi7zIOFxP35ao3gHWFymSuNwGKqu3jGFthXxpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwhsPqCT; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59911cb8c3cso7879997e87.2
        for <linux-integrity@vger.kernel.org>; Fri, 26 Dec 2025 02:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766744644; x=1767349444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MGr0steWVR+tud6A7R1zsUzouFtLNpTY8y6W21UhPic=;
        b=XwhsPqCTsefKADYOApNHM2ktRA95jFJosqxakaYjA0JBrxnadrxNMRgCu5qZHKtzi+
         mV96q0gdwAgbO9ZTgdoQWPH4n4wlm3+iDXTiP2bEejOx6/7IhUmekA9+gca88/Ih1D94
         lblWVd5WIOT2H2kvNblvazMQUfOmeLhl187A9GHcF2TRUoqwmcrk0GP5Yebup3yERQqG
         A47VVy83+tUWpjsEGOA90yNHPEg/OUh4pRsLR/vvNBwFgG/d1PPtRiWZE+SM0THU7hQf
         u2EzlEYOVeFATquvTxT32Tvw+Ck5pBZDAy1GQJsnfBOYLd+hE5/xDjrNtXT8CgYfE0GI
         9BSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766744644; x=1767349444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGr0steWVR+tud6A7R1zsUzouFtLNpTY8y6W21UhPic=;
        b=f5c48l91xnvi042rs9oRiVust5HTf+mBJ25vlH+H0c64bpmSjSx3a0oUUeoh7EJ51q
         nP55D0PN1KRse32MI9jJC1qWsJacka4Lm5HUDTf8OuDIVPVvT64DEWJsrsztQkpisWlz
         IiY4JXgUR0VrfQswJmmQSNWex7ZThiKo0+4Jbejs+uT+WJRUfPyHdgDjLiUyPdhvSNyb
         4VhFlZ2iCsCtAvWpIfbcEi20dFdL33at024MZF3nP8PThS5590xRV0mepOFYkYBsvpkp
         EXnXVuqmpXAe71dj2ytnt4k6F4zknTkZrq7wouEZcOJvRA1VzB31g7Yv1NizMZv0XSgV
         mupA==
X-Forwarded-Encrypted: i=1; AJvYcCWEQIHyIiUrZrs0Ayg2LYb5HP/KpENjpvJvyppO7tHXBmKgJpGcLaX6SERpZcb7BwyvmZnHp7Z/Vi84lqk/wvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqVoky6vM5VE55q1PMmYpoIGr5LpEKapvjj9GlArMdQySW9Uwg
	mdLZZhDzQ2+Bse/nC6OEdFwk+HsyxSKs2JcmNZ96qJwjblDxrICpekxq
X-Gm-Gg: AY/fxX7c7wxIrXwv2OimEQd+Mp44gJvQBGieI9Lv4xCjqCH0DYOxpGLZ1MQw86wvAlE
	0RqR8PSmeRJ6h1Lnnz3EpfWyp+LOXUTXwdUM4CKI083iwAdef0WHgvoPQ5mr7ubhSmGMpPkqNjB
	/lPNsuEG2P04VqFSgHxo3ysHIexw/JLBZ2h0C0Ao5UYCoVdvcUtRvAsQKENFqu99Gtz6d3VJO/9
	grkyazCDtJ+WPrg3A+uleeRrnyPGWSfJEnqwM2C8IZprtR6gScMiAi5y4MA2pTtmwxLl6kEjIqL
	YYY3OKJ1x6K9IKqzOxEpOvvsLGqvUk2SHJS1XUd75LOdkH276VWZ8IEMyR6L3oavwenzKv4+7Ip
	aZOWv/Zr2wnXvAoDwgbuScaWJjoGCxwCHxy5qL87x9ziqx7WZmclB4ZLAO/6tMOUEz573/dtEZA
	PJGC+4MGiyxuo+xXpReGfkJXSLJf4=
X-Google-Smtp-Source: AGHT+IGVV8Y/v4qTcN26cr5MHMCOzKjuyYzizYRbwpe8C3zUOB+9ClEo3hD2TUdNBCc/S6c1ZoRJpA==
X-Received: by 2002:a05:6512:4005:b0:592:f330:221 with SMTP id 2adb3069b0e04-59a17d18296mr7419824e87.6.1766744644182;
        Fri, 26 Dec 2025 02:24:04 -0800 (PST)
Received: from localhost.localdomain ([176.33.65.121])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a1862026bsm6472189e87.84.2025.12.26.02.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 02:24:03 -0800 (PST)
From: Alper Ak <alperyasinak1@gmail.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: Alper Ak <alperyasinak1@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Bryan Freed <bfreed@chromium.org>,
	Andi Shyti <andi.shyti@gmail.com>,
	Kent Yoder <key@linux.vnet.ibm.com>,
	Marcel Selhorst <tpmdd@selhorst.net>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: tpm_i2c_infineon: Fix locality leak on get_burstcount() failure
Date: Fri, 26 Dec 2025 13:23:38 +0300
Message-ID: <20251226102339.45054-1-alperyasinak1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_burstcount() can return -EBUSY on timeout. When this happens, the
function returns directly without releasing the locality that was
acquired at the beginning of tpm_tis_i2c_send().

Use goto out_err to ensure proper cleanup when get_burstcount() fails.

Fixes: aad628c1d91a ("char/tpm: Add new driver for Infineon I2C TIS TPM")
Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
---
 drivers/char/tpm/tpm_i2c_infineon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
index bdf1f329a679..8b7d32de0b2e 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -544,8 +544,10 @@ static int tpm_tis_i2c_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 		burstcnt = get_burstcount(chip);
 
 		/* burstcnt < 0 = TPM is busy */
-		if (burstcnt < 0)
-			return burstcnt;
+		if (burstcnt < 0) {
+			rc = burstcnt;
+			goto out_err;
+		}
 
 		if (burstcnt > (len - 1 - count))
 			burstcnt = len - 1 - count;
-- 
2.43.0


