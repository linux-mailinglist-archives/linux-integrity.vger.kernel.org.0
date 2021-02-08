Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5C13128A2
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Feb 2021 01:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhBHAly (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Feb 2021 19:41:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:43242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhBHAlx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Feb 2021 19:41:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEA0464E37;
        Mon,  8 Feb 2021 00:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612744873;
        bh=pawCFFNuxieuedqkeD8rhslUdcJnXnMbNF7lCMg+Kfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MxgnLAxnhDXpzhWuQaK2mYbkiLgAU9GALMHEpqZMz362Ji/YjF8X5QaYvQmCWHLvH
         3jAeohdTQM6HDI8Y+NccKCsLhPG2uRtTish8xOzip7v+ySqaVNL/AwDS4MRnGGOouq
         vBAkzjLQ1AzSbSm78rm16Hjf/WDJ5mNhXjrKEXdJbTZkskVQao+GMM24R1kF/mSwGM
         I7Xeqk7L3uWvICRuI31uBiNlyT6j0q1BhegwWs/IHCKnLrm4VU9rlPpbwjBQQZbp8s
         ABeJJZrhNIDYzExLg//3iNTx0eUpMyqrvxCG+/Kk08siW+MD90ogCuZYYwyEb/sSzx
         lY+hAL+lX/5Ow==
Date:   Mon, 8 Feb 2021 02:41:04 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dirk Gouders <dirk@gouders.net>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tpm_tis: handle -EPROBE_DEFER in tpm_tis_plat_probe()
Message-ID: <YCCIoDc70hHIL6KK@kernel.org>
References: <20210205202022.4515-1-dirk@gouders.net>
 <20210205202022.4515-2-dirk@gouders.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205202022.4515-2-dirk@gouders.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 05, 2021 at 09:20:22PM +0100, Dirk Gouders wrote:
> tpm_tis does not consider -EPROBE_DEFER in tpm_tis_plat_probe().
> Instead, without notification it falls back to polling mode if
> platform_get_irq_optional() returns a negative value.
> 
> This could lead to different behavior depending on wether tpm_tis was
> compiled builtin or as a module; in the latter case
> platform_get_irq_optional() often if not always returns a valid IRQ
> number on the first attempt.
> 
> Harmonize builtin and module behavior by returning -EPROBE_DEFER,
> effectively putting the device on the deferred probe list for later
> probe attempts.
> 
> Signed-off-by: Dirk Gouders <dirk@gouders.net>

This would be best picked to James' patch set.

> ---
>  drivers/char/tpm/tpm_tis.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 4ed6e660273a..4cf863704aa1 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -320,6 +320,9 @@ static int tpm_tis_plat_probe(struct platform_device *pdev)
>  
>  	tpm_info.irq = platform_get_irq_optional(pdev, 0);
>  	if (tpm_info.irq <= 0) {
> +                if (tpm_info.irq == -EPROBE_DEFER)
> +                        /* Enter deferred probe list and try again, later. */
> +                        return -EPROBE_DEFER;
>  		if (pdev != force_pdev)
>  			tpm_info.irq = -1;
>  		else
> -- 
> 2.26.2
> 
> 

/Jarkko
