Return-Path: <linux-integrity+bounces-5445-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D669A719B0
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 16:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C38D3A5F90
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 14:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E199C1F3B87;
	Wed, 26 Mar 2025 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3BMY7NN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6AB155C82;
	Wed, 26 Mar 2025 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001067; cv=none; b=ud7OLjSFzPRn9mVgbQg88T7A98uGqFc9H43suE4Qjr5FCoW0GVu40JhGo3Igdm2aF9eWcs5Fcd9XTQ8BqpZJlyyIbR1n/yNMQxQBEcRJqVzKwTSXWzRUGjGmscgYuECPIwyLrbkWtkFPxWJcznYaK+oRBbt9PX1mB2DeHfs6ouI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001067; c=relaxed/simple;
	bh=xN1v97k32cH32YUDw/w2dLs9w/r2mWW4ozAyNecjuCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJGiOp+CLFRuTpKpTIEnkA/Dl3RoZEeFMUUdejFDHKoeIDdBdOB6njYT5wEnTBGXZUjXnlAww2Ta4G1/2K8aUcaApJTChrX8esBLH8zaiEpslUAKN11pVykcETQU0I9aAM0D1G8ow1eJGNuTGWy+c2zenEVuzK5eKM7YpTjgJk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3BMY7NN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B2BC4CEE2;
	Wed, 26 Mar 2025 14:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743001067;
	bh=xN1v97k32cH32YUDw/w2dLs9w/r2mWW4ozAyNecjuCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3BMY7NNPalOxYdtJR6b+/6pxLFvMs+0LYwBewo+JDTDOlGP70oTkU70BYMHeKjeq
	 DB8+JQGj1CG/s0+3XJvRs4Cd9XhVnWTJN9rx+3nJfXmGTKWBLDVJcc5nBqFx47vEUO
	 QBR9BsiRCW5FMREvISugXx5UWaZbSrPItMsKP1xLSxXQKeVPeCXM+tPR4XvYLCA6bs
	 enLwZG/KFST0mmjb5jdr5uUUfNfSQvvxC6sC50XsXi+CeFbSMYscl32XyKbSTa7yQh
	 LqZeOzY4qr/6GCfk5jFsXTvLNLTur/oYUaFmXep3hMe+r/HRwwUHkkAxEUKGnPTyAx
	 O7IsszVBlt+YA==
Date: Wed, 26 Mar 2025 16:57:43 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sumit Garg <sumit.garg@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH 2/2] tpm/tpm_ftpm_tee: use send_recv() op
Message-ID: <Z-QV5y1JGBDpsPuH@kernel.org>
References: <20250320152433.144083-1-sgarzare@redhat.com>
 <20250320152433.144083-3-sgarzare@redhat.com>
 <Z-I86tWMcD6b_YeM@sumit-X1>
 <Z-Pu4FhcntnKii61@kernel.org>
 <Z+QQWe/upJuVpU8r@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+QQWe/upJuVpU8r@ziepe.ca>

On Wed, Mar 26, 2025 at 11:34:01AM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 26, 2025 at 02:11:12PM +0200, Jarkko Sakkinen wrote:
> 
> > Generally speaking I don't see enough value in complicating
> > callback interface. It's better to handle complications in
> > the leaves (i.e. dictatorship of majority ;-) ).
> 
> That is very much not the way most driver subsystems view the
> world. We want to pull logical things into the core code and remove
> them from drivers to make the drivers simpler and more robust.
> 
> The amount of really dumb driver boiler plate that this series
> obviously removes is exactly the sort of stuff we should be fixing by
> improving the core code.
> 
> The callback interface was never really sanely designed, it was just
> built around the idea of pulling the timout processing into the core
> code for TIS hardware. It should be revised to properly match these
> new HW types that don't have this kind of timeout mechanism.

Both TIS and CRB, which are TCG standards and they span to many
different types of drivers and busses. I don't have the figures but
probably they cover vast majority of the hardware.

We are talking about 39 lines of reduced complexity at the cost
of complicating branching at the top level. I doubt that there
is either any throughput or latency issues.

What is measurable benefit? The rationale is way way too abstract
for me to cope, sorry.

> Jason

BR, Jarkko

