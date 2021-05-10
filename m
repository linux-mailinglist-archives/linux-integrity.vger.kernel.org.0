Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E500379676
	for <lists+linux-integrity@lfdr.de>; Mon, 10 May 2021 19:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbhEJRw3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 May 2021 13:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231786AbhEJRw1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 May 2021 13:52:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6D78601FA;
        Mon, 10 May 2021 17:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620669082;
        bh=+hf11QRJVdEDxS2uQZBcnMSOoYiIW5DRA7C7sdWiZms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tEnSGp0WxjqIbYc+r7mgkHg3XHDUs1yVcyjlfiAk7SyuHLljHFHirPn/J9Ybt9DTu
         +9yuBuOYnj3VSFQ0Upxaio+j9av9hf2wPcJCbGkRDr3A5rTIh3zbuWndmLTqYHyUjF
         0cbXgzXjL0khBsR3mf65T3ZShw7ouAn5rWxNYpEB6LUACy8tW1fyoiDH3jD/+I/qVb
         jdYVhaEEtgAHnWV2oSNYIGbSxYqvP8RQky1CL9kqhlBwSHj+aMZanX08QwGkD2KvtH
         s7j0WaqaPpVFLva6g0Snl4gOZoG+KfpgL48Li00HxA9XGuTeqslEynaRci6mVPikJn
         iQGl210y0ILrA==
Date:   Mon, 10 May 2021 20:51:19 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        peterhuewe@gmx.de, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hager@nuvoton.com,
        amir.mizinski@nuvoton.com
Subject: Re: [PATCH v1] tpm2: add longer timeout for verify signature command
Message-ID: <YJlyl+Eie/+G3l4S@kernel.org>
References: <20210510142719.48153-1-amirmizi6@gmail.com>
 <20210510142719.48153-2-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510142719.48153-2-amirmizi6@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 10, 2021 at 05:27:19PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> TPM2_CC_VERIFY_SIGNATURE(0x177) Current timeout does not apply to usage with
> RSA 3070-bit keys.

I don't understand what this sentence means.

Better excuse for making the whole change would be to:

1. If possible put a snippet of the klog transcript what happens to you.
2. You probably want rationalize this change for the reason that, since the
   TPM PC Client specification does not specify any specific number, and
   you have a corner case to show, it's best to pick the longest timeout,
   i.e. TPM_LONG_LONG.

> Additional time may be required for usage with RSA 3070-bit keys. Therefore, the
> timeout of TPM2_CC_VERIFY_SIGNATURE is set to 3 minutes (TPM_LONG_LONG).
> 
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>

Please, re-phrase : "Set duration for TPM2_CC_VERIFY_SIGNATUE to
TPM_LONG_LONG (3 minutes)".  Imperative way to express things is always
better, and "timeout" is a concept of its own, separate from "duration" in
TPM jargon.

> ---
>  drivers/char/tpm/tpm2-cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index eff1f12..235a454 100644
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

The commit message needs rework because now it makes no sense. With the
correct rationalization this probably would make sense.

/Jarkko
