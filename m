Return-Path: <linux-integrity+bounces-6257-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F8DABC99B
	for <lists+linux-integrity@lfdr.de>; Mon, 19 May 2025 23:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5C34A212F
	for <lists+linux-integrity@lfdr.de>; Mon, 19 May 2025 21:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C3E2356BF;
	Mon, 19 May 2025 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ER5/7zos"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFFD2356B8;
	Mon, 19 May 2025 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689774; cv=none; b=LRY0vfksul0nfNdCt6KB1AyWfLs0m2DZG+2TXxijWa8yeVJiIFQwWBUnN6Wy1iQbkZ0CRM7plbO2wFjPyOFvef9to/AGeOyq9aGILXKE8HoCbs6/pN/7C5WwLn343xLgPLJbSwCgvu0R1l9zLQiBIPecKwPqi+DsKBrwnXEbWXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689774; c=relaxed/simple;
	bh=MKcEzRp+6zB+UsCj6QXygYdiA9HahGYDQrKNZmw3d2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U7M0I26TffGjEWqPlUghVYrLuCpBTKi4lkbV3BNucz+gpjiH8/2FXYDM2s2atiYWZNorMR7VosRH3818LRkDE8WLzG6UivGu0OmLWUxv8rEz+mAkWVoBDJxZwitN5aHK4oMkNL5PLCMv45Ex7zhedZU/YCbldCx02nSty9ZS364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ER5/7zos; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F29C4CEED;
	Mon, 19 May 2025 21:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689773;
	bh=MKcEzRp+6zB+UsCj6QXygYdiA9HahGYDQrKNZmw3d2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ER5/7zosxdbj0HD3cYfv8J4zeV4NUYVjhw3Rh3d67LXKkZX9ZhzHbQ8EfdXDBqHd1
	 RbIqh9i5CneztzhVrIxyjl0tPWXV/S0z0NRUlZdneOeI83KnYEY88knpY+EVz2Vifs
	 CAyXO2grVixkOchIs80AUyQD/ypWx2AZ525h2eAwFV9QAXrOVqEJmqN7Nd8hOBeYFk
	 1HnrAlMQ6fHXaIKetMz1dU5aLmg1xMssVoukOe/mgKiMQuAZxdxsz9Ju2Hs4usgYqk
	 A6On3LnTEV3GtNHSvkU/+1f/a8g8nuQXH2hEx/dmJrofoUotRwvi0N3srTC81auPAV
	 JP7WngIUMIMvw==
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
Subject: [PATCH AUTOSEL 6.6 10/11] tpm: tis: Double the timeout B to 4s
Date: Mon, 19 May 2025 17:22:36 -0400
Message-Id: <20250519212237.1986368-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212237.1986368-1-sashal@kernel.org>
References: <20250519212237.1986368-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.91
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
index 369496a6aebf1..27e61ddfb6229 100644
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
index 5f4998626a988..bf8a4ec8a01c1 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -181,7 +181,7 @@ enum tpm2_const {
 
 enum tpm2_timeouts {
 	TPM2_TIMEOUT_A          =    750,
-	TPM2_TIMEOUT_B          =   2000,
+	TPM2_TIMEOUT_B          =   4000,
 	TPM2_TIMEOUT_C          =    200,
 	TPM2_TIMEOUT_D          =     30,
 	TPM2_DURATION_SHORT     =     20,
-- 
2.39.5


