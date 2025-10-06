Return-Path: <linux-integrity+bounces-7388-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E549CBBF04B
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Oct 2025 20:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC5E3B5B6F
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Oct 2025 18:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19992D480F;
	Mon,  6 Oct 2025 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huyGJNgw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9538523A58E;
	Mon,  6 Oct 2025 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759776615; cv=none; b=IwCHYSPmENPPAC4vZvEDJve7fLI+uBSKzGBDR4XUxzwBaX9g5zbswi/NGIg/hHr283THdSF6LibAliOy4pAcazkD+ezrvRFklfxMih6MYwZKlQm115c0aUOc0yB7RoXOAttkO6rErD3Crg8jMpgz81t9vFHwGHiZyecqeC+McaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759776615; c=relaxed/simple;
	bh=oYXN7rLD3gtjZiRSYbxun0bwTVmxYxH26vAytle1D1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQ1Zp4knQSlLZfET9fn5o/cVoVnj65GMMvTzR+GqRwAJVKUgIHHl0wfgEMtS5PKLF3ViqOH+04qPudHmR03EPbL+a0Zzp+W8yB2fa947Lyj6S7JoNj5107qR1SzZ5/qE/oYsyDwDnIXqMc2NZdpMZJOBQeDqGtpC2PjthYLYpEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huyGJNgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82FBC4CEF5;
	Mon,  6 Oct 2025 18:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759776615;
	bh=oYXN7rLD3gtjZiRSYbxun0bwTVmxYxH26vAytle1D1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=huyGJNgwS8oUZZCDdWvf7PVife/G+HjSgd6ai1LBsd2Osf5gJGQ/gB12rsrybsFsf
	 0I5C+BgmBwX6sPoHTs7o6NFkgvQUNyEx8rBLoDomWfZ0NnG0qbFrMkcAWoC+URt/TJ
	 NI0E9BsCKEN0KkgYeGMv1RlKQbw9OOlRERv+9d5+ta+dX7eUpd5OnSsWiNPbj793qW
	 YYml5oQqCGyzrznclN8BHHgcO2r6HQt7Et110KFrkprCX1OAOaUAVBiwknSuKjkssU
	 OXtv6R3VXrINSd1AZalqqW/H5ziHwvNpuBZZVxFXjUfDKG0u5o8wS04V8pouhfy7MX
	 G/usjs+XAjqjg==
Date: Mon, 6 Oct 2025 21:50:11 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18
Message-ID: <aOQPYwrGwZfP-GsV@kernel.org>
References: <aOKTFv1vh1cvvcLk@kernel.org>
 <CAHk-=wiCWiDcLEE3YqQo78piVHpwY2iXFW--6FbmFAURtor2+w@mail.gmail.com>
 <aOOu1f1QWQNtkl6c@kernel.org>
 <aOPOZwp_inGui9Bx@kernel.org>
 <125ba81bb222cdffef05ef9868c68002efd61235.camel@HansenPartnership.com>
 <aOPzovsBYlH3ojTR@kernel.org>
 <aOP2DUj67yB0afUt@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOP2DUj67yB0afUt@earth.li>

On Mon, Oct 06, 2025 at 06:02:05PM +0100, Jonathan McDowell wrote:
> On Mon, Oct 06, 2025 at 07:51:46PM +0300, Jarkko Sakkinen wrote:
> > My main issue preventing sending a new pull request is that weird list
> > of core TPM2 features that is claimed "not to be required" with zero
> > references. Especially it is contraditory claim that TPM2_CreatePrimary
> > would be optional feature as the whole chip standard is based on three
> > random seeds from which primary keys are templated and used as root
> > keys for other keys.
> 
> My understanding here is that the main specification about what's 
> "required" for TPMs to implement is from the PC Client Platform TPM 
> Profile. There's no specific server PTP (though there is talk about 
> creating one), so _most_ vendors just implement the PC Client PTP. It 
> doesn't mean a TPM that doesn't do so isn't TPM compliant, just not PC 
> Client PTP compliant.
> 
> Google have taken the approach in their Titan based TPM implementation 
> to avoid implementing features they don't need, to reduce attack 
> surface.

If it is an internal product, it does not qualify for as an argument but
good that you brought this detail out. I mean the action is the same
and debate is really what are correct preconditions for taking any
action.

So I'll cover the next trial for PR with:

1. I'll retain my existing commit with no changes.
2. In the cover letter I can address the details brough by Chris with
   the clause that Titan specific arguments are not basis for any
   decision making, as it is wrong and does not scale given that
   any possible company in this planet can have their own random
   incompatible partial TPM implementation (and most likely there
   are at least few of such).
3. I'll link Chris' message to the email. I.e. based on other
   claims in that mail we can already fully justify the action
   itself. I'm just knowingly ignoring that list of "incompatible"
   features, and remark that so that the process is transparent.

> 
> I'm not aware of anyone else who has done this.
> 
> J.
> 
> -- 
> ... You non-conformists are all alike.

BR, Jarkko

