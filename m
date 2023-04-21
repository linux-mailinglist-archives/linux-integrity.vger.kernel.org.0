Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C8B6EB3DA
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Apr 2023 23:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjDUVrD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Apr 2023 17:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjDUVrC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Apr 2023 17:47:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BEA2711;
        Fri, 21 Apr 2023 14:46:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4961865320;
        Fri, 21 Apr 2023 21:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1B8C433EF;
        Fri, 21 Apr 2023 21:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682113603;
        bh=5jZwlULWqJhakp+S5Nl0zzDSo4Z6CykzB8eI1k6/BNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gnG78z7mO2C4SYKcQq2mzT/YZ41s1HkB8wHNEPPUJT+gYmzDQ/4prZJWuQQw0kOKT
         bB8eaHH1kpWXXRLoZ+S1imnUPN59z7QHF7JBUsglcI6mQEZOVxVb4Cv7S/KeX8n7Zi
         S8//55Y8R3O4fGHL+/Pa5HBL6Ozn4Ir+opHt3b4wMTzD07Y9WomZOo4DjhpHaRad3D
         EkmKw/K/O7MSMYBtqBKFwe1x5EeVrZue0/5HxuxymjJtbdN6Rv7PvkGoFnxqx7/sKF
         Hl03If35y7x1V7BKdsKGr0TChqIWIewbog0KGzdi5zyXoGfmx5TXG+hXkUJLJXsG51
         UBJ+SswiKPAWA==
Date:   Sat, 22 Apr 2023 00:46:40 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     shaopeijie@cestc.cn
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_spi: fix:release chip select when flow control
 fails
Message-ID: <ZEMEQE4Cym+A4XTG@kernel.org>
References: <20230331065625.1977-1-shaopeijie@cestc.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331065625.1977-1-shaopeijie@cestc.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 31, 2023 at 02:56:25PM +0800, shaopeijie@cestc.cn wrote:
> From: Peijie Shao <shaopeijie@cestc.cn>
> 
> The TPM's chip select will leave active after spi_bus_unlock when
> flow control timeout, and may interfere other chips sharing the same
> spi bus, or may damage them dule to level conflict on MISO pin.
> 
> So the patch deactives the chip select by sending an empty message
> with cs_change=0 if flow control fails.
> 
> The reason why flow control timeout for me is unfortunately I got a
> damaged TPM chip. It always pull MISO low during cs active(this can
> be easily emulated by wire MISO to the ground), not responding anything,
> and dmesg shows below:
> ...
> [   311.150725] tpm_tis_spi: probe of spi0.0 failed with error -110
> ...

We don't really cease to support damaged hardware but it is true
that the *software* failure paths should probably be robust enough
to deativate chip select.

I would rewrite this as

"The failure paths in tpm_tis_spi_transfer() do not deactivate
chip select. Send an empty message (cs_select == 0) to overcome
this."

That's all there needs to be. We do not care about broken hardware.

> 
> Signed-off-by: Peijie Shao <shaopeijie@cestc.cn>
> ---
>  drivers/char/tpm/tpm_tis_spi_main.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> index a0963a3e92bd..5c8ff343761f 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -105,8 +105,19 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
>  		/* Flow control transfers are receive only */
>  		spi_xfer.tx_buf = NULL;
>  		ret = phy->flow_control(phy, &spi_xfer);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			/*
> +			 * Release cs pin if the device is not responding, regardless of the reason.
> +			 * Notice cs may alreadly been released if the failure was caused inside
> +			 * spi_sync_locked called by flow_control, in this situation, a pluse may be
> +			 * generated on cs.
> +			 */

Please replace above comment with:

/* Deactivate chip select: */

> +			memset(&spi_xfer, 0, sizeof(spi_xfer));
> +			spi_message_init(&m);
> +			spi_message_add_tail(&spi_xfer, &m);
> +			spi_sync_locked(phy->spi_device, &m);
>  			goto exit;
> +		}
>  
>  		spi_xfer.cs_change = 0;
>  		spi_xfer.len = transfer_len;
> -- 
> 2.39.1
> 
> 
> 

There's three call sites, why are you taking care of only one
of them?

I'd consider instead:

        return 0;

exit:
        memset(&spi_xfer, 0, sizeof(spi_xfer));
        spi_message_init(&m);
        spi_message_add_tail(&spi_xfer, &m);
        spi_sync_locked(phy->spi_device, &m);
        spi_bus_unlock(phy->spi_device->master);
        return ret;
}

The the rollback would apply to all call sites.

BR, Jarkko
