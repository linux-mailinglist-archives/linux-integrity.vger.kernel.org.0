Return-Path: <linux-integrity+bounces-8237-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35259D200C7
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jan 2026 17:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08BA0307767E
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jan 2026 15:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9C239C659;
	Wed, 14 Jan 2026 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6wDpZkn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD3F394487
	for <linux-integrity@vger.kernel.org>; Wed, 14 Jan 2026 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406295; cv=none; b=a1nTBeR0w3o8v5MeuZwLUkjY1L+K/EtJdLDsW3YhR8FgJLANnjez7bBpZsRuz0uun8q4YCrja9E3lfBvSpRen0rD+ml+QBHf2rmSl9EtetpW7Ld5Zsary6f12pBvl3JinImyjAeKtIiUqrbFyL4ch7gMTPzT2F/e0fWHACyRUmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406295; c=relaxed/simple;
	bh=AhKOx9WGxdl63a5YPTMY3qUySL9oDSlEXQvGK45ZLIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEBw+Byc4HD2usYXYNZSDYr7ALe0WejfdE5r2ad7tduMu/eoM3MnGTvnQit5TY99vGXRMjlpB8ZEEYhBMAE5lYan+v2z7jZ0mp9k+FOzVKFGEeDG3u1mEuYqMQFjn3GicUZ1l76guzOES+2D6jrZBymDBb95Vo5Am/Lr2UxLYIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6wDpZkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96F9C4CEF7;
	Wed, 14 Jan 2026 15:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768406295;
	bh=AhKOx9WGxdl63a5YPTMY3qUySL9oDSlEXQvGK45ZLIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R6wDpZkn+vwmYqca9R3+RIxbiF8cbJIOYJGKOkWHakNuaOQCph2iG4jbdAS1QLZ1g
	 UxThDm56F7TSCBQ6VCaF6lM0zpekRiOVG/jUYw72p6XLghNFIKzxFGXLI0eyR6ndFS
	 Dc3oI5yxztCQw/EWyKzgGrIUZKt10u3ZyI9oaD6CGd8Ix8omUVaA3dH6hzvazg5F1f
	 DtY2RB3w9MEN4HCmsvXKy5GPxKEy63x9XHY6TC0rbqJ9tAAPZkJIk1MccRZ8qKsufo
	 3IusGeQ7iiKNa2Seb5duE2ORgS3eL/5IZAAmqwHhjRWCRGWXhLBJ6LCxnrHpR8emho
	 KmPegUvDWm62A==
Date: Wed, 14 Jan 2026 17:58:11 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	linux-integrity@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] tpm/tpm_ftpm_tee: Fix kdoc after function renames
Message-ID: <aWe9EzWskkSB0Sv-@kernel.org>
References: <20260113143816.1600893-2-u.kleine-koenig@baylibre.com>
 <CAHUa44G+2PWzOnj6smTR9vES06hrwry-SaSj-FcPJgVccNTSXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44G+2PWzOnj6smTR9vES06hrwry-SaSj-FcPJgVccNTSXg@mail.gmail.com>

On Wed, Jan 14, 2026 at 07:47:09AM +0100, Jens Wiklander wrote:
> On Tue, Jan 13, 2026 at 3:38 PM Uwe Kleine-König
> <u.kleine-koenig@baylibre.com> wrote:
> >
> > Recently ftpm_tee_probe() and ftpm_tee_remove() grew a suffix in their
> > function name but I failed to adapt the kernel doc when doing so. This
> > change aligns the kernel doc to the actual function name (again).
> >
> > Fixes: 92fad96aea24 ("tpm/tpm_ftpm_tee: Make use of tee bus methods")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202601132105.9lgSsC4U-lkp@intel.com/
> > ---
> >  drivers/char/tpm/tpm_ftpm_tee.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Looks good to me. Jarkko, OK, if I also take this patch via my tree?

Works for me that way too with my r-by tag.

> 
> Cheers,
> Jens
> 
> >
> > diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> > index 20294d1953a3..b82490439633 100644
> > --- a/drivers/char/tpm/tpm_ftpm_tee.c
> > +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> > @@ -163,7 +163,7 @@ static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
> >  }
> >
> >  /**
> > - * ftpm_tee_probe() - initialize the fTPM
> > + * ftpm_tee_probe_generic() - initialize the fTPM
> >   * @dev: the device description.
> >   *
> >   * Return:
> > @@ -266,7 +266,7 @@ static int ftpm_plat_tee_probe(struct platform_device *pdev)
> >  }
> >
> >  /**
> > - * ftpm_tee_remove() - remove the TPM device
> > + * ftpm_tee_remove_generic() - remove the TPM device
> >   * @dev: the device description.
> >   *
> >   * Return:
> >
> > base-commit: 92fad96aea24fc19abe1eae2249402b61de3a3e2
> > --
> > 2.47.3
> >

BR, Jarkko

