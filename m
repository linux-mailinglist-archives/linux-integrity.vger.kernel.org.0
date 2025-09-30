Return-Path: <linux-integrity+bounces-7310-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0660BACA42
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 13:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD7A19272EE
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 11:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735F023AB8E;
	Tue, 30 Sep 2025 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="AAMcnL1i"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B21B34BA29;
	Tue, 30 Sep 2025 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230655; cv=none; b=inL6sAJK7C+g4c1z9NKAu31jguE8YAyb1/T4Sc96qHc7t9cCNXWlVWzS4MpDdD//5owcWWp0JbEza3sktZ+/xlLwPGhQbB5/N6PDzbu7uE13Z9MMJeDsbectzQCTcUqU1mKktIeFiB+X6kYzJGOplm9eoEuxYOGOaQgRU1eSnsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230655; c=relaxed/simple;
	bh=EDAZqqzxu9H/EJ9imMXgz+Txvgn/w1enGbuBd/jhMgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YI9FdZ2JV3Br1pEtrD0M43FXkppaQfy6EzX17GT5FB6DKXb8p1Q5RzHLNrQ033mtmJwRV9shlz4+CfX1SUCh6IAtnznuvQM0Y+WwmTyhCG4cNVIgxA2UZXpWw3txsPtKN+4P0DYP2OCrHA0fMV3svRzeHa3SHQFzouKGwditEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=AAMcnL1i; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VV/gTZBqClU1FvL2tmsAtbQIqHipBUWV7jGxOZGXtvc=; b=AAMcnL1i/ElDOb6lYABbVkJrVC
	X2U42CldJm7p9b4IQ6BZob9VPBXYGc4FPrSpgf2DiO29EVYKR6ZFMnYjDb55UsUGtTnL+U/pw4ign
	vHvTFwmEWvSmUi0JOGiVUIbCQADixjVqh7TFvzoC44bRN8+PqBCthn3SwSnxHjug0hYbF30GtKO9+
	NjDGh9DrKdPV9R2DYHr2KI9pD6KV+R1sZxyR/dNDur59b+NnkxLfukPgCJQmWECGOCMomP/cK8RMT
	dRy2oPgp70F3lXGuym4boL/jCaN2tGOf8mDZwreyEFA8qE82Ork/y9b4jQ0ZZ6HFyPV7krQtiIsbg
	80Iry1AA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1v3YFl-006yWS-2u;
	Tue, 30 Sep 2025 12:10:41 +0100
Date: Tue, 30 Sep 2025 12:10:41 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 04/10] tpm2-sessions: Remove 'attributes' from
 tpm_buf_append_auth
Message-ID: <aNu6sZc-JTPhFTLV@earth.li>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-5-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929194832.2913286-5-jarkko@kernel.org>

On Mon, Sep 29, 2025 at 10:48:26PM +0300, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> In a previous bug fix, 'attributes' was added by mistake to
> tpm_buf_append_auth(). Remove the parameter.
> 
> Fixes: 27184f8905ba ("tpm: Opt-in in disable PCR integrity protection")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Reviewed-by: Jonathan McDowell <noodles@meta.com>

> ---
> v3:
> - No changes
> v2:
> - Uncorrupt the patch.
> ---
>  drivers/char/tpm/tpm2-cmd.c      | 2 +-
>  drivers/char/tpm/tpm2-sessions.c | 5 ++---
>  include/linux/tpm.h              | 2 +-
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index a7cddd4b5626..86b1a4d859b9 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -191,7 +191,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
>  	} else {
>  		tpm_buf_append_handle(chip, &buf, pcr_idx);
> -		tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
> +		tpm_buf_append_auth(chip, &buf, NULL, 0);
>  	}
>  
>  	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index 6d03c224e6b2..13f019d1312a 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -266,7 +266,7 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
>  EXPORT_SYMBOL_GPL(tpm_buf_append_name);
>  
>  void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
> -			 u8 attributes, u8 *passphrase, int passphrase_len)
> +			 u8 *passphrase, int passphrase_len)
>  {
>  	/* offset tells us where the sessions area begins */
>  	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
> @@ -327,8 +327,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
>  #endif
>  
>  	if (!tpm2_chip_auth(chip)) {
> -		tpm_buf_append_auth(chip, buf, attributes, passphrase,
> -				    passphrase_len);
> +		tpm_buf_append_auth(chip, buf, passphrase, passphrase_len);
>  		return;
>  	}
>  
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 51846317d662..1fa02e18e688 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -531,7 +531,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
>  				 u8 attributes, u8 *passphrase,
>  				 int passphraselen);
>  void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
> -			 u8 attributes, u8 *passphrase, int passphraselen);
> +			 u8 *passphrase, int passphraselen);
>  static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
>  						   struct tpm_buf *buf,
>  						   u8 attributes,
> -- 
> 2.39.5
> 
> 

J.

-- 
   101 things you can't have too   |  .''`.  Debian GNU/Linux Developer
       much of : 17 - Money.       | : :' :  Happy to accept PGP signed
                                   | `. `'   or encrypted mail - RSA
                                   |   `-    key on the keyservers.

