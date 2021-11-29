Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCFB4627B9
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Nov 2021 00:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhK2XJg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 18:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbhK2XIl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 18:08:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79A5C093B6C;
        Mon, 29 Nov 2021 12:09:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 14106CE13F9;
        Mon, 29 Nov 2021 20:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C32C53FC7;
        Mon, 29 Nov 2021 20:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638216576;
        bh=HdIvwUw01pQG2zy2l1sOI1S6QWrIy1eeE7pkego8dWQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OOQ+WfbCyIcoZPueiw2jpFttexN0cv+ShoJPQWx6anEaIT8gsipRD6Fgr82fRDwT1
         T+VVCCGyPCnfc91RMiW0RfivfUlXnfKTcdn5GQQt6WZ9c57HqePs0uzS3Tc8/+XuCg
         p3MYvNaVqm8DPgJ1m8LeOGQdM0U8MdOw/1dMqqNSsxCHSI+XBastAh078AUYHSLSPG
         B3u5XtXN1cNt3TUIZTc0bsW8tliD77c3csYAZR4kjEiyV52jjtzHfKrE71Ymn7qPNY
         kvWpNDARu0NrlL8XHgKfmtfT3iWJtV6UrBgS8LXMOcQ0z9w5Ss3RLjU/F8e2lRaEeV
         zujpgeOvGqZOQ==
Message-ID: <455f66b569d81606e05775c4ac04a4b16e4c1782.camel@kernel.org>
Subject: Re: [PATCH] tpm: make const pointer desc a static const array
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Colin Ian King <colin.i.king@googlemail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Nov 2021 22:09:33 +0200
In-Reply-To: <20211127172604.126322-1-colin.i.king@gmail.com>
References: <20211127172604.126322-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-11-27 at 17:26 +0000, Colin Ian King wrote:
> Make const pointer desc a static const array, removes a dereference
> and shrinks object code a few bytes.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> =C2=A0drivers/char/tpm/tpm_tis_core.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index b2659a4c4016..649b4229e76e 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -716,7 +716,7 @@ static irqreturn_t tis_int_handler(int dummy, void *d=
ev_id)
> =C2=A0
> =C2=A0static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *desc =3D "attempti=
ng to generate an interrupt";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0static const char desc[] =3D "=
attempting to generate an interrupt";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 cap2;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cap_t cap;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;

I'd rather go for:

#define TPM_TIS_GEN_INTERRUPT_DESC "attempting to generate an interrupt"

/Jarkko
