Return-Path: <linux-integrity+bounces-5447-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5567BA71B9E
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 17:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373471889D22
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2AA1F3FD7;
	Wed, 26 Mar 2025 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFTmpIbS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39611EB5DD;
	Wed, 26 Mar 2025 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743005933; cv=none; b=qojEN9YPxWqtzryw/i9KHmdJZHwXv03aIy666X3ZZe6RHbJLD7iYWjYrbAfCGSKx07B0Q+iTIrZJip1lGeafRzavXwz7BkRA7PDWr+6k7czKAcaHJqot4+baWJFmck76qHDp865VFDgO98Z73srQNk6Dg3gm/my9ohrHSXkx96Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743005933; c=relaxed/simple;
	bh=Z4mfmOoHDjZnf6VjFetSlpm7EqU2U/ycpOa/pXxe3As=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AScncm2LssmMJdn91Uo7bUOcJRGXPJelygVPluMTeSocpfo80f72h/SecAaNb1OzZ4MLk3Hx+K1BKR8TXSrwgPMH9srnGalfTG3fcPqJc8Bkbts/LnbGcLe1PC+kizm6OtbW2RQe/RG51EnSjxoupEqt0f+ZLcaGBW5SPgJlRUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFTmpIbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89A4C4CEE2;
	Wed, 26 Mar 2025 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743005933;
	bh=Z4mfmOoHDjZnf6VjFetSlpm7EqU2U/ycpOa/pXxe3As=;
	h=From:To:Cc:Subject:Date:From;
	b=IFTmpIbSr02+z+3hzqVTVDVY47MUu+MuOh7sDPYKYTz9W4Zd/sQYszYl0O9V5NxkX
	 ro8eQdeLPbf81UJ3rEAvCcKETeaMaTqNFybysQaLVDVYznROqZeReYdk/zIVHvahJq
	 9ub88mDc/Pt283gQ59XiLm+C9NSbnzXBRqfXfGd0t7ndfTI+mubG4wdWd4PQ22mWzW
	 dsUOJb01Ceo80+PjgjrRba4l13mM8/hI54RB52yN+lJJ4vjihzew2lQ4C8wnS4gjPu
	 +LJwqrfHSl17NMWgSVk0Cc9LPF7bZyeEoR3qEwkiK4C4I3PtZGepUm6BlN0gr2FO8O
	 +gaWp82UNZkIQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Sumit Garg <sumit.garg@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: Make chip->{status,cancel,req_canceled} opt
Date: Wed, 26 Mar 2025 18:18:38 +0200
Message-Id: <20250326161838.123606-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

tpm_ftpm_tee does not require chip->status, chip->cancel and
chip->req_canceled. Make them optional.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
 drivers/char/tpm/tpm-interface.c | 31 ++++++++++++++++++++++++++++---
 drivers/char/tpm/tpm_ftpm_tee.c  | 20 --------------------
 2 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index f62f7871edbd..10ba47a882d8 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -58,6 +58,30 @@ unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
 
+static void tpm_chip_cancel(struct tpm_chip *chip)
+{
+	if (!chip->ops->cancel)
+		return;
+
+	chip->ops->cancel(chip);
+}
+
+static u8 tpm_chip_status(struct tpm_chip *chip)
+{
+	if (!chip->ops->status)
+		return 0;
+
+	return chip->ops->status(chip);
+}
+
+static bool tpm_chip_req_canceled(struct tpm_chip *chip, u8 status)
+{
+	if (!chip->ops->req_canceled)
+		return false;
+
+	return chip->ops->req_canceled(chip, status);
+}
+
 static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 {
 	struct tpm_header *header = buf;
@@ -65,6 +89,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 	ssize_t len = 0;
 	u32 count, ordinal;
 	unsigned long stop;
+	u8 status;
 
 	if (bufsiz < TPM_HEADER_SIZE)
 		return -EINVAL;
@@ -104,12 +129,12 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 
 	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
 	do {
-		u8 status = chip->ops->status(chip);
+		status = tpm_chip_status(chip);
 		if ((status & chip->ops->req_complete_mask) ==
 		    chip->ops->req_complete_val)
 			goto out_recv;
 
-		if (chip->ops->req_canceled(chip, status)) {
+		if (tpm_chip_req_canceled(chip, status)) {
 			dev_err(&chip->dev, "Operation Canceled\n");
 			return -ECANCELED;
 		}
@@ -118,7 +143,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 		rmb();
 	} while (time_before(jiffies, stop));
 
-	chip->ops->cancel(chip);
+	tpm_chip_cancel(chip);
 	dev_err(&chip->dev, "Operation Timed out\n");
 	return -ETIME;
 
diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 8d9209dfc384..53ba28ccd5d3 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -164,30 +164,10 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	return 0;
 }
 
-static void ftpm_tee_tpm_op_cancel(struct tpm_chip *chip)
-{
-	/* not supported */
-}
-
-static u8 ftpm_tee_tpm_op_status(struct tpm_chip *chip)
-{
-	return 0;
-}
-
-static bool ftpm_tee_tpm_req_canceled(struct tpm_chip *chip, u8 status)
-{
-	return false;
-}
-
 static const struct tpm_class_ops ftpm_tee_tpm_ops = {
 	.flags = TPM_OPS_AUTO_STARTUP,
 	.recv = ftpm_tee_tpm_op_recv,
 	.send = ftpm_tee_tpm_op_send,
-	.cancel = ftpm_tee_tpm_op_cancel,
-	.status = ftpm_tee_tpm_op_status,
-	.req_complete_mask = 0,
-	.req_complete_val = 0,
-	.req_canceled = ftpm_tee_tpm_req_canceled,
 };
 
 /*
-- 
2.39.5


