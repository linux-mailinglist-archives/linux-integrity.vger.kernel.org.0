Return-Path: <linux-integrity+bounces-7392-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4023CBC0D08
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Oct 2025 11:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E692F3AAAD7
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Oct 2025 09:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EC42D5C97;
	Tue,  7 Oct 2025 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="B7rpfU+S"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7447E2D46D0
	for <linux-integrity@vger.kernel.org>; Tue,  7 Oct 2025 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828071; cv=none; b=N4fg6zaxhrXiWW+kUql8PCu4PvuaBvf+EQjyzFSYviqGWW3YTsyKhQ4bpOLbdvjlnbQppVHy2HGl/amWZmL/PIKm6M9u3wtNhAqcNXofUCSehC/LERBtWHluB+X70UCzbN6r6dAyGngNj5mDZqtcba3FIM7eKPP13fbIgpfTVRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828071; c=relaxed/simple;
	bh=ZHX+FiPSiE2E1Wigo8Og8gIZxYADFUEaJAsKoo/q/SI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qseRFjhyxgoN1YvizAkbSgScIZP8VYPHv4T1G6cAzyag/qABFJugQfpHBDKa29EyZ68dGmo6LypALxxv21OaNPbqG8kRX3efXr/9lZcwTrCuWSZU++aNSmNvvGqsJPrgn1CfF7QKRQGXLy1LEZxi/52JaDzdthLg5KZU3JTkECA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=B7rpfU+S; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id CB95F240028
	for <linux-integrity@vger.kernel.org>; Tue,  7 Oct 2025 11:07:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1759828059; bh=tLnL2HT54F+560rMBs/uFtu/cmzwUuzUU1HYryiA84Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=B7rpfU+S1vA6PeSETcuv2uIUilWTOZ/lZbeTqhuM1rETJQQkeVJXfnVxVR7OV4uuw
	 1mQYvAB16+/9LuQj855Pt6JtVf44Eex15SsXAA4bO3lveoC6NMn+EbMi+a+EyfLZN3
	 q2T14HuesnyUEvl9xXcWH6+055SZmEwVF5qIjZMZhjVSrfklTvFB1Aw8h05I6eZnrq
	 uay72vhxGglmUCW5hsseURHTkNcAFUVNslFR/42lsNZI0vf/A/33MiKwkCJnpoUdWu
	 I74NMpCT/Q6ixmVhIlfdUJXmw/vrAitJQ0UfiOE3EA7at36eurV5yqbR4KaAJ3RN11
	 GEL7LU4GghiYg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cgqzG5MRZz9rxD;
	Tue,  7 Oct 2025 11:07:38 +0200 (CEST)
From: Shahriyar Jalayeri <shahriyar@posteo.de>
To: jarkko@kernel.org
Cc: shahriyar@posteo.de,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: infineon: add bounds check in tpm_inf_recv
Date: Tue, 07 Oct 2025 09:07:39 +0000
Message-ID: <20251007090736.17942-1-shahriyar@posteo.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two buffer size validations to prevent buffer overflows in
tpm_inf_recv():

1. Validate that the provided buffer can hold at least the 4-byte header
   before attempting to read it.
2. Validate that the buffer is large enough to hold the data size reported
   by the TPM before reading the payload.

Without these checks, a malicious or malfunctioning TPM could cause buffer
overflows by reporting data sizes larger than the provided buffer, leading
to memory corruption.

Fixes: ebb81fdb3dd0 ("[PATCH] tpm: Support for Infineon TPM")
Signed-off-by: Shahriyar Jalayeri <shahriyar@posteo.de>
---
 drivers/char/tpm/tpm_infineon.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
index 7638b65b8..8b90a8191 100644
--- a/drivers/char/tpm/tpm_infineon.c
+++ b/drivers/char/tpm/tpm_infineon.c
@@ -250,6 +250,11 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
 	number_of_wtx = 0;
 
 recv_begin:
+    /* expect at least 1-byte VL header, 1-byte ctrl-tag, 2-byte data size */
+	if (count < 4) {
+		return -EIO;
+	}
+
 	/* start receiving header */
 	for (i = 0; i < 4; i++) {
 		ret = wait(chip, STAT_RDA);
@@ -268,6 +273,10 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
 		/* size of the data received */
 		size = ((buf[2] << 8) | buf[3]);
 
+		if (size + 6 > count) {
+			return -EIO;
+		}
+
 		for (i = 0; i < size; i++) {
 			wait(chip, STAT_RDA);
 			buf[i] = tpm_data_in(RDFIFO);
-- 
2.43.0


