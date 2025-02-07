Return-Path: <linux-integrity+bounces-4748-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 524DCA2CAD3
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 19:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497EC188C31C
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 18:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F25C19C54C;
	Fri,  7 Feb 2025 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oKWn0qQc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CCA19A28D;
	Fri,  7 Feb 2025 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738951693; cv=none; b=XDLWaSBWmomH/DDfLRjwY21iWWDy7CU/FHL+1Nf9WuuezOxutRP77MZxxrXGySv/S+3GfVgZ2IDCLFTNbDeQ8Tywt2irxxvlnNaNOAHFTgdTMvFK7Ts5AEHuSNNe1iZY3+wd1oUj1rSgOo1gHMvK6u8NaZRjVHghPInRpqAWRHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738951693; c=relaxed/simple;
	bh=ZofhyASRMaafFnHAsmCwIy7+QrDK0R12jbRJuRvm8W8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q0CI5RF1G8pvvbkLnevb7+iJqJHjIkQ81IbuMsbPIbiy1aSp9bUEq0pRt1tzTtQqWOZS2eEFX4zFyMKOWdTgGQMooS8Bj7bsWuKucfMndF5VRUcytQSb9+RsCiEQKibLeX0sLbovnXx+b/I6rdAaJlQqX6gl70ArWYEWcyUIaoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=oKWn0qQc; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oT4q5SA4b9tiEFh6DIdA0Rz1s3Dq/ibQV47m9De2Ve0=; b=oKWn0qQcmWmk+o5U3fVtUmLN/Y
	mV8p2Fu5X9zn/Ys3qEUEofysf4pVJwMEToz35Im9FIDaqbPlbfZ5IIunHbPG9mOlv1n4Ag2OhUrqP
	EjKGg8hghYCt3YVQlXAXNycR0o32O/w9kTGUALu3Lea+9nYxeeGnMhkhHmPnJOjlFxmxFYAbU53Xy
	QdjUfO/RRI/hHUloLLpXGzcw4OVdlw11OgH+ibtmuNnk9zsjsklqQDDhbi7ntektVfR2H7hImUfSc
	iRqsgu5YzsXRyKvxVte3eZswTsnxAZ/7ZdwNRkrCswCaQ0vXB1UNVYFsrFZFNziCyQ8Z6Ad90t4/N
	v08eiO4g==;
Received: from 179-125-64-239-dinamico.pombonet.net.br ([179.125.64.239] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tgSlj-0062jU-86; Fri, 07 Feb 2025 19:08:05 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Fri, 07 Feb 2025 15:07:46 -0300
Subject: [PATCH v2] tpm: do not start chip while suspended
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-tpm-suspend-v2-1-b8cfb51d43ce@igalia.com>
X-B4-Tracking: v=1; b=H4sIAPFLpmcC/23MQQ7CIBCF4as0sxYDY1HrynuYLoBCO4kFArXRN
 Nxd7Nrl/5L3bZBtIpvh1myQ7EqZgq+BhwbMpPxoGQ21ATlKjlyyJc4sv3K0fmAa0V1a6U4CW6i
 PmKyj9649+toT5SWkz46v4rf+d1bBBHP62insDNfn7k6jepI6mjBDX0r5AnK+blunAAAA
X-Change-ID: 20250205-tpm-suspend-b22f745f3124
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Jerry Snitselaar <jsnitsel@redhat.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mike Seo <mikeseohyungjin@gmail.com>, kernel-dev@igalia.com, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

Checking TPM_CHIP_FLAG_SUSPENDED after the call to tpm_find_get_ops() can
lead to a spurious tpm_chip_start() call:

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

Don't move forward with tpm_chip_start() inside tpm_try_get_ops(), unless
TPM_CHIP_FLAG_SUSPENDED is not set. tpm_find_get_ops() will return NULL in
such a failure case.

Fixes: 9265fed6db60 ("tpm: Lock TPM chip in tpm_pm_suspend() first")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: stable@vger.kernel.org
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Mike Seo <mikeseohyungjin@gmail.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
---
Changes in v2:
- Improve commit message as suggested by Jarkko Sakkinen.
- Link to v1: https://lore.kernel.org/r/20250205-tpm-suspend-v1-1-fb89a29c0b69@igalia.com
---
 drivers/char/tpm/tpm-chip.c      | 5 +++++
 drivers/char/tpm/tpm-interface.c | 7 -------
 2 files changed, 5 insertions(+), 7 deletions(-)

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
index b1daa0d7b341b1a4c71a200115f0d29d2e87512d..f62f7871edbdb0181fad8af3367878308fa8a454 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -445,18 +445,11 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
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


