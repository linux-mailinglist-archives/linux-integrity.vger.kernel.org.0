Return-Path: <linux-integrity+bounces-2688-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D57D8D2893
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 01:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092B9287A56
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 23:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB8613E41C;
	Tue, 28 May 2024 23:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJY0Lznq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C03F17C6A;
	Tue, 28 May 2024 23:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716937792; cv=none; b=rcva1/GO/JZV2ey3cqEl0ea1EHS3whag0W98zW4LyiBo0hgEoaq+gjEgpNiol6TikefoHyBrO2H6qZK70IwsmGXeV/Y6f1uPAShJTy81chUix68qLsu6ChxzGZTEcpkTb65HNy3M75uOpZOyDlj9AMwnbC4QiNcmuYtmLbq1njU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716937792; c=relaxed/simple;
	bh=onyWA+d2BlSWT+ML9qSE85yyFiLFQ+oqmdDWiKsYT04=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=aDCMCnbfMemUrqCVYnc6wbb2ge53guWT7+XRdYxSbhiNY2hIsGRx02Uy55Nj+imB5x3PAenCY6g7tkJ7/ZJMStKFAFyTZZr/OQ8G7taI5icak63Kp2ZmHeg59ryS9bV626dARI6ytyKwdExis9bVuGCK7acM22Y7AhK30LJqy7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJY0Lznq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B77C3277B;
	Tue, 28 May 2024 23:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716937791;
	bh=onyWA+d2BlSWT+ML9qSE85yyFiLFQ+oqmdDWiKsYT04=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=kJY0LznqSZD8TdDuLyfHr40B7u5c/8/Gbldd3grLHo6tIDaj/svY5WYltsMtMYfWY
	 l15pysUR0LlQi6+V7uCPLwM9m8GE6Y7skGcSo/Bm077AJ/OQxKWNeXK9poG0dmPCHu
	 atubP0Ecm9kXzyZiTEk9ubRV10iYJcLdgxvUKZH0a54tq9gtEfnWJftDe55e1SK7Pw
	 dwlXPnKBxzjFIb+Y/Bx3wjNgYiD0IxXawzwxT1Er8BkUxUcjC5nPrjEzWcgbe1NdM2
	 hx8dbysWf5mtn/WehHouBRe7Mjuc7QY6u31SOVPgAr5+EUBWuQ7gYjw0kEijPQ9EsL
	 dbZZpqAAcfYbg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 May 2024 02:09:45 +0300
Message-Id: <D1LNNE1FMDBS.3T9J17BAX1D04@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <Andreas.Fuchs@infineon.com>, "James Prestwood" <prestwoj@gmail.com>,
 "David Woodhouse" <dwmw2@infradead.org>, "Eric Biggers"
 <ebiggers@kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, <linux-crypto@vger.kernel.org>,
 "Stefan Berger" <stefanb@linux.ibm.com>, "Lennart Poettering"
 <lennart@poettering.net>, "David S. Miller" <davem@davemloft.net>, "open
 list" <linux-kernel@vger.kernel.org>, "David Howells"
 <dhowells@redhat.com>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Ard Biesheuvel" <ardb@kernel.org>, "Mario Limonciello"
 <mario.limonciello@amd.com>
Subject: Re: [PATCH v7 5/5] keys: asymmetric: Add tpm2_key_ecdsa
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240528210823.28798-1-jarkko@kernel.org>
 <20240528210823.28798-6-jarkko@kernel.org>
 <D1LLSAS0YN47.18EIHL1KRF2UR@kernel.org>
In-Reply-To: <D1LLSAS0YN47.18EIHL1KRF2UR@kernel.org>

On Wed May 29, 2024 at 12:42 AM EEST, Jarkko Sakkinen wrote:
> On Wed May 29, 2024 at 12:08 AM EEST, Jarkko Sakkinen wrote:
> > +	/* Encode the ASN.1 signature: */
> > +#define TPM2_KEY_ECDSA_SIG_SIZE		(2 + 2 * (2 + SHA256_DIGEST_SIZE) + r=
_0 + s_0)
> > +	pr_info("sig_size=3D%d\n", TPM2_KEY_ECDSA_SIG_SIZE);
> > +	ptr[0] =3D 0x30; /* SEQUENCE */
> > +	ptr[1] =3D TPM2_KEY_ECDSA_SIG_SIZE - 2;
> > +#define TPM2_KEY_ECDSA_SIG_R_TAG	2
> > +#define TPM2_KEY_ECDSA_SIG_R_SIZE	3
> > +#define TPM2_KEY_ECDSA_SIG_R_BODY	4
> > +	ptr[TPM2_KEY_ECDSA_SIG_R_TAG] =3D 0x02; /* INTEGER */
> > +	ptr[TPM2_KEY_ECDSA_SIG_R_SIZE] =3D SHA256_DIGEST_SIZE + r_0;
> > +	ptr[TPM2_KEY_ECDSA_SIG_R_BODY] =3D 0x00; /* maybe dummy write */
> > +	memcpy(&ptr[TPM2_KEY_ECDSA_SIG_R_BODY + r_0], r, SHA256_DIGEST_SIZE);
> > +#define TPM2_KEY_ECDSA_SIG_S_TAG	(4 + r_0 + SHA256_DIGEST_SIZE)
> > +#define TPM2_KEY_ECDSA_SIG_S_SIZE	(5 + r_0 + SHA256_DIGEST_SIZE)
> > +#define TPM2_KEY_ECDSA_SIG_S_BODY	(6 + r_0 + SHA256_DIGEST_SIZE)
> > +	ptr[TPM2_KEY_ECDSA_SIG_S_TAG] =3D 0x02; /* INTEGER */
> > +	ptr[TPM2_KEY_ECDSA_SIG_S_SIZE] =3D SHA256_DIGEST_SIZE + s_0;
> > +	ptr[TPM2_KEY_ECDSA_SIG_S_BODY] =3D 0x00; /* maybe dummy write */
> > +	memcpy(&ptr[TPM2_KEY_ECDSA_SIG_S_BODY + s_0], s, SHA256_DIGEST_SIZE);
> > +	ret =3D TPM2_KEY_ECDSA_SIG_SIZE;
>
> Stefan, so this how I realized the signature encoding, thanks to
> your earlier remarks [1]! I found out based on that a few glitches
> and ended up with this better structured ECDSA signature encoder,
> so thank you for doing that.

1. SHA384 would fit without any significant changes.
2. SHA512 will require a single additional byte, i.e. prefix byte 0x81
   for the sequence (not for coeffients).
3. SM3 similarly is also trivial to add.

Both will be also easy to add later on. I would not enlarge this patch
set from what it is now.

So I think this is pretty well along the lines of:

https://datatracker.ietf.org/doc/draft-woodhouse-cert-best-practice/

BR, Jarkko

