Return-Path: <linux-integrity+bounces-7365-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A0CBB8B7F
	for <lists+linux-integrity@lfdr.de>; Sat, 04 Oct 2025 11:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A1604E1477
	for <lists+linux-integrity@lfdr.de>; Sat,  4 Oct 2025 09:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A45288D6;
	Sat,  4 Oct 2025 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="TG4IBoSc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944471BC5C
	for <linux-integrity@vger.kernel.org>; Sat,  4 Oct 2025 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759568662; cv=none; b=JBo4dh/LyHj8RJq1Qq98kdW+hXnsyzZ2XQqUWumGXcX7sa17q6LPwJ/B+S659AZmitGF0/3cJOb68G/ebDztOFBLtlQExMwcYmN0tt67lpxqHbDPELkQX2qUeMcQoyPLFjGfIW6R31DTPsygKmHwPTmukNO6nQTo8yK+PtBy5BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759568662; c=relaxed/simple;
	bh=JUYFV/YPR3WrOHsq9M1VxyXMt3tnzJiffNEySy2Kvpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YChG8vg4d8LWa1Z1wwTvdZVViyJAVUO/aTPqwMduIF06dNoRTPL6ZbTrX1w9xM5DSoFPoDOc5dw6dxSfQZVvg6kxazkIFh1ZgUtvTH0r+vjOqSx7v6sIrXMaE5HUjkJVGDA/njbvn3XC8wpLgZLBOqFCI/EnimC3JkqCJZiWoQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=TG4IBoSc; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id CC5D1240101
	for <linux-integrity@vger.kernel.org>; Sat,  4 Oct 2025 11:04:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1759568657; bh=JWVwdt67/VtIvFKQXq3esRk8HgOyYMQli13m3MQ1k2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=TG4IBoScPLkI2pE6RP/ERU6J67561ar0RS8kL3SOenYFIVOqxJB3pcgf0OFSh1DHk
	 XG91ss2ta+c1ceCfaOTVjzjmcKA8/5aYu4PmuqUCCorNRU2QL86o48WpN+d7S42iPP
	 YbK78o1CUGcm68Xd/Yig12GnFVFJtmODBOOIlBipPxBQaS7kP2TnP/zQXo+DRHx1Gp
	 bClYSbV87G8FTWerTjR0eGYiCmV2YkNHcGqcqumGnJmx8/XHaRq7x2XWG2HSqz4a5o
	 zOfne2jU3Reh1+lUdvu3grhtu+QB8FM/aNhW53ErK8BozHF8PjEL34BPNzkqxKj9xD
	 KLXccWsKbQRXg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cf02n1GJ9z6tyW;
	Sat,  4 Oct 2025 11:04:17 +0200 (CEST)
From: Shahriyar Jalayeri <shahriyar@posteo.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: shahriyar@posteo.de,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: infineon: add bounds check in tpm_inf_recv
Date: Sat, 04 Oct 2025 09:04:17 +0000
Message-ID: <20251004090413.8885-1-shahriyar@posteo.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two buffer size validations to prevent buffer
overflows in tpm_inf_recv():

1. Validate that the provided buffer can hold at
   least the 4-byte header before attempting to
   read it.
2. Validate that the buffer is large enough to
   hold the data size reported by the TPM before
   reading the payload.

Without these checks, a malicious or malfunctioning
TPM could cause buffer overflows by reporting data
sizes larger than the provided buffer, leading to
memory corruption.

The error messages include both the expected and
actual buffer sizes to indicate that the operation
is aborted.

Signed-off-by: Shahriyar Jalayeri <shahriyar@posteo.de>
---
 drivers/char/tpm/tpm_infineon.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
index 7638b65b8..385bac46a 100644
--- a/drivers/char/tpm/tpm_infineon.c
+++ b/drivers/char/tpm/tpm_infineon.c
@@ -247,11 +247,20 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
 	int i;
 	int ret;
 	u32 size = 0;
+	u32 header_size = 4;
 	number_of_wtx = 0;
 
 recv_begin:
+	if (count < header_size) {
+		dev_err(&chip->dev,
+			"Buffer too small (count=%zd, header_size=%u), "
+			"operation aborted\n",
+			count, header_size);
+		return -EIO;
+	}
+
 	/* start receiving header */
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < header_size; i++) {
 		ret = wait(chip, STAT_RDA);
 		if (ret)
 			return -EIO;
@@ -268,6 +277,14 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
 		/* size of the data received */
 		size = ((buf[2] << 8) | buf[3]);
 
+		if (size > count) {
+			dev_err(&chip->dev,
+				"Buffer too small for incoming data "
+				"(count=%zd, size=%u), operation aborted\n",
+				count, size);
+			return -EIO;
+		}
+
 		for (i = 0; i < size; i++) {
 			wait(chip, STAT_RDA);
 			buf[i] = tpm_data_in(RDFIFO);
-- 
2.43.0


