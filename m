Return-Path: <linux-integrity+bounces-8007-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB47CC02BA
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 00:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E32B30145AD
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 23:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF69279DC2;
	Mon, 15 Dec 2025 23:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7ZrR0GL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CF0216E24;
	Mon, 15 Dec 2025 23:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765841111; cv=none; b=XCxicSCrk9igrIwmk9qF4sZVpUviZWwXkURULCDsW6mdMcY2kg9pSvk5SsxAv/JgwB4+gZR/N0LbWr1zneqc5KyasE/EGZjKvuMc6Fq+cQ7k+KbP1CdPJj49Xd9MuWQWASVhvJyfH5r7alxTXgwjL8fIJuWQowUSP5kDCSQ7LBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765841111; c=relaxed/simple;
	bh=Qy5lP0OR9gCF+HsIH5DH0g7d5yl1T1AVgNU0AxMjSMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvHq871RKvV22Np7vaXFbM0AYxkOKoBKGHo0li5owF72bK6gzMn+p9cp/F1x2zuI5i0EJNGTtGg3TGAZb7v0bqcfS/omIlj5x7X1lGWyzIeCS1ZVrorP4T16NcFsnseSJRVfIV8oHSA7sYyFodzv3Zz+KH1E8Rdo81i2ITHMmc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7ZrR0GL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058BCC4CEF5;
	Mon, 15 Dec 2025 23:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765841110;
	bh=Qy5lP0OR9gCF+HsIH5DH0g7d5yl1T1AVgNU0AxMjSMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7ZrR0GLPRBSw+0dkaMD2ReNFrOR3TjhlN/dNS7OBwmDa+2gURDZMoQLxMY/CRo/A
	 yxfdqznCLcm/43oQAet+LK87SzOFldkXf9TxAuCoe0qNfByzX77d2JNuA+a/nVY8qO
	 7aGC9fLJGMkCygAzcYuhrXwyb5xKldDllgWQ4VwrIgIgm+mMvfcK/SeP60RwVKWl72
	 GPHzXVrGf2wKaSBLALzPp2sGK29tHVmmTTuDMO9N5CHu0aIGuHaNsTGYcAtj+9NY5M
	 NIyhL/F4E55k9Gkb5nPrj2TWnNYPe4YOtyaaY4ShU7Uxt1JlF4Ha8B1h+tAbrrqh0i
	 pVPZoHsZS1QPA==
Date: Tue, 16 Dec 2025 01:25:06 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] KEYS: trusted: Use get_random-fallback for TPM
Message-ID: <aUCY0oF3Ts0V7H1h@kernel.org>
References: <20251215231438.565522-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215231438.565522-1-jarkko@kernel.org>

On Tue, Dec 16, 2025 at 01:14:38AM +0200, Jarkko Sakkinen wrote:
> 1. tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled and thus its
>    use should be pooled rather than directly used. This both reduces
>    latency and improves its predictability.
> 
> 2. Linux is better off overall if every subsystem uses the same source for
>    generating the random numbers required.
> 
> Thus, unset '.get_random', which causes fallback to kernel_get_random().
> 
> One might argue that TPM RNG should be used so that generated trusted keys
> have the matching entropy with the TPM internally generated objects.
> 
> This argument does some weight into it but as far cryptography goes, FIPS
> certification sets the exact bar, not which exact FIPS certified RNG will
> be used. Thus, the rational choice is obviously to pick the lowest latency
> path.
> 
> Finally, there also some actual defence in depth benefits on using kernel
> RNG. E.g., it helps to mitigate TPM firmware bugs concerning RNG
> implementation, which do happen in the wild occasionally.
> 
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

I noticed also some typos in the commit message.

I think I will also supplement this with a patch that unexports
tpm_get_random(), as the patch zeros the external call sites.

Full encapsulation to the driver is exactly should aim for in order to
make hwrng easier target for further optimizations.

BR, Jarkko

