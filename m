Return-Path: <linux-integrity+bounces-7779-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 54068C9D8BE
	for <lists+linux-integrity@lfdr.de>; Wed, 03 Dec 2025 03:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F200C349760
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Dec 2025 02:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AF41E8826;
	Wed,  3 Dec 2025 02:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpXKpZVw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5172628;
	Wed,  3 Dec 2025 02:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764727327; cv=none; b=M70h8WTOvqEL+QecFLb59HYfAUTGoMf8C9S6sGIa5lLuTomo5hiIXAMqO17WBxNemaF6z4eJ9vsYvOaLyCYDWYAzaa29xYc6Jh6m1YbtJMtwJzCKOloGN5jPDSKISWiMfyCaruft2E5QHNiVo5soBt7FIjU12y2AdS5k3dCuBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764727327; c=relaxed/simple;
	bh=vuHSrf2VEvDmdiDwv9dbB7gAbg0bgepHkMAYrwtvtmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODdonMbnRYocsJs6TWzyNAVFdhkOPYMRUqBjR2+ziK1Em/D7LrVRCy5nN7voO7bLfB66TOymmctZZV9QNikRKwCqe4UAvJbo1ypj4a+WAA0/1Qvu1nu2+cKjgENJ6gacOxjECatpYd0we3g/90A1OYexZApEgDiQ6+QLCysEwbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpXKpZVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B518C4CEF1;
	Wed,  3 Dec 2025 02:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764727324;
	bh=vuHSrf2VEvDmdiDwv9dbB7gAbg0bgepHkMAYrwtvtmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kpXKpZVwyt/h917aSu1imO8kXg45b+7Mt+ixwoIUxN3XvvzYGjsCTeRNkjA7NcS/e
	 4ZaDlGVLGfNYKy9GTDjnM8N98CBMT2XQOS0zOHlcSNrAKCPSVfNSFQIa70HemadGXu
	 yu0lm4qdLCuHbYA1p2OOR73l12gQxYwqtF7Qwv+0QvJXjtTB9ZYL3xIXWW+x+MBnqY
	 bbNKfhb7Nt1b2dS3241lIk26E39O1qBELmfbcbwEIYmaPLBg8O7dPkDvxJKGmFTjyX
	 DKZxUVfYGpexP3eZbiJ1lLd+Feb2frEisBMdq8NucFZrbAD5ReVwGviF8lexCXKgQl
	 DAunTe5ITnOEg==
Date: Wed, 3 Dec 2025 04:02:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.19-rc1-v3
Message-ID: <aS-aGEmiCks9EY30@kernel.org>
References: <aS4m3QWXzE4nSG1O@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS4m3QWXzE4nSG1O@kernel.org>

On Tue, Dec 02, 2025 at 01:38:05AM +0200, Jarkko Sakkinen wrote:
> The following changes since commit 4664fb427c8fd0080f40109f5e2b2090a6fb0c84:
> 
>   Merge tag 'vfs-6.19-rc1.minix' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs (2025-12-01 15:22:40 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.19-rc1-v3
> 
> for you to fetch changes up to b8b93e380604ce33e41e78522406df011f07aefe:
> 
>   KEYS: trusted: Use tpm_ret_to_err() in trusted_tpm2 (2025-12-02 01:30:23 +0200)
> 
> ----------------------------------------------------------------
> Hi,
> 
> This pull request for TPM driver contains changes to unify TPM return
> code translation between trusted_tpm2 and TPM driver itself. Other than
> that the changes are either bug fixes or minor imrovements.
> 
> Removed commits from earlier revisions and associated lore links:
> 
> 1. "drivers/char/tpm: use min() instead of min_t()"
>    https://lore.kernel.org/all/20251201161228.3c09d88a@pumpkin/
> 2. "Documentation: tpm-security.rst: change title to section"
>    https://lore.kernel.org/all/86514a6ab364e01f163470a91cacef120e1b8b47.camel@HansenPartnership.com/
> 
> BR, Jarkko
> 
> ----------------------------------------------------------------
> Chu Guangqing (1):
>       tpm_crb: Fix a spelling mistake
> 
> Jarkko Sakkinen (3):
>       tpm: Cap the number of PCR banks
>       tpm: Use -EPERM as fallback error code in tpm_ret_to_err
>       KEYS: trusted: Use tpm_ret_to_err() in trusted_tpm2
> 
> Jonathan McDowell (1):
>       tpm: Remove tpm_find_get_ops
> 
> Marco Crivellari (1):
>       tpm: add WQ_PERCPU to alloc_workqueue users
> 
> Maurice Hieronymus (1):
>       selftests: tpm2: Fix ill defined assertions
> 
> Stuart Yoder (1):
>       tpm_crb: add missing loc parameter to kerneldoc
> 
>  drivers/char/tpm/tpm-chip.c               | 36 -------------------------------
>  drivers/char/tpm/tpm-dev-common.c         |  3 ++-
>  drivers/char/tpm/tpm-interface.c          | 20 +++++++++++++----
>  drivers/char/tpm/tpm.h                    |  1 -
>  drivers/char/tpm/tpm1-cmd.c               |  5 -----
>  drivers/char/tpm/tpm2-cmd.c               |  8 +++----
>  drivers/char/tpm/tpm_crb.c                |  4 +++-
>  drivers/char/tpm/tpm_tis_core.c           |  3 +--
>  include/linux/tpm.h                       | 12 +++++++----
>  security/keys/trusted-keys/trusted_tpm2.c | 26 ++++++----------------
>  tools/testing/selftests/tpm2/tpm2.py      |  4 ++--
>  11 files changed, 42 insertions(+), 80 deletions(-)

This is getting silly but I'll update this one more time.

BR, Jarkkok

