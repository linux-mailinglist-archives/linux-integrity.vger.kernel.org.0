Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D2F27DC1F
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 00:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgI2WeS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 18:34:18 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51338 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728142AbgI2WeS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 18:34:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0510F8EE17F;
        Tue, 29 Sep 2020 15:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601418858;
        bh=UjoWhQsfJF0wlY7djVDjNwxpe5OSPsx27bOacLF0BRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SCsgOWHVIkizbMHqXiV0rQ31KlcoTJVl6VcW3WfxtBWXL4MBSM7Y/5K4r6BhJxLtA
         SFn/+YXkMnUt9Ni3Vy7abZ4XDxZAuH/y97nws3t3YgZH6U2UEYI/s2iqVhEUNVSV4A
         pjHbqrX6YCYzUEnR7I7+2xWi2GQ3f+Qa4dM/20+k=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rj8nHCb8TBzt; Tue, 29 Sep 2020 15:34:17 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 814FF8EE119;
        Tue, 29 Sep 2020 15:34:17 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH 4/4] Revert "tpm: Revert "tpm_tis_core: Turn on the TPM before probing IRQ's""
Date:   Tue, 29 Sep 2020 15:32:16 -0700
Message-Id: <20200929223216.22584-5-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929223216.22584-1-James.Bottomley@HansenPartnership.com>
References: <20200929223216.22584-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Revert the patch aa4a63dd9816 which stops interrupt probing from
working, now that it should be safe to allow interrupt probing on all
systems without incurring interrupt storms.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm_tis_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index b8ab26077cb1..0a86cf392466 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1116,6 +1116,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 			goto out_err;
 		}
 
+		tpm_chip_start(chip);
 		if (irq) {
 			tpm_tis_probe_irq_single(chip, IRQF_SHARED, irq);
 			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
@@ -1127,6 +1128,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		} else {
 			tpm_tis_probe_irq(chip);
 		}
+		tpm_chip_stop(chip);
 	}
 
 	rc = tpm_chip_register(chip);
-- 
2.28.0

