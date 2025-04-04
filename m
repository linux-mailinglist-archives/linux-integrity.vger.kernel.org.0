Return-Path: <linux-integrity+bounces-5607-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F15BA7BC16
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Apr 2025 14:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A5B189FDA5
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Apr 2025 12:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA251DDA00;
	Fri,  4 Apr 2025 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8b8dSHo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA11CDFAC;
	Fri,  4 Apr 2025 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743767936; cv=none; b=THVEV80maUSZ4LaahsPt+EGqoAJGsEv2CuatGDd04DfWqU4yZ1esdNqb8DAdkHoG84h66yC+etDovIpWlkhrjvnZlCSiL0T8uuRvM958v7F3UiAMVK2Vb9900yYt9/2nefefg5oqT3tq+r63/CybgzqXrkIU51NmM9MqvNUcGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743767936; c=relaxed/simple;
	bh=L1ipA6ghftHVe27dfwT9Pe/CFAO/XalqKctlGIvJ044=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGBSqpwjXTMVgHF+hmecY5f7ubNQAHifcHqGYYFdtIxKy+ap5nXcq1l9IuxLfeaSNNMtjwt9TsNcWJPP6g4yKcm6wmWHWWJsx8pbNkvD6PUEIej24MMdGgvfx9kGe7FVT+iC95nCp9JH5xs5eza18/H84uvC0PmtZ+hBEA/f/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8b8dSHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F86AC4CEDD;
	Fri,  4 Apr 2025 11:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743767936;
	bh=L1ipA6ghftHVe27dfwT9Pe/CFAO/XalqKctlGIvJ044=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8b8dSHoRwbwEPHvL7tL2vNaKDlnvc81OrZDmNa1csOSwaODgSzfUc67vHtEeDNQx
	 3YNXZrheWNUVIKvje2ZK3ujBd0BEjPbHN1MIfqK7Gl5Oc0kLg8izo9MkXAnW7RkRs0
	 +hxWWSK11o7T1JO8+z6M9RuOe9TdzJVoUUoTySvuZY2zw1GZjwaULZLMqqJkoNlV1f
	 OZwmCMdYpG/VLPBlKYcYDzvXSxPXvzstpQx3HuEcrR/4eOW0Rt+Octx+09biMNIhlb
	 4OMZ/ym88J7vr0uZg5uwutn49Vgf/yg+at1KbDyUEKrN2e7OYZIFs/wWXQGrU/oalm
	 NYu83Xj1nKkzw==
Date: Fri, 4 Apr 2025 14:58:51 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>, Sasha Levin <sashal@kernel.org>
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] tpm: tis: Increase the default for timeouts B and C
Message-ID: <Z-_Je7evunNi7kz0@kernel.org>
References: <20250402172134.7751-1-msuchanek@suse.de>
 <Z-13xOebA3LvQQ-8@earth.li>
 <Z-7XQYP7_tXYR2Ik@kernel.org>
 <Z-7y5x3u6wVGFjj-@earth.li>
 <Z--PgeuYjRx6zXmG@kitsune.suse.cz>
 <Z--T5LEsXddkTX-H@kernel.org>
 <Z--m5rTDLLbyWEE5@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z--m5rTDLLbyWEE5@earth.li>

On Fri, Apr 04, 2025 at 10:31:18AM +0100, Jonathan McDowell wrote:
> On Fri, Apr 04, 2025 at 11:10:12AM +0300, Jarkko Sakkinen wrote:
> > On Fri, Apr 04, 2025 at 09:51:29AM +0200, Michal Suchánek wrote:
> > > On Thu, Apr 03, 2025 at 09:43:19PM +0100, Jonathan McDowell wrote:
> > > > On Thu, Apr 03, 2025 at 09:45:21PM +0300, Jarkko Sakkinen wrote:
> > > > > On Wed, Apr 02, 2025 at 06:45:40PM +0100, Jonathan McDowell wrote:
> > > > > > On Wed, Apr 02, 2025 at 07:21:30PM +0200, Michal Suchanek wrote:
> > > > > > > With some Infineon chips the timeouts in tpm_tis_send_data (both B and
> > > > > > > C) can reach up to about 2250 ms.
> > > > > > >
> > > > > > > Extend the timeout duration to accommodate this.
> > > > > >
> > > > > > The problem here is the bump of timeout_c is going to interact poorly with
> > > > > > the Infineon errata workaround, as now we'll wait 4s instead of 200ms to
> > > > > > detect the stuck status change.
> > > > > >
> > > > > > (Also shouldn't timeout_c already end up as 750ms, as it's
> > > > > > max(TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C), and TIS_SHORT_TIMEOUT is 750 vs 200
> > > > > > for TPM2_TIMEOUT_C? That doesn't seem to be borne out by your logs, nor my
> > > > > > results.)
> > > > >
> > > > > Just noticed that the commit did not end up having fixes etc. tags:
> > > > >
> > > > > https://web.git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=de9e33df7762abbfc2a1568291f2c3a3154c6a9d
> > > > >
> > > > > Should we forward to stable?
> > > >
> > > > It's a TPM bug rather than a kernel issue, so I don't think there's a valid
> > > > Fixes: for it, but it's certainly stable material in my mind.
> > > 
> > > In the more general sense of Fixes: indicating where the fix is
> > > applicable it would be any kernel that supports TPM2.
> > 
> > I tried applying the patch on 6.1-stable:
> > 
> > ~/work/kernel.org/stable/linux tags/v6.1.132
> > $ git am -3 ~/Downloads/infineon.patch
> > Applying: tpm, tpm_tis: Workaround failed command reception on Infineon devices
> > Using index info to reconstruct a base tree...
> > M	drivers/char/tpm/tpm_tis_core.c
> > M	drivers/char/tpm/tpm_tis_core.h
> > M	include/linux/tpm.h
> > Falling back to patching base and 3-way merge...
> > Auto-merging include/linux/tpm.h
> > Auto-merging drivers/char/tpm/tpm_tis_core.h
> > Auto-merging drivers/char/tpm/tpm_tis_core.c
> > 
> > If no counter-opinions, I'd add:
> > 
> > stable@vger.kernel.org # v6.1+
> > 
> > I based this on Bookworm kernel.
> 
> It looks like Sasha has already autoselected it for 6.1, 6.6, 6.12, 6.13 +
> 6.14.

Right! I can see also those mails, and exactly the version range I would
have proposed :-) Perfect, thanks Sasha!

> 
> J.
> 
> -- 
> How does it work?  I don't know but it does!
> This .sig brought to you by the letter R and the number 21
> Product of the Republic of HuggieTag
> 

BR, Jarkko

