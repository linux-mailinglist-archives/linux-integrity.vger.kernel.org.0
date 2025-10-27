Return-Path: <linux-integrity+bounces-7535-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F94C115C8
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Oct 2025 21:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30CE1A27E53
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Oct 2025 20:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F6F2652AF;
	Mon, 27 Oct 2025 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXmshEGw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019E20B212;
	Mon, 27 Oct 2025 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761596293; cv=none; b=ugIBSgQWZXxXQJgcAjx5Pd05te7NhaW0K/7qade63PgTd5TkScUxaKqdt+Cqi8r0Kpo7iCYVgSeXFo1RIDuX7OuGQTOr9K25KJWF+M0fQ/kJDdrQdXNeF8lXvXl8D5vzOfhojDDOXcLyuRkJ34e1GEZRKMi1kyPsVvM4CtmgSJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761596293; c=relaxed/simple;
	bh=ysCxOLuzWtWfg3BB6WQ58AoN2L/h+P0qZsxhA9ei9rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANenV6Hk9qmpZ8FP7miSyFk5ov21oJQJ9mlDtCqIO3WNls8vNVhhYmB0QbvHnipge7VBu+h9f1Bn5iQ3/FGWVBWtpStaABDoFYW/HIttPQYnH50i0fQZpbPY8yrzlnckknlLV6xEzUOnxbtl+Yq9zm2bIPG5usbubTXGG5cZZ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXmshEGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEE2C4CEF1;
	Mon, 27 Oct 2025 20:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761596290;
	bh=ysCxOLuzWtWfg3BB6WQ58AoN2L/h+P0qZsxhA9ei9rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXmshEGwwhE8FbyCEqI3FYM38x5EHNTqfuc2TcpfiF92N1TTOCzRzeKIRjhCt8tlX
	 mmaoqtdfksQaFmFShdmmoSuzZs3EZByEV6neQkVtla7HJOAmRgb3u8tNhBffnZ7ua1
	 z8VoiyWCxltzpR91C82wIQ2RzUZTCb1JfhbtTaqiIGlAcHCWF0B7o1ZacgOAuobvyS
	 0Se3oFqp4uSdrLmxL+r/SDqAk6SPCg1tC0bwFUfMJkQe6kVNlGgAd8Zb7UnhHK1xe4
	 5fiiafJ9SQFdlSenrsf2fbD88yqIzcYtghPX1i4UFB6t4nxNmPbXBXmY1iuMKx9jU7
	 RnPrlpXDG79Rg==
Date: Mon, 27 Oct 2025 22:18:06 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Jonathan McDowell <noodles@earth.li>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	zohar@linux.ibm.com
Subject: Re: [PATCH v3 4/4] tpm: Allow for exclusive TPM access when using
 /dev/tpm<n>
Message-ID: <aP_Tfl9B-CW49ukN@kernel.org>
References: <cover.1760958898.git.noodles@meta.com>
 <61049f236fe1eaf72402895cea6892b52ce7e279.1760958898.git.noodles@meta.com>
 <cec499d5130f37a7887d39b44efd8538dd361fe3.camel@huaweicloud.com>
 <aP_KT0GiQSzt1ClO@kernel.org>
 <feb863c3e73f0b73b53d7d6f9889c79d37476855.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feb863c3e73f0b73b53d7d6f9889c79d37476855.camel@HansenPartnership.com>

On Mon, Oct 27, 2025 at 04:09:35PM -0400, James Bottomley wrote:
> On Mon, 2025-10-27 at 21:38 +0200, Jarkko Sakkinen wrote:
> > On Mon, Oct 20, 2025 at 01:53:30PM +0200, Roberto Sassu wrote:
> [...]
> > > Hi Jonathan
> > > 
> > > do I understand it correctly, that a process might open the TPM
> > > with O_EXCL, and this will prevent IMA from extending a PCR until
> > > that process closes the file descriptor?
> > > 
> > > If yes, this might be a concern, and I think an additional API to
> > > prevent such behavior would be needed (for example when IMA is
> > > active, i.e. there is a measurement policy loaded).
> > 
> > Also this would be a problem with hwrng.
> > 
> > This probably needs to be refined somehow. I don't have a solution at
> > hand but "invariant" is that in-kernel caller should override user
> > space exclusion, even when O_EXCL is used.
> 
> Also, are we sure we need O_EXCL in the first place?  A well
> functioning TPM is supposed to be able to cope with field upgrade while
> it receives other commands.  When it's in this state, it's supposed to
> return TPM_RC_UPGRADE to inappropriate commands, so if we made sure we
> can correctly handle that in the kernel, that might be enough to get
> all this to work correctly without needing an exclusive open.
> 
> Of course, Field Upgrade is likely to be the least well tested of any
> TPM capability, so there's a good chance at least one TPM out there
> isn't going to behave as the standard says it should.
> 
> Regards,
> 
> James

I get that depending on configuration someone really would want to
have guaranteed exclusive access to the device. Since it is opt-in
via O_EXCL, I don't have anything in principle againts adding it.

The patch set needs rework but feature itself is totally fine.

BR, Jarkko

