Return-Path: <linux-integrity+bounces-2902-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64CF912137
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 11:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12FF01C21791
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 09:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EE416F82F;
	Fri, 21 Jun 2024 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7Z9Rklj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64F516E86B;
	Fri, 21 Jun 2024 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963461; cv=none; b=l5npDHliebmqw0gBoE7dEbnW+gcwXLgc4IP/QYVoajMqCTD08Rerf+qKRuXLDpywcUcHx/Lx8Ebb7scqi40s7Xuexd1EugaIxKB4LStXsup3rP47LeXQvfFeFiiF1RwZ7ck0Z61J5SnqK9SGH4Q/cjTMhEOckVyE0Wb6/YFw6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963461; c=relaxed/simple;
	bh=cvYHNa+hIJJ+RNHkoXRTd4NRdSnicliKkicnX+9ow0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pTkS14PcmXAKj+AyzgKgHxHf0EtkJR3upIMHL7IkCvxT9W1eln0m3he1jp3M5x6T59foiMOS5kgB+aG4W8M8jBp2/QfVFL8gMKpwNuKO0LiDqCxjkmp22UgCBv2OaglO5M7nJCzh3qDlad+Kz5f9PrX3aRHW0z4dhK3E2+qu7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7Z9Rklj; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-354b722fe81so1275914f8f.3;
        Fri, 21 Jun 2024 02:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718963458; x=1719568258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qMVxhUU5XY6Kva5wDPcO6sBUJYNFOfP/teCdrUpvYVo=;
        b=X7Z9RkljTy5myI0DGsWtMv0qbv6ksWx3Q9/+UkTZWsAGuAgQ9yM5qAZxqzD31/doPv
         WduwADlKqE5QhfOYk9p638G4KC2TUIGI9xaxfbrVRw+PgAR9DY75zxBMd44W87T6aIJh
         wcvvRKh7XlLPz1u/7f/hR21DHa6zkVCQ5kt+VYlaqtGcjlALcxirDGQOABATSilOVLCq
         4MZhnYmaValj02+byelFxSskvVSynm1PSYlxOsUcA/YI+MJicENJnj8fBXw8N2/dnhMg
         IbWW8vXP+vhxC3nHCt6ASZyvxAoc+zriGd+AgeS58JEIcq4eOaX2fHeLWGL5ZE2BzCWv
         Higw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718963458; x=1719568258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMVxhUU5XY6Kva5wDPcO6sBUJYNFOfP/teCdrUpvYVo=;
        b=YBJYAsheIqo6HCshHLMOnK3fwouH4e2gpQXwK2c8PbJgvwa6NA7yxQzwC5Kbls6gCU
         7x1J7NcxwK/AJ+WyDKz1TDQyLffuhU5keGEHqHAVAW/uzr4PlUZe+e1EdBkM76ZKw8t0
         K5ZpV2HtZglBn80KaeYUU6s/qPUR9jzUit4T4kb5cicxBe2kFWqym1VlpXicGIPSyp1/
         CEd7ycr40rcudphs7BCky50MssgUVsTlxPspDy/dAEq+j37cdWwGZorDAXGlMhOOujM6
         CXLhaU3zqRm95uiOSKQZTOzX+BD6yPbNpMM6B+UIWFEm+nrxWj3uJAJWkWlmJfj4SSMx
         5P1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVy2R/H7d6ti7kvyl1G2iNmqa0PAJxAqqSu8smCe/fNlT7ZVydYvw0yGT+KIEpznFY5cYRof+Ch4Yxc+rQ4udocdOxIfzHV4q8v7eoK3cMfuwYN5E6H1VnUZYUico6BZHR6Q4oJ+hmBY1aUCTSSm3Kl4j9AWJ2wXWERzU98VT4GDN383WR
X-Gm-Message-State: AOJu0YxCXf9KVUJYQsMBk+81qX0hbqGYdrtx20bYUby4IzClQwwlmi7T
	iGRSUlYYetpVQJlXA53mARKQBe/1JFU4u9XJ3ePwpNA2cPRsc89h
X-Google-Smtp-Source: AGHT+IFrweBZm7r27ycSwyudMYCNoQgDJxfiX4045xUVNtMnwDt4rTTu0oWIZNtGc5VvXAxtcet+Nw==
X-Received: by 2002:a5d:4a87:0:b0:360:88a3:e56f with SMTP id ffacd0b85a97d-36319a85e76mr5656363f8f.67.1718963457791;
        Fri, 21 Jun 2024 02:50:57 -0700 (PDT)
Received: from vitor-nb.. ([2001:8a0:e622:f700:9e85:710d:d269:42ed])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638f85916sm1234604f8f.61.2024.06.21.02.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 02:50:57 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Lukas Wunner <lukas@wunner.de>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ivitro@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v1] tpm_tis_spi: add missing attpm20p SPI device ID entry
Date: Fri, 21 Jun 2024 10:50:45 +0100
Message-Id: <20240621095045.1536920-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitor Soares <vitor.soares@toradex.com>

"atmel,attpm20p" DT compatible is missing its SPI device ID entry, not
allowing module autoloading and leading to the following message:

  "SPI driver tpm_tis_spi has no spi_device_id for atmel,attpm20p"

Based on:
  commit 7eba41fe8c7b ("tpm_tis_spi: Add missing SPI ID")

Fix this by adding the corresponding "attpm20p" spi_device_id entry.

Fixes: 3c45308c44ed ("tpm_tis_spi: Add compatible string atmel,attpm20p")
Cc: stable@vger.kernel.org
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 drivers/char/tpm/tpm_tis_spi_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index c9eca24bbad4..61b42c83ced8 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -318,6 +318,7 @@ static void tpm_tis_spi_remove(struct spi_device *dev)
 }
 
 static const struct spi_device_id tpm_tis_spi_id[] = {
+	{ "attpm20p", (unsigned long)tpm_tis_spi_probe },
 	{ "st33htpm-spi", (unsigned long)tpm_tis_spi_probe },
 	{ "slb9670", (unsigned long)tpm_tis_spi_probe },
 	{ "tpm_tis_spi", (unsigned long)tpm_tis_spi_probe },
-- 
2.34.1


