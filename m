Return-Path: <linux-integrity+bounces-9341-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FEMMVI672mD+gAAu9opvQ
	(envelope-from <linux-integrity+bounces-9341-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 12:28:34 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 642C4471029
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 12:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 649CE3001312
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 10:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446A03B2FE4;
	Mon, 27 Apr 2026 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2S9+KPj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oiggHzA3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E470357702
	for <linux-integrity@vger.kernel.org>; Mon, 27 Apr 2026 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777285712; cv=none; b=XZ57zeGuqCsABqP4vJC3Qj6hxhYKlz6o3/ZhDh3SvMDZjOTIPeZtugJ3DRehO3UypKf5HimEtImz6gKfaudizCcgf8gCO/9a86KeyrRaprh52RnWhVc5ROIRj4BStIavX/F0puFRrAvOY7s8/1RqDEoODX78VSFXFpBRB4FPIbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777285712; c=relaxed/simple;
	bh=cCt541ifea4w7PLLIlqaxiEyv36+ufAxy9BS7z7jNio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QM5QPmIWKhIBE2bCliHiW5RpkrHP/wl1ZynpRXVMW6aucjAwO8djj6yqcdNGTYp/zNMmkEN6ETs7S6iBKTXoBNhnQq9VX4KBqZGrgZiYoeVrgPyGv1m8jrljp5oELunSU6x8PvvJN4LLRPiRNe3NU71aOlWLekhAzU7CCqLXDgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2S9+KPj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oiggHzA3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777285709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wKk6nuizBx2EkYYb78gjU7IxUoclGd/n9oduZdA/mLA=;
	b=Q2S9+KPjdtNgaHynQSmo4VGSjGlsh7tsYh99U5FPsI6ETtdXft/3cSR0jUKKf0s1weLilX
	4+JkhL72FBD1FmRhyI4hfAuVqvlkXkI1a5BwkG8Vqj3z2j757pianlvPD6V8dg/9HV4BpV
	xJQElZXPV9a/cuUg/K1ZkDvPKH5Wqsw=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-yU0rbTNhOhWpW-vrunM0hg-1; Mon, 27 Apr 2026 06:28:28 -0400
X-MC-Unique: yU0rbTNhOhWpW-vrunM0hg-1
X-Mimecast-MFC-AGG-ID: yU0rbTNhOhWpW-vrunM0hg_1777285707
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82fa7c6699fso11319734b3a.1
        for <linux-integrity@vger.kernel.org>; Mon, 27 Apr 2026 03:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777285707; x=1777890507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKk6nuizBx2EkYYb78gjU7IxUoclGd/n9oduZdA/mLA=;
        b=oiggHzA3D6ID5/zbtSOK2HGj/lY9z7L+ESl4No9Iz3EwNRorBwLtHzp2UyRKBXmwK2
         lnBDJUVtQUxOpSthYe2swUjeBhqZxA933OKJuMk/Kwhhp4XZv5NYaErDbnjDbj+wyeF6
         3jcXcjvJVsgd7QoSm126qfpWdFR9Z1P18GsDqBk3B24hKVvKVz9XGKNb1tiKCt1VrBFJ
         YOKGAmjFdjrG22imnrD9UeJkeosfM8qH4G70BRriSlopSIalm+dOLVICNfquLt8V0baQ
         ZGCIs5xdVUDPD7pjGue7pU4JSfACa9GrMiXTImh487qv/hTaqNJ6sM7pNH4Xyw25d9VR
         SsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777285707; x=1777890507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKk6nuizBx2EkYYb78gjU7IxUoclGd/n9oduZdA/mLA=;
        b=r/6shA9zuRoctVwUWv6LiPDY7d6a58nVc0qcsoOoJXw/WhXDR4IcIiBj9v0wCrWQuU
         qI7evxq7FwnlpLzJgl0ktpHXLnLzFgwlLNnw3gREox5+2LZeBdX5JZmLH6whImcNSST9
         TO1Hz0vshVyu/HCPXcc1f/UAHM02F7NsBiL7ZKKudTEi3D0A5s4HVdjIpR3sbl52Q6FW
         f5r7uLoAiaCWCz0uHtKYO135u+urgtihMZph4OHuiS64NFdp69buxNBGSStyXQYbWYGt
         WXTDQpjhH0hhCV/tDWyc2T9mpd4qoJbpjx2FoZ9G6F5l+XgcwskWTTNoNIjRLTNeJi0y
         YlRw==
X-Forwarded-Encrypted: i=1; AFNElJ+qWuYs+on/0hnUzyl2ilrVpKZWF2X5VYiQWorvpxwV+AEZ1DIIGA9dCbgZkztnrd+SC3zf6GxdMNr9FlG4COo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0p/NWVkTEp5noY0g8Cce37DOsQT8HDKkOIeJxQ2kiGJCMJdQx
	1edgvs2iFU4SQYEPd7dBPISePGp201t6TMA0Cd3kYvy+kB/sN6x0QSUxYVZQysf05Le65n0NLfQ
	E2HBGaBg70IJ0YyQO9zdDAMK6qJaL/oYQJFgHXT+1NHTLdZ3AmUdoiPA0yEktZ7pkYCCe1w==
X-Gm-Gg: AeBDieu8QBUPJfN/5H9SVokw2Fx5rQN5spM1KyGxYP4RooImczuKimwRBzJ3i5XDrou
	/K/8axTYHhNhNOsnpya4eBSzYurekOL5zN/K/sXJbp3SO7ng2gZyCH1XSI2/jCx0OplK/oQsL0F
	rR7S0sw0bWCly9n6Mx1QkUrKSI+0vTlHNYAKefkEmkA5fRdIAyQCwZLiy3QZLDmCca2gPER/P8d
	l1/CFkSo5SSratS+G0nxhouqTIXu2LxrDn4L5o/FYZ7a6V6FeMY/Q6ASUKdq1furCNoSeYMdkZ4
	/6lK6MnJ4FK8K4G4gAN8tQawxX8ysTYD0pyebBF7AGg6RZ0AAbQk6VazuIdSN+1KilbqwFPRiOZ
	4aLup/A0tk07sY75iHjhxOXU=
X-Received: by 2002:a05:6a00:845:b0:82c:20ba:1570 with SMTP id d2e1a72fcca58-82f8c9024a2mr46748900b3a.29.1777285707188;
        Mon, 27 Apr 2026 03:28:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:845:b0:82c:20ba:1570 with SMTP id d2e1a72fcca58-82f8c9024a2mr46748873b3a.29.1777285706718;
        Mon, 27 Apr 2026 03:28:26 -0700 (PDT)
Received: from fedora ([49.36.104.184])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ea0098fsm31558014b3a.24.2026.04.27.03.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:28:26 -0700 (PDT)
Date: Mon, 27 Apr 2026 15:58:11 +0530
From: Arun Menon <armenon@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [RFC 0/4] tpm_crb: Add command and response buffer chunking
 support
Message-ID: <ae86O1ivNt_JSZeO@fedora>
References: <20260324071803.324774-1-armenon@redhat.com>
 <acJqVjZ7eSxOpSL5@kernel.org>
 <acKGZ33ItHvMkQ_5@fedora>
 <adYTLq0qgWpA1kIS@kernel.org>
 <aen3zxxedDXlekRb@fedora>
 <7fa63e8a-1ffb-4dcd-af01-0811768ecda9@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fa63e8a-1ffb-4dcd-af01-0811768ecda9@linux.ibm.com>
X-Rspamd-Queue-Id: 642C4471029
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9341-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,ziepe.ca,gmx.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armenon@redhat.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	HAS_WP_URI(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,trustedcomputinggroup.org:url]

On Fri, Apr 24, 2026 at 04:54:03PM -0400, Stefan Berger wrote:
> 
> 
> On 4/23/26 6:43 AM, Arun Menon wrote:
> > On Wed, Apr 08, 2026 at 11:34:54AM +0300, Jarkko Sakkinen wrote:
> > > On Tue, Mar 24, 2026 at 06:11:11PM +0530, Arun Menon wrote:
> > > > Hi Jarkko,
> > > > 
> > > > On Tue, Mar 24, 2026 at 12:41:26PM +0200, Jarkko Sakkinen wrote:
> > > > > On Tue, Mar 24, 2026 at 12:47:59PM +0530, Arun Menon wrote:
> > > > > > The new version of TCG TPM v185 (currently under review [1]) supports
> > > > > > sending data/commands in chunks for the CRB (Command Response Buffer)
> > > > > > interface. This is in line with the initiative to support PQC algorithms.
> > > > > > 
> > > > > > This series implements the logic to send and receive larger TPM
> > > > > > cmd/rsp between the linux guest and the TPM backend in chunks.
> > > > > > Currently, the TPM CRB driver is limited by the physical size of the
> > > > > > MMIO window. When userspace attempts to send a payload that exceeds this
> > > > > > size, the driver rejects it.
> > > > > > 
> > > > > > This series introduces chunking support. The driver now checks the CRB
> > > > > > interface capability for CRB_INTF_CAP_CRB_CHUNK. If supported by the
> > > > > > backend, the driver will slice oversized commands into MMIO-sized
> > > > > > chunks, signalling the backend via CRB_START_NEXT_CHUNK, and finalizing
> > > > > > with CRB_START_INVOKE. Responses are also read back in a similar chunked
> > > > > > manner.
> > > > > > 
> > > > > > If the backend does not support chunking, the driver retains its legacy
> > > > > > behaviour and enforces the standard size limits.
> > > > > > 
> > > > > > This feature also requires the QEMU to interpret the data in chunks and
> > > > > > forward it to the TPM backend and subsequently dispatch the TPM response
> > > > > > in chunks back to the linux guest. This is implemented in [2]
> > > > > > 
> > > > > > [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf
> > > > > > [2] https://lore.kernel.org/qemu-devel/20260319135316.37412-1-armenon@redhat.com/
> > > > > > 
> > > > > > Arun Menon (4):
> > > > > >    tpm_crb: Add definition of TPM CRB chunking fields
> > > > > >    tpm_crb: Add new wrapper function to invoke start method
> > > > > >    tpm_crb: Implement command and response chunking logic
> > > > > >    tpm: Increase TPM_BUFSIZE to 64kB for chunking support
> 
> 64kb? I am only increasing the TPM buffer to 8kb. More does not seem to be
> necessary.

That was a mistake in v1. I have changed that to 8kb in v2.
https://lore.kernel.org/all/20260324181244.17741-5-armenon@redhat.com/

> 
> > > > > > 
> > > > > >   drivers/char/tpm/tpm.h     |   2 +-
> > > > > >   drivers/char/tpm/tpm_crb.c | 194 ++++++++++++++++++++++++++-----------
> > > > > >   2 files changed, 137 insertions(+), 59 deletions(-)
> > > > > > 
> > > > > > -- 
> > > > > > 2.53.0
> > > > > > 
> > > > > 
> > > > > When QEMU has the feature available?
> > > > 
> > > > The QEMU patches are in review at the moment,
> > > > here is the link: https://lore.kernel.org/qemu-devel/20260319135316.37412-1-armenon@redhat.com/
> > > > Hoping to have them merged soon.
> > > 
> > > Right, and additional question: what about swtpm?
> 
> I am waiting for https://github.com/trustedComputingGroup/tpm to show rev185
> with PQC support so that I can merge my patches based on 'their' PQC support
> into the public libtpms repo.
> 

Regards,
Arun Menon


