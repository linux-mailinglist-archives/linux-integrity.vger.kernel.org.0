Return-Path: <linux-integrity+bounces-7876-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCA4CB06E4
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Dec 2025 16:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 476BC3009F75
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Dec 2025 15:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA5D2ED15F;
	Tue,  9 Dec 2025 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUp0ow5U"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E738C223DD4;
	Tue,  9 Dec 2025 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765294974; cv=none; b=kFvUK5RmoPEEGHFa6Qd0J8fi1eavYjIN+Ju77VdwLlYzB1+jeyPdeT/KcOMog61Ry0KRaViJpnR8dWGc7P0dox2udNH5LHLGDbc99SXo/UBOiHSryhK8HgGsBbu6YgTdN8gqDUeJiwVwW5Tvwp+z+HlNWtVH8elWIulq2mAHa70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765294974; c=relaxed/simple;
	bh=h22s+vDLdBYW1znnXtPe86wywszUj5z1THYtyGXrvBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHqdAPa2y1ccqIz8vHXgJ5O5k8O/i9VRIVw0z+POltwyX3BLH+vCpzTnQtYNAtbK0GeJexEK1GKbOONtiggxoHrpbsFYy6wtP/sWf/n6Z8IiLJacs3F5L/LJiS/V2Rt5fHlJInnfn/+1biFI45HerE2OHjphyhQt6mJRSCc7pjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUp0ow5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E79C4CEF5;
	Tue,  9 Dec 2025 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765294973;
	bh=h22s+vDLdBYW1znnXtPe86wywszUj5z1THYtyGXrvBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NUp0ow5U4mbTQW7pk0uCDeKgXS+rLRU5T3PVlpimPydbCn7o5PJnyqBI2h6bqgfur
	 TYf/eevyAufBwGsQ5uhX4H5QuBUuoLuGrGAsVEkEsOL6maMEWwveZ0yS1nIAu5kx9c
	 5zcfM+n+ez7TFAebQ5i5D/sCXbzGc7EOgAPdpeid84/wAfVUIYt27SsMZXfTGPRUro
	 DzH2R60WYYbId3NMHFt3EdoxnjmBOgZiVp/XU3k+b0RBO/Y0WqYG6jHRz8+OY6hJOz
	 fiPm93AhDwdgf1LkifUz9CBIpMXwK6546caIyFcS7J0wyZQW0mG/ThO1yKOdaee18E
	 MZzA5bmlPAt/w==
Date: Tue, 9 Dec 2025 17:42:49 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Streamline TPM2 HMAC sessions
Message-ID: <aThDeSWFhbI6GRgh@kernel.org>
References: <20251209100529.1700779-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209100529.1700779-1-jarkko@kernel.org>

On Tue, Dec 09, 2025 at 12:05:23PM +0200, Jarkko Sakkinen wrote:
> Since we cannot at this point cache names of the keys given limitations
> of the ASN.1 file format, I'll start a fresh patch set. Let's fixup what
> we can right now.
> 
> This patch set addresses two major issues in the feature:
> 
> 1. Dynamic resolution without gain. All kernel sites have at most single
>    handle to authorize. Even if this changes some day this is how it is
>    as of today and we definitely do not want to dictate the future but
>    instead downscale code to the metrics that we have as of today.
> 2. Eliminate at least one unnnecessary tpm2_read_public() call.
> 
> Jarkko Sakkinen (5):
>   KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
>   tpm2-sessions: Define TPM2_NAME_MAX_SIZE
>   KEYS: trusted: Re-orchestrate tpm2_read_public() calls
>   tpm2-sessions: Remove AUTH_MAX_NAMES
>   tpm-buf: Remove tpm_buf_append_handle
> 
>  drivers/char/tpm/tpm-buf.c                |  25 ----
>  drivers/char/tpm/tpm-sysfs.c              |   2 +-
>  drivers/char/tpm/tpm2-cmd.c               |   9 +-
>  drivers/char/tpm/tpm2-sessions.c          | 130 ++++++---------------
>  include/linux/tpm.h                       |  49 +++++---
>  security/keys/trusted-keys/trusted_tpm2.c | 134 +++++++++++++---------
>  6 files changed, 155 insertions(+), 194 deletions(-)
> 
> -- 
> 2.52.0
> 

For hwrng we can e.g., calculate factor by timing tpm2_get_random() with
and without HMAC encryption. Then we can use this as frequency how often 
data is pulled.

The other angle to combine this is to maintain largeish FIFO of random 
bytes and fill this when it goes below a treshold. 

Probably some combination of these will provide answer to performance
and latency problem with hwrng when HMAC encryption is turned on:

1. The first amortizes the overall quota.
2. Second provides constant latency without major spikes.

BR, Jarkko

