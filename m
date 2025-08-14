Return-Path: <linux-integrity+bounces-6813-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0264DB25A6F
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 06:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D2F1749FB
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 04:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8951487F4;
	Thu, 14 Aug 2025 04:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACEd9ODu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661403D69;
	Thu, 14 Aug 2025 04:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755145275; cv=none; b=t8JN+b2aNLgyAgFVwcCSP3HLdw049THejGcjWGivMtvvATqPXiyyBcWLK63h3oSCkCD1G79Ko7ITC23jqWax8/wspgfyCdK9QozX8znqIntb9YVGpOeKHi33nxEce9el1PpoqNcciD1VLFU7QI9HYW2vCy01VY+i3JHjXAN5sa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755145275; c=relaxed/simple;
	bh=PnNTC1rOLdy+QzgW9I46DnuAC81CuNNmZRTFtHLJxcM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PjHajBvqNlNWw1mZud01s30ml9B7PT7Im7hdkRyMNEr68Z7cEK6gBzs56P47+tZThJeY7BPD4gHyUsr0UaOjFgIbOnAZLAzf492I0/zmt/+CeX5wL3AuWO3UZKZu0L/Uy3aiiTcTBgIyJtDJQDomIScMLjZzh1r3KfI4EaZpeow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACEd9ODu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F09FC4CEEF;
	Thu, 14 Aug 2025 04:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755145275;
	bh=PnNTC1rOLdy+QzgW9I46DnuAC81CuNNmZRTFtHLJxcM=;
	h=Date:From:To:Cc:Subject:From;
	b=ACEd9ODuky9e5OCpXAYsK3YEC9JOe7DRhU1wE0cqADGT2+4BXWh01wviLD4dLKqWK
	 1tZFeG0BW9VJgh6rIvGmiT3HgXh+ogdPf7GKiHmYg7L/QygAAam6ioX4LzTGYB+I5+
	 cH6BtqVPeQrXI1mKjafxE/pXQ9r8o5Y9I1S5uraVL1TEh4OZVzGFO0Xcb0sH7TpXGX
	 QeMyu2kRJKeNc+k5OVn6if2M8hr0CfTHHra8/bBampAWXZhvxEvVePESI7W+MxvtXq
	 1/62Cdw70x5mxa1HTeVKHAbpPwOS88E8wcTTp6koIFttn1nIU9U6m6uFA6hfc9BFHD
	 VRp6hl7BTMmuQ==
Date: Thu, 14 Aug 2025 07:21:11 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: tpm2@lists.linux.dev, linux-integrity@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Josh Triplett <josh@joshtriplett.org>,
	ust-for-linux@vger.kernel.org
Subject: tpm2_protocol/tpm2sh
Message-ID: <aJ1kNzDf-9r_16Cs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Crates for 0.5.4:

https://crates.io/crates/tpm2_protocol
https://crates.io/crates/tpm2sh

As I said earlier tpm2_protocol is no_std, zero 3rd party dependence
crate that does not require a memory allocator, and its first priority
driver for design choices has been Linux kernel. However, given the
design, it could even power the actual chip itself orchestrated by a
microcontroller.

It's unipolar TPM 2.0 protocol implementation, which can power anything
from to actual chips given ability to build and parse both commands and
responsese.

This mean in English that if you take e.g., a command byte stream, parse
it and feed that to the builder you will get the exact same bytestream.
The same principle applies responses.

For upcoming release the rest of the work is basically just populate
rest of the TCG spec, which is easy given the declarative domain
language designed with `macro_rules!` construct.

"A demo video":

https://social.kernel.org/notice/Ax9FRqKTBL69UYMIW8

Some things we could do given someone has some driver to do so, which
we could not realistically do with the pre-existing C driver:

1. Super high-granularity configurable resource manager (perhaps with
   eBPF filtering)
2. Kernel driven vTPMs (as it is bidirectional).
3. Perhaps even offer vTPM implementations also for CoC VMs.
4. Not in kernel necessarily but if you have a keystore/crypto product
   you can use it for building interoperability layer.
5. Given extremely sophisticated building/parsing capabilities,
   implementing e.g., a tailord remote attestation server becomes super
   easy, given that server can use it (w/o TPM ofc) to to carve the data it
   wants from the protocol shenanigans.

Can rarely say this but it's the first ever unipolar and across the
board role agnostic TPM2 protocol implementation - first of its kind
:-)

BR, Jarkko

