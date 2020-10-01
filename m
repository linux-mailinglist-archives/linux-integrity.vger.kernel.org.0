Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B316928064C
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Oct 2020 20:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733019AbgJASLa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Oct 2020 14:11:30 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50904 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730116AbgJASLa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Oct 2020 14:11:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1A5748EE17F;
        Thu,  1 Oct 2020 11:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601575890;
        bh=VeLS3oENa9mbbyJzRw1kF0e9Sr9BSblKBLqGxC/5i58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fGLgFksLAHPOOfF33bp8meQALZrXqP80I2qAv6Ce0fLik0p+3Oht1/V9/w4e1uNKY
         ftlGIZakifgaj3xKHX/m10wV4WNPStUpdFlBAjTcFXWYm/xMI53D9YZDstXBtB/INj
         BFNiBPOBvi3DdJLwjuflzJ6Qu4uY77WV4pYQdqgM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jDuC0aJuh7oI; Thu,  1 Oct 2020 11:11:30 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9A0CD8EE0DA;
        Thu,  1 Oct 2020 11:11:29 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH v2 5/5] Revert "tpm: Revert "tpm_tis_core: Turn on the TPM before probing IRQ's""
Date:   Thu,  1 Oct 2020 11:09:25 -0700
Message-Id: <20201001180925.13808-6-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
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
index 12b657ed3a39..23b60583928b 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1117,6 +1117,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 			goto out_err;
 		}
 
+		tpm_chip_start(chip);
 		if (irq) {
 			tpm_tis_probe_irq_single(chip, IRQF_SHARED, irq);
 			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
@@ -1128,6 +1129,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		} else {
 			tpm_tis_probe_irq(chip);
 		}
+		tpm_chip_stop(chip);
 	}
 
 	rc = tpm_chip_register(chip);
-- 
2.28.0

