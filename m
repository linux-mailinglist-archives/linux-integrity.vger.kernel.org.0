Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BADA724EC1
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 23:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbjFFVXj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 17:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238659AbjFFVXh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 17:23:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494A91734;
        Tue,  6 Jun 2023 14:23:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF2B9636EB;
        Tue,  6 Jun 2023 21:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80786C433D2;
        Tue,  6 Jun 2023 21:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686086614;
        bh=SJ7mYeJ2NHHpFrgZ8PqWmB5m5DnfNIdjr+JIxZtmkE0=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=CJ2jHX1TlgdfckWbNolQgFMczAv9tDKsy/AcJaYVopO/C2Cu9qpwcIw8sOVhZpU7B
         54H+63V/RxEfJGBE/eG5qJ1Dx+PHHdpcd7rIxu7Drhd+VKHlDqhCw3L8tjD5tb5l51
         qL6KBtaO74abwGNQ4Kh4fpDsUJmfK0MmhdeWio5Qq97CDZmXgAIsFveULA9A2AAiYC
         rIPdZtde75xJzUgMoK/N4nW5LlJnryA2ZHE/9MN60KkmMEVBe3nT5Vesh/vjXJVsfC
         S73q1ok8DZi8PNg9EU7JSTOAfnvZz8WxPFcqHsPC9HvXLQZ+H0mI72ruZ6XAvQEGIS
         R6FaQRj53CO9g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 07 Jun 2023 00:23:30 +0300
Message-Id: <CT5VTJHY1SEA.31VAFLZ2O561Z@suppilovahvero>
Cc:     "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>,
        "Alexander Steffen" <Alexander.Steffen@infineon.com>,
        "Michael Haener" <michael.haener@siemens.com>
Subject: Re: [PATCH 1/2] tpm: tis_i2c: Limit read bursts to
 I2C_SMBUS_BLOCK_MAX (32) bytes
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "A. Sverdlin" <alexander.sverdlin@siemens.com>,
        <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230524154040.1204030-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20230524154040.1204030-1-alexander.sverdlin@siemens.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
> imx-lpi2c for instance doesn't. SLB 9673 offers 427-bytes packets.
>
> Visible symptoms are:
>
> tpm tpm0: Error left over data
> tpm tpm0: tpm_transmit: tpm_recv: error -5
> tpm_tis_i2c: probe of 1-002e failed with error -5
>

Cc: stable@vger.kernel.org # v5.20+

> Fixes: bbc23a07b072 ("tpm: Add tpm_tis_i2c backend for tpm_tis_core")
> Tested-by: Michael Haener <michael.haener@siemens.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  drivers/char/tpm/tpm_tis_i2c.c | 37 ++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2=
c.c
> index c8c34adc14c0..106fd20d94e4 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -189,21 +189,28 @@ static int tpm_tis_i2c_read_bytes(struct tpm_tis_da=
ta *data, u32 addr, u16 len,
>  	int ret;
> =20
>  	for (i =3D 0; i < TPM_RETRY; i++) {
> -		/* write register */
> -		msg.len =3D sizeof(reg);
> -		msg.buf =3D &reg;
> -		msg.flags =3D 0;
> -		ret =3D tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
> -		if (ret < 0)
> -			return ret;
> -
> -		/* read data */
> -		msg.buf =3D result;
> -		msg.len =3D len;
> -		msg.flags =3D I2C_M_RD;
> -		ret =3D tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
> -		if (ret < 0)
> -			return ret;
> +		u16 read =3D 0;
> +
> +		while (read < len) {
> +			/* write register */
> +			msg.len =3D sizeof(reg);
> +			msg.buf =3D &reg;
> +			msg.flags =3D 0;
> +			ret =3D tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
> +			if (ret < 0)
> +				return ret;
> +
> +			/* read data */
> +			msg.buf =3D result + read;
> +			msg.len =3D len - read;
> +			msg.flags =3D I2C_M_RD;
> +			if (msg.len > I2C_SMBUS_BLOCK_MAX)
> +				msg.len =3D I2C_SMBUS_BLOCK_MAX;
> +			ret =3D tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
> +			if (ret < 0)
> +				return ret;
> +			read +=3D msg.len;
> +		}
> =20
>  		ret =3D tpm_tis_i2c_sanity_check_read(reg, len, result);
>  		if (ret =3D=3D 0)
> --=20
> 2.40.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
