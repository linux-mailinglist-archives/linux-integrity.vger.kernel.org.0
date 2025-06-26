Return-Path: <linux-integrity+bounces-6545-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E91AE9C11
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 13:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C6B1893E83
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 11:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3402750F0;
	Thu, 26 Jun 2025 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiVTXsf1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2E82750EA;
	Thu, 26 Jun 2025 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750935638; cv=none; b=dpB8hms51bZxJJHYl/x38kRdZDnc63TmlL0Mez78yHcdN1rN7xOiE+ZCYdqXmKyJkcXgXDnp5Zrlf1fCL1NjmdM+jqZLJx/vcfBlL8mo40YX0Ju8vpbM2D9LgFC5hGw5ajn5PhU2SPjSErPZ6Ye4weq4Fbgwwow34tU3c3BCSI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750935638; c=relaxed/simple;
	bh=ddNRVKo8K0tfenXyApgTa21tpAnD59RnOxpMdupRAxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiHeZy0GXbxpfT+mLyXyH01voy1eShdxoOfqJ/kMHz+XbRxHGmyg5RNnWtFos/i4sTjWL6VMpP+So5tdOkeRYu+k2+B6yd9Zepc6PCG93Mszvo2nbwigrkFZU3BK6oJXcshqAjo+m3TVYifDTVYFrnJU8JYVZ4jEv439y0HYOS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiVTXsf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AFCC4CEEB;
	Thu, 26 Jun 2025 11:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750935638;
	bh=ddNRVKo8K0tfenXyApgTa21tpAnD59RnOxpMdupRAxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SiVTXsf1FIH/BpKrflB7q9chXI1l7A434+C25VnLr3aj+2QSmJtxziSIpI/CapoZT
	 eG1hU0n1odgZzGlmn1OEPfp0ncwoxX5u+1rDjuj4v4R1sWaFh5vVGY0RH4l4msiMGG
	 oDjjsIS967tTVZvlkHjTbnvg5tEcUHzG+w0eQvkX+bZ2u90O2NGrx7+WsL8of7SXKZ
	 0pzrCC3c9Q8i64Yw+v5mrIaPSCevMBgsCCoCPVHQ4kO2nVsM4DFIqTAB8Jjw9D4xSk
	 jiuYMdeFXlY9MG4lLRN+nBuzqHMOIvx3MhAdOuHfuXDvTRniln6GLMomlzjQuTDw+g
	 PVcIbeAVzSrlg==
Date: Thu, 26 Jun 2025 14:00:34 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, Sudeep Holla <sudeep.holla@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] tpm_crb_ffa: Remove unused export
Message-ID: <aF0oUnrb3t5ZVo1q@kernel.org>
References: <20250626105423.1043485-1-jarkko@kernel.org>
 <2025062651-distress-bagel-3718@gregkh>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025062651-distress-bagel-3718@gregkh>

On Thu, Jun 26, 2025 at 11:58:26AM +0100, Greg KH wrote:
> On Thu, Jun 26, 2025 at 01:54:23PM +0300, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > Remove the export of tpm_crb_ffa_get_interface_version() as it has no
> > callers outside tpm_crb_ffa.
> > 
> > Cc: stable@vger.kernel.org # v6.15+
> 
> Why is this marked for stable trees as a fix?  Seems to just be a normal
> cleanup patch to me, what am I missing?

unintentional, i added it as a reflex (was going to add the fixes tag
for bookmark/reference)

> 
> thanks,
> 
> greg k-h

BR, Jarkko

