Return-Path: <linux-integrity+bounces-663-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA765824AD8
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 23:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C7F1F21B18
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 22:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040DE2C85F;
	Thu,  4 Jan 2024 22:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="VZk07FVu";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="VZk07FVu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EF02C855;
	Thu,  4 Jan 2024 22:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1704407163;
	bh=pxtFYTfg5Btt9q2rnCmd31UlDOGjhAIA3pQzQG/fur8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=VZk07FVuzBCbVfrboiLg+q2okHjldFAPOUSZZbhrUGwPCWD1ajCFNvf1KTZ4guVp8
	 /61WOOnuecqdTKuxpljbQWD1xolw/vz4UdLqRJoWwtpoHargHmLNOTh3IDeH5PlQ1s
	 /pl3CDn5IeJAaKvBMhJOlOa7E2CGb9qEdGm3acQQ=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id C399E1286A8E;
	Thu,  4 Jan 2024 17:26:03 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id OtKBJrqFQNQP; Thu,  4 Jan 2024 17:26:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1704407163;
	bh=pxtFYTfg5Btt9q2rnCmd31UlDOGjhAIA3pQzQG/fur8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=VZk07FVuzBCbVfrboiLg+q2okHjldFAPOUSZZbhrUGwPCWD1ajCFNvf1KTZ4guVp8
	 /61WOOnuecqdTKuxpljbQWD1xolw/vz4UdLqRJoWwtpoHargHmLNOTh3IDeH5PlQ1s
	 /pl3CDn5IeJAaKvBMhJOlOa7E2CGb9qEdGm3acQQ=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C920B1286A80;
	Thu,  4 Jan 2024 17:26:02 -0500 (EST)
Message-ID: <c4f30887420363ad67f09b6df607544695e9c0e9.camel@HansenPartnership.com>
Subject: Re: [PATCH v6 13/20] tpm: Add HMAC session start and end functions
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 04 Jan 2024 17:25:58 -0500
In-Reply-To: <CY64GOLHZ2ZS.VIOWWUMZTV6U@suppilovahvero>
References: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
	 <20240102170408.21969-14-James.Bottomley@HansenPartnership.com>
	 <CY566RG0WK3A.21KMYFHM9R6UR@suppilovahvero>
	 <926f031e15739ea9044c8aaa7bbe72ab18a8f3c5.camel@HansenPartnership.com>
	 <CY64GOLHZ2ZS.VIOWWUMZTV6U@suppilovahvero>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-01-04 at 20:09 +0200, Jarkko Sakkinen wrote:
> On Wed Jan 3, 2024 at 5:31 PM EET, James Bottomley wrote:
> > On Wed, 2024-01-03 at 17:18 +0200, Jarkko Sakkinen wrote:
> > > On Tue Jan 2, 2024 at 7:04 PM EET, James Bottomley wrote:
[...]
> > > > +struct tpm2_auth {
> > > > +       u32 handle;
> > > > +       /*
> > > > +        * This has two meanings: before
> > > > tpm_buf_fill_hmac_session()
> > > > +        * it marks the offset in the buffer of the start of
> > > > the
> > > > +        * sessions (i.e. after all the handles).  Once the
> > > > buffer
> > > > has
> > > > +        * been filled it markes the session number of our auth
> > > > +        * session so we can find it again in the response
> > > > buffer.
> > > > +        *
> > > > +        * The two cases are distinguished because the first
> > > > offset
> > > > +        * must always be greater than TPM_HEADER_SIZE and the
> > > > second
> > > > +        * must be less than or equal to 5.
> > > > +        */
> > > > +       u32 session;
> > > > +       /*
> > > > +        * the size here is variable and set by the size of
> > > > our_nonce
> > > > +        * which must be between 16 and the name hash length.
> > > > we
> > > > set
> > > > +        * the maximum sha256 size for the greatest protection
> > > > +        */
> > > > +       u8 our_nonce[SHA256_DIGEST_SIZE];
> > > > +       u8 tpm_nonce[SHA256_DIGEST_SIZE];
> > > > +       /*
> > > > +        * the salt is only used across the session
> > > > command/response
> > > > +        * after that it can be used as a scratch area
> > > > +        */
> > > > +       union {
> > > > +               u8 salt[EC_PT_SZ];
> > > > +               /* scratch for key + IV */
> > > > +               u8 scratch[AES_KEYBYTES + AES_BLOCK_SIZE];
> > > > +       };
> > > > +       u8 session_key[SHA256_DIGEST_SIZE];
> > > > +};
> > > 
> > > Could this contain also the fields added in the previous patch?
> > > 
> > > Then obviously this data would be allocated together with chip
> > > but is there hard reason why this needs separate kzalloc and
> > > cannot be always allocated with chip blob?
> > 
> > It's session specific (and highly sensitive data), so it needs to
> > be allocated and destroyed with each session.  Our usage pattern
> > under the ops mutex means that every session is single threaded, so
> > effectively it has a 1:1 relationship with the chip, but part of
> > the reason for all of this is to remove visibility of the contents
> > of this area from anything other than the session code. 
> > Essentially it's stuff the chip doesn't need to know because it's
> > always constructed when the session is created.
> > 
> > I've also got a policy patch much later that requires two sessions,
> > so needs a push and pop mechanism which a static allocation in the
> > chip area won't work for.
> > 
> > James
> 
> Given the 1:1 relationship keeping the fields in tpm_chip has the
> benefit of not having to deal with allocation error.
> 
> I guess having struct tpm2_auth (dunno, maybe tpm2_hmac_auth tho)
> does make sense because then it could be declared as static field
> and zeroed with memzero_explicit().
> 
> I don't see any point saving memory here at least...

It's not about saving memory, it's about encapsulation: the inner
details of session encryption would have to go into a global linux wide
header file.  Ideally they should stay local to the TPM code and not be
splashed about the kernel, so as not to give anyone else the idea they
can muck with the values.  And, as I also said, a single allocation
won't work with >1 sessions which are needed later on.

James


