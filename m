Return-Path: <linux-integrity+bounces-8238-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFE6D202F7
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jan 2026 17:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2B36300908E
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jan 2026 16:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2916F3A0E81;
	Wed, 14 Jan 2026 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuoXLnCZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EF531B108;
	Wed, 14 Jan 2026 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407707; cv=none; b=OWm0fAWHaFgmlCDW+rTORLuGhWosdmYvgaHrukTKQ3FriWp+Txn810BcYtBTGi0qdJqS+kaBryKyQpc2F0PAorvyUV7pGe/zQAZ8Y2mTa5BY/uK962fvIN5GIzAxc+eBRRB16P9l8pL2KXGYbuoT0aQjdAhPQfpnA7JXgjVH088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407707; c=relaxed/simple;
	bh=0uBHXLZlnYYBIVGGFSZ6N7bZ/j0TInBMfIjXlel1Ems=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhuL/I+LfTmLvM5FcWuLRIMt7yJdxRtitBCXKjlM+piz8Ed6q3Kn+Mr2vU6w49ldn1DhNx6MkFr/9Rgm/jCIoQPots6NMR0NkT1rMz6MgLveZHs6XBfDuPICkG2Nss+nTfTzr7NL02OZ0AGXKCZj1+b8Q23y24DQ4jONtTufwXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuoXLnCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7BFC4CEF7;
	Wed, 14 Jan 2026 16:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768407706;
	bh=0uBHXLZlnYYBIVGGFSZ6N7bZ/j0TInBMfIjXlel1Ems=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nuoXLnCZ/RJhkJGVfxYpRojNHy0knql+uJVK/49tgHIGDdfq9vKd5c+fTFkg6iXFw
	 +7ViOKhS8SbzFCbWAcov4CNvxybi9v0wr4e+t0WrouJe7+wQPNoA0JYH11YVNx7yIV
	 6b6Efr6r1lC5HvfqY0jjRPuufdlMr/VZb0Z0AQXo6scyMxrzKQtPeCr6U2fEDQUIGH
	 EkHkalQUg/Bds1DSrp0CPW4Rvog40eicWObrQ7ijqAUb37Txgqi3eWEI5CE3C/Yp33
	 djwsQocHzBPDa9aq/L0c2eP14k8QBlIhiOlwylsLovr2rZ/vG4FPFs1m89+Q/wQWfO
	 0kAwpReE0uAeA==
Date: Wed, 14 Jan 2026 18:21:42 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, linux-integrity@vger.kernel.org,
	Jonathan McDowell <noodles@meta.com>
Subject: Re: [PATCH] tpm2-sessions: Fix out of range indexing in name_size
Message-ID: <aWfClpKGFgVJ7zQr@kernel.org>
References: <20260108123159.1008858-1-jarkko@kernel.org>
 <aV-kD5iKi9fwluU0@kernel.org>
 <2026010931-cling-enjoyer-9ce6@gregkh>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026010931-cling-enjoyer-9ce6@gregkh>

On Fri, Jan 09, 2026 at 10:45:51AM +0100, Greg KH wrote:
> On Thu, Jan 08, 2026 at 02:33:19PM +0200, Jarkko Sakkinen wrote:
> > On Thu, Jan 08, 2026 at 02:31:59PM +0200, Jarkko Sakkinen wrote:
> > > [ Upstream commit 6e9722e9a7bfe1bbad649937c811076acf86e1fd ]
> > > 
> > > 'name_size' does not have any range checks, and it just directly indexes
> > > with TPM_ALG_ID, which could lead into memory corruption at worst.
> > > 
> > > Address the issue by only processing known values and returning -EINVAL for
> > > unrecognized values.
> > > 
> > > Make also 'tpm_buf_append_name' and 'tpm_buf_fill_hmac_session' fallible so
> > > that errors are detected before causing any spurious TPM traffic.
> > > 
> > > End also the authorization session on failure in both of the functions, as
> > > the session state would be then by definition corrupted.
> > > 
> > > Cc: stable@vger.kernel.org # v6.10+
> > > Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
> > > Reviewed-by: Jonathan McDowell <noodles@meta.com>
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > 
> > This is for v6.12.
> 
> Does not apply anymore to the latest 6.12.y release, can you rebase and
> resend?

Sure, I'll fix the issue (reproduced locally) and also run my smoke tests [1]
before sending anything.

> 
> thanks,
> 
> greg k-h

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd-test.git

BR, Jarkko

