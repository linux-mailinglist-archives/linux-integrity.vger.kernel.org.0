Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFAE6E7E86
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Apr 2023 17:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjDSPlg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Apr 2023 11:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjDSPlf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Apr 2023 11:41:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3329E4490
        for <linux-integrity@vger.kernel.org>; Wed, 19 Apr 2023 08:41:34 -0700 (PDT)
Date:   Wed, 19 Apr 2023 17:41:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681918891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4/YfXKV5b0StPu508z4GRS2uAmm2oisxiF22pdKUUnw=;
        b=e/yuoalzU9dA24XJvzZCp2JVS0zw8xW1FEiHz83ON4/99DRm5MLjfie2zzGQaB/VdHTXmr
        Jczg75aNxqwnHMwrw+CipaD/l9C3UH0jepCsXjdMMdi9edi8Bv2h8+KEgb3hkhvbLVbbC6
        MugdzwLivMa6V1xrGGaxWEXRFrABNzeBMZHlicybQuG3TigrfKo4CBq02z4SFfOa/4EJjx
        8j8C0eP2zgDd+tdZiQ+xgqX2LANOk3F0rBF6scD/6EiDR+gHtWwEJwoG+i02jDqKelrNnX
        XoCCfmD5iVL7XjemdoTONgIi25ra48DOa3BE18fu+GpauQiJRq6Ua0ZFgZw+MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681918891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4/YfXKV5b0StPu508z4GRS2uAmm2oisxiF22pdKUUnw=;
        b=r+AuIlArX4ov/q87M0FPIcSe68gdWPhTOBeCZHfq0wjdvW9TtLFs4zMYbxc4dP0W6Kuiq3
        RcgMhc+2sEayshCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        Haris Okanovic <haris.okanovic@ni.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] tpm_tis: fix stall after iowrite*()s
Message-ID: <20230419154130.b392MbTl@linutronix.de>
References: <20230323153436.B2SATnZV@linutronix.de>
 <20230330002534.teqpltcmpkdms72t@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230330002534.teqpltcmpkdms72t@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

=46rom: Haris Okanovic <haris.okanovic@ni.com>

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
Link: https://lore.kernel.org/r/20230323153436.B2SATnZV@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2:
  - Updated/ added comments as per Jarkko Sakkinen.

On 2023-03-30 03:25:34 [+0300], Jarkko Sakkinen wrote:
=E2=80=A6
> I would replace this with:
>=20
> /*
>  * Flush previous write operations with a dummy read operation to the=20
>  * TPM MMIO base address.
>  */
>=20
>  I think rest of the reasoning would be better place to the functions,
>  which are call sites for this helper, and here it would be make more
>  sense to explain what it actually does.
=E2=80=A6
>=20
> Thanks for catching this up. It is a small code change but I think that it
> would deserve just a bit more documentation, as it would make sure that t=
he
> reasoning you gave is taken into account in the future code reviews.
>=20
> I think that if you append what I suggested above (you can use your
> judgement and edit as you will), it should be sufficient.

Did as asked. However, it is a bit misleading given that the comment
above tpm_tis_iowrite*() describes the flush behaviour which is
conditional on CONFIG_PREEMPT_RT. Do you want this flush unconditionally
or you fine the way it is?

 drivers/char/tpm/tpm_tis.c |   43 ++++++++++++++++++++++++++++++++++++++++=
+--
 1 file changed, 41 insertions(+), 2 deletions(-)

--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -50,6 +50,45 @@ static inline struct tpm_tis_tcg_phy *to
 	return container_of(data, struct tpm_tis_tcg_phy, priv);
 }
=20
+#ifdef CONFIG_PREEMPT_RT
+/*
+ * Flush previous write operations with a dummy read operation to the
+ * TPM MMIO base address.
+ */
+static inline void tpm_tis_flush(void __iomem *iobase)
+{
+	ioread8(iobase + TPM_ACCESS(0));
+}
+#else
+#define tpm_tis_flush(iobase) do { } while (0)
+#endif
+
+/*
+ * Write a byte word to the TPM MMIO address, and flush the write queue.
+ * The flush ensures that the data is sent immediately over the bus and not
+ * aggregated with further requests and transferred later in a batch. The =
large
+ * write requests can lead to unwanted latency spikes by blocking the CPU =
until
+ * the complete batch has been transferred.
+ */
+static inline void tpm_tis_iowrite8(u8 b, void __iomem *iobase, u32 addr)
+{
+	iowrite8(b, iobase + addr);
+	tpm_tis_flush(iobase);
+}
+
+/*
+ * Write a 32-bit word to the TPM MMIO address, and flush the write queue.
+ * The flush ensures that the data is sent immediately over the bus and not
+ * aggregated with further requests and transferred later in a batch. The =
large
+ * write requests can lead to unwanted latency spikes by blocking the CPU =
until
+ * the complete batch has been transferred.
+ */
+static inline void tpm_tis_iowrite32(u32 b, void __iomem *iobase, u32 addr)
+{
+	iowrite32(b, iobase + addr);
+	tpm_tis_flush(iobase);
+}
+
 static int interrupts =3D -1;
 module_param(interrupts, int, 0444);
 MODULE_PARM_DESC(interrupts, "Enable interrupts");
@@ -186,12 +225,12 @@ static int tpm_tcg_write_bytes(struct tp
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
=20

