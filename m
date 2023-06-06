Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF18D724EC3
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 23:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjFFVYe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 17:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbjFFVYd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 17:24:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC871706;
        Tue,  6 Jun 2023 14:24:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 880D5637D3;
        Tue,  6 Jun 2023 21:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432A9C433D2;
        Tue,  6 Jun 2023 21:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686086672;
        bh=b1FE7V9gXbFtl1txAXWfQDccXeyWymPKRp3++rDn/ow=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=IN7yudMwoaLOfDN1DdGfneiXgBnXrf9Zz76Dse/q1oziRzB1Zv79cyU07keOJME8b
         iF16UPH5GTZ+c6CvTGW1s9oT5gWD2TKLbvdFYiAOhhGfelFJED1amGsIe+B7ithao8
         s0wqwYZuO2RHrM9MJ5ATvK7OLHsw3reOdnC1XT4ks7cslURgSkmFAH4UKmdvSYZp2q
         Yi3rEDExjgrhOi6PyE3bOWAVE2vmj15wVq2u7uM0+dPYV28WPfhKLTage9guO+kW8s
         WLDpDlvA6ZWYrXFXZxtdBLJ1idfYNogfbY1lxsUyTwUbH2E2D6W188e4WvvMgIWTLZ
         k4S/LphLdjGWg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 07 Jun 2023 00:24:28 +0300
Message-Id: <CT5VUA5ZPSD3.6H4DN11M7148@suppilovahvero>
Cc:     "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>,
        "Alexander Steffen" <Alexander.Steffen@infineon.com>,
        "Michael Haener" <michael.haener@siemens.com>
Subject: Re: [PATCH 2/2] tpm: tis_i2c: Limit write bursts to
 I2C_SMBUS_BLOCK_MAX (32) bytes
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "A. Sverdlin" <alexander.sverdlin@siemens.com>,
        <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230524154040.1204030-1-alexander.sverdlin@siemens.com>
 <20230524154040.1204030-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20230524154040.1204030-2-alexander.sverdlin@siemens.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed May 24, 2023 at 6:40 PM EEST, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>
> Underlying I2C bus drivers not always support longer transfers and
> imx-lpi2c for instance doesn't. The fix is symmetric to previous patch
> which fixed the read direction.
>

Cc: stable@vger.kernel.org # v5.20+

> Fixes: bbc23a07b072 ("tpm: Add tpm_tis_i2c backend for tpm_tis_core")
> Tested-by: Michael Haener <michael.haener@siemens.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  drivers/char/tpm/tpm_tis_i2c.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2=
c.c
> index 106fd20d94e4..82fda488e98b 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -230,19 +230,27 @@ static int tpm_tis_i2c_write_bytes(struct tpm_tis_d=
ata *data, u32 addr, u16 len,
>  	struct i2c_msg msg =3D { .addr =3D phy->i2c_client->addr };
>  	u8 reg =3D tpm_tis_i2c_address_to_register(addr);
>  	int ret;
> +	u16 wrote =3D 0;
> =20
>  	if (len > TPM_BUFSIZE - 1)
>  		return -EIO;
> =20
> -	/* write register and data in one go */
>  	phy->io_buf[0] =3D reg;
> -	memcpy(phy->io_buf + sizeof(reg), value, len);
> -
> -	msg.len =3D sizeof(reg) + len;
>  	msg.buf =3D phy->io_buf;
> -	ret =3D tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
> -	if (ret < 0)
> -		return ret;
> +	while (wrote < len) {
> +		/* write register and data in one go */
> +		msg.len =3D sizeof(reg) + len - wrote;
> +		if (msg.len > I2C_SMBUS_BLOCK_MAX)
> +			msg.len =3D I2C_SMBUS_BLOCK_MAX;
> +
> +		memcpy(phy->io_buf + sizeof(reg), value + wrote,
> +		       msg.len - sizeof(reg));
> +
> +		ret =3D tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
> +		if (ret < 0)
> +			return ret;
> +		wrote +=3D msg.len - sizeof(reg);
> +	}
> =20
>  	return 0;
>  }
> --=20
> 2.40.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
