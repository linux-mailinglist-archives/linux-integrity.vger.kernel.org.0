Return-Path: <linux-integrity+bounces-6260-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC90ABC9F8
	for <lists+linux-integrity@lfdr.de>; Mon, 19 May 2025 23:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881173ABAD9
	for <lists+linux-integrity@lfdr.de>; Mon, 19 May 2025 21:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71953244691;
	Mon, 19 May 2025 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnNCHM3O"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A35244689;
	Mon, 19 May 2025 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689811; cv=none; b=AnbpIdkh9ArW25jrtga13cs31uIIWVNrCC+zFfjKOY2T0Jyhp1s3/bz+AGqpzW0WSqgt5fAaKs/LFQ4PUVm3n0Z249XP5jCLKU2Hwl8SXiAsFfSlLwkAt2K2yqas2cptOdUZI7pcAelo6R2GwGBSGvXbzoaCIDZhlRTTBwkGx8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689811; c=relaxed/simple;
	bh=O33U2Imm5ypbs0NToGKPRgFoOC4/c8VH64LahKk3eME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pVJkHVMSTWN6/1RF/lMdJE02bGfPIXcOvdM7eXqKKVLGIB/a12ERHFWlwwI8gpdCfoncH7NVsw+MSVAbtEvTWh0uaWbuG86c/n0nLahEKTk+v2F7RDTp6Lk7uDvBrCQCdC2w4MbRT34h6xmRwmNBNQ07JF2YCFCOGpwFvKWOzcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnNCHM3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C39C4CEEB;
	Mon, 19 May 2025 21:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689810;
	bh=O33U2Imm5ypbs0NToGKPRgFoOC4/c8VH64LahKk3eME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lnNCHM3O8IiaHlYWmJAEUrjtWotXwX9naW/eDUZOXv0fs+rSzi8W8viwqbomuFPO0
	 LkIlIDJO7wnIVdnXkJ3Kil/d+l/My17pMmkJHS+3NnT3fOIwK2fUAZ56BqK4/Yhqxy
	 ijhvuHMxpxqQQcN1OQzylRRxXtaT24xDD8GDw9iUIRIEcTItuQ2bVSxu3+Ci5j6iNZ
	 1U5XEgk2CPt1Jq8p4zqlAbS8DXstEhxRhddMtEm1DrGJ216Rd1yEB36Qfbp50TzQIx
	 dK/LPC++lh4lv57U/MHrxrLwJDqhh0OVh+ouzySc87CtqqtzvusP7aRX3zq2or9H/k
	 U/+L+NYxlMdPA==
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
Subject: [PATCH AUTOSEL 5.10 6/6] tpm: tis: Double the timeout B to 4s
Date: Mon, 19 May 2025 17:23:20 -0400
Message-Id: <20250519212320.1986749-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212320.1986749-1-sashal@kernel.org>
References: <20250519212320.1986749-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 464ed352ab2e8..ed7b2caa9ebbd 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -53,7 +53,7 @@ enum tis_int_flags {
 enum tis_defaults {
 	TIS_MEM_LEN = 0x5000,
 	TIS_SHORT_TIMEOUT = 750,	/* ms */
-	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
+	TIS_LONG_TIMEOUT = 4000,	/* 4 secs */
 	TIS_TIMEOUT_MIN_ATML = 14700,	/* usecs */
 	TIS_TIMEOUT_MAX_ATML = 15000,	/* usecs */
 };
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 95c3069823f9b..7868e847eee0e 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -174,7 +174,7 @@ enum tpm2_const {
 
 enum tpm2_timeouts {
 	TPM2_TIMEOUT_A          =    750,
-	TPM2_TIMEOUT_B          =   2000,
+	TPM2_TIMEOUT_B          =   4000,
 	TPM2_TIMEOUT_C          =    200,
 	TPM2_TIMEOUT_D          =     30,
 	TPM2_DURATION_SHORT     =     20,
-- 
2.39.5


