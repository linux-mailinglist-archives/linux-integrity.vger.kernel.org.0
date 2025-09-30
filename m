Return-Path: <linux-integrity+bounces-7321-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEDDBACE5F
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 14:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048401926105
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 12:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F692FC00C;
	Tue, 30 Sep 2025 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8rlVDg4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205CA2571DD;
	Tue, 30 Sep 2025 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236220; cv=none; b=mS5R16k5lf7Tt5udLs3rRHIVH6FqJxnxKbWLOObtjSbNTQlb9zOSpD1auXNtNAHfPuHOaGD03G/X7lOL6WN1e3HevZndBU+dFd/uv4XLci1YTGEEAErnWiJkN1PmFJfaoeedC/nh4d1A1fUkEg+8WxRTZXyGkFL40VhRtyYGHKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236220; c=relaxed/simple;
	bh=zvA09JRHRoS4Irppg02GUnqfKuR65JfJN0o6RT9T3Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQ1fSb3L2uDzi5R6Uyu8FuHMdUwAPWmS5HsbrAucLrvahLHRXYOPxKqpZE8D9tKP49SJ9vGRwyVvAYBYXjCTBtbMUOXE/2XqDSpyhaKFGArNxDJIW/dfou1GP1AwxgdvdbrkO6uSQiQrcM4rGwjpkhXCDnONzpJ2hndCOUsYVeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8rlVDg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959DBC4CEF0;
	Tue, 30 Sep 2025 12:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759236220;
	bh=zvA09JRHRoS4Irppg02GUnqfKuR65JfJN0o6RT9T3Zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O8rlVDg43qnBpa7ebXTZag6Q4/81uW9oquKxzE1JzXlMDITIlLq/ntCXxxwmTKK8U
	 JNmezGevD5eWFQ9yVukMPjvcufLsEgBf7YnrW8Lei7XHxegRaxhMXl6OoD7ZHSSu/v
	 x/lkAg8KRa/Jc8b5lmI+KlDQzjYBhMfvbfcaKF781Sft17zlb97keWPUqCD4SMnKsK
	 7n/doag6Wxnu+SxV6dCH+V+k/EGbdAHPr79NwPu1U6yiiPd9+UVXEfFpUYqLaj0mtI
	 zTVix4jtSTzujJcWSHjsAkwMl/0eicsivatqg6OCC8Si/rsY+TtAnif1VmAfFeFQBm
	 pCUxUaFPEongA==
Date: Tue, 30 Sep 2025 15:43:36 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org, dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 07/10] tpm-buf: check for corruption in
 tpm_buf_append_handle()
Message-ID: <aNvQeLXGb3Dhty79@kernel.org>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-8-jarkko@kernel.org>
 <aNu7R8J8h8Kmon0H@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNu7R8J8h8Kmon0H@earth.li>

On Tue, Sep 30, 2025 at 12:13:11PM +0100, Jonathan McDowell wrote:
> On Mon, Sep 29, 2025 at 10:48:29PM +0300, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > Unify TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW into TPM_BUF_INVALID
> > flag because semantically they are identical.
> > 
> > Test and set TPM_BUF_INVALID in tpm_buf_append_handle() following the
> > pattern from other functions in tpm-buf.c.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> Reviewed-by: Jonathan McDowell <noodles@meta.com>

Thanks.

> 
> > ---
> > v3:
> > - No changes.
> > v2:
> > - A new patch.
> > ---
> >  drivers/char/tpm/tpm-buf.c                | 14 ++++++++------
> >  include/linux/tpm.h                       |  8 +++-----
> >  security/keys/trusted-keys/trusted_tpm2.c |  6 +++---
> >  3 files changed, 14 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> > index dc882fc9fa9e..69ee77400539 100644
> > --- a/drivers/char/tpm/tpm-buf.c
> > +++ b/drivers/char/tpm/tpm-buf.c
> > @@ -104,13 +104,12 @@ EXPORT_SYMBOL_GPL(tpm_buf_length);
> >   */
> >  void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
> >  {
> > -	/* Return silently if overflow has already happened. */
> > -	if (buf->flags & TPM_BUF_OVERFLOW)
> > +	if (buf->flags & TPM_BUF_INVALID)
> >  		return;
> >  
> >  	if ((buf->length + new_length) > PAGE_SIZE) {
> >  		WARN(1, "tpm_buf: write overflow\n");
> > -		buf->flags |= TPM_BUF_OVERFLOW;
> > +		buf->flags |= TPM_BUF_INVALID;
> >  		return;
> >  	}
> >  
> > @@ -157,8 +156,12 @@ EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
> >   */
> >  void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle)
> >  {
> > +	if (buf->flags & TPM_BUF_INVALID)
> > +		return;
> > +
> >  	if (buf->flags & TPM_BUF_TPM2B) {
> >  		dev_err(&chip->dev, "Invalid buffer type (TPM2B)\n");
> > +		buf->flags |= TPM_BUF_INVALID;
> >  		return;
> >  	}
> >  
> > @@ -177,14 +180,13 @@ static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count, void
> >  {
> >  	off_t next_offset;
> >  
> > -	/* Return silently if overflow has already happened. */
> > -	if (buf->flags & TPM_BUF_BOUNDARY_ERROR)
> > +	if (buf->flags & TPM_BUF_INVALID)
> >  		return;
> >  
> >  	next_offset = *offset + count;
> >  	if (next_offset > buf->length) {
> >  		WARN(1, "tpm_buf: read out of boundary\n");
> > -		buf->flags |= TPM_BUF_BOUNDARY_ERROR;
> > +		buf->flags |= TPM_BUF_INVALID;
> >  		return;
> >  	}
> >  
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index e72e7657faa2..5283f32781c4 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -366,12 +366,10 @@ struct tpm_header {
> >  } __packed;
> >  
> >  enum tpm_buf_flags {
> > -	/* the capacity exceeded: */
> > -	TPM_BUF_OVERFLOW	= BIT(0),
> >  	/* TPM2B format: */
> > -	TPM_BUF_TPM2B		= BIT(1),
> > -	/* read out of boundary: */
> > -	TPM_BUF_BOUNDARY_ERROR	= BIT(2),
> > +	TPM_BUF_TPM2B		= BIT(0),
> > +	/* The buffer is in invalid and unusable state: */
> > +	TPM_BUF_INVALID		= BIT(1),
> >  };
> >  
> >  /*
> > diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> > index 8e3b283a59b2..119d5152c0db 100644
> > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > @@ -295,7 +295,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> >  	/* creation PCR */
> >  	tpm_buf_append_u32(&buf, 0);
> >  
> > -	if (buf.flags & TPM_BUF_OVERFLOW) {
> > +	if (buf.flags & TPM_BUF_INVALID) {
> >  		rc = -E2BIG;
> >  		tpm2_end_auth_session(chip);
> >  		goto out;
> > @@ -308,7 +308,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> >  		goto out;
> >  
> >  	blob_len = tpm_buf_read_u32(&buf, &offset);
> > -	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_BOUNDARY_ERROR) {
> > +	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_INVALID) {
> >  		rc = -E2BIG;
> >  		goto out;
> >  	}
> > @@ -414,7 +414,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> >  
> >  	tpm_buf_append(&buf, blob, blob_len);
> >  
> > -	if (buf.flags & TPM_BUF_OVERFLOW) {
> > +	if (buf.flags & TPM_BUF_INVALID) {
> >  		rc = -E2BIG;
> >  		tpm2_end_auth_session(chip);
> >  		goto out;
> > -- 
> > 2.39.5
> > 
> > 
> 
> J.
> 
> -- 
> Web [       Reality is for people with no grasp of fantasy.        ]
> site: https:// [                                          ]      Made by
> www.earth.li/~noodles/  [                      ]         HuggieTag 0.0.24

BR, Jarkko

