Return-Path: <linux-integrity+bounces-5347-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A13A6AAF0
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 17:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9912F3B4DF3
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 16:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4571EB195;
	Thu, 20 Mar 2025 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTgrWY/E"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B7917B402;
	Thu, 20 Mar 2025 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487688; cv=none; b=CCEjzrqo2xr7605ToExcPjXI3R1oyMXYhl+VqsjJuG+SO91TEU5kd/PokGei3vsSyETF2a4tcHc2pddj9y6F2x0dY3XSlds8N+YOgK5LlVZFeBuWoRTbykSOz+PbmFqx32ktnnph4wFksvAM9EBCDPWapHyCvmZvWWqmBnXkPMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487688; c=relaxed/simple;
	bh=68gyuZ9MiytLAMaRvZoTBEumWAPyxnmorS74ObmW0AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heJoGsclG35pCBPL/HUBnxiz7ZcF/ajjVlssxwnp25T3N2VlsGpnbTDd4iarjUMUEekA5tc6W8lXJie8JvOJtws441nk11pBpXYVCdBoIdnaq4wlbhGmCIHhASl8ZyDAYgQT2WGI3ursYCzAWE3smMlsniQQ+NcrXQX7iGkcr2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTgrWY/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE958C4CEDD;
	Thu, 20 Mar 2025 16:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742487688;
	bh=68gyuZ9MiytLAMaRvZoTBEumWAPyxnmorS74ObmW0AE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kTgrWY/E9YISB4CPczzcqb+fUaZxaZFhFNC2PsCmezPLr8n0z3hQi7rwdpNMlT4cX
	 dNc8rcfQQiMMN5+IMsDcdA8OWUhFyb5LjcWY/1f/sRqr/m8TcA/1vY4D3VPJ5chuaR
	 vnKNJ6H4nX3dVTdOr4l1uSEA7IRZxoXwglEN/Hr3Q+nf1gEuz0mIZ98RaIDxeloRzq
	 qmY6b2FwPW+8mAWZendTvMOXk8tTm9+Rks7dzyn4qJlCwtoh4EkmAv8UwORqKhbV/h
	 vMXe+dExxbGNN+/eLFVVv7oiIAwZtihBs1V1vrT0owbCoT/vlVjqp7FoK0qYPVU/vL
	 gNOstlXswMW4w==
Date: Thu, 20 Mar 2025 18:21:23 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: End any active auth session before shutdown
Message-ID: <Z9xAeLYrOg-pkcui@kernel.org>
References: <Z8rls0QkzOliECp_@earth.li>
 <Z9rWqCutMrz6sAgQ@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9rWqCutMrz6sAgQ@earth.li>

On Wed, Mar 19, 2025 at 02:37:28PM +0000, Jonathan McDowell wrote:
> Gentle poke about this patch, which I haven't seen any feedback for.  It's
> causing us a problem in terms of having a string of kexecs result in the
> kernel no longer being able to talk to the TPM with an HMAC session, and the
> rng random data fetches from the TPM then failing.

Sorry, this was unintentional!

I applied the patch to my master branch now.

BR, Jarkko

