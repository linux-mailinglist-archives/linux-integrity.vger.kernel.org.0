Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 658EB87193
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Aug 2019 07:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfHIFgm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Aug 2019 01:36:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35229 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfHIFgi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Aug 2019 01:36:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id l14so1050006lje.2
        for <linux-integrity@vger.kernel.org>; Thu, 08 Aug 2019 22:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkESspP4zbr99ojw52v1cXFMI0dDrn0lXHnV6ilVC5Q=;
        b=atU7IHWXmtnksMrbQ1k8BhvgynR/4zyE9OG6rt3PbzKxYem2YQ+LktsQVrdVxU9YLC
         6YS80Puii0arAAtUnabMIGV3zOeVA3ApszU4i/8p8wffKinEejM0dX7NX0PIEsTgMwvO
         TLzlf48b35qwzLFYgJMSx7ys1Tf0RN+OG8QBquU8whFJhPaB1FkUd42OD9c0OyIJsSHJ
         KiLi5JgnoeFZjOcc1P0sXibjDkKRUkLk7IMYnOeem0uchFACJ8+T4ZID/+da8ANX2BVu
         Ko5uHliRhM4w0sAseDx2oJ+M853EwbV2INgH2yf6WehmFBIkH027WuZ/eSEYYm1W4a3G
         FllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkESspP4zbr99ojw52v1cXFMI0dDrn0lXHnV6ilVC5Q=;
        b=MkZckK8ZvA00fKBvfeqGnozBV+PmURM3RUK7vXn3+QUuhuXq5iiwzyKqZJ6d8EHb7k
         zFyqOWSPFHWmT3Fs/u7PcBU7l7k+JSHOd4Xtvry6LFs+W25Txf37E+uqE1/8t+fmQ2St
         u7K3I+91s6mPP3/JewHwEMktwYsj2V4sbAne5bzEw071joftpf/nDVSvSelVZPKPWh22
         Fdm4Ez2tkmzipvZR42Rc7AGihtIlkiwtVZhCuV+FBdVcN37HK0Qz7S16jOHsPTJU41cu
         VEzwCMcIDheVcfo49FTp00ypZM/kjE+A6SQi6wQZJnyzDYWmjalZX2UHiDw07HUKcRiX
         9vhw==
X-Gm-Message-State: APjAAAXNrR+CKxzBYpkrrJzq5hmcN0AsLZ+k5dpUOjQ8ed3J2I1IHSgK
        J+PywL/rMQADxH8j+sbqlMGzdOMu8DBfTITzA7E2Og==
X-Google-Smtp-Source: APXvYqxxy1TTV6QUfZHgTqMprUtqV1APmZ3PZFtZk65sg1r/cmrL6x9y1rC58d2HxqSp7BbfYHFxOnFanGeQ7Y6xGlk=
X-Received: by 2002:a2e:301a:: with SMTP id w26mr10098807ljw.76.1565328996305;
 Thu, 08 Aug 2019 22:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <1564489420-677-3-git-send-email-sumit.garg@linaro.org> <99777010-db74-096a-ce1a-da30539d6fb5@arm.com>
In-Reply-To: <99777010-db74-096a-ce1a-da30539d6fb5@arm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 9 Aug 2019 11:06:24 +0530
Message-ID: <CAFA6WYPUEUVJqk9E2F6z9oBW3VpC+xeqqpY4YrU9KPL1s0DTyA@mail.gmail.com>
Subject: Re: [Tee-dev] [RFC v2 2/6] tee: enable support to register kernel memory
To:     Stuart Yoder <stuart.yoder@arm.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, jejb@linux.ibm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dhowells@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 9 Aug 2019 at 03:57, Stuart Yoder <stuart.yoder@arm.com> wrote:
>
>
>
> On 7/30/19 7:23 AM, Sumit Garg wrote:
>
> > @@ -264,7 +266,17 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
> >               goto err;
> >       }
> >
> > -     rc = get_user_pages_fast(start, num_pages, FOLL_WRITE, shm->pages);
> > +     if (flags & TEE_SHM_USER_MAPPED) {
> > +             rc = get_user_pages_fast(start, num_pages, FOLL_WRITE,
> > +                                      shm->pages);
> > +     } else {
> > +             const struct kvec kiov = {
> > +                     .iov_base = (void *)start,
> > +                     .iov_len = PAGE_SIZE
> > +             };
> > +
> > +             rc = get_kernel_pages(&kiov, num_pages, 0, shm->pages);
>
> Passing a single kvec struct is temporary I assume?  Because as currently
> written this will only work with num_pages==1.
>

Ah, thanks Stuart for pointing this out. It should rather be an array
of kvec struct. Will fix it in next version.

-Sumit

> Stuart
