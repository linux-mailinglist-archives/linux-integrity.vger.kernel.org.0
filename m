Return-Path: <linux-integrity+bounces-7051-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E404B51EA4
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Sep 2025 19:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26A83ADFBE
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Sep 2025 17:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD74D2D5406;
	Wed, 10 Sep 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDNWQ/iZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBDA329F0B;
	Wed, 10 Sep 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524255; cv=none; b=MLQcfuEabg2vWW5dAjL0LS8u1tJa/vcixzxgdKLHcJ2Q6prihxGGq5h6d3E6Ajl6kVG7WgewPkEdmbkBL1GABAFe4nDkdyaMRcOsAUJ6Ujv+umBf1WW1eyQwaFCxoDVL7nruM9bIEyt3RQpZAbESRM2NN6VRHUtrFDNAfmzEOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524255; c=relaxed/simple;
	bh=PeptklT0kkpC+qJQCy0ivRtO/PYK+E1202FFZp7v5n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gf50eKLaBjQZBhdcUlFXF33R8Lzba5h8dp1VUH3JLSjyLiZ92VZ1MMX+Xwq5+Z0YaXINM8P58xMfMvaVxkNzBYjpFBvOpeTN6NMWlx9Y3JYriPAKu8HJC+DhKqzAc98RckhX0P+m1hvVAXI4M/hE+u8A8oZrTTJpoALaCu5qHLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDNWQ/iZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C411C4CEEB;
	Wed, 10 Sep 2025 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757524255;
	bh=PeptklT0kkpC+qJQCy0ivRtO/PYK+E1202FFZp7v5n8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CDNWQ/iZUm8bMMKkw490e7NfaLqGPdA9w/ES4uIfe4v+U3svPCEJaEgNypMRC8pUU
	 QYrWGVwKmJf04TkJmk7RQby/JEoKBx8oQX2G42myu183qw6ScZUh04O1NzHNfK+Ab2
	 XvcqN+rULwbl9+age9ZGKGk2MjDI45vQC7a/f8ay8GCicTXNXp2LkHGCZYEAPr8NaE
	 lhRHZKOALFL7Y8B+EGNGh6BASHSGV1ruQ/Rdblqu/Z0mGt5FMorzBY8eJO84AT28aL
	 XOqw3p6rNSfGoMJcZs9/qXTLKBSRcJZgQO4Hcwp8/TuBqcTbJhH7oOsyun9vDuOmgx
	 4z8ImgVP37YVA==
Date: Wed, 10 Sep 2025 20:10:51 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tpm: Compare HMAC values in constant time
Message-ID: <aMGxG4BSc0UgXqxl@kernel.org>
References: <20250801212422.9590-1-ebiggers@kernel.org>
 <20250801212422.9590-2-ebiggers@kernel.org>
 <aJIMGWFDZejNwAVP@kernel.org>
 <20250805160740.GA1286@sol>
 <aJckvs9mIO_BscPQ@kernel.org>
 <20250809173839.GB3339@quark>
 <20250904023828.GD1345@sol>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904023828.GD1345@sol>

On Wed, Sep 03, 2025 at 07:38:28PM -0700, Eric Biggers wrote:
> Hi Jarkko,
> 
> On Sat, Aug 09, 2025 at 10:38:39AM -0700, Eric Biggers wrote:
> > On Sat, Aug 09, 2025 at 01:36:46PM +0300, Jarkko Sakkinen wrote:
> > > On Tue, Aug 05, 2025 at 09:07:40AM -0700, Eric Biggers wrote:
> > > > On Tue, Aug 05, 2025 at 04:50:17PM +0300, Jarkko Sakkinen wrote:
> > > > > 
> > > > > I think we might want to also backport this to stables.
> > > > > 
> > > > 
> > > > That's what I did originally, but on v1 James complained about it being
> > > > characterized as a fix.
> > > 
> > > Please put out v3 with backporting shenanigans and I can apply these.
> > > 
> > 
> > v1 had Fixes and Cc stable
> > (https://lore.kernel.org/r/20250731215255.113897-2-ebiggers@kernel.org/).
> > Again, I removed them in response to James' complaint about it being
> > characterized as a fix.  If you want them back, please go ahead and add
> > them back in when committing.  I'm not going to go around in circles.
> > 
> > - Eric
> 
> Could you let me know how you'd like to proceed here?  Thanks.

Thanks for reminding. I applied them to my local tree and will push
tomorrow.

> 
> - Eric

BR, Jarkko

