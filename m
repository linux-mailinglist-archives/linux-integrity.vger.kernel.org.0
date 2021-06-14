Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB143A6EDF
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Jun 2021 21:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhFNTZf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Jun 2021 15:25:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233048AbhFNTZe (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jun 2021 15:25:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6C1C61042;
        Mon, 14 Jun 2021 19:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623698611;
        bh=1A249yoVZVt625jJtwCHg3Eq4rJAvE9AR+oVYBj6Rtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H58Uj1yqJHQSiEhNJreFYb5FL8P2P8+y9vquF07+pUf8cYQTSWxRG+bjkDl6GwEVF
         PnM0VGntmT0CtrYGDOimrP/NI5plVSHdTKhq9xOyzWctADMueW0bIOE/SjuW475mU2
         ho/vzdlpojgCRsSkPAhFLaAAcOktB6vSZu+PFFTU89yceAYh9XAmBmI/R8cr0l9lvP
         35HHrQyRgTgM0KFwGJxYf28NDl2gpk69nR+FuBgK/OPvhG5V/Ky1347FIsvQdKlMU/
         /HFOEDEWOCGCd0N1EcApT54acG2kEDin5ffw5x/3uHuw5S8XsxsmDVWT0QrmdEFeAA
         hLcw3/drr0lPw==
Date:   Mon, 14 Jun 2021 22:23:29 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] certs: Adjustment due to 'Check whether openssl
 tool is available'
Message-ID: <20210614192329.dhhahvi5gtnlgbln@kernel.org>
References: <20210610125623.1553792-1-stefanb@linux.ibm.com>
 <20210610125623.1553792-5-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610125623.1553792-5-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 10, 2021 at 08:56:23AM -0400, Stefan Berger wrote:
> Adjust the previous patch due to fixes applied to the first patch
> in the series.
> 
> Fixes: 46449892e6e5 ("certs: Add support for using elliptic curve keys for signing modules")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  certs/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/certs/Makefile b/certs/Makefile
> index dc9f354dd5f8..4eb69bdadc79 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -66,16 +66,21 @@ ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
>  
>  ifeq ($(openssl_available),yes)
>  X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
> +endif
>  
>  # Support user changing key type
>  ifdef CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
>  keytype_openssl = -newkey ec -pkeyopt ec_paramgen_curve:secp384r1
> +ifeq ($(openssl_available),yes)
>  $(if $(findstring id-ecPublicKey,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
>  endif
> +endif # CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
>  
>  ifdef CONFIG_MODULE_SIG_KEY_TYPE_RSA
> +ifeq ($(openssl_available),yes)
>  $(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
>  endif
> +endif # CONFIG_MODULE_SIG_KEY_TYPE_RSA
>  
>  $(obj)/signing_key.pem: $(obj)/x509.genkey
>  	@$(kecho) "###"
> -- 
> 2.29.2
> 
> 

Please check that they are applied correctly, thanks.

/Jarkko
