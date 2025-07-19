Return-Path: <linux-integrity+bounces-6652-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B8AB0B05C
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Jul 2025 16:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12EA1AA1ED1
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Jul 2025 14:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F54E2236E3;
	Sat, 19 Jul 2025 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhE5rs01"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE69B881E;
	Sat, 19 Jul 2025 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752934569; cv=none; b=lagD6buLe7I7+b9l/GGElEzhZCFpCt6ebCulXkrTUoF5BVYegjd99g9bJ7lOoAB8xwQMPjo3kBWevjlXNhXBlc2eZ8uZ419blokf4a5rYt/efTO686Q+OYxh4DBLtyHBsYlA0ntD01Vvx22ZHV1HiaBStEly91C7auRh6OoXSR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752934569; c=relaxed/simple;
	bh=9nlBeA/bI2YLmQWQiEOIWZxKTC/jzlRcca9ddVgWGQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Stt3vf30zjbTLbZbqiCjwaxLyMLDFSF+SGGXyboeYa4sbmCjJncYKouEQC/951XVAlOBlaVz0r4JWod+hGdroR9wcQihvqTgtmNFyFO3LfoqJ/u7pNJImAHL00WXtxJxjFWY0BPJHuFMMorLCB+2+koZQ3rEVJsLU0X+uQ1/YQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhE5rs01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E08C4CEE3;
	Sat, 19 Jul 2025 14:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752934568;
	bh=9nlBeA/bI2YLmQWQiEOIWZxKTC/jzlRcca9ddVgWGQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nhE5rs01Gpb5puCru071sjThbWwgMPVjGV0YyPiwxbBXXZBFbiXPsBm0ZXHozAy7u
	 1sMv7M6MCp9QkOeKGXdeAcIV0pZTmdmBb0NJuoL9PNU6SfVkOFmRwAmOvDLl7WUIre
	 130cl73Lsc3U9NIcxjF9C3DdBwlwITCJuCqB6sCE4IvfE+L52JXyYs4BFIHFGWujSj
	 kyXSLZgk9+01jIfFNYRf7ZdS3j/QEvtdhoB+UhOfDDFXn+Ix9TmVbu7U5qzL8kNoZf
	 5aX16W1mYM59+uS5LL/QVqZXg6RcIco7Ez1aHrQI6a8Y1GO8LlQ9rgBbB33ZudFJdO
	 7IFIGWDRYqgWg==
Date: Sat, 19 Jul 2025 17:16:04 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Jonathan Corbet <corbet@lwn.net>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Frank van der Linden <fvdl@google.com>, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH] tpm, tpm_vtpm_proxy: boot-time TPM
Message-ID: <aHuohdh2tVU48o9U@kernel.org>
References: <20250716121823.173949-1-jarkko@kernel.org>
 <9193c59f-3982-42f4-9b05-c6cdefe3b05c@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9193c59f-3982-42f4-9b05-c6cdefe3b05c@molgen.mpg.de>

On Wed, Jul 16, 2025 at 02:23:04PM +0200, Paul Menzel wrote:
> Dear Jarkko,
> 
> 
> Am 16.07.25 um 14:18 schrieb Jarkko Sakkinen:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> Congratulations on the new(?) job! Big thanks to that company to do upstream
> Linux kernel work.
> 
> > Provide a kernel command-line parameter named as `supplicant`, which
> > contains a path to an TPM emulator binary. When defind, the kernel will
> 
> defin*e*d
> 
> > launch the program during boot-time.
> > 
> > This feature is most useful in feature testing e.g., in environments
> > where other means are not possible, such as CI runners. Its original use
> > case highlights also quite well of its applicability for pre-production
> > hardware: it was used to provide a TPM implemnentation for a RISC-V SoC
> 
> implementation

Thanks for the corrections!

I think also the code changes are actually half-broken or missing some
of the stuff. I'm glad that I remebered to use RFC tag ;-)

> 
> > running on FPGA with no TPM HW implementation at the time.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > ---
> > Bumped into this in my archives so thought to make it available just in
> > case anyone is interested.
> 
> Do you have such a TPM emulator binary?
> 
> Thank you for upstreaming this.

It was like internal project within research group but e.g, MS TPM
emulator [1] is pretty easy to wrap and wire with a program that does
three functions:

1. Feeds the emulator with incoming data coming from the client
   through socket provided by vtpmx.
2. Writes the data coming from the emulator back to the client.
3. Handles TPM2_CC_LOCALITY.

MS TPM 2.0 emulator is quite generic and abstracted out code, so you can
almost just take the source files, ignore the build files, and meld it
into your own thing and it will envetually work, if you spend a few
afternoons on it :-)

[1] https://github.com/microsoft/ms-tpm-20-ref

BR, Jarkko

