Return-Path: <linux-integrity+bounces-5088-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37EDA4F223
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 01:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E59416E2CC
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 00:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC829D530;
	Wed,  5 Mar 2025 00:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6FdZk39"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F1AD515;
	Wed,  5 Mar 2025 00:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133347; cv=none; b=WfdfYjptmWpbX820/bmRJ7Kj3z8Vn+nDUTyzRlXBUuGxALhTKQs2TtNsIBqxEFc3fLGDpDagehX2KkOg2hlY636O3FDj13K2pDHD7nGPKRRTVYhjqMLX3np+Is05s9YBlWey04YunbbNhPsBaAFOEKvY2Wt/7HfF4VNKnaXFpCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133347; c=relaxed/simple;
	bh=A1wa9xVH0h38Q06rD552vhEcw3vJ3zFK0RAmVd0Zcmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyFZInrVIKNS5rady7uERbDLuxHEv4fPPXNMcl63epcW4r3vKl6jWCR2LU7INgkF+tluVGy4YCC4CV1LCbNDCdqtfbcv6G2iCVrSnJJ5c8td8ZvxoTw9YCKm9GhpD42ONFTYE+ceqYE6CGruO6XNUXMuObkSCx0X53AHlxc2iHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6FdZk39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94150C4CEE5;
	Wed,  5 Mar 2025 00:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741133346;
	bh=A1wa9xVH0h38Q06rD552vhEcw3vJ3zFK0RAmVd0Zcmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G6FdZk39QPkgy26sD3kMTQnMm4+L//KzEvvjwi1iJttsxxXtSTyaov4KW9P1bEeu3
	 cekFPcZjrkiUmwK9HNEINTzdNEJjWNqY2mxnMYhhG5qcrR4eCAeK6YnaaWLJQRkQQD
	 VmUkpqmb5yXxmSZ7tlGLoqZF2BD4S29iuF9QkgNKrOSbYffOWdzC0suM1qegrct5aE
	 j2ZJZefJBVow/8ObheD2oxtA4MMzknLAp87vd5ZV9PsM1CIqW3rjgVif17e7HT7cuu
	 6qqjK2gLicPu/r+PKZ68IwpnnSoREwYvnZs1kaNRoUblwWnEnDvcsa5EBoIouCCNFX
	 8PmbgtVyCJiBQ==
Date: Wed, 5 Mar 2025 02:09:01 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-sgx@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arch/x86: Fix size overflows in sgx_encl_create()
Message-ID: <Z8eWHVEoYeNHSgO6@kernel.org>
References: <20250305000602.127665-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305000602.127665-1-jarkko@kernel.org>

On Wed, Mar 05, 2025 at 02:06:02AM +0200, Jarkko Sakkinen wrote:
> The total size calculated for EPC can overflow u64 given the added up page
> for SECS.  Further, the total size calculated for shmem can overflow even
> when the EPC size stays within limits of u64, given that it adds the extra
> space for 128 byte PCMD structures (one for each page).
> 
> Address this by pre-evaluating the micro-architectural requirement of
> SGX: the address space size must be power of two. This is eventually
> checked up by ECREATE but the pre-check has the additional benefit of
> making sure that there is some space for additional data.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-sgx/c87e01a0-e7dd-4749-a348-0980d3444f04@stanley.mountain/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Cc: stable@vger.kernel.org # v5.11+
Fixes: 888d24911787 ("x86/sgx: Add SGX_IOC_ENCLAVE_CREATE")

BR, Jarkko

