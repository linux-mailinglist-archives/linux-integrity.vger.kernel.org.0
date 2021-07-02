Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BCE3B9C61
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jul 2021 08:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhGBGwu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Jul 2021 02:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhGBGwt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jul 2021 02:52:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B348061413;
        Fri,  2 Jul 2021 06:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625208616;
        bh=o+phWmQp9hkxTI4UpBQ/lXbHLrZIIqcGKXHa40ptZ2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SN+CHPU066BMSWA49opSuDUyuyOZhwved+Tt798IBKCSm2/iR7Z4JZncEzzEWN4Kf
         6DcY4nKp4IYPLWuBlRY8lE9eslrploAADH4kgHKzDKP4rFfBwlrFyD9RlpOeu3NS9O
         TKrcM9fKc9m/l9DPEciZrU+e15meZsxeCcAKSfUvbE1G7xazaeAhP2sJ0IwTaWGgr3
         JHO3RjwfpxyJ8ezFLDx/pdVADG1VTUZMJ6RduIWm6OQ1DVwA76tXF4hfqflwqxLHTw
         UyEX2wPZDs3G7YNss8WjFjhk6tcTz4Xw9++n1PGxLDFTCwUnqx3vipQtDrtFMBeJgM
         6i7V3XZSmLnSQ==
Date:   Fri, 2 Jul 2021 09:50:13 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v8 0/2] Add support for ECDSA-signed kernel modules
Message-ID: <20210702065013.ywu2a7u5vbo4o3mu@kernel.org>
References: <20210629213421.60320-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629213421.60320-1-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 29, 2021 at 05:34:19PM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> This series adds support for ECDSA-signed kernel modules. It also
> attempts to address a kbuild issue where a developer created an ECDSA
> key for signing kernel modules and then builds an older version of the
> kernel, when bisecting the kernel for example, that does not support
> ECDSA keys.
> 
> The first patch addresses the kbuild issue of needing to delete that
> ECDSA key if it is in certs/signing_key.pem and trigger the creation
> of an RSA key. However, for this to work this patch would have to be
> backported to previous versions of the kernel but would also only work
> for the developer if he/she used a stable version of the kernel to which
> this patch was applied. So whether this patch actually achieves the
> wanted effect is not always guaranteed.
> 
> The 2nd patch adds the support for the ECSDA-signed kernel modules.
> 
>   Stefan
> 
> v8:
>   - Removed R-b tags and reordered Cc tags
> 
> v7:
>   - Changed Kconfig reference to kernel version from 5.11 to 5.13
>   - Redirecting stderr of openssl to NULL device to address kernel robot
>     detected issue
>   - Replaced $(CONFIG_MODULE_SIG_KEY) with "certs/signing_key.pem" following
>     Linus's suggestion
> 
> v6:
>   - Patch 2/4 is fixing V4's 1/2 and 4/4 is fixing V4's 2/2. Both fixup
>     patches to be squashed.
> 
> v5:
>   - do not touch the key files if openssl is not installed; likely
>     addresses an issue pointed out by kernel test robot
> 
> v4:
>   - extending 'depends on' with MODULES to (IMA_APPRAISE_MODSIG && MODULES)
>   
> v3:
>   - added missing OIDs for ECDSA signed hashes to pkcs7_sig_note_pkey_algo
>   - added recommendation to use string hash to Kconfig help text
> 
> v2:
>   - Adjustment to ECDSA key detector string in 2/2
>   - Rephrased cover letter and patch descriptions with Mimi
> 
> 
> Stefan Berger (2):
>   certs: Trigger creation of RSA module signing key if it's not an RSA
>     key
>   certs: Add support for using elliptic curve keys for signing modules
> 
>  certs/Kconfig                         | 26 ++++++++++++++++++++++++++
>  certs/Makefile                        | 21 +++++++++++++++++++++
>  crypto/asymmetric_keys/pkcs7_parser.c |  8 ++++++++
>  3 files changed, 55 insertions(+)
> 
> -- 
> 2.31.1
> 
> 

LGTM

For both:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
