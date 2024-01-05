Return-Path: <linux-integrity+bounces-668-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5B88256C5
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jan 2024 16:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE7AFB20FD8
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jan 2024 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F222E63C;
	Fri,  5 Jan 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CB2giagl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64AA2E631;
	Fri,  5 Jan 2024 15:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BC0C433C8;
	Fri,  5 Jan 2024 15:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704469006;
	bh=/b6funpS0X/9KSxRshCH0i3q2i/kWjlVhaCDfv8+BaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CB2giagl66OOlu1L5P2le9NKzW6s2xm8YnqlRbyIqPDo1mCs3hUJoL0N6eVKr9rME
	 HrUV7FroqH9jTDpU4zAe8/8IR4Tlr9MicY6x5py1U0CF70O9n3aiKPXSOb8JaFIlTX
	 WxJT8yWxwMeYRgzWUWWoZaK+MBqan+dS3B8YJmF9lHVXFuFnl+GimbVvgGNm6iQIXz
	 bcZS6nzDxqg16HR1h/wRyvKlzLubi3WZJm0z8jgXwzw+mGE8/nFOSI8/LPeThIpsaG
	 ckzkPbeEmZsj+4G7he3vmanwBPSNa68MwvGxkLY7NwC6UE0W33Tn7RtWJ8QTdjPANH
	 BMmDc8ak8766A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jan 2024 17:36:43 +0200
Message-Id: <CY6VU28UYUP8.1FBIPURJHNNHV@suppilovahvero>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v6 13/20] tpm: Add HMAC session start and end functions
X-Mailer: aerc 0.15.2
References: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
 <20240102170408.21969-14-James.Bottomley@HansenPartnership.com>
 <CY566RG0WK3A.21KMYFHM9R6UR@suppilovahvero>
 <926f031e15739ea9044c8aaa7bbe72ab18a8f3c5.camel@HansenPartnership.com>
 <CY64GOLHZ2ZS.VIOWWUMZTV6U@suppilovahvero>
 <c4f30887420363ad67f09b6df607544695e9c0e9.camel@HansenPartnership.com>
In-Reply-To: <c4f30887420363ad67f09b6df607544695e9c0e9.camel@HansenPartnership.com>

On Fri Jan 5, 2024 at 12:25 AM EET, James Bottomley wrote:
> On Thu, 2024-01-04 at 20:09 +0200, Jarkko Sakkinen wrote:
> > On Wed Jan 3, 2024 at 5:31 PM EET, James Bottomley wrote:
> > > On Wed, 2024-01-03 at 17:18 +0200, Jarkko Sakkinen wrote:
> > > > On Tue Jan 2, 2024 at 7:04 PM EET, James Bottomley wrote:
> [...]
> > > > > +struct tpm2_auth {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 handle;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This has two meanin=
gs: before
> > > > > tpm_buf_fill_hmac_session()
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * it marks the offset=
 in the buffer of the start of
> > > > > the
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * sessions (i.e. afte=
r all the handles).=C2=A0 Once the
> > > > > buffer
> > > > > has
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * been filled it mark=
es the session number of our auth
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * session so we can f=
ind it again in the response
> > > > > buffer.
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The two cases are d=
istinguished because the first
> > > > > offset
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * must always be grea=
ter than TPM_HEADER_SIZE and the
> > > > > second
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * must be less than o=
r equal to 5.
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 session;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the size here is va=
riable and set by the size of
> > > > > our_nonce
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * which must be betwe=
en 16 and the name hash length.
> > > > > we
> > > > > set
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the maximum sha256 =
size for the greatest protection
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 our_nonce[SHA256_DI=
GEST_SIZE];
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 tpm_nonce[SHA256_DI=
GEST_SIZE];
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the salt is only us=
ed across the session
> > > > > command/response
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * after that it can b=
e used as a scratch area
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0union {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 salt[EC_PT_SZ];
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0/* scratch for key + IV */
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 scratch[AES_KEYBYTES + AES_BLOCK_SIZE];
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 session_key[SHA256_=
DIGEST_SIZE];
> > > > > +};
> > > >=20
> > > > Could this contain also the fields added in the previous patch?
> > > >=20
> > > > Then obviously this data would be allocated together with chip
> > > > but is there hard reason why this needs separate kzalloc and
> > > > cannot be always allocated with chip blob?
> > >=20
> > > It's session specific (and highly sensitive data), so it needs to
> > > be allocated and destroyed with each session.=C2=A0 Our usage pattern
> > > under the ops mutex means that every session is single threaded, so
> > > effectively it has a 1:1 relationship with the chip, but part of
> > > the reason for all of this is to remove visibility of the contents
> > > of this area from anything other than the session code.=C2=A0
> > > Essentially it's stuff the chip doesn't need to know because it's
> > > always constructed when the session is created.
> > >=20
> > > I've also got a policy patch much later that requires two sessions,
> > > so needs a push and pop mechanism which a static allocation in the
> > > chip area won't work for.
> > >=20
> > > James
> >=20
> > Given the 1:1 relationship keeping the fields in tpm_chip has the
> > benefit of not having to deal with allocation error.
> >=20
> > I guess having struct tpm2_auth (dunno, maybe tpm2_hmac_auth tho)
> > does make sense because then it could be declared as static field
> > and zeroed with memzero_explicit().
> >=20
> > I don't see any point saving memory here at least...
>
> It's not about saving memory, it's about encapsulation: the inner
> details of session encryption would have to go into a global linux wide
> header file.  Ideally they should stay local to the TPM code and not be
> splashed about the kernel, so as not to give anyone else the idea they
> can muck with the values.  And, as I also said, a single allocation
> won't work with >1 sessions which are needed later on.

Do not mean to be impolite but "later on" does not matter, unless
it is within the scope of the same patch set. Clearly tpm2_auth
is not required to implement the feature and should be postponed
to a patch set which requires multiple instances of tpm2_auth.

I don't simply want to commmit to futures, sorry.

> James

BR, Jarkko

