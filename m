Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FD72CEE89
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Dec 2020 14:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbgLDM7E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 07:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgLDM7E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 07:59:04 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E00C061A4F
        for <linux-integrity@vger.kernel.org>; Fri,  4 Dec 2020 04:58:23 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id p12so3780311qtp.7
        for <linux-integrity@vger.kernel.org>; Fri, 04 Dec 2020 04:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mMB6TptaiGgF4Fosm42A4LHTb/bohqrND/1SgruKzRo=;
        b=EwWyGtpTj94igDoF8XfgXRonTlvZx6CGc8I12BZB1X6VA+Fg+dcSxLIFNTW5ALVnOu
         SlEvcfbUm2Np8zJw2dvHlihTrqW6jxkbVPqYIpAV2Mcw8sDlEJGU2kcW9g/+BIyUDett
         Xdt5G5/1vrb+GgUEA4oV2nBf1NQ8z8DlqJBMUQJfoG4zDqSXK2DQPUO9kZR7rI2tZdU6
         iM+A4bd8xrhG9YSPLO39gvlZlJvDGQFXC82Ko/2fNCEV1gEPPrOFFdl/jTFdnVNgSqK3
         +XzA5cXaCbWTsd9yWvOxI4LocjRS2aB3+B3Sq1JEz1EctKYU/e26KHzWQieUiEwq1+vi
         S+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mMB6TptaiGgF4Fosm42A4LHTb/bohqrND/1SgruKzRo=;
        b=uVlbRm6ekhCpqk2CH7Jr1HdHiniZAfjP7vGBlqeTGZ5uEGvNCeNOPKZokAi6/yC8I2
         TX+RHz2qtnS8VSR5LgBMYcfR/sk6HBFLQWx5f0ux61TdglbJx/TNXgGOWdJzHSjzTs+S
         Ph0GcGXTuin/JLWd+vOeZVBQJqkOVfmPnnai2zUVTf+Jx4HomS7UTz8g71Z7XbwrxDA0
         frYBFhKWshOY39IEquGUcfks9UzgVbWEpTqQabSVkOSzY2ZWstudHbQidcW28gAP8LeO
         VJgHFRHkAz9uMQl3IqpLWEuMawjZEmWkSrhNj56zI3/YBomkMV6tSJrzPRQceWPPx0SY
         Z+zg==
X-Gm-Message-State: AOAM5304yKpRHjHGnwuAHJgYiECc4ubNMtVTHF70599ePe7np0sOM5oT
        hZhNuIaSapVhvqnlSveILvAdOw==
X-Google-Smtp-Source: ABdhPJwPFcOOZLe1Mg2mYyorVSLAyiPoevE1tsF0aJXBNFYF7EYaPI5QkdHoa4YMi7efamOTUiQFpw==
X-Received: by 2002:ac8:678d:: with SMTP id b13mr9105807qtp.332.1607086703152;
        Fri, 04 Dec 2020 04:58:23 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id 94sm4768303qtg.57.2020.12.04.04.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 04:58:22 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1klAfF-005qwi-5P; Fri, 04 Dec 2020 08:58:21 -0400
Date:   Fri, 4 Dec 2020 08:58:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sergey Temerkhanov <s.temerkhanov@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] tpm: Rework open/close/shutdown to avoid races
Message-ID: <20201204125821.GW5487@ziepe.ca>
References: <20201204101805.27374-1-s.temerkhanov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204101805.27374-1-s.temerkhanov@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 04, 2020 at 01:18:05PM +0300, Sergey Temerkhanov wrote:
> Avoid race condition at shutdown by shutting downn the TPM 2.0
> devices synchronously. This eliminates the condition when the
> shutdown sequence sets chip->ops to NULL leading to the following:
> 
> [ 1586.593561][ T8669] tpm2_del_space+0x28/0x73
> [ 1586.598718][ T8669] tpmrm_release+0x27/0x33wq
> [ 1586.603774][ T8669] __fput+0x109/0x1d
> [ 1586.608380][ T8669] task_work_run+0x7c/0x90
> [ 1586.613414][ T8669] prepare_exit_to_usermode+0xb8/0x128
> [ 1586.619522][ T8669] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 1586.626068][ T8669] RIP: 0033:0x4cb4bb
> 
> Signed-off-by: Sergey Temerkhanov <s.temerkhanov@gmail.com>
>  drivers/char/tpm/tpm-chip.c  | 27 ---------------------------
>  drivers/char/tpm/tpm-dev.c   | 11 ++++++-----
>  drivers/char/tpm/tpmrm-dev.c |  7 +++++++
>  include/linux/tpm.h          |  2 +-
>  4 files changed, 14 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 1838039b0333..ede7f4790c5e 100644
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -282,32 +282,6 @@ static void tpm_devs_release(struct device *dev)
>  	put_device(&chip->dev);
>  }
>  
> -/**
> - * tpm_class_shutdown() - prepare the TPM device for loss of power.
> - * @dev: device to which the chip is associated.
> - *
> - * Issues a TPM2_Shutdown command prior to loss of power, as required by the
> - * TPM 2.0 spec. Then, calls bus- and device- specific shutdown code.
> - *
> - * Return: always 0 (i.e. success)
> - */
> -static int tpm_class_shutdown(struct device *dev)
> -{
> -	struct tpm_chip *chip = container_of(dev, struct tpm_chip, dev);
> -
> -	down_write(&chip->ops_sem);
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> -		if (!tpm_chip_start(chip)) {
> -			tpm2_shutdown(chip, TPM2_SU_CLEAR);
> -			tpm_chip_stop(chip);
> -		}
> -	}
> -	chip->ops = NULL;
> -	up_write(&chip->ops_sem);
> -
> -	return 0;
> -}

This does more than just call tpm2_shutdown, it exists to prevent use
after free situations because the chip point can exist in other parts
of the system beyond the lifetime of the driver.

You can't call into the driver at all past shutdown, so moving
tpm2_shutdown here:

> @@ -39,6 +41,11 @@ static int tpmrm_release(struct inode *inode, struct file *file)
>  
>  	tpm_common_release(file, fpriv);
>  	tpm2_del_space(fpriv->chip, &priv->space);
> +
> +	if (!atomic_dec_return(&fpriv->chip->is_open)) {
> +		tpm2_shutdown(fpriv->chip, TPM2_SU_CLEAR);
> +		tpm_chip_stop(fpriv->chip);
> +	}

Is just wrong.

Your bug is because tpmrm_release is not following the lifetime rules
for chip, it probably needs to do a get on the pointer to be able to
access the ops.

Jason
