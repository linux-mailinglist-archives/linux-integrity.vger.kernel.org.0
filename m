Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C18F33DD53
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Mar 2021 20:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbhCPTWs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Mar 2021 15:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234990AbhCPTWk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Mar 2021 15:22:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E870D65061;
        Tue, 16 Mar 2021 19:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615922559;
        bh=zg65Pn1r3cXmZ68Zj9qDDZ2iLpobA6DjNNZemVWYfXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HpoautR6qNDWPE2QlXP5cZF13tXQgMfXBEoaqM/R32UyMWeeuXXUGEoQz85frM8GG
         ebu0MBOo1S8ciNndBDKlI26RwrhnBv4fhnktaQoWISiVL6Mx8fMJnYFyTVHjdi+YYi
         zdxRn0pNDuTAzSUzzVv3T5JI9rhcLSV1pFPVsorfyDWDMxUkwZdfBGqTIXRJj02SCV
         S0IBACa7l3uqHAk+CdOoOpadvNkP+1lRUIVu9OIkyuH0XvOPMxDM4q3wdKON03HIxT
         RkK0nZrnUqjGeHNhdhQYnCwB9aL7mEph5OhSCIWXRY/uKmDvDbGAd6iQR4R024Kdgo
         PNP2TdxzKrpgw==
Date:   Tue, 16 Mar 2021 21:22:14 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>, kernel@pengutronix.de,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@penutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 3/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Message-ID: <YFEFZujgsMpX7VbU@kernel.org>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 16, 2021 at 06:01:18PM +0100, Ahmad Fatoum wrote:
> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
> built into many newer i.MX and QorIQ SoCs by NXP.
> 
> The CAAM does crypto acceleration, hardware number generation and
> has a blob mechanism for encapsulation/decapsulation of sensitive material.
> 
> This blob mechanism depends on a device specific random 256-bit One Time
> Programmable Master Key that is fused in each SoC at manufacturing
> time. This key is unreadable and can only be used by the CAAM for AES
> encryption/decryption of user data.
> 
> This makes it a suitable backend (source) for kernel trusted keys.
> 
> Previous commits generalized trusted keys to support multiple backends
> and added an API to access the CAAM blob mechanism. Based on these,
> provide the necessary glue to use the CAAM for trusted keys.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> To: Jonathan Corbet <corbet@lwn.net>
> To: David Howells <dhowells@redhat.com>
> To: Jarkko Sakkinen <jarkko@kernel.org>
> To: James Bottomley <jejb@linux.ibm.com>
> To: Mimi Zohar <zohar@linux.ibm.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: "Horia Geantă" <horia.geanta@nxp.com>
> Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Udit Agarwal <udit.agarwal@nxp.com>
> Cc: Jan Luebbe <j.luebbe@penutronix.de>
> Cc: David Gstir <david@sigma-star.at>
> Cc: Franck LENORMAND <franck.lenormand@nxp.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: keyrings@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  1 +-
>  include/keys/trusted_caam.h                     | 11 +++-
>  security/keys/trusted-keys/Makefile             |  1 +-
>  security/keys/trusted-keys/trusted_caam.c       | 74 ++++++++++++++++++-
>  security/keys/trusted-keys/trusted_core.c       |  6 +-
>  5 files changed, 92 insertions(+), 1 deletion(-)
>  create mode 100644 include/keys/trusted_caam.h
>  create mode 100644 security/keys/trusted-keys/trusted_caam.c
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c8bad1762cba..382e911389aa 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5469,6 +5469,7 @@
>  			sources:
>  			- "tpm"
>  			- "tee"
> +			- "caam"
>  			If not specified then it defaults to iterating through
>  			the trust source list starting with TPM and assigns the
>  			first trust source as a backend which is initialized
> diff --git a/include/keys/trusted_caam.h b/include/keys/trusted_caam.h
> new file mode 100644
> index 000000000000..2fba0996b0b0
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
> +extern struct trusted_key_ops caam_trusted_key_ops;
> +
> +#endif
> diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
> index feb8b6c3cc79..050370690abd 100644
> --- a/security/keys/trusted-keys/Makefile
> +++ b/security/keys/trusted-keys/Makefile
> @@ -12,3 +12,4 @@ trusted-y += trusted_tpm2.o
>  trusted-y += tpm2key.asn1.o
>  
>  trusted-$(CONFIG_TEE) += trusted_tee.o
> +trusted-$(CONFIG_CRYPTO_DEV_FSL_CAAM_BLOB_GEN) += trusted_caam.o
> diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
> new file mode 100644
> index 000000000000..fc2e3dde9e06
> --- /dev/null
> +++ b/security/keys/trusted-keys/trusted_caam.c
> @@ -0,0 +1,74 @@
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
> +struct caam_blob_priv *blobifier;
> +
> +#define KEYMOD "kernel:trusted"
> +
> +static_assert(MAX_KEY_SIZE + CAAM_BLOB_OVERHEAD <= CAAM_BLOB_MAX_LEN);
> +static_assert(MAX_BLOB_SIZE <= CAAM_BLOB_MAX_LEN);
> +
> +static int trusted_caam_seal(struct trusted_key_payload *p, char *datablob)
> +{
> +	int length = p->key_len + CAAM_BLOB_OVERHEAD;
> +	int ret;
> +
> +	ret = caam_encap_blob(blobifier, KEYMOD, p->key, p->blob, length);
> +	if (ret)
> +		return ret;
> +
> +	p->blob_len = length;
> +	return 0;
> +}
> +
> +static int trusted_caam_unseal(struct trusted_key_payload *p, char *datablob)
> +{
> +	int length = p->blob_len;
> +	int ret;
> +
> +	ret = caam_decap_blob(blobifier, KEYMOD, p->blob, p->key, length);
> +	if (ret)
> +		return ret;
> +
> +	p->key_len = length - CAAM_BLOB_OVERHEAD;
> +	return 0;
> +}
> +
> +static int trusted_caam_init(void)
> +{
> +	int ret;
> +
> +	blobifier = caam_blob_gen_init();
> +	if (IS_ERR(blobifier)) {
> +		pr_err("Job Ring Device allocation for transform failed\n");
> +		return PTR_ERR(blobifier);
> +	}
> +
> +	ret = register_key_type(&key_type_trusted);
> +	if (ret)
> +		caam_blob_gen_exit(blobifier);
> +
> +	return ret;
> +}
> +
> +static void trusted_caam_exit(void)
> +{
> +	unregister_key_type(&key_type_trusted);
> +	caam_blob_gen_exit(blobifier);
> +}
> +
> +struct trusted_key_ops caam_trusted_key_ops = {
> +	.migratable = 0, /* non-migratable */
> +	.init = trusted_caam_init,
> +	.seal = trusted_caam_seal,
> +	.unseal = trusted_caam_unseal,
> +	.exit = trusted_caam_exit,
> +};
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> index 5f92323efedf..e9bfb1bbc014 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -9,6 +9,7 @@
>  #include <keys/user-type.h>
>  #include <keys/trusted-type.h>
>  #include <keys/trusted_tee.h>
> +#include <keys/trusted_caam.h>
>  #include <keys/trusted_tpm.h>
>  #include <linux/capability.h>
>  #include <linux/err.h>
> @@ -25,7 +26,7 @@
>  
>  static char *trusted_key_source;
>  module_param_named(source, trusted_key_source, charp, 0);
> -MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
> +MODULE_PARM_DESC(source, "Select trusted keys source (tpm, tee or caam)");
>  
>  static const struct trusted_key_source trusted_key_sources[] = {
>  #if defined(CONFIG_TCG_TPM)
> @@ -34,6 +35,9 @@ static const struct trusted_key_source trusted_key_sources[] = {
>  #if defined(CONFIG_TEE)
>  	{ "tee", &trusted_key_tee_ops },
>  #endif
> +#if defined(CONFIG_CRYPTO_DEV_FSL_CAAM_BLOB_GEN)
> +	{ "caam", &caam_trusted_key_ops },
> +#endif
>  };
>  
>  DEFINE_STATIC_CALL_NULL(trusted_key_init, *trusted_key_sources[0].ops->init);
> -- 
> git-series 0.9.1
> 

Too early to ack, as I've not included the TEE thing to any PR yet.

/Jarkko
