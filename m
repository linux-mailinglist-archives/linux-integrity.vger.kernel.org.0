Return-Path: <linux-integrity+bounces-7383-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D8BBBE592
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Oct 2025 16:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62F73BF031
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Oct 2025 14:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817EE137923;
	Mon,  6 Oct 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBmeTHEd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5679E24B28;
	Mon,  6 Oct 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761018; cv=none; b=CaY06M06uj34wLNAdDiWe2QWdYXbHa8h4+KNAsu+W37VyASAaE4hDzfDCh6tI6muMzP2q6mb4ZIQ11XHzVnlnAVEYHF7jP1qe9YqA2h6y5Scbt2RWZd/9NW4K1dJ5UpR5y6x/lawGSPKIRSAFUF+TvfTBHL8uJjhZjcu6k08y8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761018; c=relaxed/simple;
	bh=voL61pr7tpXNE7UVtTh1JilvSM6+IA0wwZxpEOl0whI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qu9OGwgIurMqF0ICS4j+lk7sqjzJ9lNMko4MAZ+EPoy+jiwg63UUx6Sku6OYO9MlPlBWPNpJQiYW2Yo3BrXwiwnslCtetU4ABQk0EOzs9Ff4Dn7hZEK7Hu3lhgiNc+782b+Az1CQpxQtZwFqC1KuFc57hj/WASq5qM80Iu2ACo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBmeTHEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8871FC4CEF9;
	Mon,  6 Oct 2025 14:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759761017;
	bh=voL61pr7tpXNE7UVtTh1JilvSM6+IA0wwZxpEOl0whI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBmeTHEd7NuFo1jgnvRcZSNaXhsnQPuQsbFDKS4E5H4u+AV+AO7kK/oQMGzwzMPof
	 WTq77WOP2j38MKJ/kmKpqz0KJR7NPE7Na+7H4t1dHlmvZgIX4CqQziK8+inb+ZnN3H
	 mBqOocfZFqf6zBB67g8v/8pwp6ZsWc0VSVwd3YKPWvsdaotK+5frbMF+7K0b0acfw2
	 3mx5uCNUQw7dNvieGaRerKJmEZBp+l1nbguj0JKn9jXqs4i+hD93rXNnysIDdxCxCu
	 DEzg3xyj22KDSnVosNGbPtECL6b2iSm5mCyXcm3pilxjuCCjM4rFtbyix6dli0KlKV
	 WbtVmN8R44aGw==
Date: Mon, 6 Oct 2025 17:30:14 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18
Message-ID: <aOPSdstd1bk0pM3R@kernel.org>
References: <aOKTFv1vh1cvvcLk@kernel.org>
 <CAHk-=wiCWiDcLEE3YqQo78piVHpwY2iXFW--6FbmFAURtor2+w@mail.gmail.com>
 <aOOu1f1QWQNtkl6c@kernel.org>
 <aOPOZwp_inGui9Bx@kernel.org>
 <aOPPpVK8rJUuDgWD@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOPPpVK8rJUuDgWD@kernel.org>

On Mon, Oct 06, 2025 at 05:18:13PM +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 06, 2025 at 05:13:02PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Oct 06, 2025 at 02:58:17PM +0300, Jarkko Sakkinen wrote:
> > > On Sun, Oct 05, 2025 at 11:09:08AM -0700, Linus Torvalds wrote:
> > > > On Sun, 5 Oct 2025 at 08:47, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > >
> > > > >      This pull request disables
> > > > > TCG_TPM2_HMAC from the default configuration as it does not perform well
> > > > > enough [1].
> > > > >
> > > > > [1] https://lore.kernel.org/linux-integrity/20250825203223.629515-1-jarkko@kernel.org/
> > > > 
> > > > This link is entirely useless, and doesn't explain what the problem
> > > > was and *why* TPM2_TCG_HMAC shouldn't be on by default.
> > > > 
> > > > I think a much better link is
> > > > 
> > > >    https://lore.kernel.org/linux-integrity/20250814162252.3504279-1-cfenn@google.com/
> > > > 
> > > > which talks about the problems that TPM2_TCG_HMAC causes.
> > > > 
> > > > Which weren't just about "not performing well enough", but actually
> > > > about how it breaks TPM entirely for some cases.
> > > 
> > > Fair enough. I'll also enumerate the issues, and also roadmap
> > > to heal the feature.
> > 
> > So some of the arguments in Chris' email are debatable, such as
> > this list:
> > 
> > - TPM_RH_NULL
> > - TPM2_CreatePrimary
> > - TPM2_ContextSave
> > - ECDH-P256
> > - AES-128-CFB
> > 
> > 
> > We've never encountered a TPM chip without those TPM commands, and e.g.
> > /dev/tpmrm0 heavily relies on TPM2_ContextSave, and has been in the
> > mainline since 2017. And further, this has been the case on ARM too.
> > 
> > So using all of the arguments as rationale for the change that according
> > to Chris' email are broken because I cannnot objectively on all of the
> > arguments.
> > 
> > E.g. I have to assume to this day that all known TPM chips have those
> > commands because no smoking gun exists. And if DID exist, then I'd
> > assume someone would fixed /dev/tpmrm0 ages ago.
> > 
> > That said, I do agree on disabling the feature for the time being:
> > we have consensus on actions but not really on stimulus tbh.
> > And if there is stimulus I would postpone this patch to create
> > fix also for /dev/tpmrm0.
> > 
> > Argument where I meet with Chris suggestion are:
> > 
> > 1. Performance. The key generation during boot is extremely bad
> >    idea and depending on the deployment the encryption cost is
> >    too much (e.g. with my laptop having fTPM it does not really
> >    matter).
> > 2. Null seed was extremely bad idea. The way I'm planning to actually
> >    fix this is to parametrize the primary key to a persistent key handle
> >    stored into nvram of the chip instead of genration. This will address
> >    also ambiguity and can be linked directly to vendor ceritifcate
> >    for e.g. to perfom remote attesttion.
> > 
> > Things don't go broken by saying that they are broken and nothing
> > elsewhere in the mainline has supporting evidence that those commands
> > would be optional. I cannot agree on argument which I have zero
> > means to measure in any possible way.
> > 
> > This is exactly also the root reason why I wrote my own commit instead
> > with the same change: I could have never signed off the commit that
> > I don't believe is true in its storyline.
> > 
> > So if I write cover for the pull request where I use the subset of
> > arguments with shared consensus would that be enough to get this
> > through? As for primary key handle fix I rather do that with
> > time and proper care.
> 
> I had to use few hours to remind why I did my commit instead of acking
> the original and this is the root. We've never had e.g. a bug in the
> wild that would /dev/tpmrm0 to be broken because ContextSave is not
> available, and it is *widely* used device across all major platforms.

Here's mobile client profile:

https://trustedcomputinggroup.org/wp-content/uploads/TPM_2.0_Mobile_Common_Profile_v2r31_FINAL.pdf

Unless I missed a tidbit I see nothing in it saying that ContextSave
would be optional. If there was even a known legit spec bringing some
context to the claims, that would move things forward.

Section 2.3 states this about ContextSave:

"The symmetric cipher mode TPM_ALG_CFB is REQUIRED by TCG TPM 2.0
Library specification Part 1 [1] and is also necessary for
implementation of TPM2_Create, TPM2_Load, TPM 2_ContextSave,
TPM2_ContextLoad, and other TPM commands"

which actually claims that TPM_ALG_CFB is required where as Chris'
patch claims 180 degrees opposite what the spec says.

Perhaps there's some other random TCG spec that I've missed, it's
entirely possible...

BR, Jarkko 

