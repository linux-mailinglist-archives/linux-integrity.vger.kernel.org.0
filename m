Return-Path: <linux-integrity+bounces-6788-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A206B1F42A
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Aug 2025 12:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377C217DB61
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Aug 2025 10:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E653242D9B;
	Sat,  9 Aug 2025 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9xXoNJX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D393F17BBF;
	Sat,  9 Aug 2025 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754735810; cv=none; b=QJc7cQOWJfxICV9ZVxHWHTy/wkNsB2LOvpzQgib8eb7LlN/CBNEvaYpOdrKthOYrmU0FMw6jrNu/hB5v0H0HEUpU6gJSIR/wuzNCgMIH2axEculbRpkLviWHt4ney1ZocMwaADr87xWWqtfjuvRbED5Ze4HjESwLVN6Qd382beE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754735810; c=relaxed/simple;
	bh=irkFrpvguBFdjMkE8ph+mR64/d+gfVlxX7KDzV2t3yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ms3tvf9eKMcZx0b7OKsAa0RBb2YyrC4DZYfe1Vw15UbX7Ous95whx9sRuRFEJQ6SF6PWtaGO8XYg1tHQuCZEL+Sv+GAo+oG/T8eI4noIKgJxSR9PHQukPEV3bHt94xdq3mPIAf02VutGjtSUkDD8lbj3ivi5m6UOPWSYMdMP3Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9xXoNJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019A6C4CEE7;
	Sat,  9 Aug 2025 10:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754735810;
	bh=irkFrpvguBFdjMkE8ph+mR64/d+gfVlxX7KDzV2t3yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s9xXoNJXOHYgRiemWRZfdeU0oAObyeUNBfBDclo4M0XzhgDVNpi12+OxBRQZJq0IX
	 c8jciddohCZtCwRIYoO2NNIRaDuzJkDDSTiDc2d5sv8F8XMmo2+5qN6+5va8BncJtI
	 Kne+ccbWNjuCXoPnSAwQaJkd0ihA3hFWaU5B4cmUQogJ4rV7ninqzbzhWLnBQtWbzG
	 PViWYdeJFYBSWt6bp+eztUJIbeEX4EStSLax6/ZSG7yx/Hi8zL07v+U4J4t4erri27
	 SJ2weEtmpg8hxEmZ3VARhpZv+3HZ5ebRnsNTUNZ71dXCALc7iOr3LXG6SQIoGlMPJ9
	 pvN1Bs21QSGDw==
Date: Sat, 9 Aug 2025 13:36:46 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tpm: Compare HMAC values in constant time
Message-ID: <aJckvs9mIO_BscPQ@kernel.org>
References: <20250801212422.9590-1-ebiggers@kernel.org>
 <20250801212422.9590-2-ebiggers@kernel.org>
 <aJIMGWFDZejNwAVP@kernel.org>
 <20250805160740.GA1286@sol>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805160740.GA1286@sol>

On Tue, Aug 05, 2025 at 09:07:40AM -0700, Eric Biggers wrote:
> On Tue, Aug 05, 2025 at 04:50:17PM +0300, Jarkko Sakkinen wrote:
> > 
> > I think we might want to also backport this to stables.
> > 
> 
> That's what I did originally, but on v1 James complained about it being
> characterized as a fix.

Please put out v3 with backporting shenanigans and I can apply these.

> 
> - Eric

BR, Jarkko

