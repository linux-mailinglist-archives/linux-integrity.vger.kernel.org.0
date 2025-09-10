Return-Path: <linux-integrity+bounces-7048-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56242B51E84
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Sep 2025 19:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9224F1C85A6F
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Sep 2025 17:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D6028C03E;
	Wed, 10 Sep 2025 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlM8pALg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E477285411;
	Wed, 10 Sep 2025 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523877; cv=none; b=rzmhHf5jZj1lT9tENfzEYnVunF/clL505RYA7qeaeUJvnvW/YFslTxxDrxzbMqRr5+6pMxzDIUnPEnvb/O4k4Zpvnl4LOvFO2hsWHyhoYlel5IOxWWZ0yj6oev3/Pu8V0GsuByioGb8Uto/be9QAdeffTliz1NbEOMu4/Zsvnlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523877; c=relaxed/simple;
	bh=jvJwuh/KqHkn4fHv0K+i/0piQ3f6u3ZXk9iz3QN96ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCuOOtT+mu4PayRGexzCj6KUfTZVdF7oP1YROxwJggZKcfK6g0L6XkPMUWEfv7yDkdO2eUAQepkz3DKtg1vSE5oBaLhWHAJy2LTac2ccaIPkT4FRq8NJuX5WToJ7xdXYh4UhBS7ME7fnjfoLL2dfvNrIbdalGpXMi9uCK7kX7IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlM8pALg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD8FC4CEEB;
	Wed, 10 Sep 2025 17:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757523876;
	bh=jvJwuh/KqHkn4fHv0K+i/0piQ3f6u3ZXk9iz3QN96ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VlM8pALgJpwL5qxEepukh1ayIbag/+tsa5YKTd65UbUIu4B8vRolKJtdMBoMz2cUU
	 L6QrBZqKyY/9iD3Tkyen9W364PFNNYEa2o3zFO3J2cZw3EmX2gWud6S3Zv15bVckoh
	 +A0TVadVVX+iDkr6uYEni5typLkGABiCNbeV46h7oyzL3ZTqdMuTHji9OvHqUcUQfN
	 vFddgFEoPGOkHCLEMaxbLr/In6fru2kldcAVxzJSnCWI1OGmD6N7RRMXcPXeFXAAhl
	 kO0LQCjVgAKdyxSpy9+uM41qB7U5op8+dRPNCgZrlbu3BF1qytNs+jUGW2QzpUcKni
	 iCKRecCn2u0rQ==
Date: Wed, 10 Sep 2025 20:04:33 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] tpm: Allow for exclusive TPM access when using
 /dev/tpm<n>
Message-ID: <aMGvoXduH9sK0noi@kernel.org>
References: <cover.1756833527.git.noodles@meta.com>
 <37c3349265f9b9ef834a996fa6808a7512875376.1756833527.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37c3349265f9b9ef834a996fa6808a7512875376.1756833527.git.noodles@meta.com>

On Tue, Sep 02, 2025 at 06:27:10PM +0100, Jonathan McDowell wrote:
> From: Jonathan McDowell <noodles@meta.com>
> 
> There are situations where userspace might reasonably desire exclusive
> access to the TPM, or the kernel's internal context saving + flushing
> may cause issues, for example when performing firmware upgrades. Extend
> the locking already used for avoiding concurrent userspace access to
> prevent internal users of the TPM when /dev/tpm<n> is in use.
> 
> The few internal users who already hold the open_lock are changed to use
> tpm_internal_(try_get|put)_ops, with the old tpm_(try_get|put)_ops
> functions changing to obtain read access to the open_lock.  We return
> -EBUSY when another user has exclusive access, rather than adding waits.
> 
> Signed-off-by: Jonathan McDowell <noodles@meta.com>
> ---
>  drivers/char/tpm/tpm-chip.c       | 53 +++++++++++++++++++++++++------
>  drivers/char/tpm/tpm-dev-common.c |  8 ++---
>  drivers/char/tpm/tpm.h            |  2 ++
>  drivers/char/tpm/tpm2-space.c     |  5 ++-
>  4 files changed, 52 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ba906966721a..3d69ccff4c2a 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -144,7 +144,7 @@ void tpm_chip_stop(struct tpm_chip *chip)
>  EXPORT_SYMBOL_GPL(tpm_chip_stop);
>  
>  /**
> - * tpm_try_get_ops() - Get a ref to the tpm_chip
> + * tpm_internal_try_get_ops() - Get a ref to the tpm_chip
>   * @chip: Chip to ref
>   *
>   * The caller must already have some kind of locking to ensure that chip is
> @@ -154,7 +154,7 @@ EXPORT_SYMBOL_GPL(tpm_chip_stop);
>   *
>   * Returns -ERRNO if the chip could not be got.
>   */
> -int tpm_try_get_ops(struct tpm_chip *chip)
> +int tpm_internal_try_get_ops(struct tpm_chip *chip)

I'd rather name the new function e.g., tpm_try_get_ops_locked.

Like both from the perspective of more localized patch and also
that "locked" documents more tan "internal".

BR, Jarkko

