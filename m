Return-Path: <linux-integrity+bounces-2564-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E438CCFAB
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 11:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E1D283B79
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 09:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0B013D51B;
	Thu, 23 May 2024 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/7IpU9F"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40DB13CFA3;
	Thu, 23 May 2024 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716457991; cv=none; b=UZVhxjpKLYHjX2osFgCMxTYTLf1xAKApE8ZypOp+fCNk37akBASRA2rJ85Rbl5/7+vi+WvP2+VJJceJtrVElf55j7kOqDHUvoHd+EIOZWC/f4WZqgbaIQBMykd2vuyjrsd5iji+2cdkKnS9eW2xGFw1PpL6e0xnSdNfi473a8JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716457991; c=relaxed/simple;
	bh=Z+LJ9o02AKGYyJoKzdsD0Mhmkl4h3nuqGk+uSvDjGlk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rVBpl4FAJeOYN6oYL05NnUuxtOoxswX4+A8n53QEZd3lS2l1q3I/httBtAQukd+u48erl1wAll4+BUVv6+A6wDfiVPei55nvVBumPKCsrEk/teQU4fnizTJIzyBwsEQrgBF7K0nxjFlcvkU9JPsbDPoq7eVw9ZEYz7hGt0KGPdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/7IpU9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACC8C2BD10;
	Thu, 23 May 2024 09:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716457990;
	bh=Z+LJ9o02AKGYyJoKzdsD0Mhmkl4h3nuqGk+uSvDjGlk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=F/7IpU9FUZAvpfEh0/t33PXl93JMwcJoeQ2AOMEWlwTURqgD5s5bE3ddLqt61tRFD
	 55A0EWMe86CTIkwwDgMd3s6pX9f3Lahh65Z1XyTNtHkoRM1v8yzOftjrp3/vkcZ01t
	 FVvX6NIP/+def5o2ISG4QbnYYy3+azOnfJzI7Gc5nMwGjd2dY0xjfGCtyNv1EdQjeI
	 vmY3X9TG06PKNJL8VJDTYu3dHd6gSZOK1ezA9ifCiTBRA6hIB+zjApAbJZPH9f6Fn6
	 /TgWTUlwBBvcifgx8kUQ2lRqfG73fQ8aGiDj7F8F72D6eZo+E8TEiQYaqjmkorNPwu
	 tDh7gMHJEz3UQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 May 2024 12:53:04 +0300
Message-Id: <D1GXKODMD4S8.1J12D4GOEQWPL@kernel.org>
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
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Herbert Xu" <herbert@gondor.apana.org.au>, "Linus Torvalds"
 <torvalds@linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com> <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano> <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org> <20240518043115.GA53815@sol.localdomain> <ZkhS1zrobNwAuANI@gondor.apana.org.au> <00bcfa65-384d-46ae-ab8b-30f12487928b@notapiano> <ZkwMnrTR_CbXcjWe@gondor.apana.org.au> <07512097-8198-4a84-b166-ef9809c2913b@notapiano> <Zk2Eso--FVsZ5AF3@gondor.apana.org.au> <CAHk-=wi7vwgzD4hdBzMrt1u3L2JyoctB91B7NLq-kVHrYXoTGA@mail.gmail.com> <Zk7K7hw-XIHmPs26@gondor.apana.org.au>
In-Reply-To: <Zk7K7hw-XIHmPs26@gondor.apana.org.au>

On Thu May 23, 2024 at 7:49 AM EEST, Herbert Xu wrote:
> On Wed, May 22, 2024 at 03:53:23PM -0700, Linus Torvalds wrote:
> >=20
> > That said, looking at the code in question, there are other oddities
> > going on. Even the "we found a favorite new rng" case looks rather
> > strange. The thread we use - nice and asynchronous - seems to sleep
> > only if the randomness source is emptied.
> >=20
> > What if you have a really good source of hw randomness? That looks
> > like a busy loop to me, but hopefully I'm missing something obvious.
>
> Yes that does look strange.  So I dug up the original patch at
>
> 	https://lore.kernel.org/all/20140317165012.GC1763@lst.de/
>
> and therein lies the answer.  It's relying on random.c to push back
> when the amount of new entropy exceeds what it needs.  IOW we will
> sleep via add_hwgenerator_randomness when random.c decides that
> enough is enough.  In fact the rate is much less now compared to
> when the patch was first applied.

Just throwing something because came to mind, not a serious suggestion.

In crypto_larval_lookup I see statements like this:

	request_module("crypto-%s", name);

You could potentially bake up a section/table to vmlinux which would
have entries like:

	"module name", 1/0

'1' would mean built-in. Then for early randomness use only stuff
that is built-in.

Came to mind from arch/x86/realmode for which I baked in a table
for relocation (this was a collaborative work with H. Peter Anvin
in 2012 to make trampoline code relocatable but is still a legit
example to do such shenanigans in a subystem).

BR, Jarkko

