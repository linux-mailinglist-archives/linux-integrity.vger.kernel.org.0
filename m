Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830B5405837
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 15:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244245AbhIINsD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Sep 2021 09:48:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358439AbhIINpG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 09:45:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33A2C6120A;
        Thu,  9 Sep 2021 13:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631195036;
        bh=idZqf3ls3/HkHNWsIFzESMREJZQWH8w+Xz30IeQkcbE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NWE31h3VqH4BM7wuW7e9UHCznhisydulTuq9bvmjURcQtjv0O5lI547C9kwjpwPM6
         Nwo5qP9XoUnwl0R0k4lau7cN9+tVu31smSsqRj22yXFtYwjcUmTEZGumqzNCyAQvH8
         ElMcjPRcaC1HuqG8nR+EmRVgqN3ocVRyvkVajLs7nLqvnFnI2OeXUcWCg61//qlMw8
         Btemw96tYM/EJjujPexiv5cs568ey4m9PfUf02ZeQylww6bvBZt2KPjfAe+811f7vZ
         MeFjzPZoTvyIYX6l3bdO1aZgxvN/OpLd2EenEP3Gj6FFzTF0aXFIyqj2jobHJdRmDv
         sjKoYTOk+/YmA==
Message-ID: <82166554e7174b349bf45a7c25d2fcbbc84a4d64.camel@kernel.org>
Subject: Re: [PATCH v5 02/12] integrity: Do not allow machine keyring
 updates following init
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
Date:   Thu, 09 Sep 2021 16:43:54 +0300
In-Reply-To: <20210907160110.2699645-3-eric.snowberg@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
         <20210907160110.2699645-3-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-09-07 at 12:01 -0400, Eric Snowberg wrote:
> The machine keyring is setup during init.  No additional keys should be
> allowed to be added afterwards.  Leave the permission as read only.
>=20
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> v2: Initial version
> v4: Unmodified from v2
> v5: Rename to machine keyring
> ---
>  security/integrity/digsig.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 8c315be8ad99..5a75ac2c4dbe 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -140,7 +140,8 @@ int __init integrity_init_keyring(const unsigned int =
id)
>  		return -ENOMEM;
> =20
>  	restriction->check =3D restrict_link_to_ima;
> -	perm |=3D KEY_USR_WRITE;

I would add here inline comment to say mostly the same as the commit
message does.

> +	if (id !=3D INTEGRITY_KEYRING_MACHINE)
> +		perm |=3D KEY_USR_WRITE;
> =20
>  out:
>  	return __integrity_init_keyring(id, perm, restriction);

I checked patch 01 but I lost the email somewhere. The keyring definition
looks now sane.

/Jarkko

