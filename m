Return-Path: <linux-integrity+bounces-3120-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70675932423
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 12:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD09282FED
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E86198E6E;
	Tue, 16 Jul 2024 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGWeTWkX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB19A198A34;
	Tue, 16 Jul 2024 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721126000; cv=none; b=G3gIHmWL3MqMQGA+55IUt0jWjE+VrFEN5k6NKoxg3h7aLm3KkfO35FPAEFjduEncfxYn+l7j1sCx0SMQMxCwhP0CZl2uXMeRs+50ak8tpIXaLknNtdrD0AF8juFtJD/D7u5+1xCZGQdxzOBwMQ1YyIw5GFwtyHTVdS43btO2L6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721126000; c=relaxed/simple;
	bh=dN5E33LT7GgPkxb12Y5QkfMGlP4vR+Mumccgj5BvfJ8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=j0WAoBZUWYt2uPTTyon0C22U8LuCuELSs3IFu7JcDISe2dFLwckPDSNK1Smh22KQHIWd1Gsuv4K9xUe2a0kke4Qzxv8lFvDHU2vTxFlN9iAEtHPGGZSKu7b2WDVtnTo1edjF5YjBXjdFjMkhW+RAD4QiBlR35L6zw29zI/PHqNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGWeTWkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D5CC116B1;
	Tue, 16 Jul 2024 10:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721126000;
	bh=dN5E33LT7GgPkxb12Y5QkfMGlP4vR+Mumccgj5BvfJ8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=HGWeTWkXtRL6VXma7QDXpFmNzfcRfYea92DaBoa4f5SfAn7PZqZ6sR9QR/AKpaLun
	 /pNc0sTWAYyGdb9M55bzVZalzvG3OIeYxK4+WuBhNZQr9LG81TI9XxGIDi7B4lp9kK
	 IFiAEvxNQT3oK/6KzTCWDAcaewz8J+RD5EM21WzOTCEAU4M0J98k/So/G00RVoLNen
	 fVdLVo9L8CG6AzYn37hxDNy8mAhiZW4HT4UuePM9AYUTyp1wFqINIVq6IQNZbpoFpA
	 keMwBSLKfaG+a6HSFNX/TW1CXJErb9UHZ1f6+kPgOLWpDACSVfLnK5FOqU8xWBwSvk
	 CqeaXPwUC2KVw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jul 2024 13:33:17 +0300
Message-Id: <D2QW8VSPX777.34R28W8GVXKMS@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hao
 Ge" <gehao@kylinos.cn>
Subject: Re: [PATCH] tpm: Move dereference after NULL check in
 tpm_buf_check_hmac_response
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Hao Ge" <hao.ge@linux.dev>, <peterhuewe@gmx.de>, <jgg@ziepe.ca>
X-Mailer: aerc 0.17.0
References: <20240709023337.102509-1-hao.ge@linux.dev>
In-Reply-To: <20240709023337.102509-1-hao.ge@linux.dev>

On Tue Jul 9, 2024 at 5:33 AM EEST, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
>
> We shouldn't dereference "auth" until after we have checked that it is
> non-NULL.
>
> Fixes: 7ca110f2679b ("tpm: Address !chip->auth in tpm_buf_append_hmac_ses=
sion*()")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
>  drivers/char/tpm/tpm2-sessions.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-ses=
sions.c
> index 2281d55df545..d3521aadd43e 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -746,15 +746,16 @@ int tpm_buf_check_hmac_response(struct tpm_chip *ch=
ip, struct tpm_buf *buf,
>  	struct tpm2_auth *auth =3D chip->auth;
>  	off_t offset_s, offset_p;
>  	u8 rphash[SHA256_DIGEST_SIZE];
> -	u32 attrs;
> +	u32 attrs, cc;
>  	struct sha256_state sctx;
>  	u16 tag =3D be16_to_cpu(head->tag);
> -	u32 cc =3D be32_to_cpu(auth->ordinal);
>  	int parm_len, len, i, handles;
> =20
>  	if (!auth)
>  		return rc;
> =20
> +	cc =3D be32_to_cpu(auth->ordinal);
> +
>  	if (auth->session >=3D TPM_HEADER_SIZE) {
>  		WARN(1, "tpm session not filled correctly\n");
>  		goto out;

Please check:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/comm=
it/?id=3D72d6e06ed101e31e943937e42053fc690dc75cfe

It is exactly this except commit message is tuned. And please denote
that I'm on holiday ;-)

If that works for you, I can put it to my -rc PR.

Thank you.

BR, Jarkko

