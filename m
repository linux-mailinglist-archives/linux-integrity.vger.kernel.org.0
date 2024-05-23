Return-Path: <linux-integrity+bounces-2568-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 350E98CD079
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 12:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CACB11F2419C
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 10:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372191411F7;
	Thu, 23 May 2024 10:41:02 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5651411C2;
	Thu, 23 May 2024 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460862; cv=none; b=JvBwxAcMB9ciyvfmemoLD1rB9ebX5uD2Tt8M19gV0imeD1zW46FKbUzIef1hF8FnTZuHsulaX12EgiYrVyx9w9gccb9GXgk7VJT8PKQP/59L6kF4D0QgkGhrb5ToPNoMtFKkoVkAdIVDg607naJmdk7EqH9tC8ulfvdzDKBK/eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460862; c=relaxed/simple;
	bh=eXRSHwUvy8ISV/ZF5NEQa0Kx5OLcz4a9q9ZU1a3C/gk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ly/QUq62YsaWYT+APwTG67o8xQqYAtBgakJlTPNITxtXn2tmtMsQcjLNOzusMsWbUHN8KHYKobXZbDZ/9Ap3T3fDCiabvDCzq9M0THp4g9xe935bc3MVtUdfNO5aK3FbXhryxUntDK/BylAIhTPSe1KvWWvLxUy4lDcTpzn80qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 107)
	id 3D0D568D09; Thu, 23 May 2024 12:40:57 +0200 (CEST)
X-Spam-Level: 
Received: from blackhole.lan (p5b33fb10.dip0.t-ipconnect.de [91.51.251.16])
	by verein.lst.de (Postfix) with ESMTPSA id 5E39267373;
	Thu, 23 May 2024 12:40:36 +0200 (CEST)
Date: Thu, 23 May 2024 12:40:32 +0200
From: Torsten Duwe <duwe@lst.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "=?UTF-8?B?TsOtY29s?=
 =?UTF-8?B?YXM=?= F. R. A. Prado" <nfraprado@collabora.com>, Eric Biggers
 <ebiggers@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>, James Bottomley
 <James.Bottomley@hansenpartnership.com>, Ard Biesheuvel <ardb@kernel.org>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 regressions@lists.linux.dev, kernel@collabora.com, Tejun Heo
 <tj@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kees Cook <keescook@chromium.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [v3 PATCH] hwrng: core - Remove add_early_randomness
Message-ID: <20240523123954.5e42bd93@blackhole.lan>
In-Reply-To: <Zk7K7hw-XIHmPs26@gondor.apana.org.au>
References: <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>
	<dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano>
	<D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>
	<20240518043115.GA53815@sol.localdomain>
	<ZkhS1zrobNwAuANI@gondor.apana.org.au>
	<00bcfa65-384d-46ae-ab8b-30f12487928b@notapiano>
	<ZkwMnrTR_CbXcjWe@gondor.apana.org.au>
	<07512097-8198-4a84-b166-ef9809c2913b@notapiano>
	<Zk2Eso--FVsZ5AF3@gondor.apana.org.au>
	<CAHk-=wi7vwgzD4hdBzMrt1u3L2JyoctB91B7NLq-kVHrYXoTGA@mail.gmail.com>
	<Zk7K7hw-XIHmPs26@gondor.apana.org.au>
Organization: LST e.V.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 12:49:50 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Wed, May 22, 2024 at 03:53:23PM -0700, Linus Torvalds wrote:
> > 
> > That said, looking at the code in question, there are other oddities
> > going on. Even the "we found a favorite new rng" case looks rather
> > strange. The thread we use - nice and asynchronous - seems to sleep
> > only if the randomness source is emptied.
> > 
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
> enough is enough.

Yes, I thought that this was the obvious choice, the lesser evil. If it
just discarded the excess and returned immediately I had expected some
kernel threads to spin constantly.

>  In fact the rate is much less now compared to
> when the patch was first applied.

You mean the rate of required entropy? Doesn't that make things worse?
Maybe redesign the API to use a pull scheme? RNGs register at the
randomness facility with a callback that can be used when there is a
need for fresh entropy?

	Torsten


