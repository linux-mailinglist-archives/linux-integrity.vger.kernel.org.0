Return-Path: <linux-integrity+bounces-6948-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DB4B3AEB2
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Aug 2025 01:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211361891609
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Aug 2025 23:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F45B2D9787;
	Thu, 28 Aug 2025 23:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E97y42YG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0512D9786
	for <linux-integrity@vger.kernel.org>; Thu, 28 Aug 2025 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756425293; cv=none; b=uC9gSPjF6BhLF5H6zz1SyYX2Sn92xMLV3OasQQ9EzRlDLP9Q1+VUYSQw1Zxa3JWxJEUs5TL5G26R8856042womxyfaoNRNXG5d1//Id/O1arPKq5R2TvB72EfBSktnglo4JY/t+RnK0kMcEpjLeNjVjFPEoQ393jbJQ+cg7zVW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756425293; c=relaxed/simple;
	bh=BjJJ4QV8UNld/i//52PoaHJ541gNRNlFMthNNdcE9LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giITubhaor/WSTxiKGYsbvdM0Swctn6WEkIZffVUsgOD7htqA57Vwb4RPReljLmIuJtA1mm8KshaH+9fsrwW8aliT9D8TdMhCamQ8ET2Yro0WSHppwQs8Jj8Ll/MRByUuyFWbrQzxbkO5Gyqv/abkfQrnz5Og0/PROwlZIMIGCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E97y42YG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498FDC4CEF7;
	Thu, 28 Aug 2025 23:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756425292;
	bh=BjJJ4QV8UNld/i//52PoaHJ541gNRNlFMthNNdcE9LM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E97y42YGbMa8cIfyKqIpLC7a0NVPQUrlfSYaUmKrfE/1trw/bG9skMi4pwRLcAYnh
	 zUjAq5jo1Em4/mX/8iHSv/remjr+2QzXpE2Wb0wk3w41dWKp4nDbIyWqsNllyx2Tmg
	 85FerJu0fdrfbt4o1YbsrwkEWYosfWW9q9zAWE0e3hGwZyVltmUGSeZddxxvdr++o2
	 TvLJKjbF31qOvjuCgRjYldCAZTY6ti3Yih5Dxb7bU/DY/uhO1+L8jSWvmAoAx+FzrX
	 QstVgmxWmDzdfMH2hpGvJllGPnTT8nBJ0ZAjSxX/NiNe9u9xftke9DSpn35nJFPeCa
	 UIKxtsDATdRNA==
Date: Fri, 29 Aug 2025 02:54:48 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Denis Aleksandrov <daleksan@redhat.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, peterhuewe@gmx.de, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org, Jan Stancek <jstancek@redhat.com>
Subject: Re: [PATCH v2] tpm: prevents local DOS via tpm/tpm0/ppi/*operations
Message-ID: <aLDsSLVH4hdXTa2J@kernel.org>
References: <20250827022102.17731-1-daleksan@redhat.com>
 <e576d3a8-2693-4445-8cd0-997afb5e5dc2@molgen.mpg.de>
 <aK7-rTTqg--lM9if@kernel.org>
 <CAG+gbFd-Y=VO0c7zU8a9DtpAEHGDjhpwk_nsiBg5FHA1qVy4yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG+gbFd-Y=VO0c7zU8a9DtpAEHGDjhpwk_nsiBg5FHA1qVy4yg@mail.gmail.com>

On Thu, Aug 28, 2025 at 11:35:31AM -0400, Denis Aleksandrov wrote:
> On Wed, Aug 27, 2025 at 8:48 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Wed, Aug 27, 2025 at 07:55:23AM +0200, Paul Menzel wrote:
> > > Dear Denis,
> > >
> > >
> > > Thank you for your patch. In the summary, I’d use imperative mood:
> >
> > +1
> >
> 
> I can add this in a v3.
> 
> > >
> > > tpm: Prevent local DOS …
> > >
> > > Am 27.08.25 um 04:21 schrieb Denis Aleksandrov:
> > > > Reads on tpm/tpm0/ppi/*operations can become very long on
> > > > misconfigured systems. Reading the TPM is a blocking operation,
> > > > thus a user could effectively trigger a DOS.
> > > >
> > > > Resolve this by caching the results and avoiding the blocking
> > > > operations after the first read.
> > >
> > > If you could elaborate, how to test this, and in possible error cases, how
> > > to debug this – for example, how to disable the cache–, that’d be great.
> >
> > +1
> >
> 
> The issue is that this bug is not replicable on most systems, but the way that
> I've been able to test it is by running the following:
> $ time cat /sys/devices/pnp0/00:0a/tpm/tpm0/ppi/tcg_operations
> and
> $ time cat /sys/devices/pnp0/00:0a/tpm/tpm0/ppi/vs_operations
> On a system that I know is experiencing the DOS symptom.
> 
> For debugging, I've been using an unpatched kernel and running the same
> commands.
> 
> > >
> > > >
> > > > Reported-by: Jan Stancek <jstancek@redhat.com>
> > > > Signed-off-by: Denis Aleksandrov <daleksan@redhat.com>
> 
> I'll make sure to add the Suggested-by tag in the future, and the v3.
> Sorry about that.
> 
> > > > ---
> > > >
> > > > Changes in v2:
> > > >   - Replaced file permission change with a caching mechanism as
> > > >     suggested by Jarkko.
> > > >
> > > >   drivers/char/tpm/tpm_ppi.c | 88 ++++++++++++++++++++++++++++----------
> > > >   1 file changed, 65 insertions(+), 23 deletions(-)
> > > >
> > > > diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> > > > index d53fce1c9d6f..e0212893748e 100644
> > > > --- a/drivers/char/tpm/tpm_ppi.c
> > > > +++ b/drivers/char/tpm/tpm_ppi.c
> > > > @@ -33,6 +33,21 @@ static const guid_t tpm_ppi_guid =
> > > >     GUID_INIT(0x3DDDFAA6, 0x361B, 0x4EB4,
> > > >               0xA4, 0x24, 0x8D, 0x10, 0x08, 0x9D, 0x16, 0x53);
> > > > +static const char * const tpm_ppi_info[] = {
> > > > +   "Not implemented",
> > > > +   "BIOS only",
> > > > +   "Blocked for OS by BIOS",
> > >
> > > Is this x86 specific? If not maybe use *system firmware*?
> > >
> 
> This was the original implementation, but I can change the info message to
> be more general. I can add it to the v3.

Sure, no need for apologies it was just a remark :-)

Go ahead and send v3. I'll test that version.

BR, Jarkko

