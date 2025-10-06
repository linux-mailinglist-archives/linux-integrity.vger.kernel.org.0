Return-Path: <linux-integrity+bounces-7385-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F204BBEBD5
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Oct 2025 18:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403671895975
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Oct 2025 16:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978F12343BE;
	Mon,  6 Oct 2025 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="et548ZUn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EC0222566;
	Mon,  6 Oct 2025 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769511; cv=none; b=dm5/novxv/uqvLXf/NUF0IX/ccAOnxWUBbA3eK13USMosoFxMZaPEW469DlUyXxrDOQ0YcA6OP1jAV0UuOWBlyoVxImK1IRhW1Bhd8MmlkzPTwaKpCRxGTNYXi5Dm+fXB9XnFA9jdXERO1y9IVbxWpKj9XxI3ll0AsV3Bipkdzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769511; c=relaxed/simple;
	bh=K8x37pmisalYaTF8JY1niJHg7zAf//L2gA9JP1ifzLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAoD9EeVnJkl9faHxtVpnjywFRyLf9Km/ZeIVw19Q9IPllzLJs4rFECF1ec4NOrS8ya8zg3Zck/KKmXeEaEJ/2UOA3UZgvKfehKMOujLlqnpeghMbS7USD2gQ2YedO23xUtOXQZgDkwToawOMpacz9XjGv6Fz1uWk93BnlJrYOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=et548ZUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8FBC4CEF5;
	Mon,  6 Oct 2025 16:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759769510;
	bh=K8x37pmisalYaTF8JY1niJHg7zAf//L2gA9JP1ifzLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=et548ZUnM6pggmg04VtjRMZ6Ps0nyA39v1ktyMElnrmn5Rq4T75w6QOexuAgFK685
	 SrIPZs+zJ5ivlFAbwVazZw6/ilTdB4glGHbOjJq1JtyEn6McpEi37vVG+soXBPHvta
	 Nr0/u44Ylrurp9OY6Yk14LDtWy1YPeuMidkM4hh6he8thBcAQp1GyBebpWVCoDDUqu
	 2QH0M1E27ZyqRpF7tb22hf9XwBQ4yRO2AGmyNAPOBHbtbPreGAExLPIfok5mf5IbbA
	 ajx2SBp+xIIoRV0fibbKZmujYH3z5WL3kgoNgI6Rhof6LIT93COdkwPY5wrDHkvmLQ
	 Rg84cmImBzBGA==
Date: Mon, 6 Oct 2025 19:51:46 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18
Message-ID: <aOPzovsBYlH3ojTR@kernel.org>
References: <aOKTFv1vh1cvvcLk@kernel.org>
 <CAHk-=wiCWiDcLEE3YqQo78piVHpwY2iXFW--6FbmFAURtor2+w@mail.gmail.com>
 <aOOu1f1QWQNtkl6c@kernel.org>
 <aOPOZwp_inGui9Bx@kernel.org>
 <125ba81bb222cdffef05ef9868c68002efd61235.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <125ba81bb222cdffef05ef9868c68002efd61235.camel@HansenPartnership.com>

On Mon, Oct 06, 2025 at 10:33:40AM -0400, James Bottomley wrote:
> On Mon, 2025-10-06 at 17:12 +0300, Jarkko Sakkinen wrote:
> > 2. Null seed was extremely bad idea. The way I'm planning to actually
> >    fix this is to parametrize the primary key to a persistent key
> > handle
> >    stored into nvram of the chip instead of genration. This will
> > address
> >    also ambiguity and can be linked directly to vendor ceritifcate
> >    for e.g. to perfom remote attesttion.
> 
> Just a minute, there's been no discussion or debate about this on the
> list.  The rationale for using the NULL seed is clearly laid out here:
> 
> https://docs.kernel.org/security/tpm/tpm-security.html
> 
> But in brief it is the only way to detect reset attacks against the TPM
> and a reset attack is the single simplest attack an interposer can do.
> 
> If you think there's a problem with the approach, by all means let's
> have a debate, since TPM security is always a trade off, but you can't
> simply come to your own opinion and try to impose it by fiat without at
> least raising whatever issue you think you've found with the parties
> who contributed the code in the first place.

Ok fair enough, it's quite context dependent what is not secure and
what is secure.

What I've thought, or have planned to implement, is not to discard null
seed but instead parmetrize the primary key as a kernel command-line
parameter.

E.g. "tpm.integrity_key={off,null,handle}" and
"tpm.integrity_key_handle" to specify an NV index. The default value is
off and I think also that with this change and possibly with some
additional polishing it can reappear in default config,

This out of context for the PR but I will take your comment into account
in the pull request.

My main issue preventing sending a new pull request is that weird list
of core TPM2 features that is claimed "not to be required" with zero
references. Especially it is contraditory claim that TPM2_CreatePrimary
would be optional feature as the whole chip standard is based on three
random seeds from which primary keys are templated and used as root
keys for other keys.

So I guess I cherry-pick the claims from Chris' patch that I can cope
with, look what I wrote to my commit and adjust that accordingly and
finally write a tag message with summarization of all this. I exactly
drop the arguments with no quantitative evidence, which is probably
a sane way to move forward.

> 
> Regards,
> 
> James

BR, Jarkko

