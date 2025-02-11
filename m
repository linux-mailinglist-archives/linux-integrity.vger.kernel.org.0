Return-Path: <linux-integrity+bounces-4786-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A99D2A3175D
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2025 22:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DF43AA543
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2025 21:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAED26D5A9;
	Tue, 11 Feb 2025 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHhH+6io"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977426B2DD;
	Tue, 11 Feb 2025 21:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308135; cv=none; b=s6y2/+FfJAL5NcXahf73aRPyB9nr8O7nrVM+TZy2M/N3hublwMPnEXL0ICCiwm8WZLhHlAUHkSurnL9eAOYfHkoZf5B9EqYhu1wbwKOddkQu2XEHmxdmqk7XfIto4jwHrfM60b21WgQBL4GQfKKJm22GdqAFFFHXLwhODUuC/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308135; c=relaxed/simple;
	bh=7HTPGAR48CRJjzHVBoG77n4rmyS/GxYTOxsXPhVkzho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7FC3/yKKY3xgmF62lqcs8C5eT6v06sTWZvzL/uaQk2Yv4MNq/A4i8ermB7y+rC08ARJJlulFPWMs9TuM/HFB67/8uPHVQ+AMERvCngIZ+2K2Rf90pEVj5GqWKdcdOq6QTU5MI15kDuOZtFSCdfO5ezbzQR6aah3CU/PfRBBPSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHhH+6io; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF599C4CEDD;
	Tue, 11 Feb 2025 21:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739308134;
	bh=7HTPGAR48CRJjzHVBoG77n4rmyS/GxYTOxsXPhVkzho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHhH+6io4Up/8fGx8BLwl7OMTe03HpALiGJXH3E6TkaOZ/PMEJC/adrYDD1ArWWh6
	 cNFr2shyPONMl2VxULJJAgjqVPT1SiAuDWrzmBrMmuuZj2SznGilJAC2HUAHLyBOPN
	 u0+2fxoDY0NQKM6V2eZ+3WtxLMAXil1ye/45tqGs1G8rBz4h+Bdksg0CnKYamDj9KE
	 eookp+Qep3mg0nYltyrjeST7rmYf/lmUK47Z1fEgfqvicH9SEGKbpwFHWvM/udV/Qx
	 F1YHBFciC5dEQuiZdHL3SeZIA3nkSqIHFAMHB3bWaf9tVtNiuBGLX0edMEPzSgAFd6
	 YtYjxy59s7mGA==
Date: Tue, 11 Feb 2025 23:08:49 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] tpm_crb: implement driver compliant to CRB over FF-A
Message-ID: <Z6u8Yb-NIs0_v2gm@kernel.org>
References: <20250210232227.97761-1-stuart.yoder@arm.com>
 <20250210232227.97761-2-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210232227.97761-2-stuart.yoder@arm.com>

On Mon, Feb 10, 2025 at 05:22:24PM -0600, Stuart Yoder wrote:
> The Arm specification TPM Service CRB over FF-A specification
> defines the FF-A messages to interact with a CRB-based TPM
> implemented as an FF-A secure partition.
> 
> Spec URL:
> https://developer.arm.com/documentation/den0138/latest/
> 
> This driver is probed when a TPM Secure Partition is
> discovered by the FF-A subsystem. It exposes APIs
> used by the TPM CRB driver to send notifications to
> the TPM.
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> ---
>  drivers/char/tpm/Kconfig   |   9 ++
>  drivers/char/tpm/Makefile  |   1 +
>  drivers/char/tpm/ffa_crb.c | 310 +++++++++++++++++++++++++++++++++++++
>  drivers/char/tpm/ffa_crb.h |  30 ++++

Let's use tpm_ prefix for these.

BR, Jarkko

