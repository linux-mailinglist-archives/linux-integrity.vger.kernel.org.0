Return-Path: <linux-integrity+bounces-6394-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E321BAD3A11
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 15:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8373A7718
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 13:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD73298998;
	Tue, 10 Jun 2025 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rL4KmZZv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D9D296160;
	Tue, 10 Jun 2025 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563914; cv=none; b=ApQudFLV+qupX8Lxzu8Hhl7vqrWPkVpkxV4U19mu0sfbOLStiY8OCHmcACnQNVcYjJIxoi8Bt2/qJH1k1st0A1BgQ+5ziebuNYETxSLSanYsAFwDvdR+LpS++gOdn843XOY/HDUURiC4ZKAlT6/o9bl3AEp4ycb9YkBr1rFvi0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563914; c=relaxed/simple;
	bh=DcjHkaAwZrvC9iqm3h/N+EYehYOf07x5o+lB32uAnwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsJLfnC5vKco4hRAh/Pm0oUj48iI+TBH/MCcl5rrRWFIMDzV6lHUu5tpGZgiY3SkYSvskB5iH0L7uPHF5T1L75L6ZimjM9OwimMcZhoGM7ajHQjaq4u78iKP+z8F0Y8BnEVS5M8XNkX/pukde8GLy+ReXRptBQOxm56fHlSa5BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rL4KmZZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA625C4CEED;
	Tue, 10 Jun 2025 13:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749563914;
	bh=DcjHkaAwZrvC9iqm3h/N+EYehYOf07x5o+lB32uAnwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rL4KmZZvWURDpVuaJDuWrMYU7W0dL4ezE5NK6t6+XoRJvPhXKvlkkmuwfMn8AxVmG
	 N66sduGzBqDsDBEsZptl603MIFdS/2uK3tFa+orLcmZM5sEtnF5NTwsvG3ZcEo4n7V
	 RPJu2kIodXLsf04s8mBYFUj4JAETnxVHueckrkzZxEZsyaRvLLOqKUJf5xEtT/F4yP
	 SqOLfIai9IKYWzr3RMTAZEYwmAV1eXgHUGF3xunvyuNavwRM3L7Y2cxaDUvUMhw1aY
	 8hQN8lzQwW8Gqc/B0tSjL6AEZby8DW+5yV2TE3sgdj5HPk1F0/QoM++UeHMqLpZoBM
	 pYL8NrGuf+whg==
Date: Tue, 10 Jun 2025 16:58:30 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fix failure of integration IMA with tpm_crb_ffa
Message-ID: <aEg6Bgh8TqzK5nSu@kernel.org>
References: <20250610060334.2149041-1-yeoreum.yun@arm.com>
 <aEgmhwu1RP27yBpw@kernel.org>
 <aEgwpXXftXW6JNRy@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEgwpXXftXW6JNRy@e129823.arm.com>

On Tue, Jun 10, 2025 at 02:18:29PM +0100, Yeoreum Yun wrote:
>   module_ffa_driver(tpm_crb_ffa_driver);

Oops, I missed this statement. Sorry, my bad.

> 
> >
> > >   0000000000000a9c l  .initcall6.init>  ffa_init
> > >
> > > In this situation, the IMA subsystem fails to integrate with the TPM device
> > > because the TPM was not available at the time ima_init() was called.
> > > As a result, you may see the following message in the kernel log:
> > >
> > >   | ima: No TPM chip found, activating TPM-bypass!
> >
> > TPM initializes before IMA, so there should not be a problem.
> 
> If you see my commit message it describes the situation why this happen.
> when crb_acpi_driver_init() is called but before tpm_crb_ffa_init() is
> called, the secure partition doesn't probe. so crb_acpi_driver_init()
> would be failed wiith -EPROBE.

What is "secure partition" and why it doesn't probe at the time of
crb_acpi_driver_init()?

> 
> In this situation, init_ima() which call ima_init() can be called first.
> NOTE, init_ima() is deployed in late_initcall and
> the "deferred_probe device" is tried again in
> deferred_probe late initcall.
> However, even the deferred_probe can be call later then init_ima().
> 
> 000000000000012c l       .initcall7.init>-------0000000000000000 init_ima
> 000000000000016c l       .initcall7.init>-------0000000000000000 deferred_probe_initcall7
> 
> That's why init_ima() is failed to init with TPM when It is deffered.
> 
> Would you let me know why you said it's not a problem?

What has deferred_probe_initcall has to do with this? Not actually
asking just pointing out stuff that you should open up.

> 
> --
> Sincerely,
> Yeoreum Yun

BR, Jarkko

