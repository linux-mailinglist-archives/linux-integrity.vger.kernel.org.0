Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90ED3D6C66
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 05:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhG0CdJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 22:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234422AbhG0CdI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 22:33:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1BFA60FF4;
        Tue, 27 Jul 2021 03:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627355616;
        bh=rxF7tCHB9BWWgtZE7ZsRj6KwO23LT1NvPOh3g54E7I0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJNYOL4qmaTvF/wNCMGsv8C++CNdDA0hw9G6AEZrL9jdYPgKFnptkeiYBgV+oZKNm
         ci9bAI59vYBMSUzYd5ElJFGDShjDoT/jYhrI/UFyBnN6U52JpodPhKbCr3BfeBF0kl
         N0VtAkfqZ5JT5TQ8z4OH7UVO+9plZViufDaZiFnbxULkMgJru2oep3oJSTB+XuXsF9
         lVCeYPdpOyuoq8DKakIhdBitw9mkVLUiDgExTb8EnAvs8+iuFdn5iSXOBaoh0alVSQ
         jsgymJ9/jxIJ6khHOGU0o7/kFx+et3fKqMOQ8lF1l1Yaayj2MuTbo8Q6V/3oyijwBW
         9Y3oXr+KkOgkQ==
Date:   Tue, 27 Jul 2021 06:13:33 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] security: keys: trusted: Fix memory leaks on
 allocated blob
Message-ID: <20210727031333.dozrxrjs4p5uzmrb@kernel.org>
References: <20210726114431.18042-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726114431.18042-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 26, 2021 at 12:44:31PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are several error return paths that don't kfree the allocated
> blob, leading to memory leaks. Ensure blob is initialized to null as
> some of the error return paths in function tpm2_key_decode do not
> change blob. Add an error return path to kfree blob and use this on
> the current leaky returns.
> 
> Addresses-Coverity: ("Resource leak")
> Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> ---
> 
> V2: Add a couple more leaky return path fixes as noted by Sumit Garg
>     Add the if (blob != payload->blob) check on the kfree as
>     noted by Dan Carpenter
> 
> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 39 ++++++++++++++++-------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 0165da386289..a2cfdfdf17fa 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -366,7 +366,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  	unsigned int private_len;
>  	unsigned int public_len;
>  	unsigned int blob_len;
> -	u8 *blob, *pub;
> +	u8 *blob = NULL, *pub;
>  	int rc;
>  	u32 attrs;
>  
> @@ -378,22 +378,30 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  	}
>  
>  	/* new format carries keyhandle but old format doesn't */
> -	if (!options->keyhandle)
> -		return -EINVAL;
> +	if (!options->keyhandle) {
> +		rc = -EINVAL;
> +		goto err;
> +	}
>  
>  	/* must be big enough for at least the two be16 size counts */
> -	if (payload->blob_len < 4)
> -		return -EINVAL;
> +	if (payload->blob_len < 4) {
> +		rc = -EINVAL;
> +		goto err;
> +	}
>  
>  	private_len = get_unaligned_be16(blob);
>  
>  	/* must be big enough for following public_len */
> -	if (private_len + 2 + 2 > (payload->blob_len))
> -		return -E2BIG;
> +	if (private_len + 2 + 2 > (payload->blob_len)) {
> +		rc = -E2BIG;
> +		goto err;
> +	}
>  
>  	public_len = get_unaligned_be16(blob + 2 + private_len);
> -	if (private_len + 2 + public_len + 2 > payload->blob_len)
> -		return -E2BIG;
> +	if (private_len + 2 + public_len + 2 > payload->blob_len) {
> +		rc = -E2BIG;
> +		goto err;
> +	}
>  
>  	pub = blob + 2 + private_len + 2;
>  	/* key attributes are always at offset 4 */
> @@ -406,12 +414,14 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  		payload->migratable = 1;
>  
>  	blob_len = private_len + public_len + 4;
> -	if (blob_len > payload->blob_len)
> -		return -E2BIG;
> +	if (blob_len > payload->blob_len) {
> +		rc = -E2BIG;
> +		goto err;
> +	}
>  
>  	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
>  	if (rc)
> -		return rc;
> +		goto err;
>  
>  	tpm_buf_append_u32(&buf, options->keyhandle);
>  	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
> @@ -441,6 +451,11 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  		rc = -EPERM;
>  
>  	return rc;
> +
> +err:
> +	if (blob != payload->blob)
> +		kfree(blob);
> +	return rc;
>  }
>  
>  /**
> -- 
> 2.31.1
> 
> 

Just denoting that I saw this, so just response to my other email,
and I'll use this one.

/Jarkko
