Return-Path: <linux-integrity+bounces-6094-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3DCAA5048
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 17:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946054C8562
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 15:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC2B20E313;
	Wed, 30 Apr 2025 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Twj3YLxb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6420617BEBF;
	Wed, 30 Apr 2025 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746027135; cv=none; b=j1aLbUr6b2ctnhjJAr+JX4MOrFrwwY1+S3jSakObHZaYO1r7jeZNMRmiIvinzA80r/SfVKISqjOnvWLn/lvNuMFtOMkj6U5eL8irJ8CeiDMwKzOvd9uNes75jyQNKyHuX8/P4KGU63JLKlALPDp7gmlpAfesQVx4kRFlXPa1Nms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746027135; c=relaxed/simple;
	bh=TOlaDEhwkOFI70NQ/ZbAkugkKh7xf2VdAaYL/4f/vAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMd9nkXCbsbzNLJOf+oKc3RrxZyAJDbmv64N9WLF5eLgf6h5rwFJGgJUYP1k8jugSXzJGRkcnC1YsIo9GvEaonJIl0cPfE3FeNANkRG8iYwoNS2fMriVo+MphJguZXej1XAS7fZyAw6hrSl4DxqwetvOCwQN6ReckZHggCsh1mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Twj3YLxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AC8C4CEE7;
	Wed, 30 Apr 2025 15:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746027135;
	bh=TOlaDEhwkOFI70NQ/ZbAkugkKh7xf2VdAaYL/4f/vAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Twj3YLxbD417cEJce1YitFNtIJ0T4/s3BujWJ6+nocXwEvU4yjC/a5NNYsTEdIbew
	 eXN3QSHFYiUwuMdbB4vUbyKxMAoNnsqdbTsirhUd4G7eUsKA/7RJv+CeRyup2r72m2
	 TUVAlDzcXbhtxkB14YbbUy7RK3bMA0Yvsah8u4Rqnvtvk3K88pXGljlGMTYnORUfYm
	 xEXeiSGtxdfMzC9CrPcKMXz/ykaUpcpOpl+ThtpK9IjjuwB2PeoQU8qjAHlFQltbHm
	 JRXsnKuLkQAYrVq9cZCw9z1rgvZoVH3gl827GHeQW8Nm0M0KoyTc2Nw0Y11XqMd9D6
	 lVYzGxxgaFc6g==
Date: Wed, 30 Apr 2025 18:32:10 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm_crb: ffa_tpm: fix cut/paste error in comment
Message-ID: <aBJCeoapwgdaPONq@kernel.org>
References: <20250429221519.1022170-1-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429221519.1022170-1-stuart.yoder@arm.com>

On Tue, Apr 29, 2025 at 05:15:17PM -0500, Stuart Yoder wrote:
> Fix the comment for the 'start' function, which was a cut/paste
> mistake for a different function.
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> ---
>  drivers/char/tpm/tpm_crb_ffa.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> index 3169a87a56b60..65b01a46d4b88 100644
> --- a/drivers/char/tpm/tpm_crb_ffa.c
> +++ b/drivers/char/tpm/tpm_crb_ffa.c
> @@ -68,7 +68,8 @@
>  #define CRB_FFA_GET_INTERFACE_VERSION 0x0f000001
>  
>  /*
> - * Return information on a given feature of the TPM service
> + * Notifies the TPM service that a TPM command or TPM locality request is
> + * ready to be processed, and allows the TPM service to process it.
>   * Call register usage:
>   * w3:    Not used (MBZ)
>   * w4:    TPM service function ID, CRB_FFA_START
> -- 
> 2.34.1
> 

Can you squash the comment updates into single patch instead and
enumerate the changes? Does not really serve any purpose because
comments do not "run".

BR, Jarkko

