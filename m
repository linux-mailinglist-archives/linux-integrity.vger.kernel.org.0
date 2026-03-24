Return-Path: <linux-integrity+bounces-9056-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOUlHmeIwmkAegQAu9opvQ
	(envelope-from <linux-integrity+bounces-9056-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 13:49:43 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A732308A04
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 13:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D20443023D51
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 12:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8773346AD6;
	Tue, 24 Mar 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EH8L7rzV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pb/2T58E"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CD3346E43
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356082; cv=none; b=iYdZP9XoOV0L6L4mC6uteCoOHTb/IBYWy7+m9YlT+o03R94pD4xqfs39IHQ/AR97137+gngi+fPNI9dUWyPmeZxW6t5txsc3T1cKvF2mmTGPKb8KFeNGYAIxwyOjhol3bSGhNWCW+gN+wQX5l7ZRz4KS8kxak13Kytmf1kJDRWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356082; c=relaxed/simple;
	bh=/pr0CgDAbsISmMKMqPOMAXkthG8+A0KhI3tEvgnrxxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bd7V7dji+dgDYzMk9WMUVzCIdjdR5RBTbPNrUXzSDkxXx8nb5gY+hQVExG6b0Db+tJeR33ueCJVctigceJDX01CrLWFACKtryHxN/ynKr14Nf9erxnuXx6tchuyulGo7QSGUuAVuh49hoiTpGgTtz+mreaxOlbM74EDKhfTCCco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EH8L7rzV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pb/2T58E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774356080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zuUnYrn7bwO0mac59ZxE1hw62IH9LGSiNtRSChOD3es=;
	b=EH8L7rzVAPwIr5IJ0gTqy+sVrzz9/q2BPyc3RfnlvD1TUOU6aJzrkEpm2+8LL6RLNrIEvL
	L7Lr//mTGmr75Y5sqJazYWZlvOTiC+cu0d6vfOmucCCnz9sagFp+C057iJuvGjT74ToRtn
	ZmYD9ZA8jNZg9eFeVEXVVczqUC4bSJM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43--2B4YRg0Pkyd1U60S0KN1A-1; Tue, 24 Mar 2026 08:41:19 -0400
X-MC-Unique: -2B4YRg0Pkyd1U60S0KN1A-1
X-Mimecast-MFC-AGG-ID: -2B4YRg0Pkyd1U60S0KN1A_1774356078
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c73c065dd15so3644649a12.0
        for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 05:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774356078; x=1774960878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zuUnYrn7bwO0mac59ZxE1hw62IH9LGSiNtRSChOD3es=;
        b=Pb/2T58ELXJ+pyuTUYhAXeIvg5vpztPyVa2Il4ASBFUjvBFnnmjUdek8RyLwU3HOww
         HDEw9oLz7XQR9y8EEXs2AKS4UyrGr+QbuQXHB5J88QZ9c6wNSQgjXHkwtDNKGhrdisKC
         Bg0K0Bljr2RwuqWdcoS4MS6ab26HvG00RXqEZ4X5EcBGvA4vGvY5jI9wO+8NFY18WFO/
         huRNZppUC9KOkf0uVMQYXahh4fNt4iUKdJkKQsMd1dsQFS804/ONzhVmiI4V8daWQ7QD
         YZoixccYppx7AeKG5nVowRaRVE5/M31pLBe04CQ38qtAKMv1hKMJBz2u/02A9h+G0pnp
         CeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774356078; x=1774960878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuUnYrn7bwO0mac59ZxE1hw62IH9LGSiNtRSChOD3es=;
        b=jdl/+CgssSjeRsZcnJnFfwyTq3dYilPq0DT4Sr7iu2T8iqDErno40Ju+enz7OdZHpu
         wKuLxv8curcK3WrS7XYoCPgbkpUdtoDGkOrHoh9g+/AekkioXGVr5afPiSrmz+kzMh+n
         umyxPWmKQZweTfuEuDtwSRaZGV3S3GmqQrduHO4vQ3m1mQdA3Kd8Vb0PelRmcFS3cDSn
         pNPl5pbIkyCgb8N6i7karMz9yOjqJSWVtToTcozx016syK65tgmXqcQ7avnY72m6/zCw
         Em9zYPLFX9jQeu14+hCIKNNRe0afGB9KoE0z4Wd9KwAtHfNRmG3K8Q+bDPPtQ+jbDM8n
         nvSA==
X-Forwarded-Encrypted: i=1; AJvYcCW6VN4CY/6TxcG6SZ2CwxYoEAEQV0afEO4bDGGOph/oZyCg1+GzLU34RlV9atWuktrBqBcT4eD6npYU8M9gndU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwnyOeggtHeaiFtggrtXSKWJLdy9KHRZ77Kap97bqzU9RNxRS0
	OVq7ozmkYDX2knIFN4jq+AAyCNw58HiQZAzy4w3kfAvUpDJmJ3ccwbgsHn1gQWeAhxn3LWy5qeQ
	2gScbXFBDBWB2rfeusz7ornI4NfzY1PYupw6ggrLzzaukzojcaAJ3WOGNV4t90qwu+hcSUA==
X-Gm-Gg: ATEYQzyR/T0nwkK9Or91NTkY/FpFKIiCs5mJgq0P6R2lgHJmDwCT1VY9UYRRz0fBNzN
	/k1z9r4xDQdrpzrd6ncxthDE6QXIbbured6A59rTrB1c5TDUcVLNfrLi6MqyC+XS6vacoqYv5Ie
	YDRO870Va3dsahaKYG1ao2TBgIcyu3xh1fGzJgwhoDOz1VZ5DaEi5uvAGvMSimF2qhMorlAzCRI
	vzABC7yPEbBig3tqHiFyl0xHPYh40JVcUZ0aJ/p+IjXFsjTjCjpFc5eprhkqr5fU6cZfUBAtZtI
	56cJM20PMu0ws9tn3xRPz9jCX4xdeQTaoH4EsVytlqpOLhPHw/L92pq3HXg8VP2UmSae0OUw5CW
	RorvtZ1kZVXo=
X-Received: by 2002:a05:6a20:7f82:b0:398:79a8:5bf4 with SMTP id adf61e73a8af0-39bceb41cc9mr14006024637.37.1774356077794;
        Tue, 24 Mar 2026 05:41:17 -0700 (PDT)
X-Received: by 2002:a05:6a20:7f82:b0:398:79a8:5bf4 with SMTP id adf61e73a8af0-39bceb41cc9mr14005992637.37.1774356077342;
        Tue, 24 Mar 2026 05:41:17 -0700 (PDT)
Received: from fedora ([49.36.108.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a938aebsm10432562a12.17.2026.03.24.05.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:41:17 -0700 (PDT)
Date: Tue, 24 Mar 2026 18:11:11 +0530
From: Arun Menon <armenon@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [RFC 0/4] tpm_crb: Add command and response buffer chunking
 support
Message-ID: <acKGZ33ItHvMkQ_5@fedora>
References: <20260324071803.324774-1-armenon@redhat.com>
 <acJqVjZ7eSxOpSL5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acJqVjZ7eSxOpSL5@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9056-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,gmx.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armenon@redhat.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	HAS_WP_URI(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,trustedcomputinggroup.org:url]
X-Rspamd-Queue-Id: 7A732308A04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jarkko,

On Tue, Mar 24, 2026 at 12:41:26PM +0200, Jarkko Sakkinen wrote:
> On Tue, Mar 24, 2026 at 12:47:59PM +0530, Arun Menon wrote:
> > The new version of TCG TPM v185 (currently under review [1]) supports
> > sending data/commands in chunks for the CRB (Command Response Buffer)
> > interface. This is in line with the initiative to support PQC algorithms.
> > 
> > This series implements the logic to send and receive larger TPM
> > cmd/rsp between the linux guest and the TPM backend in chunks.
> > Currently, the TPM CRB driver is limited by the physical size of the
> > MMIO window. When userspace attempts to send a payload that exceeds this
> > size, the driver rejects it.
> > 
> > This series introduces chunking support. The driver now checks the CRB
> > interface capability for CRB_INTF_CAP_CRB_CHUNK. If supported by the
> > backend, the driver will slice oversized commands into MMIO-sized
> > chunks, signalling the backend via CRB_START_NEXT_CHUNK, and finalizing
> > with CRB_START_INVOKE. Responses are also read back in a similar chunked
> > manner.
> > 
> > If the backend does not support chunking, the driver retains its legacy
> > behaviour and enforces the standard size limits.
> > 
> > This feature also requires the QEMU to interpret the data in chunks and
> > forward it to the TPM backend and subsequently dispatch the TPM response
> > in chunks back to the linux guest. This is implemented in [2]
> > 
> > [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf
> > [2] https://lore.kernel.org/qemu-devel/20260319135316.37412-1-armenon@redhat.com/
> > 
> > Arun Menon (4):
> >   tpm_crb: Add definition of TPM CRB chunking fields
> >   tpm_crb: Add new wrapper function to invoke start method
> >   tpm_crb: Implement command and response chunking logic
> >   tpm: Increase TPM_BUFSIZE to 64kB for chunking support
> > 
> >  drivers/char/tpm/tpm.h     |   2 +-
> >  drivers/char/tpm/tpm_crb.c | 194 ++++++++++++++++++++++++++-----------
> >  2 files changed, 137 insertions(+), 59 deletions(-)
> > 
> > -- 
> > 2.53.0
> > 
> 
> When QEMU has the feature available?

The QEMU patches are in review at the moment,
here is the link: https://lore.kernel.org/qemu-devel/20260319135316.37412-1-armenon@redhat.com/
Hoping to have them merged soon.

> 
> BR, Jarkko
> 

Regards,
Arun Menon


