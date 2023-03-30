Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4915C6CF836
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Mar 2023 02:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjC3AZk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Mar 2023 20:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC3AZk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Mar 2023 20:25:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8F21FED
        for <linux-integrity@vger.kernel.org>; Wed, 29 Mar 2023 17:25:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CBB761EA4
        for <linux-integrity@vger.kernel.org>; Thu, 30 Mar 2023 00:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF3CC433D2;
        Thu, 30 Mar 2023 00:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680135937;
        bh=25ZJMrTw3QsyGmG3wewPCga8phpYFesiLGZ3PD69QF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hcovzbTiSErnEjZeWz28BiwFnJ9k+G/5VRFWqyPxwnuzlvY5tAxsFnOqVsSqvN3JX
         pjFg/4i2W5xlGq6OaLfUyRGoNzhEg7v9IuRf7vG+OA/9F1JQjcRjO0+DUNAAmt3CxS
         e0MIaM8hy4lxTDSerRrSBvYfAEcibgZEznCFuIitoqLW+3raNbPHOfWvO2xnghvYes
         2RXprNqJxxT4j5oLocKYkKHnAE4JSq+f+BjGetJHLEFeqfk5tCCXuXWiGrdBiGxJ5C
         XT/rusT68fnzBr8gIHWnISvF+xRAaovyoXjPxDyYQ6ABBddO8ncufsg13x3dRnaik+
         IDWgXEPkwcANQ==
Date:   Thu, 30 Mar 2023 03:25:34 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-integrity@vger.kernel.org,
        Haris Okanovic <haris.okanovic@ni.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tpm_tis: fix stall after iowrite*()s
Message-ID: <20230330002534.teqpltcmpkdms72t@kernel.org>
References: <20230323153436.B2SATnZV@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323153436.B2SATnZV@linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 23, 2023 at 04:34:36PM +0100, Sebastian Andrzej Siewior wrote:
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
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> I don't know how performance critical this is so that it should be
> restricted to PREEMPT_RT. This has been in RT queue since late 2017 and
> I have no idea how to deal with this differently/ in a more generic way.
> Original thread:
> 	https://lore.kernel.org/20170804215651.29247-1-haris.okanovic@ni.com
> 
>  drivers/char/tpm/tpm_tis.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index ed5dabd3c72d6..513e0d1c349a6 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -50,6 +50,31 @@ static inline struct tpm_tis_tcg_phy *to_tpm_tis_tcg_phy(struct tpm_tis_data *da
>  	return container_of(data, struct tpm_tis_tcg_phy, priv);
>  }
>  
> +#ifdef CONFIG_PREEMPT_RT
> +/*
> + * Flushes previous write operations to chip so that a subsequent
> + * ioread*()s won't stall a CPU.
> + */

I would replace this with:

/*
 * Flush previous write operations with a dummy read operation to the 
 * TPM MMIO base address.
 */

 I think rest of the reasoning would be better place to the functions,
 which are call sites for this helper, and here it would be make more
 sense to explain what it actually does.

> +static inline void tpm_tis_flush(void __iomem *iobase)
> +{
> +	ioread8(iobase + TPM_ACCESS(0));
> +}
> +#else
> +#define tpm_tis_flush(iobase) do { } while (0)
> +#endif
> +
> +static inline void tpm_tis_iowrite8(u8 b, void __iomem *iobase, u32 addr)

/*
 * Write a byte to the TPM MMIO address, and flush the write queue. The
 * flush amortizes the cost of the IO operations, and thus avoids unwanted
 * latency peaks.
 */

> +{
> +	iowrite8(b, iobase + addr);
> +	tpm_tis_flush(iobase);
> +}
> +

/*
 * Write a 32-bit word to the TPM MMIO address, and flush the write queue.
 * The flush amortizes the cost of the IO operations, and thus avoids
 * unwanted latency peaks.
 *

> +static inline void tpm_tis_iowrite32(u32 b, void __iomem *iobase, u32 addr)
> +{
> +	iowrite32(b, iobase + addr);
> +	tpm_tis_flush(iobase);
> +}
> +
>  static int interrupts = -1;
>  module_param(interrupts, int, 0444);
>  MODULE_PARM_DESC(interrupts, "Enable interrupts");
> @@ -186,12 +211,12 @@ static int tpm_tcg_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
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
>  
> -- 
> 2.40.0
> 

Thanks for catching this up. It is a small code change but I think that it
would deserve just a bit more documentation, as it would make sure that the
reasoning you gave is taken into account in the future code reviews.

I think that if you append what I suggested above (you can use your
judgement and edit as you will), it should be sufficient.

BR, Jarkko

BR, Jarkko
