Return-Path: <linux-integrity+bounces-6897-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF07B32EB9
	for <lists+linux-integrity@lfdr.de>; Sun, 24 Aug 2025 11:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6401B6355D
	for <lists+linux-integrity@lfdr.de>; Sun, 24 Aug 2025 09:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5592F9E8;
	Sun, 24 Aug 2025 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3fTKcnP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D12B1A08AF;
	Sun, 24 Aug 2025 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756027297; cv=none; b=WRnOvipDWliJbsj8SO3nQ521gSkoUr1bj6UHILOUIjipOPbOPfZ857q7VRWOq4CZzhqpFfNupcwf0my6Tsi6gbsyWY0IwI68KfDJ2fCwUb90fuXT4+OIQ56B+jU34Bck/D+Ceh1mmmZG0GW6+H4wps83YFfG8ZekeUUv5RrxJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756027297; c=relaxed/simple;
	bh=8yG6jZ7gTtL7Th1yc4Ga2h6amtxruSZdlRKUABrErsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QF7s8lybhC+669D4tJrLybdxn5FaFhnHJViysuc1jFamWP9VGCsRgbOYx08EVgL0AKFntknuyjuXPSMs9SkZm3Ks+OjQntlLCbkvEMKZe/H7wLZtz7KT1jxGx56zaT94fHhl0F9fi0WJM7vQL0BWT68BUfOw36J0Fkymgz6rK70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3fTKcnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5D6C4CEEB;
	Sun, 24 Aug 2025 09:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756027297;
	bh=8yG6jZ7gTtL7Th1yc4Ga2h6amtxruSZdlRKUABrErsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y3fTKcnP3oJrmL/Ela1EO5Lfovjx2ieXhbvpVRKsSSmrxJCs9R3aBtmbB8Ooihig/
	 Du3fsUljqrOc7ywJFNz2UK+eOIMoiTdtCfNlGoWxMp9lfVjMleanuKX5Zy1w22JHVq
	 MexIVetVDKL80rvN+LmhkuKixOZdwiUP/6Bs2VxB7V4S77GC3PfIPPXeObygxO2Nru
	 SVOedwKkC7+hJy4rV5bWz1MGm121w9DG/FV8gK7vI6nOfoZhF7WAF4qo1BkstdUWi+
	 rpEFyN4ijbgURpUUYuPheQlZFbX3Yk43qfAKKXTGhgJqlJD7Yz77kBMjyEjuQpzemd
	 HpXiP8awk5s9A==
Date: Sun, 24 Aug 2025 12:21:33 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: Using Rust on non-Rust side of kernel
Message-ID: <aKrZkLWirkjt9fRJ@kernel.org>
References: <aKmyg0auI8jHuAmZ@kernel.org>
 <BE42A51A-60C4-4E79-8459-CADEAB8DC3BA@collabora.com>
 <aKpJbIEZss_l-8wb@kernel.org>
 <aKpKxaJyZsSMfy_o@kernel.org>
 <1DF705A6-9743-4BAF-9904-63E9F5B72831@collabora.com>
 <aKq8GderGYkCCbVf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKq8GderGYkCCbVf@kernel.org>

On Sun, Aug 24, 2025 at 10:15:37AM +0300, Jarkko Sakkinen wrote:
> > >> There's one particular challenge where this could help: early boot code
> > >> for D-RTM (i.e., Trenchboot) as given my crate is just a thing in stack
> > >> with no deps, it could be linked also to that payload.

Right so if anyone working on Trenchboot (which I'm helping with by
giving feedback on implementation strategy) is raising eyebrows,
fear not ...

It's more about that if redoing any TPM stuff in Rust, it's best
to design as much of it as possible to run bare metal rather than
requiring a kernel, and only leave small slice of IO code to be
integrated to Linux APIs.

I.e. make a design that addresses all the bottlenecks we've seen
over the years... Thus, tpm2-protocol was first designed with
bare metal in mind, and secondly kernel.

BR, Jarkko

