Return-Path: <linux-integrity+bounces-6906-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAB5B34AE6
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Aug 2025 21:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72161B23CC1
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Aug 2025 19:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257152D7BF;
	Mon, 25 Aug 2025 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3Xp4mzO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B1A41;
	Mon, 25 Aug 2025 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150228; cv=none; b=JJuyj0TmV1OgYyXGRvevl480plPdfbab0e+K2h+I5a4O695cAmh0pd6K10y60d/HcnqtjCpeRa0vT9FaP2cu+h9gATH7YinDGGBt1LkhyZAYpGLD10v0XyeyeVrrBx5vSSG57N1YBTOHqK1gKTGCsR0Woaq+PfMMYesfxQ098Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150228; c=relaxed/simple;
	bh=wVt33l1vjCoy4m+csBjzU5NrxJHWMdJ8EMxYyEoGmvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0ICvHoHWa9K5pGbg/jrv3YHKYZDnEX9TYgi3QKXtfVSDLsy0Kq5AQtYvJTVMx/kHjuTdU5mEiMEDpvK+e+ZcOtQLZiY1b+kL8EYgrHvN/Psdv2DV00y3z7t1WgCuLLh0v9psrCqA8ITy38fSNmgiBhm18XMjPngU61aagBFLjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3Xp4mzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B56C4CEED;
	Mon, 25 Aug 2025 19:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756150227;
	bh=wVt33l1vjCoy4m+csBjzU5NrxJHWMdJ8EMxYyEoGmvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3Xp4mzOC28JGhFkxteYmhsEHBxsQL6oRceVTuiXQ/7TxzFcwi6PA/wDF3NEG58pd
	 v+RwB29C106ACDc6EiPHykYemZkQs7KPDbIQqqr0LpsV54sgCFpt2xY/bGH56Tlcdr
	 h9MzWHxs6W3CRheh20T7o7R4Er+k6M1jA6uu2k/FMNrgt+1SoQLJXc+3tPCvWdq0+Q
	 TclEumr6pbt+ZMVwwFASHbnBtWKmTR9sc8A/uETBsgojII8tGupOtcZYLLmXFUi1o1
	 C9wX4vK1QKHMdfCwMAsuxa7AFtmGsTpUl7pASLHtbT0zFeO0XMXpnPFJ9kq4DwocLy
	 A1vzZxpw+dzWg==
Date: Mon, 25 Aug 2025 22:30:23 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: rust-for-linux@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: Using Rust on non-Rust side of kernel
Message-ID: <aKy5z74FE4paL7za@kernel.org>
References: <aKmwPFb4cCk_E-ob@kernel.org>
 <aKxRVlyNXUGBwJ2L@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKxRVlyNXUGBwJ2L@earth.li>

On Mon, Aug 25, 2025 at 01:04:38PM +0100, Jonathan McDowell wrote:
> On Sat, Aug 23, 2025 at 03:12:44PM +0300, Jarkko Sakkinen wrote:
> 
> > My goal with tpm2_protocol is to have ACPICA alike model of imports as
> > the crate is driven by TCG spec updates and it is very likely to be
> > also used by TPM-RS (also via import style process).
> 
> I'm not entirely clear on what your plan is for this / the existing TPM
> drivers in the kernel? I assume it's to eventually remove some of the C code
> in favour of the Rust implementation, but I'm missing exactly how that's
> expected to work.

There's no plan of doing anything at this point. This is more like doing
early research for the following questions:

1. If this comes up in form or another, what are the directions of freedom.
2. What could be in general done in Rust that could potentially extend
   the capabilities of e.g. /dev/tpmrm0 (which could be entirely
   different device).
3. There has not been any discussion from my part of removing and/or
   repealing and replacing any of the C driver code.

It's a bit odd position IMHO to not prepare for future outcomes. Even
without kernel context, for the TPM marshalling/unmarshalling there does
not exist decent implementation as of today in *any language*.

There's been way too many unprepared situations of C-to-Rust
transformations, and learning lessons from that, I think it was the
priority to implement the protocol part so that it has enough time to
mature when the day might come.

> 
> (Given I've spent a bunch of time this year tracking down various edge case
> issues in the TPM code that have been causing failures in our fleet I'm
> understandably wary of a replacement of the core code. *It* might be a
> perfect spec implementation, but hardware rarely is.)

I think this is somewhat unconstructive comment. How do you implement
against anything if you don't follow the spec and later on fix the
incosistencies?

I have not observed high stream of marshalling and unmarshalling
associated bugs or other issues.

Also if you make obnoxious arguments like that please also underline
how implementation A is worse at dealing possible inconsistencies
than implementation B. Otherwise, you're only spreading FUD.

> 
> J.
> 
> -- 
> /-\                             |    It's deja-vu all over again.
> |@/  Debian GNU/Linux Developer |
> \-                              |

BR, Jarkko

