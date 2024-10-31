Return-Path: <linux-integrity+bounces-3942-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B76679B7141
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2024 01:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CB11C2134E
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2024 00:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DA017C98;
	Thu, 31 Oct 2024 00:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYe5dU0l"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38440156CF;
	Thu, 31 Oct 2024 00:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730335509; cv=none; b=qOCTztoPaNrOLkSSHCglt1DlsFxWGcKxPpkG6NsATn7bn2D3ah3WClYOgMYKJi55NfyhwDlGw+m0NLcpjmaAnrlK1vIWEq2qMSuQFpMfaSgrJ+9Ft17MObo5PxBadw13GPaQ0UOyqVNaOnepmNZda56/EsWgIzNHrrjsUmGoYWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730335509; c=relaxed/simple;
	bh=L9TwB0ET8ic5Y1NDlL9zdzcEuTRfwOrfk8W3N9skWyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GvoMLEsIJZTC1kRJBJUZN0CCJ0t3DonRH26ipHf1BPhRb0v9px3DfIax1RXmy843CLD5EDtUoXjFqx46MGuSbFOU5O3Shy8iM+Uzqo05dpbbK1bekvp7Hx+C+vSsq8x1mQmdUNb+nrTanHumCuLpYA0B9WtJgrzmGb1sckKs8Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYe5dU0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5972FC4CED4;
	Thu, 31 Oct 2024 00:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730335508;
	bh=L9TwB0ET8ic5Y1NDlL9zdzcEuTRfwOrfk8W3N9skWyI=;
	h=From:To:Cc:Subject:Date:From;
	b=QYe5dU0lkJnPHBlc/5STC0DRhfE6NID7VgLv8zjxrPS5yLbS1UjcAFtScmxyum8HV
	 DnQIc9e18/ZiZQAlPNsICXIaJu5rkC57AfCSvSKZtz9vyULkuzRUSfy5T+6yGWsjkN
	 n29RxR9ILcvD2DD9PvpsWo7mKnWKKH7HVJHscPhZjQakJF80bli+v4/s4qcl+8kYpy
	 lQRtPh4y8ROZvqG2p/dxloVX0q9WXpJtla23d+tTm4iRfYdj/U3HpIGaXF5rEL4g6O
	 mLrGY/8gUSKURZD0LLceucVRD8S2q19Xq0/gben8RlmB2rOruieAH2O4pUlTzeWTk7
	 04y7hOvTl+Jbw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Cc: stable@vger.kernel.org,
	Mike Seo <mikeseohyungjin@gmail.com>,
	linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] tpm: Lock TPM chip in tpm_pm_suspend() first
Date: Thu, 31 Oct 2024 02:45:00 +0200
Message-ID: <20241031004501.165027-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting TPM_CHIP_FLAG_SUSPENDED in the end of tpm_pm_suspend() can be racy
according to the bug report, as this leaves window for tpm_hwrng_read() to
be called while the operation is in progress.

To address this, lock the TPM chip before checking any possible flags.
This will guarantee that tpm_hwrng_read() and tpm_pm_suspend() won't
conflict with each other.

Cc: stable@vger.kernel.org # v6.4+
Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
Reported-by: Mike Seo <mikeseohyungjin@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219383
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- Addressed my own remark:
  https://lore.kernel.org/linux-integrity/D59JAI6RR2CD.G5E5T4ZCZ49W@kernel.org/
---
 drivers/char/tpm/tpm-interface.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 8134f002b121..e37fcf9361bc 100644
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
 
@@ -377,23 +384,22 @@ int tpm_pm_suspend(struct device *dev)
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
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm_pm_suspend);
-- 
2.47.0


