Return-Path: <linux-integrity+bounces-3933-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325D79B55DA
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Oct 2024 23:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B8F1C20AEB
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Oct 2024 22:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0128620ADDC;
	Tue, 29 Oct 2024 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iECXAQPr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C5E20822D;
	Tue, 29 Oct 2024 22:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241480; cv=none; b=JiZKci6UJqKu7ht/QYMWY3SJ9/P84T35bvXfG13FTpSTy2518igrFgT3uj62A+Qg59TMj06xFYGClAZJcjrJk5IyACNs6AjBQ7HQzPIx9ORzkspJ+6DSYTB1Ul07n1dYSd/lvqNnW1Cm5xTq7NVQw2xt3a95MAeDyv42ybY937c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241480; c=relaxed/simple;
	bh=n/rSFNWJKAdBA4Z/FVlAhcvjy5j1KGuh21dTEV1TsMs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=dgj6sX//W9RlAFfEXlyo7GwT7o1XGZchi3pSccylKWD5ybcyT41dUrbpT5ua4tzEzmcXEhzYBEIFQzc8psRppJoFmyHvFNMby0x2Cmriy6u8rzUO7AA3WTYQmqsi6PsZX7UJXn7xB3LLG0h9llJ3vbWBYGRgs/6OtHpNPG5QBXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iECXAQPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3B9C4CECD;
	Tue, 29 Oct 2024 22:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730241480;
	bh=n/rSFNWJKAdBA4Z/FVlAhcvjy5j1KGuh21dTEV1TsMs=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=iECXAQPrPI/MuOUNhEwbJgKM+edsM7LiBFiSokLWyRq8I35SMDcSYaXhZ5Qy6Xl13
	 SUN50pLeGk4lrLvgB5zMTl4cQxLkzkTdBiN0uCaKAEnaIAu4FQdwgxhpnj39JoKTJD
	 n/O/kVQyZJX4rTyTYpCVVKhVm//IFkg0ZBr0HBK5XqEFC3wo2NskLJHlGGpLty8NKu
	 8rSIfifCs3JZa2hc1zD8whdE+vtel4PJ0AHCLnj8c6ZCWSBgOw8eCrOUZmkhn1eQ8A
	 HvmlNQhMrxF0EJbosW/aPdYejBbQ2TlQdqvGCvmW0Nofovv9SXdrZBWMw1FcjUA38s
	 SX8Ei49WOmUSw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Oct 2024 00:37:55 +0200
Message-Id: <D58NEWOJP8YY.CXZB4F73W284@kernel.org>
To: "David Gstir" <david@sigma-star.at>, <parthiban@linumiz.com>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>
Cc: "sigma star Kernel Team" <upstream+dcp@sigma-star.at>,
 <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] KEYS: trusted: dcp: fix NULL dereference in AEAD crypto
 operation
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <254d3bb1-6dbc-48b4-9c08-77df04baee2f@linumiz.com>
 <20241029113401.90539-1-david@sigma-star.at>
In-Reply-To: <20241029113401.90539-1-david@sigma-star.at>

On Tue Oct 29, 2024 at 1:34 PM EET, David Gstir wrote:
> When sealing or unsealing a key blob we currently do not wait for
> the AEAD cipher operation to finish and simply return after submitting
> the request. If there is some load on the system we can exit before
> the cipher operation is done and the buffer we read from/write to
> is already removed from the stack. This will e.g. result in NULL
> pointer dereference errors in the DCP driver during blob creation.
>
> Fix this by waiting for the AEAD cipher operation to finish before
> resuming the seal and unseal calls.
>
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: 0e28bf61a5f9 ("KEYS: trusted: dcp: fix leak of blob encryption key=
")
> Reported-by: Parthiban N <parthiban@linumiz.com>
> Closes: https://lore.kernel.org/keyrings/254d3bb1-6dbc-48b4-9c08-77df04ba=
ee2f@linumiz.com/
> Signed-off-by: David Gstir <david@sigma-star.at>
> ---
>  security/keys/trusted-keys/trusted_dcp.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/tru=
sted-keys/trusted_dcp.c
> index 4edc5bbbcda3..e908c53a803c 100644
> --- a/security/keys/trusted-keys/trusted_dcp.c
> +++ b/security/keys/trusted-keys/trusted_dcp.c
> @@ -133,6 +133,7 @@ static int do_aead_crypto(u8 *in, u8 *out, size_t len=
, u8 *key, u8 *nonce,
>  	struct scatterlist src_sg, dst_sg;
>  	struct crypto_aead *aead;
>  	int ret;
> +	DECLARE_CRYPTO_WAIT(wait);
> =20
>  	aead =3D crypto_alloc_aead("gcm(aes)", 0, CRYPTO_ALG_ASYNC);
>  	if (IS_ERR(aead)) {
> @@ -163,8 +164,8 @@ static int do_aead_crypto(u8 *in, u8 *out, size_t len=
, u8 *key, u8 *nonce,
>  	}
> =20
>  	aead_request_set_crypt(aead_req, &src_sg, &dst_sg, len, nonce);
> -	aead_request_set_callback(aead_req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL,
> -				  NULL);
> +	aead_request_set_callback(aead_req, CRYPTO_TFM_REQ_MAY_SLEEP,
> +				  crypto_req_done, &wait);
>  	aead_request_set_ad(aead_req, 0);
> =20
>  	if (crypto_aead_setkey(aead, key, AES_KEYSIZE_128)) {
> @@ -174,9 +175,9 @@ static int do_aead_crypto(u8 *in, u8 *out, size_t len=
, u8 *key, u8 *nonce,
>  	}
> =20
>  	if (do_encrypt)
> -		ret =3D crypto_aead_encrypt(aead_req);
> +		ret =3D crypto_wait_req(crypto_aead_encrypt(aead_req), &wait);
>  	else
> -		ret =3D crypto_aead_decrypt(aead_req);
> +		ret =3D crypto_wait_req(crypto_aead_decrypt(aead_req), &wait);
> =20
>  free_req:
>  	aead_request_free(aead_req);

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

