Return-Path: <linux-integrity+bounces-6920-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B83B357BB
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Aug 2025 10:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3C797A3E76
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Aug 2025 08:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D752FD1A1;
	Tue, 26 Aug 2025 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+sH2ZvP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9D028D8ED;
	Tue, 26 Aug 2025 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198608; cv=none; b=gvZwQdZBNQIwHWnozLCl+Ae+3pUq1tv8hXJeGxF55dqitCQpYB7VOWU9uv7Um1KYHuRaH8roe8cjn5Worhg4EMLbbJpg7dclmaewPbeg1Mvmy+RAE3RsO5bx/mSoHIsmubbSHhP5QF84J8cgy5edkMsgfYwrYRFHDSye303JWvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198608; c=relaxed/simple;
	bh=lLjMwJkGmZO68L19BUCN997mBt9nhLyxSUYQQYo4S+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBaGIDHcaoyfQEqeqZgW08V/k4Er9k4av0/vDODTTppuquSeWc3wo12m/aTwD7/r7NMoTw/7WyQG0js30uK0/0Nt2y6BMJSsVaQ76Ny4eadxT60ngDopiNKhFi5siBWFMO6YLtdVmWRE0LyVCZ0DdRiE6VJ3qmotPTXs/liBCx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+sH2ZvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C411C4CEF1;
	Tue, 26 Aug 2025 08:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756198607;
	bh=lLjMwJkGmZO68L19BUCN997mBt9nhLyxSUYQQYo4S+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+sH2ZvPy6MdSEvlwqC5tqOWYIQg3Oe2+Uvhl5a/93n/1rv10OwifYZGmA5LpIsQa
	 LdBf7GMGSR8hWXbFLw2F/wS+X1c8RfBWaGwhR2OVU77st4n/EKr+m95UmHRidYPBGW
	 uM/z3MW+JrH0Y7O1Hnsq9jmuL4Pzk8No43CD1kVUujxffV5y6mKWjwncIhGxM3Tm+v
	 2/DN/xDaHfz/7vY7cO0hyjH9qLdunYAvO+cE/SpOlRoo+iu3R2EB46yRlDaeHntpb0
	 zQim+QS1Y94eNAaUmruMlUNhKsohVZ3tPDxjpqmKCF5Rdu1q9OOQydQvHX/oLDuRWx
	 zjOVX5hjYlkdg==
Date: Tue, 26 Aug 2025 11:56:43 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: rust-for-linux@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: Using Rust on non-Rust side of kernel
Message-ID: <aK12y2NuBmA4SfyM@kernel.org>
References: <aKmwPFb4cCk_E-ob@kernel.org>
 <aKxRVlyNXUGBwJ2L@earth.li>
 <aKy5z74FE4paL7za@kernel.org>
 <aK1xvMTqoq-6JyHm@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK1xvMTqoq-6JyHm@earth.li>

On Tue, Aug 26, 2025 at 09:35:08AM +0100, Jonathan McDowell wrote:
> d4640c394f23 tpm: Check for completion after timeout
> 2f661f71fda1 tpm: tis: Double the timeout B to 4s
> 1dbf74e00a5f tpm: End any active auth session before shutdown
> de9e33df7762 tpm, tpm_tis: Workaround failed command reception on Infineon devices
> 7146dffa875c tpm, tpm_tis: Fix timeout handling when waiting for TPM status
> e3aaebcbb7c6 tpm: Clean up TPM space after command failure

I think we're in the same line here really :-) And apologies for
over-reacting, I definitely went over the top!

I did the marshaller/unmarshaller exactly for Rust TPM driver only in
the sense that if I got a patch set on my table doing that, it would be
the part which is complex enough that I would actually be in trouble.
So consider it like "years ahead preparation".

I quickly went through your list as a reality check if I have blind
spot but for the most part it is "business as usual" type of stuff,
some to change done many years ago (at least as old as tpmrm0).

Obvious exception to the rule are bugs related to HMAC encryption
to which I think we have now a resolution.

BR, Jarkko


