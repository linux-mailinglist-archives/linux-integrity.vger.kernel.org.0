Return-Path: <linux-integrity+bounces-5591-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB99A7AEE2
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 22:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C6D17B618
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 20:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4816227586;
	Thu,  3 Apr 2025 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRHDjayh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B58C226D1F;
	Thu,  3 Apr 2025 19:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707895; cv=none; b=nExjNDPdjwv7mD60NLGIgcw+Ow0txd3TpILtWXcSGurZbFr3kfAijXFld42TLR+bzipnd+9mv4lPHYKQT0BLWghFVriaM+WyFENkmX97CWtqz+UYxPyao7lFp23dp/A39JGZzGxDiKiSn6nj0AYIIyk1NUUYvhVTTaNbalEO4ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707895; c=relaxed/simple;
	bh=tyXlb/gCHl/HhkC71/I7Pcv2vUXDGnOl9QgbzLBqfP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MW3GGrG5l7N56hs7StTyJ1clM8jFg7wRi2UWTxJ7kBz58r+pi4zqksLsDyqwNZ3CMtqf5pfZrNioFyokJ9DfbLkl9qaUacdXOOgmQfdQSH+y8jPoxiU1uz6/aiHtDyPPJHq8yWVTtAAUpFmI0GYUYi+Hv10OMzr4M80h7srAGew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRHDjayh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3934FC4CEE8;
	Thu,  3 Apr 2025 19:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707894;
	bh=tyXlb/gCHl/HhkC71/I7Pcv2vUXDGnOl9QgbzLBqfP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRHDjayhD302C+hd2KADGN9SD+RRdK4w4kjwqVmEwsbJUlGeDVYUf9bGooJVbmKWo
	 RdjuLU2GG/FkWebkQzMcqGtCCLcsviGQ9+OBtQ5VxRuyVQW9R+91VbRzL5Lrmv/Q2n
	 QaaLYwG1FJvFomh8z3DVSHtqrN0RenWT77mgD5O6Q9/T9/zUeb3gScdDdhTIA+Vg9C
	 8shYbA2Y9yHY3E40hWLEfC636zqX4pIWGFiOBvdi6BpU8Cefh5AMZUD7QpDKCb/a35
	 THenCbptcxHYMcUeWXMEAKdB1q4EDspZsNPmyRLFhcXZGNJirs7xNJ6zLFm4luGLUV
	 lJaspAiZR4T1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonathan McDowell <noodles@meta.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	peterhuewe@gmx.de,
	linux-integrity@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 32/33] tpm, tpm_tis: Workaround failed command reception on Infineon devices
Date: Thu,  3 Apr 2025 15:16:55 -0400
Message-Id: <20250403191656.2680995-32-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191656.2680995-1-sashal@kernel.org>
References: <20250403191656.2680995-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Jonathan McDowell <noodles@meta.com>

[ Upstream commit de9e33df7762abbfc2a1568291f2c3a3154c6a9d ]

Some Infineon devices have a issue where the status register will get
stuck with a quick REQUEST_USE / COMMAND_READY sequence. This is not
simply a matter of requiring a longer timeout; the work around is to
retry the command submission. Add appropriate logic to do this in the
send path.

This is fixed in later firmware revisions, but those are not always
available, and cannot generally be easily updated from outside a
firmware environment.

Testing has been performed with a simple repeated loop of doing a
TPM2_CC_GET_CAPABILITY for TPM_CAP_PROP_MANUFACTURER using the Go code
at:

  https://the.earth.li/~noodles/tpm-stuff/timeout-reproducer-simple.go

It can take several hours to reproduce, and several million operations.

Signed-off-by: Jonathan McDowell <noodles@meta.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 17 ++++++++++++++---
 drivers/char/tpm/tpm_tis_core.h |  1 +
 include/linux/tpm.h             |  1 +
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index fdef214b9f6bf..4cc2ab2d16cc5 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -464,7 +464,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 
 		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
 					&priv->int_queue, false) < 0) {
-			rc = -ETIME;
+			if (test_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags))
+				rc = -EAGAIN;
+			else
+				rc = -ETIME;
 			goto out_err;
 		}
 		status = tpm_tis_status(chip);
@@ -481,7 +484,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 
 	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
 				&priv->int_queue, false) < 0) {
-		rc = -ETIME;
+		if (test_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags))
+			rc = -EAGAIN;
+		else
+			rc = -ETIME;
 		goto out_err;
 	}
 	status = tpm_tis_status(chip);
@@ -546,9 +552,11 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 		if (rc >= 0)
 			/* Data transfer done successfully */
 			break;
-		else if (rc != -EIO)
+		else if (rc != -EAGAIN && rc != -EIO)
 			/* Data transfer failed, not recoverable */
 			return rc;
+
+		usleep_range(priv->timeout_min, priv->timeout_max);
 	}
 
 	/* go and do it */
@@ -1144,6 +1152,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		priv->timeout_max = TIS_TIMEOUT_MAX_ATML;
 	}
 
+	if (priv->manufacturer_id == TPM_VID_IFX)
+		set_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags);
+
 	if (is_bsw()) {
 		priv->ilb_base_addr = ioremap(INTEL_LEGACY_BLK_BASE_ADDR,
 					ILB_REMAP_SIZE);
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 690ad8e9b7319..970d02c337c7f 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -89,6 +89,7 @@ enum tpm_tis_flags {
 	TPM_TIS_INVALID_STATUS		= 1,
 	TPM_TIS_DEFAULT_CANCELLATION	= 2,
 	TPM_TIS_IRQ_TESTED		= 3,
+	TPM_TIS_STATUS_VALID_RETRY	= 4,
 };
 
 struct tpm_tis_data {
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 20a40ade80308..6c3125300c009 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -335,6 +335,7 @@ enum tpm2_cc_attrs {
 #define TPM_VID_WINBOND  0x1050
 #define TPM_VID_STM      0x104A
 #define TPM_VID_ATML     0x1114
+#define TPM_VID_IFX      0x15D1
 
 enum tpm_chip_flags {
 	TPM_CHIP_FLAG_BOOTSTRAPPED		= BIT(0),
-- 
2.39.5


