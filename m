Return-Path: <linux-integrity+bounces-3952-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6C99B8798
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Nov 2024 01:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 824C0B21F61
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Nov 2024 00:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2851E571;
	Fri,  1 Nov 2024 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqoiMvoO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E5F196;
	Fri,  1 Nov 2024 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730420525; cv=none; b=nllCHNINeJXOTXXNjOM/TEKNfYqv0SuDp5mkfipM8tDwrnYlI6gkrab9CqaNIA2zVNVZqzFC4/ILaCQTwslLbv+Fn7eU6hcX9spbpQTKKyWSbeA27RnKaO2iwlt1hS00jbbE4t8bLnIQQ2OVq2vorQRcQtWDZ5ce+8+h7gZ8H3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730420525; c=relaxed/simple;
	bh=2qL387XEwi0QJoPJLdNwkpzU1ZgxjA26xwDKEWQ6jvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YFit5nQjhqJah2dLeS3MI5suWo1c45uMeJtoyOKlru8c9wICCqw3PPfeIfQaCeczCy47weUJXgar3j2Iw5JtUJKXIE5KNqfYawbkyb8XJYOZcNSrVDG6mmIlCv0vLtO1ggeKzUd1xeFdURwbp5GlxJveUO3ei6sUIxNrlNXqQ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqoiMvoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75433C4CEC3;
	Fri,  1 Nov 2024 00:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730420524;
	bh=2qL387XEwi0QJoPJLdNwkpzU1ZgxjA26xwDKEWQ6jvc=;
	h=From:To:Cc:Subject:Date:From;
	b=mqoiMvoOta5E9zcIZpB0NV9tHfGDDN0X0lzrTzlo0O6/BVzdFlfxEHlU4hq2vGxO7
	 g90sAw1euB6VUi1XvA5Uhz5MDoWSAxqrtxxYVGOTXU//Uq8kHHGzljAJSFiYNP5Lve
	 eVi1tBDmAt+KU4NgpcPfLJyo+Lj3702HoL6eXiL/lJGjyhUPDbNqOoByJXFt2aGk99
	 ladAF3d5uiMeznt+oTozrJQ18UfQkJR/gS4DZv1XDku+SgcXpsZnicS7Gg6RqbquTN
	 m9oRQ31dYVS8/UQr1+s7y8vRF4cBUoUFL4LTzDtm/223rGvJUN9QP/ijkH7YowSW2y
	 pSEfsZQtpTraQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Cc: stable@vger.kernel.org,
	Mike Seo <mikeseohyungjin@gmail.com>,
	linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] tpm: Lock TPM chip in tpm_pm_suspend() first
Date: Fri,  1 Nov 2024 02:21:56 +0200
Message-ID: <20241101002157.645874-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting TPM_CHIP_FLAG_SUSPENDED in the end of tpm_pm_suspend() can be racy
according, as this leaves window for tpm_hwrng_read() to be called while
the operation is in progress. The recent bug report gives also evidence of
this behaviour.

Aadress this by locking the TPM chip before checking any chip->flags both
in tpm_pm_suspend() and tpm_hwrng_read(). Move TPM_CHIP_FLAG_SUSPENDED
check inside tpm_get_random() so that it will be always checked only when
the lock is reserved.

Cc: stable@vger.kernel.org # v6.4+
Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
Reported-by: Mike Seo <mikeseohyungjin@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219383
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
- Check TPM_CHIP_FLAG_SUSPENDED inside tpm_get_random() so that it is
  also done under the lock (suggested by Jerry Snitselaar).
v2:
- Addressed my own remark:
  https://lore.kernel.org/linux-integrity/D59JAI6RR2CD.G5E5T4ZCZ49W@kernel.org/
---
 drivers/char/tpm/tpm-chip.c      |  4 ----
 drivers/char/tpm/tpm-interface.c | 32 ++++++++++++++++++++++----------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 1ff99a7091bb..7df7abaf3e52 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -525,10 +525,6 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
 	struct tpm_chip *chip = container_of(rng, struct tpm_chip, hwrng);
 
-	/* Give back zero bytes, as TPM chip has not yet fully resumed: */
-	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED)
-		return 0;
-
 	return tpm_get_random(chip, data, max);
 }
 
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 8134f002b121..b1daa0d7b341 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -370,6 +370,13 @@ int tpm_pm_suspend(struct device *dev)
 	if (!chip)
 		return -ENODEV;
 
+	rc = tpm_try_get_ops(chip);
+	if (rc) {
+		/* Can be safely set out of locks, as no action cannot race: */
+		chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
+		goto out;
+	}
+
 	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
 		goto suspended;
 
@@ -377,21 +384,19 @@ int tpm_pm_suspend(struct device *dev)
 	    !pm_suspend_via_firmware())
 		goto suspended;
 
-	rc = tpm_try_get_ops(chip);
-	if (!rc) {
-		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-			tpm2_end_auth_session(chip);
-			tpm2_shutdown(chip, TPM2_SU_STATE);
-		} else {
-			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
-		}
-
-		tpm_put_ops(chip);
+	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+		tpm2_end_auth_session(chip);
+		tpm2_shutdown(chip, TPM2_SU_STATE);
+		goto suspended;
 	}
 
+	rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
+
 suspended:
 	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
+	tpm_put_ops(chip);
 
+out:
 	if (rc)
 		dev_err(dev, "Ignoring error %d while suspending\n", rc);
 	return 0;
@@ -440,11 +445,18 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 	if (!chip)
 		return -ENODEV;
 
+	/* Give back zero bytes, as TPM chip has not yet fully resumed: */
+	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED) {
+		rc = 0;
+		goto out;
+	}
+
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		rc = tpm2_get_random(chip, out, max);
 	else
 		rc = tpm1_get_random(chip, out, max);
 
+out:
 	tpm_put_ops(chip);
 	return rc;
 }
-- 
2.47.0


