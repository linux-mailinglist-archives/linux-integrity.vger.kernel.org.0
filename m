Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29F96C6C60
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Mar 2023 16:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjCWPep (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Mar 2023 11:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjCWPen (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Mar 2023 11:34:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648F8AD11
        for <linux-integrity@vger.kernel.org>; Thu, 23 Mar 2023 08:34:40 -0700 (PDT)
Date:   Thu, 23 Mar 2023 16:34:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679585678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=LVp4pkaZTAa2Pm4n5l7CpJunHSxqocoaqX8/zGFYMEA=;
        b=U0RuVqB2wWe1RpgGkGvG980EjhqofvIqXk7qUxksq98UEETeXFX7QcKrhhu7cr1jXLrkoj
        CSOGrYf+RfqX4n3AcDQz8uXORT9cV1dU3ssPejyEn1ooO7KpDWRXJcoEvLk1+ZwiojFdXy
        Kgvx7P9Wp6GDtkGCUXT1Mx+iqDJTieNtgenVfVHDfsdWZKSoFbyVPauYcUczWI4vR1v5zm
        X1ZY178Al6AMfSy2l2DzcB2gtQtQAq7Ibi9VxCSn7FFLDCB3bubC2aebAPPNXwKbhF5QvA
        bUFT54rwAvwPValbHmp1LpYCiXQWGiYWLSarWdWJEV6wdZW1u/R9cZeoZ72kBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679585678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=LVp4pkaZTAa2Pm4n5l7CpJunHSxqocoaqX8/zGFYMEA=;
        b=Leotz5KjQFfLkbasVU2Is1xWvKP7Ys8OZHYwkcVNS8UYIbtPla4q5SQlCwScK2RgHMeGFZ
        Q4Tq0GdkGqULk1Ag==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-integrity@vger.kernel.org
Cc:     Haris Okanovic <haris.okanovic@ni.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] tpm_tis: fix stall after iowrite*()s
Message-ID: <20230323153436.B2SATnZV@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Haris Okanovic <haris.okanovic@ni.com>

ioread8() operations to TPM MMIO addresses can stall the CPU when
immediately following a sequence of iowrite*()'s to the same region.

For example, cyclitest measures ~400us latency spikes when a non-RT
usermode application communicates with an SPI-based TPM chip (Intel Atom
E3940 system, PREEMPT_RT kernel). The spikes are caused by a
stalling ioread8() operation following a sequence of 30+ iowrite8()s to
the same address. I believe this happens because the write sequence is
buffered (in CPU or somewhere along the bus), and gets flushed on the
first LOAD instruction (ioread*()) that follows.

The enclosed change appears to fix this issue: read the TPM chip's
access register (status code) after every iowrite*() operation to
amortize the cost of flushing data to chip across multiple instructions.

Signed-off-by: Haris Okanovic <haris.okanovic@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

I don't know how performance critical this is so that it should be
restricted to PREEMPT_RT. This has been in RT queue since late 2017 and
I have no idea how to deal with this differently/ in a more generic way.
Original thread:
	https://lore.kernel.org/20170804215651.29247-1-haris.okanovic@ni.com

 drivers/char/tpm/tpm_tis.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index ed5dabd3c72d6..513e0d1c349a6 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -50,6 +50,31 @@ static inline struct tpm_tis_tcg_phy *to_tpm_tis_tcg_phy(struct tpm_tis_data *da
 	return container_of(data, struct tpm_tis_tcg_phy, priv);
 }
 
+#ifdef CONFIG_PREEMPT_RT
+/*
+ * Flushes previous write operations to chip so that a subsequent
+ * ioread*()s won't stall a CPU.
+ */
+static inline void tpm_tis_flush(void __iomem *iobase)
+{
+	ioread8(iobase + TPM_ACCESS(0));
+}
+#else
+#define tpm_tis_flush(iobase) do { } while (0)
+#endif
+
+static inline void tpm_tis_iowrite8(u8 b, void __iomem *iobase, u32 addr)
+{
+	iowrite8(b, iobase + addr);
+	tpm_tis_flush(iobase);
+}
+
+static inline void tpm_tis_iowrite32(u32 b, void __iomem *iobase, u32 addr)
+{
+	iowrite32(b, iobase + addr);
+	tpm_tis_flush(iobase);
+}
+
 static int interrupts = -1;
 module_param(interrupts, int, 0444);
 MODULE_PARM_DESC(interrupts, "Enable interrupts");
@@ -186,12 +211,12 @@ static int tpm_tcg_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 	switch (io_mode) {
 	case TPM_TIS_PHYS_8:
 		while (len--)
-			iowrite8(*value++, phy->iobase + addr);
+			tpm_tis_iowrite8(*value++, phy->iobase, addr);
 		break;
 	case TPM_TIS_PHYS_16:
 		return -EINVAL;
 	case TPM_TIS_PHYS_32:
-		iowrite32(le32_to_cpu(*((__le32 *)value)), phy->iobase + addr);
+		tpm_tis_iowrite32(le32_to_cpu(*((__le32 *)value)), phy->iobase, addr);
 		break;
 	}
 
-- 
2.40.0

