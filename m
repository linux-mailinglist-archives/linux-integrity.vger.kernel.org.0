Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17FBA12CD68
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Dec 2019 08:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfL3HmJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Dec 2019 02:42:09 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32926 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfL3HmJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Dec 2019 02:42:09 -0500
Received: by mail-ot1-f65.google.com with SMTP id b18so23448195otp.0
        for <linux-integrity@vger.kernel.org>; Sun, 29 Dec 2019 23:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cwlK7F0OhgofZ2g1c0eZ3ZVDb9GpV5ov9doTgWC0/9U=;
        b=BIp45yVziKNxpjGFASN8D5v/1fT7LjBa4Qn8eNSmrBq3xaVgnM44DM6PK7rx3YeBNi
         BDWg9AfiT3EWhYCOfZdHIo3SkBFKNmNUONsZnmcUK7pdKNwI11KFuoPkBLfBAXS5n8Fr
         mud8KAX20EIHYtiOXNQY/ktuH9N97++24K9VBM7ShhN4uC68X1Ta0t/VTCvKUNwQwhdV
         kf4ZRtK6H5V1Z3I5V5BgOY7krjGLjDje15J+E3eKmtgyyS0N/uXeW19g4XAnM/Tqcdv5
         jqhypWawBaFAHuyunqRhY0zOH+DDpiG8bRo7oS/Sx3iURFKo4RyorYe1PY4Q5ddsmfAZ
         Q3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cwlK7F0OhgofZ2g1c0eZ3ZVDb9GpV5ov9doTgWC0/9U=;
        b=iHe+PPZVg6t98tuOaLFZCriV9wJNTpxnB4oZv6D46G2LHx9qdUUUZQUCup5pMseFiy
         gPyGkIv27ESSvirr7KhwQd09EuJNWTxs7U5V7IvnnUI5xm1YsWK0mUEMKt3Kx6an2dyt
         LM8J/7zMH0lJYkLlrEhFc492tPsHUb2C5Ni61qAj6KFXYwnXBRrZn1WFWlRGn6NUNH7u
         Cx3y+fZNj21echqeb2hIv689BXh1zfttnbdCFcMQL5y33VbDPUN6T4ayZgygue9h6tgi
         xUH5Wr0k/6GXyOuBNY4+hEQyZt1/S69paoMH4bYmb3wEXhzDm5K6q8ReMGNtN2Jg4hxY
         LCdA==
X-Gm-Message-State: APjAAAV6bWpX1RgbrCF4JBHqZC5EqbjfLiFjOhg71pPdZikmlxj9lBdB
        hn9Oa4qtLXo4dv8NVLbJV+M7r5UeegQ6PNEDtoKlcQ==
X-Google-Smtp-Source: APXvYqxZCdiUMDh71LNzQUqteO0QNtYqYbR0IterKvdS2rrqYRU7b1xSIGCSAE+kMAVQyN/LJmYR708bEBLXhWJ92iQ=
X-Received: by 2002:a9d:7852:: with SMTP id c18mr64344596otm.247.1577691728093;
 Sun, 29 Dec 2019 23:42:08 -0800 (PST)
MIME-Version: 1.0
References: <1577122577157232@kroah.com> <CAPcyv4jfpOX85GWgNTyugWksU=e-j=RhU_fcrcHBo4GMZ8_bhw@mail.gmail.com>
 <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
 <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com>
 <20191228151526.GA6971@linux.intel.com> <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
In-Reply-To: <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 29 Dec 2019 23:41:56 -0800
Message-ID: <CAPcyv4iyQeXBWvp8V_UPBsOk29cfmTVZGYrrDgyYYqzsQvTjNA@mail.gmail.com>
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

On Sat, Dec 28, 2019 at 9:17 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Sat, Dec 28, 2019 at 7:15 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Fri, Dec 27, 2019 at 08:11:50AM +0200, Jarkko Sakkinen wrote:
> > > Dan, please also test the branch and tell if other patches are needed.
> > > I'm a bit blind with this as I don't have direct access to the faulting
> > > hardware. Thanks. [*]
> > >
> > > [*] https://lkml.org/lkml/2019/12/27/12
> >
> > Given that:
> >
> > 1. I cannot reproduce the bug locally.
> > 2. Neither of the patches have any appropriate tags (tested-by and
> >    reviewed-by). [*]
> >
> > I'm sorry but how am I expected to include these patches?
>
> Thanks for the branch, I'll get it tested on the failing hardware.
> Might be a few days due to holiday lag.

This looked like the wrong revert to me, and testing confirms that
this does not fix the problem.

As I mentioned in the original report [1] the commit that bisect flagged was:

    5b359c7c4372 tpm_tis_core: Turn on the TPM before probing IRQ's

That commit moved tpm_chip_start() before irq probing. Commit
21df4a8b6018 "tpm_tis: reserve chip for duration of tpm_tis_core_init"
does not appear to change anything in that regard.

Perhaps this hardware has always had broken interrupts and needs to be
quirked off? I'm trying an experiment with tpm_tis_core.interrupts=0
workaround.


[1]: https://lore.kernel.org/linux-integrity/CAA9_cmeLnHK4y+usQaWo72nUG3RNsripuZnS-koY4XTRC+mwJA@mail.gmail.com/
