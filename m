Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F322749CC7F
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 15:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242237AbiAZOiz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 09:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242117AbiAZOiy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 09:38:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0B6C06161C;
        Wed, 26 Jan 2022 06:38:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09350617AE;
        Wed, 26 Jan 2022 14:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB43AC340E3;
        Wed, 26 Jan 2022 14:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643207932;
        bh=KSC8mIqfcnBcTC8Z3ucooyb2sQ/gcATsBmj9OuXoO6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQ0hJ+gnswrZLFnwodrrUkhqZOvhGhwcRDbO9/fT4bP8/BUtJAckhbSXdO28pVoJA
         xYpL2Fn+ORooIzvw9TUQuxN0/2FFIiXTmFTRBfQ9l5wINVJcZeFARmiIHZrM3h0QL0
         lqlYqXUw6ChPWiZ4VBkBFBpsBRWExgDHBMYrHO9G+RTz1u3WLZIG70OxzWoDSLZg24
         cL4JqSdaf2yh8Vz3n5RJvQo3GIsvpq25SPV5DqIL7ciZD6S8rW6dE5WipL+gjc97J/
         rgqSA0/dNA7tZE/tnLiboai+eoNK3hsi7MwH5c8YCYmZ7o1mGCErSaWDq1rjP3FPnm
         ygz77W5PjcloQ==
Date:   Wed, 26 Jan 2022 16:38:32 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] tpm: xen-tpmfront: Use struct_size() helper
Message-ID: <YfFc6Im+WmFFi7XI@iki.fi>
References: <20220119233803.GA66829@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119233803.GA66829@embeddedor>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 19, 2022 at 05:38:03PM -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worse scenario, could lead to heap overflows.
> 
> Also, address the following sparse warning:
> drivers/char/tpm/xen-tpmfront.c:131:16: warning: using sizeof on a flexible structure
> 
> Link: https://github.com/KSPP/linux/issues/160
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/char/tpm/xen-tpmfront.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
> index da5b30771418..f53e0cf1ec7e 100644
> --- a/drivers/char/tpm/xen-tpmfront.c
> +++ b/drivers/char/tpm/xen-tpmfront.c
> @@ -126,16 +126,16 @@ static void vtpm_cancel(struct tpm_chip *chip)
>  	notify_remote_via_evtchn(priv->evtchn);
>  }
>  
> -static unsigned int shr_data_offset(struct vtpm_shared_page *shr)
> +static size_t shr_data_offset(struct vtpm_shared_page *shr)
>  {
> -	return sizeof(*shr) + sizeof(u32) * shr->nr_extra_pages;
> +	return struct_size(shr, extra_pages, shr->nr_extra_pages);
>  }
>  
>  static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>  {
>  	struct tpm_private *priv = dev_get_drvdata(&chip->dev);
>  	struct vtpm_shared_page *shr = priv->shr;
> -	unsigned int offset = shr_data_offset(shr);
> +	size_t offset = shr_data_offset(shr);
>  
>  	u32 ordinal;
>  	unsigned long duration;
> @@ -177,7 +177,7 @@ static int vtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>  {
>  	struct tpm_private *priv = dev_get_drvdata(&chip->dev);
>  	struct vtpm_shared_page *shr = priv->shr;
> -	unsigned int offset = shr_data_offset(shr);
> +	size_t offset = shr_data_offset(shr);
>  	size_t length = shr->length;
>  
>  	if (shr->state == VTPM_STATE_IDLE)
> -- 
> 2.27.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
