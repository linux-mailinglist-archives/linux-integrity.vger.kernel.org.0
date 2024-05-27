Return-Path: <linux-integrity+bounces-2652-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3978CFEB4
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 13:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C80ADB22285
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 11:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDCB13A268;
	Mon, 27 May 2024 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3tYrJsd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F3F50263;
	Mon, 27 May 2024 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716808716; cv=none; b=aHZNN18w9W8KFagF/j4dwYnVxgSIBacOVIhg3DcFmu840LS2DYIGqeR0Tun4AuZ1iOJ+0v4CjzrfiiyVDAIKoqMNUMLriQkP+9vc3BRpStPeotiPl8Mav8XSH2b0exKo7lXmjPa59NI7YMKLEjVXueK6trPn9vd6jMxvj7uUEG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716808716; c=relaxed/simple;
	bh=5ozoIdzSA20RW+cQlpSA9XZAa0A7renh/kwiMKVsJao=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bwMt7iOizuiBsQx/wapfnOF1H/OpwQXF9N+e8o39vdnxTZTe9oHMDsu7YgMg/AuIhLTAgwLDXG2NYrViSKcpZuNSZGPgysf8DBjsNjg9GVpqogUd4vkQVb7PKqx01zdeeTzNLal01Qn9yx3hLhJ1A7Z3h7s0E9HacjKCptmWoHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3tYrJsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39183C2BBFC;
	Mon, 27 May 2024 11:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716808716;
	bh=5ozoIdzSA20RW+cQlpSA9XZAa0A7renh/kwiMKVsJao=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=K3tYrJsdshbaL4HNefr2oQERur24zdu9yYu3oq0xO5vzGVkkEDXtKvwTuTeV50M7k
	 foZKTFxCradMqazpPc/ZdTe2jLNFvRrULg2lrqpafJ9LpxzNtfOgUsY2ZHlU+nu0ll
	 Spkxe6YpdYY6dGkVztCCro+AFMWQML6hXpUIi6cY3iAcAS/HZtkM+7pSVy2ljojd58
	 cTpd4uHOngdBg4IAvAWBp0oPZLDhm10KhtrxoYMv04QvlwUP8iUhNCHJ0nT4vsSOcB
	 tEhg/j5BAS48nbcFJmUBhi3P4Rm/lfqf6vp80LlS6xoAkQvzo7x7IurtQrrWIgLkT5
	 ANDa6/VzthB1w==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 May 2024 14:18:33 +0300
Message-Id: <D1KDWAY0DJUU.37W6F6RTTNVI0@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>
Subject: Re: [PATCH 1/6] tpm: consolidate TPM to crypto hash algorithm
 conversion
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ben Boeckel" <me@benboeckel.net>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>
X-Mailer: aerc 0.17.0
References: <20240524130459.21510-1-James.Bottomley@HansenPartnership.com>
 <20240524130459.21510-2-James.Bottomley@HansenPartnership.com>
 <ZlQBzdfyg1rSF_9a@farprobe>
In-Reply-To: <ZlQBzdfyg1rSF_9a@farprobe>

On Mon May 27, 2024 at 6:45 AM EEST, Ben Boeckel wrote:
> On Fri, May 24, 2024 at 09:04:54 -0400, James Bottomley wrote:
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index c17e4efbb2e5..07f532456a0c 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -418,11 +418,61 @@ enum tpm2_session_attributes {
> >  	TPM2_SA_AUDIT			=3D BIT(7),
> >  };
> > =20
> > -struct tpm2_hash {
> > +static const struct {
> >  	unsigned int crypto_id;
> >  	unsigned int tpm_id;
> > +} tpm2_hash_map[] =3D {
> > +	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
> > +	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
> > +	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
> > +	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
> > +	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
> >  };
> > =20
> > +/**
> > + * tpm2_crypto_to_alg() - convert a crypto hash to a TPM alg id
>
> Should "alg id" be "algorithm id" everwhere in the docs?

tpm2_hash_algorithm_from() would work for me.

> > + *
> > + * @hash: the crypto subsystem view of the hash

It is an instance of &hash_algo not "crypto subsystem view of the hash".

> > + *
> > + * Return: TPM algorithm id or -1 if no mapping was found.
> > + */
> > +static inline int tpm2_crypto_to_alg(int hash)
>
> How about naming this `crypto_id`?

It really should be @hash_info, which an instance of &hash_info.

Despite comments, this patch set will be ignored up until hmac
encryption needs no active attention and asymmetric keys have been
landed.

BR, Jarkko

