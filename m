Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894CE6FE740
	for <lists+linux-integrity@lfdr.de>; Thu, 11 May 2023 00:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjEJWeZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 May 2023 18:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEJWeZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 May 2023 18:34:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95912691;
        Wed, 10 May 2023 15:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51BAC63486;
        Wed, 10 May 2023 22:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F95C433EF;
        Wed, 10 May 2023 22:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683758062;
        bh=5lwgpRirVMKMBfKNTdkYQ99GSADK6M/k974dY6LAvdk=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Olcc+CBQIv4nW6Km3essWppOa3Ja1MDp0fuZ9RPLj8MQ7s4CMpUCbvtBIOcAWlhoy
         dUhP6XlB0AxYgTf59rLC2g5wwEji7gpSs3PnMKA1uVX6Gq5zCNQg4Zyy8bfm0sRmhm
         /qieU245/ZzCd12vv0F56ikPtl6lwISrOFAP6Kebq1zJmtn10uBYZ6QhnsXIcuo6HR
         6sgnqUt5MuDmsYB7LfAiCNoJYV/6gwmzMCPm2+FnLulIDl8mYZlLEV+9amVz15HePL
         C/Nna3lcCnFnuOBJMRmzsnxkr5jkCR3+8NPfyJfAw/vxnAcYgzd8TT/rmxFVGz72Ke
         hY5ZDSHbTBDtw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 11 May 2023 01:34:17 +0300
Message-Id: <CSIYF14C6N58.7IDA6DAC9NHF@suppilovahvero>
Cc:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <dmitry.kasatkin@gmail.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <jlee@suse.com>,
        <kanth.ghatraju@oracle.com>, <konrad.wilk@oracle.com>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 1/3] KEYS: DigitalSignature link restriction
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Eric Snowberg" <eric.snowberg@oracle.com>, <zohar@linux.ibm.com>,
        <dhowells@redhat.com>, <dwmw2@infradead.org>
X-Mailer: aerc 0.14.0
References: <20230508220708.2888510-1-eric.snowberg@oracle.com>
 <20230508220708.2888510-2-eric.snowberg@oracle.com>
In-Reply-To: <20230508220708.2888510-2-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue May 9, 2023 at 1:07 AM EEST, Eric Snowberg wrote:
> Add a new link restriction.  Restrict the addition of keys in a keyring
> based on the key having digitalSignature usage set. Additionally, verify
> the new certificate against the ones in the system keyrings.  Add two
> additional functions to use the new restriction within either the builtin
> or secondary keyrings.
>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  certs/system_keyring.c            | 52 +++++++++++++++++++++++++++++++
>  crypto/asymmetric_keys/restrict.c | 44 ++++++++++++++++++++++++++
>  include/crypto/public_key.h       | 11 +++++++
>  include/keys/system_keyring.h     | 11 +++++++
>  4 files changed, 118 insertions(+)
>
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index a7a49b17ceb1..4249c49bd43b 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -51,6 +51,27 @@ int restrict_link_by_builtin_trusted(struct key *dest_=
keyring,
>  					  builtin_trusted_keys);
>  }
> =20
> +/**
> + * restrict_link_by_digsig_builtin - Restrict digitalSignature key addit=
ions
> + *   by the built-in keyring.

BTW, does checkpatch complain if you put that to a single line (I don't
know this)?

If not, I would just put "Restrict by digitalSignature"

> + * @dest_keyring: Keyring being linked to.
> + * @type: The type of key being added.
> + * @payload: The payload of the new key.
> + * @restriction_key: A ring of keys that can be used to vouch for the ne=
w cert.
> + *
> + * Restrict the addition of keys into a keyring based on the key-to-be-a=
dded
> + * being vouched for by a key in the built in system keyring. The new ke=
y
> + * must have the digitalSignature usage field set.
> + */
> +int restrict_link_by_digsig_builtin(struct key *dest_keyring,
> +				    const struct key_type *type,
> +				    const union key_payload *payload,
> +				    struct key *restriction_key)
> +{
> +	return restrict_link_by_digsig(dest_keyring, type, payload,
> +				       builtin_trusted_keys);
> +}
> +
>  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
>  /**
>   * restrict_link_by_builtin_and_secondary_trusted - Restrict keyring
> @@ -83,6 +104,37 @@ int restrict_link_by_builtin_and_secondary_trusted(
>  					  secondary_trusted_keys);
>  }
> =20
> +/**
> + * restrict_link_by_digsig_builtin_and_secondary - Restrict digitalSigna=
ture
> + *   key additions by both built-in and secondary keyrings.
> + * @dest_keyring: Keyring being linked to.
> + * @type: The type of key being added.
> + * @payload: The payload of the new key.
> + * @restrict_key: A ring of keys that can be used to vouch for the new c=
ert.
> + *
> + * Restrict the addition of keys into a keyring based on the key-to-be-a=
dded
> + * being vouched for by a key in either the built-in or the secondary sy=
stem
> + * keyrings. The new key must have the digitalSignature usage field set.
> + */
> +int restrict_link_by_digsig_builtin_and_secondary(
> +	struct key *dest_keyring,
> +	const struct key_type *type,
> +	const union key_payload *payload,
> +	struct key *restrict_key)
> +{
> +	/* If we have a secondary trusted keyring, then that contains a link
> +	 * through to the builtin keyring and the search will follow that link.
> +	 */
> +	if (type =3D=3D &key_type_keyring &&
> +	    dest_keyring =3D=3D secondary_trusted_keys &&
> +	    payload =3D=3D &builtin_trusted_keys->payload)
> +		/* Allow the builtin keyring to be added to the secondary */
> +		return 0;
> +
> +	return restrict_link_by_digsig(dest_keyring, type, payload,
> +				       secondary_trusted_keys);
> +}
> +
>  /*
>   * Allocate a struct key_restriction for the "builtin and secondary trus=
t"
>   * keyring. Only for use in system_trusted_keyring_init().
> diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/r=
estrict.c
> index 276bdb627498..6b69ea40da23 100644
> --- a/crypto/asymmetric_keys/restrict.c
> +++ b/crypto/asymmetric_keys/restrict.c
> @@ -148,6 +148,50 @@ int restrict_link_by_ca(struct key *dest_keyring,
>  	return 0;
>  }
> =20
> +/**
> + * restrict_link_by_digsig - Restrict additions to a ring of digsig keys
> + * @dest_keyring: Keyring being linked to.
> + * @type: The type of key being added.
> + * @payload: The payload of the new key.
> + * @trust_keyring: A ring of keys that can be used to vouch for the new =
cert.
> + *
> + * Check if the new certificate has digitalSignature usage set. If it is=
,
> + * then mark the new certificate as being ok to link. Afterwards verify
> + * the new certificate against the ones in the trust_keyring.
> + *
> + * Returns 0 if the new certificate was accepted, -ENOKEY if the
> + * certificate is not a digsig. -ENOPKG if the signature uses unsupporte=
d
> + * crypto, or some other error if there is a matching certificate but
> + * the signature check cannot be performed.
> + */
> +int restrict_link_by_digsig(struct key *dest_keyring,
> +			    const struct key_type *type,
> +			    const union key_payload *payload,
> +			    struct key *trust_keyring)
> +{
> +	const struct public_key *pkey;
> +
> +	if (type !=3D &key_type_asymmetric)
> +		return -EOPNOTSUPP;
> +
> +	pkey =3D payload->data[asym_crypto];
> +
> +	if (!pkey)
> +		return -ENOPKG;
> +
> +	if (!test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
> +		return -ENOKEY;
> +
> +	if (test_bit(KEY_EFLAG_CA, &pkey->key_eflags))
> +		return -ENOKEY;
> +
> +	if (test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
> +		return -ENOKEY;
> +
> +	return restrict_link_by_signature(dest_keyring, type, payload,
> +					  trust_keyring);
> +}
> +
>  static bool match_either_id(const struct asymmetric_key_id **pair,
>  			    const struct asymmetric_key_id *single)
>  {
> diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
> index 653992a6e941..8eb5eff059f3 100644
> --- a/include/crypto/public_key.h
> +++ b/include/crypto/public_key.h
> @@ -80,6 +80,10 @@ extern int restrict_link_by_ca(struct key *dest_keyrin=
g,
>  			       const struct key_type *type,
>  			       const union key_payload *payload,
>  			       struct key *trust_keyring);
> +int restrict_link_by_digsig(struct key *dest_keyring,
> +			    const struct key_type *type,
> +			    const union key_payload *payload,
> +			    struct key *trust_keyring);
>  #else
>  static inline int restrict_link_by_ca(struct key *dest_keyring,
>  				      const struct key_type *type,
> @@ -88,6 +92,13 @@ static inline int restrict_link_by_ca(struct key *dest=
_keyring,
>  {
>  	return 0;
>  }
> +static inline int restrict_link_by_digsig(struct key *dest_keyring,
> +					  const struct key_type *type,
> +					  const union key_payload *payload,
> +					  struct key *trust_keyring)
> +{
> +	return 0;
> +}
>  #endif
> =20
>  extern int query_asymmetric_key(const struct kernel_pkey_params *,
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.=
h
> index 91e080efb918..38f63f1c2cbe 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -23,10 +23,15 @@ extern int restrict_link_by_builtin_trusted(struct ke=
y *keyring,
>  					    const struct key_type *type,
>  					    const union key_payload *payload,
>  					    struct key *restriction_key);
> +int restrict_link_by_digsig_builtin(struct key *dest_keyring,
> +				    const struct key_type *type,
> +				    const union key_payload *payload,
> +				    struct key *restriction_key);
>  extern __init int load_module_cert(struct key *keyring);
> =20
>  #else
>  #define restrict_link_by_builtin_trusted restrict_link_reject
> +#define restrict_link_by_digsig_builtin restrict_link_reject
> =20
>  static inline __init int load_module_cert(struct key *keyring)
>  {
> @@ -41,8 +46,14 @@ extern int restrict_link_by_builtin_and_secondary_trus=
ted(
>  	const struct key_type *type,
>  	const union key_payload *payload,
>  	struct key *restriction_key);
> +extern int restrict_link_by_digsig_builtin_and_secondary(
> +	struct key *keyring,
> +	const struct key_type *type,
> +	const union key_payload *payload,
> +	struct key *restriction_key);
>  #else
>  #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_=
builtin_trusted
> +#define restrict_link_by_digsig_builtin_and_secondary restrict_link_by_d=
igsig_builtin
>  #endif
> =20
>  #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
> --=20
> 2.27.0

BR, Jarkko
