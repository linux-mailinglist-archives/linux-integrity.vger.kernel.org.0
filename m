Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF8B42A81C
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Oct 2021 17:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbhJLPWk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Oct 2021 11:22:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232952AbhJLPWj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Oct 2021 11:22:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EB8160E0B;
        Tue, 12 Oct 2021 15:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634052037;
        bh=PJFtGAJ/i5vrU6he/YsT/9McMcu5XsKOvf+ehOHtKMI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=j56pxltmiq/yaaXtZ/NLMeN+/4RKTiaPaNJv+rTsP9S9eYpxR7bEYecqoPOhzDKiZ
         WJiLA8w5rjE9lmhKq8kJL0PvhdLS4uRKkf5VLV7IMB78qVoLPYxarYFzpGHumNLhHg
         RU2xrLdsIHgM2asHepxtq+VI1jqkmSDKDknOHJmy+/NG/GkdGZiqT/npITtxdzK/JL
         xda87+WdSvgOPsnQS59EaRqbB7fZjcb/P3zBe/MQN8T5v0AgyeyWbIvvly5qSccf0J
         epzUTY9aVbVk/R/Sh8r9LWUL1paFssJr3F8jza3ZURdCG4ZWCbColrWlRxYDuvfcRJ
         NPP5dG6LGZagA==
Message-ID: <500c72ecc99c127838dd4bded1e70fa48a1e97a3.camel@kernel.org>
Subject: Re: [PATCH] tpm/st33zp24: Fix typo in st33zp24.c
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Oct 2021 18:20:34 +0300
In-Reply-To: <20211008052736.629562-1-sohaib.amhmd@gmail.com>
References: <20211008052736.629562-1-sohaib.amhmd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-10-08 at 07:27 +0200, Sohaib Mohamed wrote:
> Remove repeated world "device"
> "datas" -> "data"
>=20
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
> ---
> =C2=A0drivers/char/tpm/st33zp24/st33zp24.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33=
zp24/st33zp24.c
> index 4ec10ab5e576..f888624c1ae7 100644
> --- a/drivers/char/tpm/st33zp24/st33zp24.c
> +++ b/drivers/char/tpm/st33zp24/st33zp24.c
> @@ -62,7 +62,7 @@ enum tis_defaults {
>=20
> =C2=A0/*
> =C2=A0 * clear_interruption clear the pending interrupt.
> - * @param: tpm_dev, the tpm device device.
> + * @param: tpm_dev, the tpm device.
> =C2=A0 * @return: the interrupt status value.
> =C2=A0 */
> =C2=A0static u8 clear_interruption(struct st33zp24_dev *tpm_dev)
> @@ -434,7 +434,7 @@ static int st33zp24_send(struct tpm_chip *chip, unsig=
ned char *buf,
> =C2=A0/*
> =C2=A0 * st33zp24_recv received TPM response through TPM phy.
> =C2=A0 * @param: chip, the tpm_chip description as specified in driver/ch=
ar/tpm/tpm.h.
> - * @param: buf,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0the buffe=
r to store datas.
> + * @param: buf,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0the buffe=
r to store data.
> =C2=A0 * @param: count, the number of bytes to send.
> =C2=A0 * @return: In case of success the number of bytes received.
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 In other case, a=
 < 0 value describing the issue.
> --
> 2.25.1
>=20

So, these do not follow kdoc syntax, and they are only local functions,
i.e. it does not make sense to fix something that is already broken.

Having parameter descriptions for these is quite useless thing to
maintain so you could just remove parameter descriptions, and make
just a normal multi-line comment.

E.g.

/*
 * Clear the pending input.
 */
static u8 clear_interruption(struct st33zp24_dev *tpm_dev)

For the 2nd the current description is barely even a proper sentence,
and it does not tell what the function does. Also for that you know
what it does already, since it is just implementing the callback.

So for that, just remove the comment altogether.

Please add to the next patch version:

Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>


/Jarkko

