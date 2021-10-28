Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36FB43D8E6
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Oct 2021 03:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhJ1BvW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Oct 2021 21:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJ1BvW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Oct 2021 21:51:22 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777FBC061570;
        Wed, 27 Oct 2021 18:48:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so3449438pjb.3;
        Wed, 27 Oct 2021 18:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LxqobM/kclvEnjJv9r02aJf3RBoqwNAZIOfJsAbeySA=;
        b=pon1Op5dMDvKHE2+KrJgefzXgj1ZIVkZuW9c8S7n49nvNEa7Yp8e8zMd0ZwQ1oNNUh
         QSgUH8A5LlA1asPkyfG6tBIOvpejljtVp/+TvfgKS7Qc+TwS3lTu5S1FdutBQBlmMEKy
         fA+rHgtEeV9aawDuRgPvcLb2bLisMxIJtgzTvstIG/ZWzw9wjdWVjYZJQlUsUwEIYD5M
         0nNrQvxTZ03A7DMSS640ZFosWYLTzun4dGhGB5CiQX4AOK0GxaQ4m8LRPHDw0a6yD6L2
         +Lp7TPUqT9R2D54lsVjo6eySd+1V85VKq0RshuuELmhw/U4KhwICXR6+MZEHwbtFDWOH
         LnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LxqobM/kclvEnjJv9r02aJf3RBoqwNAZIOfJsAbeySA=;
        b=58N0nnQRCNxRVrttBdCfrKkPYrqNJAdc2PMD3CJLtLXOcvmKDpgtg8SyLWqu/gY9H7
         9OJ5kAcGwVLDV5uaE3vpVow0cbiinA+UT14oiZugULSwv8BNOFd4FRXR0H+CohTBDGFo
         A51ZO/8YcmxLFiGQ8i1iS71f9JGvZI2EzyYHiSrM1VrhBM/uwlecEJqZw7WnlpDdqWwQ
         HXKUOdnUsQeJeVIlDpEfmq1cckC2qqakokzMajAcnVIMCaiQvkSXFjEEECqAjkKSwr7v
         Of43lWWJ4R8qzriGT33mcFi7+E/+ZBxxB2hqZ/TpmNil8EJCTQn5N9uo4ljoZBxzlVTO
         OV3w==
X-Gm-Message-State: AOAM533mK/PZsvtxqLYUlWnpeFRBxCY0cgU24+ixPxeJqPLu+G4czVZT
        zyaGfJN0ZraJwpaXoh2SMslq9hESBlhOcFj4KNc=
X-Google-Smtp-Source: ABdhPJxotc4rU6SdEi04ZhbQkL61Bd7URPib/5h4MWJhY1kRI3pD9Tk+aSrTsIDgnIjfCKIHbv5iiStRE0rpVq+qb/M=
X-Received: by 2002:a17:90a:b296:: with SMTP id c22mr1329572pjr.13.1635385735888;
 Wed, 27 Oct 2021 18:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211026224354.GA13009@raspberrypi> <f675255eae2bc97bc571f7e798a952ea3d24e4d6.camel@linux.ibm.com>
In-Reply-To: <f675255eae2bc97bc571f7e798a952ea3d24e4d6.camel@linux.ibm.com>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Thu, 28 Oct 2021 10:48:46 +0900
Message-ID: <CADLLry7fhBazjgBJovqAwxyVdvUPLifLRxgwZwSAifQY6HGThg@mail.gmail.com>
Subject: Re: [PATCH] ima/evm: mark evm_fixmode as __ro_after_init
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?6rmA64+Z7ZiE?= <austin.kim@lge.com>,
        kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Mimi,

2021=EB=85=84 10=EC=9B=94 28=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 9:27, =
Mimi Zohar <zohar@linux.ibm.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Austin,
>
> The subject line should be just "evm:".
>
> On Tue, 2021-10-26 at 23:43 +0100, Austin Kim wrote:
> > From: Austin Kim <austin.kim@lge.com>
> >
> > evm_fixmode global variable is never modified
> > outside initcalls, so declaring it with __ro_after_init is better.
>
> Please properly format the text.  From
> Documentation/process/submitting-patches.rst:
>
>   - The body of the explanation, line wrapped at 75 columns, which will
>     be copied to the permanent changelog to describe this patch.

Thanks for feedback.
let me resend the patch after updating "subject line" and checking text-for=
mat.

BR,
Austin Kim

>
> >
> > Signed-off-by: Austin Kim <austin.kim@lge.com>
>
> Otherwise,
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>
