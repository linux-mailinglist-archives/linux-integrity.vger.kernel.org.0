Return-Path: <linux-integrity+bounces-6922-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B55FB35887
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Aug 2025 11:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175953602D3
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Aug 2025 09:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E683019A2;
	Tue, 26 Aug 2025 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlZsQp6s"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F672264B8;
	Tue, 26 Aug 2025 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199621; cv=none; b=FKrtLooxJSId+4+HvE0jnH6RBmtmdaxj9U7J2098Kxr2+IzfzXi7gEPF7Ud3hTnAmPOge+ze5FLleld6ftLEqmUQaWa0h4380QzY7EM44fL0LJhI6ThDytE0BXjldJVcUlOTBh8tE5FvJKhdCGIsBhvrAFffy+GOOLmBQILjW4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199621; c=relaxed/simple;
	bh=wIiQ7TffapU2rCFO6zjBA1TstT51WxaPWa/EGr2UdQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqGvLeWU4YbyvfoHKH1Kf0Yf+JmpwclO8JNoYz9gLgc7+zKsT1eIeIu2K7zNzVyKNXJ3ZbPgIO0JQ/OiDAF4Srxkh6gUu5hxsoM5/dHfRGLvqIwSniu7I6kgBFQF1uA0NHyNq/0FWl4/OXL+mqrsP/Us/S1IUVaibui4v9c+vtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlZsQp6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F255C4CEF4;
	Tue, 26 Aug 2025 09:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756199620;
	bh=wIiQ7TffapU2rCFO6zjBA1TstT51WxaPWa/EGr2UdQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JlZsQp6s0QNwctC4r38S74yzlxLtnCYwGT4dYECETFr+a2cL6DaMoMpa6xrQeuiXF
	 E8ACEVo7EltMlCiYKqWNQtp3w2EM/iGEzrhR2exTfNVTep3jlzvmqdr971lgFILqSI
	 6Ndr1bH2GrCcgUeAKiS7NKO0rNzmBe3A5mTNi6fUlQaxLpLMzEpYP47ZVlcfMU9X/W
	 Um5vNrMfaORiMoyjZiJj1gzXc0KQ7A47Ld2Kt0maa/8CLlfhQpXqmp0O7eESSA9ENm
	 x/MNQQA9ZJhUC2GtUOkO6JJqXSs35X5Yj9DE5Kn1vJhxBfopdYiIZGbTUUfKO3jKQ9
	 OkCTdV3UDmZRA==
Date: Tue, 26 Aug 2025 12:13:37 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: rust-for-linux@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: Using Rust on non-Rust side of kernel
Message-ID: <aK16wbmeKjq_1RLO@kernel.org>
References: <aKmwPFb4cCk_E-ob@kernel.org>
 <aKxRVlyNXUGBwJ2L@earth.li>
 <aKy5z74FE4paL7za@kernel.org>
 <aK1xvMTqoq-6JyHm@earth.li>
 <aK12y2NuBmA4SfyM@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK12y2NuBmA4SfyM@kernel.org>

On Tue, Aug 26, 2025 at 11:56:48AM +0300, Jarkko Sakkinen wrote:
> On Tue, Aug 26, 2025 at 09:35:08AM +0100, Jonathan McDowell wrote:
> > d4640c394f23 tpm: Check for completion after timeout
> > 2f661f71fda1 tpm: tis: Double the timeout B to 4s
> > 1dbf74e00a5f tpm: End any active auth session before shutdown
> > de9e33df7762 tpm, tpm_tis: Workaround failed command reception on Infineon devices
> > 7146dffa875c tpm, tpm_tis: Fix timeout handling when waiting for TPM status
> > e3aaebcbb7c6 tpm: Clean up TPM space after command failure
> 
> I think we're in the same line here really :-) And apologies for
> over-reacting, I definitely went over the top!
> 
> I did the marshaller/unmarshaller exactly for Rust TPM driver only in
> the sense that if I got a patch set on my table doing that, it would be
> the part which is complex enough that I would actually be in trouble.
> So consider it like "years ahead preparation".

As per having e.g. C driver with some Rust in and all sort of ways to
integrate Rust code etc. I definitely want to experiment with that type
of stuff in experimental branches. It's single best way to learn stuff
to do integrations (factors better than "how to program") at least for
me. Kernel dev is all about how sandboxes are created and not so
much how to program kernel (IMHO).

> 
> I quickly went through your list as a reality check if I have blind
> spot but for the most part it is "business as usual" type of stuff,
> some to change done many years ago (at least as old as tpmrm0).
> 
> Obvious exception to the rule are bugs related to HMAC encryption
> to which I think we have now a resolution.
> 
> BR, Jarkko
> 

BR, Jarkko

