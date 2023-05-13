Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277977018B5
	for <lists+linux-integrity@lfdr.de>; Sat, 13 May 2023 19:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbjEMR6B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 13 May 2023 13:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjEMR5x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 13 May 2023 13:57:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F452D4A;
        Sat, 13 May 2023 10:57:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B649B61B86;
        Sat, 13 May 2023 17:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEB8C433D2;
        Sat, 13 May 2023 17:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684000670;
        bh=gRyFgLllhpvhpItRhUBvhxIrRN1R6Xc2ZIh/hKJ6AJ0=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=c+uhW+cGqO44l175N8ovEzw61/SzuLM+FLV16m0S7zh2LdVkTZIzhzuGxM8p5ioSl
         Gf2jzJCXFh9tBbTWyQ/pVtZYuB3fW9jS1JixqU85Y/TNsF/SOnwNxIUV1Fzah2WS40
         yvmk85xnA4K3mL3UeXxNslnYNbidhH2ctGjCvSIpA0152bkcRsWOuJD6vKsvX9ql3s
         W7DA8hC7U97gznBEQno1LDJgQXhDcVx1eL3cVMql/4eilf0d/wJyRDpQV5sRzg+YIP
         ae0mwAKHoRmZ3zrYlExQPCQ/MvHag5AiSjmPT5MFYIRsQOr0shwtElFl6H9rQF0Pez
         qY+ILtwozmmOQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 13 May 2023 20:57:46 +0300
Message-Id: <CSLCEYDKKWWE.36POIXVT65SLE@suppilovahvero>
Cc:     <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm_vtpm_proxy: fix race condition in /dev/vtpmx
 creation
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jarkko Sakkinen" <jarkko.sakkinen@tuni.fi>,
        <linux-integrity@vger.kernel.org>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Stefan Berger" <stefanb@linux.vnet.ibm.com>
X-Mailer: aerc 0.14.0
References: <20230513172818.752712-1-jarkko.sakkinen@tuni.fi>
In-Reply-To: <20230513172818.752712-1-jarkko.sakkinen@tuni.fi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat May 13, 2023 at 8:28 PM EEST, Jarkko Sakkinen wrote:
> /dev/vtpmx is made visible before the workqueue exist, which can lead
> memory corruption in the worst case, if workqueue is used before it has
> been fully initialized. Address this by changing the call order.
>
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org
> Fixes: 6f99612e2500 ("tpm: Proxy driver for supporting multiple emulated =
TPMs")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
> ---
>  drivers/char/tpm/tpm_vtpm_proxy.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtp=
m_proxy.c
> index 5c865987ba5c..ef1367cf2f10 100644
> --- a/drivers/char/tpm/tpm_vtpm_proxy.c
> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> @@ -50,7 +50,7 @@ struct proxy_dev {
>  /* all supported flags */
>  #define VTPM_PROXY_FLAGS_ALL  (VTPM_PROXY_FLAG_TPM2)
> =20
> -static struct workqueue_struct *workqueue;
> +static struct workqueue_struct *vtpm_workqueue;
> =20
>  static void vtpm_proxy_delete_device(struct proxy_dev *proxy_dev);
> =20
> @@ -478,7 +478,7 @@ static void vtpm_proxy_work_stop(struct proxy_dev *pr=
oxy_dev)
>   */
>  static inline void vtpm_proxy_work_start(struct proxy_dev *proxy_dev)
>  {
> -	queue_work(workqueue, &proxy_dev->work);
> +	queue_work(vtpm_workqueue, &proxy_dev->work);
>  }
> =20
>  /*
> @@ -697,30 +697,24 @@ static int __init vtpm_module_init(void)
>  {
>  	int rc;
> =20
> -	rc =3D vtpmx_init();
> -	if (rc) {
> -		pr_err("couldn't create vtpmx device\n");
> +	vtpm_workqueue =3D create_workqueue("tpm-vtpm");
> +	if (!vtpm_workqueue) {
> +		rc =3D -ENOMEM;
>  		return rc;
>  	}
> =20
> -	workqueue =3D create_workqueue("tpm-vtpm");
> -	if (!workqueue) {
> -		pr_err("couldn't create workqueue\n");
> -		rc =3D -ENOMEM;
> -		goto err_vtpmx_cleanup;
> +	rc =3D vtpmx_init();
> +	if (rc) {
> +		vtpmx_cleanup();

This should be destroy_workqueue(). I'll send a new version.

BR, Jarkko
