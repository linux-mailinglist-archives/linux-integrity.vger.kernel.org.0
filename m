Return-Path: <linux-integrity+bounces-7434-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AC3BDE344
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Oct 2025 13:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33929504F58
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Oct 2025 11:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFB531A560;
	Wed, 15 Oct 2025 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEham1AU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B05B31CA5E;
	Wed, 15 Oct 2025 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526380; cv=none; b=Fxn6yr6N+HU3xoWvrIgFU3e8BXaKh8ccvdvv8irXtUHiz7CbNViH5mFbIfUuv3qrOCdTvQZJqPCWASqWXHG5dS/up2zi2kXUGOI0r811D7vAOIRvxSRK/a/c8+d09AI+y1DJ93/amliixxETRf+TrZLHvkQAjY4ro4OQbrVRdNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526380; c=relaxed/simple;
	bh=fTXvcK/lAXjVHIAq2Mwskl0w9FOm9oRJ609SvZs/uQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACrM4L9f3csAWG1TfpyJDAwfzIoy521DgGs6VePbRy5EivXsVMalxFtHhR51Uy9ur7p0yq7K6D9Nq45phYgjGJpt4ZuHVy907sAkMKDRV+iDJOh8DhqPOyZpqEAZQbvoKFM2A5jpC1Sh2oIyQ+7VHLMvkqtNGh0pAOtT0pPPPZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEham1AU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AB6C4CEFE;
	Wed, 15 Oct 2025 11:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760526380;
	bh=fTXvcK/lAXjVHIAq2Mwskl0w9FOm9oRJ609SvZs/uQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sEham1AUkuxN/0R72jL23MyC2xu9WiTFl/7wbePmfgRk33hHyz6lHDVmumWWhkm2X
	 J75KGhprm7vQqzZQozbfmNEtxgvKsaGbhlH1wUGCH+v+Hjmai5YS23O8xO+taUwpPm
	 JL8kCR5YcEjRiZo0Y/GEssB0xacWO1AcTxli4VSumq94Jqn1DygFd0idMfCAaQVHNd
	 ka2QojkzJVr7NNBn03SGw1kpe0mFEFhDNYlCcp6uLXYz5385fXVTxtVMNuBEZWO4cS
	 khy510Z5RWIga8IpJOt3ZrLeQpQ6usVMJMKm5t0kI/urrqQpb/w+hIjXNRYHigae5d
	 haixsjgnlZ8dg==
Date: Wed, 15 Oct 2025 14:06:16 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>,
	David Howells <dhowells@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] keys: Replace deprecated strncpy in
 ecryptfs_fill_auth_tok
Message-ID: <aO-AKMHUzTmACgwE@kernel.org>
References: <20251013152627.98231-2-thorsten.blum@linux.dev>
 <b9246396-c9d9-4452-a16c-f2c8166a32ee@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9246396-c9d9-4452-a16c-f2c8166a32ee@molgen.mpg.de>

On Mon, Oct 13, 2025 at 06:11:38PM +0200, Paul Menzel wrote:
> Dear Thorsten,
> 
> 
> Thank you for the patch.
> 
> Am 13.10.25 um 17:26 schrieb Thorsten Blum:
> > strncpy() is deprecated for NUL-terminated destination buffers; use
> > strscpy_pad() instead to retain the NUL-padding behavior of strncpy().
> > 
> > The destination buffer is initialized using kzalloc() with a 'signature'
> > size of ECRYPTFS_PASSWORD_SIG_SIZE + 1. strncpy() then copies up to
> > ECRYPTFS_PASSWORD_SIG_SIZE bytes from 'key_desc', NUL-padding any
> > remaining bytes if needed, but expects the last byte to be zero.
> > 
> > strscpy_pad() also copies the source string to 'signature', and NUL-pads
> > the destination buffer if needed, but ensures it's always NUL-terminated
> > without relying on it being zero-initialized.
> > 
> > strscpy_pad() automatically determines the size of the fixed-length
> > destination buffer via sizeof() when the optional size argument is
> > omitted, making an explicit size unnecessary.
> > 
> > In encrypted_init(), the source string 'key_desc' is validated by
> > valid_ecryptfs_desc() before calling ecryptfs_fill_auth_tok(), and is
> > therefore NUL-terminated and satisfies the __must_be_cstr() requirement
> > of strscpy_pad().
> > 
> > Link: https://github.com/KSPP/linux/issues/90
> > Reviewed-by: Kees Cook <kees@kernel.org>
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> > Changes in v3:
> > - Improve commit message
> > - Link to v2: https://lore.kernel.org/lkml/20251010161340.458707-2-thorsten.blum@linux.dev/
> > 
> > Changes in v2:
> > - Improve commit message as suggested by Jarkko and Kees
> > - Link to v1: https://lore.kernel.org/lkml/20251009180316.394708-3-thorsten.blum@linux.dev/
> > ---
> >   security/keys/encrypted-keys/ecryptfs_format.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/security/keys/encrypted-keys/ecryptfs_format.c b/security/keys/encrypted-keys/ecryptfs_format.c
> > index 8fdd76105ce3..2fc6f3a66135 100644
> > --- a/security/keys/encrypted-keys/ecryptfs_format.c
> > +++ b/security/keys/encrypted-keys/ecryptfs_format.c
> > @@ -54,8 +54,7 @@ int ecryptfs_fill_auth_tok(struct ecryptfs_auth_tok *auth_tok,
> >   	auth_tok->version = (((uint16_t)(major << 8) & 0xFF00)
> >   			     | ((uint16_t)minor & 0x00FF));
> >   	auth_tok->token_type = ECRYPTFS_PASSWORD;
> > -	strncpy((char *)auth_tok->token.password.signature, key_desc,
> > -		ECRYPTFS_PASSWORD_SIG_SIZE);
> > +	strscpy_pad(auth_tok->token.password.signature, key_desc);
> >   	auth_tok->token.password.session_key_encryption_key_bytes =
> >   		ECRYPTFS_MAX_KEY_BYTES;
> >   	/*
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thanks for the review Paul.

David: and also this is in my tree now.

> 
> 
> Kind regards,
> 
> Paul

BR, Jarkko

