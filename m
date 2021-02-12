Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC24231A86D
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Feb 2021 00:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhBLXtN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Feb 2021 18:49:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhBLXtM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Feb 2021 18:49:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19CD864E2A;
        Fri, 12 Feb 2021 23:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613173711;
        bh=OAq5dOrNvnWKNrhHL3ue9iqqdD8L+U4dRz2dwfyWJBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YgGj2Ukcpv+DQ5OUqWhyIXB3w3IZsYUlytYZK2OuTayblpjWl3Mvd01gEKaeVD+gh
         7fzFmh4fFEiYXc0IsWavyYuFV3QQYUh1oqSVyAiSmKSsUnbbdPi7hT62Tb2YG+Klvf
         8nytsi+6mUd2r11TJminF7fFwYSSD/93G80BIFBiUxYKrC/ioLZi1aOGUnganpEy+w
         taqQENDxD82CKC2Sp70TDO+gXbvUDb/3ieo3q45kRsmnk0OviPmKNJdBPIQ1tbxe23
         +SqVmLrTvZlsPfh3YNLOGtm30HuSl95m9iKkz0wtWBKJyEiYnPwgd2Or9P1OFRZeyi
         FJDzbA1ctIu4w==
Date:   Sat, 13 Feb 2021 01:48:22 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] ima: enable loading of build time generated key to
 .ima keyring
Message-ID: <YCcTxu1r5ABPMLOR@kernel.org>
References: <20210211195435.135582-1-nayna@linux.ibm.com>
 <20210211195435.135582-6-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211195435.135582-6-nayna@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 11, 2021 at 02:54:35PM -0500, Nayna Jain wrote:
> The kernel currently only loads the kernel module signing key onto
> the builtin trusted keyring. To support IMA, load the module signing
> key selectively either onto builtin or ima keyring based on MODULE_SIG
                                         ~~~
                                         IMA


> or MODULE_APPRAISE_MODSIG config respectively; and loads the CA kernel
> key onto builtin trusted keyring.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

/Jarkko

> ---
>  certs/system_keyring.c        | 56 +++++++++++++++++++++++++++--------
>  include/keys/system_keyring.h |  9 +++++-
>  security/integrity/digsig.c   |  4 +++
>  3 files changed, 55 insertions(+), 14 deletions(-)
> 
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 798291177186..0bbbe501f8a7 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -26,6 +26,7 @@ static struct key *platform_trusted_keys;
>  
>  extern __initconst const u8 system_certificate_list[];
>  extern __initconst const unsigned long system_certificate_list_size;
> +extern __initconst const unsigned long module_cert_size;
>  
>  /**
>   * restrict_link_to_builtin_trusted - Restrict keyring addition by built in CA
> @@ -131,19 +132,12 @@ static __init int system_trusted_keyring_init(void)
>   */
>  device_initcall(system_trusted_keyring_init);
>  
> -/*
> - * Load the compiled-in list of X.509 certificates.
> - */
> -static __init int load_system_certificate_list(void)
> +static __init int load_cert(const u8 *p, const u8 *end, struct key *keyring,
> +			    unsigned long flags)
>  {
>  	key_ref_t key;
> -	const u8 *p, *end;
>  	size_t plen;
>  
> -	pr_notice("Loading compiled-in X.509 certificates\n");
> -
> -	p = system_certificate_list;
> -	end = p + system_certificate_list_size;
>  	while (p < end) {
>  		/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
>  		 * than 256 bytes in size.
> @@ -158,16 +152,15 @@ static __init int load_system_certificate_list(void)
>  		if (plen > end - p)
>  			goto dodgy_cert;
>  
> -		key = key_create_or_update(make_key_ref(builtin_trusted_keys, 1),
> +		key = key_create_or_update(make_key_ref(keyring, 1),
>  					   "asymmetric",
>  					   NULL,
>  					   p,
>  					   plen,
>  					   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
>  					   KEY_USR_VIEW | KEY_USR_READ),
> -					   KEY_ALLOC_NOT_IN_QUOTA |
> -					   KEY_ALLOC_BUILT_IN |
> -					   KEY_ALLOC_BYPASS_RESTRICTION);
> +					   flags);
> +
>  		if (IS_ERR(key)) {
>  			pr_err("Problem loading in-kernel X.509 certificate (%ld)\n",
>  			       PTR_ERR(key));
> @@ -185,6 +178,43 @@ static __init int load_system_certificate_list(void)
>  	pr_err("Problem parsing in-kernel X.509 certificate list\n");
>  	return 0;
>  }
> +
> +__init int load_module_cert(struct key *keyring, unsigned long flags)
> +{
> +	const u8 *p, *end;
> +
> +	if (!IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG))
> +		return 0;
> +
> +	pr_notice("Loading compiled-in module X.509 certificates\n");
> +
> +	p = system_certificate_list;
> +	end = p + module_cert_size;
> +	load_cert(p, end, keyring, flags);
> +
> +	return 0;
> +}
> +
> +/*
> + * Load the compiled-in list of X.509 certificates.
> + */
> +static __init int load_system_certificate_list(void)
> +{
> +	const u8 *p, *end;
> +
> +	pr_notice("Loading compiled-in X.509 certificates\n");
> +
> +#ifdef CONFIG_MODULE_SIG
> +	p = system_certificate_list;
> +#else
> +	p = system_certificate_list + module_cert_size;
> +#endif
> +	end = p + system_certificate_list_size;
> +	load_cert(p, end, builtin_trusted_keys, KEY_ALLOC_NOT_IN_QUOTA |
> +						KEY_ALLOC_BUILT_IN |
> +						KEY_ALLOC_BYPASS_RESTRICTION);
> +	return 0;
> +}
>  late_initcall(load_system_certificate_list);
>  
>  #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index fb8b07daa9d1..e91c03376599 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -16,9 +16,16 @@ extern int restrict_link_by_builtin_trusted(struct key *keyring,
>  					    const struct key_type *type,
>  					    const union key_payload *payload,
>  					    struct key *restriction_key);
> -
> +extern __init int load_module_cert(struct key *keyring, unsigned long flags);
>  #else
>  #define restrict_link_by_builtin_trusted restrict_link_reject
> +
> +static inline __init int load_module_cert(struct key *keyring,
> +					  unsigned long flags)
> +{
> +	return 0;
> +}
> +
>  #endif
>  
>  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 0f518dcfde05..4009d1e33fe0 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -111,8 +111,12 @@ static int __init __integrity_init_keyring(const unsigned int id,
>  	} else {
>  		if (id == INTEGRITY_KEYRING_PLATFORM)
>  			set_platform_trusted_keys(keyring[id]);
> +		if (id == INTEGRITY_KEYRING_IMA)
> +			load_module_cert(keyring[id], KEY_ALLOC_NOT_IN_QUOTA);
>  	}
>  
> +	pr_info("Loading key to ima keyring\n");
> +
>  	return err;
>  }
>  
> -- 
> 2.18.1
> 
> 
