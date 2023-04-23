Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FB66EBD2F
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Apr 2023 07:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjDWF3s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Apr 2023 01:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjDWF3r (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Apr 2023 01:29:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBAD1736;
        Sat, 22 Apr 2023 22:29:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF44B60BCC;
        Sun, 23 Apr 2023 05:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B11C433EF;
        Sun, 23 Apr 2023 05:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682227785;
        bh=do70prUP7Yp/qQZpHtKiAoZB66OjY1P/f8crHCgNYE4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RY7WpJA3gnRsXf0YGxR5aD+dSH5iF5AkgsjAj3E719k3dDNYcIeJn51JJqFg8qSEU
         9ydpQi9A0W5zmPqsTYdRKduUxblcx5Y+WR5F3+9WzObujtJnC3yKHup2TWhjp9n3Eg
         pvYt7lSqSiZ2W8nafL+i9TLcluFknRev/YmXwlQJWn177MesIeMCYZTUUhg+CgEbMl
         KseB1a1VrJHQ60mZJ0f9MWihc6QHam3xtBmub3MFOyRG5oDeDN1DKUxNUwweCL3sRQ
         DjHhFUlgKuA4me0i3o7O/HJYuqGIe2+l3PYOfSGVUFm4EEWuiKUInbtTphf+FQ43Gq
         zpvHgWxJHf8Cw==
Message-ID: <adad1047b7935b4f4d982dcd40f1fe92edcfd2d3.camel@kernel.org>
Subject: Re: [PATCH v4 08/13] tpm: Add full HMAC and encrypt/decrypt session
 handling code
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 23 Apr 2023 08:29:42 +0300
In-Reply-To: <20230403214003.32093-9-James.Bottomley@HansenPartnership.com>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
         <20230403214003.32093-9-James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-04-03 at 17:39 -0400, James Bottomley wrote:
> Add true session based HMAC authentication plus parameter decryption
> and response encryption using AES. The basic design is to segregate
> all the nasty crypto, hash and hmac code into tpm2-sessions.c and
> export a usable API.  The API first of all starts off by gaining a
> session with
>=20
> tpm2_start_auth_session()
>=20
> Which initiates a session with the TPM and allocates an opaque
> tpm2_auth structure to handle the session parameters.  Then the use is
> simply:
>=20
> * tpm_buf_append_name() in place of the tpm_buf_append_u32 for the
>   handles
>=20
> * tpm_buf_append_hmac_session() where tpm2_append_auth() would go
>=20
> * tpm_buf_fill_hmac_session() called after the entire command buffer
>   is finished but before tpm_transmit_cmd() is called which computes
>   the correct HMAC and places it in the command at the correct
>   location.
>=20
> Finally, after tpm_transmit_cmd() is called,
> tpm_buf_check_hmac_response() is called to check that the returned
> HMAC matched and collect the new state for the next use of the
> session, if any.
>=20
> The features of the session is controlled by the session attributes
> set in tpm_buf_append_hmac_session().  If TPM2_SA_CONTINUE_SESSION is
> not specified, the session will be flushed and the tpm2_auth structure
> freed in tpm_buf_check_hmac_response(); otherwise the session may be
> used again.  Parameter encryption is specified by or'ing the flag
> TPM2_SA_DECRYPT and response encryption by or'ing the flag
> TPM2_SA_ENCRYPT.  the various encryptions will be taken care of by
> tpm_buf_fill_hmac_session() and tpm_buf_check_hmac_response()
> respectively.
>=20
> To get all of this to work securely, the Kernel needs a primary key to
> encrypt the session salt to, so an EC key from the NULL seed is
> derived and its context saved in the tpm_chip structure.  The context
> is loaded on demand into an available volatile handle when
> tpm_start_auth_session() is called, but is flushed before that
> function exits to conserve handles.
>=20
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org> # crypto API part=
s
>=20
> ---
>=20
> v2: fix memory leaks from smatch; adjust for name hash size
> v3: make tpm2_make_null_primary static
> v4: use crypto library functions
> ---
>  drivers/char/tpm/Kconfig         |   13 +
>  drivers/char/tpm/Makefile        |    1 +
>  drivers/char/tpm/tpm-buf.c       |    1 +
>  drivers/char/tpm/tpm-chip.c      |    3 +
>  drivers/char/tpm/tpm.h           |   10 +
>  drivers/char/tpm/tpm2-cmd.c      |    5 +
>  drivers/char/tpm/tpm2-sessions.c | 1158 ++++++++++++++++++++++++++++++
>  include/linux/tpm.h              |  165 +++++
>  8 files changed, 1356 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm2-sessions.c
>=20
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 927088b2c3d3..8af3afc48511 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -27,6 +27,19 @@ menuconfig TCG_TPM
> =20
>  if TCG_TPM
> =20
> +config TPM_BUS_SECURITY

"bus security" means nothing.


> +	bool "Use secure transactions on the TPM bus"

Neither does "secure transactions"


> +	default y
> +	select CRYPTO_ECDH
> +	select CRYPTO_LIB_AESCFB
> +	select CRYPTO_LIB_SHA256
> +	help
> +	  Setting this causes us to deploy a tamper resistent scheme
> +	  for communicating with the TPM to prevent or detect bus
> +	  snooping and iterposer attacks like TPM Genie.  Saying Y here
> +	  adds some encryption overhead to all kernel to TPM
> +	  transactions.

AFAIK, tamper resistance is part of the physical security. Software
does not provide tamper resistance. Or at least I've not heard that
term used with software before.

Please provide URL to TPM Genie because you can't assume it being
"commmon terminology". Or if you don't want to do that, remove it
from the description as it has on function in kconfig.

From that description it is impossible to say what this *actually*
does, if we assume that the reader is kernel developer/maintainer.
It is just gibberish.

To fix all this maybe to flag could be something like
TCG_TPM_HMAC_ENCRYPTION because it adds layer of protection.

The kconfig description should essentially two things:

1. The HMAC scheme very broadly.
2. Keys generated/used, e.g. it would be nice to know if there
   is a protection key for each boot cycle and that kind of stuff.

The current stuff helps no one to understand this feature.

R, Jarkko
