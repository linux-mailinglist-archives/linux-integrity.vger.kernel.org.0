Return-Path: <linux-integrity+bounces-5350-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9B9A6AC03
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 18:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 960847A6E2B
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 17:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C7D224B1E;
	Thu, 20 Mar 2025 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmiILIoS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537FC2144C9;
	Thu, 20 Mar 2025 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491848; cv=none; b=F+Kk+LdXgKyk2fYzCkl4KqfKTZ09i7LTh+9JKwbdVOwssIoU4ggNOGCcFAfKg/Zmhk1hgKcKEjaZEhpNcEhQi3B8vVbogV3pU4NU/xT3ermWGFbpzXG5bLuLinxclu/FFU3szNy087RUaNpZHp10JjfTrRE+pUL0/0jyeiioDR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491848; c=relaxed/simple;
	bh=nRMAPsn1Bgxu6fM0iRIzboTvePnPyN561wNoryZUtdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojt/mQtWPX0VeUFCZIaKcCBjiOvJN+MsQi/F3hBbVFwFY2yQRvthWaI88wmjI7iuQw9/TsOB4X6MzLr3HwBFR8/4npZvHdPUL8/hxOOcTTwnt6iWv/UjMQCkN579YdIZD7ZnWKsVN785tXogvVwf05bPgrGjx+TsLa6PiRgpkoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmiILIoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEBAC4CEDD;
	Thu, 20 Mar 2025 17:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742491847;
	bh=nRMAPsn1Bgxu6fM0iRIzboTvePnPyN561wNoryZUtdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TmiILIoSOPuFP9MzWarOSzTJagU82Lo3pGGXgeI2fv1QldVk9NM0VaXptBjAJS5AM
	 MMnK9+QlS2iIgIdPRXvbOlphg/gw4Hgo/C/nrcJCODxqi6svG+wa7SIkrWSuKFKJcx
	 FZcjgDu2cTcGUvpPUCoRVbFHPnGlmPGGDytyYWKVF+j0Zufj0N9NxuZwnOtAfupxe8
	 Mul7vHMiyjhIaPi0TpFK+M+IkgF1O9X6iBt1Cbzw8PRsz6T6T4CBh/z7E1k/QCZya4
	 A0/gpphCAcYQ4i97sJ9C/6hSrgHrxdNEGK7rymlznXD9fIEagJxoGAiHCsv5W5wthd
	 iWWsVoXAjraVQ==
Date: Thu, 20 Mar 2025 19:30:43 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>, linux-coco@lists.linux.dev,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 1/4] x86/sev: add SVSM vTPM probe/send_command
 functions
Message-ID: <Z9xQw8QpRKk26G6R@kernel.org>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-2-sgarzare@redhat.com>
 <d7e5a1d2-5fcc-bf7f-a67d-7871a1627c98@amd.com>
 <Z9glWp6U6vyEmKQa@kernel.org>
 <7kuhiyy7gj4py323g5n2vy3ddlg666zwhtx3mjcklebgtlstdc@xgdyeecifwei>
 <Z9wuLVeP726Cssqp@kernel.org>
 <20250320171619.GOZ9xNY4W54avW2a-u@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320171619.GOZ9xNY4W54avW2a-u@fat_crate.local>

On Thu, Mar 20, 2025 at 06:16:19PM +0100, Borislav Petkov wrote:
> On Thu, Mar 20, 2025 at 05:03:09PM +0200, Jarkko Sakkinen wrote:
> > > I can do that, I slightly prefer BIT_ULL() macro, but I don't have a strong
> > > opinion on my side.
> > > @Borislav since you suggested it, WDYT?
> > 
> > Either goes for me. Sorry for nitpicking that :-) The first comment
> > stil applies.
> 
> Bit 8 is a lot better than 0x100.
> 
> Let's give a better example:
> 
> 0x0000000008000000
> 
> or
> 
> BIT_ULL(27)
> 
> :-)

Sure, I'm fine with using BIT_ULL() :-)

> 
> While I'm here: I'm guessing I'll route patches 1 and 4 through tip once
> they're ready to go and give Jarkko an immutable branch he can base the other
> two ontop.
> 
> Agreed?

Works for me.

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

BR, Jarkko

