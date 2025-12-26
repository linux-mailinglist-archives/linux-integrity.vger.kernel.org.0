Return-Path: <linux-integrity+bounces-8137-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25435CDEA79
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Dec 2025 12:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24868300727A
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Dec 2025 11:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CE9283121;
	Fri, 26 Dec 2025 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjDZaKc/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C920D1D86DC
	for <linux-integrity@vger.kernel.org>; Fri, 26 Dec 2025 11:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766748958; cv=none; b=R/z+MHBQK4UJL5AOSSvttA04OcvIafUFegkYPU1TNXbD/F7xT+/Cy40N0+pLCZ71nu0DPIg5A8PyUTxscU+BKTxDJkhlBfkw+x9bknof0tULRIv1qEin75VkSPzszJ78D99bgFFnke/6vO4LrU/+UGl/zQNRMUEQ/NmgpQpdrOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766748958; c=relaxed/simple;
	bh=h7Q8TIoHb2clEfMFWcY4ckjMLk9OcogwO7V1uIer53w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a+TxocWUaf8ih3FJygXnWMe468Egid1ljrH/1ZoO0B2SuVR+M3WBZXwYTsthE96cuR8mqZe43jmzSRFyMMFQTMi0mM3Dl1HVAqe1/FhApS2I9kJDKG1KoaJ2hNDU3V4NG3hPlFHMFbg47GyXfjXMu5PIWfbyNnMKnf85sq6QLRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjDZaKc/; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-594285c6509so7738808e87.0
        for <linux-integrity@vger.kernel.org>; Fri, 26 Dec 2025 03:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766748955; x=1767353755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vkLDWzVkVGEGy7oqy0wjarG1BP52vTs1apSPyNRbl6w=;
        b=EjDZaKc/5L1Jxpy9RaGYbXvdbYWD/uBH1UCmCXN2NnHo3O1acR0dczCNlCgObV1INI
         w72lNlm64/ezFkTgHdahts1aaoZzDLduRvEOIgZq8YVOBlzH82ahkMpQ3HFU2ar0irFA
         8l/CtyJ95kVno+eLpaCeFUxQAdKdd2YKiqlhJAXMY67Jkkm/LZt8e3DJq0MkTbnlBvLx
         kDwQIijlTJ4/R9Yt8fTI2vli57RXscKAskaaiLP845pgnyW3xCsoYyF+tQYw7tGv66Bu
         bTIm1dQsG6fJRblY624XuQrVG7IylnT5iaeT+Kd6exQoaz3p8H0Hq44M3proWsa4irI+
         95ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766748955; x=1767353755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkLDWzVkVGEGy7oqy0wjarG1BP52vTs1apSPyNRbl6w=;
        b=isdkt9aVNzjAz5hu+lNqSkaiREjWzBJLcMkrwv/GN0SBvCE4ZjmZx9GSMAlxDv+O0X
         5i2eKVcfzlMSO/k14862YY4nA/+7Q6iVsiIRoGIXUl/HfSK++0UfrCUIx8XKvvx42QSp
         xuFwahS9hwW1g6xC9M+WdY66231jx/rzu6ZorW6rK8bNCFAN8OKefVqm78l2SVR3x+I1
         0I9HWkONGPvu5LqQfJ6fP47yaYrq5mGSzjLppjkerpIGVrBShR6gJfUdj2NXOpTwZ/g8
         IHXhKvYI2Z85zDAsNoEdekuKDXdO9G7vf/jdsrPFUP+ABUjpC2UiEF8B0dlKXUDWppLn
         873g==
X-Forwarded-Encrypted: i=1; AJvYcCV+QpFMeRFOkcj+5vr86Fm8WK+iHT+6xS3KrqD4qCMJzq2VeY3j55Fz2IzuVAaiOhI5DJsSNJS0ekWahMA1Amw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyor7qbvXRdZmdCaLmIxdIHGkJ4QeL4bmh7fZGvrRWCQnTSOpQ
	xW2MsAEJAHNs7DteWro6wNJiQcwqoCy9JIpHeT0hNyyDICU/NY82+Tfv
X-Gm-Gg: AY/fxX7rb1mZq5LQEVDyk0wB/xZEdDUJZb0XF6vs4dt3AlwNxIBYfrloZkugl8qtKXw
	XjYqv7isLLe18NK+xVzTwbzZ697Bt8FIturJhP1m5aszUWoXpHBIjxaEvpP3ke6gGSS0FH5wjJT
	LdwedheuBFeZOlUZuplerdYpi73zSVvCirOSSrRkQORTpdOvNJiG7iObQ57JXDhNft6OfEtxSto
	X0c/mQcxI88kIX4V88j4YfBfPBH2KGUuIetP7+lvky3xAXl3NFnmf5UnjXVz4OjNrO6Qi9bZmBD
	um62MnRAOHKqzpC87orTEPd5oK5k9aXJUUjo5mwJQ6XTuiAvVl4ivjonSYvfCzflr/YAEVEXs5O
	c/ZYfzOXKO11I5AGAHziJVNHCbLSX2t67Lr/8org5XjUZZpBsDnlmF8+EnzqgiAt8uv2meUOX9C
	iUHIYT0vGw3caO2Pd2o0hW9n7AjX0=
X-Google-Smtp-Source: AGHT+IGV+ti61UNwfvokZHz4Yvl2VzkFLVddac+hzh5LaEa+pP2BzaGRv+B0OAsHXjyNg6Ji6cbFoA==
X-Received: by 2002:a05:6512:3088:b0:594:2e7b:6f9 with SMTP id 2adb3069b0e04-59a17d3df9dmr9147293e87.27.1766748954754;
        Fri, 26 Dec 2025 03:35:54 -0800 (PST)
Received: from localhost.localdomain ([176.33.65.121])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5ff5sm6526298e87.6.2025.12.26.03.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 03:35:54 -0800 (PST)
From: Alper Ak <alperyasinak1@gmail.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: Alper Ak <alperyasinak1@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Krishna Yarlagadda <kyarlagadda@nvidia.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: tpm_tis_spi: Initialize ret variable in tpm_tis_spi_transfer_half()
Date: Fri, 26 Dec 2025 14:35:04 +0300
Message-ID: <20251226113505.53740-1-alperyasinak1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When len is 0, the while loop in tpm_tis_spi_transfer_half() is never
entered and the function returns an uninitialized ret variable.

Initialize ret to 0 to correctly handle this case. This is consistent
with tpm_tis_spi_transfer_full(), which already initializes ret to 0
before the loop.

Fixes: a86a42ac2bd6 ("tpm_tis_spi: Add hardware wait polling")
Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
---
 drivers/char/tpm/tpm_tis_spi_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index 61b42c83ced8..1b6d79662ca1 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -85,7 +85,7 @@ static int tpm_tis_spi_transfer_half(struct tpm_tis_data *data,	u32 addr,
 	struct spi_transfer spi_xfer[3];
 	struct spi_message m;
 	u8 transfer_len;
-	int ret;
+	int ret = 0;
 
 	while (len) {
 		transfer_len = min_t(u16, len, MAX_SPI_FRAMESIZE);
-- 
2.43.0


