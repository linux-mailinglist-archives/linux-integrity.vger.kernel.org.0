Return-Path: <linux-integrity+bounces-7394-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD93DBC1C5B
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Oct 2025 16:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B8D34EBD99
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Oct 2025 14:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7802E03E8;
	Tue,  7 Oct 2025 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USQSwcBd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D89A2D73A4;
	Tue,  7 Oct 2025 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759847934; cv=none; b=V16ds2AVkaW+0ry5tpzHM2OBO534WqzsG5oZjLYP6bL4Ma5E9WC0bbDrWe4HC+DK/Urn6XfE9Hj1SkGefBveCGsd8nVLesBalsMw86BbsfNYrZuBan5jCqdBQsE1CTW0TOgNSIE3/r5BnXxHnGcu1Ior4q9DyUrkq6E8YgYBNUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759847934; c=relaxed/simple;
	bh=40+xkhjc2Wm5Ld3hrRFSd44nAhq1g6XgDf94PZ4Cw6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqVRHVH3NMOe/iuMxZVLf4g114RzMAH8cGGuM7+xZS0YheEnY6urZl7wYf4iU0eEVTzqp7ePdfrcaxzoAlNWdJ4m+xf1c9cc63fMxe+kCkq4NnEsJGlvp5ZXFFpgZZRPi2lwzXYZJ1XX2aO87Y4iwgmbhqe1WuzvJ/dkUvLBK+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USQSwcBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAE9C4CEF1;
	Tue,  7 Oct 2025 14:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759847934;
	bh=40+xkhjc2Wm5Ld3hrRFSd44nAhq1g6XgDf94PZ4Cw6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USQSwcBdmZW6GjWjGuipqp6KDuuLpVyqYBETKZ+omYpRNYoaQ7QbbGc27lrkOgCvo
	 iJJzTYHk344B7migg7+yhG1UvHqWgsK2/26nYMc2QmcEeD9WcML/tUmSJ5nROmiPOj
	 q4up48+SpiEyHumv788A0evsIKK5qks+7ohKe5K3QusNQDAoBJOvH66kYXfvLNSqOw
	 TOWFcPxmBb5I7Zn285Peio8hr+LLLMg3MtlV1LE2RG+FoOsPk1tt3ywO6ECZpZXdEA
	 PsUn4dNaqOvQTo2B3A3YwDylIpQAlhdK5/2dVh/e/ClQjeslvYNIcEkmRT8s3CNfrn
	 PQPdFOwrE6y/Q==
Date: Tue, 7 Oct 2025 17:38:50 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18
Message-ID: <aOUl-mZkRwJJwtJ7@kernel.org>
References: <aOKTFv1vh1cvvcLk@kernel.org>
 <CAHk-=wiCWiDcLEE3YqQo78piVHpwY2iXFW--6FbmFAURtor2+w@mail.gmail.com>
 <aOOu1f1QWQNtkl6c@kernel.org>
 <aOPOZwp_inGui9Bx@kernel.org>
 <125ba81bb222cdffef05ef9868c68002efd61235.camel@HansenPartnership.com>
 <aOPzovsBYlH3ojTR@kernel.org>
 <aOP04Yy3m23E4kjf@kernel.org>
 <aOUkcytS21zQs71I@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOUkcytS21zQs71I@kernel.org>

On Tue, Oct 07, 2025 at 05:32:24PM +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 06, 2025 at 07:57:10PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Oct 06, 2025 at 07:51:51PM +0300, Jarkko Sakkinen wrote:
> > > On Mon, Oct 06, 2025 at 10:33:40AM -0400, James Bottomley wrote:
> > > > On Mon, 2025-10-06 at 17:12 +0300, Jarkko Sakkinen wrote:
> > > > > 2. Null seed was extremely bad idea. The way I'm planning to actually
> > > > >    fix this is to parametrize the primary key to a persistent key
> > > > > handle
> > > > >    stored into nvram of the chip instead of genration. This will
> > > > > address
> > > > >    also ambiguity and can be linked directly to vendor ceritifcate
> > > > >    for e.g. to perfom remote attesttion.
> > > > 
> > > > Just a minute, there's been no discussion or debate about this on the
> > > > list.  The rationale for using the NULL seed is clearly laid out here:
> > > > 
> > > > https://docs.kernel.org/security/tpm/tpm-security.html
> > > > 
> > > > But in brief it is the only way to detect reset attacks against the TPM
> > > > and a reset attack is the single simplest attack an interposer can do.
> > > > 
> > > > If you think there's a problem with the approach, by all means let's
> > > > have a debate, since TPM security is always a trade off, but you can't
> > > > simply come to your own opinion and try to impose it by fiat without at
> > > > least raising whatever issue you think you've found with the parties
> > > > who contributed the code in the first place.
> > > 
> > > Ok fair enough, it's quite context dependent what is not secure and
> > > what is secure.
> > > 
> > > What I've thought, or have planned to implement, is not to discard null
> > > seed but instead parmetrize the primary key as a kernel command-line
> > > parameter.
> > > 
> > > E.g. "tpm.integrity_key={off,null,handle}" and
> > > "tpm.integrity_key_handle" to specify an NV index. The default value is
> > > off and I think also that with this change and possibly with some
> > > additional polishing it can reappear in default config,
> > > 
> > > This out of context for the PR but I will take your comment into account
> > > in the pull request.
> > > 
> > > My main issue preventing sending a new pull request is that weird list
> > > of core TPM2 features that is claimed "not to be required" with zero
> > > references. Especially it is contraditory claim that TPM2_CreatePrimary
> > > would be optional feature as the whole chip standard is based on three
> > > random seeds from which primary keys are templated and used as root
> > > keys for other keys.
> > > 
> > > So I guess I cherry-pick the claims from Chris' patch that I can cope
> > > with, look what I wrote to my commit and adjust that accordingly and
> > > finally write a tag message with summarization of all this. I exactly
> > > drop the arguments with no quantitative evidence, which is probably
> > > a sane way to move forward.
> > 
> > Personally I think that once there's correctly implemented command-line
> > option, the feature flag is somewhat redundant (and we've never had one
> > for /dev/tpmrm0). And it will help a lot with kernel QA as you can run
> > tests with same kernel image without recompilation.
> 
> I don't really see any possible security issues either with null seed.
> 
> It's no different as per remote attestation when compared storage keys.
> In a power cycle it's like same as per TPM2_Certify is considered. It's
> pretty much exactly performance issues but depending on deployment.
> Sometimes storage key root would be probably a better choice.
> 
> I really tried to dig something else than exactly perf stuff but was
> unsuccessful to find anything, and I've actually done a lot of work
> at work on remote attestation so everything is also somewhat fresh
> on my mind.
> 
> Still rooting to perf, immediate action being default option disable,
> and long term action being replacing the compilation option with
> kernel command-line options. I.e., I'll stay on track what I'e
> been already doing for some time :-)
> 
> That said, my PR cover letter (or the tag message) did suck and
> I'll just address next during exactly why something is or isn't
> an issue. I think this is really good outcome for everyone in
> the long run (because everyone will get the outcome they were
> looking for).

And in the business I'm ATM i.e., covering like with 20-30% market share
Finnish high school IT deplyoment going extremes is feasible, as some
kids are smart and capable of hacking the systems so to speak ;-) I'd
likely enable this feature e.g., in that type of deployment together
with remote attesation just to max out defence in depth.

BR, Jarkko

