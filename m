Return-Path: <linux-integrity+bounces-6891-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8561B32C80
	for <lists+linux-integrity@lfdr.de>; Sun, 24 Aug 2025 01:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716B11B666D6
	for <lists+linux-integrity@lfdr.de>; Sat, 23 Aug 2025 23:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C6D20C461;
	Sat, 23 Aug 2025 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJ47lETS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1622E1FF1A1;
	Sat, 23 Aug 2025 23:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755990384; cv=none; b=QU533S62sUZ7t4jhstw0sOqtzB9MrjmcNRlOekKDmULMon8iZcWQsV2vQNuojR1Kj+FQ0K1S53yAqbKl9IxLrtraDpoHf3hZXy97TR2QB8ne/VQcXSRtFdlmIl3oZda069CbtFmSexrtO4T0gG1gPjWh6tjuibs35zJCI90MfJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755990384; c=relaxed/simple;
	bh=AtNuZIyC+WM8Uejm4XIR9s6u0eRHoFr1u0k/qJFj+sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3qBQu+vWsdpZ9P8G/wGhE3Ro7l1b5y+oV2V3LPpuvgrjd/jrxYZm+4ofUd5Et/OH7KDxvJeGkcHoX1e635KWKItGvtxa9DcuAdKPkhPDtPY3lnII8+MdsdFb+4Chks9ogD7ENEJxQjc7PT6YICLfe03Rc5A66/GT89eoXhRU98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJ47lETS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECA0C4CEE7;
	Sat, 23 Aug 2025 23:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755990383;
	bh=AtNuZIyC+WM8Uejm4XIR9s6u0eRHoFr1u0k/qJFj+sQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eJ47lETSSLNwwdiJAzQZiEZ80HMk/Jzmnz5UB7u22YX+gn6yzxmhRVvSI/3rFQs/s
	 nCMwT+gilxrxhei2/kYUjJeW4BMm2g5QiLJnvljq/Xwv42Azk34MDfDJlGVdqG2MUP
	 +WNIPJFPKeHNBaXzwuLL4jRcYV3oVqga92cmned/1p7hVfUCank9Asqkzz79nugFkc
	 /1Ab21pFiUSnRoeAoYfPu0BAkE1C4+MqVesn1jTmpoiodSDhqwWKH+B4nTy5oVBY10
	 6ddyw0iqMg6UVPw/RTQv62MM4JlW7WkQuwAiTZVq20F+HyJKvuZd9CuQiE9Su/n4aT
	 E8XQRrBkZY5wg==
Date: Sun, 24 Aug 2025 02:06:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: Using Rust on non-Rust side of kernel
Message-ID: <aKpJbIEZss_l-8wb@kernel.org>
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

Hi,

Would it be possible to response in plain text?

BR, Jarkko

On Sat, Aug 23, 2025 at 11:38:00AM -0300, Daniel Almeida wrote:
> Hi Jarkko,
> 
> I must admit that I had a hard time understanding what you’re trying to say.
> 
> 
>     On 23 Aug 2025, at 09:22, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> 
>     On Sat, Aug 23, 2025 at 03:12:48PM +0300, Jarkko Sakkinen wrote:
> 
>         Hi
> 
>        
> 
>         As of today can we possibly do this:
> 
>        
> 
>         1. drivers/char/tpm (C code)
> 
>         2. drivers/char/tpm/protocol (imported tpm2_protocol)
> 
>        
> 
> 
> What do you mean?
> 
> 
>         ?
> 
>        
> 
>         And then build FFI from C to Rust for building commands that we need
> 
>         today etc.
> 
>        
> 
>         There's one particular challenge where this could help: early boot code
> 
>         for D-RTM (i.e., Trenchboot) as given my crate is just a thing in stack
> 
>         with no deps, it could be linked also to that payload.
> 
>        
> 
>         This would be much better integration step for TPM2 than having a
> 
>         separate driver on Rust side. We could start with tpm2-cmd1/cmd2, then
> 
>         move on to tpm2-space.c i.e. get all structural processing inside Rust.
> 
> 
> Can you expand on what these cmds are?
> 
> 
>        
> 
>         tpm2_protocol is light on definitions and should not need any kernel
> 
>         specific Rust shenanigans.
> 
> 
> You mean the Rust abstractions?
> 
> 
>        
> 
>         Consider it as value like integer but just a bit more complex internaal
> 
>         represention but in the end it is just a value on stack.
> 
> 
> Not sure what you mean here either.
> 
> 
>        
> 
>         My goal with tpm2_protocol is to have ACPICA alike model of imports as
> 
>         the crate is driven by TCG spec updates and it is very likely to be
> 
>         also used by TPM-RS (also via import style process).
> 
>    
>     The source code since 0.10.0 version has been relocated here:
>    
>     https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-protocol.git
>    
>     The representation of commands and responses defined is pretty well
>     high-lighted by
>    
>     https://bsky.app/profile/jarkk0.bsky.social/post/3lx2n2uvxos2h
>    
>     I'm also working on a test that measures the estimated compile time
>     size and realized run-time size (suggested by Philip Tricca) so that
>     we know where we are at on stack usage.
>    
>     I've started to optimize it after development phase with some
>     low-hanging fruit cut already in 0.10.0 but this work is barely
>     starting [1].
>    
>     There's also a kselftest compatible test that can be run with
>     "make test" in the repo using only rustc (build + run circa
>     2 seconds on my laptop).
>    
>     [1] https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/
>     tpm2-protocol.git/commit/?id=cd6641bf9e8c8fde8726bece9eb6cdc630d893c2
>    
>     BR, Jarkko
> 
> 
> 
> 
> My somewhat limited understanding here is that you’re trying to implement Rust
> code that can be called from the rest of the kernel, but that otherwise doesn’t
> depend on it? 
> 
> 
> If so, I did try something similar [0]. Perhaps this is useful to you and is
> somewhat applicable to your use case as well?
> 
> [0]: https://lwn.net/Articles/970565/
> 
> 

