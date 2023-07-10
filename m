Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B1C74DBC9
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jul 2023 18:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjGJQ6c (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jul 2023 12:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjGJQ6a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 12:58:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FD712B;
        Mon, 10 Jul 2023 09:58:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F9946102A;
        Mon, 10 Jul 2023 16:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F459C433C8;
        Mon, 10 Jul 2023 16:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689008308;
        bh=0TjUeSeHP6RtpBKkYu34BDFsV/QhcMw+SRmzO50X/QI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=t9BeTLf9Meb/JVYIK8S5WgEf5I66CB5jBfm0E82+WESeoBgnYZ9+xB0bt1VnFDRS1
         dLFsnvnjEXwxARt4jizcVHhuVcp38QX6ZXeGpwkYHq6WwzfS55BMO3P2eYYQ5AhyKw
         kvre5BC48exAqwcxbsGYhqUL4vMSIoUfw2YNTLxKmlwldCiYkvjVfI+uN1uxn8+OV0
         EIn/6+0IBzBVz+DXihRgvceL/WRvpZNyPYbVty9Hws4/KkKezG/TjbJCI1ssieVf4x
         P8a7h8MU6ZX4PDQK3r5/AlHGNKEKubF19Ocqp0nIEPGzqJwbCwtLwwrIYTgx9f3TMi
         C7GrTJj8EJ7og==
Message-ID: <8877c0d2592b5f93f3b1e8ba6e6d4db7a04a094f.camel@kernel.org>
Subject: Re: [PATCH v3 1/4] tpm_tis: Explicitly check for error code
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Date:   Mon, 10 Jul 2023 19:58:25 +0300
In-Reply-To: <20230613180259.3525-2-Alexander.Steffen@infineon.com>
References: <20230613180259.3525-1-Alexander.Steffen@infineon.com>
         <20230613180259.3525-2-Alexander.Steffen@infineon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
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

On Tue, 2023-06-13 at 20:02 +0200, Alexander Steffen wrote:
> recv_data either returns the number of received bytes, or a negative valu=
e
> representing an error code. Adding the return value directly to the total
> number of received bytes therefore looks a little weird, since it might a=
dd
> a negative error code to a sum of bytes.
>=20
> The following check for size < expected usually makes the function return
> ETIME in that case, so it does not cause too many problems in practice. B=
ut
> to make the code look cleaner and because the caller might still be
> interested in the original error code, explicitly check for the presence =
of
> an error code and pass that through.
>=20
> Cc: stable@vger.kernel.org
> Fixes: cb5354253af2 ("[PATCH] tpm: spacing cleanups 2")
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
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

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
