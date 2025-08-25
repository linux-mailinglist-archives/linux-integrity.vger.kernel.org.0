Return-Path: <linux-integrity+bounces-6917-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DD8B34FA5
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Aug 2025 01:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F492A6A54
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Aug 2025 23:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD8F1D7E4A;
	Mon, 25 Aug 2025 23:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snd25aNS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2575981720;
	Mon, 25 Aug 2025 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756164214; cv=none; b=UeNvmQPRt68ZupEY46tTh4Vb4JkBjANEtcIGljfEkdcjMXj04LPdZCrSGTyM94drjUhLS4zw5MhZxiNpRl1GUz8YnDMB82dt8A0I7sarqEvEN4jO0/Xqp9N3VBgpCUpWQxeBhvp/rj/llFbqycyKWWr1glDDUhqgN5EAjEF407o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756164214; c=relaxed/simple;
	bh=RJ44myUrtV49DCfufmFqtuY55fThe5kSESQUBhgI+MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOTvw35UP6EZn7QH7agFXFAXV8aTr2uHF0y5wqUKZadtOLdhy7HZAG/ZEMx4ldUo0drso8wX08dm154sqm/5jY9kpZTaIJjZaYMDoK7frRwRFICc1Bky5BeVl28bGJI8vEliiSiESAEinSG7WuC9ILPDgZI0zhADhuG2fkN7iyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snd25aNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8E1C4CEED;
	Mon, 25 Aug 2025 23:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756164213;
	bh=RJ44myUrtV49DCfufmFqtuY55fThe5kSESQUBhgI+MQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snd25aNSGxrLMF3XW2GHwyq2A7TcN9WuzpvJ3STZYJmvwlVJaKyt36HiVxjoUIURU
	 Yx9yFj1OktBbt1ol6YgWODIU6IRf5LAqFoBwjpNrJyB4X2sQ+CgWhZt9/VPFOVRVQf
	 CfZ5uHEM8H5S0tWmMUYDl4SD7sizIFAr4DY3YNhMpYJ2A8Z5aDaCYRcoOJ2HNMwEpx
	 I85/302xRILcmaoRExleq1Ui9LO1olzxBCjvQvzZ3EhrLcPARrwM3PK45reBbN7TtC
	 LHrVfyAyStKQ0UFs69xOj8yZaKoCxDKsfbScTPDBIljtvjDuXP8vk7bkh/MyUMKZCG
	 A+ZTRwybSvuFQ==
Date: Tue, 26 Aug 2025 02:23:29 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: rust-for-linux@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: Using Rust on non-Rust side of kernel
Message-ID: <aKzwcWKftTL0DLG3@kernel.org>
References: <aKmwPFb4cCk_E-ob@kernel.org>
 <aKxRVlyNXUGBwJ2L@earth.li>
 <aKy5z74FE4paL7za@kernel.org>
 <aKy8tWxTiK90iyLi@kernel.org>
 <aKzj44NBShpMXFA0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKzj44NBShpMXFA0@kernel.org>

On Tue, Aug 26, 2025 at 01:29:59AM +0300, Jarkko Sakkinen wrote:
> I am going to most likely make experiments with kernel and most
> definitely make "tpmtrace" (a tool that hooks to BPF ring buffer and
> pretty prints the protocol in real-time, it's dead easy to do now).
> Finally (as I've said before) it would be quite unproductive to create a
> design that does not upscale to let's say to an attestation server
> (which would use this to parse e.g. quotes) or downscale to a chip.

Considering existing TPM C driver, Linux keyring (from trusted keys
angle and likely in future from imported asymmetric keys angle) and
security stuff overall in kernel, this work really can fuel up both
developer and debuging experience. I.e. my motivation is really 180
degrees opposite than deleting anything :-) [maybe that's why I got a
bit upset]

And doing tools like tpmtrace will quickly level up the feasibility in
production through stress testing in the field. And as I improve tpm2sh
(which I don't yet recommend anyone to use, it's so far just quickly
upgraded to test the protocol changes, I'm now stabilizing it ) we can
better evaluate different choices given better toolkit that will
consequently reduce the number of wrong decisions.

Like in pretty basic kernel testing it's not too feasible to package
something tpm2-tools to an image that you build (I do full rootfs
per kernel patch when testing) but something like tpm2sh and in
future tpmtrace are much more nicer blobs given how rust ELF images
are constructed and linked. Downscaling of the stack  has been 
a QA issue for ages now.

BR, Jarkko

