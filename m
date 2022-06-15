Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47DE54D0E5
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jun 2022 20:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbiFOS1k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 14:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242474AbiFOS1j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 14:27:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F73311C23;
        Wed, 15 Jun 2022 11:27:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C137ACE1F96;
        Wed, 15 Jun 2022 18:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A19C34115;
        Wed, 15 Jun 2022 18:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655317653;
        bh=Am7c4bFgivyhoxr0ca8K1YRqNfaQDlprc2E2R2wk02E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rbhX5VTydlxca9LUO0mU0uKnGjonLFHNZ+bxFxI0TDOYYaTwlLk43y1lWrPiuWkFA
         CL+3JL+LI+XDw8q8RKfoDCFIzBWIkYvEsaOPv/Ck/pYiG0ZrGrJWB4NLpY49EMEM4K
         XWP6pl5H7IbHM/qifSIksopmUyqRthgTk0yfTH+jQGu/NtQe8GGUNRiuZZpWX3gdH4
         ElZbK/yrP2QwWLIxxPukQQXwHBl7ImHpdTOWCnDymEXtE/V3Y6KRtti472+P/tjLUG
         XiKlG6smxzsN+sw0p1qQJLAK1HVQ9wEy/z5b3Tfw/IiJzyLlbe6J2fOIuP/JDM1Xtc
         IRG3942fpSupQ==
Date:   Wed, 15 Jun 2022 21:25:24 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     LinoSanfilippo@gmx.de
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v5 09/10] tpm, tpm_tis: Claim locality in interrupt
 handler
Message-ID: <YqokFNUsB4f5mgRG@iki.fi>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
 <20220610110846.8307-10-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610110846.8307-10-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 10, 2022 at 01:08:45PM +0200, LinoSanfilippo@gmx.de wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Writing the TPM_INT_STATUS register in the interrupt handler to clear the
> interrupts only has effect if a locality is held. Since this is not
> guaranteed at the time the interrupt is fired, claim the locality
> explicitly in the handler.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 8b5aa4fdbe92..e5edf745fb23 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -753,7 +753,9 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>  		wake_up_interruptible(&priv->int_queue);
>  
>  	/* Clear interrupts handled with TPM_EOI */
> +	request_locality(chip, 0);
>  	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), interrupt);
> +	release_locality(chip, 0);
>  	if (rc < 0)
>  		return IRQ_NONE;
>  
> -- 
> 2.36.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
