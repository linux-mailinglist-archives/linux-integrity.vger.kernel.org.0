Return-Path: <linux-integrity+bounces-7759-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB69C99978
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Dec 2025 00:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9B604E1F51
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Dec 2025 23:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E162882C5;
	Mon,  1 Dec 2025 23:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nL1PtSl+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B6827E7EC;
	Mon,  1 Dec 2025 23:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764631673; cv=none; b=o9e9dq7hYPmDSBjc+Ab6SMHFRS8zoXp47H3Avm9avH9UzMHT6VIoT6iVsWxdL6X95jpH/G7zLNRPaO/sYXSL+jkscEj9vzKNBGCg2OmGpkFPJYd4Bb3LLkvYOG1PHnUW5wMnMocnKDJgDSu6FBY0hOZte2S2Dagq7QV6FUvC4Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764631673; c=relaxed/simple;
	bh=inLNL8E26pgqjT/rKTiuliM4Lttsj3qgeDv0NsqxiO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qo5kyCXYciueIFIANnpdSn99/8Qwbovc8vEsXas6XeYt1Oazl7vQRHuw9pSrU4jA8YUl2XqCIMdRT/sgYC+2JpghpGjTJv5hU4m7RTPX8zpK8Ot7ul7Ge1V3Qmiy6HSt8VOZo40WRYUD6++zMobJFnnu1JPHwODAaO5n5Mi/evw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nL1PtSl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FADC4CEF1;
	Mon,  1 Dec 2025 23:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764631673;
	bh=inLNL8E26pgqjT/rKTiuliM4Lttsj3qgeDv0NsqxiO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nL1PtSl+eBpvXuXYOb1bSZ6WPwhBoDZpAiduaDApPeEVwviLFsW9bJr67EGX60gy6
	 E0taiR4sliz8OrEb7MI1RxO2JMSyoxKPjW687o5w/cXGP4e7R0N+ctnfaXYWTdsJcH
	 eiwzWZ8Tp5qDIwJfUQtC5iG8bYNp4GRUqTY+KHU1hVO62KxhVAhANVWeqqfceZDyyY
	 BMh8+FWQDz0rYYDrpUWfZNcfd5/kBN5v14Kvx+akJ2jQCWGNzAxB/nLaSGPsnBqgqG
	 B7eLBWBS4hfNPwVRtCMWwHbJN6KMhwKu5cpJohMvPAEeNQHf7WyNlYghzJ0o+mg6dI
	 Nytns7xBQKAKA==
Date: Tue, 2 Dec 2025 01:27:49 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] tpm2-sessions: Fixes for v6.19
Message-ID: <aS4kdQpJPWztYZw1@kernel.org>
References: <20251201224554.1717104-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201224554.1717104-1-jarkko@kernel.org>

On Tue, Dec 02, 2025 at 12:45:48AM +0200, Jarkko Sakkinen wrote:
> I collected the accumulated fixed for tpm2-sessions, given that I need
> to still redo TPM driver pull request.
> 
> Jarkko Sakkinen (4):
>   tpm2-sessions: address out-of-range indexing
>   tpm2-sessions: Fix tpm2_read_public range checks
>   tpm2-sessions: Remove 'attributes' parameter from tpm_buf_append_auth
>   tpm2-sessions: Open code tpm_buf_append_hmac_session()
> 
>  drivers/char/tpm/tpm2-cmd.c               |  42 ++++-
>  drivers/char/tpm/tpm2-sessions.c          | 197 ++++++++++++++--------
>  include/linux/tpm.h                       |  31 +---
>  security/keys/trusted-keys/trusted_tpm2.c |  41 ++++-
>  4 files changed, 197 insertions(+), 114 deletions(-)
> 
> -- 
> 2.52.0
> 

Not putting to the first pull request tho but hopefully get these merged
during the cycle.

BR, Jarkko

