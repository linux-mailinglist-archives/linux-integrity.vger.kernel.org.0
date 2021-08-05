Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561473E1D99
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Aug 2021 22:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241287AbhHEUxC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Aug 2021 16:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241284AbhHEUxC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Aug 2021 16:53:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47C0261102;
        Thu,  5 Aug 2021 20:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628196767;
        bh=BeWYLMUrrmLWzoTZWyTo9bGckBDYYCkOj7hXsiV9Rmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u8dszIoVqiBB0dGuelE8qpsNcM1nbpxPR5QsHwkwH961qwBBt7ZqWh0+lSwTfxwfb
         pngu2gni6ByJ9t1GNOVErD9WXrEVT9fzewUMaI7TDISDH94PQyoG0xIk0si4CCaeZs
         TFJE34t6FMFUr51WfCDSYp5B/qQL5Yf9ZrGp4fkbCqvjaYrmKCGqVAH+iesLqat40N
         txefQDZWHPetUPhLZeCLBJ+6iOgZl1EOSoisBKCuyIitJ2QYXHAOp/JrLXY+GA0LF5
         f9f5MLyk07gZucjlPC1iBZYKFmlIlsHpYnNdsNaKZOxW/RxcUcYD13YuMBzbte31Lv
         r0YU/0XMNjtFQ==
Date:   Thu, 5 Aug 2021 23:52:45 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Borys Movchan <borysmn@axis.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        kernel@axis.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tpm: Add Upgrade/Reduced mode support for TPM2 modules
Message-ID: <20210805205245.qcdqcuog7zmsp7j5@kernel.org>
References: <20210804162132.24786-1-borysmn@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804162132.24786-1-borysmn@axis.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 04, 2021 at 06:21:31PM +0200, Borys Movchan wrote:
> If something went wrong during the TPM firmware upgrade, like power
> failure or the firmware image file get corrupted, the TPM might end
> up in Upgrade or Failure mode upon the next start. The state is
> persistent between the TPM power cycle/restart.
> 
> According to TPM specification:
>  * If the TPM is in Upgrade mode, it will answer with TPM2_RC_UPGRADE
>    to all commands except Field Upgrade related ones.
>  * If the TPM is in Failure mode, it will allow performing TPM
>    initialization but will not provide any crypto operations.
>    Will happily respond to Field Upgrade calls.
> 
> The fix changes the behavior of the `tpm2_auto_startup` function, so
                                
In commit messages, you ought to use imperative form:

"Change the behaviour of tpm2_auto_startup(), ..."

> it tries to detect what mode TPM is running in. If the chip is in the
> Upgrade or Failure mode, the function returns -EIO error code which
> can be used later to adjust driver behavior later.

*How* tpm2_auto_startup() detects the mode?

> After `tpm_chip_register` calls `tpm2_auto_startup` it checks for the

Please remove all these hyphens. They make the commit message a pain
to read. E.g. instead write tpm_chip_register(). This is not Github.

> error code. If the TPM is in Upgrade or Failure mode, set the
> `limited_mode` flag. The calls to `tpm2_get_cc_attrs_tbl`,
> `tpm_add_hwrng` and `tpm_get_pcr_allocation` will fail if the TPM is
> in Failure or Upgrade mode, so use `limited_mode` flag to exclude
> them from the module initialization sequence.
> 
> Signed-off-by: Borys Movchan <borysmn@axis.com>
> ---
> 
> Notes:
>     Commit message updated

v2:
* Commit message updated.

Notes would be something that had existed already in the first version.
Here we want a simple change log.

/Jarkko
