Return-Path: <linux-integrity+bounces-6653-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E63EB0B060
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Jul 2025 16:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0E91AA1FE2
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Jul 2025 14:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1547170A37;
	Sat, 19 Jul 2025 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVUdM+0K"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E717881E;
	Sat, 19 Jul 2025 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752934644; cv=none; b=n9nFkoODNn1fj084wa6EhWRMwi9NWfW2ENLLkGyP0hp3Hv9gzd6LbCDxxtf76sdRMAI64PhXbD2Agb63MtD/PJAQHfoWB1pHDEY4B9FD7tgl0eR8Oaqh1xhJ74GJLCdjHvRYeOiUyIba6UfViPyyf5BNz0Oa4HcUtnPPHSC7Go0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752934644; c=relaxed/simple;
	bh=KUofb521B8AZVG1D7BsR/ikz80zn5hGl17C7QpRR16o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyjWhbSltVZlQ6nz4nl7bkY2EvnU62K2dRVC3nDilO3y0EF+lrac2eZDrPpe2x2Bk0r4/yCnoVx7hPzWEFKMBHxBgpCL6G1DPYXYLlUwtTyIoFUT2OemMPLW9PgTCCNRim/8eNpS+lqvd+hgvE+1mDB96Lu4WKfcb3tDYW44Ph4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVUdM+0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F87AC4CEE7;
	Sat, 19 Jul 2025 14:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752934644;
	bh=KUofb521B8AZVG1D7BsR/ikz80zn5hGl17C7QpRR16o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SVUdM+0K0jGe4rVqrY0b0y344DhaNF/P4l5qjcxHDZvjs1Sz5lEaHuUgqbvaNEk53
	 qQnUBOgvlrcAm4zN71fyfN0akPvw/r1ml61YT3oGeexTcYdu/yhx9FzkdMacNyRNTE
	 zyv+HGIXmcJ0L36rHQzw5SOny2Rg8llXUoO/L8Si1gfO5eJCm5+HS+FjpcPSHzj46P
	 wwH+vlfJORYkYA65kjGqarey6/GIYwgDIS+PBmngoO9/dqd8SZTjQXQ77/y7bSQnem
	 2aXfilZYH0Gma9kVAdLA7hP3yS6+DftAVDwDHFrwttCgKK6fRvpP/mcsYh6NPp0qYL
	 8r1iJCcLOAHyw==
Date: Sat, 19 Jul 2025 17:17:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Jonathan Corbet <corbet@lwn.net>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Frank van der Linden <fvdl@google.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [RFC PATCH] tpm, tpm_vtpm_proxy: boot-time TPM
Message-ID: <aHuo8Fh_S8aEi7VM@kernel.org>
References: <20250716121823.173949-1-jarkko@kernel.org>
 <bfcc3a24-b48c-48a6-8280-07f7a2669e6b@infradead.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfcc3a24-b48c-48a6-8280-07f7a2669e6b@infradead.org>

On Wed, Jul 16, 2025 at 11:44:02AM -0700, Randy Dunlap wrote:
> (mostly nits, along with Paul's comments)
> 
> 
> On 7/16/25 5:18 AM, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > Provide a kernel command-line parameter named as `supplicant`, which
> > contains a path to an TPM emulator binary. When defind, the kernel will
> 
>                   to a TPM
> 
> > launch the program during boot-time.
> > 
> > This feature is most useful in feature testing e.g., in environments
> 
>                                          testing, e.g.,
> 
> > where other means are not possible, such as CI runners. Its original use
> > case highlights also quite well of its applicability for pre-production
> > hardware: it was used to provide a TPM implemnentation for a RISC-V SoC
> > running on FPGA with no TPM HW implementation at the time.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > ---
> > Bumped into this in my archives so thought to make it available just in
> > case anyone is interested.
> > ---
> >  .../admin-guide/kernel-parameters.txt         | 14 +++++
> >  drivers/char/tpm/tpm_vtpm_proxy.c             | 51 +++++++++++++++++++
> >  2 files changed, 65 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index f1f2c0874da9..e062de99480e 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -7230,6 +7230,20 @@
> >  			defined by Trusted Computing Group (TCG) see
> >  			https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
> >  
> > +	tpm_vtpm_proxy.supplicant= [TPM]
> > +			When defined, this field must contain a legit path to a
> 
> 			                                        legitimate
> or			                                        valid
> 
> > +			program emulating a TPM chip, which will be started
> > +			during the driver initialization, thus providing a
> > +			mechanism for the user space have an emulated TPM from
> > +			the get go. Kernel prepares the process with a file
> 
> 			    get-go.
> or just don't use slang terms.
> 
> > +			pre-opened file descriptor in the index 3 for
> > +			/dev/vtpmx.
> > +
> > +			An emulator can optionally provide support for
> > +			localities by reacting to the vendor command defined
> > +			by the driver: 0x20001000. Its payload is a single
> > +			byte containing the new locality.
> > +
> >  	tp_printk	[FTRACE]
> >  			Have the tracepoints sent to printk as well as the
> >  			tracing ring buffer. This is useful for early boot up
> 
> thanks.
> -- 
> ~Randy
> 

Thank you for reviewing this (especially given how bad shape it was)!

BR, Jarkko

