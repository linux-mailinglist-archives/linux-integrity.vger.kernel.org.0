Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847AF405845
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 15:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355483AbhIINws (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Sep 2021 09:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240903AbhIINvL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 09:51:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8CBB60E94;
        Thu,  9 Sep 2021 13:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631195401;
        bh=EKizRFE604TA7mZ4e2VhCAEb+bG2xQL8uEJDyWOYE7E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iaIoaX2rio6PIN9NSfFX0h7aBAOmjZFhMWeUJ07GexBfHZ2hV3F0XiiP4/yUy+He2
         owb0oN2g1YmjI1HLbqkEDbAOJdVJ13Tq3ZTUsgB9OHR8RL9zPAyJHYTRND8sR54rjt
         WvmlleA6Ayj7XrxEnTanffDaDLiWvTCg6CSElG6GkDKQFYFidsUCJrqPYyKOeqGffJ
         xVzyyb5TZUMbuFHV7kb/Pg+ADrIFzLerO48wp2D4UneBTdQH6oJg6OgYglcGDKH32Z
         X5q/UpSBH67D8+zCR1piAzhVq9G/of76jWTP73R22HfqDn/v4cjy0szTtIYvNeHOdf
         D+OuQzAjhBmvQ==
Message-ID: <8118cf37e9b76bb0ce326f7c1af5a5b6c02e0400.camel@kernel.org>
Subject: Re: [PATCH v5 04/12] integrity: restrict INTEGRITY_KEYRING_MACHINE
 to restrict_link_by_ca
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Date:   Thu, 09 Sep 2021 16:49:58 +0300
In-Reply-To: <20210907160110.2699645-5-eric.snowberg@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
         <20210907160110.2699645-5-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-09-07 at 12:01 -0400, Eric Snowberg wrote:
> Set the restriction check for INTEGRITY_KEYRING_MACHINE keys to
> restrict_link_by_ca.  This will only allow CA keys into the machine
> keyring.
>=20
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> v1: Initial version
> v2: Added !IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING check so mok
>     keyring gets created even when it isn't enabled
> v3: Rename restrict_link_by_system_trusted_or_ca to restrict_link_by_ca
> v4: removed unnecessary restriction->check set
> v5: Rename to machine keyring
> ---
>  security/integrity/digsig.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 5a75ac2c4dbe..2b75bbbd9e0e 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -132,14 +132,18 @@ int __init integrity_init_keyring(const unsigned in=
t id)
>  		goto out;
>  	}
> =20
> -	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING))
> +	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING) && id !=3D INTEGRITY_=
KEYRING_MACHINE)
>  		return 0;
> =20
>  	restriction =3D kzalloc(sizeof(struct key_restriction), GFP_KERNEL);
>  	if (!restriction)
>  		return -ENOMEM;
> =20
> -	restriction->check =3D restrict_link_to_ima;
> +	if (id =3D=3D INTEGRITY_KEYRING_MACHINE)
> +		restriction->check =3D restrict_link_by_ca;
> +	else
> +		restriction->check =3D restrict_link_to_ima;
> +
>  	if (id !=3D INTEGRITY_KEYRING_MACHINE)
>  		perm |=3D KEY_USR_WRITE;
> =20

03 and 04 look sane. As said, the patches seem to be already in nice shape.

/Jarkko
