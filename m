Return-Path: <linux-integrity+bounces-5151-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90F7A55A00
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 23:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295011896974
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 22:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CCE27CB0C;
	Thu,  6 Mar 2025 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdMdDC+T"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B86D1F4185;
	Thu,  6 Mar 2025 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741300942; cv=none; b=JLLOL4iiSNTcfjC8q4ehaY+ybtQEmCpE/Zwqh1Uf3kjSCM/SMBwlPpU5E26mfwP5YK1I0M+4T3r8dWmmAE9dBGeJPv6juzpieGHFPs/cdRKkO4Ia+IKTLlE5IeJcG7plRbRlGgM8cuLv2+xLlFbMR+x70ocJykWtXJYMelxDGfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741300942; c=relaxed/simple;
	bh=x5hBWxXl1ixfuMYseUlWPl12G3fpAxDaCHfha8AZWJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEkPzyW1MyyTx84EnDexG0HzzH8zQ3vo7UvasKlPqi3IhJH4ELER47gNqFjOd6xJCuAbosffth4r5dmqlsHjvk22rDgnOYqn3wxjEOcO3nLTwRnzZKXi1j2zreWLTQ6On4m461U0AFb4S/Dn6TUatdD3o22YYuzYkC9VgGZcXeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdMdDC+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F162C4CEE0;
	Thu,  6 Mar 2025 22:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741300941;
	bh=x5hBWxXl1ixfuMYseUlWPl12G3fpAxDaCHfha8AZWJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sdMdDC+TiO0FRB2A4yrHllcfVSW4h6oE6VoiZdw7Y5zEgBmIa+a6hUslZVMsbouBC
	 rWpEe2yfvyhHqS+TfJWSzHPRMKXJ2Hg+2xb8OUGvlTCFKvYdWO8SirlNun0TG58h+h
	 OMt9PQL4jdIVFvtq5LX+VOz0LOPYBv0WvDTvE2ukkQUgX13nCKNnTEzCUpdcV8IjXw
	 4t2KYxcfHWmQJoVAG8mpEsQjPePpyZ11r5n9BweGXBOVioG6egFYgGowVpAfWfpQ8C
	 3arpZDdBFcuMjTvCYjArWBjpxMMes8OQf0HlFAPT0UQSs0kXZlZ3jx3/xd2EW5m3Ft
	 4fkqJ0nr9iGRw==
Date: Fri, 7 Mar 2025 00:42:17 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm, tpm_tis: Fix timeout handling when waiting for TPM
 status
Message-ID: <Z8okyZetPHrzkwHV@kernel.org>
References: <Z8gdKxsw2unC5UID@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8gdKxsw2unC5UID@earth.li>

On Wed, Mar 05, 2025 at 09:45:15AM +0000, Jonathan McDowell wrote:
> From: Jonathan McDowell <noodles@meta.com>
> 
> The change to only use interrupts to handle supported status changes,
> then switch to polling for the rest, inverted the status test and sleep
> such that we can end up sleeping beyond our timeout and not actually
> checking the status. This can result in spurious TPM timeouts,

I *really* have hard time understanding what I'm reading the first
sentence *but* I do understand the code change. Maybe you could try
to be a bit more punctual there...

> especially on a more loaded system. Fix by switching the order back so
> we sleep *then* check. We've done a up front check when we enter the
> function so this won't cause an additional delay when the status is
> already what we're looking for.

Remove the use of we-pronoun: it is best for science papers. Also, e.g.
why not just say "switch" instead of "fix by switching" ? :-)

I'd rewrite this tail part like:

"Switch the order back where it was i.e., sleep before check."

Instead of "upfront check" it'd nice to be a bit more specific...

> 
> Cc: stable@vger.kernel.org # v6.4+
> Fixes: e87fcf0dc2b4 ("tpm, tpm_tis: Only handle supported interrupts")
> Signed-off-by: Jonathan McDowell <noodles@meta.com>
> Reviewed-by: Michal Suchánek <msuchanek@suse.de>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index fdef214b9f6b..167d71747666 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -114,11 +114,11 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>  		return 0;
>  	/* process status changes without irq support */
>  	do {
> +		usleep_range(priv->timeout_min,
> +			     priv->timeout_max);
>  		status = chip->ops->status(chip);
>  		if ((status & mask) == mask)
>  			return 0;
> -		usleep_range(priv->timeout_min,
> -			     priv->timeout_max);
>  	} while (time_before(jiffies, stop));
>  	return -ETIME;
>  }
> -- 
> 2.48.1
> 
> 

The fix itself looks legit although you could just as well put it into a
single line.

BR, Jarkko

