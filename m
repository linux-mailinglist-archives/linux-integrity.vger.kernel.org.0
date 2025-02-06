Return-Path: <linux-integrity+bounces-4738-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A26A2B374
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Feb 2025 21:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF977A1041
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Feb 2025 20:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC6D1CBE8C;
	Thu,  6 Feb 2025 20:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmvCpBBX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84FC155757
	for <linux-integrity@vger.kernel.org>; Thu,  6 Feb 2025 20:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738874137; cv=none; b=OVMYw/N7BLbLR5kE6Ky6A2g1gtAv1vC8zrikvizEFjH9CsGUJvSKHQapLrY/l+7w8Iwyw/JTgpeucZHQ1pSzHMq2sPufnxO99SknHMUdo+3TN2JweG27ld3U3QUvDL7kFT2shZEanwVAqj2z+HKliYbZcfBt+ZBz2XE4JZQqcd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738874137; c=relaxed/simple;
	bh=l+IYtwmKJxT8YhgMr5aq2i1Tw57OuYQE4MUV4oA1Zzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fgli8XzFWnloftKXGF46c44ju1bravHJwt2KTJIVdsEzI3mDly6rgmvf9Xw6tXsTGvF045kZ9sQ1zgHAxtLtui2mETpzFeOrFGPgttMu3wV0vw3oFWoVkRRW0ui/P/IsyZOXajtfpKZ+bKIjJvxpv0bMdWv8rYj4jdrAI4zAq9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmvCpBBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2978C4CEDD;
	Thu,  6 Feb 2025 20:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738874137;
	bh=l+IYtwmKJxT8YhgMr5aq2i1Tw57OuYQE4MUV4oA1Zzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cmvCpBBXa6eCJZ4qCu2IINegsb8zawjwfu00kAW5/GXq/yWS+fkDyhRR1wy+mYljJ
	 rxlnCcufK0TMlIH62RIBBIliuoSUqc6pnp71x4Q58iNsFzCu3cuJVbsvn0HeplyPk5
	 cCpaGIT+qQRKfo7r40G9gKxYfF/uVRPK20KlnM+dWaLLb0svyfwJqIlhV7SxhvCh0Z
	 5CNYLfddZCz5rOdvHqbyxe8x+RtJ3zlQf3F/1WSdECj1mdgCj3PWrY5vvwU5i7rp8d
	 GhhjTA7wXb0IU1/7bgFIvVHBiJDLkJG6nq0+ZeQOxgaE8/0pMNL30wnloyGIOZ1+i+
	 PAIKMyY8zcj8w==
Date: Thu, 6 Feb 2025 22:35:32 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z6UdFCdqCNZ8VGOL@kernel.org>
References: <Z5pRKcZKc3FUzP8Q@earth.li>
 <D7FSS837QLNR.5XOU66J6FBTU@kernel.org>
 <Z5yLYVBn6inIH8cG@kitsune.suse.cz>
 <D7G6P7W7AY65.257WPBC8I3HAF@kernel.org>
 <Z5zJ7R6vDU4h9iDk@kitsune.suse.cz>
 <D7GFCNGDK7S6.1X0KPPHF1TXBO@kernel.org>
 <Z50IKdYe42_n2B0b@kitsune.suse.cz>
 <D7GIBDO5KJMD.118CQO10LJ79Y@kernel.org>
 <Z6Nm7Y8TFF8YG56Z@kitsune.suse.cz>
 <Z6N10NQY75hpX0Ed@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6N10NQY75hpX0Ed@earth.li>

On Wed, Feb 05, 2025 at 02:29:36PM +0000, Jonathan McDowell wrote:
> Interesting. TPM2_CC_CONTEXT_LOAD (353) / TPM2_CC_FLUSH_CONTEXT (357) /
> TPM2_CC_CONTEXT_SAVE (354) I kinda expect to maybe take a bit longer,
> but TPM2_CC_GET_RANDOM (379) is a little surprising.

The whole arithmetic with timeout_a/b/c is mostly gibberish and could
be replaced with a single "max" constant without issues (just set it
large enough).

They could be all be replaced with let's say 3s timeout in a constant.

> > Failure is observed with another chip type as well:
> > 
> > localhost kernel: tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id
> > 22)
> > 
> > TPM Device
> >         Vendor ID: IFX
> >         Specification Version: 2.0
> >         Firmware Revision: 7.83
> >         Description: TPM 2.0, ManufacturerID: IFX , Firmware Version: 7.83.3358.0
> >         Characteristics:
> >                 Family configurable via firmware update
> >                 Family configurable via OEM proprietary mechanism
> >         OEM-specific Information: 0x00000000
> 
> That looks like an SLB9670, not running the latest firmware (7.85). I
> think that might have the errata I've been trying to work around; my
> current patch in testing (with logging to see how effective it is):
> 
> commit d8c680ec34e7f42f731e7d64605a670fb7b3b4d1
> Author: Jonathan McDowell <noodles@meta.com>
> Date:   Mon Aug 19 09:22:46 2024 -0700
> 
>     tpm: Workaround failed command reception on Infineon devices
>     
>     Some Infineon devices have a issue where the status register will get
>     stuck with a quick REQUEST_USE / COMMAND_READY sequence. The work around
>     is to retry the command submission. Add appropriate logic to do this in
>     the send path.
>     
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index fdef214b9f6b..561d6801e299 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -464,7 +464,12 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>  
>  		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
>  					&priv->int_queue, false) < 0) {
> -			rc = -ETIME;
> +			if (test_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags)) {
> +				dev_err(&chip->dev, "Timed out waiting for status valid in send, retrying\n");
> +				rc = -EAGAIN;


I'm not sure why wait_for_tpm_stat() return value is ignored but it
should not be like that. E.g. it can return -ERESTARTSYS. Probably
would be better to check all the call sites for it that they do
same thing.

I.e. rc = wait_for_tpm_stat(...);

/* ... */

BR, Jarkko

