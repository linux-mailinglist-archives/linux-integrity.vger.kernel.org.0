Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547404C8D43
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Mar 2022 15:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiCAOG2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Mar 2022 09:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiCAOG1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Mar 2022 09:06:27 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74964CD7D
        for <linux-integrity@vger.kernel.org>; Tue,  1 Mar 2022 06:05:46 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id b20so5578581qkn.9
        for <linux-integrity@vger.kernel.org>; Tue, 01 Mar 2022 06:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wtjizohg2CiwaFsaFvPT2wpJpMfkgawgg3Rxz5LmFXY=;
        b=GsRBTV8VD/o9MySrOhudutHADbuYL9ep+ZxLIVZMNyyhVObhTfhbQKDkqaWRomFsGq
         1aMX+BXHg9wrjqRQtEQ/rdwOZ+r0PJZmslM7L2fWNkzcWorK3mxoYmkUenKeE/IQp2zT
         PfsBEkDUvDjHmmPoi+BdD1txx9RyeAeZOBmv+Co8oHJF1nRUNBPN/vcCSfdxgUlWJtMI
         RFrDwr0/c7+BC0eFSdtRqiGO/Ku6kYR9n3K6ARHTgS1/wBLRniW7lSlCjaoVNTKa2Pja
         YkYoAn4N5Xbq1YwIgQizbvOZ87EwU0eBxKhm2ByIgZBeX26qUESOJF0PtcEau2YRMQni
         k2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wtjizohg2CiwaFsaFvPT2wpJpMfkgawgg3Rxz5LmFXY=;
        b=ZUxAuJl4VmDJZMxddozdYQKkVdLpqN44bjHQLt2/0tv7/FoUtbykOGXvtCz7kFYb19
         m9jwndpovfBBjz33yI0bIL8qdFzOQRKXyIa4htJNL3lfpvKZxPqESUhwcD19JNvqUMlX
         5IPNmiReQbZ43AYacJssz5UBrAUeoLNKC8KQWRbWhbdIRIa2i4vxzK9hz3gH9hKeLK3+
         2FKmg579dDWM2qsEaDCVtIMTy/LoMLjiFTkOA8K72Jho4YjXI31UahDTN6gUpbjjVJu+
         yvfN5sTHFnxKlSpTr+r6D266BN3/ivIBEN0vMyuN9b/4Gvr1PMgbqw4Oe+AxLyeu00Qr
         EJfg==
X-Gm-Message-State: AOAM533Tonv3tD7pqs5VXR3OJRIpIZ+2f7Lpx3KXZurqIwi0scFtl/lM
        Rc1kOCMzkgUsTm3fl9Ks1hDFAg==
X-Google-Smtp-Source: ABdhPJwI0NqfzPP+GkfqwR8OmC5EsTEp+yRSTD28VkEDjkdvz0BPphnx25Tzuqxb1A/beX02YKpz9g==
X-Received: by 2002:a37:a246:0:b0:49b:679a:2f2b with SMTP id l67-20020a37a246000000b0049b679a2f2bmr13467991qke.702.1646143545990;
        Tue, 01 Mar 2022 06:05:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id d4-20020a05620a136400b0060dda40b3ecsm6536312qkl.30.2022.03.01.06.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 06:05:45 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nP38K-003W39-LL; Tue, 01 Mar 2022 10:05:44 -0400
Date:   Tue, 1 Mar 2022 10:05:44 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, stefanb@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com, David.Laight@ACULAB.COM,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v8 1/1] tpm: fix reference counting for struct tpm_chip
Message-ID: <20220301140544.GF6468@ziepe.ca>
References: <20220301022108.30310-1-LinoSanfilippo@gmx.de>
 <20220301022108.30310-2-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301022108.30310-2-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 01, 2022 at 03:21:08AM +0100, Lino Sanfilippo wrote:
> @@ -653,8 +623,10 @@ void tpm_chip_unregister(struct tpm_chip *chip)
>  	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip))
>  		hwrng_unregister(&chip->hwrng);
>  	tpm_bios_log_teardown(chip);
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_firmware_upgrade(chip))
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_firmware_upgrade(chip)) {
>  		cdev_device_del(&chip->cdevs, &chip->devs);
> +		put_device(&chip->devs);
> +	}

I would put those two lines in a function bside tpm_devs_add() as
well, more modular.

It looks like a good idea to me

Jason
