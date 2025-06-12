Return-Path: <linux-integrity+bounces-6441-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3608DAD6DBC
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jun 2025 12:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C440A3A34C9
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jun 2025 10:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE7222FAC3;
	Thu, 12 Jun 2025 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoppQeLr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7850422DF95;
	Thu, 12 Jun 2025 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724259; cv=none; b=DLEQMgi43CYvQkBi1aePje5pX+N8K7x2NJNc4gM58MkVt5mY2vb5piwLi2ebtq7l2TxAxhXkyIbUh9oocQN/7EtgZ4cMFf5h4Vnokw08Wyw8nR2vZhemTC5Ypwdqz2JiTO9Emymi/RoJmdjNA4/XiSWJke+me77lmspw5dCTHh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724259; c=relaxed/simple;
	bh=UptZCHL/SIqqhiJnZoOAivvnbhhBVRs8nh2meH1TAcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFF/i4L+7W13AGFlZx8BJcqOX47cbzjt5jV8IITOgCSdyezUKcAloJtJtBqzI2FdWgdHUcT2ItETIoGMXV5Auwgqlk907Qnq8VBT3B3TdqmpS46dEjzpZ8I7kxnKYyq9MqFVUpEzNuNcvKnyxNzr0xVQqngqa44xWtc1kjH9UJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoppQeLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0929C4CEEA;
	Thu, 12 Jun 2025 10:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749724259;
	bh=UptZCHL/SIqqhiJnZoOAivvnbhhBVRs8nh2meH1TAcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RoppQeLrgwYBS3NtzwQCtg9PLDtH/IW+ZdBAiOqEUnLKHV7xetiRSWhnJCL+5ufcr
	 TLeO5n8ZYUTLCEvR/bpqNXAckoT3PD8OstCVmnSkcaacWAbQsqFbjhxXKXjml9hGx0
	 g3gSZuma6ldoBoH5tCj1cqwYsBg2wt9X1kp5GrcAf4TiSTpkVKYjM+D3rKXThm2kxd
	 prCk207kuuLlS4HyEGVy5tHgKTtw4uBDlBdiwDjwHvU1wLmKsvzQab0rtIAj96qAz3
	 VHItFaOFe64btH1Wmli7MOVyhz4OR9jLZe/OH0J0Mk5NXu+XyRzR9n0F+9KokdT4vT
	 Y798ZykDBKcQQ==
Date: Thu, 12 Jun 2025 13:30:55 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fix failure of integration IMA with tpm_crb_ffa
Message-ID: <aEqsX0hBKb7ZC1qZ@kernel.org>
References: <20250610060334.2149041-1-yeoreum.yun@arm.com>
 <aEgmhwu1RP27yBpw@kernel.org>
 <aEgwpXXftXW6JNRy@e129823.arm.com>
 <aEg6Bgh8TqzK5nSu@kernel.org>
 <aEhDY4VlkIPYAjPE@e129823.arm.com>
 <aEhIPC95FisptBO5@kernel.org>
 <aEhNnAxlToRMteA2@e129823.arm.com>
 <aEmxaJQNfYJwSCd0@kernel.org>
 <aEm+gqyp0aa4ULYa@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEm+gqyp0aa4ULYa@e129823.arm.com>

On Wed, Jun 11, 2025 at 06:36:02PM +0100, Yeoreum Yun wrote:
> Hi Jarkko,
> 
> > On Tue, Jun 10, 2025 at 04:22:04PM +0100, Yeoreum Yun wrote:
> > > > OK, if ffa_init() is leveled up in the initcall hierarchy, shouldn't
> > > > that be enough as long as ko's can be found from initramfs?
> > >
> > > As you mentioned, this is handled in Patch #1.
> > > However, although ffa_init() is called first,
> > > unless tpm_crb_ffa_init() is also invoked,
> > > crb_acpi_driver_init() will fail with -EPROBE_DEFER.
> > >
> > > Please note that IMA is always built-in and cannot be built as a module.
> >
> > Sure but if one needs IMA, then tpm_crb_ffa can be compiled as built-in
> > with zero code changes.
> 
> All of my describtion based on all things are built as "built-in".
> in case of ffa_init() changes the init level to root_initcall,
> so, the ffa_device will be produced first before the trial of TPM probe.
> 
> Note that tpm_crb_ffa_init() which is the "ffa_driver" is called in
> device_initcall level. I mean
> 
>     ffa_init() -> arm_ffa -> root_initcall
>     tpm_crb_ffa_init() -> device_initcall
>     crb_acpi_driver_init() -> device_initcall
> 
> therefore, "crb_acpi_driver_init()" can be call first before
> tpm_crb_ffa_init() since they're deployed in device_initcall.
> If this happen, "crb_acpi_driver_init()" failed with -EPROBE_DEFER.
> 
> That's why this patch is required to probe "tpm_crb_ffa" when
> crb_acpi_driver_init() called to complete the TPM device probe before
> IMA subsystem initailization.

Yep, and you sort it out by not compiling it as a module.

+	ret = ffa_register(&tpm_crb_ffa_driver);
+	BUG_ON(!ret && !tpm_crb_ffa);

These lines struck me in your patch. The commit message has nothing
about ffa_register().

Also, please remove BUG_ON(). That said, I don't think 2/2 is needed.

> 
> Thanks.
> 
> --
> Sincerely,
> Yeoreum Yun


BR, Jarkko

