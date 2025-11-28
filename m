Return-Path: <linux-integrity+bounces-7740-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB77C92E02
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 19:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAF954E19C8
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 18:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4840B258EDE;
	Fri, 28 Nov 2025 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0J+50zt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2197023E32D;
	Fri, 28 Nov 2025 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764353149; cv=none; b=qgLxB41hppiyv9NUdnn9DYXDe6pu2EwwrnmctWnyoZRqJ9KDCF5yqaU2B70Rn0VxpRYT+BwmW5gxO8FYWd5Rdz+QM9YBlhhLVh1ZmHJxxWXoyC0F5ar/OnR/ptFRPlClBiKYn4SyJtds/lSwLQZVfraDFF65CzleRfC6cQltwqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764353149; c=relaxed/simple;
	bh=sqxZvjjTbrrgue5i9b1rqQh6dBDU0Pb4oOuiCH7yYcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkltWOQlIMwUFfJ/qYOQRXPg0OOP1xApt37pAMb+Mts/QmYXVgliTpT1zjajxI3EvJoNiRO85yx51eYeTnfRbslO8jdyi636BlP99HeZkRugSnil/BZukGyXWsgkzETz1rxunJusnCWmFDsNW/2X9jy6Mr/YBH1GqbjflEkWvPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0J+50zt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A602C4CEF1;
	Fri, 28 Nov 2025 18:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764353147;
	bh=sqxZvjjTbrrgue5i9b1rqQh6dBDU0Pb4oOuiCH7yYcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B0J+50ztAOdsraPPs86SOo+apSe26nzMQF3vwPYnlOfUSp7Mn4ojpvfCyjR6L2No6
	 aqWOXsxaBiymMoC4kpE8GHLxt9hfhsbNLCGsHDKPVE1roTRJ94JXgpETrh3qM/AxnN
	 m3pWunkCEtMiKOiaL/BXO/zwmG9cbD4FEQ06mY7f3xsVfZB0OMRnEjzokKlTXl78LX
	 E56BPbFX4tx5bJuRcGxLujYnAfHbRpCRzlH5PEVXTVJ6xC9kU7UY+BIMu3fip0RZyA
	 huxzyMDGwKTVCFOyy0cZv6oLIyNsVuNTyJ8oErlAv8pzF8GgA/bCBBNZapaZ2A41l2
	 OjAtdAgL0Qd7Q==
Date: Fri, 28 Nov 2025 20:05:42 +0200
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
Message-ID: <aSnkdn86LW5mfjey@kernel.org>
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

https://lore.kernel.org/linux-integrity/aSnQZ4pRWqJai6FW@kernel.org/T/#u

I renewed the PR as I had to drop one patch so it's there in place :-)

Thanks again for reviewed-by.

BR, Jarkko

