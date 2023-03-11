Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE0E6B6161
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Mar 2023 23:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCKWKQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Mar 2023 17:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjCKWKP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Mar 2023 17:10:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B542C657;
        Sat, 11 Mar 2023 14:10:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4191260E88;
        Sat, 11 Mar 2023 22:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8D5C433EF;
        Sat, 11 Mar 2023 22:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678572613;
        bh=D9dLzCfeqWuXouu3aKrlHiE1Tazt/6/b97r6ngWPJaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IcT1ljkO4RsToJDNXqRwIOVoh9Tb36Q+04t6fC7zd0cfP8TRMGf5bMbwtfK87hzFK
         sQm8pjQdlYqZVP1Xk6R7jqXhEcOtvME3a8cuAzgfG/v0HtPpxOnTx2AQ/cE/5+Ro3G
         6pTPNO7m5fiMXrv3NowItD4nghj/opIfSPIE7sO/k1B7DWPYdI2efez+g2VBIRZAOc
         YFBPZIXZbkrH4KJ/EQ/rnAG1BVFQLrd30B1w/j2GNFr/5Vc4w2GnwecKIIK48ByelG
         WqR2W3F1vGR2IUedndTYh8iSYqzB3bff/PyXf2CUPRZMPhnG9vFWarhsTAi96BkTmG
         vLaq+x9s2AIHQ==
Date:   Sun, 12 Mar 2023 00:10:10 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, erpalmer@linux.vnet.ibm.com,
        coxu@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 5/6] KEYS: CA link restriction
Message-ID: <ZAz8QlynTSMD7kuE@kernel.org>
References: <20230302164652.83571-1-eric.snowberg@oracle.com>
 <20230302164652.83571-6-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302164652.83571-6-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 02, 2023 at 11:46:51AM -0500, Eric Snowberg wrote:
> Add a new link restriction.  Restrict the addition of keys in a keyring
> based on the key to be added being a CA.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  crypto/asymmetric_keys/restrict.c | 38 +++++++++++++++++++++++++++++++
>  include/crypto/public_key.h       | 15 ++++++++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
> index 6b1ac5f5896a..48457c6f33f9 100644
> --- a/crypto/asymmetric_keys/restrict.c
> +++ b/crypto/asymmetric_keys/restrict.c
> @@ -108,6 +108,44 @@ int restrict_link_by_signature(struct key *dest_keyring,
>  	return ret;
>  }
>  
> +/**
> + * restrict_link_by_ca - Restrict additions to a ring of CA keys
> + * @dest_keyring: Keyring being linked to.
> + * @type: The type of key being added.
> + * @payload: The payload of the new key.
> + * @trust_keyring: Unused.
> + *
> + * Check if the new certificate is a CA. If it is a CA, then mark the new
> + * certificate as being ok to link.
> + *
> + * Returns 0 if the new certificate was accepted, -ENOKEY if the
> + * certificate is not a CA. -ENOPKG if the signature uses unsupported
> + * crypto, or some other error if there is a matching certificate but
> + * the signature check cannot be performed.
> + */
> +int restrict_link_by_ca(struct key *dest_keyring,
> +			const struct key_type *type,
> +			const union key_payload *payload,
> +			struct key *trust_keyring)
> +{
> +	const struct public_key *pkey;
> +
> +	if (type != &key_type_asymmetric)
> +		return -EOPNOTSUPP;
> +
> +	pkey = payload->data[asym_crypto];
> +	if (!pkey)
> +		return -ENOPKG;
> +	if (!test_bit(KEY_EFLAG_CA, &pkey->key_eflags))
> +		return -ENOKEY;
> +	if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
> +		return -ENOKEY;
> +	if (test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
> +		return -ENOKEY;

nit: would be more readable, if conditions were separated by
empty lines.

> +
> +	return 0;
> +}
> +
>  static bool match_either_id(const struct asymmetric_key_id **pair,
>  			    const struct asymmetric_key_id *single)
>  {
> diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
> index 03c3fb990d59..653992a6e941 100644
> --- a/include/crypto/public_key.h
> +++ b/include/crypto/public_key.h
> @@ -75,6 +75,21 @@ extern int restrict_link_by_key_or_keyring_chain(struct key *trust_keyring,
>  						 const union key_payload *payload,
>  						 struct key *trusted);
>  
> +#if IS_REACHABLE(CONFIG_ASYMMETRIC_KEY_TYPE)
> +extern int restrict_link_by_ca(struct key *dest_keyring,
> +			       const struct key_type *type,
> +			       const union key_payload *payload,
> +			       struct key *trust_keyring);
> +#else
> +static inline int restrict_link_by_ca(struct key *dest_keyring,
> +				      const struct key_type *type,
> +				      const union key_payload *payload,
> +				      struct key *trust_keyring)
> +{
> +	return 0;
> +}
> +#endif
> +
>  extern int query_asymmetric_key(const struct kernel_pkey_params *,
>  				struct kernel_pkey_query *);
>  
> -- 
> 2.27.0
> 

BR, Jarkko
