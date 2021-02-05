Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEA63114E9
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Feb 2021 23:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbhBEWSL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Feb 2021 17:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbhBEOdZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Feb 2021 09:33:25 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117E8C061786
        for <linux-integrity@vger.kernel.org>; Fri,  5 Feb 2021 08:11:23 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m12so3873290pjs.4
        for <linux-integrity@vger.kernel.org>; Fri, 05 Feb 2021 08:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j5MllqUmJkfRvZTV+AWvGvgx9JoPvBJg21QU0c/0D1o=;
        b=b3RMqfVavOIEqwGRRivq9NgCENkagcWiskhM3JY4EGNW9hd9v1bs7l9UlM8EpZfVm5
         vREkflHTcgNEQpsCgbGKrKR97t3Cp2dqmEKB5SXg532h6HQcMlMBzBx+y1t12M56pqU0
         Sv89uwgjPKqlY3hpb/idpPKG6yEGfZBZLAUTipRhMg1+aZCaHNWnVGidZS9NJAt7Vp90
         Za9VbADbCNhmSCw9mj5EWIElrJpx4D9ulFCCA1GBgiA28gcdgpFksuQ7L3AGx7UF4Qhq
         SqNlKW0Ao9XW9FJ/nyXze22EHbgGv5sqZg7bjXBgVMkjLt7SgkfdJHfjTsovASX0Rx51
         mJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j5MllqUmJkfRvZTV+AWvGvgx9JoPvBJg21QU0c/0D1o=;
        b=dZ93kt32Gy5u4ZzAU/DI+mv/r5fYYQ6l/9bbkbLFBk3lKN5UyxTNt2foWJJR1ZcQhE
         724J596E1zYb2VL75yR4YCh9uqCaV55mcFQdTNthQKgAw4MMdIx44lNhbj+5KoVKSTd7
         QXIIJ2obiBww/dZtjO29aHU2rAbL3nW+t+eUi6JX8DhpIsvKuLStlXMxN4JG53zCPRXH
         icPU9fnB/IXwAqa4NBQn35jTrsgIb6xliL5xL3ea0yzFfMy6rqsYpR8V7d+p56ks5Fkr
         9gzvxJrfC+TxG3+ATitbNitPvXokwHXFk5mOwsM5XL6LhEpbHzoj4odYjmS8pLynqURN
         Aw9Q==
X-Gm-Message-State: AOAM531KIDS0hC6bRmUGfh8NWDp81bZen9ks6CfSLkONegis0rlXjYNb
        qilmKY3/ldiJbxIJmbXBcRf4nztd6CTZRkmN
X-Google-Smtp-Source: ABdhPJxeZMLoomFn1WjzWfZnvvTcV/Q+etRcBdUTT6bm05dRZWDXHxKohEu0PiEYzsDNRpzUFwuBew==
X-Received: by 2002:a0c:e652:: with SMTP id c18mr4545150qvn.59.1612538113060;
        Fri, 05 Feb 2021 07:15:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id c5sm9647761qkg.99.2021.02.05.07.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 07:15:12 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l82pD-003sLK-Mb; Fri, 05 Feb 2021 11:15:11 -0400
Date:   Fri, 5 Feb 2021 11:15:11 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, stefanb@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com, stable@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tpm: fix reference counting for struct tpm_chip
Message-ID: <20210205151511.GM4718@ziepe.ca>
References: <1612482643-11796-1-git-send-email-LinoSanfilippo@gmx.de>
 <1612482643-11796-2-git-send-email-LinoSanfilippo@gmx.de>
 <20210205130511.GI4718@ziepe.ca>
 <3b821bf9-0f54-3473-d934-61c0c29f8957@kunbus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b821bf9-0f54-3473-d934-61c0c29f8957@kunbus.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 05, 2021 at 03:55:09PM +0100, Lino Sanfilippo wrote:
> Hi,
> 
> On 05.02.21 14:05, Jason Gunthorpe wrote:
> 
> >>
> >> Commit fdc915f7f719 ("tpm: expose spaces via a device link /dev/tpmrm<n>")
> >> already introduced function tpm_devs_release() to release the extra
> >> reference but did not implement the required put on chip->devs that results
> >> in the call of this function.
> > 
> > Seems wonky, the devs is just supposed to be a side thing, nothing
> > should be using it as a primary reference count for a tpm.
> > 
> > The bug here is only that tpm_common_open() did not get a kref on the
> > chip before putting it in priv and linking it to the fd. See the
> > comment before tpm_try_get_ops() indicating the caller must already
> > have taken care to ensure the chip is valid.
> > 
> > This should be all you need to fix the oops:
> > 
> > diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> > index 1784530b8387bb..1b738dca7fffb5 100644
> > +++ b/drivers/char/tpm/tpm-dev-common.c
> > @@ -105,6 +105,7 @@ static void tpm_timeout_work(struct work_struct *work)
> >  void tpm_common_open(struct file *file, struct tpm_chip *chip,
> >                      struct file_priv *priv, struct tpm_space *space)
> >  {
> > +       get_device(&priv->chip.dev);
> >         priv->chip = chip;
> >         priv->space = space;
> >         priv->response_read = true;
> 
> This is racy, isnt it? The time between we open the file and we want to grab the
> reference in common_open() the chip can already be unregistered and freed.

No, the cdev layer holds the refcount on the device while open is
being called.

Jason
