Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19905570AD7
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Jul 2022 21:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiGKTj3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Jul 2022 15:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiGKTj3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Jul 2022 15:39:29 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6076352459;
        Mon, 11 Jul 2022 12:39:28 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id p6so4621235ljc.8;
        Mon, 11 Jul 2022 12:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FmrPbk0CTn59DhOrtjuvdbDhlXyaAxbjDkdLGnYexnI=;
        b=ROwY+uUjEXcx7y8mwtPOpXSaj7Mu4ehLBicjuQBzZ9FCSEe1QAPW0B/xPjy4Q95jne
         QAkxjRPNez0IrBh/e5dpv7vBJLyjuAjqagk7IY4kRS3M5v7bb31AVv7xZi7/eBw0qATK
         nJ4IBnH36ekieHSSVbEUQoKRd1RkjKaVSRsCAG0QSICdK/kcvyDwM3d5R51ZmMu0exhM
         ltBU0Us+JmARPw1C02A3ktO3inABxxBGo+b+wz8bKDKNUBnxGbTzYGptbBbD9JC4CdGI
         PGvZ6JRWZjLJufH/fwzZreAUlIEAREbSsTvABxQCTjgx+zSJOakmj73TIKljGhcfzmSh
         7T1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FmrPbk0CTn59DhOrtjuvdbDhlXyaAxbjDkdLGnYexnI=;
        b=Cr7WD9AaoavtGzdJ+bwQfkdtGvjOqHj3UIkAbOMFMW2vQZ+FyPJtcRzM12qrWa4HIx
         d8N6MX+42jObEgR3E+qAO+J4KjNzY+j+e1n7cqZBCPhdjwLyBhcW8D+ktTIxjY5Pd255
         lvWr764l6cUfHIwj2G1NX1JdEkxvXedCh5MaYM4euPajYWKYhODJe5PORHcI+B2ht5ZX
         Plnf4qWzmsIfuNnaWXhpNN6Y0aHd5pW5sxPMyHSPn0QNVXBN9dvf+au/2Qj1FPW+NIH7
         mLRyxawwI2+uVCLjKkJ6YAF/ZiN/yvhCWBtXr6prIQSZpbndwwW1N5V1xpSeU4aKT7Gh
         lh7g==
X-Gm-Message-State: AJIora+UgF5Dq29JA64aCQr7zhH5Fcl9EdjICqAauw7pJTI+ouVymhwm
        ZW7bUnjYihzV0WBzeHBPQNWVA5obOuYBIhbXmtY=
X-Google-Smtp-Source: AGRyM1s99Ni9pj/ax7LWCB2d6ITDCzG0QBKKrBoeAURtFnk0Yys1KwiAevTrmsbiMfdK+yk5qRd77k1k5M5tzJj0EuU=
X-Received: by 2002:a2e:6819:0:b0:25d:63ec:7954 with SMTP id
 c25-20020a2e6819000000b0025d63ec7954mr6472158lja.389.1657568366544; Mon, 11
 Jul 2022 12:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de> <20220629232653.1306735-8-LinoSanfilippo@gmx.de>
In-Reply-To: <20220629232653.1306735-8-LinoSanfilippo@gmx.de>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Mon, 11 Jul 2022 15:39:15 -0400
Message-ID: <CAKf6xpvY1peO-mWM+bjaHnXhrqpOrGbyrOOaT18-myWYSJ88Sw@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] tmp, tmp_tis: Implement usage counter for locality
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        l.sanfilippo@kunbus.com, lukas@wunner.de, p.rosenberger@kunbus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

This patch subject has a typo "tmp, tmp_tis" -> "tpm, tpm_tis"

On Wed, Jun 29, 2022 at 7:28 PM Lino Sanfilippo <LinoSanfilippo@gmx.de> wro=
te:
>
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>
> Implement a usage counter for the (default) locality used by the TPM TIS
> driver:
> Request the locality from the TPM if it has not been claimed yet, otherwi=
se
> only increment the counter. Also release the locality if the counter is 0
> otherwise only decrement the counter. Ensure thread-safety by protecting
> the counter with a mutex.
>
> This allows to request and release the locality from a thread and the
> interrupt handler at the same time without the danger to interfere with
> each other.
>
> By doing this refactor the names of the amended functions to use the prop=
er
> prefix.
>
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> Tested-by: Michael Niew=C3=B6hner <linux@mniewoehner.de>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 75 ++++++++++++++++++++++-----------
>  drivers/char/tpm/tpm_tis_core.h |  2 +
>  2 files changed, 53 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index bd4eeb0b2192..e50a2c78de9f 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c

> @@ -215,6 +226,20 @@ static int request_locality(struct tpm_chip *chip, i=
nt l)
>         return -1;
>  }
>
> +static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
> +{
> +       struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> +       int ret =3D 0;
> +
> +       mutex_lock(&priv->locality_count_mutex);
> +       if (priv->locality_count =3D=3D 0)
> +               ret =3D tpm_tis_request_locality_locked(chip, l);
> +       if (!ret)
> +               priv->locality_count++;
> +       mutex_unlock(&priv->locality_count_mutex);
> +       return ret;
> +}
> +

This function should check that the requested locality matches the
current locality otherwise this sequence would seemingly succeed
though locality 0 is the one acquired.

tpm_tis_request_locality(chip, 0);
tpm_tis_request_locality(chip, 1);

Regards,
Jason
