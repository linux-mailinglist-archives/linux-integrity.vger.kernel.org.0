Return-Path: <linux-integrity+bounces-5638-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5296A7DDB1
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 14:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFEAC16F5D4
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 12:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6D0227EBD;
	Mon,  7 Apr 2025 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1D0ZHtp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6784D15382E;
	Mon,  7 Apr 2025 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744029160; cv=none; b=KWAxGg0/+SCMfZ7GazLxmEKZ0LJlW8ewtfscGSTTz23OlnqwgORboDYEBYQFPU9UuyJ2jjo0SeZFHptlhiNsCYz+sr8TRz9M2xyEUqXbWSgLSZrn99rSc5+fC7VOwK0EXODvtnTDJP9tHbTWCgpusdCqDxs4hSnrorQdDN2BBRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744029160; c=relaxed/simple;
	bh=C2hUbIPOqtG04WpoGSHIQr7eWr+HJM7/fdl8jvapedc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAwHJt7DuMxCIyon5asSR7fueBeJowd4tBmk3V45yHUogkwPPEYr1LsuGtJz8qkdXqkRW8aQRa42B7UewWuDEE8FIVaKLN5S9ZVDBrrtXLKW4Rd0qnSUCpjbj3g+uFKgtsOnOtUJ2dIQHwQd+UHHDvtEe3gFrc9mUS3NsM7Dikw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1D0ZHtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA7AC4CEDD;
	Mon,  7 Apr 2025 12:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744029160;
	bh=C2hUbIPOqtG04WpoGSHIQr7eWr+HJM7/fdl8jvapedc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z1D0ZHtpGqv8mh9PT3FG56iuyZCJrHW+vIA1JLwYTMxNIl/9ukZGy7iUTaa7C8XZi
	 r1lxOy7yq2FhMlgElHelPdp5xLQ0oQNiHQBmlXOYj03YicfmI7SQA0zdzR+vmDuswF
	 bzwl6Fs+jmQbpagDmdYBaUPU74Yzd6sc7l4eXYeCSKjvyCLGDfMXa5a3z0xofLWkVw
	 W7+QC3ZIgXkInE6tvLjVD9jjEjNp9mTOZuEc6GGXqUOzdPzBQvOWluntdwHqKbDPdC
	 iPtVgXPDg7BB9t7Hnf/wUR3MNAMVvXRCcOu+si2mU+7qeEHhjTJmAFFT+6a6l/aqnK
	 c5vmdKD19Jcgw==
Date: Mon, 7 Apr 2025 15:32:35 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4] tpm: Mask TPM RC in tpm2_start_auth_session()
Message-ID: <Z_PF4-W2q8OdywN5@kernel.org>
References: <20250407072057.81062-1-jarkko@kernel.org>
 <20250407122806.15400-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407122806.15400-1-jarkko@kernel.org>

On Mon, Apr 07, 2025 at 03:28:05PM +0300, Jarkko Sakkinen wrote:
> tpm2_start_auth_session() does not mask TPM RC correctly from the callers:
> 
> [   28.766528] tpm tpm0: A TPM error (2307) occurred start auth session
> 
> Process TPM RCs inside tpm2_start_auth_session(), and map them to POSIX
> error codes.
> 
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
> Reported-by: Herbert Xu <herbert@gondor.apana.org.au>
> Closes: https://lore.kernel.org/linux-integrity/Z_NgdRHuTKP6JK--@gondor.apana.org.au/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v4:
> - tpm_to_ret()
> v3:
> - rc > 0
> v2:
> - Investigate TPM rc only after destroying tpm_buf.
> ---
>  drivers/char/tpm/tpm2-sessions.c | 20 ++++++--------------
>  include/linux/tpm.h              | 21 +++++++++++++++++++++
>  2 files changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index 3f89635ba5e8..102e099f22c1 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -40,11 +40,6 @@
>   *
>   * These are the usage functions:
>   *
> - * tpm2_start_auth_session() which allocates the opaque auth structure
> - *	and gets a session from the TPM.  This must be called before
> - *	any of the following functions.  The session is protected by a
> - *	session_key which is derived from a random salt value
> - *	encrypted to the NULL seed.
>   * tpm2_end_auth_session() kills the session and frees the resources.
>   *	Under normal operation this function is done by
>   *	tpm_buf_check_hmac_response(), so this is only to be used on
> @@ -963,16 +958,13 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
>  }
>  
>  /**
> - * tpm2_start_auth_session() - create a HMAC authentication session with the TPM
> - * @chip: the TPM chip structure to create the session with
> + * tpm2_start_auth_session() - Create an a HMAC authentication session
> + * @chip:	A TPM chip
>   *
> - * This function loads the NULL seed from its saved context and starts
> - * an authentication session on the null seed, fills in the
> - * @chip->auth structure to contain all the session details necessary
> - * for performing the HMAC, encrypt and decrypt operations and
> - * returns.  The NULL seed is flushed before this function returns.
> + * Loads the ephemeral key (null seed), and starts an HMAC authenticated
> + * session. The null seed is flushed before the return.
>   *
> - * Return: zero on success or actual error encountered.
> + * Returns zero on success, or a POSIX error code.
>   */
>  int tpm2_start_auth_session(struct tpm_chip *chip)
>  {
> @@ -1024,7 +1016,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>  	/* hash algorithm for session */
>  	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
>  
> -	rc = tpm_transmit_cmd(chip, &buf, 0, "start auth session");
> +	rc = tpm_to_ret(tpm_transmit_cmd(chip, &buf, 0, "StartAuthSession"));

The cool thing here is that e.g., in the case of
tpm2_start_auth_session, there is two implementation options:

1. tpm_to_ret(tpm2_start_auth_session)
2. tpm_to_ret(tpm_transmit_cmd)

Just want to expose this choice..


>  	tpm2_flush_context(chip, null_key);
>  
>  	if (rc == TPM2_RC_SUCCESS)
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 6c3125300c00..c826d5a9d894 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -257,8 +257,29 @@ enum tpm2_return_codes {
>  	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
>  	TPM2_RC_REFERENCE_H0	= 0x0910,
>  	TPM2_RC_RETRY		= 0x0922,
> +	TPM2_RC_SESSION_MEMORY	= 0x0903,
>  };
>  
> +/*
> + * Convert a return value from tpm_transmit_cmd() to a POSIX return value. The
> + * fallback return value is -EFAULT.
> + */
> +static inline ssize_t tpm_to_ret(ssize_t ret)
> +{
> +	/* Already a POSIX error: */
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (ret) {
> +	case TPM2_RC_SUCCESS:
> +		return 0;
> +	case TPM2_RC_SESSION_MEMORY:
> +		return -ENOMEM;
> +	default:
> +		return -EFAULT;
> +	}
> +}
> +
>  enum tpm2_command_codes {
>  	TPM2_CC_FIRST		        = 0x011F,
>  	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
> -- 
> 2.39.5
> 

BR, Jarkko

