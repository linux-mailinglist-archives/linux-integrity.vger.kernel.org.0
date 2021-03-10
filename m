Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A283334C2C
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Mar 2021 00:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhCJXFh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Mar 2021 18:05:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232181AbhCJXFQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Mar 2021 18:05:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FD2C64FC3;
        Wed, 10 Mar 2021 23:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615417516;
        bh=XyxscAGqJqN5bwT0S+ApXaeaQO6zY8Mh7SZCMy4y92Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B1WBa10526PGTQqZ+BZNjcYDgBeC4olep5iBLxBSByjMfN/9bFhGwiTK/0Qk8HEFM
         zAlk1CwuCqi9rOa9RGN0xBzT3CZH3SMH5UTCvb4zI3A25muWOGBCPx9d74RFeHjrtS
         lDHtU4K2jSvmGm3Rh8M+vxLPPS3X1ew06NZ4HlpV1Cp5SmrksjU4Mi2Z/IvBOIiorf
         CKlj7wPpi5pmrVMdhNBKHyGtuJNgI4wZci/msl0/YwqlxwZ0bwvpvE1BFUhO9b/vfW
         +dnyRdAH+H4x+Gf0O7fsdZQb5kpUZknrKYxRJ+ftybX507mLG3go60az8EyHwRMoZm
         piLHU88BVVHTw==
Date:   Thu, 11 Mar 2021 01:04:52 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] tpm: vtpm_proxy: Avoid reading host log when
 using a virtual device
Message-ID: <YElQlDGQI8sx2Igz@kernel.org>
References: <20210310221916.356716-1-stefanb@linux.ibm.com>
 <20210310221916.356716-4-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310221916.356716-4-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 10, 2021 at 05:19:16PM -0500, Stefan Berger wrote:
> Avoid allocating memory and reading the host log when a virtual device
> is used since this log is of no use to that driver. A virtual
> device can be identified through the flag TPM_CHIP_FLAG_VIRTUAL, which
> is only set for the tpm_vtpm_proxy driver.
> 
> Fixes: 6f99612e2500 ("tpm: Proxy driver for supporting multiple emulated TPMs")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/eventlog/common.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/char/tpm/eventlog/common.c b/drivers/char/tpm/eventlog/common.c
> index 7460f230bae4..8512ec76d526 100644
> --- a/drivers/char/tpm/eventlog/common.c
> +++ b/drivers/char/tpm/eventlog/common.c
> @@ -107,6 +107,9 @@ void tpm_bios_log_setup(struct tpm_chip *chip)
>  	int log_version;
>  	int rc = 0;
>  
> +	if (chip->flags & TPM_CHIP_FLAG_VIRTUAL)
> +		return;
> +
>  	rc = tpm_read_log(chip);
>  	if (rc < 0)
>  		return;
> -- 
> 2.29.2
> 
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>


/Jarkko
