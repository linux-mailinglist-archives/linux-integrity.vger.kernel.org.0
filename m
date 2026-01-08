Return-Path: <linux-integrity+bounces-8199-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00114D0401E
	for <lists+linux-integrity@lfdr.de>; Thu, 08 Jan 2026 16:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1E0B31A1A2D
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jan 2026 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842B944E05F;
	Thu,  8 Jan 2026 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kt3d6w4N"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491FC44B677;
	Thu,  8 Jan 2026 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875604; cv=none; b=htQnar1QFeLPi2vY+nu/hSYaiXmqnV1epmePSGge1OW2f3r3pjDLtLMeOe0xbI2aM8iXMVCmq90CvLnZMKjXL5MLGpTssrHilRzrkL2nRswJdQgaJdC7bvtMukxPQSCfp8SXJ0BnAnv3Id55kOpVzHExSN1zVQFFWw/JBMTysE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875604; c=relaxed/simple;
	bh=8irjAoyU6Q3XVv5nSxgjPfVJ753zDB/rHE+Sm4lpPp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1XxiaAk6fLaSmh7sUWvi2wIO6rDcnILoTK3iK1ovzo0sXsgx34uEk5TCtQ6kbLZnbvc5ylKgG8mgC9gP1CkOahW4qij2HH2l7YH2kVsfyF+oJX9pv67rITZooPLdlBl2LkcATcTFqiFJYj/abCCY5igrN/8DgpUU+3ArzCmYVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kt3d6w4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50283C116C6;
	Thu,  8 Jan 2026 12:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767875603;
	bh=8irjAoyU6Q3XVv5nSxgjPfVJ753zDB/rHE+Sm4lpPp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kt3d6w4NWVxSLbLHjeurILo3vitrE/Zbt2VL/6xlzG1EQzOPOe0Xg3TP7Nnl4Iszf
	 i9qPl1zvi6QMrJLQHk5YMapdK4+rditOFAHeZXDP2Rhj5CSjYAkL2Ia/qTxW5rIpXu
	 eIemY0mUMmkjnJ4Y9t73Ges0KCqCE4Sg12etLpJoDxCyNm1U1f+hh//FA2DWso5hcL
	 mtugiwRCxRvzXzHuXPmRaJ79oaXnK0sVws0lhAUm1K6Eo0vGPpYUNcNHUGnXroQQL8
	 G8KaX+l4BBo8NI2ZUwL9PhpUKhZs3M25Zd5Igh1c6d9E8zYtx0WSBE02f7s3O8TcoH
	 P6MpgR4lQ22QQ==
Date: Thu, 8 Jan 2026 14:33:19 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: stable@vger.kernel.org
Cc: linux-integrity@vger.kernel.org, Jonathan McDowell <noodles@meta.com>
Subject: Re: [PATCH] tpm2-sessions: Fix out of range indexing in name_size
Message-ID: <aV-kD5iKi9fwluU0@kernel.org>
References: <20260108123159.1008858-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108123159.1008858-1-jarkko@kernel.org>

On Thu, Jan 08, 2026 at 02:31:59PM +0200, Jarkko Sakkinen wrote:
> [ Upstream commit 6e9722e9a7bfe1bbad649937c811076acf86e1fd ]
> 
> 'name_size' does not have any range checks, and it just directly indexes
> with TPM_ALG_ID, which could lead into memory corruption at worst.
> 
> Address the issue by only processing known values and returning -EINVAL for
> unrecognized values.
> 
> Make also 'tpm_buf_append_name' and 'tpm_buf_fill_hmac_session' fallible so
> that errors are detected before causing any spurious TPM traffic.
> 
> End also the authorization session on failure in both of the functions, as
> the session state would be then by definition corrupted.
> 
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
> Reviewed-by: Jonathan McDowell <noodles@meta.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---

This is for v6.12.

BR, Jarkko

