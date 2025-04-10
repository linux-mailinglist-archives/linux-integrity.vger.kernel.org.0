Return-Path: <linux-integrity+bounces-5755-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E0CA83DA9
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 10:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217398A74E1
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 08:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F36A20B812;
	Thu, 10 Apr 2025 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaBG4o7M"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DA7204594;
	Thu, 10 Apr 2025 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275295; cv=none; b=OZlu3fzPhHDFK9px2Z2p0AxR+jitvSquXwYg3EyhiGFftWzbZdNFbIbWzs7xKKcjhW3wDqfOoyTxM/ybbQdAREgXDYqFGDSP7IMthJXnof6BlPFRHphW9GbhLWZtgYgtHNmsz9dVfL1ZaiVrwvsNS3bh2Y/CUX4tFQYNOZU+ad0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275295; c=relaxed/simple;
	bh=ptkcX70U257+g8/2Wk2uzcpQkIuZva6w5Z/vSCmd3dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ayb0mXuYNh4wTEC+33VRwYrVokANFxE1OECtSn91ETYQZdtf/gQpgHkBC8uT+K1vml5i222OvncflBhoqGhHxqjdDU4/FkBEp7sBPcD+0/HjbA9zZUObu/zXysdB/GUfce50eZaMGXc0Sa7Fzpvl1FoPuUCgzE7RMykhZHKgM58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaBG4o7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE13C4CEDD;
	Thu, 10 Apr 2025 08:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744275294;
	bh=ptkcX70U257+g8/2Wk2uzcpQkIuZva6w5Z/vSCmd3dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SaBG4o7MMRpxmUfGavVb/hFtx+qdk/ZMF2zUBJc9laLjAQ1+059V5ont6nA2Lbnyx
	 GwxtqHMGsm7QY7sUqM/3pSZlvY27DX6mIeU67mkl8s2YImXL+aRkZMMxNFH5L1l0f1
	 tv0rG+DZyHFyoK1HEtOeqWah2KiBoY73VD+pQ2hDrjCeSUJamMBdfBjX/VWFMfBMcE
	 P/TNup9aSNe80zbItP3vNK6VprtEV5dkbnI03zk25fmk9J6IoYB1kodsVNItAF5ylk
	 RPSRq2p4hdI5kzLhMExbaSvgihNdkt+tnX0ggsoRXfXnKC1qNXkngDFdMRRosXLNFR
	 RoAnbkzN3qWQg==
Date: Thu, 10 Apr 2025 11:54:50 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Purva Yeshi <purvayeshi550@gmail.com>, peterhuewe@gmx.de, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: tpm: tpm-buf: Fix uninitialized return values in
 read helpers
Message-ID: <Z_eHWkSdhfOHxiNe@kernel.org>
References: <20250409205536.210202-1-purvayeshi550@gmail.com>
 <Z_dh4tRIa6xxAWQ2@kernel.org>
 <t2ri7facyvtmt6rx6xwcjos7rgtyiln7cywl2gt4effgukeejc@f3ml4apdh4zs>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t2ri7facyvtmt6rx6xwcjos7rgtyiln7cywl2gt4effgukeejc@f3ml4apdh4zs>

On Thu, Apr 10, 2025 at 09:51:09AM +0200, Stefano Garzarella wrote:
> On Thu, Apr 10, 2025 at 09:14:58AM +0300, Jarkko Sakkinen wrote:
> > On Thu, Apr 10, 2025 at 02:25:36AM +0530, Purva Yeshi wrote:
> > > Fix Smatch-detected error:

Empty line and s/error/issue/.

> > > drivers/char/tpm/tpm-buf.c:208 tpm_buf_read_u8() error:
> > > uninitialized symbol 'value'.
> > > drivers/char/tpm/tpm-buf.c:225 tpm_buf_read_u16() error:
> > > uninitialized symbol 'value'.
> > > drivers/char/tpm/tpm-buf.c:242 tpm_buf_read_u32() error:
> > > uninitialized symbol 'value'.
> > > 
> > > Call tpm_buf_read() to populate value but do not check its return
> > > status. If the read fails, value remains uninitialized, causing
> > > undefined behavior when returned or processed.
> > > 
> > > Initialize value to zero to ensure a defined return even if
> > > tpm_buf_read() fails, avoiding undefined behavior from using
> > > an uninitialized variable.
> > 
> > How does tpm_buf_read() fail?
> 
> If TPM_BUF_BOUNDARY_ERROR is set (or we are setting it), we are effectively
> returning random stack bytes to the caller.
> Could this be a problem?

It should never happen, if the kernel is working correctly. The commit
message implies a legit failure scenario, which would imply that the
patch is a bug fix, which it actually is not.

"Add a sanity check for boundary overflow, and zero out the value,
if the unexpected happens" is what this patch actually does. I.e.,
code change acceptable, commit message is all wrong.

> 
> If it is, maybe instead of this patch, we could set `*output` to zero in the
> error path of tpm_buf_read(). Or return an error from tpm_buf_read() so
> callers can return 0 or whatever they want.
> 
> Thanks,
> Stefano
> 
> 

BR, Jarkko

