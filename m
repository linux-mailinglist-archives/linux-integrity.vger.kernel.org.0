Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B69609683
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Oct 2022 23:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJWV1c (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Oct 2022 17:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJWV11 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Oct 2022 17:27:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6008266F2D
        for <linux-integrity@vger.kernel.org>; Sun, 23 Oct 2022 14:27:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13FF1B80DCE
        for <linux-integrity@vger.kernel.org>; Sun, 23 Oct 2022 21:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D2FC433B5;
        Sun, 23 Oct 2022 21:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666560443;
        bh=4V0hOIBLog/JEv5WsOgqIaQjdSUS3u1YzkMdoP0dYS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WEe04/adwm2P1EZ+/q0QFRxkGgGek+GaHHIANvqK4TzTQp+tE5BK0RDYHN0daWeDC
         Ecx2IRNbkXtYbGHBZSeAhu9AWQGwTOkUoK0W4JER03tJRI6VbsN1mHbhcHbVcSmONn
         aXLhr9unEskSQ2OY6LihOnEHMoP3Smzaj0+idphRp1GRVbksUZb+cfB3itpy4nzQyl
         pPhilyWSrHBG9TO0v2v410zRsZ+gCvupnpCXzqTt88yITOpjzBTlxAtL07FciLPZTC
         0oyGFvy1kx3RrUEoFO12/V+aeJWO+/bOw7T/RitqOfLaHw7Y2R+JXJ9oVRpiSBeMe9
         di4DYsAic5B7g==
Date:   Mon, 24 Oct 2022 00:27:16 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     peterhuewe@gmx.de, linux-integrity@vger.kernel.org, jgg@ziepe.ca,
        keescook@chromium.org, samitolvanen@google.com
Subject: Re: [PATCH] tpm: Avoid function type cast of put_device()
Message-ID: <Y1WxtIjnJvX0jAk1@kernel.org>
References: <20221021123309.2770740-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021123309.2770740-1-ardb@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 21, 2022 at 02:33:09PM +0200, Ard Biesheuvel wrote:
> The TPM code registers put_device() as a devm cleanup handler, and casts
> the reference to the right function pointer type for this to be
> permitted by the compiler.
> 
> However, under kCFI, this is rejected at runtime, resulting in a splat
> like
> 
>    CFI failure at devm_action_release+0x24/0x3c (target: put_device+0x0/0x24; expected type: 0xa488ebfc)
>    Internal error: Oops - CFI: 0000000000000000 [#1] PREEMPT SMP
>    Modules linked in:  ...
>    CPU: 20 PID: 454 Comm: systemd-udevd Not tainted 6.1.0-rc1+ #51
>    Hardware name: Socionext SynQuacer E-series DeveloperBox, BIOS build #1 Oct  3 2022
>    pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>    pc : devm_action_release+0x24/0x3c
>    lr : devres_release_all+0xb4/0x114
>    sp : ffff800009bb3630
>    x29: ffff800009bb3630 x28: 0000000000000000 x27: 0000000000000011
>    x26: ffffaa6f9922c0c8 x25: 0000000000000002 x24: 000000000000000f
>    x23: ffff800009bb3648 x22: ffff7aefc3be2100 x21: ffff7aefc3be2e00
>    x20: 0000000000000005 x19: ffff7aefc1e1ec10 x18: ffff800009af70a8
>    x17: 00000000a488ebfc x16: 0000000094ee7df3 x15: 0000000000000000
>    x14: 4075c5c2ef7affff x13: e46a91c5c5e2ef42 x12: ffff7aefc2c57540
>    x11: 0000000000000001 x10: 0000000000000001 x9 : 0000000100000000
>    x8 : ffffaa6fa09b39b4 x7 : 7f7f7f7f7f7f7f7f x6 : 8000000000000000
>    x5 : 000000008020000e x4 : ffff7aefc2c57500 x3 : ffff800009bb3648
>    x2 : ffff800009bb3648 x1 : ffff7aefc3be2e80 x0 : ffff7aefc3bb7000
>    Call trace:
>     devm_action_release+0x24/0x3c
>     devres_release_all+0xb4/0x114
>     really_probe+0xb0/0x49c
>     __driver_probe_device+0x114/0x180
>     driver_probe_device+0x48/0x1ec
>     __driver_attach+0x118/0x284
>     bus_for_each_dev+0x94/0xe4
>     driver_attach+0x24/0x34
>     bus_add_driver+0x10c/0x220
>     driver_register+0x78/0x118
>     __platform_driver_register+0x24/0x34
>     init_module+0x20/0xfe4 [tpm_tis_synquacer]
>     do_one_initcall+0xd4/0x248
>     do_init_module+0x44/0x28c
>     load_module+0x16b4/0x1920
> 
> Fix this by going through a helper function of the correct type.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/char/tpm/tpm-chip.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 783d65fc71f0..741d8f3e8fb3 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -373,6 +373,11 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>  }
>  EXPORT_SYMBOL_GPL(tpm_chip_alloc);
>  
> +static void tpm_put_device(void *dev)
> +{
> +	put_device(dev);
> +}
> +
>  /**
>   * tpmm_chip_alloc() - allocate a new struct tpm_chip instance
>   * @pdev: parent device to which the chip is associated
> @@ -391,7 +396,7 @@ struct tpm_chip *tpmm_chip_alloc(struct device *pdev,
>  		return chip;
>  
>  	rc = devm_add_action_or_reset(pdev,
> -				      (void (*)(void *)) put_device,
> +				      tpm_put_device,
>  				      &chip->dev);
>  	if (rc)
>  		return ERR_PTR(rc);
> -- 
> 2.35.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
