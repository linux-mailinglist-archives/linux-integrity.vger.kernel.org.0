Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4043280649
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Oct 2020 20:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbgJASLS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Oct 2020 14:11:18 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50868 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730070AbgJASLS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Oct 2020 14:11:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 60FD58EE17F;
        Thu,  1 Oct 2020 11:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601575878;
        bh=+CqbArv6HAhHDhBNuyZbeVG2w6KgOAP4Ys5fnYVjUQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uk9beEYMto/W+twF13s2nWjjehYbBGzgzIH29pp4fGKBU5QZU7UnCaHEq4zGdRpdr
         1y70QeWnokvxhZ2i8APD9oRHUgVOZM3K7EZRaYLcskLisBJVhPDY05rXBx1/WDne7D
         0yTUhCAOWe0HNHPCm6YtQkPBoxpi/XXQlQqTkAYw=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OM33tkN0FE_w; Thu,  1 Oct 2020 11:11:18 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id ED72C8EE0DA;
        Thu,  1 Oct 2020 11:11:17 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH v2 4/5] tpm_tis: fix IRQ probing
Date:   Thu,  1 Oct 2020 11:09:24 -0700
Message-Id: <20201001180925.13808-5-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There are two problems with our current interrupt probing: firstly the
TPM_CHIP_FLAG_IRQ never gets set initially, so a check for interrupts
is never done.  Fix this by setting the flag before we generate and
interrupt for probing.  Secondly our IRQ setup may be ineffective on a
TPM without legacy access cycles becuase according to the TPM
Interface Specification the interrupt registers are only writeable in
the current locality, so issue a request_locality before setting up
the interrupts.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v2: improved description
---
 drivers/char/tpm/tpm_tis_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 0c07da8cd680..12b657ed3a39 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -809,6 +809,19 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip,
 	}
 	priv->irq = irq;
 
+	/*
+	 * note writes to the interrupt registers are only effective
+	 * when the TPM is in the active locality, so we have to
+	 * request the locality here to get the interrupt set up.
+	 * This request has no corresponding release, because the
+	 * locality will be relinquished at the end of the tpm command
+	 * that probes the interrupts
+	 */
+	if (request_locality(chip, 0) != 0) {
+		dev_err(&chip->dev, "failed to gain locality for irq probe\n");
+		return -EBUSY;
+	}
+
 	rc = tpm_tis_read8(priv, TPM_INT_VECTOR(priv->locality),
 			   &original_int_vec);
 	if (rc < 0)
@@ -836,6 +849,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip,
 		return rc;
 
 	priv->irq_tested = false;
+	chip->flags |= TPM_CHIP_FLAG_IRQ;
 
 	/* Generate an interrupt by having the core call through to
 	 * tpm_tis_send
-- 
2.28.0

