Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2790438F4E1
	for <lists+linux-integrity@lfdr.de>; Mon, 24 May 2021 23:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhEXVbA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 May 2021 17:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhEXVa7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 May 2021 17:30:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB0B86140F;
        Mon, 24 May 2021 21:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621891771;
        bh=YCmkIaqHTR970MFQyLTDzqmvo4gnfjhbcmJUTyb9VcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ojmJJ2zet/895B7ORw0FIcmOYmjkUbLkKqx1Fbzr393liPXRUoIodwKICJK1n2nN3
         U1uoPTBqpUuVcO2rKide9ujl0sWrN1+JRbVeA4NLgVVQWxkz/W3mKZRDwF7dIdK8n9
         jZnQZ4UfXb9XUNk2ei0JAZUa5mXv1n3IcliiKxUq1nKmTB4t7EJcqAM0g2QekTZr3L
         cJoc0LQWArTWxGOZt/6iCAxDbkbT08U3IoEMLEhKYDgbbiXx3gQA4n7YK+5FqONlpU
         vkCK7ov6MuE9Yn4tLWEuWldWMa31qrJZOgTmaeydJlhhG/a6cAXNWnrsmC7IgCr9HH
         S4I5qKdR4HqXg==
Date:   Tue, 25 May 2021 00:29:28 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Subject: Re: [PATCH v3] tpm2: add longer timeout for verify signature command
Message-ID: <YKwauPYtLlOxKj2N@kernel.org>
References: <20210523153610.86927-1-amirmizi6@gmail.com>
 <20210523153610.86927-2-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210523153610.86927-2-amirmizi6@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, May 23, 2021 at 06:36:10PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> While running a TPM2_CC_VERIFY_SIGNATURE operation with RSA 3072-bit
> keys the TPM driver fails with the following error:
> 
> "kernel: [ 2416.187522] tpm tpm0: Operation Timed out"
> 
> Since the TPM PC Client specification does not specify a number for
> verify signature operation timeout, and the duration of
> TPM2_CC_VERIFY_SIGNATURE with RSA 3070-bit keys exceeds the current timeout
> of TPM_LONG (2 seconds), it is preferable to pick the longest timeout
> possible.
> 
> Therefore, set the duration for TPM2_CC_VERIFY_SIGNATUE to TPM_LONG_LONG
> (5 minutes).
> 
> link: https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/
> 

Link should be with capital letter and there should not be an empty line
before sob.

> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> ---
>  drivers/char/tpm/tpm2-cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 7603295..e71154b 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -87,7 +87,7 @@ static u8 tpm2_ordinal_duration_index(u32 ordinal)
>  		return TPM_MEDIUM;
>  
>  	case TPM2_CC_VERIFY_SIGNATURE:        /* 177 */
> -		return TPM_LONG;
> +		return TPM_LONG_LONG;
>  
>  	case TPM2_CC_PCR_EXTEND:              /* 182 */
>  		return TPM_MEDIUM;
> -- 
> 2.7.4
> 
> 

/Jarkko
