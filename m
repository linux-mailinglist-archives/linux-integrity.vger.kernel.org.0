Return-Path: <linux-integrity+bounces-7807-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3665BCA5AE5
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Dec 2025 00:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13DD4307483A
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Dec 2025 23:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71F931354A;
	Thu,  4 Dec 2025 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bG7rreyu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43C92C11EB;
	Thu,  4 Dec 2025 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764890430; cv=none; b=ALK/kUdHeh3KOqgl+2nWffq3wPF1n+GBooHLLgP5DYsPhjyU80tEUo2GvqrBXz6PjsQoAE/UFrC93mXcSSVNhfMyaRrbFbp+3lJeGNId1kbSiSkNxwn6WVNxBYtHmx7OhZ8e3qVVOqtTcGwc7iTEhsFkxg0S2Hza9Q6SW5zB/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764890430; c=relaxed/simple;
	bh=MnTTaKwXV957osDrcVgHqsxyuFdRStJEoxr+arT8VtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yntk4mFHgL9TopQ1D3vuZPVFoqGMuhfEu4NMYMZh4JM6J+cXxWVltTo8hTGaVJkh874cdUtR01FPQQYnoTj1V8SDTEpOpwmU0KjGXloR3Lfoe9/Tu9wLRptfBE/tRrU8mpr4DpeEoKM/Kpj3vvrOb2GEB/UIIawJTjGjhiVavNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bG7rreyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9C2C4CEFB;
	Thu,  4 Dec 2025 23:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764890430;
	bh=MnTTaKwXV957osDrcVgHqsxyuFdRStJEoxr+arT8VtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bG7rreyu3Gy9A+mFyNPI6WwyccbbswXyP4foJC+RujSDRZEFfyoHSQ3oCYjmWSCXK
	 NL7N/8LZRhGOZPuRGZp4ysyzPWPsMZn1p+Ad1OLLGcTvYM/g1n1BuNT02ehS7LWjhM
	 zwosg8wWWEKmTzuv8d5jIOQRSAfsDUfrp2EryLjwAZAtP8zHzB+4jCpA0AF/F5F0kQ
	 0cvdSH26ChgSyQVCI2JwlYaeqJq3zS+lxLVyUN9J4cbnjpPYkcN4jWk+VzHCQFiQQH
	 C3oNfPC0gBZa+CxWiV4JZWDuHTCKnRvH1HRcVGjUTZ+JJR/m+4mvx9/kCIpyMO4qq1
	 xjsBqfuPxjh+A==
Date: Fri, 5 Dec 2025 01:20:26 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] KEYS: trusted: Re-orchestrate tpm2_read_public() calls
Message-ID: <aTIXOr3rpI9xufTl@kernel.org>
References: <20251204223128.435109-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204223128.435109-1-jarkko@kernel.org>

On Fri, Dec 05, 2025 at 12:31:27AM +0200, Jarkko Sakkinen wrote:
> tpm2_load_cmd() and tpm2_unseal_cmd() use the same parent, and calls to
> tpm_buf_append_name() cause the exact same TPM2_ReadPublic command to be
> sent to the chip, causing unnecessary traffic.
> 
> 1. Export tpm2_read_public in order to make it callable from 'trusted_tpm2'.
> 2. Re-orchestrate tpm2_seal_trusted() and tpm2_unseal_trusted() in order to
>    halve the name resolutions required:
> 2a. Move tpm2_read_public() calls into trusted_tpm2.
> 2b. Pass TPM name to tpm_buf_append_name().
> 2c. Rework tpm_buf_append_name() to use the pre-resolved name.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

If ASN.1 blob would contain also name of the parent then zero
tpm2_read_public() calls would be required i.e., the main bottleneck
here inherits from the limitations of the file format itself.

BR, Jarkko

