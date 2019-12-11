Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE14711B593
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 16:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbfLKPRP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 10:17:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34742 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731992AbfLKPRK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 10:17:10 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so10931217pgf.1
        for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2019 07:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lHzHnQGhN5tP71FlaevdaIuAFnoogD+yCbRZ8NYHtWo=;
        b=sSUCr5hqdCnnJt3WZvMu8bQU7Alg+WbM4uglsvmVb980MLMQFRtNLsJzPhYRv4n0gG
         KXONx1ZAMX4/7WbSKCNagj90q6wvdN9CclU6teSEllyr5FcVF7BpAwsW0jIpQIbxf6Qv
         v3F+DTZ3ZUWhtf00PqhlFpjL7PnZlKru+3VvT6mMi88LBB0Ra2NaxzG/zBPThRa4BRlc
         hRHYsP69ktcVYKUeJlXmsdltQT3NBYzL2/p6ittL41wHpn9lbcK4kA4arPLlUdfmWFkX
         xTx0Vi0qjZZIprIpiQrnwGq/FEKDbW0eXek4SDpku8jp11WuSUqDuGjIQgJx2w2zoyw7
         2gDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lHzHnQGhN5tP71FlaevdaIuAFnoogD+yCbRZ8NYHtWo=;
        b=KjAtJ1vKvV6W8oOYP9PGQ4Z46l2ydEXALNCXyOSmsZucq/v8/MoGagZt9sNBDVWecA
         pjtpINlpUYDJk9CxdGq6Fu3L+nInIAkFSTKBSU2kJk1JcIOw8kLEuzvYVz5o0uGLeTrz
         gFdp84lU4Hi4xxOCI8UrcpiWGWFqO1Aci2OTwFuofq6ktLTSUU+gAV6Fqe0jaeYfc96b
         QPbr9/ECLYJr76u6FsQeBh6taVjVUXwhPkhkmruuzq5y3PmPzsFpWQVpCHOeKMj2qbCf
         puepdXm8/LhLmDh5X+Rn+uHzUtgS2Mij/UQQnTjtngPD+8GWd75hIEfzmmtzKBtoJQG2
         oEYw==
X-Gm-Message-State: APjAAAU2KNxyMRihVaUjzcvbVh+1mPt9y9dzyM50vJto4tpmjTgqEtfr
        qO7bzpmG74wS9kHp5laEhcP1pw==
X-Google-Smtp-Source: APXvYqxEy3hDiJI2lA1gpQG3Xx+YjI+4Pit9SHQzetSX/fKg3dymirOozItGH0VMVlafiz0cwPFbfw==
X-Received: by 2002:a65:66c8:: with SMTP id c8mr4884729pgw.161.1576077429375;
        Wed, 11 Dec 2019 07:17:09 -0800 (PST)
Received: from debian ([122.164.82.31])
        by smtp.gmail.com with ESMTPSA id t8sm3757537pfq.92.2019.12.11.07.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:17:08 -0800 (PST)
Date:   Wed, 11 Dec 2019 20:47:01 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Will Deacon <will@kernel.org>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PROBLEM]: WARNING: lock held when returning to user space!
 (5.4.1 #16 Tainted: G )
Message-ID: <20191211151701.GA3643@debian>
References: <20191207173420.GA5280@debian>
 <20191209103432.GC3306@willie-the-truck>
 <20191209202552.GK19243@linux.intel.com>
 <34e5340f-de75-f20e-7898-6142eac45c13@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34e5340f-de75-f20e-7898-6142eac45c13@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> diff --git a/drivers/char/tpm/tpm-dev-common.c
> b/drivers/char/tpm/tpm-dev-common.c
> index 2ec47a69a2a6..47f1c0c5c8de 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -61,6 +61,12 @@ static void tpm_dev_async_work(struct work_struct *work)
> 
>  	mutex_lock(&priv->buffer_mutex);
>  	priv->command_enqueued = false;
> +	ret = tpm_try_get_ops(priv->chip);
> +	if (ret) {
> +		priv->response_length = ret;
> +		goto out;
> +	}
> +
>  	ret = tpm_dev_transmit(priv->chip, priv->space, priv->data_buffer,
>  			       sizeof(priv->data_buffer));
>  	tpm_put_ops(priv->chip);
> @@ -68,6 +74,7 @@ static void tpm_dev_async_work(struct work_struct *work)
>  		priv->response_length = ret;
>  		mod_timer(&priv->user_read_timer, jiffies + (120 * HZ));
>  	}
> +out:
>  	mutex_unlock(&priv->buffer_mutex);
>  	wake_up_interruptible(&priv->async_wait);
>  }
> @@ -205,6 +212,7 @@ ssize_t tpm_common_write(struct file *file, const
> char __user *buf,
>  		priv->command_enqueued = true;
>  		queue_work(tpm_dev_wq, &priv->async_work);
>  		mutex_unlock(&priv->buffer_mutex);
> +		tpm_put_ops(priv->chip);
>  		return size;
>  	}
> 
> 
> 
> -- 
> Tadeusz

above patch shows errors when i try to apply it.
--------------------x------------------------x------------------
error: git diff header lacks filename information when removing 1 leading pathname component (line 2)
when i did  related to this "diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c"
i get another error
error: corrupt patch at line 27
----------------------x------------------------x-----------------

i use "git apply"

--
software engineer
rajagiri school of engineering and technology
