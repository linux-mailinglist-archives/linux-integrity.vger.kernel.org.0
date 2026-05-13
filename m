Return-Path: <linux-integrity+bounces-9526-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lAHEAjRbBGqiHQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9526-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 13 May 2026 13:06:28 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DCF531DE7
	for <lists+linux-integrity@lfdr.de>; Wed, 13 May 2026 13:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76FDB3002F5F
	for <lists+linux-integrity@lfdr.de>; Wed, 13 May 2026 11:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D403E5EF7;
	Wed, 13 May 2026 11:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzXzyENQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cULJYiJG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BC53FADFE
	for <linux-integrity@vger.kernel.org>; Wed, 13 May 2026 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670381; cv=none; b=GtWleFvqADbpWOU8CVqf77A+uKqTV9EdhaaaoMqf/8aE9IetZ+hhfv59u5jEuiwUt1hQJm49uLN3VUCqv9s7jGspaPlKk/WwRmtatPIVL98JgtfgLpPXxGcQ/1wiAsLHGllIlfiqVGIp+0r2IfQ8q+3XDduFdIWb2YP+yApd/KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670381; c=relaxed/simple;
	bh=oRBfEG6V06ZPBsNalKp3fPrBA64JATwU3SY33qQ8O+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3fBnuUjUhZOAPl8cow7224bn6t+zTBuQEBaM0ebhKHbaz1ibhXPW2GnNwuT5x4TlzKdRgDdLgToHjxjpWJmg95OdXAM3JR5y+y3h4GYCkvjvhB9PA0LQxXUIjfVDPIzZD3RVKtYnsMlIOVQ+7NSbVoOaH6XGWmFScYHxB1uXSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BzXzyENQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cULJYiJG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778670376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g4aX+tA7681RtoZuYuTTDvdoIPi9sMbmQGgALbo6OmY=;
	b=BzXzyENQV5r81lLN+OT9dhcCHZvgMPFpw7eMv/2oUsV7Uw0u4vEzOQvvgcrK8YM15mtSmC
	WwktTQhDa1s9/O7XNIQZZE3AunhWbnXminD1Ik8FQHzDGmjhhhn5I4Gr/+cOZk4I0Jj9sV
	wGAWT8KXb+/chD/tK2bnWa+oY4zQFRk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-ODGffXdGNnGklVvsHR6SNA-1; Wed, 13 May 2026 07:06:13 -0400
X-MC-Unique: ODGffXdGNnGklVvsHR6SNA-1
X-Mimecast-MFC-AGG-ID: ODGffXdGNnGklVvsHR6SNA_1778670372
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8397b14a689so4182874b3a.2
        for <linux-integrity@vger.kernel.org>; Wed, 13 May 2026 04:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778670372; x=1779275172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g4aX+tA7681RtoZuYuTTDvdoIPi9sMbmQGgALbo6OmY=;
        b=cULJYiJG3L1Sya/l2VnRMl7xXQztumF+fT0uXPI8Ib7Nfn/AL1k4PyrXD3Yh+Jn97z
         h649pU4aFMKxU6P3921XcMdwpGq7UqYPeZnyJPAEFUkGXN6VZhIF3zVKR/63TUjes/4R
         58mMQPDJH1BOz+X0oc6hg4GRSekeGSU4l7gT1dJqMugQnyuGarLqn7nTKEETPPrMgdMo
         9UpkqcGP0oZimkRDJaCgH1LfPj7DA7S2mMLVCWsVZTkg0SFPxRFK4ALc3dbgmUsh4bJB
         1Myendy/Yu+sH+Fw/Y+UUCqdB+MnKPx/7tzX6mNy2UrhTaixp4CPBzCuREJJLPsM+YWo
         X9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778670372; x=1779275172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4aX+tA7681RtoZuYuTTDvdoIPi9sMbmQGgALbo6OmY=;
        b=oZjqwz37UCUXXrYkoEUWMnkKTK74GsYhEIVVlh2Ea5hARxDOvDM/20rHgPUY3Adszm
         MMyiX41VjubXF99EqE3twwVzfN+0j2ENoYNzoBz8XYhOq/S6irN2r5xLiCEyZOlbO48e
         AWZbCpTUp+JY2CCCJ8iBpeUSJLaRdXEXh0ilstLzoQxUfgsk1mee5qV9470AbaYchR8m
         ucrdF0k023ZZDdUzjWGtFe+5IJE2BANtIOP76k+Buaq3GIfkfcFozQlSCIrD9E1sbd2M
         RKyDHrBEf3bMOBK+mXi5cCf5rDxfP5nnF4hnEJw2Y47QtXzQ6hyykhDFg3Qjtxnx6Jx6
         QmCw==
X-Forwarded-Encrypted: i=1; AFNElJ+8akEcmLkLPSSZmMF1c5wzRDI3iz+ZUdbrhCylVVQNnPpSa5jbns62/0dnfEEgnD1dihqPHKhzIbowRm0qTCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLNiEbwwrsWXmHiKg4xTEee+rLrBrHQmvrxgal87MWdbmoaiXK
	LSLfMFqMFvCE/OxwPV/KseWNh5HZTPDTQ5Axt78hXaQnW/Z0Se5oStayX+/6k4/8+LTdyR++L90
	ZpLDavNmjNXTeyQaEDm+ZcrWce/R2FtwDHM6QEVqhrLSEEVfzIzgmmuD7YNCFS8PFOUHv8A==
X-Gm-Gg: Acq92OHOYPIM8VbkUU7TJsjV6hWdGxFSEizW4FsM+RZV7qvVOjZ3vvar07CKK/gSXd1
	Rnb5T1Zw1YuxH+0ZeCK5NdKbuVo3sPGnJWVIHw19u99dKuF7KRY4S58GYXI4zdCF5Z2io38FHjk
	+NfljHm6PXau+jYJ3fzASp2K6lZUSIlCH8akjP1UDiRTZL3FUr/2jSTPjzPAvyigcaPya4YMQ5N
	Gu9A0goHR2zGvmktI3YV0lE6FRmZxUc1AukFw9PDydOflH/Fur4p7wTHo2XBTiLMR3gh3tt7IJ6
	3lwQtzlt2k6LQqV5Qqw7MDM0SW61YcwvgiDTOD9t2xKgmfi69RNLINrRYVjAHsstzxUJJZjuTlY
	LiCQ9HupzLUdD
X-Received: by 2002:a05:6a00:14c3:b0:838:af72:fb35 with SMTP id d2e1a72fcca58-83f03e949f1mr3022955b3a.10.1778670372158;
        Wed, 13 May 2026 04:06:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:14c3:b0:838:af72:fb35 with SMTP id d2e1a72fcca58-83f03e949f1mr3022912b3a.10.1778670371677;
        Wed, 13 May 2026 04:06:11 -0700 (PDT)
Received: from fedora ([49.36.106.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a20ebsm27211301b3a.53.2026.05.13.04.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:06:11 -0700 (PDT)
Date: Wed, 13 May 2026 16:36:05 +0530
From: Arun Menon <armenon@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC v2 4/5] tpm: Increase TPM_BUFSIZE to 8kB for chunking
 support
Message-ID: <agRbHXcRF2XI1d-x@fedora>
References: <20260324181244.17741-1-armenon@redhat.com>
 <20260324181244.17741-5-armenon@redhat.com>
 <af9KnU90yMf8MxnQ@kernel.org>
 <af9Nn3WA7bWVI1nO@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af9Nn3WA7bWVI1nO@kernel.org>
X-Rspamd-Queue-Id: 02DCF531DE7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9526-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 06:07:11PM +0300, Jarkko Sakkinen wrote:
> On Sat, May 09, 2026 at 05:54:25PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Mar 24, 2026 at 11:42:43PM +0530, Arun Menon wrote:
> > > The size of the command is checked against TPM_BUFSIZE early on before
> > > even sending it to the backend. We therefore need to increase the
> > > TPM_BUFSIZE to allow support for larger commands.
> > > 
> > > For now, 8KB seems sufficient for ML-KEM and ML-DSA algorithms and it is
> > > also order-1 safe.
> > > 
> > > Signed-off-by: Arun Menon <armenon@redhat.com>
> > > ---
> > >  drivers/char/tpm/tpm.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > > index 87d68ddf270a7..26c3765fbd732 100644
> > > --- a/drivers/char/tpm/tpm.h
> > > +++ b/drivers/char/tpm/tpm.h
> > > @@ -33,7 +33,7 @@
> > >  #endif
> > >  
> > >  #define TPM_MINOR		224	/* officially assigned */
> > > -#define TPM_BUFSIZE		4096
> > > +#define TPM_BUFSIZE		8192
> > >  #define TPM_NUM_DEVICES		65536
> > >  #define TPM_RETRY		50
> > >  
> > > -- 
> > > 2.53.0
> > > 
> > 
> > Shouldn't this prepend previous patch?
> 
> Also did you remark that tpm_buf would also need changes as it is fixed
> to PAGE_SIZE?

TPM_BUFSIZE can be increased, in its new location include/linux/tpm.h as
per the patch : https://lore.kernel.org/linux-integrity/20260125192526.782202-12-jarkko@kernel.org/
and I think that alone will take care of the check if (size > TPM_BUFSIZE)
in tpm_common_write() in drivers/char/tpm/tpm-dev-common.c.

However I was not able to apply the mbox file cleanly on the existing
branches for-next-tpm and for-next-keys. I could apply them cleanly on
the old branch (next). Please guide.

I would only change the TPM_BUFSIZE set in 
[PATCH v9 11/11] tpm-buf: Implement managed allocations to 8192.

> 
> I've made a patch that essentially makes tpm_buf size variable as caller
> does kzalloc:
> 
> https://lore.kernel.org/linux-integrity/20260125192526.782202-12-jarkko@kernel.org/
> 
> I'd see this as pretty good long-term solution.

Indeed. 

> 
> BR, Jarkko
> 


Regards,
Arun Menon


