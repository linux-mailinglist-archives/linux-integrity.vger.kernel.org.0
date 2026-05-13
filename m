Return-Path: <linux-integrity+bounces-9528-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAdhIdxbBGqiHQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9528-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 13 May 2026 13:09:16 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 227BA531E74
	for <lists+linux-integrity@lfdr.de>; Wed, 13 May 2026 13:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8371430154A2
	for <lists+linux-integrity@lfdr.de>; Wed, 13 May 2026 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520E23FBEA5;
	Wed, 13 May 2026 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9gCPEGZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zr8hbpyh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A5E3806A7
	for <linux-integrity@vger.kernel.org>; Wed, 13 May 2026 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670534; cv=none; b=Id6cI3jxOzVTrzaeOZqp2HGhmvgho205H4PX3ayZEucqaTFF+lTBNJRxl3vlzFugSkPRNQSTjmcDei97YlDpKUbCoMaRemIouL6l0e7XPJjECEoTIbsGRyySFSlpdKKLp8IaHrlGfJn9bB0RV2Gt3yGkaZJDkdSRrz6PLz6tjqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670534; c=relaxed/simple;
	bh=maqtlKnUOZGrFSRyjOaYy2eO27H61t61DIbhg7jOchQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dq3SutyB72pR4Hi0tm02/xGi+IpPHzxGTraiRNurVJS9nZpT/dWMzAQaBm0FbGfzBp86QW1IJRAC8SAti2+uufNuq8SDMnlUgaAe3X/t/2vkE7DdUa2uZ+AXhA16+MqYt/MdpPcOfIxi7BVC1AsLiwTJWaJijmjbytdMo6sV5j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d9gCPEGZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zr8hbpyh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778670531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WCdmdOmMZW9gHjE/20zHllRfTLpIviKY45IRyXg7XHs=;
	b=d9gCPEGZ3sCrM0luZB91U81KTgu+a8Q3pN55nVdVQ3YvmfQFIWIQQIPGzU9PQOTptMERAB
	oywSr3PWxfT4j7s7VbX+Xpl3NuyWnZFUBv08PAe3A6exzzyGHoXYLtTU1PhyurI3cvJ/fq
	pvG7AX2/vNY2jH7qFEkKJG43hAUSaMQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-QpbcsMkYPjy27gGxhFfykw-1; Wed, 13 May 2026 07:08:50 -0400
X-MC-Unique: QpbcsMkYPjy27gGxhFfykw-1
X-Mimecast-MFC-AGG-ID: QpbcsMkYPjy27gGxhFfykw_1778670529
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bc6899bfb1so52519015ad.2
        for <linux-integrity@vger.kernel.org>; Wed, 13 May 2026 04:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778670529; x=1779275329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WCdmdOmMZW9gHjE/20zHllRfTLpIviKY45IRyXg7XHs=;
        b=Zr8hbpyhLxI8DwFa81qoJB1yzTyQ7OQqRkdmjmAA08sKDDMOwuORYy5S99HdmXiUuZ
         5K7wvj+hpd21XJzKC3ZNSFD8LRou8H05t4J1ndJPRd1qn1ULpbsooCbhN8K1UA/swU/k
         d06v+M6NfEYlMNMMIBq9LEw+kk5aMSvL3/XBSz0Vcq9xvfafhrqCNb0PD38eCBz++G9M
         Bqk81wYHmCcYyt1NzR8gTp3pyp0skSir3GImhr0xHiToBgpnaeZd9RBjRUHUvGVQqn1M
         UYzShOWH5ift20NRkqsuwfhksouFT61D5T6p1vhp5DFqG9A1gLdlaw2+n0g5TWeq09S/
         0WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778670529; x=1779275329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCdmdOmMZW9gHjE/20zHllRfTLpIviKY45IRyXg7XHs=;
        b=UK6XHMLD0c8QCiw6T5gJrYFaIjQ6VYYKnMKftfdlXvIhn4DdNurMbrhCkwkOsNh3aR
         lM8XxkSqnEEjs//X+IeMeRxSJfqIddMszj0+9Mp1z1zmU2sgQ6P1+5/B1LbCy7GWRogc
         k6mTVIf3AN7361D8fGTSvPi0ufpJTYWCpD5jzzSl9ptnMSPYHdFkxwqh8BJUfA15xEcT
         yxt6TjH5pDYIIkVrnlRXGAB370ZeblAV4mmApDVdgaXmrrrC6qyaxOiJf3TpEMy6he+j
         ItRTMjd7TLg5BtrzlH4NvUoBFDxJCMsTjydJM2JGw4xvnKb8QJVK5a17CS0P0FsTvRbE
         M6Mg==
X-Forwarded-Encrypted: i=1; AFNElJ9Gtaz5bPeSt5m4EPnceIELVgs/Nq9X10KumDK5ujd5b5siZ8OUVgbtj0aEYPRYd9ss0OU/GiHPpeK4KSLAEZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgznYCZr2OpRTV/tKhWmPHfgfQecwyOxEIKN9D/8acfO2Dw3o9
	+OmY+5HNKZSz4GvVAc/B5N5GgbhnYYuqvglZjyKolQIXowNH7oaDd/7DEPYe8g2g9bbO99uWqFO
	z2spjbvenUZjZHLl5PmjL8Unt2YLk1EbOxCKqOwhRrT85Y0uLq22b+xnlX3bB+YP8YoKf0lgpEh
	q0ig==
X-Gm-Gg: Acq92OGxpetvknQaWXRPn2ynA0drZtSUomcpThB8oTcYoO7S/Hav6OhJFF0d0es7sJU
	/bL1MqyuNQtLlh04v6hGa83Z6Xfezd8x/k4zuuHSsvCUQgnJiXThJnrefLyJgvms/wewnv/BRdd
	HKE1m1mu0g7KGDt2iF5bE9gZrK00tepIANaCsMD4SX+SwJXqxtTtE+h6+bF3syU0PHyS3mCw1cp
	c5TfC1ADhXbaE5qmupU8pCA0ABRYobpwYf7dnbL/N+6DVgiU9eOGijmyOlQ/xwZW7duDy2Iz4gB
	xr1D+7PjQawrO3BmUSURfBBwzCBg7vk7Uh+yspf1zrBZcMZD/NWs8ZxrSsakehka0ISTs6nARI/
	CX1if5K+h7LEd
X-Received: by 2002:a17:902:ceca:b0:2bd:2de3:5181 with SMTP id d9443c01a7336-2bd2de353e8mr26474645ad.9.1778670528948;
        Wed, 13 May 2026 04:08:48 -0700 (PDT)
X-Received: by 2002:a17:902:ceca:b0:2bd:2de3:5181 with SMTP id d9443c01a7336-2bd2de353e8mr26474345ad.9.1778670528460;
        Wed, 13 May 2026 04:08:48 -0700 (PDT)
Received: from fedora ([49.36.106.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d40677sm165126325ad.33.2026.05.13.04.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:08:47 -0700 (PDT)
Date: Wed, 13 May 2026 16:38:42 +0530
From: Arun Menon <armenon@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC v2 2/5] tpm_crb: Add new wrapper function to invoke start
 method
Message-ID: <agRbuhM05I7bZxN8@fedora>
References: <20260324181244.17741-1-armenon@redhat.com>
 <20260324181244.17741-3-armenon@redhat.com>
 <af9H_rFY5-lGEr2g@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af9H_rFY5-lGEr2g@kernel.org>
X-Rspamd-Queue-Id: 227BA531E74
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9528-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,ziepe.ca];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armenon@redhat.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 05:43:10PM +0300, Jarkko Sakkinen wrote:
> On Tue, Mar 24, 2026 at 11:42:41PM +0530, Arun Menon wrote:
> > The current implementation handles different platform start methods
> > (ACPI, ARM SMC, and ARM FFA) directly within crb_send(), but it is
> > limited to triggering the CRB_START_INVOKE bit.
> > 
> > To support cmd/rsp chunking, the driver must be able to send other
> > control bits, like CRB_START_NEXT_CHUNK, using these same
> > platform-specific paths.
> > 
> > By moving this logic into a new helper function, crb_trigger_tpm(),
> > the driver can now send any required control bit across all supported
> > platforms. This prepares the driver for the upcoming chunking support.
> > 
> > No functional change is intended.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  drivers/char/tpm/tpm_crb.c | 50 ++++++++++++++++++++------------------
> >  1 file changed, 27 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> > index 67c0061d4cab7..922bcf7a69ad5 100644
> > --- a/drivers/char/tpm/tpm_crb.c
> > +++ b/drivers/char/tpm/tpm_crb.c
> > @@ -445,6 +445,32 @@ static int tpm_crb_smc_start(struct device *dev, unsigned long func_id)
> >  }
> >  #endif
> >  
> > +static int crb_trigger_tpm(struct tpm_chip *chip, u32 start_cmd)
> 
> tpm_crb_start?

Yes, it can be renamed. On the qemu side also, its renamed and made
consistent with the spec.

> 
> I'd also split this into two commits:
> 
> 1. One that splits the helper.
> 2. Second that adds the new stuff.

Yes. Will do. Thank you.

> 
> > +{
> > +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> > +	int rc = 0;
> > +	/* The reason for the extra quirk is that the PTT in 4th Gen Core CPUs
> > +	 * report only ACPI start but in practice seems to require both
> > +	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
> > +	 */
> > +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
> > +	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
> > +	    !strcmp(priv->hid, "MSFT0101"))
> > +		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
> > +	if (priv->sm == ACPI_TPM2_START_METHOD ||
> > +	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
> > +		rc = crb_do_acpi_start(chip);
> > +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
> > +		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
> > +		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
> > +	}
> > +	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
> > +		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
> > +		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
> > +	}
> > +	return rc;
> > +}
> > +
> >  static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
> >  {
> >  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> > @@ -470,29 +496,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
> >  	/* Make sure that cmd is populated before issuing start. */
> >  	wmb();
> >  
> > -	/* The reason for the extra quirk is that the PTT in 4th Gen Core CPUs
> > -	 * report only ACPI start but in practice seems to require both
> > -	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
> > -	 */
> > -	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
> > -	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
> > -	    !strcmp(priv->hid, "MSFT0101"))
> > -		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> > -
> > -	if (priv->sm == ACPI_TPM2_START_METHOD ||
> > -	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
> > -		rc = crb_do_acpi_start(chip);
> > -
> > -	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
> > -		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> > -		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
> > -	}
> > -
> > -	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
> > -		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> > -		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
> > -	}
> > -
> > +	rc = crb_trigger_tpm(chip, CRB_START_INVOKE);
> >  	if (rc)
> >  		return rc;
> >  
> > -- 
> > 2.53.0
> > 
> 
> BR, Jarkko
> 

Regards,
Arun Menon


