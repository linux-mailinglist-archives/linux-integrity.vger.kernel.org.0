Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8DEADD007
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Oct 2019 22:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443434AbfJRUZz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Oct 2019 16:25:55 -0400
Received: from sonic312-30.consmr.mail.gq1.yahoo.com ([98.137.69.211]:39618
        "EHLO sonic312-30.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2505990AbfJRUZ3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Oct 2019 16:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571430327; bh=phgYHNnQHoGX/oaAuG+5aUwvA92bi7BKFaw0LniZzPY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=GlWmiEmKVw5wbRtSXgpBYle4cOr/fGQJCOuUabQn0+NDWLn8w503z+4LjjF3a8DkepAcpsluZhoU2tStuBecTgsFblNATmXGPUz5guki0rRsvErBBBUnwejuSsQ5Vkuf2PPsSC4wOxsi8pHvD1eu2VjtHa+Nxf+6mFdKi2LkjHOvgEBzeEfdrV18vs1H30YfEj48+dObSz6vCBh1Rw25HuTcdg0dGNBztkyqagBrH/GQ///k6QzN/BqdSkjfuYlDEBKkPpyitX/qW8MaNQikCCmgBS3qCbKShsDClVX4SL7sz8+uc7qHS8KGOVxcyfO0bgZFV5cmwWEThpssUhS5DQ==
X-YMail-OSG: AK7GjPYVM1k6PSQ5QIPDXWylK00vUPcK.I.oz5wB3VBQZfumMjuTW67j2bZh.P9
 yq1UkMjBZrZ7ZRK8_sqO3GjMdrqsr6BAsTekyfCjt8qWqQfLHTKk0fTs2x0MedXF1helB8.LG04r
 nivlsUqKLjGwzo5nhzl3T8.LPtX.NTSfrCkxWIy03lGfJJOzn9c9rAglmvDgb80fsjmECSkSc8jv
 jBi1ujF5warxrREjP86ON6ZjjOYLNkabFESEXMjcgMUAN7_O970EiMKDmgJJdjLwA4W_0oMQkudJ
 fzVi965BZa79jcRaR2CSp6fuymH4yjtdEXrhJYzM6SXiiAnm32UaCdyuosw04xfvO1XeexZirL4l
 shxLoFWpy5V3isdf0aYKiOte1.Fsp.uxISoDKp4.GdeOalit4u8lYZpXF2NdoZuFvRJ_myFmGoBD
 RRXkyO1Jwehlkfin6t2YA5JE4MwFSM5TKluOrwma8WiVta6K02BB_MV2et8dKDNgGFGZf66EZGqY
 qBH.3vKNzrOh1tfFaSJmLixs914VI9ZNI49pGEaQiwTrGaxpgEbBHRSXIDgtaD1D8ej.rgQq0kz5
 spCsnexI8htByQ94DyGPehxu0D9b.wvqaHGKZBcbF9Pi7o1CiJCDgYwTwM6uNm3A1aa42r_iZ_QM
 e2jpacCKEurIhTELK1EPQ6KpvrjJoJlgljdTru3q2Dow1M1lSValAgJSmSvoQaP3WK6NiQepub7O
 EplehYARjb6j.MunoK9.VGZy3BrVV5SdzACj4jI5Y18rmOUbN6O4V.5xtTsY584NVUGMtOO_wNR3
 .69NO_kXWrcwBRSaJyh3_LP_pRU2WoviPAIbeaATinZEyglpVmxYTgMAoW0FvLEvnWKsnqXE4KqU
 rW6rElVy6tYhtm8kCq.WmRO1FtOvTON3mmOhoj.sY3VeWMWvdxeDZ35PO.BUZz4gb98xDVps3QRt
 gkMvKzk.HAWe5L2PfUGef3Qbe0Qj7CRZ6lkNi2AK6L8ELJ5dUQl_6_F8mdg45d9VgKPTlCXTPtx1
 et2ED76HWj.OnXf.U01HV7e4x6mBSJdbkV4L_f6px..7YLa2Wgx3M_y6jm85FR9X37TktGfMAsjg
 e6edG.NtzA.3Qu3i2gVCWYFl0aESEDBtdVpEt3wOmSLPY_bGvBKzvnCw9GInxKg_R8J_5Wto6K6_
 8FrLcHfEqvpuHzRathc9usiHvM3qPZ9ExchuotgKeiJ1P8XZqQAzERGzxN0SL.JT24NqEhCDoPck
 Nafpj7ZCq2hrrRBrJAcvLy9RBsLfEYoNK7dNfURo8U2sjmjYmwP152q9aczyJ7KqvFv9eukQQ50e
 QqkosOLdUtjH0P_3fieI1btoCpqUcbNGaIc9SxYDRozc1UENU.iEC9wylOFk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Fri, 18 Oct 2019 20:25:27 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7f147f6f617c7f4e02fb61df8a2a81af;
          Fri, 18 Oct 2019 20:25:24 +0000 (UTC)
Subject: Re: [PATCH v0] KEYS: Security LSM Hook for key_create_or_update
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, dhowells@redhat.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        sashal@kernel.org, jamorris@linux.microsoft.com
Cc:     msft-linux-kernel@linux.microsoft.com, prsriva@linux.microsoft.com,
        casey@schaufler-ca.com
References: <20191018195328.6704-1-nramas@linux.microsoft.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <e5ffe76e-ff9f-7542-2ff7-3ede4f911c2a@schaufler-ca.com>
Date:   Fri, 18 Oct 2019 13:25:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018195328.6704-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/18/2019 12:53 PM, Lakshmi Ramasubramanian wrote:
> Problem Statement:
> key_create_or_update function currently does not have
> a security LSM hook. The hook is needed to allow security
> subsystems to use key create or update information.

What security module(s) do you expect to use this?

> security_key_alloc LSM hook that is currently available is not
> providing enough information about the key (the key payload,
> the target keyring, etc.). Also, this LSM hook is only available
> for key create.
>
> Changes made:
> Adding a new LSM hook for key key_create_or_update,
> security_key_create_or_update, which is called after
>    => A newly created key is instantiated and linked to the target
>       keyring (__key_instantiate_and_link).
>    => An existing key is updated with a new payload (__key_update)
>
> security_key_create_or_update is passed the target keyring, key,
> cred, key creation flags, and a boolean flag indicating whether
> the key was newly created or updated.
>
> Security subsystems can use this hook for handling key create or update.
> For example, IMA subsystem can measure the key when it is created or
> updated.

IMA is not a Linux Security Module.

> Testing performed:
>   * Booted the kernel with this change.
>   * Executed keyctl tests from the Linux Test Project (LTP)
>   * Added a new key to a keyring and verified "key create" code path.
>     => In this case added a key to builtin_trusted_keys keyring.
>   * Added the same key again and verified "key update" code path.
>     => Add the same key to builtin_trusted_keys keyring.
>     => find_key_to_update found the key and LSM hook was
>        called for key update (create flag set to false).
>   * Forced the LSM hook (security_key_create_or_update) to
>     return an error and verified that the key was not added to
>     the keyring ("keyctl list <keyring>" does not list the key).
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  include/linux/lsm_hooks.h | 13 +++++++
>  include/linux/security.h  | 10 +++++
>  security/keys/key.c       | 78 ++++++++++++++++++++++++++++++++++-----
>  security/security.c       |  8 ++++

You don't have a security module that provides this hook.
We don't accept interfaces without users.

>  4 files changed, 100 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index df1318d85f7d..2f2e95df62f3 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1066,6 +1066,15 @@
>   *
>   * Security hooks affecting all Key Management operations
>   *
> + * @key_create_or_update:
> + *      Notification of key create or update.
> + *      @keyring points to the keyring to which the key belongs
> + *      @key points to the key being created or updated
> + *      @cred current cred
> + *      @flags is the allocation flags
> + *      @create flag set to true if the key was created.
> + *              flag set to false if the key was updated.
> + *      Return 0 if permission is granted, -ve error otherwise.
>   * @key_alloc:
>   *	Permit allocation of a key and assign security data. Note that key does
>   *	not have a serial number assigned at this point.
> @@ -1781,6 +1790,9 @@ union security_list_options {
>  
>  	/* key management security hooks */
>  #ifdef CONFIG_KEYS
> +	int (*key_create_or_update)(struct key *keyring, struct key *key,
> +				    const struct cred *cred,
> +				    unsigned long flags, bool create);
>  	int (*key_alloc)(struct key *key, const struct cred *cred,
>  				unsigned long flags);
>  	void (*key_free)(struct key *key);
> @@ -2026,6 +2038,7 @@ struct security_hook_heads {
>  	struct hlist_head xfrm_decode_session;
>  #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
>  #ifdef CONFIG_KEYS
> +	struct hlist_head key_create_or_update;
>  	struct hlist_head key_alloc;
>  	struct hlist_head key_free;
>  	struct hlist_head key_permission;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 5f7441abbf42..27e1c0a3057b 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1672,6 +1672,9 @@ static inline int security_path_chroot(const struct path *path)
>  #ifdef CONFIG_KEYS
>  #ifdef CONFIG_SECURITY
>  
> +int security_key_create_or_update(struct key *keyring, struct key *key,
> +				  const struct cred *cred,
> +				  unsigned long flags, bool create);
>  int security_key_alloc(struct key *key, const struct cred *cred, unsigned long flags);
>  void security_key_free(struct key *key);
>  int security_key_permission(key_ref_t key_ref,
> @@ -1680,6 +1683,13 @@ int security_key_getsecurity(struct key *key, char **_buffer);
>  
>  #else
>  
> +int security_key_create_or_update(struct key *keyring, struct key *key,
> +				  const struct cred *cred,
> +				  unsigned long flags, bool create)
> +{
> +	return 0;
> +}
> +
>  static inline int security_key_alloc(struct key *key,
>  				     const struct cred *cred,
>  				     unsigned long flags)
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 764f4c57913e..b913feaf196e 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -781,7 +781,7 @@ static inline key_ref_t __key_update(key_ref_t key_ref,
>  }
>  
>  /**
> - * key_create_or_update - Update or create and instantiate a key.
> + * __key_create_or_update - Update or create and instantiate a key.
>   * @keyring_ref: A pointer to the destination keyring with possession flag.
>   * @type: The type of key.
>   * @description: The searchable description for the key.
> @@ -789,6 +789,8 @@ static inline key_ref_t __key_update(key_ref_t key_ref,
>   * @plen: The length of @payload.
>   * @perm: The permissions mask for a new key.
>   * @flags: The quota flags for a new key.
> + * @create: Set to true if the key was newly created.
> + *          Set to false if the key was updated.
>   *
>   * Search the destination keyring for a key of the same description and if one
>   * is found, update it, otherwise create and instantiate a new one and create a
> @@ -805,13 +807,14 @@ static inline key_ref_t __key_update(key_ref_t key_ref,
>   * On success, the possession flag from the keyring ref will be tacked on to
>   * the key ref before it is returned.
>   */
> -key_ref_t key_create_or_update(key_ref_t keyring_ref,
> -			       const char *type,
> -			       const char *description,
> -			       const void *payload,
> -			       size_t plen,
> -			       key_perm_t perm,
> -			       unsigned long flags)
> +static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
> +					const char *type,
> +					const char *description,
> +					const void *payload,
> +					size_t plen,
> +					key_perm_t perm,
> +					unsigned long flags,
> +					bool *create)
>  {
>  	struct keyring_index_key index_key = {
>  		.description	= description,
> @@ -936,6 +939,7 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
>  		goto error_link_end;
>  	}
>  
> +	*create = true;
>  	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
>  
>  error_link_end:
> @@ -948,7 +952,7 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
>  error:
>  	return key_ref;
>  
> - found_matching_key:
> +found_matching_key:
>  	/* we found a matching key, so we're going to try to update it
>  	 * - we can drop the locks first as we have the key pinned
>  	 */
> @@ -964,9 +968,65 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
>  		}
>  	}
>  
> +	*create = false;
>  	key_ref = __key_update(key_ref, &prep);
>  	goto error_free_prep;
>  }
> +
> +/**
> + * key_create_or_update - Update or create and instantiate a key.
> + * @keyring_ref: A pointer to the destination keyring with possession flag.
> + * @type: The type of key.
> + * @description: The searchable description for the key.
> + * @payload: The data to use to instantiate or update the key.
> + * @plen: The length of @payload.
> + * @perm: The permissions mask for a new key.
> + * @flags: The quota flags for a new key.
> + *
> + * Calls the internal function __key_create_or_update.
> + * If successful calls the security LSM hook.
> + */
> +key_ref_t key_create_or_update(key_ref_t keyring_ref,
> +			       const char *type,
> +			       const char *description,
> +			       const void *payload,
> +			       size_t plen,
> +			       key_perm_t perm,
> +			       unsigned long flags)
> +{
> +	key_ref_t key_ref;
> +	struct key *keyring, *key = NULL;
> +	int ret = 0;
> +	bool create = false;
> +
> +	key_ref = __key_create_or_update(keyring_ref, type, description,
> +					 payload, plen, perm, flags,
> +					 &create);
> +	if (IS_ERR(key_ref))
> +		goto out;
> +
> +	keyring = key_ref_to_ptr(keyring_ref);
> +	key = key_ref_to_ptr(key_ref);
> +
> +	/* let the security module know about
> +	 * the created or updated key.
> +	 */
> +	ret = security_key_create_or_update(keyring, key,
> +					    current_cred(),
> +					    flags, create);
> +	if (ret < 0)
> +		goto security_error;
> +	else
> +		goto out;
> +
> +security_error:
> +	key_unlink(keyring, key);
> +	key_put(key);
> +	key_ref = ERR_PTR(ret);
> +
> +out:
> +	return key_ref;
> +}
>  EXPORT_SYMBOL(key_create_or_update);
>  
>  /**
> diff --git a/security/security.c b/security/security.c
> index 250ee2d76406..fc1e4984fb53 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2280,6 +2280,14 @@ EXPORT_SYMBOL(security_skb_classify_flow);
>  
>  #ifdef CONFIG_KEYS
>  
> +int security_key_create_or_update(struct key *keyring, struct key *key,
> +				  const struct cred *cred,
> +				  unsigned long flags, bool create)
> +{
> +	return call_int_hook(key_create_or_update, 0,
> +			     keyring, key, cred, flags, create);
> +}
> +
>  int security_key_alloc(struct key *key, const struct cred *cred,
>  		       unsigned long flags)
>  {
