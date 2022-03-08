Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B857F4D16AF
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Mar 2022 12:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242254AbiCHLz3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Mar 2022 06:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbiCHLz3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Mar 2022 06:55:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB8F2DD5F;
        Tue,  8 Mar 2022 03:54:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02D12616B4;
        Tue,  8 Mar 2022 11:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E320C340EE;
        Tue,  8 Mar 2022 11:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646740471;
        bh=mK13UO2icdJkbKzDbJRR7VE/cOk6rGlpu6tEY0bGCuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Re5QDj7KRYzTymY4POCxVl1W2LAH0TjcmZxoB7Lcljws/4CY5LeietEgW+tc6LQ+S
         iEDz677lvA1j7kmfIoqfKmPa6Hury9ctUNCbbdkWgNYiR8vMexjRRBCKxXMwAvIrMd
         r4nrMUUZWzdOlzGP56ssPqA4ZqGCiEiOFibWz8STmwMRuF/FCDiFMaFnB6V2aZjFfY
         vZHLYQJ7a2GAk2LM0Q8tGJ63WFN4b9hLuLGFe9aXqKjJcMtxNvFapkaomSWGx75JhS
         hk2bDSCmqbjAsjtsygHOFwRdfHqTi8Kwoz6hQHGpEum45KLH7qoxv7a66TY5iCYe40
         X7BOwDpy4dnNw==
Date:   Tue, 8 Mar 2022 13:53:50 +0200
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
Subject: Re: [PATCH v8 5/5] certs: Allow root user to append signed hashes to
 the blacklist keyring
Message-ID: <YidDznCPSmFmfNwE@iki.fi>
References: <20210712170313.884724-1-mic@digikod.net>
 <20210712170313.884724-6-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210712170313.884724-6-mic@digikod.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 12, 2021 at 07:03:13PM +0200, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Add a kernel option SYSTEM_BLACKLIST_AUTH_UPDATE to enable the root user
> to dynamically add new keys to the blacklist keyring.  This enables to
> invalidate new certificates, either from being loaded in a keyring, or
> from being trusted in a PKCS#7 certificate chain.  This also enables to
> add new file hashes to be denied by the integrity infrastructure.
> 
> Being able to untrust a certificate which could have normaly been
> trusted is a sensitive operation.  This is why adding new hashes to the
> blacklist keyring is only allowed when these hashes are signed and
> vouched by the builtin trusted keyring.  A blacklist hash is stored as a
> key description.  The PKCS#7 signature of this description must be
> provided as the key payload.
> 
> Marking a certificate as untrusted should be enforced while the system
> is running.  It is then forbiden to remove such blacklist keys.
> 
> Update blacklist keyring, blacklist key and revoked certificate access rights:
> * allows the root user to search for a specific blacklisted hash, which
>   make sense because the descriptions are already viewable;
> * forbids key update (blacklist and asymmetric ones);
> * restricts kernel rights on the blacklist keyring to align with the
>   root user rights.
> 
> See help in tools/certs/print-cert-tbs-hash.sh .
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Eric Snowberg <eric.snowberg@oracle.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20210712170313.884724-6-mic@digikod.net
> ---
> 
> Changes since v6:
> * Rebase on keys-cve-2020-26541-v3: commit ebd9c2ae369a ("integrity:
>   Load mokx variables into the blacklist keyring").
> 
> Changes since v5:
> * Rebase on keys-next, fix Kconfig conflict, and update the asymmetric
>   key rights added to the blacklist keyring by the new
>   add_key_to_revocation_list(): align with blacklist key rights by
>   removing KEY_POS_WRITE as a safeguard, and add
>   KEY_ALLOC_BYPASS_RESTRICTION to not be subject to
>   restrict_link_for_blacklist() that only allows blacklist key types to
>   be added to the keyring.
> * Change the return code for restrict_link_for_blacklist() from -EPERM
>   to -EOPNOTSUPP to align with asymmetric key keyrings.
> 
> Changes since v3:
> * Update commit message for print-cert-tbs-hash.sh .
> 
> Changes since v2:
> * Add comment for blacklist_key_instantiate().
> ---
>  certs/Kconfig     | 10 +++++
>  certs/blacklist.c | 96 ++++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 85 insertions(+), 21 deletions(-)
> 
> diff --git a/certs/Kconfig b/certs/Kconfig
> index 0fbe184ceca5..e0e524b7eff9 100644
> --- a/certs/Kconfig
> +++ b/certs/Kconfig
> @@ -103,4 +103,14 @@ config SYSTEM_REVOCATION_KEYS
>  	  containing X.509 certificates to be included in the default blacklist
>  	  keyring.
>  
> +config SYSTEM_BLACKLIST_AUTH_UPDATE
> +	bool "Allow root to add signed blacklist keys"
> +	depends on SYSTEM_BLACKLIST_KEYRING
> +	depends on SYSTEM_DATA_VERIFICATION
> +	help
> +	  If set, provide the ability to load new blacklist keys at run time if
> +	  they are signed and vouched by a certificate from the builtin trusted
> +	  keyring.  The PKCS#7 signature of the description is set in the key
> +	  payload.  Blacklist keys cannot be removed.
> +
>  endmenu
> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index b254c87ceb3a..486ce0dd8e9c 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -15,6 +15,7 @@
>  #include <linux/err.h>
>  #include <linux/seq_file.h>
>  #include <linux/uidgid.h>
> +#include <linux/verification.h>
>  #include <keys/system_keyring.h>
>  #include "blacklist.h"
>  #include "common.h"
> @@ -26,6 +27,9 @@
>   */
>  #define MAX_HASH_LEN	128
>  
> +#define BLACKLIST_KEY_PERM (KEY_POS_SEARCH | KEY_POS_VIEW | \
> +			    KEY_USR_SEARCH | KEY_USR_VIEW)
> +
>  static const char tbs_prefix[] = "tbs";
>  static const char bin_prefix[] = "bin";
>  
> @@ -80,19 +84,51 @@ static int blacklist_vet_description(const char *desc)
>  	return 0;
>  }
>  
> -/*
> - * The hash to be blacklisted is expected to be in the description.  There will
> - * be no payload.
> - */
> -static int blacklist_preparse(struct key_preparsed_payload *prep)
> +static int blacklist_key_instantiate(struct key *key,
> +		struct key_preparsed_payload *prep)
>  {
> -	if (prep->datalen > 0)
> -		return -EINVAL;
> -	return 0;
> +#ifdef CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE
> +	int err;
> +#endif
> +
> +	/* Sets safe default permissions for keys loaded by user space. */
> +	key->perm = BLACKLIST_KEY_PERM;
> +
> +	/*
> +	 * Skips the authentication step for builtin hashes, they are not
> +	 * signed but still trusted.
> +	 */
> +	if (key->flags & (1 << KEY_FLAG_BUILTIN))
> +		goto out;
> +
> +#ifdef CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE
> +	/*
> +	 * Verifies the description's PKCS#7 signature against the builtin
> +	 * trusted keyring.
> +	 */
> +	err = verify_pkcs7_signature(key->description,
> +			strlen(key->description), prep->data, prep->datalen,
> +			NULL, VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
> +	if (err)
> +		return err;
> +#else
> +	/*
> +	 * It should not be possible to come here because the keyring doesn't
> +	 * have KEY_USR_WRITE and the only other way to call this function is
> +	 * for builtin hashes.
> +	 */
> +	WARN_ON_ONCE(1);
> +	return -EPERM;
> +#endif
> +
> +out:
> +	return generic_key_instantiate(key, prep);
>  }
>  
> -static void blacklist_free_preparse(struct key_preparsed_payload *prep)
> +static int blacklist_key_update(struct key *key,
> +		struct key_preparsed_payload *prep)
>  {
> +	return -EPERM;
>  }
>  
>  static void blacklist_describe(const struct key *key, struct seq_file *m)
> @@ -103,9 +139,8 @@ static void blacklist_describe(const struct key *key, struct seq_file *m)
>  static struct key_type key_type_blacklist = {
>  	.name			= "blacklist",
>  	.vet_description	= blacklist_vet_description,
> -	.preparse		= blacklist_preparse,
> -	.free_preparse		= blacklist_free_preparse,
> -	.instantiate		= generic_key_instantiate,
> +	.instantiate		= blacklist_key_instantiate,
> +	.update			= blacklist_key_update,
>  	.describe		= blacklist_describe,
>  };
>  
> @@ -154,8 +189,7 @@ static int mark_raw_hash_blacklisted(const char *hash)
>  				   hash,
>  				   NULL,
>  				   0,
> -				   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
> -				    KEY_USR_VIEW),
> +				   BLACKLIST_KEY_PERM,
>  				   KEY_ALLOC_NOT_IN_QUOTA |
>  				   KEY_ALLOC_BUILT_IN);
>  	if (IS_ERR(key)) {
> @@ -232,8 +266,10 @@ int add_key_to_revocation_list(const char *data, size_t size)
>  				   NULL,
>  				   data,
>  				   size,
> -				   ((KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW),
> -				   KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_BUILT_IN);
> +				   KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH
> +				   | KEY_USR_VIEW,
> +				   KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_BUILT_IN
> +				   | KEY_ALLOC_BYPASS_RESTRICTION);
>  
>  	if (IS_ERR(key)) {
>  		pr_err("Problem with revocation key (%ld)\n", PTR_ERR(key));
> @@ -260,25 +296,43 @@ int is_key_on_revocation_list(struct pkcs7_message *pkcs7)
>  }
>  #endif
>  
> +static int restrict_link_for_blacklist(struct key *dest_keyring,
> +		const struct key_type *type, const union key_payload *payload,
> +		struct key *restrict_key)
> +{
> +	if (type == &key_type_blacklist)
> +		return 0;
> +	return -EOPNOTSUPP;
> +}
> +
>  /*
>   * Initialise the blacklist
>   */
>  static int __init blacklist_init(void)
>  {
>  	const char *const *bl;
> +	struct key_restriction *restriction;
>  
>  	if (register_key_type(&key_type_blacklist) < 0)
>  		panic("Can't allocate system blacklist key type\n");
>  
> +	restriction = kzalloc(sizeof(*restriction), GFP_KERNEL);
> +	if (!restriction)
> +		panic("Can't allocate blacklist keyring restriction\n");


This prevents me from taking this to my pull request. In moderns standards,
no new BUG_ON(), panic() etc. should never added to the kernel.

I missed this in my review.

This should rather be e.g.

        restriction = kzalloc(sizeof(*restriction), GFP_KERNEL);
	if (!restriction) {
		pr_err("Can't allocate blacklist keyring restriction\n");
                return 0;
        }

Unfortunately I need to drop this patch set, because adding new panic()
is simply a no-go.

BR, Jarkko
