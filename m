Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632FF34F708
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Mar 2021 04:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhCaCzx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Mar 2021 22:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233291AbhCaCz3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Mar 2021 22:55:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE9B5619D6;
        Wed, 31 Mar 2021 02:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617159329;
        bh=CeP0VvhfD5jRKipKfgRTMCR59h0WViNfjZ1mQ5IK8w4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eimKdz3PK1hkrIri4gAiAtvqV18EMoJlPdlWloYhc/TPui6tJsTK3PpTBm+CiJry6
         Ie3hOqTCVMFGOm/pl/KvSY1XY9wC0y/pbzkLpG2iirfLiZ4b56S/kVEJdhIqcIUEU1
         20Bnnf/9HC+R/vlSW6wiFYBRFsb0JTdHZ4bS9SJO2zh/Wb6Yi1G50Z/bJmRmGAp5Z4
         Y8q9+rlzGBZaco2L0dl3HnyFV8oC0JUvYSLad8PMfpk95iwNjNV7Tcv7MJTwkFX9DQ
         PJ2GVjlpdWESIyqW7XTUo/W2UacgfQzbp/C7ODNIESwp2kpvy9X89eYVnhr5fq5ODi
         v3Nh341f7o3pA==
Date:   Wed, 31 Mar 2021 05:55:26 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3 1/3] keys: cleanup build time module signing keys
Message-ID: <YGPkngIlvLxz4xYA@kernel.org>
References: <20210330131636.21711-1-nayna@linux.ibm.com>
 <20210330131636.21711-2-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330131636.21711-2-nayna@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 30, 2021 at 09:16:34AM -0400, Nayna Jain wrote:
> The "mrproper" target is still looking for build time generated keys in
> the kernel root directory instead of certs directory. Fix the path and
> remove the names of the files which are no longer generated.
> 
> Fixes: cfc411e7fff3 ("Move certificate handling to its own directory")
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index d4784d181123..b7c2ed2a8684 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1523,9 +1523,9 @@ MRPROPER_FILES += include/config include/generated          \
>  		  debian snap tar-install \
>  		  .config .config.old .version \
>  		  Module.symvers \
> -		  signing_key.pem signing_key.priv signing_key.x509	\
> -		  x509.genkey extra_certificates signing_key.x509.keyid	\
> -		  signing_key.x509.signer vmlinux-gdb.py \
> +		  certs/signing_key.pem certs/signing_key.x509 \
> +		  certs/x509.genkey \
> +		  vmlinux-gdb.py \
>  		  *.spec
>  
>  # Directories & files removed with 'make distclean'
> -- 
> 2.29.2
> 
> 



Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
