Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024654931F4
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jan 2022 01:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349264AbiASAme (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jan 2022 19:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiASAme (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jan 2022 19:42:34 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B5EC061574
        for <linux-integrity@vger.kernel.org>; Tue, 18 Jan 2022 16:42:33 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id m3so2522592lfu.0
        for <linux-integrity@vger.kernel.org>; Tue, 18 Jan 2022 16:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WC6vCmlBaJcnOq0yqjfAIqZ48ognlL3tNUNuOCNKcLA=;
        b=JjdZ1Qa07omNstuAfkDNTfKeVCeI3Y9spOp3On6OcIMntUS3IS5W/0Jqr8JBWQcuuq
         wvfuCIEq9LyVMNJhUREVCJJH/yzkpHWh/Jc+sx5VLJafgGpTKk90V/aeek82j8R9SpIG
         ssvHuxn4pBXKmBCOrMUZV8jYXXphDOr8QW6G0KsuREth4TOM/Bvt9ZM9E117kgZgQPiV
         IAjpkAYGdX9tH76Y4rt/BT4Rbqacl/i5q0/wIfHLLkuz1f/HVGDOzaUcZn45X1U659Ve
         kDcqj1epuybqsUqzS2+tPbfOWz+IqOeEAjAJ30Z4hCxtFPMwwFg+tP2ftuSGjhbA6Jj4
         fhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WC6vCmlBaJcnOq0yqjfAIqZ48ognlL3tNUNuOCNKcLA=;
        b=N3Zp9OUSP2sOHWzFozzbGD5UrvXi3AkL6hGLZ7l+FRhtUKMYacLsTWTTmaDq1I0x8t
         ttG9KWcKPW93QoiMnJYogm4XiOBAKMNOQasPBwo2jsq2oIe5esh199+iXg+JmeRTKopW
         KEXzMLLz42F6jEG58pdY2fC6BcVPZX1xI+ax3Hf4O7pqeDmO1H+/tV58PpFm+pi+NoSN
         lW7dbQ0yB0URCKfwRuAbxax7SqCBMAONIO8sBM9ONQgcY1lbSRVbnm29B73+HkYji4zW
         28Q0MNCb/s5ya3f4Vrrrg+wuuUr0fivBnxt+ajr2uSwSy0uqBVODfGwIZLBRhuAnwac5
         bTdw==
X-Gm-Message-State: AOAM5313kPA2DNObqRw8uXxFPHSn4ZVHRe9WQa7K311bjn9Cvnb6cc3I
        GKFX0eRGmjxJfB40LDWbBGA1C6R12OgBq5zOoNbVkw==
X-Google-Smtp-Source: ABdhPJyh4AKgqcun9w5U2hmSqhuaRzXvM7cXo5We6xiKZ5ywhTrrC+pfHoCKkGU6LnR5SyPjoI1uggDb8QK43Jy9o4Y=
X-Received: by 2002:a2e:9e98:: with SMTP id f24mr22000014ljk.347.1642552951599;
 Tue, 18 Jan 2022 16:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20220118183650.3386989-1-keescook@chromium.org>
 <CAG48ez00FFW-n_Pi=+ya1xY5QuB3q2mPr8++scVe3h3ROeF_mg@mail.gmail.com>
 <20220118193931.GH8034@ziepe.ca> <202201181255.DB5D38F6AA@keescook>
In-Reply-To: <202201181255.DB5D38F6AA@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 19 Jan 2022 01:42:04 +0100
Message-ID: <CAG48ez1iTF9KegKJrW5a3WzXgCPZJ73nS2_e5esKJRppdzvv8g@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: vtpm_proxy: Double-check to avoid buffer overflow
To:     Kees Cook <keescook@chromium.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 18, 2022 at 10:20 PM Kees Cook <keescook@chromium.org> wrote:
> On Tue, Jan 18, 2022 at 03:39:31PM -0400, Jason Gunthorpe wrote:
> > On Tue, Jan 18, 2022 at 08:32:43PM +0100, Jann Horn wrote:
> > > On Tue, Jan 18, 2022 at 7:37 PM Kees Cook <keescook@chromium.org> wro=
te:
> > > > When building with -Warray-bounds, this warning was emitted:
> > > >
> > > > In function 'memset',
> > > >     inlined from 'vtpm_proxy_fops_read' at drivers/char/tpm/tpm_vtp=
m_proxy.c:102:2:
> > > > ./include/linux/fortify-string.h:43:33: warning: '__builtin_memset'=
 pointer overflow between offset 164 and size [2147483648, 4294967295]
> > > > [-Warray-bounds]
> > > >    43 | #define __underlying_memset     __builtin_memset
> > > >       |                                 ^
> > >
> > > Can you explain what that compiler warning actually means, and which
> > > compiler it is from? Is this from a 32-bit or a 64-bit architecture?
>
> This is from ARCH=3Di386
>
> > >
> > > It sounds like the compiler (GCC?) is hallucinating a codepath on
>
> Yes, GCC 11.2.
>
> > > which "len" is guaranteed to be >=3D2147483648, right? Why is it doin=
g
> > > that? Is this some kinda side effect from the fortify code?
>
> Right; I don't know what triggered it. I assume the "count" comparison.
> The warning is generated with or without CONFIG_FORTIFY_SOURCE. It is
> from adding -Warray-bounds. This is one of the last places in the kernel
> where a warning is being thrown for this option, and it has found a lot
> of real bugs, so Gustavo and I have been working to get the build
> warning-clean so we can enable it globally.
>
> > I agree, this looks bogus, or at least the commit message neeeds alot
> > more explaining.
> >
> > static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_=
t count)
> >
> >         if (count > sizeof(proxy_dev->buffer))
> >             [...]
> >         proxy_dev->req_len =3D count;
> >
> > Not clear how req_len can be larger than sizeof(buffer)?
>
> Given the current code, I agree: it's not possible.
>
> As for the cause of the warning, my assumption is that since the compiler
> only has visibility into vtpm_proxy_fops_read(), and sees size_t len set
> from ((struct proxy_dev *)filp->private_data)->req_len, and it performs
> range checking perhaps triggered by the "count" comparison:
>
>
> static ssize_t vtpm_proxy_fops_read(struct file *filp, char __user *buf,
>                                     size_t count, loff_t *off)
> {
>         struct proxy_dev *proxy_dev =3D filp->private_data;
>         size_t len;
>         ...
>         len =3D proxy_dev->req_len;
>
>         if (count < len) {
>                 ...
>                 return -EIO;
>         }
>
>         rc =3D copy_to_user(buf, proxy_dev->buffer, len);
>         memset(proxy_dev->buffer, 0, len);
>
>
> I haven't been able to reproduce the specific cause of why GCC decided to
> do the bounds checking, but it's not an unreasonable thing to check for,
> just for robustness.

Ok, I think this is what's happening:


$ cat bogus_bounds_warning_small.i
struct proxy_dev {
 unsigned char buffer[4096];
};

long state;

void vtpm_proxy_fops_read(struct proxy_dev *proxy_dev, unsigned int len) {
  /*
   * sz =3D=3D SIZE_MAX =3D=3D -1  because the compiler can't prove whether=
 proxy_dev
   * points to an array or a single object and we're using the type-0 versi=
on.
   */
  int sz =3D __builtin_object_size(proxy_dev->buffer, 0);
  _Bool check_result;

  /* always false but must keep this check to trigger the warning */
  if (sz >=3D 0 && sz < len) {
    check_result =3D 0;
  /*
   * compiler forks the rest of the function starting at this check, probab=
ly
   * because it sees that a branch further down has a condition that depend=
s on
   * which branch we took here
   */
  } else if (len > 0x7fffffff/*INT_MAX*/) {
    check_result =3D 0;
  } else {
    check_result =3D 1;
  }
  /*
   * this part is basically duplicated, it is compiled once for the
   * len<=3D0x7fffffff case and once for the len>0x7fffffff case
   */
  __builtin_memset(proxy_dev->buffer, 0, len);

  if (check_result)
    state |=3D 1;
}
$ gcc -ggdb -std=3Dgnu89 -Warray-bounds -m32 -mregparm=3D3 -fno-pic
-march=3Di686 -O2 -c -o bogus_bounds_warning.o
bogus_bounds_warning_small.i
bogus_bounds_warning_small.i: In function =E2=80=98vtpm_proxy_fops_read=E2=
=80=99:
bogus_bounds_warning_small.i:32:3: warning: =E2=80=98__builtin_memset=E2=80=
=99
specified bound between 2147483648 and 4294967295 exceeds maximum
object size 2147483647 [-Wstringop-overflow=3D]
   32 |   __builtin_memset(proxy_dev->buffer, 0, len);
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Here's what the CFG of the generated machine code looks like - you can
see how the function is split up starting at the "len > 0x7fffffff"
check: https://var.thejh.net/gcc_bounds_warning_cfg.png

(You can also see how the two copies of __builtin_memset() generate
some pretty gross and bloated code...)
