Return-Path: <linux-integrity+bounces-7799-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DD973CA5028
	for <lists+linux-integrity@lfdr.de>; Thu, 04 Dec 2025 19:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C89F3022838
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Dec 2025 18:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A33A334C0A;
	Thu,  4 Dec 2025 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGYrVcBu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6641D63F0;
	Thu,  4 Dec 2025 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764874059; cv=none; b=I1aZluz2DmAL3emODDML8BVpjA1ELr1YErX6JW2QHD+o7b+IdSGPko9IvoTehvi70BCQxLQeNHEFpjhrAAB1S6ZUvcHc22EI8wIUKt5/oJSHNg3qqsOFpOzA/Etr5NCShs9t0diXPoJjPksUwLz4LkXtPv0VDZTN/PWijVGE9t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764874059; c=relaxed/simple;
	bh=aBxY+yeXb15BcB6Xl5bDbKq9uRhz1HRl79Z86J6Ybu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTeWQ45DasXDi5mH+fWyfQrScOmIQJBlZ2ZS64mBTn/gyklt3ipeV0Nz8biSkTt03Ziy7qsb4eMmlgrMgE43EFCc5UfOsfcq8nd9qcVCyc3gj1SX0/7i1BJm4UpBkH7RfKKMCd94b6V5185szBOk1tznS6wtHmmZ2/tE4fmOPs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGYrVcBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7199BC116C6;
	Thu,  4 Dec 2025 18:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764874059;
	bh=aBxY+yeXb15BcB6Xl5bDbKq9uRhz1HRl79Z86J6Ybu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGYrVcBuE68nPW1f8ynVRAwgA597ivDkxHiMwvaNGKPBwsWiVxo1jaiEjKVGS2iCW
	 I68+t3ERUCIAMJdKMzxH9AS8WzmDQkateiJeF/wpFjqL8w5WTrH8KkhSnsyqKGUkmr
	 9esKVfbQpMj/2NH+RB7PmaPkfjjd8rIlHw5OhELkVQb2yX/ByyP73Srqg3IreRo2IX
	 546D/K8CseJD+5FvvVSsLe73uUY5e/hu7RmVstFn1Y+XH2JXDeuYqtdlAig2nbtqsv
	 cv4mLKJiIcQLZgHSVJVJyeYE8Q1D+bhiAbBwe9p7MhcKH/WLCIyRetdcPanJNCAvk7
	 sgVMWjqcgZiow==
Date: Thu, 4 Dec 2025 20:47:34 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] tpm2-sessions: fix out of range indexing in
 name_size
Message-ID: <aTHXRuvbUkCiQQAL@kernel.org>
References: <20251203221215.536031-1-jarkko@kernel.org>
 <20251203221215.536031-2-jarkko@kernel.org>
 <aTGkno0fzQMHXc7X@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTGkno0fzQMHXc7X@earth.li>

On Thu, Dec 04, 2025 at 03:11:26PM +0000, Jonathan McDowell wrote:
> On Thu, Dec 04, 2025 at 12:12:11AM +0200, Jarkko Sakkinen wrote:
> > 'name_size' does not have any range checks, and it just directly indexes
> > with TPM_ALG_ID, which could lead into memory corruption at worst.
> > 
> > Address the issue by only processing known values and returning -EINVAL for
> > unrecognized values.
> > 
> > Make also 'tpm_buf_append_name' and 'tpm_buf_fill_hmac_session' fallible so
> > that errors are detected before causing any spurious TPM traffic.
> > 
> > End also the authorization session on failure in both of the functions, as
> > the session state would be then by definition corrupted.
> > 
> > Cc: stable@vger.kernel.org # v6.10+
> > Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> A minor whitespace query below, but:
> 
> Reviewed-by: Jonathan McDowell <noodles@meta.com>

Thanks. I updated the commit and removed the extra whitespace.

BR, Jarkko

