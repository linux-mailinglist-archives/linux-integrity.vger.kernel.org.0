Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97E336CFAA
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Apr 2021 01:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbhD0Xrg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Apr 2021 19:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236015AbhD0Xrg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Apr 2021 19:47:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14E8B61076;
        Tue, 27 Apr 2021 23:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619567212;
        bh=o+ft7QpWTKZODu7FJO8CbZqI/vociOA3tGc3KsMtfNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KA4btV8xk5YSVnWSCbkmgsXmMZOBNhrQxZopLpoYq2crKVYvuZAozIVzVHydEvAJ1
         0DR29DWQKM2J2qTLYEflKgiwM7aoEHgYKk648BF/pkgV+JcVZ5LB0EmarLZFWw6kvZ
         Tl+bJIcm5SL9bv+ShwhO/DBCgDyfidmCs3lwpVmellSKJWI1kju1xmmDNvCGkVjQQS
         9eI0LiCvJDttvG9M+w/f+GMpITLWJJN8n43t2F0LH81lsUvgJic6Nzqwv1tyi10mzK
         Q68R2sZjFAp4q5bhmrVr7yXq2HbvWdjtJCQDoIFiSgkTFOsWjTB48rJfrg5XhXwLp3
         LlhZJFxWFQROA==
Date:   Wed, 28 Apr 2021 02:46:50 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        zohar@linux.ibm.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] certs: Trigger creation of RSA module signing key
 if it's not an RSA key
Message-ID: <YIiiatWqrdBX0rPS@kernel.org>
References: <20210421194319.1489291-1-stefanb@linux.ibm.com>
 <20210421194319.1489291-2-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421194319.1489291-2-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 21, 2021 at 03:43:18PM -0400, Stefan Berger wrote:
> Address a kbuild issue where a developer created an ECDSA key for signing
> kernel modules and then builds an older version of the kernel, when bi-
> secting the kernel for example, that does not support ECDSA keys.
> 
> Trigger the creation of an RSA module signing key if it is not an RSA key.
> 
> Fixes: cfc411e7fff3 ("Move certificate handling to its own directory")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

> ---
>  certs/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/certs/Makefile b/certs/Makefile
> index e3185c57fbd8..f64bc89ccbf1 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -59,6 +59,11 @@ silent_redirect_openssl = 2>/dev/null
>  # external private key, because 'make randconfig' might enable such a
>  # boolean option and we unfortunately can't make it depend on !RANDCONFIG.
>  ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
> +
> +X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
> +
> +$(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
> +
>  $(obj)/signing_key.pem: $(obj)/x509.genkey
>  	@$(kecho) "###"
>  	@$(kecho) "### Now generating an X.509 key pair to be used for signing modules."
> -- 
> 2.29.2
> 
> 

/Jarkko
