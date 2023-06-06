Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6F5724E83
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 23:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbjFFVJn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 17:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbjFFVJ0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 17:09:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6401726;
        Tue,  6 Jun 2023 14:09:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60AC6603F7;
        Tue,  6 Jun 2023 21:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7DFC433D2;
        Tue,  6 Jun 2023 21:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686085764;
        bh=jJ24bU4cqwTsoJWPLU9u777uw4xa5To44lSGGC0UhkQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=QEQrXdO8LmQp68hdmH6ZnOCffUwHZ4+8dg1hWcp7x5KO9kv9nIFHWlwcLjrHvPxZy
         kVu+s75vSgVsoWEHbWLn+SUMHvXY4PaRMgFhOUhcD2ZKVdjtUPMkuJDGCbnJA/nq5Y
         b41OEU5yJQZRsSeQxa8c68P8MibrzDCaXvxVuGsmzUmB9SszFRw5Qju2TOItTEGYJK
         40kcdoHg00hVZWuR2Bqg0JkHdJ4iLoQ02icRISl5aj/1Kh3MRmYVeiZkvBPe4mphEP
         M3LIZpzZZiMGuNcFZHrU4zJsU0nTS+ZmdCBM2+xT2v5k1dTFsiLKLgKZgAMOcdiYSF
         giHzrmKcjdHIQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 07 Jun 2023 00:09:21 +0300
Message-Id: <CT5VIPKR029R.Z1XFDV427X1V@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Alexander Steffen" <Alexander.Steffen@infineon.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] tpm_tis: Explicitly check for error code
X-Mailer: aerc 0.14.0
References: <20230605175959.2131-1-Alexander.Steffen@infineon.com>
 <20230605175959.2131-2-Alexander.Steffen@infineon.com>
In-Reply-To: <20230605175959.2131-2-Alexander.Steffen@infineon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon Jun 5, 2023 at 8:59 PM EEST, Alexander Steffen wrote:
> recv_data either returns the number of received bytes, or a negative valu=
e
> representing an error code. Adding the return value directly to the total
> number of received bytes therefore looks a little weird, since it might a=
dd
> a negative error code to a sum of bytes.
>
> The following check for size < expected usually makes the function return
> ETIME in that case, so it does not cause too many problems in practice. B=
ut
> to make the code look cleaner and because the caller might still be
> interested in the original error code, explicitly check for the presence =
of
> an error code and pass that through.
>

Cc: stable@vger.kernel.org
Fixes: cb5354253af2 ("[PATCH] tpm: spacing cleanups 2")

> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index 558144fa707a..aaaa136044ae 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -363,8 +363,13 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *b=
uf, size_t count)
>  		goto out;
>  	}
> =20
> -	size +=3D recv_data(chip, &buf[TPM_HEADER_SIZE],
> -			  expected - TPM_HEADER_SIZE);
> +	rc =3D recv_data(chip, &buf[TPM_HEADER_SIZE],
> +		       expected - TPM_HEADER_SIZE);
> +	if (rc < 0) {
> +		size =3D rc;
> +		goto out;
> +	}
> +	size +=3D rc;
>  	if (size < expected) {
>  		dev_err(&chip->dev, "Unable to read remainder of result\n");
>  		size =3D -ETIME;
> --=20
> 2.34.1

BR, Jarkko
