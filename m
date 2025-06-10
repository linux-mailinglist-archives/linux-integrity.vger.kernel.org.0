Return-Path: <linux-integrity+bounces-6392-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CC9AD36C1
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 14:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9616179619
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 12:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8022957C6;
	Tue, 10 Jun 2025 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLy814kH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472442951B1;
	Tue, 10 Jun 2025 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558924; cv=none; b=RmibWVPf+V5/3aP25FN83V3a4bC1DoMxou5gQnn0QBjS7ha1A+/dN4ISvVUSDiXBPgPVipxe9/HDK/cC3dkTss0S2FJVbPRxebRgxQk5pqjIBu/lfM6VfFpOcnYOcNanDaR9a8YX3uxcymwZh83C8zuqJdIDMBlkoE7H4FtSRp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558924; c=relaxed/simple;
	bh=CSmYS/pEFaVijBjHY+AHpQU5O1e+HZuwLLbg9pOH0U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URgwf8dXlSsBqKSGwRPOwc/KA6S31mOnV8umZEK8YAGmOm1v5TTqBTnM4g1Li3tWf2GSYb87Suo2TYiXupwloTCTBGRc4b9lcQL8kP8/DHN0Uvfv2S1/AmJ87vhXZznzoDz8HqDF3HTZs3N/hOiKpFs+a7ufVEtRK6eEUG2LhP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLy814kH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F17C4CEED;
	Tue, 10 Jun 2025 12:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749558923;
	bh=CSmYS/pEFaVijBjHY+AHpQU5O1e+HZuwLLbg9pOH0U0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cLy814kHt42+XDyorgdKuhyW4Kp9DnDA1Yj7xT5s0OTL8tQtGZCvJPaPuY+r3W3BD
	 AlgG3tryBBHPYzAnqZTGCLIf+VKJ98RGPtseBnslkqZ8wh9NNBnwQjF5Wnc/MNAInH
	 tstKUA+jlZo0X3EUr/A6M2gS5zWsJPyfPNvOLlODu8fNs5KuX/lXGM/YZvRehytEhI
	 6AMRMIVO90DWDla+Jp6LbN48mJ17GDGMFl78vNI1+JS4dVmQ/oJFtvUx6tluRUsYtK
	 L4c6GdcyjV7ncWDm0WDpoteQjZR3ObVBaIzpraIFybRL6BKKlhnC7lGuYpUI+U2jH/
	 bAflbXLO0z0sA==
Date: Tue, 10 Jun 2025 15:35:19 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fix failure of integration IMA with tpm_crb_ffa
Message-ID: <aEgmhwu1RP27yBpw@kernel.org>
References: <20250610060334.2149041-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610060334.2149041-1-yeoreum.yun@arm.com>

On Tue, Jun 10, 2025 at 07:03:32AM +0100, Yeoreum Yun wrote:
> To integrate a TPM device that uses CRB over FF-A with the IMA subsystem,
> both the tpm_crb and tpm_crb_ffa drivers must be built as built-in
> (i.e., ARM_FFA_TRANSPORT=y, CONFIG_TCG_CRB=y, and CONFIG_TCG_CRB_FFA=y),
> because IMA itself is built-in and the TPM device must be probed
> before ima_init() is invoked during IMA subsystem initialization.

The description of the problem and motivation to solve it should be
first; not the actions taken.

> 
> To ensure this works correctly, the following initcalls must be executed in order:
> 	1.	ffa_init()
> 	2.	tpm_crb_ffa_driver_init()
> 	3.	crb_acpi_driver_init()
> 
> Unfortunately, the order of these device initcalls cannot be strictly controlled.
> As a result:
> 	1.	ffa_init() may be called after tpm_crb_ffa_driver_init()
> 	2.	tpm_crb_ffa_driver_init() may be called after crb_acpi_driver_init()
> 
> For example, the following initcall sequence may occur:
>   0000000000000888 l  .initcall6.init>  crb_acpi_driver_init
>   000000000000088c l  .initcall6.init>  tpm_crb_ffa_driver_init

This symbol does not exist.

>   0000000000000a9c l  .initcall6.init>  ffa_init
> 
> In this situation, the IMA subsystem fails to integrate with the TPM device
> because the TPM was not available at the time ima_init() was called.
> As a result, you may see the following message in the kernel log:
> 
>   | ima: No TPM chip found, activating TPM-bypass!

TPM initializes before IMA, so there should not be a problem.

BR, Jarkko

