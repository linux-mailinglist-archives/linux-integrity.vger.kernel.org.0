Return-Path: <linux-integrity+bounces-6254-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7ACABC94D
	for <lists+linux-integrity@lfdr.de>; Mon, 19 May 2025 23:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5543BC637
	for <lists+linux-integrity@lfdr.de>; Mon, 19 May 2025 21:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1E2224254;
	Mon, 19 May 2025 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cekGv1E2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D98224243;
	Mon, 19 May 2025 21:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689727; cv=none; b=q2QLvHj+msowYP3k0uEB1baFcdLFeRbvRb2uwfEGAX8YvUl/5EnpGOVLKoV4tQ/4nLza4SNDS07B1WyHUNLZmAUUMCZ1BI0l2hElM/meSefS4qP/CBDvMpyuYEf9uS0coQmr99HyfrsOUkDXa4/TCrGynxiv0MeTOGejS7VVFUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689727; c=relaxed/simple;
	bh=EQ3IzvGXf0ucRDNdpCAmCBBVswJOtl92Ip02snCfp7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RpDeaQebIbk2d4UO9L+ooaXRrFsAnLuOODXFCg80aYXzjkfmEWvIxj7a0zAvR+t6sZCzEP1MX4vZTagcHbyD2OhCFzj2SID4ah7vKU2S1j3mH4P5/WU1MiBwuT812Fuob3exDDtKDI4oQmJO3NlEH202stx8AkgDWX5vKNyka/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cekGv1E2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18FFC4CEEB;
	Mon, 19 May 2025 21:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689726;
	bh=EQ3IzvGXf0ucRDNdpCAmCBBVswJOtl92Ip02snCfp7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cekGv1E2rUk9hFOeoy+9SBWJGbhmaRPmpZG+FoRZO3wSFpuylBKWD1tQVDIRw6a8Q
	 WIDWNCSPnTkow+3aP/26jgc6Ir9XZGFc28U3+OCT3sDsYq5B+iaxgxY1+vaPOR7kpe
	 jy67tcIrNGo54vB0E/TxnguRrATH+jBdGF3gWmWzuRtRjhC7z5rYKDpQi1Xc8riWje
	 ZCyTk6ZAXNORRIcU/zBcXrP1bz5E58zRF3B4mLtjXeFZIIkG2tu57inCGm3bxuvitz
	 9IS42X/gaD4JFiicMwpPMxWHH140AGCPqWkNq35a6rvrjpR1uzkLtZevo0ClBJq5/a
	 u7/AYFCTMJ03g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Michal Suchanek <msuchanek@suse.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	peterhuewe@gmx.de,
	jarkko.sakkinen@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 22/23] tpm: tis: Double the timeout B to 4s
Date: Mon, 19 May 2025 17:21:29 -0400
Message-Id: <20250519212131.1985647-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212131.1985647-1-sashal@kernel.org>
References: <20250519212131.1985647-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.7
Content-Transfer-Encoding: 8bit

From: Michal Suchanek <msuchanek@suse.de>

[ Upstream commit 2f661f71fda1fc0c42b7746ca5b7da529eb6b5be ]

With some Infineon chips the timeouts in tpm_tis_send_data (both B and
C) can reach up to about 2250 ms.

Timeout C is retried since
commit de9e33df7762 ("tpm, tpm_tis: Workaround failed command reception on Infineon devices")

Timeout B still needs to be extended.

The problem is most commonly encountered with context related operation
such as load context/save context. These are issued directly by the
kernel, and there is no retry logic for them.

When a filesystem is set up to use the TPM for unlocking the boot fails,
and restarting the userspace service is ineffective. This is likely
because ignoring a load context/save context result puts the real TPM
state and the TPM state expected by the kernel out of sync.

Chips known to be affected:
tpm_tis IFX1522:00: 2.0 TPM (device-id 0x1D, rev-id 54)
Description: SLB9672
Firmware Revision: 15.22

tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id 22)
Firmware Revision: 7.83

tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1A, rev-id 16)
Firmware Revision: 5.63

Link: https://lore.kernel.org/linux-integrity/Z5pI07m0Muapyu9w@kitsune.suse.cz/
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.h | 2 +-
 include/linux/tpm.h             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 970d02c337c7f..6c3aa480396b6 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -54,7 +54,7 @@ enum tis_int_flags {
 enum tis_defaults {
 	TIS_MEM_LEN = 0x5000,
 	TIS_SHORT_TIMEOUT = 750,	/* ms */
-	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
+	TIS_LONG_TIMEOUT = 4000,	/* 4 secs */
 	TIS_TIMEOUT_MIN_ATML = 14700,	/* usecs */
 	TIS_TIMEOUT_MAX_ATML = 15000,	/* usecs */
 };
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 6c3125300c009..3db0b6a87d454 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -224,7 +224,7 @@ enum tpm2_const {
 
 enum tpm2_timeouts {
 	TPM2_TIMEOUT_A          =    750,
-	TPM2_TIMEOUT_B          =   2000,
+	TPM2_TIMEOUT_B          =   4000,
 	TPM2_TIMEOUT_C          =    200,
 	TPM2_TIMEOUT_D          =     30,
 	TPM2_DURATION_SHORT     =     20,
-- 
2.39.5


