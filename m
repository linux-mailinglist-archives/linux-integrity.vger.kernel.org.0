Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FEF6B613F
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Mar 2023 22:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCKVwx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Mar 2023 16:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjCKVwu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Mar 2023 16:52:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0DD4E5CE;
        Sat, 11 Mar 2023 13:52:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F436B80066;
        Sat, 11 Mar 2023 21:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBF3C433EF;
        Sat, 11 Mar 2023 21:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678571527;
        bh=4ihtkamQW1DKeXGj7i+4ho2sOjUjujw9GnHfOu6wzLI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sz9VV5mz2YtNPMQCPMir3pAN+2eSzIV/hVgQCLUv6WCO1H+xb50FJ3bHMWZGoLv62
         ZuBCDrjxE5mvY7yXhgP/c6Whkx9MpLlA9aUTwaqdr1gGo+Zxg7OYbdKtdbQdMlwTym
         y6hdahKeHbm9Rnh7oyxTydbZOfZ8XFq1oSSLTB7BDVe59TeoB6iAdRBT/pLdS5dyIa
         oDAoNPfcguNa2x/n62/Zre+KBx/kRnqo3qubKiSPBll56oWACoB109vYEA2RA1d6nC
         X+vlgY3c0KVmmADyrWeyi1ylXI3Q6URdJWr4wf2CXmyb5PN39jtm3OMmCBoC71nHnb
         iyTVdVdcd5XWw==
Message-ID: <e0558e9ece8bfd413080aa3101f2e3d7f746a5e2.camel@kernel.org>
Subject: Re: [PATCH v5 1/6] KEYS: Create static version of
 public_key_verify_signature
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>, zohar@linux.ibm.com,
        dhowells@redhat.com, dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, erpalmer@linux.vnet.ibm.com,
        coxu@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Sat, 11 Mar 2023 23:52:05 +0200
In-Reply-To: <20230302164652.83571-2-eric.snowberg@oracle.com>
References: <20230302164652.83571-1-eric.snowberg@oracle.com>
         <20230302164652.83571-2-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-03-02 at 11:46 -0500, Eric Snowberg wrote:
> The kernel test robot reports undefined reference to
> public_key_verify_signature when CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> is
> not defined. Create a static version in this case and return -EINVAL.
>=20
> Fixes: db6c43bd2132 ("crypto: KEYS: convert public key and digsig
> asym to the akcipher api")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
> =C2=A0include/crypto/public_key.h | 9 +++++++++
> =C2=A01 file changed, 9 insertions(+)
>=20
> diff --git a/include/crypto/public_key.h
> b/include/crypto/public_key.h
> index 68f7aa2a7e55..6d61695e1cde 100644
> --- a/include/crypto/public_key.h
> +++ b/include/crypto/public_key.h
> @@ -80,7 +80,16 @@ extern int create_signature(struct
> kernel_pkey_params *, const void *, void *);
> =C2=A0extern int verify_signature(const struct key *,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 const struct public_key_signature *);
> =C2=A0
> +#if IS_REACHABLE(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE)
> =C2=A0int public_key_verify_signature(const struct public_key *pkey,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct public_key_signat=
ure
> *sig);
> +#else
> +static inline
> +int public_key_verify_signature(const struct public_key *pkey,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct public_key_signature
> *sig)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> +}
> +#endif
> =C2=A0
> =C2=A0#endif /* _LINUX_PUBLIC_KEY_H */

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
