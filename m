Return-Path: <linux-integrity+bounces-6814-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1ABB25A7A
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 06:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A8D1C24E33
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 04:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA6E1F8F04;
	Thu, 14 Aug 2025 04:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAfElyII"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38FD341AA;
	Thu, 14 Aug 2025 04:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755145728; cv=none; b=ILyWrk1t/ZqCQr4KORyZ5Do1t3bboca/dXmFNpd/RdsHKW802kL9zrZOuyHyOV6+8LCQ1CUhnSD99zFyc9zXOE7gqcsnXQ6rTHloucNs8WpxRPOszW7iPJmk3SKs8zm0mzVSWPTqk1XiBNsbHZK3KFMsRpYCz8LrDKKSgQOw83M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755145728; c=relaxed/simple;
	bh=5ZcXwVynuXpUxiBWIA9PyMv6slGY9DtVqh77si6Mv1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAvpHYgSnd/WZ2+EsLTvYXbfXNcgIHWxguMi4KWzxnpmn/lqB44J6KmiowrTMomG6d3OAuFu/NR3j7ONRDWxSIFVMGWKor/P5qbYLjY/YogjMeu0xms+08P77ECkma7Hz/57vPxWvCN7T6EKuwXnnAdWHLeDqcWKXkCzxldHlbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAfElyII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06973C4CEEF;
	Thu, 14 Aug 2025 04:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755145727;
	bh=5ZcXwVynuXpUxiBWIA9PyMv6slGY9DtVqh77si6Mv1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FAfElyIIXB6rR4DYvEuZk/N5cjcirZYUi/Ys5xcUFaFa4gzaYoFSAxubnJ3rStZ5s
	 8rTEE4hgjJTjdAKpNDG8uKGv/e6yyIxyX+EgofIl7sVix3uCUeQsr0EZJzQhV/bdVK
	 clLgQPW0pIaJ7s1Nwq7bQ0D2tUa1uAszoGd8h1qL3xOUeiXhiKPc4/ii9XS78fa5ST
	 Iu8kdzggzIfBr+BUvAXNNwut7FfhbHWdTYn3Wc0YszNcV5ySZ1LF4Or2Pr3Ah/p1z1
	 bWC8clBXS20ZfYSPLiku3YzUz8zqcUz8j3wlQgcW71UEwd3K4rJP6cg4YjWpPdyduN
	 94FqqHy0nlA+g==
Date: Thu, 14 Aug 2025 07:28:43 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: tpm2@lists.linux.dev, linux-integrity@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Josh Triplett <josh@joshtriplett.org>,
	rust-for-linux@vger.kernel.org
Subject: Re: tpm2_protocol/tpm2sh
Message-ID: <aJ1l-xZ6-UlIsX0L@kernel.org>
References: <aJ1kNzDf-9r_16Cs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ1kNzDf-9r_16Cs@kernel.org>

On Thu, Aug 14, 2025 at 07:21:15AM +0300, Jarkko Sakkinen wrote:
> Hi,
> 
> Crates for 0.5.4:
> 
> https://crates.io/crates/tpm2_protocol
> https://crates.io/crates/tpm2sh
> 
> As I said earlier tpm2_protocol is no_std, zero 3rd party dependence
> crate that does not require a memory allocator, and its first priority
> driver for design choices has been Linux kernel. However, given the
> design, it could even power the actual chip itself orchestrated by a
> microcontroller.
> 
> It's unipolar TPM 2.0 protocol implementation, which can power anything
> from to actual chips given ability to build and parse both commands and
> responsese.
> 
> This mean in English that if you take e.g., a command byte stream, parse
> it and feed that to the builder you will get the exact same bytestream.
> The same principle applies responses.
> 
> For upcoming release the rest of the work is basically just populate
> rest of the TCG spec, which is easy given the declarative domain
> language designed with `macro_rules!` construct.
> 
> "A demo video":
> 
> https://social.kernel.org/notice/Ax9FRqKTBL69UYMIW8
> 
> Some things we could do given someone has some driver to do so, which
> we could not realistically do with the pre-existing C driver:
> 
> 1. Super high-granularity configurable resource manager (perhaps with
>    eBPF filtering)
> 2. Kernel driven vTPMs (as it is bidirectional).
> 3. Perhaps even offer vTPM implementations also for CoC VMs.
> 4. Not in kernel necessarily but if you have a keystore/crypto product
>    you can use it for building interoperability layer.
> 5. Given extremely sophisticated building/parsing capabilities,
>    implementing e.g., a tailord remote attestation server becomes super
>    easy, given that server can use it (w/o TPM ofc) to to carve the data it
>    wants from the protocol shenanigans.
> 
> Can rarely say this but it's the first ever unipolar and across the
> board role agnostic TPM2 protocol implementation - first of its kind
> :-)

****

BR, Jarkko

