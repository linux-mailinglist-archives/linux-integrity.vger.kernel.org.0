Return-Path: <linux-integrity+bounces-6613-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30723AF85C7
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 04:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFDA54739A
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 02:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6B9158520;
	Fri,  4 Jul 2025 02:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgzeqJSM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277E51FC3;
	Fri,  4 Jul 2025 02:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751597608; cv=none; b=VC1iyqD/g1oFx8ToNIkKe+S8bsD3j6333MugByAhmy5+RBz6JOGMVOeklzNJNvzndIdp/V8GfoJbkqFWUg3HzuG+yQuX3sP27KNgljXJ2yM5LxIUIwQ/5o8pQGV8X4OLXj7iHna3g9uShV5FG+BvYyOyFqwOrqoDdA/MERiitQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751597608; c=relaxed/simple;
	bh=9UOWMeZLVtkwSXIS3fo46rKrNh0I1J1skAXKQCS7QZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGi6btcK00b1r78HrukV3oEM3stlwbNZafeaHcvyXKM26AoDfpQ6FtovrHp5ncmvwDXlMEkgSStBR9OqR5eyvBtzYfZQxf7RSfRyfsHqcUIcFhDoDAauaCisz414CRfqTP4fBQu61o4j8S7JIH50fg1HFJr45d0S68a2VtG3GJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgzeqJSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B912C4CEE3;
	Fri,  4 Jul 2025 02:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751597607;
	bh=9UOWMeZLVtkwSXIS3fo46rKrNh0I1J1skAXKQCS7QZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IgzeqJSMKseKK7omQDZzCBBv4DBbLPEh9U0RIFksF3m2S4jguzBc5zNf1Di2F2Ar1
	 FWgHdlp6V1NZ1mSDzod7Qn77tSMPXrdIUAV+zraDYFFJ8tAjd+UE0vNuOWOl1NkQGI
	 Oz0cYcSVQO5w1YVCNL8UEROl7yHcXs+jHZgeSWS4C3mhz3v/fLSbSgpsuWPeL3BD4p
	 5Si7qyVAxfWZuKLoFdoazIIjMxpxHjGg7ydu/iIKUlH9ciLlYZKpwEK27mz3U6nhh+
	 U7GnwOuDMQam/auYi2FcvVUEj5qJg7eekf/BYUbhl8JaQv5d/Y8ns+Dkk+ssw1+TLd
	 zlsy6L+HvChnQ==
Date: Fri, 4 Jul 2025 05:53:23 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v5] tpm: Managed allocations for tpm_buf instances
Message-ID: <aGdCI7aD05aIqS6s@kernel.org>
References: <20250703181712.923302-1-jarkko@kernel.org>
 <be1c5bef-7c97-4173-b417-986dc90d779c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be1c5bef-7c97-4173-b417-986dc90d779c@linux.ibm.com>

On Thu, Jul 03, 2025 at 04:21:05PM -0400, Stefan Berger wrote:
> 
> 
> On 7/3/25 2:17 PM, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > Repeal and replace tpm_buf_init() and tpm_buf_init_sized() with
> > tpm_buf_alloc(), which returns a buffer of  memory with the struct tpm_buf
> > header at the beginning of the returned buffer. This leaves 4092 bytes of
> > free space for the payload.
> > 
> > Given that kfree() becomes the destructor for struct tpm_buf instances,
> > tpm_buf_destroy() is now obsolete, and can be removed.
> > 
> > The actual gist is that a struct tpm_buf instance can be declared using
> > __free(kfree) from linux/slab.h:
> > 
> > 	struct tpm_buf *buf __free(kfree) buf = tpm_buf_alloc();
> > 
> > Doing this has two-folded benefits associated with struct tpm_buf:
> > 
> > 1. New features will not introduce memory leaks.
> > 2. It addresses undiscovered memory leaks.
> > 
> > In addition, the barrier to contribute is lowered given that managing
> > memory is a factor easier.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > ---
> 
> > @@ -374,20 +362,18 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
> >    */
> >   void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
> >   {
> > -	struct tpm_buf buf;
> > -	int rc;
> > +	struct tpm_buf *buf __free(kfree) = tpm_buf_alloc();
> >
> 
> Remove empty line?

I recalled from the past that checkpatch.pl would complain if there was
no empty line after the declarations.

Now that I tested removing that line, it did not so I guess I can remove
that empty line. The presumed checkpatch error was the only reason for
having it.
> 
> > -	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_FLUSH_CONTEXT);
> > -	if (rc) {
> > +	if (!buf) {
> >   		dev_warn(&chip->dev, "0x%08x was not flushed, out of memory\n",
> >   			 handle);
> >   		return;
> >   	}
> > -	tpm_buf_append_u32(&buf, handle);
> > +	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_FLUSH_CONTEXT);
> > +	tpm_buf_append_u32(buf, handle);
> > -	tpm_transmit_cmd(chip, &buf, 0, "flushing context");
> > -	tpm_buf_destroy(&buf);
> > +	tpm_transmit_cmd(chip, buf, 0, "flushing context");
> >   }
> >   EXPORT_SYMBOL_GPL(tpm2_flush_context);
> > @@ -414,19 +400,20 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
> >   			const char *desc)
> >   {
> >   	struct tpm2_get_cap_out *out;
> > -	struct tpm_buf buf;
> >   	int rc;
> > -	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
> > -	if (rc)
> > -		return rc;
> > -	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
> > -	tpm_buf_append_u32(&buf, property_id);
> > -	tpm_buf_append_u32(&buf, 1);
> > -	rc = tpm_transmit_cmd(chip, &buf, 0, NULL);
> > +	struct tpm_buf *buf __free(kfree) = tpm_buf_alloc();
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
> > +	tpm_buf_append_u32(buf, TPM2_CAP_TPM_PROPERTIES);
> > +	tpm_buf_append_u32(buf, property_id);
> > +	tpm_buf_append_u32(buf, 1);
> > +	rc = tpm_transmit_cmd(chip, buf, 0, NULL);
> >   	if (!rc) {
> >   		out = (struct tpm2_get_cap_out *)
> > -			&buf.data[TPM_HEADER_SIZE];
> > +			&buf->data[TPM_HEADER_SIZE];
> >   		/*
> >   		 * To prevent failing boot up of some systems, Infineon TPM2.0
> >   		 * returns SUCCESS on TPM2_Startup in field upgrade mode. Also
> > @@ -438,7 +425,6 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
> >   		else
> >   			rc = -ENODATA;
> >   	}
> > -	tpm_buf_destroy(&buf);
> >   	return rc;
> >   }
> >   EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
> > @@ -455,15 +441,14 @@ EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
> >    */
> >   void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
> >   {
> > -	struct tpm_buf buf;
> > -	int rc;
> > +	struct tpm_buf *buf __free(kfree) = tpm_buf_alloc();
> 
> Remove empty line here.
> 
> With this nit fixed:
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> 

Thanks and I'm happy to fixup those. They did look also silly to me :-)

BR, Jarkko

