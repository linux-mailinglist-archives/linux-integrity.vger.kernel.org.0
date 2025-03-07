Return-Path: <linux-integrity+bounces-5179-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0854EA56DE8
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 17:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E606189A297
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 16:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8698023ED40;
	Fri,  7 Mar 2025 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIU1ZcPm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F93923CEF0;
	Fri,  7 Mar 2025 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365291; cv=none; b=Lbnd5NRTjI+iPi7iylFEBCBFXeAiza/eQ+z2IocPAgnFsxHSD6AIaSP/3ZNRWsmbypDgsecRMaKtpPCgEwk8egzgr7D1S7cU8j+6/aloDktEQM4dI4C4pZwsezN8h7E1GI+Ei6/VvLhe+wdaVPA1dl9KUsmFc0dI6FSdTOVNxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365291; c=relaxed/simple;
	bh=If886+JVZBilI2kacdlFEGkRIp2aU1ionJknP08oaYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9pIdKnstCIkKnMAHIbEkeNqd/r+e3r9GBO2dhFO49NQ3zqKByHsHqhL6uW5sAGgUK3iJDd6MAO7pSg6YuREKZHzk2GIBjmpjhER1JHQqr27R6MIJOeH0AJ7f5Tz9WeBH4kAQNV4gSBfv+ZHZEGX/Olbczh6fGgafnxteTEW2Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIU1ZcPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524E9C4CED1;
	Fri,  7 Mar 2025 16:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741365290;
	bh=If886+JVZBilI2kacdlFEGkRIp2aU1ionJknP08oaYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aIU1ZcPmFyb57johNW5qsFal3/gTqNAK5IirltrmPYNUHv6mHWvAB/z66T3JdAdTi
	 7zWL1IfPqAbm33lYcFo8WIL2qdjhy6RO3+APQKcZ9nA+fLbO/+k74kobcpduPnjcF4
	 lBqK2C6TEeWaePbif3aa2+tzlhvvE08+WRySy+P2tTQRZZbd0A4xhu8qYWDsiN1hGJ
	 Eo6xOeqgisL7yhtPdglMZkcOsBHVN8vNlzmXu0RY9AJP5Nb+LS3Bk9A7DR/vSgB1yn
	 bRUZYMqea1djtuj9G5qtPutt/g722LZQhMDUuHECeUeDIz5+CL1vokdJnwNQTj1zO1
	 URfeJYqhNq9VQ==
Date: Fri, 7 Mar 2025 18:34:46 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Lazily flush auth session when getting random data
Message-ID: <Z8sgJl7UZLpmwpp8@kernel.org>
References: <Z8m8G0RfiRyYGH_t@earth.li>
 <Z8oV9lJ4hsHualcP@kernel.org>
 <Z8rRRdwlI6JW8RWF@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8rRRdwlI6JW8RWF@earth.li>

On Fri, Mar 07, 2025 at 10:58:13AM +0000, Jonathan McDowell wrote:
> From: Jonathan McDowell <noodles@meta.com>
> 
> Lazy flushing of TPM auth sessions was introduced to speed up IMA
> measurments into the TPM. Make use of it in tpm2_get_random as well,
> which has the added benefit of not needlessly cleaning up the session
> that IMA is using when there are no userspace accesses taking place.
> 
> Command trace before for every call:
> 
> hwrng (0x00000161): 14 (52965242 ns)
> hwrng (0x00000176): 48 (161612432 ns)
> hwrng (0x00000165): 10 (2410494 ns)
> hwrng (0x0000017B): 117 (70699883 ns)
> hwrng (0x0000017B): 117 (70959666 ns)
> hwrng (0x00000165): 10 (2756827 ns)
> 
> After, with repeated calls showing no setup:
> 
> hwrng (0x00000161): 14 (53044582 ns)
> hwrng (0x00000176): 48 (160491333 ns)
> hwrng (0x00000165): 10 (2408220 ns)
> hwrng (0x0000017B): 117 (70695037 ns)
> hwrng (0x0000017B): 117 (70994984 ns)
> hwrng (0x0000017B): 117 (70195388 ns)
> hwrng (0x0000017B): 117 (70973835 ns)
> 
> Signed-off-by: Jonathan McDowell <noodles@meta.com>
> ---
>  drivers/char/tpm/tpm2-cmd.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index dfdcbd009720..524d802ede26 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -359,7 +359,6 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>  	} while (retries-- && total < max);
>  
>  	tpm_buf_destroy(&buf);
> -	tpm2_end_auth_session(chip);
>  
>  	return total ? total : -EIO;
>  out:
> -- 
> 2.48.1
> 

Thanks for this. It is a good catch! I'll apply this over the weekend
when I apply Arm FF-A driver patches.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

