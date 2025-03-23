Return-Path: <linux-integrity+bounces-5400-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6785CA6D10C
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 21:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390F37A61A8
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 20:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093881422DD;
	Sun, 23 Mar 2025 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkoccYn9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4D53B1A4;
	Sun, 23 Mar 2025 20:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742762152; cv=none; b=aaQZQRliO7mUhWL32YYCRjxMLvuq9tV6oplLgI+J7Z8z4hSMCq/3ZvOaR6EkzWORVVzKjIdTZqsLnMx04erShKAXGcJf1NmHOARDUh4uWOx+27UbyZ4800TPIdf+fLK5EiXYn9gyZIwMIt63NTBjmwtF4CdHY921x0SCykwVZas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742762152; c=relaxed/simple;
	bh=xHXZy8w9I0XLOj4xlizPUlTNg89hck9OKd3WPhMQbRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjv3zoDdKJUoctvHPWHJYG1LiwP8DpmfyTDloFthrCt1+WWdzutmj7mEqinhax5zXDjpvPD53K6AiJHdqf3UPl3Q+1E1oOjSTQZbbEVYespafBI+GuaIxmR78wvBWFZBDNaCF/Bzdy1piPWRBo5pdrZ6geB1KmGvJS4N5Mumwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkoccYn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2621C4CEE2;
	Sun, 23 Mar 2025 20:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742762152;
	bh=xHXZy8w9I0XLOj4xlizPUlTNg89hck9OKd3WPhMQbRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZkoccYn9iIrnnlLXqjtafwV9zsCmc0ozjZtyQUhSKYUbChF9wxU/j/wm2oCukWkHT
	 p4XX8xe8UG+WG9GODgGVSq9yBKEpoR3TGtSHtV6NpQ8ZEiUUO6fXklLTzoxPTMtvtS
	 nVoa6/Yqk2RemzQNBcQ/cSF9Be9OtkJ04BC2i3xyg/HnUgnhbM7vYJIyOr+BQqagZQ
	 R8H7VRsYxis1fcGJ2Qsg5zathbThPxtljSZibljavLOZRtJ+yJ7IOtyUYpYuhqVy1i
	 iIIZPehScuXcxwDxbf0C5QxB7lLhQ5F6rL8ISpEZGukZn4n2H+msmjHJFan8LmqPzt
	 9bIhLX4oyOXKA==
Date: Sun, 23 Mar 2025 22:35:47 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Nicolai Stange <nstange@suse.de>
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 10/13] tpm: authenticate tpm2_pcr_read()
Message-ID: <Z-Bwo_ZHwYDgwh0X@kernel.org>
References: <20250323140911.226137-1-nstange@suse.de>
 <20250323140911.226137-11-nstange@suse.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323140911.226137-11-nstange@suse.de>

On Sun, Mar 23, 2025 at 03:09:08PM +0100, Nicolai Stange wrote:
> PCR reads aren't currently authenticated even with CONFIG_TCG_TPM2_HMAC=y
> yet.
> 
> It is probably desirable though, as e.g. IMA does some PCR reads to form
> the cumulative boot digest subsequently extended into PCR 10 (an operation
> which *is* authenticated).
> 
> Furthermore, a subsequent patch will make IMA to skip certain PCR bank
> re-invalidations (which are implemented with extensions) upon kexec based
> on the value read back at boot. In order to not weaken the overall
> security posture in this case, it will be required to establish the same
> level of trust into PCR reads as there is already for the extensions.
> 
> Make tpm2_pcr_read() to protect the command with a HMAC auth session,
> using the already existing infrastructure.
> 
> As the TPM2_PCR_Read command doesn't have any authorizations defined, and
> neither of TPM2_SA_ENCRYPT/TPM2_SA_DECRYPT is needed, use TPM2_SA_AUDIT,
> even though no auditing functionality is actually being required. Since
> the TPM will set TPM2_SA_AUDIT_EXCLUSIVE in its response with this
> single-use session, set it upfront so that tpm_buf_check_hmac_response()
> would expect it for the HMAC verification.
> 
> Now that tpm2_pcr_read() depends on the driver's session infrastructure,
> note that the first call to tpm2_pcr_read() at init time gets issued from
>   tpm_chip_bootstrap() -> tpm_get_pcr_allocation()
>   -> tpm2_get_pcr_allocation() -> tpm2_init_bank_info()
>   -> tpm2_pcr_read()
> after
>   tpm_chip_bootstrap() -> tpm_auto_startup() -> tpm2_auto_startup()
>   -> tpm2_sessions_init(),
> so there won't be any issues with that.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>

Please write a better commit message. There's extra words like 'yet'.

And e.g., subsequent patch means nothing in the commit log.  Please
don't use such terminology.

Not going to waste my life reading this.

BR, Jarkko 

