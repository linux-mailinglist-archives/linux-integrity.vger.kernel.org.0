Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E329074E2D0
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jul 2023 02:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjGKAyB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jul 2023 20:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjGKAyB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 20:54:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1A0E49;
        Mon, 10 Jul 2023 17:53:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D72B612A8;
        Tue, 11 Jul 2023 00:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BF7C433C7;
        Tue, 11 Jul 2023 00:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689036835;
        bh=7NtGGH0puiyGbQq/G89w8kpReCKON+iR4Ms01GN2vAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l/lVBVe7r2zkqtgf7uUaJaXCpk9ZlniyEsELevVSE4WQepVmNBeTUJuAhHwNsw+72
         c9EtauNxZvh6DO9uQxwMi0JC7A84vjoZ8OAi5/ayF8P0h62AH9u6Mw94tSeVdaV4sc
         FCT7bSJxGhLtz8DZY4TBnLtg5RQyziKOMQTgWBXPA1pFpIN2tlAJADje6yeOLcHZq4
         a4iUJRLMQ/fDddN8ZueBvIQm/n+UgInqr+l6zKM0lmAYepXsmEiMnwRtxqCs+LHEg5
         0xyb2qdZK/zg51JmRhjUasbjdiYsq2v3K4JtvcDH6zaFV5eMnrfW8Ynq6GQFiXm+sL
         9UFmfUl0h5RLg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 11 Jul 2023 03:53:51 +0300
Message-Id: <CTYXL4O99AHB.2P41COJDMW4JS@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-integrity@vger.kernel.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "Ivan Orlov" <ivan.orlov0322@gmail.com>,
        "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>
Subject: Re: [PATCH] tpm: make all 'class' structures const
X-Mailer: aerc 0.14.0
References: <20230620144642.584926-2-gregkh@linuxfoundation.org>
In-Reply-To: <20230620144642.584926-2-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Jun 20, 2023 at 5:46 PM EEST, Greg Kroah-Hartman wrote:
> From: Ivan Orlov <ivan.orlov0322@gmail.com>
>
> Now that the driver core allows for struct class to be in read-only
> memory, making all 'class' structures to be declared at build time
> placing them into read-only memory, instead of having to be dynamically
> allocated at load time.
>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-integrity@vger.kernel.org
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/char/tpm/tpm-chip.c      | 11 ++++++++---
>  drivers/char/tpm/tpm-interface.c | 21 +++++++++------------
>  drivers/char/tpm/tpm.h           |  4 ++--
>  drivers/char/tpm/tpm2-space.c    |  2 +-
>  4 files changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index cd48033b804a..7c028f0b9d38 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -28,8 +28,13 @@
>  DEFINE_IDR(dev_nums_idr);
>  static DEFINE_MUTEX(idr_lock);
> =20
> -struct class *tpm_class;
> -struct class *tpmrm_class;
> +const struct class tpm_class =3D {
> +	.name =3D "tpm",
> +	.shutdown_pre =3D tpm_class_shutdown,
> +};
> +const struct class tpmrm_class =3D {
> +	.name =3D "tmprm",
> +};
>  dev_t tpm_devt;
> =20
>  static int tpm_request_locality(struct tpm_chip *chip)
> @@ -336,7 +341,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
> =20
>  	device_initialize(&chip->dev);
> =20
> -	chip->dev.class =3D tpm_class;
> +	chip->dev.class =3D &tpm_class;
>  	chip->dev.release =3D tpm_dev_release;
>  	chip->dev.parent =3D pdev;
>  	chip->dev.groups =3D chip->groups;
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-inte=
rface.c
> index 586ca10b0d72..66b16d26eecc 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -476,18 +476,15 @@ static int __init tpm_init(void)
>  {
>  	int rc;
> =20
> -	tpm_class =3D class_create("tpm");
> -	if (IS_ERR(tpm_class)) {
> +	rc =3D class_register(&tpm_class);
> +	if (rc) {
>  		pr_err("couldn't create tpm class\n");
> -		return PTR_ERR(tpm_class);
> +		return rc;
>  	}
> =20
> -	tpm_class->shutdown_pre =3D tpm_class_shutdown;
> -
> -	tpmrm_class =3D class_create("tpmrm");
> -	if (IS_ERR(tpmrm_class)) {
> +	rc =3D class_register(&tpmrm_class);
> +	if (rc) {
>  		pr_err("couldn't create tpmrm class\n");
> -		rc =3D PTR_ERR(tpmrm_class);
>  		goto out_destroy_tpm_class;
>  	}
> =20
> @@ -508,9 +505,9 @@ static int __init tpm_init(void)
>  out_unreg_chrdev:
>  	unregister_chrdev_region(tpm_devt, 2 * TPM_NUM_DEVICES);
>  out_destroy_tpmrm_class:
> -	class_destroy(tpmrm_class);
> +	class_unregister(&tpmrm_class);
>  out_destroy_tpm_class:
> -	class_destroy(tpm_class);
> +	class_unregister(&tpm_class);
> =20
>  	return rc;
>  }
> @@ -518,8 +515,8 @@ static int __init tpm_init(void)
>  static void __exit tpm_exit(void)
>  {
>  	idr_destroy(&dev_nums_idr);
> -	class_destroy(tpm_class);
> -	class_destroy(tpmrm_class);
> +	class_unregister(&tpm_class);
> +	class_unregister(&tpmrm_class);
>  	unregister_chrdev_region(tpm_devt, 2*TPM_NUM_DEVICES);
>  	tpm_dev_common_exit();
>  }
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 460bb85dd142..61445f1dc46d 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -230,8 +230,8 @@ enum tpm2_pt_props {
>   * compiler warnings about stack frame size. */
>  #define TPM_MAX_RNG_DATA	128
> =20
> -extern struct class *tpm_class;
> -extern struct class *tpmrm_class;
> +extern const struct class tpm_class;
> +extern const struct class tpmrm_class;
>  extern dev_t tpm_devt;
>  extern const struct file_operations tpm_fops;
>  extern const struct file_operations tpmrm_fops;
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.=
c
> index ffb35f0154c1..363afdd4d1d3 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -606,7 +606,7 @@ int tpm_devs_add(struct tpm_chip *chip)
> =20
>  	device_initialize(&chip->devs);
>  	chip->devs.parent =3D chip->dev.parent;
> -	chip->devs.class =3D tpmrm_class;
> +	chip->devs.class =3D &tpmrm_class;
> =20
>  	/*
>  	 * Get extra reference on main device to hold on behalf of devs.
> --=20
> 2.41.0

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
