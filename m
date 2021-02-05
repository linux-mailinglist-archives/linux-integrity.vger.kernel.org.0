Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41E4311560
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Feb 2021 23:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhBEW3O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Feb 2021 17:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbhBEOUK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Feb 2021 09:20:10 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AC4C061224
        for <linux-integrity@vger.kernel.org>; Fri,  5 Feb 2021 07:58:10 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id k193so7306498qke.6
        for <linux-integrity@vger.kernel.org>; Fri, 05 Feb 2021 07:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q5eyzLZq3gCKs8Kqw79XkqaQD8/gdoEJh1yzqQxqHt0=;
        b=ZEWUNFjaacXrMffIa+tWBci8iY9Dj/FxUUXeBdqAu2KvjWWVuxjTwyNuZihnDEFXPF
         rHLdpEmbtxPLlxdTercBuvHfpTHV+RyH3DwxMpk/eBXg8TCVwevSt60qABU9a++u1QWw
         ixshWfeoK5Is5BrPf+qqDVyp5mTATbijtMgYZuCmKsNG9wOFnAn7Rn9GXSI1uhfOsfBr
         H646r6BwHCa9FS0WxX6Xf85kzWHo4lIGiygp2Fpv1PX5EnL9CqDu5pFUxF6V4Dvs85e5
         4fBmkGaVaKvnHn6uqelFKNvVi+Cybsi64bcoX7tdF7DaKX4hoAQbowhSbHc7+U6tvW3b
         7vNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q5eyzLZq3gCKs8Kqw79XkqaQD8/gdoEJh1yzqQxqHt0=;
        b=pvXM2vntOep6lN2okw73zCQ6z5nI01HQTOyhOdz9mDfGvFdNyL/Ow8LIhSGn2vV8EX
         LrLQcjKSpHnxKtPau0oFbNOFCmFhFz5Q2nrqXipLSD0U/Z36+n1y0IavP9Oo7p+E3e6g
         I3Izp+V1wfbZDFBge/gfU5+CRvm//nwcIDjoLgZesuB9fTJdbDfmZfuA65dyvNdvmHhp
         3tO7tCym8mNjQJUQATKhGprnORmcABdNyuqTxnPWmQJ59Mxqvlo8gb71fHqlSnnywnYZ
         WFHSeObFMzcYINbFmY1+ugrxPWc8RzHOzWnPzNc8M9CrK0xaYbS8DGRcE6GC0AnyJR4/
         dtyw==
X-Gm-Message-State: AOAM53156B5QGNwTUIz6TV4F3gB0n84AHKy3TtUxSIgyzpRa9ZnU0vP1
        NYmfnzExiwAQSj0A1AqBjypjsA==
X-Google-Smtp-Source: ABdhPJyA7K4oUWNeCskRU6Pypei9zC3tndf7O8W2PUr0OOndWQlgAUmypXMY9EdbNg2wmLUYeRpk9Q==
X-Received: by 2002:a37:a053:: with SMTP id j80mr5100519qke.198.1612540689687;
        Fri, 05 Feb 2021 07:58:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id b16sm8170352qtx.85.2021.02.05.07.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 07:58:09 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l83Um-003tDI-IH; Fri, 05 Feb 2021 11:58:08 -0400
Date:   Fri, 5 Feb 2021 11:58:08 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, stefanb@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com, stable@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tpm: fix reference counting for struct tpm_chip
Message-ID: <20210205155808.GO4718@ziepe.ca>
References: <1612482643-11796-1-git-send-email-LinoSanfilippo@gmx.de>
 <1612482643-11796-2-git-send-email-LinoSanfilippo@gmx.de>
 <20210205130511.GI4718@ziepe.ca>
 <3b821bf9-0f54-3473-d934-61c0c29f8957@kunbus.com>
 <20210205151511.GM4718@ziepe.ca>
 <f6e5dd7d-30df-26d9-c712-677c127a8026@kunbus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6e5dd7d-30df-26d9-c712-677c127a8026@kunbus.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 05, 2021 at 04:50:13PM +0100, Lino Sanfilippo wrote:
> 
> On 05.02.21 16:15, Jason Gunthorpe wrote:
> > 
> > No, the cdev layer holds the refcount on the device while open is
> > being called.
> > 
> Yes, but the reference that is responsible for the chip deallocation is chip->dev
> which is linked to chip->cdev and represents /dev/tpm, not /dev/tpmrm.
> You are right, we dont have the issue with /dev/tpm for the reason you mentioned.
> But /dev/tpmrm is represented by chip->cdevs and keeping this ref held by the cdev
> layer wont protect us from the chip being freed (which is the reason why we need
> the chip->dev reference in the first place).

No, they are all chained together because they are all in the same
struct:

struct tpm_chip {
	struct device dev;
	struct device devs;
	struct cdev cdev;
	struct cdev cdevs;

dev holds the refcount on memory, when it goes 0 the whole thing is
kfreed.

The rule is dev's refcount can't go to zero while any other refcount
is != 0.

For instance devs holds a get on dev that is put back only when devs
goes to 0:

static void tpm_devs_release(struct device *dev)
{
	struct tpm_chip *chip = container_of(dev, struct tpm_chip, devs);

	/* release the master device reference */
	put_device(&chip->dev);
}

Both cdev elements do something similar inside the cdev layer.

The net result is during any open() the tpm_chip is guarenteed to have
a positive refcount.

Jason
