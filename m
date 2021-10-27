Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA28E43C926
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Oct 2021 14:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbhJ0MFF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Oct 2021 08:05:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57196 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbhJ0MFF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Oct 2021 08:05:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1BD521F443DB
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     linux-integrity@vger.kernel.org
Cc:     apronin@chromium.org, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] tpm: tpm_tis_spi_cr50: Add default RNG quality
Date:   Wed, 27 Oct 2021 14:02:33 +0200
Message-Id: <20211027120233.2489258-1-angelogioacchino.delregno@collabora.com>
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
the p-values distribution wasn't uniform in all the cases, so a
conservative quality value was chosen.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/char/tpm/tpm_tis_spi_cr50.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_tis_spi_cr50.c
index ea759af25634..d6195fb58036 100644
--- a/drivers/char/tpm/tpm_tis_spi_cr50.c
+++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
@@ -264,6 +264,7 @@ int cr50_spi_probe(struct spi_device *spi)
 	phy = &cr50_phy->spi_phy;
 	phy->flow_control = cr50_spi_flow_control;
 	phy->wake_after = jiffies;
+	phy->priv.rng_quality = 700;
 	init_completion(&phy->ready);
 
 	cr50_phy->access_delay = CR50_NOIRQ_ACCESS_DELAY;
-- 
2.33.0

