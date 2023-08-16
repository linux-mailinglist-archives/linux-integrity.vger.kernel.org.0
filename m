Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D965177EA92
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Aug 2023 22:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346074AbjHPURB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Aug 2023 16:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346071AbjHPUQo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Aug 2023 16:16:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AB01BF7
        for <linux-integrity@vger.kernel.org>; Wed, 16 Aug 2023 13:16:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1BB8640FA
        for <linux-integrity@vger.kernel.org>; Wed, 16 Aug 2023 20:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34281C433C7;
        Wed, 16 Aug 2023 20:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692217003;
        bh=evX6vkIZMOOlz4okzXROLd1OGW3BcN7U/ybDYQXR8w8=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=YWdQijvzKxoehxjnZFHTgwcQvlRLcWGwUl3xdoZe/YGT2vlpGJFvdhcxNe81Dp1Vj
         YX03GLWfbGoRymOAzgkDqv88OVvd+FQRY1DGabpmaG61f0FEVXgMgDMFT0fPXeBAy5
         RdastqJqeqT8lxZ/lCPzxny1Z5qrk0z8w7dVcTIyMHwdv4abJn4uMt9pZlMtAKn7cN
         SQVWIA9u8LCoxr2impKkPJqlX5OBEhjb9FY6mGqN9KuUGbpQzhHrBBtWMsv+Xp68or
         PYmlWIUhnncoEh8ne82IhFJQnyv5li+Mo/DQ2gzUpq9PKxyTYKtESBmJuWlX91gx3I
         EOdCZ31FTlQ8g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 16 Aug 2023 23:16:40 +0300
Message-Id: <CUU8V1TOV5P5.28AL7104K516W@suppilovahvero>
Cc:     <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH -next] tpm/tpm_tis_synquacer: Use module_platform_driver
 macro to simplify the code
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Li Zetao" <lizetao1@huawei.com>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>
X-Mailer: aerc 0.14.0
References: <20230815080637.1100650-1-lizetao1@huawei.com>
In-Reply-To: <20230815080637.1100650-1-lizetao1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Aug 15, 2023 at 11:06 AM EEST, Li Zetao wrote:
> Use the module_platform_driver macro to simplify the code, which is the
> same as declaring with module_init() and module_exit().
>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/char/tpm/tpm_tis_synquacer.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_synquacer.c b/drivers/char/tpm/tpm_=
tis_synquacer.c
> index 49278746b0e2..f7d5e76b505e 100644
> --- a/drivers/char/tpm/tpm_tis_synquacer.c
> +++ b/drivers/char/tpm/tpm_tis_synquacer.c
> @@ -162,23 +162,7 @@ static struct platform_driver tis_synquacer_drv =3D =
{
>  	},
>  };
> =20
> -static int __init tpm_tis_synquacer_module_init(void)
> -{
> -	int rc;
> -
> -	rc =3D platform_driver_register(&tis_synquacer_drv);
> -	if (rc)
> -		return rc;
> -
> -	return 0;
> -}
> -
> -static void __exit tpm_tis_synquacer_module_exit(void)
> -{
> -	platform_driver_unregister(&tis_synquacer_drv);
> -}
> +module_platform_driver(tis_synquacer_drv);
> =20
> -module_init(tpm_tis_synquacer_module_init);
> -module_exit(tpm_tis_synquacer_module_exit);
>  MODULE_DESCRIPTION("TPM MMIO Driver for Socionext SynQuacer platform");
>  MODULE_LICENSE("GPL");
> --=20
> 2.34.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko


