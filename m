Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FFE36CFB0
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Apr 2021 01:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbhD0Xsf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Apr 2021 19:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236015AbhD0Xsf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Apr 2021 19:48:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E28061076;
        Tue, 27 Apr 2021 23:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619567271;
        bh=TFwGmF0S+aDOzPhe7rg8N7GWEOOJzXVXXwUBK1ZpOOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VGeLEos/LYRcIBjuqKtAGyIam3joh+EZmmQcM3sGI4fAyKvqLz/JWmgKsgfFq9f1l
         r6T1j0+u6Zduo3SQqzKbmiw0QXxRJoAvl+qYq73J88OP9KF1FdxXPwCVnhVQ2OhAAM
         0WtO4VBbIaxWG8csflefoovclu1FZHgcmI12WBEAkYxK0AUeWEOusclhEw8z6cTA2X
         A6YvItjkUTDysbqAPP7EGla3lQVc4LcIRfU57YnWcKVMvgiogD+nkx0MpMlSHptU1W
         AiYHDDGvttdlGeOCe02+Dr64Pqcg7YrgMMtVffrVFef1EwzlwCCG67WRgkMXTR1wEY
         S/TU7qIf1XJDw==
Date:   Wed, 28 Apr 2021 02:47:49 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        zohar@linux.ibm.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Add support for ECDSA-signed kernel modules
Message-ID: <YIiipT1nDSfzX3P6@kernel.org>
References: <20210423151247.1517808-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423151247.1517808-1-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Apr 23, 2021 at 11:12:45AM -0400, Stefan Berger wrote:
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
>  certs/Makefile                        | 14 ++++++++++++++
>  crypto/asymmetric_keys/pkcs7_parser.c |  8 ++++++++
>  3 files changed, 48 insertions(+)
> 
> -- 
> 2.29.2
> 
> 

I just went through v3. My tags apply also to this version.

/Jarkko
