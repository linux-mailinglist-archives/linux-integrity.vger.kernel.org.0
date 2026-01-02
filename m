Return-Path: <linux-integrity+bounces-8151-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39636CEEFD2
	for <lists+linux-integrity@lfdr.de>; Fri, 02 Jan 2026 17:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D26AF3016CE8
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jan 2026 16:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0AC2C0F6E;
	Fri,  2 Jan 2026 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEZUpQOz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3D62C029A;
	Fri,  2 Jan 2026 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767371871; cv=none; b=dVXGUeKPjHcpyKXxs+gob30jaGhYmVCjWtTAl4gENaTluGE6tVdU35rHv6HMQbJaqOCV/OFKCem5JqwN87hTBhyBvpoOIrwlzx3426qPq2Z79CVMFwJ1BGFDPYPPtnv/qrDRGH/qndp9xOaW8Edi8vfq66yHr8ih4DXYegyaku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767371871; c=relaxed/simple;
	bh=VbbSdjGoPNyzxh0k0yMWn6nnijnsNc02fHiCQfLRwiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXyGscgardD41uytHJ0SRZ/GjYJJ10tWc2Ca+r/wuk8SsbWdA9SFUFjEKpIbhkGWgCcSxS7qSg06mtYf5bhZ05jaOS2FrNYFDt2POP2T6734RLMEI/TtdlnSwBEbDRJHuCIbnQH0lHr4jaeIcywE3lCewvN3xyZSuRAhngl/2bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEZUpQOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25501C116B1;
	Fri,  2 Jan 2026 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767371867;
	bh=VbbSdjGoPNyzxh0k0yMWn6nnijnsNc02fHiCQfLRwiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEZUpQOz29NmXP/3GJWiWv1lV8KLofnFPszDrpr/Xr2SeEz3PrFYqluvReoiIbsEq
	 JsMFN1zdNKov2pRU5WcFP7/k2yppXUJvJG9WGgvIdLTc4NuVpHTcvFkboCe/uhGc3I
	 ETuPLq39j+/UIq4cjv/PHcRW9D+FavzsWivnyQLz5Uez6n2AUAjythhNdCVrT51acg
	 YfI/NwvnWiCivEBUFzvwYFjI6lGNaPCf+6pT/fNeCtC7tKvDvouc4wuuO2z2laYICH
	 MthTwQHuA/kvfALhBcbTNEqC2n17CdHGip2+A/UVtQ+Gydu/MMz0mlHJ9dy/K7wG7T
	 7+ZLIBJvHLv8Q==
Date: Fri, 2 Jan 2026 18:37:43 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v8 04/12] tpm: Change tpm_get_random() opportunistic
Message-ID: <aVf0V7GOtekOiSi7@kernel.org>
References: <20251216092147.2326606-1-jarkko@kernel.org>
 <20251216092147.2326606-5-jarkko@kernel.org>
 <aUUd760l89lrNOs-@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUUd760l89lrNOs-@earth.li>

On Fri, Dec 19, 2025 at 09:42:07AM +0000, Jonathan McDowell wrote:
> On Tue, Dec 16, 2025 at 11:21:38AM +0200, Jarkko Sakkinen wrote:
> > hwrng framework does not have a requirement that the all bytes requested
> > need to be provided. By enforcing such a requirement internally, TPM driver
> > can cause unpredictability in latency, as a single tpm_get_random() call
> > can result multiple TPM commands.
> > 
> > Especially, when TCG_TPM2_HMAC is enabled, extra roundtrips could have
> > significant effect to the system latency.
> > 
> > Thus, send TPM command only once and return bytes received instead of
> > committing to the number of requested bytes.
> 
> Function comment for tpm_get_random needs updated as well, as it currently
> says "until all of the @max bytes have been received", which is no longer
> true with this patch. With that:
> 
> Reviewed-by: Jonathan McDowell <noodles@meta.com>

Thank you and definitely can refine that comment. After holidays it is
probably to go through this patch set with time and send +1 iteration
:-)

BR, Jarkko

