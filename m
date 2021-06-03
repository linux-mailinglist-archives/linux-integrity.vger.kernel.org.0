Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08166399AF6
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jun 2021 08:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFCGtZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Jun 2021 02:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhFCGtZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jun 2021 02:49:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 977A9613B4;
        Thu,  3 Jun 2021 06:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622702861;
        bh=whQ5awbfuf7TtbPdUWFwRctWP18k3gRZdJxFleFXT4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BcWqz17SJhPIKm5LyoKTIC46oMedZf+LuOoFcwvZMgK6dNeENmuU385rSWx2VQdEf
         jBD7i9H7C1Tvy0CKuWnCmoxNNYxa69AYDYbQ+aE1fNZO6+FZ2iQYrY0S7qpRlDd97R
         gpuQfP8s9bENHKxQxKMJb6+q44LvXoG//md61u3rSjMW5d1mxXr+DvA1uP3A18Ybqp
         pFDR8dcqIpXrvax7NxMI9lh4u0CJYp9UshBirA5NOmkRI0r7Ly2wz0cXWWwe0MczTm
         t+315o11WUsIl2jWywiKhT73gaEgYGjbWDCjx4wkgU5b4uCl3xTzsz1FBkyd695ORO
         RaRGp4Vy98Rdw==
Date:   Thu, 3 Jun 2021 09:47:38 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Add support for ECDSA-signed kernel modules
Message-ID: <20210603064738.pwfq3n7erzmncdmw@kernel.org>
References: <20210602143537.545132-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602143537.545132-1-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 02, 2021 at 10:35:35AM -0400, Stefan Berger wrote:
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
> This patch depends on the ECDSA support series currently queued here:
> https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/log/?h=ecc
> 
>   Stefan
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
> 2.29.2
> 
> 

Please instead send a fix.

/Jarkko
