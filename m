Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1230133A01D
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Mar 2021 19:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbhCMSy6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 13 Mar 2021 13:54:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234010AbhCMSy3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 13 Mar 2021 13:54:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2F1F64E54;
        Sat, 13 Mar 2021 18:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615661669;
        bh=AiePwYTGUBvmJJyLewKFbOk2lvQCrkRh/i/qjfZMPuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=byRo2PRFTMhg/SAJ+ddwlS3PYkAGRBD1mhHtMOwKe4j/FL64DrTf8useVc8VkAlr4
         WCL0cK9WCyaJprouOnbKBf3KA/0L0SeF00JHyfPidyjZ1/ehN3J+dzI3i4ZMdbfoZo
         WTYDM2MFZnpQRFsQIu8tlfi1G5y/BP8l1d2706B3iu/FzCQ7/XCHelS3p+PB4XNCZB
         iQZvNJeG9jfJOH97e1LUuAqgRWBXGJYJjhMeIdwPU2MaW5kNJG4D071TqBOm6bm50M
         NG8M6+i914D4T3IH69fmHup95CVWyvGKsnCEA5GvcGKxRqSTVw4X3yxuRisL/TQ2Ig
         nTl1Z8hk89KSA==
Date:   Sat, 13 Mar 2021 20:54:04 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 4/5] certs: Factor out the blacklist hash creation
Message-ID: <YE0KTAfElytCNh0M@kernel.org>
References: <20210312171232.2681989-1-mic@digikod.net>
 <20210312171232.2681989-5-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210312171232.2681989-5-mic@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 12, 2021 at 06:12:31PM +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Factor out the blacklist hash creation with the get_raw_hash() helper.
> This also centralize the "tbs" and "bin" prefixes and make them private,
> which help to manage them consistently.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Eric Snowberg <eric.snowberg@oracle.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20210312171232.2681989-5-mic@digikod.net


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

> ---
> 
> Changes since v6:
> * Rebase on keys-cve-2020-26541-v3: commit ebd9c2ae369a ("integrity:
>   Load mokx variables into the blacklist keyring").
> 
> Changes since v5:
> * Rebase on keys-next and fix conflict as previously done by David
>   Howells.
> * Fix missing part to effectively handle UEFI DBX blacklisting.
> * Remove Jarkko's Acked-by because of the above changes.
> 
> Changes since v2:
> * Add Jarkko's Acked-by.
> ---
>  certs/blacklist.c                             | 76 ++++++++++++++-----
>  crypto/asymmetric_keys/x509_public_key.c      |  3 +-
>  include/keys/system_keyring.h                 | 14 +++-
>  .../platform_certs/keyring_handler.c          | 26 +------
>  4 files changed, 73 insertions(+), 46 deletions(-)
> 
> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index 97a35cf9a62c..b254c87ceb3a 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -109,11 +109,43 @@ static struct key_type key_type_blacklist = {
>  	.describe		= blacklist_describe,
>  };
>  
> +static char *get_raw_hash(const u8 *hash, size_t hash_len,
> +		enum blacklist_hash_type hash_type)
> +{
> +	size_t type_len;
> +	const char *type_prefix;
> +	char *buffer, *p;
> +
> +	switch (hash_type) {
> +	case BLACKLIST_HASH_X509_TBS:
> +		type_len = sizeof(tbs_prefix) - 1;
> +		type_prefix = tbs_prefix;
> +		break;
> +	case BLACKLIST_HASH_BINARY:
> +		type_len = sizeof(bin_prefix) - 1;
> +		type_prefix = bin_prefix;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return ERR_PTR(-EINVAL);
> +	}
> +	buffer = kmalloc(type_len + 1 + hash_len * 2 + 1, GFP_KERNEL);
> +	if (!buffer)
> +		return ERR_PTR(-ENOMEM);
> +	p = memcpy(buffer, type_prefix, type_len);
> +	p += type_len;
> +	*p++ = ':';
> +	bin2hex(p, hash, hash_len);
> +	p += hash_len * 2;
> +	*p = '\0';
> +	return buffer;
> +}
> +
>  /**
> - * mark_hash_blacklisted - Add a hash to the system blacklist
> + * mark_raw_hash_blacklisted - Add a hash to the system blacklist
>   * @hash: The hash as a hex string with a type prefix (eg. "tbs:23aa429783")
>   */
> -int mark_hash_blacklisted(const char *hash)
> +static int mark_raw_hash_blacklisted(const char *hash)
>  {
>  	key_ref_t key;
>  
> @@ -133,29 +165,36 @@ int mark_hash_blacklisted(const char *hash)
>  	return 0;
>  }
>  
> +int mark_hash_blacklisted(const u8 *hash, size_t hash_len,
> +		enum blacklist_hash_type hash_type)
> +{
> +	const char *buffer;
> +	int err;
> +
> +	buffer = get_raw_hash(hash, hash_len, hash_type);
> +	if (IS_ERR(buffer))
> +		return PTR_ERR(buffer);
> +	err = mark_raw_hash_blacklisted(buffer);
> +	kfree(buffer);
> +	return err;
> +}
> +
>  /**
>   * is_hash_blacklisted - Determine if a hash is blacklisted
>   * @hash: The hash to be checked as a binary blob
>   * @hash_len: The length of the binary hash
> - * @type: Type of hash
> + * @hash_type: Type of hash
>   */
> -int is_hash_blacklisted(const u8 *hash, size_t hash_len, const char *type)
> +int is_hash_blacklisted(const u8 *hash, size_t hash_len,
> +		enum blacklist_hash_type hash_type)
>  {
>  	key_ref_t kref;
> -	size_t type_len = strlen(type);
> -	char *buffer, *p;
> +	const char *buffer;
>  	int ret = 0;
>  
> -	buffer = kmalloc(type_len + 1 + hash_len * 2 + 1, GFP_KERNEL);
> -	if (!buffer)
> -		return -ENOMEM;
> -	p = memcpy(buffer, type, type_len);
> -	p += type_len;
> -	*p++ = ':';
> -	bin2hex(p, hash, hash_len);
> -	p += hash_len * 2;
> -	*p = 0;
> -
> +	buffer = get_raw_hash(hash, hash_len, hash_type);
> +	if (IS_ERR(buffer))
> +		return PTR_ERR(buffer);
>  	kref = keyring_search(make_key_ref(blacklist_keyring, true),
>  			      &key_type_blacklist, buffer, false);
>  	if (!IS_ERR(kref)) {
> @@ -170,7 +209,8 @@ EXPORT_SYMBOL_GPL(is_hash_blacklisted);
>  
>  int is_binary_blacklisted(const u8 *hash, size_t hash_len)
>  {
> -	if (is_hash_blacklisted(hash, hash_len, "bin") == -EKEYREJECTED)
> +	if (is_hash_blacklisted(hash, hash_len, BLACKLIST_HASH_BINARY) ==
> +			-EKEYREJECTED)
>  		return -EPERM;
>  
>  	return 0;
> @@ -243,7 +283,7 @@ static int __init blacklist_init(void)
>  		panic("Can't allocate system blacklist keyring\n");
>  
>  	for (bl = blacklist_hashes; *bl; bl++)
> -		if (mark_hash_blacklisted(*bl) < 0)
> +		if (mark_raw_hash_blacklisted(*bl) < 0)
>  			pr_err("- blacklisting failed\n");
>  	return 0;
>  }
> diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
> index ae450eb8be14..3b7dba5e4cd9 100644
> --- a/crypto/asymmetric_keys/x509_public_key.c
> +++ b/crypto/asymmetric_keys/x509_public_key.c
> @@ -81,7 +81,8 @@ int x509_get_sig_params(struct x509_certificate *cert)
>  	if (ret < 0)
>  		goto error_2;
>  
> -	ret = is_hash_blacklisted(sig->digest, sig->digest_size, "tbs");
> +	ret = is_hash_blacklisted(sig->digest, sig->digest_size,
> +				  BLACKLIST_HASH_X509_TBS);
>  	if (ret == -EKEYREJECTED) {
>  		pr_err("Cert %*phN is blacklisted\n",
>  		       sig->digest_size, sig->digest);
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index 875e002a4180..d2597f8d6d7e 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -10,6 +10,13 @@
>  
>  #include <linux/key.h>
>  
> +enum blacklist_hash_type {
> +	/* TBSCertificate hash */
> +	BLACKLIST_HASH_X509_TBS = 1,
> +	/* Raw data hash */
> +	BLACKLIST_HASH_BINARY = 2,
> +};
> +
>  #ifdef CONFIG_SYSTEM_TRUSTED_KEYRING
>  
>  extern int restrict_link_by_builtin_trusted(struct key *keyring,
> @@ -33,13 +40,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
>  
>  extern struct pkcs7_message *pkcs7;
>  #ifdef CONFIG_SYSTEM_BLACKLIST_KEYRING
> -extern int mark_hash_blacklisted(const char *hash);
> +extern int mark_hash_blacklisted(const u8 *hash, size_t hash_len,
> +			       enum blacklist_hash_type hash_type);
>  extern int is_hash_blacklisted(const u8 *hash, size_t hash_len,
> -			       const char *type);
> +			       enum blacklist_hash_type hash_type);
>  extern int is_binary_blacklisted(const u8 *hash, size_t hash_len);
>  #else
>  static inline int is_hash_blacklisted(const u8 *hash, size_t hash_len,
> -				      const char *type)
> +				      enum blacklist_hash_type hash_type)
>  {
>  	return 0;
>  }
> diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
> index 5604bd57c990..9e4f156b356e 100644
> --- a/security/integrity/platform_certs/keyring_handler.c
> +++ b/security/integrity/platform_certs/keyring_handler.c
> @@ -15,35 +15,13 @@ static efi_guid_t efi_cert_x509_sha256_guid __initdata =
>  	EFI_CERT_X509_SHA256_GUID;
>  static efi_guid_t efi_cert_sha256_guid __initdata = EFI_CERT_SHA256_GUID;
>  
> -/*
> - * Blacklist a hash.
> - */
> -static __init void uefi_blacklist_hash(const char *source, const void *data,
> -				       size_t len, const char *type,
> -				       size_t type_len)
> -{
> -	char *hash, *p;
> -
> -	hash = kmalloc(type_len + len * 2 + 1, GFP_KERNEL);
> -	if (!hash)
> -		return;
> -	p = memcpy(hash, type, type_len);
> -	p += type_len;
> -	bin2hex(p, data, len);
> -	p += len * 2;
> -	*p = 0;
> -
> -	mark_hash_blacklisted(hash);
> -	kfree(hash);
> -}
> -
>  /*
>   * Blacklist an X509 TBS hash.
>   */
>  static __init void uefi_blacklist_x509_tbs(const char *source,
>  					   const void *data, size_t len)
>  {
> -	uefi_blacklist_hash(source, data, len, "tbs:", 4);
> +	mark_hash_blacklisted(data, len, BLACKLIST_HASH_X509_TBS);
>  }
>  
>  /*
> @@ -52,7 +30,7 @@ static __init void uefi_blacklist_x509_tbs(const char *source,
>  static __init void uefi_blacklist_binary(const char *source,
>  					 const void *data, size_t len)
>  {
> -	uefi_blacklist_hash(source, data, len, "bin:", 4);
> +	mark_hash_blacklisted(data, len, BLACKLIST_HASH_BINARY);
>  }
>  
>  /*
> -- 
> 2.30.2
> 
> 
