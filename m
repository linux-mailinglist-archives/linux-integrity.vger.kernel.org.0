Return-Path: <linux-integrity+bounces-7386-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C85BBEC28
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Oct 2025 18:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 19BEB34A541
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Oct 2025 16:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A89B283FC5;
	Mon,  6 Oct 2025 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cg8BEA2u"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC512367AC;
	Mon,  6 Oct 2025 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769831; cv=none; b=fpNVMu8AlRTAwGeVAdOAqmt76zZHgPycIxI5LVgjMAPBANUrKNGVoKVE8B8+CVfGHphMH7aHsclfv6RJw0mGdqR/l3wMkXfE9N80Gzxp5BMp8gpLPjWbXNTcBJo4aQ8V2wL9/1JPcpcSJ6CgUqJcel4D1awn2Uq2/zW3uuk1Mfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769831; c=relaxed/simple;
	bh=MTyzOQ65D3yo+3oxCfSL27YKKf7wwGR9IB0zRc/aHMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGa8si8sDElpCaV4gNDmnvBASZHmBfQBQMlVQ6fC7JFy231tE8SORy3B2RVAeVHDaVQjRnPCP88UoQHE+TshTdPrmM7zt7xJRa7SYpKBlqNJD6noT+uo83a3+53nB/p7tq2TsXQGjF1g6Y/+ZjvjzXhkd9Ju2tmVX5l+cPYou/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cg8BEA2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E9AC4CEF5;
	Mon,  6 Oct 2025 16:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759769829;
	bh=MTyzOQ65D3yo+3oxCfSL27YKKf7wwGR9IB0zRc/aHMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cg8BEA2uCYLJeCBdRnpOQuodVhixbeBqCmGHjBgeD5gTn51vBh1KRrUGx2wxVXSY2
	 urkOplG65teNQuRCOY585tgNBLLwSVnDn1oOr6Uo1VjYs1XHPO7zoIr2iam9G2uh7t
	 rkMcEDGhX55TtBekhYzLI3DXJMKCDqDAAL6K+BeFsh8f7s8i1Y+RQ7hmQ/wFndAzs2
	 pzzTy3Isa7kXQELe9s94p8P3tWJNjk3i3lBIou6RkFz/5VWSVkz7XiHK2Z4xXQI80i
	 Fhkw+vqwnh7usf7kxEVir1Zs5b8Wi5KF30ooRdeCDs/rN3cPgSbcexvHvn3Clw7QwT
	 URAlQbi5eTWPA==
Date: Mon, 6 Oct 2025 19:57:05 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18
Message-ID: <aOP04Yy3m23E4kjf@kernel.org>
References: <aOKTFv1vh1cvvcLk@kernel.org>
 <CAHk-=wiCWiDcLEE3YqQo78piVHpwY2iXFW--6FbmFAURtor2+w@mail.gmail.com>
 <aOOu1f1QWQNtkl6c@kernel.org>
 <aOPOZwp_inGui9Bx@kernel.org>
 <125ba81bb222cdffef05ef9868c68002efd61235.camel@HansenPartnership.com>
 <aOPzovsBYlH3ojTR@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOPzovsBYlH3ojTR@kernel.org>

On Mon, Oct 06, 2025 at 07:51:51PM +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 06, 2025 at 10:33:40AM -0400, James Bottomley wrote:
> > On Mon, 2025-10-06 at 17:12 +0300, Jarkko Sakkinen wrote:
> > > 2. Null seed was extremely bad idea. The way I'm planning to actually
> > >    fix this is to parametrize the primary key to a persistent key
> > > handle
> > >    stored into nvram of the chip instead of genration. This will
> > > address
> > >    also ambiguity and can be linked directly to vendor ceritifcate
> > >    for e.g. to perfom remote attesttion.
> > 
> > Just a minute, there's been no discussion or debate about this on the
> > list.  The rationale for using the NULL seed is clearly laid out here:
> > 
> > https://docs.kernel.org/security/tpm/tpm-security.html
> > 
> > But in brief it is the only way to detect reset attacks against the TPM
> > and a reset attack is the single simplest attack an interposer can do.
> > 
> > If you think there's a problem with the approach, by all means let's
> > have a debate, since TPM security is always a trade off, but you can't
> > simply come to your own opinion and try to impose it by fiat without at
> > least raising whatever issue you think you've found with the parties
> > who contributed the code in the first place.
> 
> Ok fair enough, it's quite context dependent what is not secure and
> what is secure.
> 
> What I've thought, or have planned to implement, is not to discard null
> seed but instead parmetrize the primary key as a kernel command-line
> parameter.
> 
> E.g. "tpm.integrity_key={off,null,handle}" and
> "tpm.integrity_key_handle" to specify an NV index. The default value is
> off and I think also that with this change and possibly with some
> additional polishing it can reappear in default config,
> 
> This out of context for the PR but I will take your comment into account
> in the pull request.
> 
> My main issue preventing sending a new pull request is that weird list
> of core TPM2 features that is claimed "not to be required" with zero
> references. Especially it is contraditory claim that TPM2_CreatePrimary
> would be optional feature as the whole chip standard is based on three
> random seeds from which primary keys are templated and used as root
> keys for other keys.
> 
> So I guess I cherry-pick the claims from Chris' patch that I can cope
> with, look what I wrote to my commit and adjust that accordingly and
> finally write a tag message with summarization of all this. I exactly
> drop the arguments with no quantitative evidence, which is probably
> a sane way to move forward.

Personally I think that once there's correctly implemented command-line
option, the feature flag is somewhat redundant (and we've never had one
for /dev/tpmrm0). And it will help a lot with kernel QA as you can run
tests with same kernel image without recompilation.

BR, Jarkko

