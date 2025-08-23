Return-Path: <linux-integrity+bounces-6893-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB833B32C91
	for <lists+linux-integrity@lfdr.de>; Sun, 24 Aug 2025 01:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B369E7979
	for <lists+linux-integrity@lfdr.de>; Sat, 23 Aug 2025 23:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C277C2459C5;
	Sat, 23 Aug 2025 23:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CksC3QQU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9873C21256A;
	Sat, 23 Aug 2025 23:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755992466; cv=none; b=AoNgVfQwJ1hBkiPnV11LsoKm8uyfHUMD3hxQcado3L+r0uNEhj4RINbb3ATf3k+zz8gYtVPSGwVKotkLQLxu1UymLhDIOVOOMti526cCs371qPE6cKsoSfYSkyX4BecT2vFmEIeJl+OUBiKJbUKjy9gkb23UScl0nc42DZlBsrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755992466; c=relaxed/simple;
	bh=PLM7ZLHUJEF2Fn2NWVSpDUXAmGmM/rlFg8UApN6Upm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRcXveQV2NkCDmlz8NiQ/cQh5v8gMiWAyEfNFuDn386ZptsAKDIyEH4b4VF8LW46sr/JnMQ1fyyk9G4d3v4pwPiQOilFSnEOyKsP2P9FhjM4li/h4Jm0VZZjJRhLqW/8UC/aI5ENRbg3JnhuDg91CvpANeEj4cmb65euZAiuaqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CksC3QQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA29DC4CEE7;
	Sat, 23 Aug 2025 23:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755992466;
	bh=PLM7ZLHUJEF2Fn2NWVSpDUXAmGmM/rlFg8UApN6Upm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CksC3QQU1LYpGNtez34pBwoF3kKTrpGsylhmv6vT9qdvy9TPh7ACR0oJFXRKhjJrD
	 X9hfSejAChDUgXuHxz/km50q3ZDrHOy0AoFLAfAYJDWcdVoaSoQWE6RbDTg/Lm5+aJ
	 85sldyfFbM9X9FTSsrzWYNP4G+yM5mWt0Z2JfjfZElgLAaw4HR4+I+JjBhb0TfsMtg
	 yC28ZzcUpY94cl0Dg7LDdoHmlsyapyfRAoYozmhD8IicTbz8yzhu3t/nPgWOIQvjUI
	 JQw5ICak9OcRgKY55e/qFuk3H3j6Zi2akjUeM+y32phi1lr5OvctHUeuIitBmuqFgA
	 FOL51/1MBYXUg==
Date: Sun, 24 Aug 2025 02:41:02 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: Using Rust on non-Rust side of kernel
Message-ID: <aKpRjgkhz5C9YM-o@kernel.org>
References: <aKmyg0auI8jHuAmZ@kernel.org>
 <BE42A51A-60C4-4E79-8459-CADEAB8DC3BA@collabora.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BE42A51A-60C4-4E79-8459-CADEAB8DC3BA@collabora.com>

On Sat, Aug 23, 2025 at 11:38:00AM -0300, Daniel Almeida wrote:
> My somewhat limited understanding here is that you’re trying to implement Rust
> code that can be called from the rest of the kernel, but that otherwise doesn’t
> depend on it? 

OK so please fill me up with rest of the email I'll respond to this
uncluttered part.

First of all, it's fully TCG spec complete in-stack implementation
with no dependencies, does not use allocator, no_std all implementation,
which can run even on bare metal and could empower chips. tpm2_protocol
generates bidirectional parsers and builders to both directions.

It purposely does not share anything with the environment.

The gist here is that given the implementations of properties this could
be used as shared entity between kernel and TPM-RS project, which would
give a single shared project, which would be anyhow "same same" if they
had separate implementations.

Not being dependent on kernel code would make it also applicable to
early boot code because you can put it anywhere, or link against
anything. E.g., perhaps Trechnboot could be one of such use case
because for that we need to find model where protocol is needed
without having TPM driver in the first place.

For TPM driver itself it would increase stability because the crate
gives guarantees on structural integrity vs looking at just "max
length".
> 
> 
> If so, I did try something similar [0]. Perhaps this is useful to you and is
> somewhat applicable to your use case as well?

Thanks! I will look into this :-)  I'm not like pushing anything
this just early querying what are options for the future. I.e is
Rust code enforced live its own cage or are there options for
doing "hybrid solutions". I'm only starting to learn of the 
possible integration options. I.e. not even debating of anything,
only learning.

> 
> [0]: https://lwn.net/Articles/970565/
> 
> 

BR, Jarkko

