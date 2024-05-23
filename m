Return-Path: <linux-integrity+bounces-2566-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8256B8CCFD1
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 12:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AEF1F2388C
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 10:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A2B13CA99;
	Thu, 23 May 2024 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dR7zJ40l"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C28113B592;
	Thu, 23 May 2024 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458531; cv=none; b=qg7SDnltq/fpLe4a1TeyrhMPUv/POUG6MdixcqafhAGauoRtAu0119sq8ZGUJ3Py0Vp68ZySfh3oyzDC8R5cl/rwz3tFwW9aQUd3AZ7TqC5o5NxtNmKP2932wMGyWuSmg0A9Xm7UYIWufsN8mtLlmoPMh/PYmAPZFYlC9lVSYSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458531; c=relaxed/simple;
	bh=UPgFW9vuL3g5qypadrRDJdjIEzGJX3EMLiS63N0hICM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=S6vqVPp6vJ7LhmdO4MisnaAEYcj2QdGe4V+tVI0HwwXjtz5eqDIYtWJFMbWwhDK1bDoaIb9pCfmeVm8xVHj015gBOqmkt68qlr7wTnuQRHApRK6KYD8lF9lld1qT7QB0fGPytaDp6g82s0MKFqdgXOL1Z7/qSmdBUSLFS8zrrcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dR7zJ40l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E295EC2BD10;
	Thu, 23 May 2024 10:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716458530;
	bh=UPgFW9vuL3g5qypadrRDJdjIEzGJX3EMLiS63N0hICM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dR7zJ40lwquVtY7dVKnnYTIz+66EOJk8cFguLQ4mvLH7tQIZ8lgnKOJKCoCLjXUoh
	 8cocuvw4pJt7A1VanISjFFVDDKu5hgPXgg510vMUYaH/ODAaM9WWv9X/cptiNx/sp8
	 cni4bMODk/lWLV9RX0KxO53rpboDWMis3NzCeh2/xG8VK9ehCv6Pdsq7eAtOuz4Nal
	 KS8jWCj7sa/hPUncnTHA3IOLy4RVYHogYbG4HvC0CKVmtIrQKqwjzHt6p1MPPujPCq
	 HOOoYAdO84c6DyqtFAJf8x0xIK0xegDPKzin27kYfQ5gNdlAsB8kr4MPXdP3VNOcem
	 KyCh8iakZNFug==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 May 2024 13:02:05 +0300
Message-Id: <D1GXRKNG42V4.1ZHV4H7HVNXHO@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "Linus Torvalds"
 <torvalds@linux-foundation.org>
Cc: =?utf-8?b?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
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
References: <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com> <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano> <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org> <20240518043115.GA53815@sol.localdomain> <ZkhS1zrobNwAuANI@gondor.apana.org.au> <00bcfa65-384d-46ae-ab8b-30f12487928b@notapiano> <ZkwMnrTR_CbXcjWe@gondor.apana.org.au> <07512097-8198-4a84-b166-ef9809c2913b@notapiano> <Zk2Eso--FVsZ5AF3@gondor.apana.org.au> <CAHk-=wi7vwgzD4hdBzMrt1u3L2JyoctB91B7NLq-kVHrYXoTGA@mail.gmail.com> <Zk7K7hw-XIHmPs26@gondor.apana.org.au> <D1GXKODMD4S8.1J12D4GOEQWPL@kernel.org>
In-Reply-To: <D1GXKODMD4S8.1J12D4GOEQWPL@kernel.org>

On Thu May 23, 2024 at 12:53 PM EEST, Jarkko Sakkinen wrote:
> On Thu May 23, 2024 at 7:49 AM EEST, Herbert Xu wrote:
> > On Wed, May 22, 2024 at 03:53:23PM -0700, Linus Torvalds wrote:
> > >=20
> > > That said, looking at the code in question, there are other oddities
> > > going on. Even the "we found a favorite new rng" case looks rather
> > > strange. The thread we use - nice and asynchronous - seems to sleep
> > > only if the randomness source is emptied.
> > >=20
> > > What if you have a really good source of hw randomness? That looks
> > > like a busy loop to me, but hopefully I'm missing something obvious.
> >
> > Yes that does look strange.  So I dug up the original patch at
> >
> > 	https://lore.kernel.org/all/20140317165012.GC1763@lst.de/
> >
> > and therein lies the answer.  It's relying on random.c to push back
> > when the amount of new entropy exceeds what it needs.  IOW we will
> > sleep via add_hwgenerator_randomness when random.c decides that
> > enough is enough.  In fact the rate is much less now compared to
> > when the patch was first applied.
>
> Just throwing something because came to mind, not a serious suggestion.
>
> In crypto_larval_lookup I see statements like this:
>
> 	request_module("crypto-%s", name);
>
> You could potentially bake up a section/table to vmlinux which would
> have entries like:
>
> 	"module name", 1/0
>
> '1' would mean built-in. Then for early randomness use only stuff
> that is built-in.
>
> Came to mind from arch/x86/realmode for which I baked in a table
> for relocation (this was a collaborative work with H. Peter Anvin
> in 2012 to make trampoline code relocatable but is still a legit
> example to do such shenanigans in a subystem).

This could be even parameter in __request_module() itself e.g.

int __request_module(bool wait, bool builtin_only, const char *fmt, ...);

And would not matter which initcall layer we are running at.

BR, Jarkko


