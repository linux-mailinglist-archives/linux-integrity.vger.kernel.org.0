Return-Path: <linux-integrity+bounces-7013-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBA6B42FDC
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Sep 2025 04:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FC468215D
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Sep 2025 02:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0891F872D;
	Thu,  4 Sep 2025 02:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/tZSzDy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E849C2628D;
	Thu,  4 Sep 2025 02:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756953579; cv=none; b=E/wE1+V0RW5RTJ/eWoYE5RsKIu5UFlXsotXWuqcya4Me4RsY5ZQ4aml7coMjnp9Sn6o9dl1XJz/mB53cKGPfTUTU9XbX/o8bH/zAQlSdpCS6Qypk1fTh9nHWG7iKYJ9lvUeosDd50LppqPTeTm/PskX0vAipZDoslsvNR31utdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756953579; c=relaxed/simple;
	bh=+GyTzgWEDCXjTXVJ47nkGKxQtubtxyZPtcXtGTwBI2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMIP208e5Hw9R7+ldUlAQbQqd0GxP61oKwCik+lSBUFuAFVDXe3eGurRyA9utL5/G0ZNhxLQc1cO7Vo3YdjQOLoRUNm7RQ8Vo8mPPoWVtQlgReBQJyXgvez3uvTqbGPgSIPNyOxh09+cY6/vfMl3JuGMr11yHchL+2rryel8cek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/tZSzDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27477C4CEE7;
	Thu,  4 Sep 2025 02:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756953578;
	bh=+GyTzgWEDCXjTXVJ47nkGKxQtubtxyZPtcXtGTwBI2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q/tZSzDyIQLsVEyVcyH/fxJGiymnsRrLbBlpPeTokxlJ28cGUHoj2KNHaIJf3t6JT
	 iBIPab56M4lE6P0aZ0pUZ5UPxYVpLDiwsJc2moBBnMzgcMTIJpwO+RuMp4gc5u3BTq
	 GtcpXyOGBJ2RCtkImotuw8uR6soNKNJgy7SkEo8BnrexMwbsYH+1d9WPD3NCv5v0Ka
	 pGfDw89mrN8TMAS4TfK3fG5HUeN2/FyiJfQLeWIsXib7m1f32G6yNMVS1PW5lTQCCK
	 tuqIqA+vqsgISAQMIdkf+ZrU7YLrdice/9i1KKJFTIAjhf6rlzJXi1tQTqxuggWHS3
	 PsKBzgVn9KnFQ==
Date: Wed, 3 Sep 2025 19:38:28 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tpm: Compare HMAC values in constant time
Message-ID: <20250904023828.GD1345@sol>
References: <20250801212422.9590-1-ebiggers@kernel.org>
 <20250801212422.9590-2-ebiggers@kernel.org>
 <aJIMGWFDZejNwAVP@kernel.org>
 <20250805160740.GA1286@sol>
 <aJckvs9mIO_BscPQ@kernel.org>
 <20250809173839.GB3339@quark>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809173839.GB3339@quark>

Hi Jarkko,

On Sat, Aug 09, 2025 at 10:38:39AM -0700, Eric Biggers wrote:
> On Sat, Aug 09, 2025 at 01:36:46PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Aug 05, 2025 at 09:07:40AM -0700, Eric Biggers wrote:
> > > On Tue, Aug 05, 2025 at 04:50:17PM +0300, Jarkko Sakkinen wrote:
> > > > 
> > > > I think we might want to also backport this to stables.
> > > > 
> > > 
> > > That's what I did originally, but on v1 James complained about it being
> > > characterized as a fix.
> > 
> > Please put out v3 with backporting shenanigans and I can apply these.
> > 
> 
> v1 had Fixes and Cc stable
> (https://lore.kernel.org/r/20250731215255.113897-2-ebiggers@kernel.org/).
> Again, I removed them in response to James' complaint about it being
> characterized as a fix.  If you want them back, please go ahead and add
> them back in when committing.  I'm not going to go around in circles.
> 
> - Eric

Could you let me know how you'd like to proceed here?  Thanks.

- Eric

