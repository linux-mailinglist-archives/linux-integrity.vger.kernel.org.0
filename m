Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B3D12BE23
	for <lists+linux-integrity@lfdr.de>; Sat, 28 Dec 2019 18:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfL1RSB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 28 Dec 2019 12:18:01 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:40998 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfL1RSB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 28 Dec 2019 12:18:01 -0500
Received: by mail-oi1-f176.google.com with SMTP id i1so10269841oie.8
        for <linux-integrity@vger.kernel.org>; Sat, 28 Dec 2019 09:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQb9gUF/kF+QGb1YAnMfnG5z8D5xbT49s3EVMzZZtcQ=;
        b=CBluK9BNCD3CqbBclvb/CqjTAW4mELSnQyoy5xbZXd7rECwk3SR5yi3Xx7KdDds6+d
         fvY2wO8bgcyzpRBmFwkZ6q+I6KAAkyqHkOTyuKwVt7q7vJ2JK4cWHpanbTczwri80ixU
         62bfaJx02L7wKPfMhxI0HTONuQ7bV1gzEXu2JJrGi3EbKe5c/ycKzuPlBALQk0XRi1Zs
         NaI2pYc91y9VVwB1/CjnMPkjRXVCEqhLd+4plTUB9VlvJb3/WKJctko7p/giM/Ydne9L
         UpRiwsHjX6Z/YMsljlr3tGCZMzBxU1t8aZ7362X6wMlAyBFp7AVgeOjcITvDnEzs7AFw
         WH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQb9gUF/kF+QGb1YAnMfnG5z8D5xbT49s3EVMzZZtcQ=;
        b=d2oQtiDDikl9y/AbKBA72v+K9+bOUdqYTMCbrT6d1/+kwXaw66kcV9ICxAomGxIkkG
         +NMqGqiZ7FGc/kArVreAtUsjgZxOMAFomibB7z9qpD7RzoLIirWrAHzv2asPoMe+RSyw
         df2UvQ1Nkcq1RgdH5v+eNs1Hd4Sg5hsW5FZrx6zC9knx/zOiprPFb5Vr9NwzH8m24nBB
         lHqqibTmRP+hKdVjn1dGoTIu4UQq5ZryUZyVU63n5lDg1EKoMJ1K2NfGEkYZ5vl61T2o
         MeMShfOSyGLYzDFGAfVvxquR1wrpc/UUPWKfUVRKBPE6v0IhfFTBGy2ZUjj1CHnlopK5
         StUg==
X-Gm-Message-State: APjAAAV3hdIxSAEGNqjfeauqEj7DfoL4j2T8Tn9EnbJoz1s6AbpbFcmW
        dDubzWM8p07stqY1D8/1GpGAdb6QbJhlPjKizz/hog==
X-Google-Smtp-Source: APXvYqwemknthHi9yLx4JjT2to533i4B7dw54JsE7re71KV1fc7wz7TN5ETZiNlMa5c9q5VrlhdoVim8dRMHj3A9/dQ=
X-Received: by 2002:aca:4c9:: with SMTP id 192mr4907748oie.105.1577553480633;
 Sat, 28 Dec 2019 09:18:00 -0800 (PST)
MIME-Version: 1.0
References: <1577122577157232@kroah.com> <CAPcyv4jfpOX85GWgNTyugWksU=e-j=RhU_fcrcHBo4GMZ8_bhw@mail.gmail.com>
 <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
 <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com> <20191228151526.GA6971@linux.intel.com>
In-Reply-To: <20191228151526.GA6971@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 28 Dec 2019 09:17:49 -0800
Message-ID: <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Dec 28, 2019 at 7:15 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Dec 27, 2019 at 08:11:50AM +0200, Jarkko Sakkinen wrote:
> > Dan, please also test the branch and tell if other patches are needed.
> > I'm a bit blind with this as I don't have direct access to the faulting
> > hardware. Thanks. [*]
> >
> > [*] https://lkml.org/lkml/2019/12/27/12
>
> Given that:
>
> 1. I cannot reproduce the bug locally.
> 2. Neither of the patches have any appropriate tags (tested-by and
>    reviewed-by). [*]
>
> I'm sorry but how am I expected to include these patches?

Thanks for the branch, I'll get it tested on the failing hardware.
Might be a few days due to holiday lag.
