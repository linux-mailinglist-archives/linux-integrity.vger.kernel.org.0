Return-Path: <linux-integrity+bounces-5471-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C75A732F6
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 14:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7F83B7501
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 13:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2651215769;
	Thu, 27 Mar 2025 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ey+q4tdY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFA12153D5;
	Thu, 27 Mar 2025 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743080556; cv=none; b=Pz7NztI9YdQvwDQyxEjLxuFYAiq7Sh2491XqQRzeBjIChr0E628XANK7E76a4DNyyogbGWXsyuVKoElMmF7W9Bj0EdnEtEC9f0yu42KOXSvpP6xgRGO4eKFMxZI+bGIZLLsjQmpsofFR6LERZ8i1Sm9fNBjcnsENG/7UEshItiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743080556; c=relaxed/simple;
	bh=Tdpl66XLAOtA5XmignFqms9SJMURQinLKq3XqPhPQTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqhRRhGSPNyE2Tgf8yxm4yDHqlgYdc7ngL/+ro+sq5j1d564dESM5x4vPamvBzmh3En3IoAdjI8YVOO5vvvhp6CCYzKe4w3WLMBemGw5mclTf0D0uV3FfMVfd3lcV/Tio+X+yQGvUN3HEiopqWHGmtY25SDTorQKcVeeGw28GFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ey+q4tdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93061C4CEE8;
	Thu, 27 Mar 2025 13:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743080555;
	bh=Tdpl66XLAOtA5XmignFqms9SJMURQinLKq3XqPhPQTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ey+q4tdYLa7txymgBaZV0kKiZE44zdPHKstItEEk5RPhQuVLGAZwa9v4R1fmngqVO
	 ijtDiwdZpnarcLF5rmeU8lJStrUFhNvMrzfoLwB4EXniQd/MAFRpYf0prlyo6e6UEl
	 74uqPC3bl7HWSQjrEdw/IAlXJuq5Y7mPwv24zodD/v1IZ3/Cf1mmMeW//SQLzAz0QJ
	 uxrIWyn/at0pMUfZjL80/lVPSTI6OkopLt84u+kAbhRzbBlQc8S9bGYE7JaPyZnuBe
	 nJuStxhkMrE0R+LRpQFM7WUPnI63UWjhkACqRCDlyBFG617M3INQO3IPYBQGGfvs/C
	 QfFj18jRf2BAA==
Date: Thu, 27 Mar 2025 15:02:32 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH 1/2] tpm: add send_recv() op in tpm_class_ops
Message-ID: <Z-VMWl9UDx5ZY1qK@kernel.org>
References: <20250320152433.144083-1-sgarzare@redhat.com>
 <20250320152433.144083-2-sgarzare@redhat.com>
 <Z-QxH7aDjlixl2gp@kernel.org>
 <eidmcwgppc4uobyupns4hzqz562wguapiocpyyqq67j5h26qbl@muhbnfxzqvqt>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eidmcwgppc4uobyupns4hzqz562wguapiocpyyqq67j5h26qbl@muhbnfxzqvqt>

On Thu, Mar 27, 2025 at 10:48:17AM +0100, Stefano Garzarella wrote:
> On Wed, Mar 26, 2025 at 06:53:51PM +0200, Jarkko Sakkinen wrote:
> > On Thu, Mar 20, 2025 at 04:24:32PM +0100, Stefano Garzarella wrote:
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > 
> > > Some devices do not support interrupts and provide a single operation
> > > to send the command and receive the response on the same buffer.
> > > 
> > > To support this scenario, a driver could set TPM_CHIP_FLAG_IRQ in the
> > > chip's flags to get recv() to be called immediately after send() in
> > > tpm_try_transmit(), or it needs to implement .status() to return 0,
> > > and set both .req_complete_mask and .req_complete_val to 0.
> > > 
> > > In order to simplify these drivers and avoid temporary buffers to be
> > 
> > Simplification can be addressed with no callback changes:
> > 
> > https://lore.kernel.org/linux-integrity/20250326161838.123606-1-jarkko@kernel.org/T/#u
> > 
> > I also noticed that tpm_ftpm_tee initalized req_complete_mask and
> > req_complete_val explictly while they would be already implicitly
> > zero.
> > 
> > So it reduces this just a matter of getting rid off the extra
> > buffer.
> 
> Yep, as mentioned I think your patch should go either way. So here I can
> rephrase and put the emphasis on the temporary buffer and the driver
> simplification.

Yes. Removing extra copy is a goal that can only make sense!

> 
> > 
> > > used between the .send() and .recv() callbacks, introduce a new callback
> > > send_recv(). If that callback is defined, it is called in
> > > tpm_try_transmit() to send the command and receive the response on
> > > the same buffer in a single call.
> > 
> > I don't find anything in the commit message addressing buf_len an
> > cmd_len (vs "just len"). Why two lengths are required?
> > 
> > Not completely rejecting but this explanation is incomplete.
> 
> Right.
> 
> The same buffer is used as input and output.
> For input, the buffer contains the command (cmd_len) but the driver can use
> the entire buffer for output (buf_len).
> It's basically the same as in tpm_try_transmit(), but we avoid having to
> parse the header in each driver since we already do that in
> tpm_try_transmit().
> 
> In summary cmd_len = count = be32_to_cpu(header->length).
> 
> I admit I'm not good with names, would you prefer a different name or is it
> okay to explain it better in the commit?
> 
> My idea is to add this:
> 
>     `buf` is used as input and output. It contains the command
>     (`cmd_len` bytes) as input. The driver will be able to use the
>     entire buffer (`buf_len` bytes) for the response as output.
>     Passing `cmd_len` is an optimization to avoid having to access the
>     command header again in each driver and check it.

This makes more sense. Maybe we could name them as buf_size and
cmd_len to further make dead obvious the use and purpose.

> 
> WDYT?

I just want to get this done right if it is done at all, so here's
one more suggestion:

1. Add TPM_CHIP_FLAG_SYNC
2. Update send() parameters.

You don't have to do anything smart with the new parameter other than
add it to leaf drivers. It makes the first patch bit more involved but
this way we end up keeping the callback interface as simple as it was.

I'm also thinking that for async case do we actually need all those
complicated masks etc. or could we simplify that side but it is 
definitely out-of-scope for this patch set (no need to worry about
this).

> 
> Thanks,
> Stefano
> 
> 

BR, Jarkko

