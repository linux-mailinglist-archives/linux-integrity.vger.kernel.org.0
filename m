Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799CB504827
	for <lists+linux-integrity@lfdr.de>; Sun, 17 Apr 2022 17:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbiDQPIR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 17 Apr 2022 11:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDQPIQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 17 Apr 2022 11:08:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE4AEBA;
        Sun, 17 Apr 2022 08:05:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 765716122A;
        Sun, 17 Apr 2022 15:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58033C385A7;
        Sun, 17 Apr 2022 15:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650207934;
        bh=TCEyh3gyXRnZ90K4gJfzgIbuDBywNlbZ2X/YTY7EWds=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vJjQVh9/cnR4yymb1LjBhXhoIw0pYfMbOeY1gn3uSvU9VydPRBdO35sIimj9rsakq
         6jkPV3DyMwZck+8d43DTLrbJMJVSJtm+X7bBnLAFqjA03Bb0Y2x1n8eDbVpiv56OXx
         Kuu/gZ3b4t5eRiSLBOd6y06RCvOm4Qqm80qh8UkSatyKKaTu6suGei7chJ0YVeYGmC
         B+wB/t0VZ7coxtI9FHVqCAAiUpe1dhX39jPvuYfNQvhV/4glP5LdP7xp1IFJVUPa6z
         QpOZ9GWL2NW3o0MOUFOEOkNUhDYyJL8ORp0JdDkKdu2odeJBCUaeZAr6smXOdoM3S2
         Ukewjhj+5ZIEg==
Message-ID: <45b00778d60cdef80f89041e5c9597d78c0d8ae7.camel@kernel.org>
Subject: Re: [PATCH v7 4/6] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     kernel@pengutronix.de, David Gstir <david@sigma-star.at>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Horia =?UTF-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Sun, 17 Apr 2022 18:04:24 +0300
In-Reply-To: <20220415205647.46056-5-a.fatoum@pengutronix.de>
References: <20220415205647.46056-1-a.fatoum@pengutronix.de>
         <20220415205647.46056-5-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-04-15 at 22:56 +0200, Ahmad Fatoum wrote:
> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
> built into many newer i.MX and QorIQ SoCs by NXP.
>=20
> The CAAM does crypto acceleration, hardware number generation and
> has a blob mechanism for encapsulation/decapsulation of sensitive materia=
l.
>=20
> This blob mechanism depends on a device specific random 256-bit One Time
> Programmable Master Key that is fused in each SoC at manufacturing
> time. This key is unreadable and can only be used by the CAAM for AES
> encryption/decryption of user data.
>=20
> This makes it a suitable backend (source) for kernel trusted keys.
>=20
> Previous commits generalized trusted keys to support multiple backends
> and added an API to access the CAAM blob mechanism. Based on these,
> provide the necessary glue to use the CAAM for trusted keys.
>=20
> Reviewed-by: David Gstir <david@sigma-star.at>
> Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> Tested-by: Tim Harvey <tharvey@gateworks.com>
> Tested-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Tested-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> v6 -> v7:
> =C2=A0 - Split off MAINTAINERS and documentation chanes into separate pat=
ches
> =C2=A0=C2=A0=C2=A0 (Jarkko)
> =C2=A0 - Use new struct caam_blob_info API (Pankaj)
> v5 -> v6:
> =C2=A0 - Rename caam_trusted_key_ops to trusted_key_caam_ops for symmetry
> =C2=A0=C2=A0=C2=A0 with other trust sources (Pankaj)
> =C2=A0 - Collected Pankaj's Reviewed-by
> v4 -> v5:
> =C2=A0 - Collected Reviewed-by's and Tested-by's
> =C2=A0 - Changed modifier to SECURE_KEY for compatibility with linux-imx
> =C2=A0=C2=A0=C2=A0 (Matthias)
> v3 -> v4:
> =C2=A0 - Collected Acked-by's, Reviewed-by's and Tested-by
> v2 -> v3:
> =C2=A0- add MAINTAINERS entry
> v1 -> v2:
> =C2=A0- Extend trusted keys documentation for CAAM
>=20
> To: David Howells <dhowells@redhat.com>
> To: Jarkko Sakkinen <jarkko@kernel.org>
> To: James Bottomley <jejb@linux.ibm.com>
> To: Mimi Zohar <zohar@linux.ibm.com>
> To: Jonathan Corbet <corbet@lwn.net>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: "Horia Geant=C4=83" <horia.geanta@nxp.com>
> Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Jan Luebbe <j.luebbe@pengutronix.de>
> Cc: David Gstir <david@sigma-star.at>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Franck LENORMAND <franck.lenormand@nxp.com>
> Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: keyrings@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> ---
> =C2=A0.../admin-guide/kernel-parameters.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0include/keys/trusted_caam.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 =
+++
> =C2=A0security/keys/trusted-keys/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 ++-
> =C2=A0security/keys/trusted-keys/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +
> =C2=A0security/keys/trusted-keys/trusted_caam.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
 82 +++++++++++++++++++
> =C2=A0security/keys/trusted-keys/trusted_core.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 6 +-
> =C2=A06 files changed, 111 insertions(+), 2 deletions(-)
> =C2=A0create mode 100644 include/keys/trusted_caam.h
> =C2=A0create mode 100644 security/keys/trusted-keys/trusted_caam.c
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 4deed1908a75..9afb7046ce97 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5958,6 +5958,7 @@
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sou=
rces:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- "=
tpm"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- "=
tee"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- "caam"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0If =
not specified then it defaults to iterating through
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0the=
 trust source list starting with TPM and assigns the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fir=
st trust source as a backend which is initialized
> diff --git a/include/keys/trusted_caam.h b/include/keys/trusted_caam.h
> new file mode 100644
> index 000000000000..73fe2f32f65e
> --- /dev/null
> +++ b/include/keys/trusted_caam.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
> + */
> +
> +#ifndef __CAAM_TRUSTED_KEY_H
> +#define __CAAM_TRUSTED_KEY_H
> +
> +extern struct trusted_key_ops trusted_key_caam_ops;
> +
> +#endif
> diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-k=
eys/Kconfig
> index fc4abd581abb..dbfdd8536468 100644
> --- a/security/keys/trusted-keys/Kconfig
> +++ b/security/keys/trusted-keys/Kconfig
> @@ -24,6 +24,15 @@ config TRUSTED_KEYS_TEE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enable use of the =
Trusted Execution Environment (TEE) as trusted
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key backend.
> =C2=A0
> -if !TRUSTED_KEYS_TPM && !TRUSTED_KEYS_TEE
> +config TRUSTED_KEYS_CAAM
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "CAAM-based trusted keys"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on CRYPTO_DEV_FSL_CAAM=
_JR >=3D TRUSTED_KEYS
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select CRYPTO_DEV_FSL_CAAM_BLO=
B_GEN
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default y
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enable use of NXP's Cry=
ptographic Accelerator and Assurance Module
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (CAAM) as trusted key b=
ackend.
> +
> +if !TRUSTED_KEYS_TPM && !TRUSTED_KEYS_TEE && !TRUSTED_KEYS_CAAM
> =C2=A0comment "No trust source selected!"
> =C2=A0endif
> diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-=
keys/Makefile
> index 2e2371eae4d5..735aa0bc08ef 100644
> --- a/security/keys/trusted-keys/Makefile
> +++ b/security/keys/trusted-keys/Makefile
> @@ -12,3 +12,5 @@ trusted-$(CONFIG_TRUSTED_KEYS_TPM) +=3D trusted_tpm2.o
> =C2=A0trusted-$(CONFIG_TRUSTED_KEYS_TPM) +=3D tpm2key.asn1.o
> =C2=A0
> =C2=A0trusted-$(CONFIG_TRUSTED_KEYS_TEE) +=3D trusted_tee.o
> +
> +trusted-$(CONFIG_TRUSTED_KEYS_CAAM) +=3D trusted_caam.o
> diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/tr=
usted-keys/trusted_caam.c
> new file mode 100644
> index 000000000000..46cb2484ec36
> --- /dev/null
> +++ b/security/keys/trusted-keys/trusted_caam.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
> + */
> +
> +#include <keys/trusted_caam.h>
> +#include <keys/trusted-type.h>
> +#include <linux/build_bug.h>
> +#include <linux/key-type.h>
> +#include <soc/fsl/caam-blob.h>
> +
> +static struct caam_blob_priv *blobifier;
> +
> +#define KEYMOD "SECURE_KEY"
> +
> +static_assert(MAX_KEY_SIZE + CAAM_BLOB_OVERHEAD <=3D CAAM_BLOB_MAX_LEN);
> +static_assert(MAX_BLOB_SIZE <=3D CAAM_BLOB_MAX_LEN);
> +
> +static int trusted_caam_seal(struct trusted_key_payload *p, char *databl=
ob)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct caam_blob_info info =3D=
 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0.input=C2=A0 =3D p->key,=C2=A0 .input_len=C2=A0=C2=A0 =3D=
 p->key_len,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0.output =3D p->blob, .output_len=C2=A0 =3D MAX_BLOB_SIZE,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0.key_mod =3D KEYMOD, .key_mod_len =3D sizeof(KEYMOD) - 1,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D caam_encap_blob(blobif=
ier, &info);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return ret;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0p->blob_len =3D info.output_le=
n;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> +}
> +
> +static int trusted_caam_unseal(struct trusted_key_payload *p, char *data=
blob)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct caam_blob_info info =3D=
 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0.input=C2=A0=C2=A0 =3D p->blob,=C2=A0 .input_len=C2=A0 =
=3D p->blob_len,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0.output=C2=A0 =3D p->key,=C2=A0=C2=A0 .output_len =3D MAX=
_KEY_SIZE,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0.key_mod =3D KEYMOD,=C2=A0 .key_mod_len =3D sizeof(KEYMOD=
) - 1,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D caam_decap_blob(blobif=
ier, &info);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return ret;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0p->key_len =3D info.output_len=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> +}
> +
> +static int trusted_caam_init(void)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0blobifier =3D caam_blob_gen_in=
it();
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(blobifier)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0pr_err("Job Ring Device allocation for transform failed\n=
");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return PTR_ERR(blobifier);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D register_key_type(&key=
_type_trusted);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0caam_blob_gen_exit(blobifier);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> +}
> +
> +static void trusted_caam_exit(void)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unregister_key_type(&key_type_=
trusted);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0caam_blob_gen_exit(blobifier);
> +}
> +
> +struct trusted_key_ops trusted_key_caam_ops =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.migratable =3D 0, /* non-migr=
atable */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.init =3D trusted_caam_init,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.seal =3D trusted_caam_seal,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.unseal =3D trusted_caam_unsea=
l,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.exit =3D trusted_caam_exit,
> +};
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/tr=
usted-keys/trusted_core.c
> index 9235fb7d0ec9..c6fc50d67214 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -9,6 +9,7 @@
> =C2=A0#include <keys/user-type.h>
> =C2=A0#include <keys/trusted-type.h>
> =C2=A0#include <keys/trusted_tee.h>
> +#include <keys/trusted_caam.h>
> =C2=A0#include <keys/trusted_tpm.h>
> =C2=A0#include <linux/capability.h>
> =C2=A0#include <linux/err.h>
> @@ -29,7 +30,7 @@ MODULE_PARM_DESC(rng, "Select trusted key RNG");
> =C2=A0
> =C2=A0static char *trusted_key_source;
> =C2=A0module_param_named(source, trusted_key_source, charp, 0);
> -MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
> +MODULE_PARM_DESC(source, "Select trusted keys source (tpm, tee or caam)"=
);
> =C2=A0
> =C2=A0static const struct trusted_key_source trusted_key_sources[] =3D {
> =C2=A0#if defined(CONFIG_TRUSTED_KEYS_TPM)
> @@ -38,6 +39,9 @@ static const struct trusted_key_source trusted_key_sour=
ces[] =3D {
> =C2=A0#if defined(CONFIG_TRUSTED_KEYS_TEE)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ "tee", &trusted_key_tee=
_ops },
> =C2=A0#endif
> +#if defined(CONFIG_TRUSTED_KEYS_CAAM)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ "caam", &trusted_key_caam_op=
s },
> +#endif
> =C2=A0};
> =C2=A0
> =C2=A0DEFINE_STATIC_CALL_NULL(trusted_key_init, *trusted_key_sources[0].o=
ps->init);


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

