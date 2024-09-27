Return-Path: <linux-integrity+bounces-3709-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 403D5987CA0
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Sep 2024 03:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6BF71C226F0
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Sep 2024 01:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6715E1C6A5;
	Fri, 27 Sep 2024 01:36:42 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E3ED53C;
	Fri, 27 Sep 2024 01:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727401002; cv=none; b=avIHuV+TsxMMR0lT4N8LjW9nRNuGJYSE/xiSkUMHYRTTXIuK5afhT+ibhl0PO0w/5Fw7On7wP8pSOqRdulfpScBeTTizJkaLV6aUYLcA6V4Xheu3vOuOGSKEnNAqxegpZBhZo1ITQvBl9KmlzbGsjwFMG2UA81CIUepHNALT1Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727401002; c=relaxed/simple;
	bh=hFdP5aaaibBZ8KCNQ8ZKquKbDyruQ6qDPnUlk8g7+Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ylji0gj8tJ00SXnTfxhWvuJ3HGLYx0weTngXTjbVdoeUBBAWWvImRGNtV3QzkvgjDKRGGJGBnxy5B/CU3r41k9ZDve0AlHZleWIXvT1MAHLRgcWuscOV1HvRN2Y6Tcb6E7R0o1qyXfkvOtpi7JTb6yMSfFcZWiCH+b4O7xa3jKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 48R1PxJ1000683;
	Thu, 26 Sep 2024 20:25:59 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 48R1PvPj000682;
	Thu, 26 Sep 2024 20:25:57 -0500
Date: Thu, 26 Sep 2024 20:25:57 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, dhowells@redhat.com,
        dwmw2@infradead.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        roberto.sassu@huawei.com, linux-security-module@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 00/14] KEYS: Add support for PGP keys and signatures
Message-ID: <20240927012557.GA634@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <ZuPDZL_EIoS60L1a@gondor.apana.org.au> <b4a3e55650a9e9f2302cf093e5cc8e739b4ac98f.camel@huaweicloud.com> <CAHk-=wiU24MGO7LZ1ZZYpQJr1+CSFG9VnB0Nyy4xZSSc_Zu0rg@mail.gmail.com> <ZuaVzQqkwwjbUHSh@gondor.apana.org.au> <CAHk-=wgnG+C3fVB+dwZYi_ZEErnd_jFbrkN+xc__om3d=7optQ@mail.gmail.com> <a991cf4187bced19485e28a5542ac446b92f864e.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a991cf4187bced19485e28a5542ac446b92f864e.camel@huaweicloud.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 26 Sep 2024 20:26:00 -0500 (CDT)

On Thu, Sep 26, 2024 at 11:41:51AM +0200, Roberto Sassu wrote:

Good evening, I hope the week has gone well for everyone.

> On Sun, 2024-09-15 at 10:40 +0200, Linus Torvalds wrote:
> > On Sun, 15 Sept 2024 at 10:08, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > > 
> > > If the aformentioned EFI use-case is bogus, then distro package
> > > verification is going to be the only application for PGP keys in
> > > the kernel.
> > 
> > So I haven't actually seen _that_ series, but as mentioned it does
> > smell pretty conceptually broken to me.
> > 
> > But hey, code talks, bullshit walks. People can most certainly try to
> > convince me.

> The solution has three parts.
> 
> 1. The kernel verifies the RPM header with a PGP key embedded in the
> kernel, and provided by the Linux distribution vendor.
> 
> 2. The Integrity Digest Cache parses the verified RPM header in the
> kernel and feeds one of the existing LSMs (IMA, IPE and BPF LSM) with
> the digests extracted from the RPM header.
> 
> 3. The LSMs compare the fsverity digest they find in the filesystem
> with the authenticated ones from the RPM header, and might deny access
> to the file if the digests don't match.
> 
> At this point, RPM headers don't contain fsverity digests, only file
> content digests, but this is an orthogonal problem.

So from the above, can it be assumed that the RPM parsing code isn't
useful until the RPM packages contain fsverity root hashes?

In addition, and we mentioned this previously in this thread, it seems
that one needs to 'eat' a full read of a file, at least once, in order
to generate an fsverity digest that is consistent with the actual
on-disk contents of the file.

So, once again, the notion of the implementation of a generic digest
cache would seem to be orthogonal to the issue of verifying that the
digest values in the cache are from a 'known good' source.

> I had a look at previous threads on similar topics, to find your
> position on the matter.
> 
> I got that you would not be probably against (1), and maybe not (3).
> 
> However, we still need a source telling whether the fsverity digest in
> the filesystem is the same of one calculated by Linux distributions
> during build. That is what the Integrity Digest Cache provides.
> 
> Regarding (2), maybe I'm missing something fundamental, but isn't
> parsing the ELF format of kernel modules from the kernel similar?
> 
> Cannot really go to user space at this point, since the authenticated
> fsverity digests are directly consumed by LSMs. Also, as David pointed
> out in this thread [1], there is no obligation for user space to call
> any signature verification function before executing a file, this task
> must be done by an LSM.
> 
> I'm aware that we should not run unnecessary code in the kernel. I
> tried to mitigate this issue by striping the parsing functionality to
> the minimum (220 LOC), and formally verifying it with the Frama-C
> static analyzer. The parser is available here [2].
> 
> I'm also aware that this is not the long term solution, but I didn't
> find much support on the alternatives, like a trustworthy user mode
> driver [3][4] (isolated from other root processes) and signed eBPF
> programs [5].

We mentioned this previously in the related threads you cite, our TSEM
LSM implementation allows the kernel to determine whether or not a
userspace process or the entirety of userspace should be 'trusted' at
any point in time.

The security footprint/model of a digest 'priming' workload is going
to be extremely small.  If the priming workload is invoked early in
the boot process the kernel can have assurance that neither the
priming workload or the surrounding userspace has commited any actions
that would be considered to make the system untrusted.

> What it would be the right way to proceed, in your opinion?

Alternatively, we had suggested previously that the RPM parsing code
may be a good candidate for implementation with a separate kernel
loadable module.  That places the parsing code in the kernel to meet
your security requirement and there is standardized infrastructure for
module signing that would ensure the integrity of the parser.

The module surfaces a pseudo-file through securityfs that userspace
can use to feed the RPM header into the kernel to drive the population
of the digest cache.  The parser only needs to be resident and
operative long enough to initialize the digest cache of a trusted
system and a kernel loadable module would seem to be consistent with
that model.

Once again, priming the digest cache with known good digests seems to
be an issue orthogonal to the implementation of the digest cache
itself.

We would be interested in knowing if we are misunderstanding the model
you are trying to achieve.

> Thanks
> 
> Roberto
> 
> [1] https://lore.kernel.org/linux-kernel/32081.1171560770@redhat.com/
> [2] https://lore.kernel.org/linux-integrity/20240905150543.3766895-9-roberto.sassu@huaweicloud.com/
> [3] https://lore.kernel.org/lkml/20230317145240.363908-1-roberto.sassu@huaweicloud.com/#t
> [4] https://lore.kernel.org/linux-integrity/eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com/
> [5] https://lwn.net/Articles/853489/

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

