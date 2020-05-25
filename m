Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795831E0F9B
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2020 15:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403855AbgEYNgy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 May 2020 09:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403843AbgEYNgy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 May 2020 09:36:54 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A562C05BD43
        for <linux-integrity@vger.kernel.org>; Mon, 25 May 2020 06:36:54 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id n10so8362080ybn.8
        for <linux-integrity@vger.kernel.org>; Mon, 25 May 2020 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcSOKq/rHuR2xKP/geses1NMEAx6OusfI/F+nRB6n20=;
        b=BKJ+vT23rQPh5/rXBGS0njdwZQY77KFgROhvzOdQQuGJnaH6eFK29yxLsfxm03OtAW
         mJmSCaKASE1ZekZXA/No4IFpT+nYZO2elldidGTfsy09faIl1kXz34zL0s7pai8BGtcs
         XrIVhkbHi3gC3fhX29bLkL7e4CHSKFR46KHC5RNtflO4SqsnHePgGohyxhfBEXBgcZ4U
         tpe+bz4UJL/TGvYsCvJeYfJpjS0r8Wru75WUMO7bLJ0l+CV1xGIQa3kdrKHN1mH6TX/u
         r8NVe4qpwKljXiDkLIr0VVGzfy+3SZHHau0TA4GeIYGQJPb7DYawu/X/pPkYOjMVfTbV
         khMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcSOKq/rHuR2xKP/geses1NMEAx6OusfI/F+nRB6n20=;
        b=Bvu26AdrIt5HwlRpbFgoiWW/xBiJ4raE64ZRHYVkvZhunrV3zUta9XdcWTDkhACrCt
         w9iqMAXkBvF0BkL2EhxRWEB4/caUyiiQ11FpNyp21CnM6DSuf8qtvy4kuipuuFAY9IZJ
         71xGBYfNFxErYq8vkMcXcrUzcwqcLPUIfONbvd/lEI0M1yync7P51HL7IVXR5MEuVvmS
         zcOAmoGKvfodLuU0JR2i0goJZdTyqg2aHh4aKhW4QRIfip3zWGI+QkyCz2NhO97yDcC6
         7i+OlsK4YcR1/vK1wBPIW67nBMuVC0oWx0SOhvbvu5Zyok6P31NEVCEAS6r+3HGMd5da
         pO5A==
X-Gm-Message-State: AOAM532aI1m7s3PmPj+OTo2BiprWeiSrzfA0HW80B4jlsYNmTDs98kar
        or9oNTXDYxwylREJcXRuq3JmakoWeuaV0EUmw4OnhaDR
X-Google-Smtp-Source: ABdhPJxHivkwWr92vIcWVAPmxdHI21UBD0f6kmFnhPInoYjQuzZMpD316VmCFypVA2DEq0sqTEZTIvRbnSo3Vys20vs=
X-Received: by 2002:a25:209:: with SMTP id 9mr31936236ybc.153.1590413813384;
 Mon, 25 May 2020 06:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200525115235.5405-1-maxim.uvarov@linaro.org>
 <20200525115235.5405-3-maxim.uvarov@linaro.org> <7de3fea9-cd88-4dbf-aa27-3cb188fd6e85@forissier.org>
In-Reply-To: <7de3fea9-cd88-4dbf-aa27-3cb188fd6e85@forissier.org>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Mon, 25 May 2020 16:36:42 +0300
Message-ID: <CAD8XO3amGVeyn9qsWE-AyGM=e36ubwxC4tiwGMVHYBL6E46ZhQ@mail.gmail.com>
Subject: Re: [Tee-dev] [PATCHv3 2/3] optee: use uuid for sysfs driver entry
To:     Jerome Forissier <jerome@forissier.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@linaro.org>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 25 May 2020 at 15:10, Jerome Forissier <jerome@forissier.org> wrote:
>
>
>
> On 5/25/20 1:52 PM, Maxim Uvarov wrote:
> > Optee device names for sysfs needed to be unique
>
> s/Optee/OP-TEE/
> s/needed/need/
>
> > and it's better if they will mean something. UUID for name
> > looks like good solution:
> > /sys/bus/tee/devices/optee-clnt-<uuid>
>
> How about mentioning it is the UUID of the Trusted Application on the
> TEE side?
>

Jerome, do you think optee-ta-<uuid> is more suitable here?


> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > ---
> >  drivers/tee/optee/device.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Thanks,
> --
> Jerome
