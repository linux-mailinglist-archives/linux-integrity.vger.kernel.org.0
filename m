Return-Path: <linux-integrity+bounces-6501-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 915E7AE7320
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 01:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E801BC27C0
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Jun 2025 23:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E2A13C81B;
	Tue, 24 Jun 2025 23:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fw9XH5X2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1AA307496;
	Tue, 24 Jun 2025 23:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807717; cv=none; b=fh7o231yIOMJutcb411cTrJtmPSIYx5A12ILkh/7N7zwKdkjJIFLzzQ63bjTKDd0WsaEH4uzwvB0tCQ7KCUTPVsjRBLqPzJ9qVAMl0+E6B4WFjPSJr8UCQnHQl7PWNESh5vPfHiBnlbpVieOsB+v4zPE7x2IJqOwsrYDgFZ0/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807717; c=relaxed/simple;
	bh=1EXD87GVOxTxY31EJd1X2c2DJ9GuyuaxSW8pKSj+2S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/rhJhzgxWhhcz6q0tE0vTlhRMcjtjKXLs4k9Ku08Rgj7gOIa0cS64cM3/CPUdRzrww77eESlmDG9S7JWbQb76x3V4PRSE0O7YDmTjtLa0eHDa0wToTf/yH2damBQkq8dltAazAEJzxCPd8/NqeeykjBZgkP61ZL3XdQynE8oqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fw9XH5X2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A6EC4CEE3;
	Tue, 24 Jun 2025 23:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750807716;
	bh=1EXD87GVOxTxY31EJd1X2c2DJ9GuyuaxSW8pKSj+2S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fw9XH5X2ljL4C8+SahCFq3xEWus2kg89JVYQrRzmaUPfkhSGILThfgscKj5tFrJTB
	 YvSKP0v5vpAKzLBOc5BJ7sZPHsAWNrT0fo5hZNp+QxAD8LJwaLU9PiTO9r2nVM4pJR
	 dSluju8i5+0u9aPzX/V3N/hVnuO82NEO8h7jMjjFRsZXRf/RCjjfI8x2OgonI9NlLh
	 ClUUbGS8/yuVK4v/CajweTIc/DxSz5P3BV06A6w+bQV3UgwKXMZCf9MW6HcjYa2d3e
	 4Fd1abk4GaR4lfrHa/g53Gy/vtZtqniSSxdbFLzFkApEDcjBe7yr6qffZwi5CFM4LH
	 ZqZCeoxanhCRA==
Date: Wed, 25 Jun 2025 02:28:33 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 0/2] generate boot_aggregate log in IMA with TPM using
 CRB over FF-A
Message-ID: <aFs0of3uZdoMEJXc@kernel.org>
References: <20250618102302.2379029-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618102302.2379029-1-yeoreum.yun@arm.com>

On Wed, Jun 18, 2025 at 11:23:00AM +0100, Yeoreum Yun wrote:
> To ensure the TPM device operating over the FF-A protocol with
> the CRB interface is probed before IMA initialization,
> the following conditions must be met:
> 
>    1. The corresponding ffa_device must be registered,
>       which is done via ffa_init().
> 
>    2. The tpm_crb_driver must successfully probe this device via
>       tpm_crb_ffa_init().
> 
>    3. The tpm_crb driver using CRB over FF-A can then
>       be probed successfully. (See crb_acpi_add() and
>       tpm_crb_ffa_init() for reference.)
> 
> Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
> all registered with device_initcall, which means crb_acpi_driver_init() may
> be invoked before ffa_init() and tpm_crb_ffa_init() are completed.

I get the ffa_init() part i.e, moving it earlier. However for
tpm_crb_ffa_init() and crb_acpi_driver_init(), modules.dep
takes care that they are loaded in order.

For IMA you will need the driver as built-in but that should
be handled via kernel config, not via code changes.

BR, Jarkko 

