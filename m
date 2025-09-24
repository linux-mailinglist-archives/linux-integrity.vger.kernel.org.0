Return-Path: <linux-integrity+bounces-7273-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1722FB9B095
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 19:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31543A9DA8
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2CF314A73;
	Wed, 24 Sep 2025 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT0rC6GB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1C031985B;
	Wed, 24 Sep 2025 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758734323; cv=none; b=mWNAjfiqQFqgXINTupmSEqzUVxm/sUsrmyThwOI+SqmaVci3A2zFZlFTl4F5spsNsw+/BEl28jDvTpZ2SANlwv3YRidxcj2ZtE1xKR39FgqaaBekbJkUJHEZbMoByjpaWTox+2T0StekO6pw5WnLJW7AL5vqZSFQbokgKVe5QW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758734323; c=relaxed/simple;
	bh=w2qKd9qg1A3iMaSfcdJ4JOxfH/9XFYnZiWK1cudMU4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cd9iZ+4BmP8mhKW3VvWPwlPHY1AlCVHdYH+fwKLXyYa7giSgmQYhdj4RiCaRTopu9FuXew9YfTeEir4kc98DD2G1SLQBSxFEgB9EYBvCSQ/85BtKsRhfpUSnj57FlwmFEkcS+g97oRxKctseSp8eqZsDrENnKShC74aKGhjVw0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT0rC6GB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B34DC4CEE7;
	Wed, 24 Sep 2025 17:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758734322;
	bh=w2qKd9qg1A3iMaSfcdJ4JOxfH/9XFYnZiWK1cudMU4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kT0rC6GBKM8Ekn84hnxuOBeiZfcds4IqCt2OI1Agf1zucMOY2f14lWK6bsYo4tCIL
	 PRUCX44Lq7pysMMXVyre1ajHBCcsi+7GwhuILZYwfkE5r9MQzxhxZbns+DviT8DB0g
	 ZssP9A+cuNZd9F1UaQCJrHhKXh2gtnlekt25SUgVZKxKoKswzEAfzHJLVxaCQaNwzc
	 IN99MKFH4H/lIcOCsXU00LxvhGxzZrppNqIQQzdEK5DS2tLdfHFAVL6iSmgHOchPdM
	 RBThf9Ty0lIOOfOhs4k3yLkCXx3MR5wV6dTGHyGy34lkmVLp6M+k2vOg1xHujvVvRL
	 WrVPehJkihdaw==
Date: Wed, 24 Sep 2025 20:18:38 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 2/4] tpm2-sessions: Remove unused parameter from
 tpm_buf_append_auth
Message-ID: <aNQn7ioBDDDexkWj@kernel.org>
References: <20250922164318.3540792-1-jarkko@kernel.org>
 <20250922164318.3540792-3-jarkko@kernel.org>
 <aNOwP99WNsDgBVof@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNOwP99WNsDgBVof@earth.li>

On Wed, Sep 24, 2025 at 09:47:59AM +0100, Jonathan McDowell wrote:
> On Mon, Sep 22, 2025 at 07:43:15PM +0300, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > In earlier bug fix, an extra parameter was by mistake to the function.
> > 
> > Fixes: 27184f8905ba ("tpm: Opt-in in disable PCR integrity protection")
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > ---
> > drivers/char/tpm/tpm2-cmd.c      |  2 +-
> > drivers/char/tpm/tpm2-sessions.c |  5 ++---
> > include/linux/tpm.h              | 25 +------------------------
> > 3 files changed, 4 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index 7d77f6fbc152..61a4daaef292 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -191,7 +191,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> > 		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
> > 	} else {
> > 		tpm_buf_append_handle(chip, &buf, pcr_idx);
> > -		tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
> > +		tpm_buf_append_auth(chip, &buf, NULL, 0);
> > 	}
> > 
> > 	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
> > diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> > index 6d03c224e6b2..13f019d1312a 100644
> > --- a/drivers/char/tpm/tpm2-sessions.c
> > +++ b/drivers/char/tpm/tpm2-sessions.c
> > @@ -266,7 +266,7 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
> > EXPORT_SYMBOL_GPL(tpm_buf_append_name);
> > 
> > void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
> > -			 u8 attributes, u8 *passphrase, int passphrase_len)
> > +			 u8 *passphrase, int passphrase_len)
> > {
> > 	/* offset tells us where the sessions area begins */
> > 	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
> > @@ -327,8 +327,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
> > #endif
> > 
> > 	if (!tpm2_chip_auth(chip)) {
> > -		tpm_buf_append_auth(chip, buf, attributes, passphrase,
> > -				    passphrase_len);
> > +		tpm_buf_append_auth(chip, buf, passphrase, passphrase_len);
> > 		return;
> > 	}
> 
> This chunk below should be in patch 3/4 where you open code
> tpm_buf_append_hmac_session_opt, rather than here:

True, thanks for catching this.

> 
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index 667d290789ca..a8984d273c28 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -533,30 +533,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
> > 				 u8 attributes, u8 *passphrase,
> > 				 int passphraselen);
> > void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
> > -			 u8 attributes, u8 *passphrase, int passphraselen);
> > -static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
> > -						   struct tpm_buf *buf,
> > -						   u8 attributes,
> > -						   u8 *passphrase,
> > -						   int passphraselen)
> > -{
> > -	struct tpm_header *head;
> > -	int offset;
> > -
> > -	if (tpm2_chip_auth(chip)) {
> > -		tpm_buf_append_hmac_session(chip, buf, attributes, passphrase, passphraselen);
> > -	} else  {
> > -		offset = buf->handles * 4 + TPM_HEADER_SIZE;
> > -		head = (struct tpm_header *)buf->data;
> > -
> > -		/*
> > -		 * If the only sessions are optional, the command tag must change to
> > -		 * TPM2_ST_NO_SESSIONS.
> > -		 */
> > -		if (tpm_buf_length(buf) == offset)
> > -			head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
> > -	}
> > -}
> > +			 u8 *passphrase, int passphraselen);
> > 
> > #ifdef CONFIG_TCG_TPM2_HMAC
> > 
> > -- 
> > 2.39.5
> > 
> > 
> 
> J.
> 
> -- 
> 101 things you can't have too much of : 19 - A Good Thing.
> This .sig brought to you by the letter V and the number 13
> Product of the Republic of HuggieTag

BR, Jarkko

