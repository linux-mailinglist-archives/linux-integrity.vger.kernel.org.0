Return-Path: <linux-integrity+bounces-2675-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2B28D131D
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 06:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3422844E8
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 04:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600851429A;
	Tue, 28 May 2024 04:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hStZr+Ev"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5DC1396;
	Tue, 28 May 2024 04:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716868929; cv=none; b=uYUOpb4xqEy2vaSWXX3E268k6fKnzV6V14AYs5xOWPuAdZZnvgjjOMyArcTy/MhY+R412sTpbdbB5D+/p/5JVOvCqzN1jRtEZHhGPQ98QYPboPz9hLQ6Q3+r5uBpEs0MGSsU6yB3PHyMDquglrDelKcaOnb6eZJ74YazM/i8UfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716868929; c=relaxed/simple;
	bh=RnmsPifvhNThYUMsbWs/uvFbuRDTORijhZ2xFj033o4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=hWiOBUd5Gn2RiA5ty4w2Sfq78lEIYW8fVbm9FNK+ufoOfvy104wvSbZXs+1GVjzvDFrJLuIaxnlnh7GK1fhb5B+yRV0Ml75PQmtaQtr5OXhEnonyXEDuOBVq0iPseupQFjS+2kji0u3I+7VJyCC8LU2+KeqfYwZUCd1JDhqtF0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hStZr+Ev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF11C3277B;
	Tue, 28 May 2024 04:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716868928;
	bh=RnmsPifvhNThYUMsbWs/uvFbuRDTORijhZ2xFj033o4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hStZr+EvKvrKdaz9HlELdlcMdbldtuZUfL9PnHRKWQRaMvEEk4a4Kbs84E1S+kX2M
	 dSLWmRSiOjLxhkQh0NdILB3C0rLsBblV9D2HH9z3xBww/NNAZHO+WhReJkRPVL8LAC
	 GYtzA4ono5iDj2l56H4dBwzDpekNHzs+naerF3wfFRb/Vh7m6yPi3iDu0yM64hiQ9V
	 Ju7SH7jNKlpl6oQFmYqxYDohQrtxzG/Ea9e+MSN0fqy5vQ55nhH+icA19zNFAoo6Sc
	 O44IBSN6sSF0m87wY223RIKBkSTlcV/0rhy4ZcPM/wOn90i8x5Nh1ivID3r99fWPTa
	 sc/SqSWKJmFJQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 May 2024 07:02:03 +0300
Message-Id: <D1KZ8N1QY0QW.1ACMEKZL0IW0R@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <Andreas.Fuchs@infineon.com>, "James Prestwood" <prestwoj@gmail.com>,
 "David Woodhouse" <dwmw2@infradead.org>, "Eric Biggers"
 <ebiggers@kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, <linux-crypto@vger.kernel.org>,
 "Stefan Berger" <stefanb@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, "open list" <linux-kernel@vger.kernel.org>, "Peter
 Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Ard Biesheuvel"
 <ardb@kernel.org>, "Mario Limonciello" <mario.limonciello@amd.com>
Subject: Re: [PATCH v6 1/6] tpm: Open code tpm_buf_parameters()
X-Mailer: aerc 0.17.0
References: <20240528035136.11464-1-jarkko@kernel.org>
 <20240528035136.11464-2-jarkko@kernel.org>
In-Reply-To: <20240528035136.11464-2-jarkko@kernel.org>

On Tue May 28, 2024 at 6:51 AM EEST, Jarkko Sakkinen wrote:
> With only single call site, this makes zero sense (slipped out of the
> radar during the review). Open code and document the action directly
> to the site, to make it more readable.
>
> Fixes: 1b6d7f9eb150 ("tpm: add session encryption protection to tpm2_get_=
random()")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm-buf.c  | 26 --------------------------
>  drivers/char/tpm/tpm2-cmd.c | 10 +++++++++-
>  include/linux/tpm.h         |  2 --
>  3 files changed, 9 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index 647c6ca92ac3..cad0048bcc3c 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -223,30 +223,4 @@ u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *off=
set)
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_read_u32);
> =20
> -static u16 tpm_buf_tag(struct tpm_buf *buf)
> -{
> -	struct tpm_header *head =3D (struct tpm_header *)buf->data;
> -
> -	return be16_to_cpu(head->tag);
> -}
> -
> -/**
> - * tpm_buf_parameters - return the TPM response parameters area of the t=
pm_buf
> - * @buf: tpm_buf to use
> - *
> - * Where the parameters are located depends on the tag of a TPM
> - * command (it's immediately after the header for TPM_ST_NO_SESSIONS
> - * or 4 bytes after for TPM_ST_SESSIONS). Evaluate this and return a
> - * pointer to the first byte of the parameters area.
> - *
> - * @return: pointer to parameters area
> - */
> -u8 *tpm_buf_parameters(struct tpm_buf *buf)
> -{
> -	int offset =3D TPM_HEADER_SIZE;
> -
> -	if (tpm_buf_tag(buf) =3D=3D TPM2_ST_SESSIONS)
> -		offset +=3D 4;
> =20
> -	return &buf->data[offset];
> -}
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 0cdf892ec2a7..1e856259219e 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -281,6 +281,7 @@ struct tpm2_get_random_out {
>  int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>  {
>  	struct tpm2_get_random_out *out;
> +	struct tpm_header *head;
>  	struct tpm_buf buf;
>  	u32 recd;
>  	u32 num_bytes =3D max;
> @@ -288,6 +289,7 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, =
size_t max)
>  	int total =3D 0;
>  	int retries =3D 5;
>  	u8 *dest_ptr =3D dest;
> +	off_t offset;
> =20
>  	if (!num_bytes || max > TPM_MAX_RNG_DATA)
>  		return -EINVAL;
> @@ -320,7 +322,13 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest,=
 size_t max)
>  			goto out;
>  		}
> =20
> -		out =3D (struct tpm2_get_random_out *)tpm_buf_parameters(&buf);
> +		head =3D (struct tpm_header *)buf.data;
> +		offset =3D TPM_HEADER_SIZE;
> +		/* Skip the parameter size field: */
> +		if (be16_to_cpu(head->tag) =3D=3D TPM2_ST_SESSIONS)
> +			offset +=3D 4;
> +
> +		out =3D (struct tpm2_get_random_out *)&buf.data[offset];
>  		recd =3D min_t(u32, be16_to_cpu(out->size), num_bytes);
>  		if (tpm_buf_length(&buf) <
>  		    TPM_HEADER_SIZE +
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index c17e4efbb2e5..b3217200df28 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -437,8 +437,6 @@ u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset=
);
>  u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
>  u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
> =20
> -u8 *tpm_buf_parameters(struct tpm_buf *buf);
> -
>  /*
>   * Check if TPM device is in the firmware upgrade mode.
>   */


This patch went into v6 by mistake, unrelated to the patch set.

BR, Jarkko

