Return-Path: <linux-integrity+bounces-6179-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E75AB360F
	for <lists+linux-integrity@lfdr.de>; Mon, 12 May 2025 13:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3ADF17C61F
	for <lists+linux-integrity@lfdr.de>; Mon, 12 May 2025 11:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F369E29209D;
	Mon, 12 May 2025 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbeIR/9T"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD933255227;
	Mon, 12 May 2025 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747050149; cv=none; b=J/wmIJ9v+TMFdh7tcOSoz5IXNj9wWMapoabs7qfE2MBQ/q7YR+IucrTUyfw36L2plMT3y/0lg3ISX0jz+YXjWn0NQ/EGwG6WnFBzoEw5+O/j7hcAArskUA9jIcdnC8TYWe1/XV0ZERgi8zdIA7yXvMPW9QfLfmf4VGxDLTEWBpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747050149; c=relaxed/simple;
	bh=G+iZK/fJWTYrFKszSrPiBYm4ohAZS1672uKXRst4nIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WX1TkPSDMM9wrcF86kXW7aNwkXuHGMJ1z5zkwdv5PyK8iHTnH5QURQuwIa/B62PmUVsnnxZAGBGosoMYjbonY6t0i/cXN1DHvL38EXtG5kJv3xdycCLyYkSDEzm/+4E8/uj+EzZXsEzN+Pt26pRSxmL+5vhGvC/KIJxPQtfFmzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbeIR/9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C4CC4CEE7;
	Mon, 12 May 2025 11:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747050149;
	bh=G+iZK/fJWTYrFKszSrPiBYm4ohAZS1672uKXRst4nIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RbeIR/9Te4YzbM4nys+aPrS0lal+55xmPrwruMsQWxrNKNwpg2gh/11ARF59CgmbI
	 t02IgBG7HRvHav0q6NVtyF9AmsY0t8ROsIeKJR8BEHteNHsJr6PmZxdKs6RqF6HfSY
	 YCkzQZnmLQAHIpY5ahdTr1AWtHOr+5oviU7jnSPNdk9dvROmuV8IKy8AafCqgdC1G7
	 LYBWFUL9K4cEFTG45n6CSonq9mmr0pBEwRwQjUKdw4qXW9uqYw5K9gfRoVeITOreJQ
	 0njHAduTZlI1eTW63AQZ5cm6r4tHdEm1zg9Pas8WdgOD2RHnMiKUwS2XOudqL7rmUX
	 BlobEQ8KMr21g==
Date: Mon, 12 May 2025 14:42:25 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, keyrings@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [v3 PATCH] KEYS: Invert FINAL_PUT bit
Message-ID: <aCHeoSBOLF-mcY7I@kernel.org>
References: <aB3OsMWScE2I9DhG@gondor.apana.org.au>
 <aBccz2nJs5Asg6cN@gondor.apana.org.au>
 <202505091721.245cbe78-lkp@intel.com>
 <1960113.1747041554@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1960113.1747041554@warthog.procyon.org.uk>

On Mon, May 12, 2025 at 10:19:14AM +0100, David Howells wrote:
> Herbert Xu <herbert@gondor.apana.org.au> wrote:
> 
> > Invert the FINAL_PUT bit so that test_bit_acquire and clear_bit_unlock
> > can be used instead of smp_mb.
> > 
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> Acked-by: David Howells <dhowells@redhat.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

David, are you going to pick this?

BR, Jarkko

