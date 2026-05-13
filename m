Return-Path: <linux-integrity+bounces-9527-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI0bC3pbBGqiHQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9527-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 13 May 2026 13:07:38 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC6E531E30
	for <lists+linux-integrity@lfdr.de>; Wed, 13 May 2026 13:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BFA7300F291
	for <lists+linux-integrity@lfdr.de>; Wed, 13 May 2026 11:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754023FB7EB;
	Wed, 13 May 2026 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOULYzhr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMOMl+2k"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1B43A0EB1
	for <linux-integrity@vger.kernel.org>; Wed, 13 May 2026 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670443; cv=none; b=KlDrsv44HuyTpy9rLc2yWGTHsRDCC+e/CkbQ9P9us73G43LqDAyQyssw5o+eCKPQo54+D89ASMCPBBiqRN9RmUY1IwRcfApyWXkT54oS8uL25t4J8rVIs4242PXY1Q+3jIzz52ovYYKQjFNeBgJmqueBEl9UFTzveBBTpA9P/Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670443; c=relaxed/simple;
	bh=SNX3X/rwlNgPtnbXUFS9NS0V8ZMTahBJBMBxp+TbMVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNWqrUe/fPbTew1tFlzI8/aehLYR0BkbtoCBLpp8ev4XhaNwBmSf0OyOr6urAQANIZFjbsMyTY+3c4aAJTRDKpNd46bGm8HcPiFGRyqcLefV6eppFip9gOaITFEMkcIXsxN0V6tIkX6GWDwa8q0s5p9jAdMrMf7P8uG0VsBgLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOULYzhr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OMOMl+2k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778670439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPx3RKj7QwNBIRIqjPw+ZA1MUziPVJfLloPYGyVdYA4=;
	b=gOULYzhrT0+9sV3XCiJWkwcvDsZ8nVHxJRqXfpA0nIavUQyEDTj+qkpZ4Ki0+MdvQiMabc
	P258T4Q0UcaSFFvDMk3z8V3lqQT13soicU+U3DCH1wfwz0bBQu7Xqs4/4RosRnujGomthA
	DqA7uk9+r+ke3Kufu6cOboiWffVgehU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-_WBlJljuO567wpHvZSJifg-1; Wed, 13 May 2026 07:07:17 -0400
X-MC-Unique: _WBlJljuO567wpHvZSJifg-1
X-Mimecast-MFC-AGG-ID: _WBlJljuO567wpHvZSJifg_1778670437
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36641fe4aedso10284502a91.1
        for <linux-integrity@vger.kernel.org>; Wed, 13 May 2026 04:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778670437; x=1779275237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QPx3RKj7QwNBIRIqjPw+ZA1MUziPVJfLloPYGyVdYA4=;
        b=OMOMl+2kQNgzNEiR84cFHq1Ah56pn0rtreTT46e724r0QmM77ta2qt/YaTqOB3/2LI
         lcH7mRzmCC+VtboaUtOft/pTB/tNw+JiMf1WeSDFWmOG3FqpPI28+1VZFk2/68MDLMzX
         1kFouQGmxP+iOl8NyTGdHuGdYaHgJuQA5plFKicejLqQq4FmDjftNLJMCE4rmycYFP6N
         YoK/Lt7Iju5uOqnbM9DD2qZVriootgl/RIY8PvbYXhPUG2sXym607wC1cv0FyNTqPFGg
         C6e3ZkC/Nda1xgVVetmtwbVI+ykdiiRosIoUqYld0DkZPuiLkT5sSVNtnim7/YBeVVBF
         iA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778670437; x=1779275237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPx3RKj7QwNBIRIqjPw+ZA1MUziPVJfLloPYGyVdYA4=;
        b=L4f/NCgKrboL/5PIQnATnZ8PL1b9GtSNEEQ934rsssM7ZHmZrc4d9bzdz2yAY8jrdO
         NPWYXwjHcx9gRClLKJXWmAfZueZ3cNycMlmPKJw15lqCHNQBop3FSfc9z5V71LZBMjWg
         08l9megjG3/uxKU0wjg2m5CGvZgdADKx/iZ+QtJVVZPW1SV4JCFnQYx00yjGjuZpNGK9
         p6oHYxmOGuVGKj3pFhwU86+6cGd4Ac1mxN+QavL1jFzLRWemEeJJTh/94HAraTWKAeCk
         qyjdEG5otKddJt3l4bq8/WgK1AuKVTXBVn2INCzHQPD71u90fQOyiKzM9lujm+XPj4ZO
         YrAg==
X-Forwarded-Encrypted: i=1; AFNElJ/Ozq28TbyGLWvg16kmkJVPGDgFXg6sSTqhTMCajkh1PesXcePoHM/fLVvzKrajvvyMW8StzKxaLugJx3Is/UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznGl6biBVirU5RRgYY4s702bULppXgQNkfZTjI7jZEv+hIx+yp
	deupGzQ+pxkfAF869jvYiH+96X7npGBpEb1mfFJhDAYEpOdnzkQ3njkLOLyJSyAyWwbvmkK9Em6
	O1X0zkwpxlqjSro5RxbbkTqvX6wnc4BWYsHMf980ZYyLHALHSsC2s+/TrMQlKOVmcGDw0wQ==
X-Gm-Gg: Acq92OGVfAxCEvR+dBPqJmeNjg6znJZkmQ4/uirhaoxyLbg4jbnG5fjASR7cLqsXu2T
	DVjMqOoiMUGkCRy7FVwzsY5UMqCbTp2tdGvzW2BZG3s/HzuneRGVBQpPxxyO6dFjmTiOFqukvqb
	lqeJwCJaDQ9Lg1vnZldqI6r9vVuUWajjoJZmlgZijzPGgcfcO5lzCQTCfkOvYIDekHqidl2wnF3
	Wkmo7Boo+/Au3cPRWFZ/BhOr2jW8DiQPziXsp2DE+Xv+MQe83rf/0ZV93pIdn/4EpD3MzjWB7mQ
	YyRIE5/guOLTCm1cOlc6Mj0IKIpn2NepgGcKinmyoH4SX34dPrrJzFpyOOGlzGjrCsp0u6rj46g
	71cwW6UYjdpvd
X-Received: by 2002:a17:90b:3c8f:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-368f2dcf4d8mr3093751a91.0.1778670436682;
        Wed, 13 May 2026 04:07:16 -0700 (PDT)
X-Received: by 2002:a17:90b:3c8f:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-368f2dcf4d8mr3093717a91.0.1778670436096;
        Wed, 13 May 2026 04:07:16 -0700 (PDT)
Received: from fedora ([49.36.106.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368b016554csm2775258a91.3.2026.05.13.04.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:07:15 -0700 (PDT)
Date: Wed, 13 May 2026 16:37:09 +0530
From: Arun Menon <armenon@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC v2 3/5] tpm_crb: Implement command and response chunking
 logic
Message-ID: <agRbXSvz5YyyCX_o@fedora>
References: <20260324181244.17741-1-armenon@redhat.com>
 <20260324181244.17741-4-armenon@redhat.com>
 <af9Kf671p1ocUwYY@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af9Kf671p1ocUwYY@kernel.org>
X-Rspamd-Queue-Id: 6BC6E531E30
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9527-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armenon@redhat.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 05:53:51PM +0300, Jarkko Sakkinen wrote:
> On Tue, Mar 24, 2026 at 11:42:42PM +0530, Arun Menon wrote:
> > With the introduction of support for Post Quantum Cryptography
> > algorithms in TPM, the commands and responses will grow in size.
> > Some TPMs have a physical hardware memory window (MMIO) that is
> > smaller than the commands we need to send. Therefore this commit
> > implements the core logic of sending/receiving data in chunks.
> > 
> > Instead of sending the whole command at once, the driver now sends it in
> > small chunks. After each chunk, it signals the TPM using a nextChunk
> > signal, and waits for the TPM to consume the data. Once the final piece
> > is delivered, the driver signals the TPM to begin execution by toggling
> > the start invoke bit. We use the same logic in reverse to read large
> > responses from the TPM.
> > 
> > This allows the driver to handle large payloads even when the hardware
> > interface has limited memory. This kernel-side support corresponds to
> > the backend implementation in QEMU [1]. QEMU reassembles the chunks
> > before passing them to the TPM emulator.
> > 
> > [1] https://lore.kernel.org/qemu-devel/20260319135316.37412-1-armenon@redhat.com/
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> 
> This is really bad at rationalizing the code change, which are heavy.
> 
> Couldn't you instead:
> 
> 1. Rename crb_recv as tpm_crb_recv_no_chunks().
> 2. Add tpm_crb_recv_chunks().
> 3. Add new tpm_crb_recv(), which delegates either.
> 
> I would not mind too much if they have some duplicate logic. It's less
> of a harm than convolution caused by interleaving.

Sure. I will amend this in v3.
Thank you.

> 
> >  drivers/char/tpm/tpm_crb.c | 155 +++++++++++++++++++++++++++----------
> >  1 file changed, 114 insertions(+), 41 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> > index 922bcf7a69ad5..a97fc5e9927e3 100644
> > --- a/drivers/char/tpm/tpm_crb.c
> > +++ b/drivers/char/tpm/tpm_crb.c
> > @@ -104,11 +104,13 @@ struct crb_priv {
> >  	u8 __iomem *cmd;
> >  	u8 __iomem *rsp;
> >  	u32 cmd_size;
> > +	u32 rsp_size;
> >  	u32 smc_func_id;
> >  	u32 __iomem *pluton_start_addr;
> >  	u32 __iomem *pluton_reply_addr;
> >  	u8 ffa_flags;
> >  	u8 ffa_attributes;
> > +	bool chunking_supported;
> 
> Why not "u32 intf_id" i.e. cache the value of the register?
> 
> >  };
> >  
> >  struct tpm2_crb_smc {
> > @@ -368,38 +370,6 @@ static u8 crb_status(struct tpm_chip *chip)
> >  	return sts;
> >  }
> >  
> > -static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> > -{
> > -	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> > -	unsigned int expected;
> > -
> > -	/* A sanity check that the upper layer wants to get at least the header
> > -	 * as that is the minimum size for any TPM response.
> > -	 */
> > -	if (count < TPM_HEADER_SIZE)
> > -		return -EIO;
> > -
> > -	/* If this bit is set, according to the spec, the TPM is in
> > -	 * unrecoverable condition.
> > -	 */
> > -	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
> > -		return -EIO;
> > -
> > -	/* Read the first 8 bytes in order to get the length of the response.
> > -	 * We read exactly a quad word in order to make sure that the remaining
> > -	 * reads will be aligned.
> > -	 */
> > -	memcpy_fromio(buf, priv->rsp, 8);
> > -
> > -	expected = be32_to_cpup((__be32 *)&buf[2]);
> > -	if (expected > count || expected < TPM_HEADER_SIZE)
> > -		return -EIO;
> > -
> > -	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
> > -
> > -	return expected;
> > -}
> > -
> >  static int crb_do_acpi_start(struct tpm_chip *chip)
> >  {
> >  	union acpi_object *obj;
> > @@ -474,6 +444,8 @@ static int crb_trigger_tpm(struct tpm_chip *chip, u32 start_cmd)
> >  static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
> >  {
> >  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> > +	size_t offset = 0;
> > +	size_t chunk_size;
> >  	int rc = 0;
> >  
> >  	/* Zero the cancel register so that the next command will not get
> > @@ -481,7 +453,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
> >  	 */
> >  	iowrite32(0, &priv->regs_t->ctrl_cancel);
> >  
> > -	if (len > priv->cmd_size) {
> > +	if (len > priv->cmd_size && !priv->chunking_supported) {
> >  		dev_err(&chip->dev, "invalid command count value %zd %d\n",
> >  			len, priv->cmd_size);
> >  		return -E2BIG;
> > @@ -491,18 +463,108 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
> >  	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
> >  		__crb_cmd_ready(&chip->dev, priv, chip->locality);
> >  
> > -	memcpy_toio(priv->cmd, buf, len);
> > +	while (offset < len) {
> > +		chunk_size = min_t(size_t, len - offset, priv->cmd_size);
> >  
> > -	/* Make sure that cmd is populated before issuing start. */
> > -	wmb();
> > -
> > -	rc = crb_trigger_tpm(chip, CRB_START_INVOKE);
> > -	if (rc)
> > -		return rc;
> > +		if (chunk_size == 0)
> > +			break;
> >  
> > +		memcpy_toio(priv->cmd, buf + offset, chunk_size);
> > +		offset += chunk_size;
> > +
> > +		/* Make sure that cmd is populated before issuing start. */
> > +		wmb();
> > +		if (offset < len) {
> > +			rc = crb_trigger_tpm(chip, CRB_START_NEXT_CHUNK);
> > +			if (rc)
> > +				return rc;
> > +			if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
> > +			    CRB_START_NEXT_CHUNK, 0, TPM2_TIMEOUT_C)) {
> > +				dev_err(&chip->dev,
> > +					"Timeout waiting for backend to consume chunk\n");
> > +				return -ETIME;
> > +			}
> > +		} else {
> > +			rc = crb_trigger_tpm(chip, CRB_START_INVOKE);
> > +			if (rc)
> > +				return rc;
> > +		}
> > +	}
> >  	return crb_try_pluton_doorbell(priv, false);
> >  }
> >  
> > +static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> > +{
> > +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> > +	unsigned int expected;
> > +	size_t offset = 0;
> > +	size_t chunk_size;
> > +	size_t first_read;
> > +	int rc;
> > +
> > +	/* A sanity check that the upper layer wants to get at least the header
> > +	 * as that is the minimum size for any TPM response.
> > +	 */
> > +	if (count < TPM_HEADER_SIZE)
> > +		return -EIO;
> > +
> > +	/* If this bit is set, according to the spec, the TPM is in
> > +	 * unrecoverable condition.
> > +	 */
> > +	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
> > +		return -EIO;
> > +
> > +	/* Read the first 8 bytes in order to get the length of the response.
> > +	 * We read exactly a quad word in order to make sure that the remaining
> > +	 * reads will be aligned.
> > +	 */
> > +	memcpy_fromio(buf, priv->rsp, 8);
> > +
> > +	expected = be32_to_cpup((__be32 *)&buf[2]);
> > +	if (expected > count || expected < TPM_HEADER_SIZE)
> > +		return -EIO;
> > +
> > +	/*
> > +	 * Set chunk_size by comparing the size of the buffer that the upper layer has
> > +	 * allocated (count) to the hardware tpm limit (priv->rsp_size).
> > +	 * This is to prevent buffer overflow while writing to buf.
> > +	 */
> > +	chunk_size = min_t(size_t, count, priv->rsp_size);
> > +	if (chunk_size < 8)
> > +		return -EIO;
> > +
> > +	/*
> > +	 * Compare the actual size of the response we found in the header to the chunk_size.
> > +	 */
> > +	first_read = min_t(size_t, expected, chunk_size);
> > +
> > +	memcpy_fromio(&buf[8], &priv->rsp[8], first_read - 8);
> > +	offset = first_read;
> > +
> > +	while (offset < expected) {
> > +		if (!priv->chunking_supported) {
> > +			dev_err(&chip->dev, "Response larger than MMIO and chunking not supported\n");
> > +			return -EIO;
> > +		}
> > +
> > +		rc = crb_trigger_tpm(chip, CRB_START_NEXT_CHUNK);
> > +		if (rc)
> > +			return rc;
> > +
> > +		if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
> > +					 CRB_START_NEXT_CHUNK, 0, TPM2_TIMEOUT_C)) {
> > +			dev_err(&chip->dev, "Timeout waiting for backend response\n");
> > +			return -ETIME;
> > +		}
> > +
> > +		chunk_size = min_t(size_t, expected - offset, priv->rsp_size);
> > +		memcpy_fromio(buf + offset, priv->rsp, chunk_size);
> > +		offset += chunk_size;
> > +	}
> > +
> > +	return expected;
> > +}
> > +
> >  static void crb_cancel(struct tpm_chip *chip)
> >  {
> >  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> > @@ -727,6 +789,15 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
> >  		goto out;
> >  	}
> >  
> > +	if (priv->regs_h) {
> > +		u32 intf_id = ioread32((u32 __iomem *)&priv->regs_h->intf_id);
> > +
> > +		if (intf_id & CRB_INTF_CAP_CRB_CHUNK) {
> > +			priv->chunking_supported = true;
> > +			dev_info(dev, "CRB Chunking is supported by backend\n");
> > +		}
> > +	}
> > +
> >  	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
> >  	rsp_pa = le64_to_cpu(__rsp_pa);
> >  	rsp_size = ioread32(&priv->regs_t->ctrl_rsp_size);
> > @@ -764,8 +835,10 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
> >  	priv->rsp = priv->cmd;
> >  
> >  out:
> > -	if (!ret)
> > +	if (!ret) {
> >  		priv->cmd_size = cmd_size;
> > +		priv->rsp_size = rsp_size;
> > +	}
> >  
> >  	__crb_go_idle(dev, priv, 0);
> >  
> > -- 
> > 2.53.0
> > 
> 
> BR, Jarkko
> 

Regards,
Arun Menon


