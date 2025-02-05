Return-Path: <linux-integrity+bounces-4727-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F45BA28A6E
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 13:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13C3167915
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 12:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92EF2288ED;
	Wed,  5 Feb 2025 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="r9V09cHh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE8F1EA91;
	Wed,  5 Feb 2025 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759218; cv=none; b=qm5+RQbyP2WRMFmfY31zJijaVHb4tHdXFGHAmHJD9qKCzkWpjzKqOwO08fcp6ySUcp5pry0agCntrM6tY4jvq8nOj+rcE0/z4d8X9PNHPvS5NwttXsHx9fUoiTcbAJwGrtDCbWLZqK5+FE+ao8HolFHQmgsF3s1eeH6sDrkVKKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759218; c=relaxed/simple;
	bh=PPCkRW2lTJ5FItdZqHLTR+/qRX1KJ5PMMfD/itYTbco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JWVq6+D6sVXlwBxdvkgKgjvM/kCC+MSQq1A7cWOxTDC6KskKqQM9ipRlxGxHL/wE1aQDA+zPe1Tvry3/gcvjOxpcdF3HcGuD3fdfH/EGvivPfppXP0h3nf4TQpcAvkTCGNY2Rsolz0LAbfW9pwlhuGD/cCRCL9nGuTw3K49m3NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=r9V09cHh; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Q+eHgl0RhcvCdFSHAR9cwfJIlu8RZ15O7xlRKsRH1SA=; b=r9V09cHhPjn7mJG9F+DA7CFL+5
	vuPuu3l9NqKzCV1Dq6fKoWiiSzgAPTvNtjImlTFz0r+JBYVCg7C8ZIbmundzIDMSIqS5Gcqo+M8Gx
	YAhniNvPNQQv+s9zjA0h5zSuAmMN7bOPlp7u5oM+mrLqkmlht0/cZjt662jvu4x1T2kOtVsJ6jTKW
	AhH/RdjgjzZWZOGTmytNfXVRzD/Z4s+3blP08SQI4Okfi3FsIz2WjOP1UNgMPYxNGBOilCJ6YnHr7
	q5RSceGvDRIo9+mjYQVBg4v6B6Of1R5iFZIqX3eaCZw1np8lskPeqqTVi7ppV0XTVJlR+lnfxPe24
	sUPx02VA==;
Received: from 179-125-64-239-dinamico.pombonet.net.br ([179.125.64.239] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tfeOZ-003xMa-15; Wed, 05 Feb 2025 13:20:49 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Wed, 05 Feb 2025 09:20:07 -0300
Subject: [PATCH] tpm: do not start chip while suspended
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-tpm-suspend-v1-1-fb89a29c0b69@igalia.com>
X-B4-Tracking: v=1; b=H4sIAHZXo2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIwNT3ZKCXN3i0uKC1LwU3SQjozRzE9M0Y0MjEyWgjoKi1LTMCrBp0bG
 1tQD0B/YtXQAAAA==
X-Change-ID: 20250205-tpm-suspend-b22f745f3124
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Jerry Snitselaar <jsnitsel@redhat.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mike Seo <mikeseohyungjin@gmail.com>, kernel-dev@igalia.com, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

tpm_chip_start may issue IO that should not be done while the chip is
suspended. In the particular case of I2C, it will issue the following
warning:

[35985.503769] ------------[ cut here ]------------
[35985.503771] i2c i2c-1: Transfer while suspended
[35985.503796] WARNING: CPU: 0 PID: 74 at drivers/i2c/i2c-core.h:56 __i2c_transfer+0xbe/0x810
[35985.503802] Modules linked in:
[35985.503808] CPU: 0 UID: 0 PID: 74 Comm: hwrng Tainted: G        W          6.13.0-next-20250203-00005-gfa0cb5642941 #19 9c3d7f78192f2d38e32010ac9c90fdc71109ef6f
[35985.503814] Tainted: [W]=WARN
[35985.503817] Hardware name: Google Morphius/Morphius, BIOS Google_Morphius.13434.858.0 10/26/2023
[35985.503819] RIP: 0010:__i2c_transfer+0xbe/0x810
[35985.503825] Code: 30 01 00 00 4c 89 f7 e8 40 fe d8 ff 48 8b 93 80 01 00 00 48 85 d2 75 03 49 8b 16 48 c7 c7 0a fb 7c a7 48 89 c6 e8 32 ad b0 fe <0f> 0b b8 94 ff ff ff e9 33 04 00 00 be 02 00 00 00 83 fd 02 0f 5
[35985.503828] RSP: 0018:ffffa106c0333d30 EFLAGS: 00010246
[35985.503833] RAX: 074ba64aa20f7000 RBX: ffff8aa4c1167120 RCX: 0000000000000000
[35985.503836] RDX: 0000000000000000 RSI: ffffffffa77ab0e4 RDI: 0000000000000001
[35985.503838] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
[35985.503841] R10: 0000000000000004 R11: 00000001000313d5 R12: ffff8aa4c10f1820
[35985.503843] R13: ffff8aa4c0e243c0 R14: ffff8aa4c1167250 R15: ffff8aa4c1167120
[35985.503846] FS:  0000000000000000(0000) GS:ffff8aa4eae00000(0000) knlGS:0000000000000000
[35985.503849] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[35985.503852] CR2: 00007fab0aaf1000 CR3: 0000000105328000 CR4: 00000000003506f0
[35985.503855] Call Trace:
[35985.503859]  <TASK>
[35985.503863]  ? __warn+0xd4/0x260
[35985.503868]  ? __i2c_transfer+0xbe/0x810
[35985.503874]  ? report_bug+0xf3/0x210
[35985.503882]  ? handle_bug+0x63/0xb0
[35985.503887]  ? exc_invalid_op+0x16/0x50
[35985.503892]  ? asm_exc_invalid_op+0x16/0x20
[35985.503904]  ? __i2c_transfer+0xbe/0x810
[35985.503913]  tpm_cr50_i2c_transfer_message+0x24/0xf0
[35985.503920]  tpm_cr50_i2c_read+0x8e/0x120
[35985.503928]  tpm_cr50_request_locality+0x75/0x170
[35985.503935]  tpm_chip_start+0x116/0x160
[35985.503942]  tpm_try_get_ops+0x57/0x90
[35985.503948]  tpm_find_get_ops+0x26/0xd0
[35985.503955]  tpm_get_random+0x2d/0x80
[35985.503960]  hwrng_fillfn+0x13b/0x2e0
[35985.503964]  ? __cfi_hwrng_fillfn+0x10/0x10
[35985.503969]  kthread+0x23d/0x250
[35985.503974]  ? srso_return_thunk+0x5/0x5f
[35985.503979]  ? lockdep_hardirqs_on+0x95/0x150
[35985.503985]  ? __cfi_kthread+0x10/0x10
[35985.503989]  ret_from_fork+0x44/0x50
[35985.503994]  ? __cfi_kthread+0x10/0x10
[35985.503998]  ret_from_fork_asm+0x11/0x20
[35985.504013]  </TASK>
[35985.504015] irq event stamp: 107462
[35985.504017] hardirqs last  enabled at (107461): [<ffffffffa6b82d41>] _raw_spin_unlock_irqrestore+0x31/0x60
[35985.504022] hardirqs last disabled at (107462): [<ffffffffa6b77309>] __schedule+0x159/0x16f0
[35985.504027] softirqs last  enabled at (104760): [<ffffffffa4f62ef5>] __irq_exit_rcu+0x75/0x160
[35985.504032] softirqs last disabled at (104755): [<ffffffffa4f62ef5>] __irq_exit_rcu+0x75/0x160
[35985.504036] ---[ end trace 0000000000000000 ]---
[35985.504126] tpm tpm0: i2c transfer failed (attempt 2/3): -108
[35985.504207] tpm tpm0: i2c transfer failed (attempt 3/3): -108
[35985.504395] tpm tpm0: i2c transfer failed (attempt 2/3): -108
[35985.504474] tpm tpm0: i2c transfer failed (attempt 3/3): -108

Test for the suspended flag inside tpm_try_get_ops while holding the chip
tpm_mutex before calling tpm_chip_start. That will also prevent
tpm_get_random from doing IO while the TPM is suspended.

Fixes: 9265fed6db60 ("tpm: Lock TPM chip in tpm_pm_suspend() first")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: stable@vger.kernel.org
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Mike Seo <mikeseohyungjin@gmail.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-chip.c      | 5 +++++
 drivers/char/tpm/tpm-interface.c | 8 +-------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 7df7abaf3e526bf7e85ac9dfbaa1087a51d2ab7e..6db864696a583bf59c534ec8714900a6be7b5156 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -168,6 +168,11 @@ int tpm_try_get_ops(struct tpm_chip *chip)
 		goto out_ops;
 
 	mutex_lock(&chip->tpm_mutex);
+
+	/* tmp_chip_start may issue IO that is denied while suspended */
+	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED)
+		goto out_lock;
+
 	rc = tpm_chip_start(chip);
 	if (rc)
 		goto out_lock;
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index b1daa0d7b341b1a4c71a200115f0d29d2e87512d..e6d786ce4e36970428b75d288a066e832c5b2af1 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -441,22 +441,16 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 	if (!out || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
+	/* NULL will be returned if chip is suspended */
 	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
-	/* Give back zero bytes, as TPM chip has not yet fully resumed: */
-	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED) {
-		rc = 0;
-		goto out;
-	}
-
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		rc = tpm2_get_random(chip, out, max);
 	else
 		rc = tpm1_get_random(chip, out, max);
 
-out:
 	tpm_put_ops(chip);
 	return rc;
 }

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250205-tpm-suspend-b22f745f3124

Best regards,
-- 
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>


