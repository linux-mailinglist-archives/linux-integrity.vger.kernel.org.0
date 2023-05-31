Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82747186C8
	for <lists+linux-integrity@lfdr.de>; Wed, 31 May 2023 17:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjEaPyE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 May 2023 11:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjEaPyD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 May 2023 11:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F7EB2
        for <linux-integrity@vger.kernel.org>; Wed, 31 May 2023 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685548395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KZrnDzqF0kg5SP8WPls5NoRBsrNhlVAy/UWdXhsE2RQ=;
        b=aonvpQLdDOk2lf5605KkbVhF30T6OWZHMbogpXxGMPbTyFR4V44MZ3GR57TDecLpcxVAT2
        6pB3sHp/ADHoPscKE/IpmMuFxVfkXTdEaueTGIK6mHSODoFKW+KfXiAK8zcbxU7w7XPGuq
        UJQnR0CLCvcpV8OPFrKvG0C/ngAWkWY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-y2JB-QpONdm4fmB9ND3xXA-1; Wed, 31 May 2023 11:53:14 -0400
X-MC-Unique: y2JB-QpONdm4fmB9ND3xXA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6260d4a9802so39534426d6.1
        for <linux-integrity@vger.kernel.org>; Wed, 31 May 2023 08:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685548394; x=1688140394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZrnDzqF0kg5SP8WPls5NoRBsrNhlVAy/UWdXhsE2RQ=;
        b=UJgo90F2Igh3WllmUbGWT46WAQKj7l3awwnkPRdoZzKu6vzinG3mP3cr+3N2VV9xXp
         oRjdQBm7U+gwbL/J9/LH431K32+zM8Q0CMC0Vm6f1P7jQDYkrUSYFFYDFaVHhF0r0LE4
         ZJlXLXzofuCpaAZGMN0Pqfs7hyQRiDKvGelkjaoYeo/Ad0FQFdC3Qce22vz7xpJDocZx
         r3/KuaWN6apOeRMnWHeZoAHxFF+KoCQ2ThbJbAkoAN2nHoSoWsj99sLcURkciQUn15TU
         2Wo0Rv+QaMFitNAukOiyQUVNQk5yeOgMCgs32yPKkeOYMZrzPv2EzWwW222QlN6TzUud
         pgFg==
X-Gm-Message-State: AC+VfDyFW8dnobvaGK75mqUVAB5iGK4s19noYxfbprJuxhEIQcGM1Q0B
        XuDaXksoAMipNyZhWjuzMxnbBzvwtePj4vpM34SuBS5jDoFUCHysvfimlvsluBHcxF8C6h/dVVY
        2aCjC1Ms7N5ca0dd860d3Ue5NNmPF
X-Received: by 2002:a05:6214:1ccd:b0:625:76bb:b25e with SMTP id g13-20020a0562141ccd00b0062576bbb25emr5341614qvd.20.1685548393958;
        Wed, 31 May 2023 08:53:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7aoOqC2dkwYyoJ3XEwUOD6orXo6CiPy4lWsJGyYNNNFmUB5gFOMpCW+frTdvf16+TbQT5VWg==
X-Received: by 2002:a05:6214:1ccd:b0:625:76bb:b25e with SMTP id g13-20020a0562141ccd00b0062576bbb25emr5341593qvd.20.1685548393599;
        Wed, 31 May 2023 08:53:13 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id jy11-20020a0562142b4b00b00626267cad1esm2867990qvb.93.2023.05.31.08.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 08:53:13 -0700 (PDT)
Date:   Wed, 31 May 2023 08:53:11 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        Alejandro Cabrera <alejandro.cabreraaldaya@tuni.fi>,
        Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>,
        stable@vger.kernel.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: factor out the user space mm from
 tpm_vtpm_set_locality()
Message-ID: <4wa3nb6h6ns3msp4o6wojhxwn37t5sxlgexacm7ga7rfcrnsfl@chr5qhednjdl>
References: <20230530205001.1302975-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530205001.1302975-1-jarkko@kernel.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 30, 2023 at 11:50:01PM +0300, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
> 
> vtpm_proxy_fops_set_locality() causes kernel buffers to be passed to
> copy_from_user() and copy_to_user().
> 
> Factor out the crippled code away with help of an internal API for
> managing struct proxy_dev instances.
> 
> Link: https://lore.kernel.org/all/20230530020133.235765-1-jarkko@kernel.org/
> Cc: stable@vger.kernel.org # v4.14+
> Fixes: be4c9acfe297 ("tpm: vtpm_proxy: Implement request_locality function.")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
> ---
> I've tested this on RISC-V QEMU and have not noticed issues so far, and
> thus dropped the RFC tag. I've been looking into the code a lot lately
> as I'm building a boot time support for it, which will allow to e.g.
> test IMA without a physical TPM.	
>  drivers/char/tpm/tpm_vtpm_proxy.c | 168 ++++++++++++++++--------------
>  1 file changed, 87 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
> index 30e953988cab..83496742cc19 100644
> --- a/drivers/char/tpm/tpm_vtpm_proxy.c
> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> @@ -38,7 +38,6 @@ struct proxy_dev {
>  #define STATE_OPENED_FLAG        BIT(0)
>  #define STATE_WAIT_RESPONSE_FLAG BIT(1)  /* waiting for emulator response */
>  #define STATE_REGISTERED_FLAG	 BIT(2)
> -#define STATE_DRIVER_COMMAND     BIT(3)  /* sending a driver specific command */
>  
>  	size_t req_len;              /* length of queued TPM request */
>  	size_t resp_len;             /* length of queued TPM response */
> @@ -58,6 +57,53 @@ static void vtpm_proxy_delete_device(struct proxy_dev *proxy_dev);
>   * Functions related to 'server side'
>   */
>  
> +static ssize_t __vtpm_proxy_copy_from(struct proxy_dev *proxy_dev, u8 *buf, size_t count)
> +{
> +	size_t len = proxy_dev->req_len;
> +
> +	if (!(proxy_dev->state & STATE_OPENED_FLAG))
> +		return -EPIPE;
> +
> +	if (count < len || len > sizeof(proxy_dev->buffer)) {
> +		pr_debug("Invalid size in recv: count=%zd, req_len=%zd\n", count, len);
> +		return -EIO;
> +	}
> +
> +	memcpy(buf, proxy_dev->buffer, len);
> +	memset(proxy_dev->buffer, 0, len);
> +	proxy_dev->req_len = 0;
> +	proxy_dev->state |= STATE_WAIT_RESPONSE_FLAG;
> +
> +	return len;
> +}
> +
> +static ssize_t __vtpm_proxy_copy_to(struct proxy_dev *proxy_dev, const u8 *buf, size_t count)
> +{
> +	if (!(proxy_dev->state & STATE_OPENED_FLAG))
> +		return -EPIPE;
> +
> +	if (count > sizeof(proxy_dev->buffer) || !(proxy_dev->state & STATE_WAIT_RESPONSE_FLAG))
> +		return -EIO;
> +
> +	proxy_dev->state &= ~STATE_WAIT_RESPONSE_FLAG;
> +	proxy_dev->req_len = 0;
> +	proxy_dev->resp_len = count;
> +	memcpy(proxy_dev->buffer, buf, count);
> +
> +	return count;
> +}
> +
> +static int vtpm_proxy_wait_for(struct proxy_dev *proxy_dev)
> +{
> +	if (wait_event_interruptible(
> +		proxy_dev->wq,
> +		proxy_dev->req_len != 0 || !(proxy_dev->state & STATE_OPENED_FLAG)))
> +		return -EINTR;
> +
> +	return 0;
> +}
> +
> +
>  /**
>   * vtpm_proxy_fops_read - Read TPM commands on 'server side'
>   *
> @@ -73,44 +119,26 @@ static ssize_t vtpm_proxy_fops_read(struct file *filp, char __user *buf,
>  				    size_t count, loff_t *off)
>  {
>  	struct proxy_dev *proxy_dev = filp->private_data;
> -	size_t len;
> -	int sig, rc;
> +	u8 *kernel_buf;
> +	ssize_t rc;
>  
> -	sig = wait_event_interruptible(proxy_dev->wq,
> -		proxy_dev->req_len != 0 ||
> -		!(proxy_dev->state & STATE_OPENED_FLAG));
> -	if (sig)
> -		return -EINTR;
> -
> -	mutex_lock(&proxy_dev->buf_lock);
> -
> -	if (!(proxy_dev->state & STATE_OPENED_FLAG)) {
> -		mutex_unlock(&proxy_dev->buf_lock);
> -		return -EPIPE;
> -	}
> -
> -	len = proxy_dev->req_len;
> -
> -	if (count < len || len > sizeof(proxy_dev->buffer)) {
> -		mutex_unlock(&proxy_dev->buf_lock);
> -		pr_debug("Invalid size in recv: count=%zd, req_len=%zd\n",
> -			 count, len);
> -		return -EIO;
> -	}
> -
> -	rc = copy_to_user(buf, proxy_dev->buffer, len);
> -	memset(proxy_dev->buffer, 0, len);
> -	proxy_dev->req_len = 0;
> +	rc = vtpm_proxy_wait_for(proxy_dev);
> +	if (rc)
> +		return rc;
>  
> -	if (!rc)
> -		proxy_dev->state |= STATE_WAIT_RESPONSE_FLAG;
> +	kernel_buf = kzalloc(sizeof(proxy_dev->buffer), GFP_KERNEL);
> +	if (!kernel_buf)
> +		return -ENOMEM;
>  
> +	mutex_lock(&proxy_dev->buf_lock);
> +	rc = __vtpm_proxy_copy_from(proxy_dev, buf, count);

Is this meant to be kernel_buf instead of buf here? To me it reads
like it copies to buf from proxy_dev->buffer, and then below it copies
over buf with the kzalloc'd kernel_buf.

>  	mutex_unlock(&proxy_dev->buf_lock);
>  
> -	if (rc)
> -		return -EFAULT;
> +	if (!rc && copy_to_user(buf, kernel_buf, count))
> +		rc = -EFAULT;
>  
> -	return len;
> +	kfree(kernel_buf);
> +	return rc;
>  }
>  
>  /**
> @@ -128,36 +156,26 @@ static ssize_t vtpm_proxy_fops_write(struct file *filp, const char __user *buf,
>  				     size_t count, loff_t *off)
>  {
>  	struct proxy_dev *proxy_dev = filp->private_data;
> +	u8 *kernel_buf;
> +	int rc;
>  
> -	mutex_lock(&proxy_dev->buf_lock);
> -
> -	if (!(proxy_dev->state & STATE_OPENED_FLAG)) {
> -		mutex_unlock(&proxy_dev->buf_lock);
> -		return -EPIPE;
> -	}
> -
> -	if (count > sizeof(proxy_dev->buffer) ||
> -	    !(proxy_dev->state & STATE_WAIT_RESPONSE_FLAG)) {
> -		mutex_unlock(&proxy_dev->buf_lock);
> -		return -EIO;
> -	}
> -
> -	proxy_dev->state &= ~STATE_WAIT_RESPONSE_FLAG;
> -
> -	proxy_dev->req_len = 0;
> +	kernel_buf = kzalloc(sizeof(proxy_dev->buffer), GFP_KERNEL);
> +	if (!kernel_buf)
> +		return -ENOMEM;
>  
> -	if (copy_from_user(proxy_dev->buffer, buf, count)) {
> -		mutex_unlock(&proxy_dev->buf_lock);
> +	if (copy_from_user(kernel_buf, buf, count)) {
> +		kfree(kernel_buf);
>  		return -EFAULT;
>  	}
>  
> -	proxy_dev->resp_len = count;
> -
> +	mutex_lock(&proxy_dev->buf_lock);
> +	rc = __vtpm_proxy_copy_to(proxy_dev, kernel_buf, count);
>  	mutex_unlock(&proxy_dev->buf_lock);
>  
>  	wake_up_interruptible(&proxy_dev->wq);
> +	kfree(kernel_buf);
>  
> -	return count;
> +	return rc;
>  }
>  
>  /*
> @@ -295,28 +313,6 @@ static int vtpm_proxy_tpm_op_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>  	return len;
>  }
>  
> -static int vtpm_proxy_is_driver_command(struct tpm_chip *chip,
> -					u8 *buf, size_t count)
> -{
> -	struct tpm_header *hdr = (struct tpm_header *)buf;
> -
> -	if (count < sizeof(struct tpm_header))
> -		return 0;
> -
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> -		switch (be32_to_cpu(hdr->ordinal)) {
> -		case TPM2_CC_SET_LOCALITY:
> -			return 1;
> -		}
> -	} else {
> -		switch (be32_to_cpu(hdr->ordinal)) {
> -		case TPM_ORD_SET_LOCALITY:
> -			return 1;
> -		}
> -	}
> -	return 0;
> -}
> -
>  /*
>   * Called when core TPM driver forwards TPM requests to 'server side'.
>   *
> @@ -330,6 +326,7 @@ static int vtpm_proxy_is_driver_command(struct tpm_chip *chip,
>  static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)
>  {
>  	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
> +	unsigned int ord = ((struct tpm_header *)buf)->ordinal;
>  
>  	if (count > sizeof(proxy_dev->buffer)) {
>  		dev_err(&chip->dev,
> @@ -338,8 +335,10 @@ static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)
>  		return -EIO;
>  	}
>  
> -	if (!(proxy_dev->state & STATE_DRIVER_COMMAND) &&
> -	    vtpm_proxy_is_driver_command(chip, buf, count))
> +	if ((chip->flags & TPM_CHIP_FLAG_TPM2) && ord == TPM2_CC_SET_LOCALITY)
> +		return -EFAULT;
> +
> +	if (ord == TPM_ORD_SET_LOCALITY)
>  		return -EFAULT;
>  
>  	mutex_lock(&proxy_dev->buf_lock);
> @@ -407,13 +406,20 @@ static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
>  				  TPM_ORD_SET_LOCALITY);
>  	if (rc)
>  		return rc;
> +
>  	tpm_buf_append_u8(&buf, locality);
>  
> -	proxy_dev->state |= STATE_DRIVER_COMMAND;
> +	mutex_lock(&proxy_dev->buf_lock);
> +	rc = __vtpm_proxy_copy_to(proxy_dev, buf.data, tpm_buf_length(&buf));
> +	mutex_unlock(&proxy_dev->buf_lock);
>  
> -	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to set locality");
> +	rc = vtpm_proxy_wait_for(proxy_dev);
> +	if (rc)
> +		return rc;
>  
> -	proxy_dev->state &= ~STATE_DRIVER_COMMAND;
> +	mutex_lock(&proxy_dev->buf_lock);
> +	rc = __vtpm_proxy_copy_from(proxy_dev, buf.data, tpm_buf_length(&buf));
> +	mutex_unlock(&proxy_dev->buf_lock);
>  
>  	if (rc < 0) {
>  		locality = rc;
> -- 
> 2.39.2
> 

