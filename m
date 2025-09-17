Return-Path: <linux-integrity+bounces-7143-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2AAB80944
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 17:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4A61C26E2D
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AD533AE87;
	Wed, 17 Sep 2025 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Xu0AM5za"
X-Original-To: linux-integrity@vger.kernel.org
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0851333AEA5;
	Wed, 17 Sep 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123031; cv=none; b=laV2ffXOercer9WXSXr3DOew3zlEZSArDetQTbsSxgigOd9NxkM/mWoC9TE631YsW9y2G6L6Plp3dC8IceY6R8kaywSiPGtVeIir+0CUjOf0mhe/VJZy7X0TBuhoUBQH+eXjseYhhBm5CoWQJJ7/9b7yWtZ4PLrgJO+kkvb6MDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123031; c=relaxed/simple;
	bh=03m738mYZFGw7DqF+3/ej17Bgl12Et2apkKBZIqxzEo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rnYG3Oi5BM/8JFQphTZfDtaR6nchR4OL50yfeOEt3LU1rZXnPvBIMuR+CC+ABCrHg+/vnOXP002ZJ3ZOJBz6mCFxa/dzV5HRIwYoMsIgPw7Rl6qcbJdk/uoy499+ebrKGtuVqglIcj2niSg1yreSp3pQ4faG3f31PX6vRGP0O0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Xu0AM5za; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758123030; x=1789659030;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wdPvPCz9v4Nnl8hinv8Kyz8XT77i6h9HCms1Dt17du0=;
  b=Xu0AM5zaAXj4a6f8YPc4j5iYvK7Yx8zXYt9V0VbwgVsNqGxY9ptxi5hi
   uztBhkHrFNkXdAfXdKb3D6jivDH69koGU53zhX+0UF+W3YpYs+Yl6TWIY
   bFB6lZiPFksoaoJ3Z/PVcHyiS70m7xEJfawitG9zHfAAdH/JZ1rhMZz05
   +pOKJ7tPCxRF5pEC4OBtt8RqcN7JO1tPlvtlWvdQzLp5lEgNOIO6k4K9D
   TcAw1iYr/ukOfawpCu+8cUx+iE0VWOTk1f/HOKolYNKFEdc9luuxSD491
   MGUAyDqCHCnPdgcF0qEyVaI2rLpTE3W/hnKGSRkNgZgAjYyyyibQDIIpG
   w==;
X-CSE-ConnectionGUID: XcWyxDHAT8Szr1bu4+2w9g==
X-CSE-MsgGUID: L83l5pOMShCZvzwEPLMpYA==
X-IronPort-AV: E=Sophos;i="6.18,272,1751241600"; 
   d="scan'208";a="3158007"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 15:30:29 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:5191]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.187:2525] with esmtp (Farcaster)
 id 048daeed-ba17-4417-8e0e-fc381c21ae8e; Wed, 17 Sep 2025 15:30:29 +0000 (UTC)
X-Farcaster-Flow-ID: 048daeed-ba17-4417-8e0e-fc381c21ae8e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 17 Sep 2025 15:30:29 +0000
Received: from dev-dsk-gunnarku-2c-36117f29.us-west-2.amazon.com
 (172.23.139.22) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Wed, 17 Sep 2025
 15:30:28 +0000
From: Gunnar Kudrjavets <gunnarku@amazon.com>
To: <peterhuewe@gmx.de>, <jarkko@kernel.org>
CC: <jgg@ziepe.ca>, <kyarlagadda@nvidia.com>,
	<linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Justinien
 Bouron" <jbouron@amazon.com>
Subject: [PATCH] tpm_tis: Fix undefined behavior in tpm_tis_spi_transfer_half()
Date: Wed, 17 Sep 2025 15:29:56 +0000
Message-ID: <20250917153022.18567-1-gunnarku@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

When len is 0, the while loop in tpm_tis_spi_transfer_half() never
executes, leaving ret uninitialized. This will lead to undefined
behavior when the function returns.

The issue was introduced when tpm_tis_spi_transfer() was refactored
to call tpm_tis_spi_transfer_half() or tpm_tis_spi_transfer_full().
While ret is properly initialized in tpm_tis_spi_transfer_full(), it
was missed in tpm_tis_spi_transfer_half().

Initialize ret to 0 at the beginning of the function to ensure
defined behavior in all code paths.

Found by GCC 14.2.0 static analyzer with -fanalyzer.

Fixes: a86a42ac2bd6 ("tpm_tis_spi: Add hardware wait polling")
Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
Reviewed-by: Justinien Bouron <jbouron@amazon.com>
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

base-commit: 5aca7966d2a7255ba92fd5e63268dd767b223aa5
--
2.47.3


