Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1CC6EC0D1
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Apr 2023 17:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjDWPeu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Apr 2023 11:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjDWPet (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Apr 2023 11:34:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A5310FC
        for <linux-integrity@vger.kernel.org>; Sun, 23 Apr 2023 08:34:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E4D460F89
        for <linux-integrity@vger.kernel.org>; Sun, 23 Apr 2023 15:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFCDC433D2;
        Sun, 23 Apr 2023 15:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682264087;
        bh=kGxXr4WewbASHdQwHogHDGBrarhgsGMmhUQCvi7mj5c=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=T7rxHWmpLDBFnf2cbEIHFbIN6xHuDVO0mYuJSOToywmwzQ5zR/kNUUrejdKGg/H+5
         fwrME1Lmr8ffT+3vH5+yOu5ClnT6YNvbOFGS/V7NKiVTk3XuwwkDjIbMLdcjSAgx0p
         TqxPuQhJk2NaMzq1Gcg+IaBy72Nk17gloXQAD6BynF4D4wvwnRYI3+V/DyjxLOZkfa
         GPmxnraCdPQNL8Em0cRuh1G9HNKJZd03OSe+qdXpYSTfQOo5cFY85JmZ+2hqDkqdUg
         i0Z/yx/cVF1rXJQbUfg/o1q28NOEwAXI/qoNdMxVK55IHJ2mrv8E33WHj9Pp79+cd/
         4A0B7ESqynUSQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 23 Apr 2023 18:34:44 +0300
Message-Id: <CS48UJACBMXA.3RS4N6JIAPBFZ@suppilovahvero>
Cc:     <linux-integrity@vger.kernel.org>,
        "Haris Okanovic" <haris.okanovic@ni.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH v2] tpm_tis: fix stall after iowrite*()s
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
X-Mailer: aerc 0.14.0
References: <20230323153436.B2SATnZV@linutronix.de>
 <20230330002534.teqpltcmpkdms72t@kernel.org>
 <20230419154130.b392MbTl@linutronix.de>
In-Reply-To: <20230419154130.b392MbTl@linutronix.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Apr 19, 2023 at 6:41 PM EEST, Sebastian Andrzej Siewior wrote:
> From: Haris Okanovic <haris.okanovic@ni.com>
>
> ioread8() operations to TPM MMIO addresses can stall the CPU when
> immediately following a sequence of iowrite*()'s to the same region.
>
> For example, cyclitest measures ~400us latency spikes when a non-RT
> usermode application communicates with an SPI-based TPM chip (Intel Atom
> E3940 system, PREEMPT_RT kernel). The spikes are caused by a
> stalling ioread8() operation following a sequence of 30+ iowrite8()s to
> the same address. I believe this happens because the write sequence is
> buffered (in CPU or somewhere along the bus), and gets flushed on the
> first LOAD instruction (ioread*()) that follows.
>
> The enclosed change appears to fix this issue: read the TPM chip's
> access register (status code) after every iowrite*() operation to
> amortize the cost of flushing data to chip across multiple instructions.
>
> Signed-off-by: Haris Okanovic <haris.okanovic@ni.com>
> Link: https://lore.kernel.org/r/20230323153436.B2SATnZV@linutronix.de
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1=E2=80=A6v2:
>   - Updated/ added comments as per Jarkko Sakkinen.
>
> On 2023-03-30 03:25:34 [+0300], Jarkko Sakkinen wrote:
> =E2=80=A6
> > I would replace this with:
> >=20
> > /*
> >  * Flush previous write operations with a dummy read operation to the=
=20
> >  * TPM MMIO base address.
> >  */
> >=20
> >  I think rest of the reasoning would be better place to the functions,
> >  which are call sites for this helper, and here it would be make more
> >  sense to explain what it actually does.
> =E2=80=A6
> >=20
> > Thanks for catching this up. It is a small code change but I think that=
 it
> > would deserve just a bit more documentation, as it would make sure that=
 the
> > reasoning you gave is taken into account in the future code reviews.
> >=20
> > I think that if you append what I suggested above (you can use your
> > judgement and edit as you will), it should be sufficient.
>
> Did as asked. However, it is a bit misleading given that the comment
> above tpm_tis_iowrite*() describes the flush behaviour which is
> conditional on CONFIG_PREEMPT_RT. Do you want this flush unconditionally
> or you fine the way it is?
>
>  drivers/char/tpm/tpm_tis.c |   43 ++++++++++++++++++++++++++++++++++++++=
+++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
>
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -50,6 +50,45 @@ static inline struct tpm_tis_tcg_phy *to
>  	return container_of(data, struct tpm_tis_tcg_phy, priv);
>  }
> =20
> +#ifdef CONFIG_PREEMPT_RT
> +/*
> + * Flush previous write operations with a dummy read operation to the
> + * TPM MMIO base address.
> + */
> +static inline void tpm_tis_flush(void __iomem *iobase)
> +{
> +	ioread8(iobase + TPM_ACCESS(0));
> +}
> +#else
> +#define tpm_tis_flush(iobase) do { } while (0)
> +#endif
> +
> +/*
> + * Write a byte word to the TPM MMIO address, and flush the write queue.
> + * The flush ensures that the data is sent immediately over the bus and =
not
> + * aggregated with further requests and transferred later in a batch. Th=
e large
> + * write requests can lead to unwanted latency spikes by blocking the CP=
U until
> + * the complete batch has been transferred.
> + */
> +static inline void tpm_tis_iowrite8(u8 b, void __iomem *iobase, u32 addr=
)
> +{
> +	iowrite8(b, iobase + addr);
> +	tpm_tis_flush(iobase);
> +}
> +
> +/*
> + * Write a 32-bit word to the TPM MMIO address, and flush the write queu=
e.
> + * The flush ensures that the data is sent immediately over the bus and =
not
> + * aggregated with further requests and transferred later in a batch. Th=
e large
> + * write requests can lead to unwanted latency spikes by blocking the CP=
U until
> + * the complete batch has been transferred.
> + */
> +static inline void tpm_tis_iowrite32(u32 b, void __iomem *iobase, u32 ad=
dr)
> +{
> +	iowrite32(b, iobase + addr);
> +	tpm_tis_flush(iobase);
> +}
> +
>  static int interrupts =3D -1;
>  module_param(interrupts, int, 0444);
>  MODULE_PARM_DESC(interrupts, "Enable interrupts");
> @@ -186,12 +225,12 @@ static int tpm_tcg_write_bytes(struct tp
>  	switch (io_mode) {
>  	case TPM_TIS_PHYS_8:
>  		while (len--)
> -			iowrite8(*value++, phy->iobase + addr);
> +			tpm_tis_iowrite8(*value++, phy->iobase, addr);
>  		break;
>  	case TPM_TIS_PHYS_16:
>  		return -EINVAL;
>  	case TPM_TIS_PHYS_32:
> -		iowrite32(le32_to_cpu(*((__le32 *)value)), phy->iobase + addr);
> +		tpm_tis_iowrite32(le32_to_cpu(*((__le32 *)value)), phy->iobase, addr);
>  		break;
>  	}
> =20


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
