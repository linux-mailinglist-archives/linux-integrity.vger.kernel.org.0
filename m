Return-Path: <linux-integrity+bounces-7736-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FC5C926AF
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 16:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C09E4E17A9
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 15:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918C930BBB7;
	Fri, 28 Nov 2025 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVCOtnxV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D4B275AE3;
	Fri, 28 Nov 2025 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764342643; cv=none; b=Efm64P7K85kPU2+sbg3TFV8IRN9e4r8L8S+WrHUZHP5iaECaPiMY6bj0kntH/tNXJvsluQpjtbMzvyO5p8047ZmuEyo5aJmQTW7sXnTD3C+yheOv++UqLLF2tYtR+mbYGO3o46ffHB+4ge5S5SZ02dSsuCu6ixpjlyPACFepllM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764342643; c=relaxed/simple;
	bh=6kO7PhSZet0QkltiCcVstJ36FFQT/yKkDpmNYpYfnMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mf4/XXidvjXmseXoa4drkNe6wCpgHf4TvHaqcUUjefT6mbtBQBfg0UTP7Ldk26bXtrLhPNEqVtIbl5UZfJ2UTExE0SJRAlels95L/lI0L67Z/hTsbJGKAtSBGSPIlXlZWDuVnQy6YvrL+XSH2YjyvUtND6/uAJ4/IMqE97JPNHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVCOtnxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E072C4CEFB;
	Fri, 28 Nov 2025 15:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764342642;
	bh=6kO7PhSZet0QkltiCcVstJ36FFQT/yKkDpmNYpYfnMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LVCOtnxVXcXWPjGwX/UHQBn0WkP1olyQhxUn7T16ZXlcnB23DayrWaKd7cf/MJOxZ
	 cicGv5ptlYCqhq4bdQA8q8nwmH8akLNYqFlf1JRyNUAhgA2bfidyzGaqIF0mhnGvxr
	 NIxKRcyfS3hR9wHiFRsmg8WHrdN5K3wVy/cP/lw2DA1rtjCEOE9Trww0an+jZdhSci
	 YAbYlcDI8e+mptPaxeLFbfeBoGqcO+bEX0yCihNT80yIevdjvbar19nupaNcLLE+yq
	 tTsnqYv3V2UFdEsqzoSTHESJQhpFtccc3e1BQPCcSbNS/UYgOeiNtw/3F0FpCtgIOD
	 t7W49iwHB6anA==
Date: Fri, 28 Nov 2025 17:10:39 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: linux-integrity@vger.kernel.org, ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Jonathan McDowell <noodles@meta.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/11] tpm: Cap the number of PCR banks
Message-ID: <aSm7bwsqhqzWHETW@kernel.org>
References: <20251127135445.2141241-1-jarkko@kernel.org>
 <20251127135445.2141241-2-jarkko@kernel.org>
 <69de8fea4851ef378613e66685c3c34c43d71f05.camel@huaweicloud.com>
 <aSiG7l_1E12r_56c@kernel.org>
 <a6e73690e73b7a3e190719d179dbc73b93d1c1f1.camel@huaweicloud.com>
 <aSid1oEcDY9mzwq4@kernel.org>
 <eff8c944622851683597a4738a2089c4b9a15b71.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eff8c944622851683597a4738a2089c4b9a15b71.camel@huaweicloud.com>

On Fri, Nov 28, 2025 at 10:21:57AM +0100, Roberto Sassu wrote:
> On Thu, 2025-11-27 at 20:52 +0200, Jarkko Sakkinen wrote:
> > On Thu, Nov 27, 2025 at 06:17:42PM +0100, Roberto Sassu wrote:
> > > On Thu, 2025-11-27 at 19:14 +0200, Jarkko Sakkinen wrote:
> > > > On Thu, Nov 27, 2025 at 05:09:38PM +0100, Roberto Sassu wrote:
> > > > > On Thu, 2025-11-27 at 15:54 +0200, Jarkko Sakkinen wrote:
> > > > > > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > > > > > 
> > > > > > tpm2_get_pcr_allocation() does not cap any upper limit for the number of
> > > > > > banks. Cap the limit to eight banks so that out of bounds values coming
> > > > > > from external I/O cause on only limited harm.
> > > > > > 
> > > > > > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > 
> > > > > Sorry, I realized that you are expecting me to review.
> > > > > 
> > > > > I have a couple of questions:
> > > > > - Could you explain better how out of bounds would occur, since one
> > > > >   could check the number of PCR banks?
> > > > > - Is dynamic allocation that bad? And if yes, why?
> > > > > - Couldn't you just check that the number of available PCR banks is 
> > > > >   below the threshold you like and keep dynamic allocation?
> > > > > - Is removing tpm1_get_pcr_allocation() improving code readability?
> > > > 
> > > > nr_possible_banks is read from external source i.e., neither kernel nor
> > > > CPU fully control its value. This causes *uncontrolled* dynamic
> > > > allocation. Thus, it must be capped to some value.
> > > 
> > > Sure, I'm fine with capping. Isn't that enough?
> > 
> > It makes sense to make the whole memory allocation then infallible,
> > especially since it does not have much effect on diff. And it has
> > not significant effect on memory usage either.
> 
> Ok. In that case (even if it does not get in):
> 
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Thank you :-) It's not a serious but categorilly it is still a bug, and
these types guards of them help to detect more serious bugs that cause
weird values to passed on to otherwise legit code (and that makes it
also utilitarily useful).

BR, Jarkko

