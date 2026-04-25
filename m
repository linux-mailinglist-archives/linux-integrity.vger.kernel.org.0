Return-Path: <linux-integrity+bounces-9338-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCZoHufN7GlDcwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9338-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Apr 2026 16:21:27 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FA0466943
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Apr 2026 16:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD7F5300E3B0
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Apr 2026 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073FC37C92E;
	Sat, 25 Apr 2026 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtRDIE3p"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6243537EA;
	Sat, 25 Apr 2026 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777126881; cv=none; b=oDsvbRoPY0+94+w7JrrPik6sfOC7sNKArH84Vxrc5ErGSGE/ElRRSc6x2i9/Y2RzyeeviCAcXL9qrEdDYBRjPJoaamuk6ECoNvwYgv/k07vp1ukhpyVReVqO28wfIKhqYfdtoFOWWPxEZO08VmTSetQ5OWKO4CvK7IoO/t2wkI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777126881; c=relaxed/simple;
	bh=BXJEY9GT4IAGipviiCJbDqRr1Y/L0Z3GhcmnT3Gjxkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a39jIAyaTQ/5tssKQs2cB1VwDqsQDa4ZaRQu0wlgrcVAIeBIXNxtaE1+ZzXZx25IqA3vf//ObNNN2jowVqVMavB9gSMIM1YcKxBadfV9lCrOqq6r++XKft3zTjEJx+73hhoibs+IRsKDNjaLlBqxI3jtMI2RFW2ekQTVmU3vIqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtRDIE3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B943C2BCB0;
	Sat, 25 Apr 2026 14:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777126881;
	bh=BXJEY9GT4IAGipviiCJbDqRr1Y/L0Z3GhcmnT3Gjxkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gtRDIE3ptxnAbuJT5k7V0MZyDJn/NOCrxNmKI06ZLZh+v+jsqPSl72MrLuHk0TwyU
	 vi3ZUK9hbwbj4ZTOtCQ9zar4vreF6UFs1rMBz+cBvAroQv6uaJ5Gab7U9U1StwTuUv
	 Fj9Jc9Hssegf9eysnjAmxPdb6wM16iTZfcElrzQxWYom2Kuy0UXPNtYLJxptWBywmb
	 +62aljvjQ2pC1IOFOd9piVLc+brFiRMQNbtHn+RpKbL72vvgB8PNw/wXczsmmSONqJ
	 1MM989ChNtGwOvT/TH3x373juveX81WvZq27vK3wIi3qv0ZXetICEBwPVpQKD4D5NH
	 DKQXwW/5Lx+Kw==
Date: Sat, 25 Apr 2026 17:21:17 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Arun Menon <armenon@redhat.com>, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [RFC 0/4] tpm_crb: Add command and response buffer chunking
 support
Message-ID: <aezN3egqDJBUUCi1@kernel.org>
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
X-Rspamd-Queue-Id: D7FA0466943
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9338-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,ziepe.ca,gmx.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	HAS_WP_URI(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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

Oh, great to hear, thanks for heads up.

Whenever that happens I'll update BuildRoot packages for libtpms and swtpm.

BR, Jarkko

