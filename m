Return-Path: <linux-integrity+bounces-5835-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E85EA85A57
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 12:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65912176CC4
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 10:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C8A204581;
	Fri, 11 Apr 2025 10:43:36 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4127278E64;
	Fri, 11 Apr 2025 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744368216; cv=none; b=fbuLz5nLwu3MI5bl5k8uXgNKKTM5RxyGfAAmSNESQFdLi4GAuiBcPA+sLNQlKf4WAg4211FVQwZwEMg3+T+AfjzTInFiimO6W/bKRVxXo5hjXdk0jmraNpYGnCpRSusDVePgqISDhOWMc0w5r0L1kC2BXYltZvykGooKOjFFfuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744368216; c=relaxed/simple;
	bh=TY4BcYnPfrKFA2/AVV1qhzSrSnSVkHMrc911GcJujzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFPz2lDtBkYjQq0mOHIG6+xOeZmZl7J+7ONSXvdMIpIZf78iPXJPzoXtVKnhoj5AmoSqJClS0BffOiKwoGGnLzmY1ltlwa93T5wBAZtbF6Sk5I8mr6BFFRZHqCuuEtLs3KE6PXK/mPTfZduX9ZBzHPElTkvzWOLUFkVK4mPGYnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77F3D106F;
	Fri, 11 Apr 2025 03:43:28 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 492143F59E;
	Fri, 11 Apr 2025 03:43:27 -0700 (PDT)
Date: Fri, 11 Apr 2025 11:43:24 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, peterhuewe@gmx.de, jgg@ziepe.ca,
	Sudeep Holla <sudeep.holla@arm.com>, stuart.yoder@arm.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm_ffa_crb: access tpm service over FF-A direct
 message request v2
Message-ID: <20250411-glittering-cerulean-scallop-ddfdaa@sudeepholla>
References: <20250411090856.1417021-1-yeoreum.yun@arm.com>
 <Z_jw6z_2k0vzqyK_@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_jw6z_2k0vzqyK_@kernel.org>

On Fri, Apr 11, 2025 at 01:37:31PM +0300, Jarkko Sakkinen wrote:
> On Fri, Apr 11, 2025 at 10:08:56AM +0100, Yeoreum Yun wrote:
> > For secure partition with multi service, tpm_ffa_crb can access tpm
> > service with direct message request v2 interface according to chapter 3.3,
> > TPM Service Command Response Buffer Interface Over FF-A specification [0].
> > 
> > This patch reflects this spec to access tpm service over
> > FF-A direct message request v2 ABI.
> > 
> > Link: https://developer.arm.com/documentation/den0138/latest/ [0]
> 
> Sorry, did not notice in the first round:
> 
> 1. Does not have "[0]" postfix.
> 2. Only for lore links:
>    https://www.kernel.org/doc/html/v6.12/maintainer/configure-git.html#creating-commit-links-to-lore-kernel-org 
> 

I was about to comment on the presence of link itself but left it to
the maintainer. It was part of the first commit log from Stuart. If it
is so important that it requires mention in each commit, it better me
made part of the file itself to avoid having to mention again and again.
Just my opinion, I leave it to the maintainers.

-- 
Regards,
Sudeep

