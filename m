Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB3E43F894
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Oct 2021 10:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhJ2ILu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Oct 2021 04:11:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50258 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbhJ2ILt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Oct 2021 04:11:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 73BD01F455F3
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     linux-integrity@vger.kernel.org
Cc:     apronin@chromium.org, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2] tpm: tpm_tis_spi_cr50: Add default RNG quality
Date:   Fri, 29 Oct 2021 10:09:15 +0200
Message-Id: <20211029080915.63838-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

To allow this device to fill the kernel's entropy pool at boot,
setup a default quality for the hwrng found in Cr50.

After some testing with rngtest and dieharder it was, in short,
discovered that the RNG produces fair quality randomness, giving
around 99.93% successes in rngtest FIPS140-2.

Notably, though, when testing with dieharder it was noticed that
we get 3 WEAK results over 114, which isn't optimal, and also
the p-values distribution wasn't uniform in all the cases, so a
conservative quality value was chosen by applying an arbitrary
penalty to the calculated values.

For reference, this is how the values were calculated:

The dieharder results were averaged, then normalized (0-1000)
and re-averaged with the rngtest result (where the result was
given a score of 99.93% of 1000, so 999.3), then aggregated
together and averaged again.
An arbitrary penalty of -100 was applied due to the retrieved
value, which brings us finally to 700.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/char/tpm/tpm_tis_spi_cr50.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_tis_spi_cr50.c
index ea759af25634..dae98dbeeeac 100644
--- a/drivers/char/tpm/tpm_tis_spi_cr50.c
+++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
@@ -36,6 +36,9 @@
 #define TPM_CR50_FW_VER(l)			(0x0f90 | ((l) << 12))
 #define TPM_CR50_MAX_FW_VER_LEN			64
 
+/* Default quality for hwrng. */
+#define TPM_CR50_DEFAULT_RNG_QUALITY		700
+
 struct cr50_spi_phy {
 	struct tpm_tis_spi_phy spi_phy;
 
@@ -264,6 +267,7 @@ int cr50_spi_probe(struct spi_device *spi)
 	phy = &cr50_phy->spi_phy;
 	phy->flow_control = cr50_spi_flow_control;
 	phy->wake_after = jiffies;
+	phy->priv.rng_quality = TPM_CR50_DEFAULT_RNG_QUALITY;
 	init_completion(&phy->ready);
 
 	cr50_phy->access_delay = CR50_NOIRQ_ACCESS_DELAY;
-- 
2.33.0

