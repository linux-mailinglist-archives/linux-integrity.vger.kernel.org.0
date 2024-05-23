Return-Path: <linux-integrity+bounces-2567-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFABC8CCFF2
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 12:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78AC81C223EA
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 10:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4361313CABA;
	Thu, 23 May 2024 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lupS8MHf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C38913CF9A;
	Thu, 23 May 2024 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458844; cv=none; b=iIqYHVa2kN5Xa7fLTeDnCTQ2DwGSbm3jG+Hoz2+yXBiTnI7eWgOatRHXiz13onCFRqaano72/1Taslgj0mT7ER0T9YZVF66aolmp5NFMCMO38uOL2IygRoP6s0lzK1bITLBw2LuLtYpQ/LNRt/aSxoNHs0Oki09BZ7YkHPC/Gsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458844; c=relaxed/simple;
	bh=lhpP0tnMGzAW+ExciYPONUGP8ehLax7xz3Mzpw/hEKw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=X/DuOb2ICjja31ocOA+qCSKIknKt5WNVHh/o9yZFdx9+KJNEppBUlDm0bwaAvtBkc8b6c+3if/NTG1AbqRC0VmWGOJdY9tUCjHLDoC5kHOctEfZGd4QlTp3yhEhMLbqy91EHO9DTPG2IwrU+8aasAhPQuDlkvGmyH7o0jQ9TO/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lupS8MHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA58C2BD10;
	Thu, 23 May 2024 10:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716458843;
	bh=lhpP0tnMGzAW+ExciYPONUGP8ehLax7xz3Mzpw/hEKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lupS8MHfMUY5e4ftuByzbxV0xPujgLfnAZVzxhXuGP5X9oBTRIXxrP8DpNLMfZEoN
	 TooMhJPn34KkFCmJ3RDP8cDTQZlxRbO9gsEAj9yXzMmGETJ/ONufs7Io29w7vWMqbR
	 KWOVVV/vp/cmkLYl90+euUpKyK0guRDjU0EAIxq4YodrzRWVELksOZxO/Lpqo5+A/s
	 g+JNNGQCHP2/Zn3oAs8cQ+rkVudaKWGj8t5Tynur1FPuMeyId4HpBxxDUG9jCKuWdY
	 jzqVLzhkvsBssbldF/X2myBUtie//byzBahIw5GC4MKGEQqxMjcyHROBn5XyfdcPeL
	 svrioa8K0/q/w==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 May 2024 13:07:17 +0300
Message-Id: <D1GXVKBX8S1K.BU96RSL9PD2E@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 =?utf-8?b?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 "Eric Biggers" <ebiggers@kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Ard Biesheuvel"
 <ardb@kernel.org>, "Linux Crypto Mailing List"
 <linux-crypto@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <regressions@lists.linux.dev>,
 <kernel@collabora.com>, "Tejun Heo" <tj@kernel.org>, "Linux Kernel Mailing
 List" <linux-kernel@vger.kernel.org>, "Kees Cook" <keescook@chromium.org>,
 "Torsten Duwe" <duwe@lst.de>, "H. Peter Anvin" <hpa@zytor.com>, "Theodore
 Ts'o" <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [v3 PATCH] hwrng: core - Remove add_early_randomness
X-Mailer: aerc 0.17.0
References: <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>
 <20240518043115.GA53815@sol.localdomain>
 <ZkhS1zrobNwAuANI@gondor.apana.org.au>
 <00bcfa65-384d-46ae-ab8b-30f12487928b@notapiano>
 <ZkwMnrTR_CbXcjWe@gondor.apana.org.au>
 <07512097-8198-4a84-b166-ef9809c2913b@notapiano>
 <Zk2Eso--FVsZ5AF3@gondor.apana.org.au>
 <CAHk-=wi7vwgzD4hdBzMrt1u3L2JyoctB91B7NLq-kVHrYXoTGA@mail.gmail.com>
 <Zk7K7hw-XIHmPs26@gondor.apana.org.au>
 <D1GXKODMD4S8.1J12D4GOEQWPL@kernel.org>
 <Zk8TXz1hfA8_Uu9R@gondor.apana.org.au>
In-Reply-To: <Zk8TXz1hfA8_Uu9R@gondor.apana.org.au>

On Thu May 23, 2024 at 12:58 PM EEST, Herbert Xu wrote:
> On Thu, May 23, 2024 at 12:53:04PM +0300, Jarkko Sakkinen wrote:
> >
> > Just throwing something because came to mind, not a serious suggestion.
> >=20
> > In crypto_larval_lookup I see statements like this:
> >=20
> > 	request_module("crypto-%s", name);
> >=20
> > You could potentially bake up a section/table to vmlinux which would
> > have entries like:
> >=20
> > 	"module name", 1/0
> >=20
> > '1' would mean built-in. Then for early randomness use only stuff
> > that is built-in.
>
> This early random stuff is obsolete not just because we have a
> kernel thread doing the same thing, but moreover random.c itself
> has been modified so that it is no longer starved of entropy on
> startup.  There is no reason to feed any early randomness.

As a feature that would still sometimes nice to have. I've
sometimes wished there was "lsmod -b" or similar to display
built-in stuff ;-)

So overally I think it was good to have at least documented
here...=20

BR, Jarkko

