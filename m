Return-Path: <linux-integrity+bounces-5601-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FF5A7B89A
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Apr 2025 10:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B1597A59F1
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Apr 2025 08:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF014191F95;
	Fri,  4 Apr 2025 08:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3lwPypm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54D34438B;
	Fri,  4 Apr 2025 08:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743754216; cv=none; b=tlNGn+8NORLctq76/YTLESnIi1jldSOxORtelfHj5T1Ex4tBlJNqT4HbYplgPILcD1DV1sGe/pRnCLgUlUAG6rx2qTnG87SIBe1aPwYRp1UUIHch7iz7rw36PVBby4V/W9OyTFhkW/CJE55lFYFABa59I7+JKlrRuJfKh6HmcIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743754216; c=relaxed/simple;
	bh=JOJw4Ly+hN8nIycVX2Sr1keBTt4OC41cKR3dcNiASGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6Phc+IC2woXHDFbulaFM4COfK0f6E4Yb6EOJxbdGRsBzx2/+zECQZjVYw7FsfpklZjb3THTxMCskL6LQrsZFPypj4Lm3wjsHBOSVjldWWM/JcQOZS0OaIDUHEJbcpEJ3PtLROGrfgEMphfgWDpTKxuMsSaXrM8dLfP03aNqBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3lwPypm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BFBC4CEE9;
	Fri,  4 Apr 2025 08:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743754216;
	bh=JOJw4Ly+hN8nIycVX2Sr1keBTt4OC41cKR3dcNiASGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k3lwPypmo33BRdLKuruE2jxtOfSIfZLeGe7CwfwzL/OmTG6cOQNjLSae9Pki97J41
	 HDnmdJrJS0dv5NkLhq9lYN1uksjTUYzXTku9DbVP2Q9v4eYK6R4uYNAsB/LCU9a6dW
	 Oi0vw8tRpodiJe5YqBxjLlWBWN85MoyTDDM5DFo8bL/mbo8SYJAgeCR+QU0KsyFDN7
	 aWKCmbghfD7AGqQaJfHt+p2aD51zdtPgW3GIRn4AEiQAerolgev9RaQ/TZUeZyULim
	 +WDO1cSOtCUzxTqL/q14sqCNbx/U2VnZtk3+OXDyUzYozT90KbcE/8ZTfWfA6ex/UL
	 7kaRA16fYG84Q==
Date: Fri, 4 Apr 2025 11:10:12 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Jonathan McDowell <noodles@earth.li>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tis: Increase the default for timeouts B and C
Message-ID: <Z--T5LEsXddkTX-H@kernel.org>
References: <20250402172134.7751-1-msuchanek@suse.de>
 <Z-13xOebA3LvQQ-8@earth.li>
 <Z-7XQYP7_tXYR2Ik@kernel.org>
 <Z-7y5x3u6wVGFjj-@earth.li>
 <Z--PgeuYjRx6zXmG@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z--PgeuYjRx6zXmG@kitsune.suse.cz>

On Fri, Apr 04, 2025 at 09:51:29AM +0200, Michal Suchánek wrote:
> On Thu, Apr 03, 2025 at 09:43:19PM +0100, Jonathan McDowell wrote:
> > On Thu, Apr 03, 2025 at 09:45:21PM +0300, Jarkko Sakkinen wrote:
> > > On Wed, Apr 02, 2025 at 06:45:40PM +0100, Jonathan McDowell wrote:
> > > > On Wed, Apr 02, 2025 at 07:21:30PM +0200, Michal Suchanek wrote:
> > > > > With some Infineon chips the timeouts in tpm_tis_send_data (both B and
> > > > > C) can reach up to about 2250 ms.
> > > > >
> > > > > Extend the timeout duration to accommodate this.
> > > > 
> > > > The problem here is the bump of timeout_c is going to interact poorly with
> > > > the Infineon errata workaround, as now we'll wait 4s instead of 200ms to
> > > > detect the stuck status change.
> > > > 
> > > > (Also shouldn't timeout_c already end up as 750ms, as it's
> > > > max(TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C), and TIS_SHORT_TIMEOUT is 750 vs 200
> > > > for TPM2_TIMEOUT_C? That doesn't seem to be borne out by your logs, nor my
> > > > results.)
> > > 
> > > Just noticed that the commit did not end up having fixes etc. tags:
> > > 
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=de9e33df7762abbfc2a1568291f2c3a3154c6a9d
> > > 
> > > Should we forward to stable?
> > 
> > It's a TPM bug rather than a kernel issue, so I don't think there's a valid
> > Fixes: for it, but it's certainly stable material in my mind.
> 
> In the more general sense of Fixes: indicating where the fix is
> applicable it would be any kernel that supports TPM2.

I tried applying the patch on 6.1-stable:

~/work/kernel.org/stable/linux tags/v6.1.132
$ git am -3 ~/Downloads/infineon.patch
Applying: tpm, tpm_tis: Workaround failed command reception on Infineon devices
Using index info to reconstruct a base tree...
M	drivers/char/tpm/tpm_tis_core.c
M	drivers/char/tpm/tpm_tis_core.h
M	include/linux/tpm.h
Falling back to patching base and 3-way merge...
Auto-merging include/linux/tpm.h
Auto-merging drivers/char/tpm/tpm_tis_core.h
Auto-merging drivers/char/tpm/tpm_tis_core.c

If no counter-opinions, I'd add:

stable@vger.kernel.org # v6.1+

I based this on Bookworm kernel.

> 
> Thanks
> 
> Michal

BR, Jarkko

