Return-Path: <linux-integrity+bounces-7643-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F92C7153A
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 23:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 524494E4007
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 22:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACA632D0DE;
	Wed, 19 Nov 2025 22:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="29pbxlf6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151AD31AF37;
	Wed, 19 Nov 2025 22:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592164; cv=none; b=rc2g78CeY4xSvkv1EHUS+B50sLEQnj1Kw1iohF+hxc7LmIFF9prijZegpf9UHtNdKvoAsaHnsoYa4HTp+nzXBTb1HzMwgFebUx5sXy+kFRaMsvqwiuF9JfUWOmPRa+GNigElObzjlX8UJXYNnr92V5Q9n/YurIBXdSEdPMzqXPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592164; c=relaxed/simple;
	bh=8DFbDceo+hae0z8sHjqS3FDVV/8W5WkMGiMPkPluteU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GLAX9Eg9V+q+ewowGGoh1IWfAcN+Ng1MdXIz2Mgyv4b5yPJhjhwIoLHuhEseDN5bWdJ+eejJzB7QaESsB9uq+3sSR1Fb7bjrB137zeFAEocPzQwa3Eb0UudJRllu3a47WUGq1eBJx/8w6vkNs5kpqrBbDzU4INwB7w75I584JPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=29pbxlf6; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsq-006ktR-4E; Wed, 19 Nov 2025 23:42:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=6F7mH0wT5IZgQzK9d7ZZZ1QEVyvkSX2hmC/0mA0wSgA=; b=29pbxlf6zrfeXIK4c9MzK3fd2x
	O4WxZid2rR43NhzlyZroOSBvNb+kJThZixKb4cqfkiqXAR20/r6B44lXzFvveuGjecyf9NGLkx/5Z
	zNFA6dpVojFF9bUY/S2yA8BRs9tXGVgInOs96RrOjqwA1wZp37gjbtzWE9STqbGUgFwYUI8hNyBwE
	YBvD+JzcLCh1lDY6WCUCr3qHWi/jTy7T1tRTJkk6GbbrluAMoB/TVYLHjpqzKOCKSZpLd5aD6y5nH
	nbbVtonZW0MtA03f56mglgnfjYpPzjxSPHNIpeKGsgDWA2s+KlU0Qkoe3VUjGH7JlJeDR/Lem1N1R
	nE7tTZOg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsp-00085G-Qv; Wed, 19 Nov 2025 23:42:39 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsb-00Fos6-GP; Wed, 19 Nov 2025 23:42:25 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 15/44] drivers/char/tpm: use min() instead of min_t()
Date: Wed, 19 Nov 2025 22:41:11 +0000
Message-Id: <20251119224140.8616-16-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

min_t(int, a, b) casts an 'long' to 'int'.
Use min(a, b) instead as it promotes any 'int' to 'long'
and so cannot discard significant bits.

In this case the 'long' value is small enough that the result is ok.

Detected by an extra check added to min_t().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 drivers/char/tpm/tpm1-cmd.c     | 2 +-
 drivers/char/tpm/tpm_tis_core.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index cf64c7385105..11088bda4e68 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -530,7 +530,7 @@ struct tpm1_get_random_out {
 int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 {
 	struct tpm1_get_random_out *out;
-	u32 num_bytes =  min_t(u32, max, TPM_MAX_RNG_DATA);
+	u32 num_bytes =  min(max, TPM_MAX_RNG_DATA);
 	struct tpm_buf buf;
 	u32 total = 0;
 	int retries = 5;
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 8954a8660ffc..2676e3a241b5 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -310,7 +310,7 @@ static int get_burstcount(struct tpm_chip *chip)
 	return -EBUSY;
 }
 
-static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
+static int recv_data(struct tpm_chip *chip, u8 *buf, u32 count)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int size = 0, burstcnt, rc;
@@ -453,7 +453,7 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 			rc = burstcnt;
 			goto out_err;
 		}
-		burstcnt = min_t(int, burstcnt, len - count - 1);
+		burstcnt = min(burstcnt, len - count - 1);
 		rc = tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv->locality),
 					 burstcnt, buf + count);
 		if (rc < 0)
-- 
2.39.5


