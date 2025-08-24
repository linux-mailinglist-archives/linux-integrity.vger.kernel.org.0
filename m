Return-Path: <linux-integrity+bounces-6896-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6B7B32DEE
	for <lists+linux-integrity@lfdr.de>; Sun, 24 Aug 2025 09:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88B817CAF5
	for <lists+linux-integrity@lfdr.de>; Sun, 24 Aug 2025 07:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0643F15624B;
	Sun, 24 Aug 2025 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hg6dYR9x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FD220EB;
	Sun, 24 Aug 2025 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756019741; cv=none; b=QL/bjIXFPf+vZJqVXKGvnlwMJmpnebFB5VZ7UuZbW7KpQjXTK/cskeAM0KP0KJZjcJ7bXdKxGyhyWsWgWcNOH1i/clJZhya6vShmubN53T4tKMa4kHa3i+EhDKTu8b88qhlATh+kEp7Ui/5MoWWGuygpZ44whhOPD3IudGDaQmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756019741; c=relaxed/simple;
	bh=gl+O88OuttXmeWTNVq+nk2CgUSuNAPkhpkXnuhpEAxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGAuMF0q0EOiWd/Sb11Gi/aU30sLgCTeGBpNUyE2n1kjFDIomtt5htefrnLRH/N9s+jVhQoo7yjW4mXgfTfg946UtC0v72mGXRAvicXn69g1XW/HMOVr7ayLXXTBa6lI1Ya+Ct1P406IbgATzH1RYjkL1MHD79/0UzoByUZukWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hg6dYR9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2451C4CEEB;
	Sun, 24 Aug 2025 07:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756019741;
	bh=gl+O88OuttXmeWTNVq+nk2CgUSuNAPkhpkXnuhpEAxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hg6dYR9xgHIfTY6lgqkohc0hIJyonPjGRslev4rR22bJvQdToxNsmfTdiCQGrJXNM
	 ernunUJHA+/FdqPIhkG0VmnmEtB2B/GUdOyGoEBwk7R9E0a7KiwpL3WIQ4D3vbbQc1
	 9q46UAKG1xcMlpI5NrPVlIWWC1ZfbfnJhdiOm0cLIoBT/dISbWcLqp9q13d8QSZ/LH
	 wX9AbU8QjFJ+3eRXEkZzSkaLaRcjXloreO3wJO8hGwfoGqN2tWi+0/vmNF5AjNyvMf
	 1zDwOMKjuuakveM/wVLdM4PwyObXxmMIL370LX6AxeVLST1J1l3Hl6PM+Ftf4Lox4s
	 BCzDIxYLsHVew==
Date: Sun, 24 Aug 2025 10:15:37 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: Using Rust on non-Rust side of kernel
Message-ID: <aKq8GderGYkCCbVf@kernel.org>
References: <aKmyg0auI8jHuAmZ@kernel.org>
 <BE42A51A-60C4-4E79-8459-CADEAB8DC3BA@collabora.com>
 <aKpJbIEZss_l-8wb@kernel.org>
 <aKpKxaJyZsSMfy_o@kernel.org>
 <1DF705A6-9743-4BAF-9904-63E9F5B72831@collabora.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1DF705A6-9743-4BAF-9904-63E9F5B72831@collabora.com>

On Sat, Aug 23, 2025 at 10:12:44PM -0300, Daniel Almeida wrote:
> Hi Jarkko,
> 
> > On 23 Aug 2025, at 20:12, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > 
> > On Sun, Aug 24, 2025 at 02:06:24AM +0300, Jarkko Sakkinen wrote:
> >> Hi,
> >> 
> >> Would it be possible to response in plain text?
> > 
> > Is highlighted at lore [1]:
> > 
> > "[not found]   <BE42A51A-60C4-4E79-8459-CADEAB8DC3BA@collabora.com>"
> > 
> > Also it is quite cluttered to read your response in mutt, as you can
> > probably see from my earlier response :-)
> > 
> > Not disregarding the response but it is right now quite convoluted.
> > 
> > See [2] for more information.
> > 
> > [1] https://lore.kernel.org/rust-for-linux/aKpJbIEZss_l-8wb@kernel.org/T/#t
> > [2] https://www.kernel.org/doc/html/latest/process/email-clients.html
> > 
> > BR, Jarkko
> 
> Sorry. Yeah I am aware of plain-text, but I was on the go and turns out that my
> phone is not properly configured. Let me copy-and-paste this here so we have
> the full context and also so that it shows up in lore.
> 
> I didn't have the time to read your response by the way, but I will get back to
> you in the next couple of days.

NP :-) 


> 
> 
> ————————————
> 
> 
> Hi Jarkko,
> 
> I must admit that I had a hard time understanding what you’re trying to say.
> 
> > On 23 Aug 2025, at 09:22, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > 
> > ﻿On Sat, Aug 23, 2025 at 03:12:48PM +0300, Jarkko Sakkinen wrote:
> >> Hi
> >> 
> >> As of today can we possibly do this:
> >> 
> >> 1. drivers/char/tpm (C code)
> >> 2. drivers/char/tpm/protocol (imported tpm2_protocol)
> >> 
> 
> What do you mean?

OK, I'm scavenging the options more than driving any plan. As can be
seen from this Makefile the code is somewhat isolated:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-protocol.git/tree/Makefile

It's also fully mmless with the goal of providing TPM protocol for
early boot code even at the point of time when memory is not fully
configured.

In the pre-existing driver case I'm wondering is it so that you either
have a Rust driver or C driver or can I have a C driver that has a
"Rust engine" for doing structured analysis?

Not sure if that would work in the generic case (e.g. for something
that would use alloc) but my implementation is even more constrained
than typical Rust kernel code. It really does not require anything
from its surroundings.

It has recursively constrained limits and I'm actually now doing
research if I could demo it inside eBPF filter :-) I'm not sure
tho is eBPF rustc capable of doing necessary unrolls. I have
recursively in all levels static limits to everything.

My goal at the moment is to get this into TPM-RS and this is more
like initial research. And also, I'm also rising awareness my work
so that if there was someone working on e.g., Rust TPM2 driver,
I think it'd be a great idea to combine that work with this
code.

Partly I initiated this work as a result of seeing all these nasty
fights over C vs Rust code. I thought that this like a great
contribution from my side to linux-rust and someone more seasoned
with that side can take advantage of my 11 years domain expertise
with TPM2 protocol. I.e. I'm trying to driver collaboration instead
of conflict :-)

The idea for ACPICA alike import policy where multiple projects
share same protocol assets comes from the observation that it is
a complicated protocol in its own right so we are better off fixing
that stuff in a single location. I.e. fixing TPM-RS would then
benefit also kernel.

I think I've really nailed the realization of it in software and
this has been the key issue with TPM2 for over a decade.

Partially some product categories exist because there is no real
developer experience for TPM2, which is very capable cryptographic
entity.

E.g., you could easily replace Yubikeys and similar products with
TPM2, and that type of products exist are merely a consequence
of the worst developer experience ever.

To replace Yubikey, you would need a cloud service that would
move secrets as you change your machine. It can be done without
surveillance. And given that this can easily wrap some other
keystore with TPM2 appearance, you could e.g. include the
whole Android ecosystem to that kind of scheme (this is what
I've been saying to Google employees I've talked with).

> 
> >> ?
> >> 
> >> And then build FFI from C to Rust for building commands that we need
> >> today etc.
> >> 
> >> There's one particular challenge where this could help: early boot code
> >> for D-RTM (i.e., Trenchboot) as given my crate is just a thing in stack
> >> with no deps, it could be linked also to that payload.
> >> 
> >> This would be much better integration step for TPM2 than having a
> >> separate driver on Rust side. We could start with tpm2-cmd1/cmd2, then
> >> move on to tpm2-space.c i.e. get all structural processing inside Rust.
> 
> Can you expand on what these cmds are?

Sure. See commands spec from

https://trustedcomputinggroup.org/resource/tpm-library-specification/

> 
> >> 
> >> tpm2_protocol is light on definitions and should not need any kernel
> >> specific Rust shenanigans.
> 
> You mean the Rust abstractions?

Yep.

> 
> >> 
> >> Consider it as value like integer but just a bit more complex internaal
> >> represention but in the end it is just a value on stack.
> 
> Not sure what you mean here either.

It does not need mm. all marshalling and unmarshalling of the protocol
can be done in-stack. You can of course box it and it is also fully
dyn-compatible while being decoupled from that as proved by a test
case a called "test_dynamic_roundtrip_blind_parse":

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-protocol.git/tree/tests/runner.rs

> 
> >> 
> >> My goal with tpm2_protocol is to have ACPICA alike model of imports as
> >> the crate is driven by TCG spec updates and it is very likely to be
> >> also used by TPM-RS (also via import style process).
> > 
> > The source code since 0.10.0 version has been relocated here:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-protocol.git
> > 
> > The representation of commands and responses defined is pretty well
> > high-lighted by
> > 
> > https://bsky.app/profile/jarkk0.bsky.social/post/3lx2n2uvxos2h
> > 
> > I'm also working on a test that measures the estimated compile time
> > size and realized run-time size (suggested by Philip Tricca) so that
> > we know where we are at on stack usage.
> > 
> > I've started to optimize it after development phase with some
> > low-hanging fruit cut already in 0.10.0 but this work is barely
> > starting [1].
> > 
> > There's also a kselftest compatible test that can be run with
> > "make test" in the repo using only rustc (build + run circa
> > 2 seconds on my laptop).
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-protocol.git/commit/?id=cd6641bf9e8c8fde8726bece9eb6cdc630d893c2
> > 
> > BR, Jarkko
> 
> 
> 
> My somewhat limited understanding here is that you’re trying to implement
> Rust code that can be called from the rest of the kernel, but that otherwise
> doesn’t depend on it?  
> 
> If so, I did try something similar [0]. Perhaps this is useful to you and is
> somewhat applicable to your use case as well?
> 
> [0]: https://lwn.net/Articles/970565/

I will do research on this! This is really just early research. I think
eventually fully migrating TPM driver Rust would make sense as we could
then do e.g., much more capable /dev/tpmrm0 than we can do today but
it would be nice to have some "intermediate steps" in-between.

BR, Jarkko

