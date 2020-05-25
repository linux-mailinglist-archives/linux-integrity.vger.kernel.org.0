Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE6C1E0F8E
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2020 15:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390807AbgEYNdz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 May 2020 09:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390802AbgEYNdy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 May 2020 09:33:54 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82544C05BD43
        for <linux-integrity@vger.kernel.org>; Mon, 25 May 2020 06:33:54 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id r128so8359701ybc.6
        for <linux-integrity@vger.kernel.org>; Mon, 25 May 2020 06:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqk0bIefrw2vrIZWbzj16crB43IedLWQvwRJlQvaA9c=;
        b=TlUGNB3o2IkqFANinGJ4SF9BF23MV1OzUqvIAlYVssnHiOkJLgD+ffpmo76rGWwPFN
         G3+EW5xsxAsXWBDaNYx84Ees2f97TtFaAXjD3Smn0Ue5VgvubIsYLn5w2+/lxNR3VRvj
         /w/qrDLCMmbJ2xjXg5qXiZld7SPYkppeFX12mD9mkiDomh1hKYa0dQdsjZVRJgK8l5lH
         7T7SNCCXaC//rhbu8pviX4qu5c9bkWaHxZf9RbBrOI+JX8Pn1+cepnZ6zfGaVKr5YRr+
         EHVEWjH9Bgr5LqPRbgS5fjlSBj8qMt8v/MXAxbUdNMKAaQWwjrofLZpd0gAHEXtdmYBe
         hj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqk0bIefrw2vrIZWbzj16crB43IedLWQvwRJlQvaA9c=;
        b=Ldq8etyD7zgS0Eu6VdWiShbWQ68CqXJKxV/JIgTxnb9rZRSLZ6sSzJrmCR8jPYc+tq
         H71J9SVET55hKpwBvoK/UFKrqO2BdOgIwkk/fS5MizV3/eexkBb1eYiK1sYvKbGFl7wV
         p2FSyuG7L6x0gUtCs2HJ1gCT5zukPWQcnvB0nzB+Ys5hlQkPd+xO4/LCulLwQ5FeUCuy
         YZdzDB8wBde9KZTJP8qz93UdrMjdzfUpiiRmHzSO3xFpfdU7mRJpHtZNLf5IOxZSbp23
         IZ0Hb5GW7m0zreWLsonuXXG7AjZrJ1/Q6TvYszdJzO5iRkcM+p+dfOmOppfmhwoACLsB
         BJUQ==
X-Gm-Message-State: AOAM533NCOcc28U6ZinLGl3orOvBn+wOvFnUUfeyFGiLPSASsZwVu+EL
        bpO90501zRfSAXXvzMfj1eWorbQkUYOTgNOOEY2blg==
X-Google-Smtp-Source: ABdhPJwDKforc+9M9yVo4pMMOxCDDVaBSg9Mmj8MRXwgkKD3wKlS43421pLmS6F4n5e6h0CCLqm5fY5bIHD4XPZICPw=
X-Received: by 2002:a25:8202:: with SMTP id q2mr42946369ybk.243.1590413633559;
 Mon, 25 May 2020 06:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200525115235.5405-1-maxim.uvarov@linaro.org>
 <20200525115235.5405-3-maxim.uvarov@linaro.org> <20200525124753.GA797117@kroah.com>
In-Reply-To: <20200525124753.GA797117@kroah.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Mon, 25 May 2020 16:33:42 +0300
Message-ID: <CAD8XO3ach_G31vkqbVoio2H2yosdoLicu4SLk6nKdGmihUukgw@mail.gmail.com>
Subject: Re: [PATCHv3 2/3] optee: use uuid for sysfs driver entry
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 25 May 2020 at 15:47, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, May 25, 2020 at 02:52:34PM +0300, Maxim Uvarov wrote:
> > Optee device names for sysfs needed to be unique
> > and it's better if they will mean something. UUID for name
> > looks like good solution:
> > /sys/bus/tee/devices/optee-clnt-<uuid>
>
> Can you document that in Documentation/ABI/ ?
>
yes, sure if we agree to go with uuid.

> And why UUID?  Those are usually huge, is that easier than just a unique
> number?
>

UUID here is connected to Trusted Application (TA) in a secure world.
If you need to 'find'  sysfs entry for the corresponding driver
becomes very easy.
Also UUID here are not really huge, like:
/sys/bus/tee/devices/optee-clnt-71d950bc-c9d4-c442-82cb-343fb7f37896
/sys/bus/tee/devices/optee-clnt-ba3ac5b6-6996-6846-a7f2-205629d00f86

I think that is better then optee-clnt-0, optee-clnt-1.. which can be
reordered on each boot and does not carry any information. And on
module unload there will be missing numbers.

Regards,
Maxim.

> thanks,
>
> greg k-h
