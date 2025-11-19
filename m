Return-Path: <linux-integrity+bounces-7628-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4FFC6C5CF
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 03:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 9E29A2980F
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 02:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D5827E056;
	Wed, 19 Nov 2025 02:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdxBYC1t"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22612749E0;
	Wed, 19 Nov 2025 02:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763519140; cv=none; b=qNZ4GVyRYcHQnomju+6x2drdK0slpw0hML/pDdjp2BOZsuMEmCg331YqTnJgt7y4hfrqSzjLOcw28HbrztIFHdSAMw6l7loe1LY8Do3k5dH+oh/odnu/u1F/pfBux3/5SK0C1SlxG7kSurLw01/2U58lPFHaRW2a8i1DC2l3q8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763519140; c=relaxed/simple;
	bh=tmiNdpSfCQrqGz9h+Ubl20jUUyrrwnSDRTn9tkVXLOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqWTKkPfOM6PS4mui4lu3FqTQIXZrMAPu1ZpNIMbaZ9bBtnlDRtaENwAGawwqlWk2SLpZ3Qafc+u+fDgX+j4hLuzDpTCLTtxg2vHpywHmatm0FDMTjYBgl6HCx7XoBaCK6UrNZDLfdUg+D7zNYwzVYBwWVrKQ6bm7qkMLGnENn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdxBYC1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6511FC16AAE;
	Wed, 19 Nov 2025 02:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763519140;
	bh=tmiNdpSfCQrqGz9h+Ubl20jUUyrrwnSDRTn9tkVXLOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OdxBYC1taI5YFX3tCWo8kt9ZkzRHAfSlNho04j0o8Tvo4zHO2NAj31O/8YUmjCkUq
	 bNVmlG1VfBBXpXYAUK0lhLGhNZiKQnbV5KG9xYRHockoDco+eEhQ5SthJJyQB8RKvo
	 qTIl0tIEMGyt7jx+mIehE4BzpoMzAHr3cnbxDMKwLG6Mrzwm1lAlBNzXP35WtiEh6v
	 XsFUh+nVTW+2aGQJbqPlXvo42Hl7QOgW+75mFG+ItSUNXVIPbbsiPI7k31OwcioI5u
	 AsLXraTEQnTQh6M3SJbm0PDgatzgZ4wa9CyPIV3TzvoT8qgy5AojHKUjKlUDltzurw
	 v+857PSSVejGA==
Date: Wed, 19 Nov 2025 04:25:34 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ye Bin <yebin@huaweicloud.com>
Cc: a.fatoum@pengutronix.de, kernel@pengutronix.de,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	yebin10@huawei.com
Subject: Re: [PATCH] KEYS: Remove the ad-hoc compilation flag CAAM_DEBUG
Message-ID: <aR0qnooQzFXGFMD7@kernel.org>
References: <20251028132254.841715-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028132254.841715-1-yebin@huaweicloud.com>

On Tue, Oct 28, 2025 at 09:22:54PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Fix the broken design based on Jarkko Sakkinen's suggestions as follows:
> 
> 1. Remove the ad-hoc compilation flag (i.e., CAAM_DEBUG).
> 2. Substitute pr_info calls with pr_debug calls.
> 
> Closes: https://patchwork.kernel.org/project/linux-integrity/patch/20251024061153.61470-1-yebin@huaweicloud.com/
> Signed-off-by: Ye Bin <yebin10@huawei.com>

$ git am -3 20251028_yebin_keys_remove_the_ad_hoc_compilation_flag_caam_debug.mbx
Applying: KEYS: Remove the ad-hoc compilation flag CAAM_DEBUG
error: sha1 information is lacking or useless (security/keys/trusted-keys/trusted_caam.c).
error: could not build fake ancestor
Patch failed at 0001 KEYS: Remove the ad-hoc compilation flag CAAM_DEBUG
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Hmm.. Could you send me a new revision rebased on top of my tree?

BR, Jarkko

