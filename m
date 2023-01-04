Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A53465D1B8
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jan 2023 12:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbjADLp2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Jan 2023 06:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbjADLp1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Jan 2023 06:45:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56E81EAC4;
        Wed,  4 Jan 2023 03:45:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A4BDB810FA;
        Wed,  4 Jan 2023 11:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91CEC433EF;
        Wed,  4 Jan 2023 11:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672832723;
        bh=u/1lpQoEwwOhaC64Ks/47LutzmlTIKS8L19spQ22zeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mfo/ycR0qy92CF/pRxMJrMUnEosIex8CofHbfFmBQ7MeuzSIs0xfxugcMSLXy8qLz
         ECNUyVd49h1K+8q9gm5q5/hVXtH8w/4Uo1QcZ4f9ZP+kiORcuwPKqzS3b/dgLL6dK1
         xN3hpHRY3B+DQprZGkmOb0Y/TMi7CrB7d5t9yO6DLZlmxBo6y2XWvzIdKIGAiobS/t
         lpaZWaptHYHn4cHqITpdeyEV3mvbz2vCSXvpE0ZOhkzGFjTsDo9+b7AXsUm1OBkBzQ
         lv4TAlKZaF/uPSVEbJK3rM/I4ILaQETGqcHqQWkIQHtsWp69X7vf18U76MqLJ8OkEs
         +QM0Ha4xJboVQ==
Date:   Wed, 4 Jan 2023 11:45:20 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, noodles@fb.com, tiwai@suse.de,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 05/10] KEYS: Introduce a CA endorsed flag
Message-ID: <Y7Vm0IPUhJ9aDpgk@kernel.org>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
 <20221214003401.4086781-6-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214003401.4086781-6-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 13, 2022 at 07:33:56PM -0500, Eric Snowberg wrote:
> Some subsystems are interested in knowing if a key has been endorsed
> as or by a Certificate Authority (CA). From the data contained in struct
> key, it is not possible to make this determination after the key
> parsing is complete.  Introduce a new Endorsed Certificate Authority
> flag called KEY_FLAG_ECA.
> 
> The first type of key to use this is X.509.  When a X.509 certificate
> has the keyCertSign Key Usage set and contains the CA bit set, this new
> flag is set. In the future, other usage fields could be added as flags,
> i.e. digitialSignature.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  crypto/asymmetric_keys/x509_public_key.c | 3 +++
>  include/linux/key-type.h                 | 2 ++
>  include/linux/key.h                      | 2 ++
>  security/keys/key.c                      | 8 ++++++++
>  4 files changed, 15 insertions(+)
> 
> diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
> index 0b4943a4592b..fd1d7d6e68e7 100644
> --- a/crypto/asymmetric_keys/x509_public_key.c
> +++ b/crypto/asymmetric_keys/x509_public_key.c
> @@ -208,6 +208,9 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
>  		goto error_free_kids;
>  	}
>  

A comment here?

> +	if (cert->kcs_set && cert->root_ca)
> +		prep->payload_flags |= KEY_ALLOC_PECA;
> +
>  	/* We're pinning the module by being linked against it */
>  	__module_get(public_key_subtype.owner);
>  	prep->payload.data[asym_subtype] = &public_key_subtype;
> diff --git a/include/linux/key-type.h b/include/linux/key-type.h
> index 7d985a1dfe4a..0b500578441c 100644
> --- a/include/linux/key-type.h
> +++ b/include/linux/key-type.h
> @@ -36,6 +36,8 @@ struct key_preparsed_payload {
>  	size_t		datalen;	/* Raw datalen */
>  	size_t		quotalen;	/* Quota length for proposed payload */
>  	time64_t	expiry;		/* Expiry time of key */
> +	unsigned int	payload_flags;  /* Proposed payload flags */
> +#define KEY_ALLOC_PECA	0x0001		/* Proposed Endorsed CA (ECA) key */
>  } __randomize_layout;
>  
>  typedef int (*request_key_actor_t)(struct key *auth_key, void *aux);
> diff --git a/include/linux/key.h b/include/linux/key.h
> index d27477faf00d..21d5a13ee4a9 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -236,6 +236,7 @@ struct key {
>  #define KEY_FLAG_ROOT_CAN_INVAL	7	/* set if key can be invalidated by root without permission */
>  #define KEY_FLAG_KEEP		8	/* set if key should not be removed */
>  #define KEY_FLAG_UID_KEYRING	9	/* set if key is a user or user session keyring */
> +#define KEY_FLAG_ECA		10	/* set if key is an Endorsed CA key */
>  
>  	/* the key type and key description string
>  	 * - the desc is used to match a key against search criteria
> @@ -296,6 +297,7 @@ extern struct key *key_alloc(struct key_type *type,
>  #define KEY_ALLOC_BYPASS_RESTRICTION	0x0008	/* Override the check on restricted keyrings */
>  #define KEY_ALLOC_UID_KEYRING		0x0010	/* allocating a user or user session keyring */
>  #define KEY_ALLOC_SET_KEEP		0x0020	/* Set the KEEP flag on the key/keyring */
> +#define KEY_ALLOC_ECA			0x0040	/* Add Endorsed CA key */
>  
>  extern void key_revoke(struct key *key);
>  extern void key_invalidate(struct key *key);
> diff --git a/security/keys/key.c b/security/keys/key.c
> index c45afdd1dfbb..e6b4946aca70 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -305,6 +305,8 @@ struct key *key_alloc(struct key_type *type, const char *desc,
>  		key->flags |= 1 << KEY_FLAG_UID_KEYRING;
>  	if (flags & KEY_ALLOC_SET_KEEP)
>  		key->flags |= 1 << KEY_FLAG_KEEP;
> +	if (flags & KEY_ALLOC_ECA)
> +		key->flags |= 1 << KEY_FLAG_ECA;
>  
>  #ifdef KEY_DEBUGGING
>  	key->magic = KEY_DEBUG_MAGIC;
> @@ -929,6 +931,12 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
>  			perm |= KEY_POS_WRITE;
>  	}
>  
> +	/* Only allow KEY_ALLOC_ECA flag to be set by preparser contents */
> +	if (prep.payload_flags & KEY_ALLOC_PECA)
> +		flags |= KEY_ALLOC_ECA;
> +	else
> +		flags &= ~KEY_ALLOC_ECA;
> +
>  	/* allocate a new key */
>  	key = key_alloc(index_key.type, index_key.description,
>  			cred->fsuid, cred->fsgid, cred, perm, flags, NULL);
> -- 
> 2.27.0
> 

BR, Jarkko
