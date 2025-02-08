Return-Path: <linux-integrity+bounces-4759-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CA6A2D89A
	for <lists+linux-integrity@lfdr.de>; Sat,  8 Feb 2025 21:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38824166AB9
	for <lists+linux-integrity@lfdr.de>; Sat,  8 Feb 2025 20:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED331F3B98;
	Sat,  8 Feb 2025 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJh9vgAj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1301F3B8E
	for <linux-integrity@vger.kernel.org>; Sat,  8 Feb 2025 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739046600; cv=none; b=p3uxnT3p8YLh60PwFU/bMCfvjyx+B15ilZO4jQ7XUJY/SqKDojKPlyZLo5YdmHCzxWUBGzwYYLF/RLNocaQpMCHj6Diix3Qh3dpJdSZNNsBXtvb2y+o8Tx+ZR3C3+Y862+ngYU1UKx+mEgxO7CYYgCoJPRKYoylorkEPC4+kJME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739046600; c=relaxed/simple;
	bh=/781yYJ885NLwOSDqG6CpgJLxjNHZvuehQPyaEmZA5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgkKEStC5YfY8h2nAT0k2Jey927wTA/2YlyqMlKvdWR52T40bV7wxygLYFapg1f6Q6BDHqBOmM59N4lnq/lFrNjtM2BcPgi5w8coc5pI3Gq9nJAHyolhrqfNi1o7SO7ecogIM/nKisKTldWNHxBXSabQ1fV2DzJ9LVkxUDnVx14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJh9vgAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12C5C4CEDF;
	Sat,  8 Feb 2025 20:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739046600;
	bh=/781yYJ885NLwOSDqG6CpgJLxjNHZvuehQPyaEmZA5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJh9vgAjdtaSuNhb2hOlvUEeixv2OH1IZy3/bMYjDtJpOJkmFFqMJh9XvUo/m+jGO
	 czw/ma2BpTArPS2XNXFqqrojT/YWEdgmbK9ZfunJ547gsxzGTOSpH/FrAOkruYbZIf
	 jJsrx/7QnDhFS89/rXQHa15r0BdoKWBre9IOJwqdsXqLLSCfRPcaT+GyE+5ULRGFN6
	 srz+kM022hk+2mosarG4LOZ4i9r8KqVXaFLlavktRkzBTkG3WRYOPtD1BirVDuEi6J
	 OdJMlToF22CPUI+/sH9J3aJbwhZXPclbmaRMv+vbFhkDhWV7S75d0neU4jHxGPTcRf
	 iZsWB4Zd0xXdA==
Date: Sat, 8 Feb 2025 22:29:55 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z6e-w2YT6hFOyFiP@kernel.org>
References: <Z5yLYVBn6inIH8cG@kitsune.suse.cz>
 <D7G6P7W7AY65.257WPBC8I3HAF@kernel.org>
 <Z5zJ7R6vDU4h9iDk@kitsune.suse.cz>
 <D7GFCNGDK7S6.1X0KPPHF1TXBO@kernel.org>
 <Z50IKdYe42_n2B0b@kitsune.suse.cz>
 <D7GIBDO5KJMD.118CQO10LJ79Y@kernel.org>
 <Z6Nm7Y8TFF8YG56Z@kitsune.suse.cz>
 <Z6N10NQY75hpX0Ed@earth.li>
 <Z6UdFCdqCNZ8VGOL@kernel.org>
 <Z6XRuFnEXeQI_rEZ@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6XRuFnEXeQI_rEZ@earth.li>

On Fri, Feb 07, 2025 at 09:26:16AM +0000, Jonathan McDowell wrote:
> > The whole arithmetic with timeout_a/b/c is mostly gibberish and could
> > be replaced with a single "max" constant without issues (just set it
> > large enough).
> > 
> > They could be all be replaced with let's say 3s timeout in a constant.
> 
> This appears to have come up before:
> 
> https://lore.kernel.org/linux-integrity/358e89ed2b766d51b5f57abf31ab7a925ac63379.1552348123.git.calvinowens@fb.com/
> 
> That patch was deemed overly complex and it was suggested to split it
> up; I can't find any indication that was ever done which I guess is why
> the discussion died off.

Looking back I suggest splitting timeouts and durations into separate
patches:

https://lore.kernel.org/linux-integrity/20190312145553.GB6682@linux.intel.com/

> So just to clarify, this more recent patch is working around a situation
> where the status register gets stuck and needs a complete retry of the
> command send - it's an Infineon errata, not something that would be
> fixed with a longer timeout.

Hmm... please shout if I ignore something but if we could -ERESTARTSYS
semantics here that should ignite completely new transmit flow, wouldn't
it?

I'm not seeing this locally so far unfortunately.

BR, Jarkko

