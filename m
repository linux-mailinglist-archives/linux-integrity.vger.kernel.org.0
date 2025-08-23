Return-Path: <linux-integrity+bounces-6890-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BCBB32883
	for <lists+linux-integrity@lfdr.de>; Sat, 23 Aug 2025 14:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA42174D21
	for <lists+linux-integrity@lfdr.de>; Sat, 23 Aug 2025 12:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25C424168D;
	Sat, 23 Aug 2025 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pegnIHxG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E30139E;
	Sat, 23 Aug 2025 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755951751; cv=none; b=Q0UESIweSd/6iXoasdvC8fLe/vyoEeCL8+wpLlSTChPT1PYUZ4bzgUMN5IeI1+Ormu0Ov2SnFcT4ho4+wCDP6skZQTthPHkJWNzAVBh5/qYQy8QoIUCyFn8OkAjfGVGmOMdnBrlTBs/ZwqICCqxHaMg3t4+RxDfTvQrQQzrtigw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755951751; c=relaxed/simple;
	bh=iGK+W5WOgkMgMj7ntxWwAuWtkuas+YgUmbkR9F7HSz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ns+9avKqdS0iEt8gr1LyXytL9vwRUKs6DntWo+ofAgn8K/RCcyn/LbTRst9Xw9+UTHK/JcK+jO93AMGaW2LM9PIcUDRZgP4Bi3iB6gJoRzH23kV+P5/OcnOlYmxveRzRLltMjXZw55ZdzPmwBZPs2RNccz40o3mDz9IvQ0TELrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pegnIHxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D93C4CEF4;
	Sat, 23 Aug 2025 12:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755951751;
	bh=iGK+W5WOgkMgMj7ntxWwAuWtkuas+YgUmbkR9F7HSz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pegnIHxGQvokYbDi5edzRIwexnaLzZXyO93Ef6fUTkQ/sTAw5OkyUSAjDQqMCxp8s
	 0GmFRs2FyVqJ399EVq2BIwzZnS3ydK9KFRJifa5+8CDvNin4JcikHRgBLx84kj/G1v
	 wpvKBbAn7I8fHqML8LTTC4Xh53EBmu+JukNkIV3fPT4N/FB4o2HD9JnzQKdobLvxgG
	 QK5YjZS+djC8t9f1ym9MaYMZnrHRJDNi8Ygmu/JAeVvsDALzdG7rs/ATArTAdM2lg8
	 rt9+c9kJ3mkaWIp3I5oQ4v4lGwXcriqyPyUZ/Ly/fqBoBp8obzX1+ssmE4nfENyZ4h
	 Gm0qi6icau0Zw==
Date: Sat, 23 Aug 2025 15:22:27 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: rust-for-linux@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Subject: Re: Using Rust on non-Rust side of kernel
Message-ID: <aKmyg0auI8jHuAmZ@kernel.org>
References: <aKmwPFb4cCk_E-ob@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKmwPFb4cCk_E-ob@kernel.org>

On Sat, Aug 23, 2025 at 03:12:48PM +0300, Jarkko Sakkinen wrote:
> Hi
> 
> As of today can we possibly do this:
> 
> 1. drivers/char/tpm (C code)
> 2. drivers/char/tpm/protocol (imported tpm2_protocol)
> 
> ?
> 
> And then build FFI from C to Rust for building commands that we need
> today etc.
> 
> There's one particular challenge where this could help: early boot code
> for D-RTM (i.e., Trenchboot) as given my crate is just a thing in stack
> with no deps, it could be linked also to that payload.
> 
> This would be much better integration step for TPM2 than having a
> separate driver on Rust side. We could start with tpm2-cmd1/cmd2, then
> move on to tpm2-space.c i.e. get all structural processing inside Rust.
> 
> tpm2_protocol is light on definitions and should not need any kernel
> specific Rust shenanigans.
> 
> Consider it as value like integer but just a bit more complex internaal
> represention but in the end it is just a value on stack.
> 
> My goal with tpm2_protocol is to have ACPICA alike model of imports as
> the crate is driven by TCG spec updates and it is very likely to be
> also used by TPM-RS (also via import style process).
 
The source code since 0.10.0 version has been relocated here:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-protocol.git

The representation of commands and responses defined is pretty well
high-lighted by

https://bsky.app/profile/jarkk0.bsky.social/post/3lx2n2uvxos2h

I'm also working on a test that measures the estimated compile time
size and realized run-time size (suggested by Philip Tricca) so that
we know where we are at on stack usage.

I've started to optimize it after development phase with some
low-hanging fruit cut already in 0.10.0 but this work is barely
starting [1].

There's also a kselftest compatible test that can be run with
"make test" in the repo using only rustc (build + run circa
2 seconds on my laptop).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-protocol.git/commit/?id=cd6641bf9e8c8fde8726bece9eb6cdc630d893c2

BR, Jarkko

