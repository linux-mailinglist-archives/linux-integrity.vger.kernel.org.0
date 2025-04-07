Return-Path: <linux-integrity+bounces-5647-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CEEA7EAF8
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 20:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72A63BAE84
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 18:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78510267AEC;
	Mon,  7 Apr 2025 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIXonLt1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0AF267731;
	Mon,  7 Apr 2025 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049690; cv=none; b=Y4sy3KhCXedJt6c8ot5tjKL0UUi+xCgVBdRGzS+/SJ4n5OR1XXXzPoTLJNlxs5c/UrXQ76HLq+zBkAdQZvda/RB9oxfjQssgw6gh5kamW3JxAru6EdQJRNL1DD9YvTEXA/6OeoZWze6MZBryJrE7AG6K9QK6f4xALm++J1029FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049690; c=relaxed/simple;
	bh=roTV4fCBWYKtx7tR13LEF6bSe/MmWW79N66Dk4jgSkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwSOhGbvwz28Ue+K0y6wd0lp5svIE2UYFxhp2NZlEuTupFc1Ne7Yhgi781uhXJ/I+hHQmGu82UP+AG36xrd3N69Ns481ptHHG5l9wqbxg7JqKHiPN2ycmpORdaCJZvKVmlJs0ZgiZFEtkq6x/3MGEJk+2CkPLR14dv6u1sfYmcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIXonLt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00C9C4CEE7;
	Mon,  7 Apr 2025 18:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049690;
	bh=roTV4fCBWYKtx7tR13LEF6bSe/MmWW79N66Dk4jgSkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NIXonLt1oMwV1DOQJSeK3B40+6p6j24z3O8dhm0pzGEEfCBHhzCAYMflHFyIv8qhR
	 XAA3/6l+dz+cCRkZ0DO96zwxiy4hCcWYBg81BYITFzqVT5tf13kP2mnrEXlaLcstTG
	 3qg6LAz0AeRL8aoeq3M8OXdyODYcuB8bQPaSQcKR0VJXtGIlagA0Zlbam2kln9Txpb
	 mWx+aGRN/7HGO3V31ldITu+d29kIImpM/a1Q/6XYVKxs7Bpt/QMTw+xU2qLjWvQUbe
	 YJypWBrZm3mBlL6BPiXsLd0BBPs2nQzlCHV91stSHpEiq5RSGkpSCqBvNqLUVXf9nY
	 J6AS1A+iJd/SA==
Date: Mon, 7 Apr 2025 21:14:46 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev,
	linux-integrity@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
	Joerg Roedel <jroedel@suse.de>,
	Dionna Glaze <dionnaglaze@google.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 0/4] Enlightened vTPM support for SVSM on SEV-SNP
Message-ID: <Z_QWFjJbPWIsBP2s@kernel.org>
References: <20250403100943.120738-1-sgarzare@redhat.com>
 <20250407134643.GDZ_PXQ0OlzcMjiGgp@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407134643.GDZ_PXQ0OlzcMjiGgp@fat_crate.local>

On Mon, Apr 07, 2025 at 03:46:43PM +0200, Borislav Petkov wrote:
> On Thu, Apr 03, 2025 at 12:09:38PM +0200, Stefano Garzarella wrote:
> > Stefano Garzarella (4):
> >   x86/sev: add SVSM vTPM probe/send_command functions
> >   svsm: add header with SVSM_VTPM_CMD helpers
> >   tpm: add SNP SVSM vTPM driver
> >   x86/sev: register tpm-svsm platform device
> > 
> >  arch/x86/include/asm/sev.h  |   9 +++
> >  include/linux/tpm_svsm.h    | 149 ++++++++++++++++++++++++++++++++++++
> >  arch/x86/coco/sev/core.c    |  67 ++++++++++++++++
> >  drivers/char/tpm/tpm_svsm.c | 128 +++++++++++++++++++++++++++++++
> >  drivers/char/tpm/Kconfig    |  10 +++
> >  drivers/char/tpm/Makefile   |   1 +
> >  6 files changed, 364 insertions(+)
> >  create mode 100644 include/linux/tpm_svsm.h
> >  create mode 100644 drivers/char/tpm/tpm_svsm.c
> 
> Jarrko,
> 
> should I take the whole bunch through the tip tree?
> 
> No point in splitting between two trees...

It's cleanly separated and does not even touch any shared headers,
so I don't see any issues on doing that. I.e., I'm with it :-)

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 

BR, Jarkko

