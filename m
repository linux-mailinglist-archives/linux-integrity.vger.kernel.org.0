Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F9B40589A
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 16:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbhIIOGS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Sep 2021 10:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347423AbhIIOFk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 10:05:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35F42610CE;
        Thu,  9 Sep 2021 14:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631196266;
        bh=pGpjj5u0nbLuEIQ38PvtmlM+kx5pkkkUe+ofiClLvS8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=u72g2CRRbWi2lJwGYEYCMi5OQHCbEAsg+LEKSD6rd/lMoOK5sK2LvIIwTywetkAD/
         NzYHSWHWjc188padd4jwM+sd0if2dPCjoqGn0Ynj3aUEz3lpjl3XG3TuhNAhPBwqGj
         59lCZKOGgFHSsH5KwXCXIW80WKRKmnP4fF4MTxn0pjZxB6UKS6JjmmFQTfkdEjeCWD
         PEIgfhj9D2Zwx3IJpjgEGD19DLrvGOlqnSYmVssLBXnKbXr8mlKi4PFxj+Gp8HjN32
         HIH9ZWlM7UX3R9lsT/KrIKlj8/dxvzV7crC2p1XHS/InQQO8oFGXaa4GIe17WpcEJF
         QNVNE3zP3WvNA==
Message-ID: <f92e564c91755b0df70ae9b2237a034fe98f00c5.camel@kernel.org>
Subject: Re: [PATCH] tpm: Check for integer overflow in
 tpm2_map_response_body()
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Thu, 09 Sep 2021 17:04:24 +0300
In-Reply-To: <20210908053356.GB28725@kili>
References: <20210908053356.GB28725@kili>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-09-08 at 08:33 +0300, Dan Carpenter wrote:
> The "4 * be32_to_cpu(data->count)" multiplication can potentially
> overflow which would lead to memory corruption.  Add a check for that.
>=20
> Fixes: 745b361e989a ("tpm: infrastructure for TPM spaces")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/char/tpm/tpm2-space.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.=
c
> index 784b8b3cb903..97e916856cf3 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -455,6 +455,9 @@ static int tpm2_map_response_body(struct tpm_chip *ch=
ip, u32 cc, u8 *rsp,
>  	if (be32_to_cpu(data->capability) !=3D TPM2_CAP_HANDLES)
>  		return 0;
> =20
> +	if (be32_to_cpu(data->count) > (UINT_MAX - TPM_HEADER_SIZE - 9) / 4)
> +		return -EFAULT;
> +
>  	if (len !=3D TPM_HEADER_SIZE + 9 + 4 * be32_to_cpu(data->count))
>  		return -EFAULT;
> =20

Thanks!

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

