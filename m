Return-Path: <linux-integrity+bounces-4760-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C61A2D8A9
	for <lists+linux-integrity@lfdr.de>; Sat,  8 Feb 2025 21:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6977F1888A0C
	for <lists+linux-integrity@lfdr.de>; Sat,  8 Feb 2025 20:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386B5243961;
	Sat,  8 Feb 2025 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnxQYAV4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103B0243942;
	Sat,  8 Feb 2025 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739046777; cv=none; b=PU0nsI2qwzKyRukDlSXXzE3zDetQz5kgE7jSPn8wFmxYNdHcVtWB2G4m1jrZSo0AtkWajLvjelmNQI+/WHRYq34onrw3Ii3wPt1FmMmAsbFEn6z73Yt4Hs4TgrzgBgkiJ6Islxqdv4iumOLj5nwqQTS6FEhmcx58N5Ge0/ODZoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739046777; c=relaxed/simple;
	bh=Ltr/1l/SbDtKRZMIZzd9idiEi51kqu97pT2cF7X4xxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoDY5XKfTSbmeB5TxAdVI5RCy31iCKuosNcRnn4P45/btUDZ6MaxEIGvwTqvXKF2Mxs+vE92hA4zNKgY07prYeAQxYuWzNOk0VwZNst1Do/YndAG6w3NEd2enKZqH+DYck6vLLHo+r4vZfGeoyPy52WJrFHT4NL35xciWnmXPFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnxQYAV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A25C4CED6;
	Sat,  8 Feb 2025 20:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739046776;
	bh=Ltr/1l/SbDtKRZMIZzd9idiEi51kqu97pT2cF7X4xxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UnxQYAV4NuOMGp2dph5SgknSoBHveIpqBvhOTmUaX/mwqZFxwwW1FsksrAmYXOwEL
	 s7b/4inNTNLhPHAZu3GG9Fw/Ii+ZHsvSO9bAi8ktHar7jNQ6KvUGX6cYwLDSk/vDWv
	 muXa2so2JVfN1tzj6uNJjyeEW7ywuvk24nuD+1J6gYxO4ZKZXNgO8cJuHShlxj8TPF
	 Vkw5gWGMSrqLtJlPgFp2F1Qqz7Zt6GKnJ7JGZHVZ8MPIOiGM3qhuFUa+7Nuf5P6eCL
	 l5NMkTDUQjN+r6DbUl2n465AMbDUNrWlB0cl0aitxbM4ITFMIDIRUtE+K/017yzXPS
	 E+GBRXHkNSWzw==
Date: Sat, 8 Feb 2025 22:32:52 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mike Seo <mikeseohyungjin@gmail.com>, kernel-dev@igalia.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] tpm: do not start chip while suspended
Message-ID: <Z6e_dGIdUROiqgMo@kernel.org>
References: <20250207-tpm-suspend-v2-1-b8cfb51d43ce@igalia.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-tpm-suspend-v2-1-b8cfb51d43ce@igalia.com>

On Fri, Feb 07, 2025 at 03:07:46PM -0300, Thadeu Lima de Souza Cascardo wrote:
> Checking TPM_CHIP_FLAG_SUSPENDED after the call to tpm_find_get_ops() can
> lead to a spurious tpm_chip_start() call:

Looks good to me.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

