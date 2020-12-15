Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3B62DB31E
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Dec 2020 18:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgLOR5P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Dec 2020 12:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729768AbgLOR5H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Dec 2020 12:57:07 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC87C0617A6
        for <linux-integrity@vger.kernel.org>; Tue, 15 Dec 2020 09:56:27 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id h4so15126256qkk.4
        for <linux-integrity@vger.kernel.org>; Tue, 15 Dec 2020 09:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m5cvA/6InFp5aAA23Q5ITLBKdhHOwJrGQylrn66gwqQ=;
        b=SLI3UgiCpV3KdNFEC6KqQ8xrFFDbbxRu3Hz6X5XkxwJ0NuuRulGSiGBbeUdCyhVwq1
         KmPDAAciX8EEp73Z6jvrcSYSbUdimDMRzQfP+nguVbhRlYuo68UJa9MGw+/L3leIh5Ib
         204hoxLIuGX/VkHFStwlqoHYKztKyKpn7/vs+1ibQlpLx63ZwvXX6udNfIiWiM16mjTb
         KpPaP0qDJ2AJudFt6PoxAC3uur0Zq60S688F89lSR5JBtwK3prXK7Cafoynp/A+TyIEF
         X0kbbm14dQT+5o2Xq8pbERVW7QY7rTRZuwrNWjDCtn5Z07KMAOlfSH9QHXHLxKsblPvK
         J+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m5cvA/6InFp5aAA23Q5ITLBKdhHOwJrGQylrn66gwqQ=;
        b=dAT8lK3uRbHRkv5TlZw2YBHxMvg9zMvQi5jQbqvILHW0tk/p8OFaw7jh2SywjPStLd
         /kxIMJhONaYJZzryeheeGhU3BrtGzOX7AXJnEvuuiA4egrg3QFSlSy3cGOO3p+wDR8sX
         R9aeUQtftk2Zvt3XQwFjCn5yt+15eXZWOCfvMfGkhlsNrhjp1eLOaNJwBb2E16m+S+eC
         ySblfmbbp3NfvDr6Er80RyJkSLrOPq4j71It9f55rD/fAYpmNO3Ctn1UmbgkyE9pjGLC
         u/ZeV1f/AJpeQ7hI1xYcx4crDOhtpec0rm8qiZI0Ut4T5wwew6/1myhX4mD2I1OArwLp
         IBzA==
X-Gm-Message-State: AOAM532tpoEMgS9UEL9ejsQYr4tbtfYDho1zdAGkNfYwurCFrWvavNpZ
        SZ+8Zy7E0TczXZVETFORZCIxwQ==
X-Google-Smtp-Source: ABdhPJz1O3y+aqloEGrkdeSRfpXq4APJu5IurHGwqsdVLTIHUZWl7wZztRHcUqAJvRqbGBnr7KlaKg==
X-Received: by 2002:a05:620a:2148:: with SMTP id m8mr37680243qkm.213.1608054986450;
        Tue, 15 Dec 2020 09:56:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id p23sm16490530qtu.53.2020.12.15.09.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 09:56:25 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kpEYi-00Azxw-SR; Tue, 15 Dec 2020 13:56:24 -0400
Date:   Tue, 15 Dec 2020 13:56:24 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sergey Temerkhanov <s.temerkhanov@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Rework open/close/shutdown to avoid races
Message-ID: <20201215175624.GG5487@ziepe.ca>
References: <20201215133801.546207-1-s.temerkhanov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215133801.546207-1-s.temerkhanov@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 15, 2020 at 04:38:01PM +0300, Sergey Temerkhanov wrote:
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
>  drivers/char/tpm/tpm-chip.c  |  2 ++
>  drivers/char/tpm/tpm-dev.c   | 20 +++++++++++++-------
>  drivers/char/tpm/tpmrm-dev.c |  3 +++
>  include/linux/tpm.h          |  6 ++++--
>  4 files changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ddaeceb7e109..e94148b8e180 100644
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -295,6 +295,7 @@ static int tpm_class_shutdown(struct device *dev)
>  {
>  	struct tpm_chip *chip = container_of(dev, struct tpm_chip, dev);
>  
> +	wait_event_idle(chip->waitq, !atomic_read(&chip->refcount));
>  	down_write(&chip->ops_sem);
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
>  		if (!tpm_chip_start(chip)) {
> @@ -330,6 +331,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>  
>  	mutex_init(&chip->tpm_mutex);
>  	init_rwsem(&chip->ops_sem);
> +	init_waitqueue_head(&chip->waitq);
>  
>  	chip->ops = ops;
>  
> diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
> index e2c0baa69fef..8558f0f7382c 100644
> +++ b/drivers/char/tpm/tpm-dev.c
> @@ -19,27 +19,32 @@ static int tpm_open(struct inode *inode, struct file *file)
>  {
>  	struct tpm_chip *chip;
>  	struct file_priv *priv;
> +	int ret = 0;
>  
>  	chip = container_of(inode->i_cdev, struct tpm_chip, cdev);
>  
>  	/* It's assured that the chip will be opened just once,
> -	 * by the check of is_open variable, which is protected
> -	 * by driver_lock. */
> -	if (test_and_set_bit(0, &chip->is_open)) {
> +	 * by the check of the chip reference count.
> +	 */
> +	if (atomic_fetch_inc(&chip->refcount)) {

Use a refcount_t for all this

> @@ -39,6 +40,8 @@ static int tpmrm_release(struct inode *inode, struct file *file)
>
>  	tpm_common_release(file, fpriv);
>  	tpm2_del_space(fpriv->chip, &priv->space);
> +	atomic_dec(&fpriv->chip->refcount);
> +	wake_up_all(&fpriv->chip->waitq);

The usual pattern is

        if (refcount_dec_and_test(&fpriv->chip->refcount))
	   wake_up_all(&fpriv->chip->waitq);

But this seems like madness, this blocks tpm_class_shutdown until
userspace closes a file descriptor, can't do it.

You need to have tpm_class_shutdown() remove the ops from the still
open FD and have that FD start returning -EIO when the ops are gone,
which is what the ops lock is already for.

Jason
