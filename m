Return-Path: <linux-integrity+bounces-5238-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6257A5D5D3
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 07:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120841792A4
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 06:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B821922F6;
	Wed, 12 Mar 2025 06:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUdG+1Uu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBDB2F43;
	Wed, 12 Mar 2025 06:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741759260; cv=none; b=PJYGT3vgcW+oBCEHZIWR9CCA3HVh5iM/Cu/hDxoJEirj/NpKUzARVjJiUSCdI0YoMdNMvWAj6PA4ASQJir9vLuG3ONKSTRsDtfY1yDWzhnsr6C0xN5JzBtqyVSeu3d2lqZP3UN5Q5VdTzzox/tm0CHzoAaBHFV46FhkxLG/g8Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741759260; c=relaxed/simple;
	bh=9pAA/yH6P+xsx2MApZdeJOVyxbVik21j2UMqV/OdY/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGRZkiwtgLrdqTbqfbg73P9khiALH1FyMQzMIjVIOU76FfwJXcuxgrFkkGd6fv4Z2cT4EfulB2NPgeUS2zWaiBS1ccbXx2X2cMHBS2DUwfjm9sknihtS+2ZY44WdKOW7/PW28ZBDkszepQYAZZkpZ3dXRWbToI0sdVGuJISc5mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUdG+1Uu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A32AC4CEE3;
	Wed, 12 Mar 2025 06:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741759259;
	bh=9pAA/yH6P+xsx2MApZdeJOVyxbVik21j2UMqV/OdY/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tUdG+1UusDMvYlqU6TDDAoy5MK2TbaR/9OXJT5bGwAgbwO+np3TbS0SCLDvlC4sJJ
	 bJYd3K7HkbZ0oGYDk/qSNZaO89Ir3ii8DUOYZn1EfytuQVIVvSTvAHgo+KKdMj7RAo
	 Xard+klOkiBnpHBq6xo4X68YrI0XHgi4UTLBk2rZR8Dv3wUhMvoQpCPtWI1kxvC3rj
	 4fnpJCuJGVuQiH+UKUpZqtQl880xhF8oirGJf4pCxaDx//7GOEguGKyBmb6CeKnQAF
	 iYrIGxeXf40rFlsEa9e5Wttf54ehlq66a1rJDMUY4iqt1b6LvC6YceyxW3tDiKK9bg
	 NMK9+2BCWfP4g==
Date: Wed, 12 Mar 2025 08:00:55 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Stuart Yoder <stuart.yoder@arm.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, lenb@kernel.org, rafael@kernel.org,
	jgg@ziepe.ca, peterhuewe@gmx.de, sudeep.holla@arm.com,
	linux-integrity@vger.kernel.org,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: Build error on -next due to tpm_crb.c changes? (was: Re: [PATCH
 v6 0/5] Add support for the TPM FF-A start method)
Message-ID: <Z9EjF-pybmZlnTws@kernel.org>
References: <20250305173611.74548-1-stuart.yoder@arm.com>
 <0ad035ff-400e-4b15-8b8f-40b69152ec46@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ad035ff-400e-4b15-8b8f-40b69152ec46@leemhuis.info>

On Tue, Mar 11, 2025 at 04:21:38PM +0100, Thorsten Leemhuis wrote:
> On 05.03.25 18:36, Stuart Yoder wrote:
> > Firmware Framework for Arm A-profile (FF-A) is a messaging framework
> > for Arm-based systems, and in the context of the TPM CRB driver is used
> > to signal 'start' to a CRB-based TPM service which is hosted in an
> > FF-A secure partition running in TrustZone.
> > 
> > These patches add support for the CRB FF-A start method defined
> > in the TCG ACPI specification v1.4 and the FF-A ABI defined
> > in the Arm TPM Service CRB over FF-A (DEN0138) specification:
> > https://developer.arm.com/documentation/den0138/latest/
> > [...]
> > Stuart Yoder (5):
> >   tpm_crb: implement driver compliant to CRB over FF-A
> >   tpm_crb: clean-up and refactor check for idle support
> >   ACPICA: add start method for Arm FF-A
> >   tpm_crb: add support for the Arm FF-A start method
> >   Documentation: tpm: add documentation for the CRB FF-A interface
> > 
> >  Documentation/security/tpm/tpm_ffa_crb.rst |  65 ++++
> >  drivers/char/tpm/Kconfig                   |   9 +
> >  drivers/char/tpm/Makefile                  |   1 +
> >  drivers/char/tpm/tpm_crb.c                 | 105 +++++--
> >  drivers/char/tpm/tpm_crb_ffa.c             | 348 +++++++++++++++++++++
> >  drivers/char/tpm/tpm_crb_ffa.h             |  25 ++
> >  include/acpi/actbl3.h                      |   1 +
> > [...]
> 
> My daily linux-next builds for Fedora failed building on ARM64 today. I did
> not bisect, but from the error message I suspect it's du to  patches in this
> series touching drivers/char/tpm/tpm_crb.c :
> 
> ld: Unexpected GOT/PLT entries detected!
> ld: Unexpected run-time procedure linkages detected!
> ld: drivers/char/tpm/tpm_crb.o: in function `crb_cancel':
> /builddir/foo//drivers/char/tpm/tpm_crb.c:496:(.text+0x2c0): undefined reference to `tpm_crb_ffa_start'
> ld: drivers/char/tpm/tpm_crb.o: in function `__crb_request_locality':
> /builddir/foo/drivers/char/tpm/tpm_crb.c:285:(.text+0x768): undefined reference to `tpm_crb_ffa_start'
> ld: drivers/char/tpm/tpm_crb.o: in function `__crb_relinquish_locality':
> /builddir/foo/drivers/char/tpm/tpm_crb.c:319:(.text+0x81c): undefined reference to `tpm_crb_ffa_start'
> ld: drivers/char/tpm/tpm_crb.o: in function `__crb_request_locality':
> /builddir/foo/drivers/char/tpm/tpm_crb.c:285:(.text+0x8bc): undefined reference to `tpm_crb_ffa_start'
> ld: drivers/char/tpm/tpm_crb.o: in function `__crb_relinquish_locality':
> /builddir/foo/drivers/char/tpm/tpm_crb.c:319:(.text+0x958): undefined reference to `tpm_crb_ffa_start'
> ld: drivers/char/tpm/tpm_crb.o:/builddir/foo/drivers/char/tpm/tpm_crb.c:474: more undefined references to `tpm_crb_ffa_start' follow
> ld: drivers/char/tpm/tpm_crb.o: in function `crb_acpi_add':
> /builddir/foo/drivers/char/tpm/tpm_crb.c:830:(.text+0x1518): undefined reference to `tpm_crb_ffa_init'
> make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
> make[1]: *** [/builddir/foo/Makefile:1242: vmlinux] Error 2
> make: *** [Makefile:259: __sub-make] Error 2
> 
> Full log:
> https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-41-aarch64/08750241-next-next-all/builder-live.log.gz
> 
> Same problem on Fedora 40, 42 and 43. 

I dropped these commit, requested for fixes from the author, and a
couple of additional nitpicks:

https://lore.kernel.org/all/Z9EiRDuWfPOkcjXN@kernel.org/

BR, Jarkko

