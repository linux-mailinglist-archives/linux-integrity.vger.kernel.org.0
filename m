Return-Path: <linux-integrity+bounces-3619-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 522D397AFB2
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2024 13:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009921F24337
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2024 11:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08B7166F23;
	Tue, 17 Sep 2024 11:29:49 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347E9200A3;
	Tue, 17 Sep 2024 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726572589; cv=none; b=VOCgToaa+ZwUeuPvBkFmOEiPRZQYUT/q1P3TWP5+O5Wfj8OWRGdNF6UBhQ73ooVZnymvlqzOxROGbPbum7QhW/pAEO9SVh2wJWpW5h93HH5lOOpnkjtwlAfkBKzNQ5y0ePHqgnOGif2NI6KgIjxPJNAbZydkiXnQYX0GQYCIFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726572589; c=relaxed/simple;
	bh=BSUGbVFzo/XLFC1Eb0wbRRxSENs3PhgBjIFbMO9VrPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5cBAFvqxGf7M1vnhkcXBk02LanXQxNAEHDLEZOg4ZGS9j3XQbM3vsliiwkcAYQ/Bd4ccYKrTKIrkShY8MwSYA2n31p1XMcLxPauN4cIs9LtxTvfzQBREQdm8aCFqWw3DEIf1VLAV7nDG7WiSDhubXsHvCXYDdVDLnde502G4YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 48HBRQaS014263;
	Tue, 17 Sep 2024 06:27:26 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 48HBROCL014262;
	Tue, 17 Sep 2024 06:27:24 -0500
Date: Tue, 17 Sep 2024 06:27:24 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>, dhowells@redhat.com,
        dwmw2@infradead.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        roberto.sassu@huawei.com, linux-security-module@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 00/14] KEYS: Add support for PGP keys and signatures
Message-ID: <20240917112724.GA14167@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <ZuPDZL_EIoS60L1a@gondor.apana.org.au> <b4a3e55650a9e9f2302cf093e5cc8e739b4ac98f.camel@huaweicloud.com> <CAHk-=wiU24MGO7LZ1ZZYpQJr1+CSFG9VnB0Nyy4xZSSc_Zu0rg@mail.gmail.com> <ZuaVzQqkwwjbUHSh@gondor.apana.org.au> <CAHk-=wgnG+C3fVB+dwZYi_ZEErnd_jFbrkN+xc__om3d=7optQ@mail.gmail.com> <ZualreC25wViRHBq@gondor.apana.org.au> <ZuapXswFUxsFxjgH@gondor.apana.org.au> <2541abb8-68b5-4e6a-b309-a001ecdfbea1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2541abb8-68b5-4e6a-b309-a001ecdfbea1@huaweicloud.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Tue, 17 Sep 2024 06:27:26 -0500 (CDT)

On Sun, Sep 15, 2024 at 07:52:13PM +0200, Roberto Sassu wrote:

Good morning, I hope the day is starting well for everyone.

> On 9/15/2024 11:31 AM, Herbert Xu wrote:
> >On Sun, Sep 15, 2024 at 05:15:25PM +0800, Herbert Xu wrote:
> >>
> >>Roberto, correct me if I'm wrong but your intended use case is
> >>the following patch series, right?
> >
> >Actually the meat of the changes is in the following series:
> >
> >https://lore.kernel.org/linux-integrity/20240905150543.3766895-1-roberto.sassu@huaweicloud.com/

> Yes, correct. The idea is to verify the authenticity of RPM headers,
> extract the file digests from them, and use those file digests as
> reference values for integrity checking of files accessed by user
> space processes.
>
> If the calculated digest of a file being accessed matches one
> extracted from the RPM header, access is granted otherwise it is
> denied.

Based on the above response and your comment:

"The security policy I want to enforce is: all code that the system
executes has been built by a trusted source (e.g. a Linux
distribution)."

From the following URL:

https://lore.kernel.org/linux-integrity/b4a3e55650a9e9f2302cf093e5cc8e739b4ac98f.camel@huaweicloud.com/#t

What you are advocating for then, with this patch series and the
digest cache series, is a security policy that requires signed code
execution, correct?

Nothing wrong with that, it is a reasonable security desire, but it
seems wrong to conflate that with the implementation of the digest
cache.  There is a great deal of utility in a digest cache but it
doesn't require the need to parse RPM header information and/or TLV
sequences in the kernel.

That would only appear to be a requirement if your goal is a signed
executable policy that is implemented through a packaging medium,
correct?

To wit:

If I have security infrastructure that gives me confidence in the
integrity of the files on my media, I can populate a digest cache with
a simple ASCII list of pathnames fed into the kernel at boot time.

If I don't have confidence in the integrity of the files on my media I
could append a known good checksum to each pathname with the last
entry in the list being a PGP signature over the input stream.

I brought the following issue up in the patch series that Herbert
links to above, but will do so here, since I believe it has relevance
to this conversation as well.

If the goal is to have the digest cache be relevant from an integrity
perspective, particularly a signed code policy, you have to physically
read every file that has a digest value in the RPM digest list.
Otherwise the scheme is vulnerable to a Time Of Measurement Time Of
Use (TOMTOU) vulnerability scenario, correct?

This requires that one needs to experience a latency hit at least
once, presumably at boot when you prime the digest cache, correct?

An alternative approach may be to separate the RPM/TLV parsing code
from the digest code and implement RPM/Debian/whatever parsing in a
loadable module that would in turn populate the digest cache.

That may be a more acceptable strategy since it places the potential
security vulnerabilities of a parser into something that an entity
that is interested in a signed code policy would consider to be an
acceptable tradeoff from a security perspective.

> Roberto

Hopefully the above comments and clarifications will be helpful in
furthering additional discussion.

Have a good day.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

