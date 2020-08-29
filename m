Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2042563A2
	for <lists+linux-integrity@lfdr.de>; Sat, 29 Aug 2020 02:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgH2ANK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Aug 2020 20:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgH2ANJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Aug 2020 20:13:09 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821A7C061264
        for <linux-integrity@vger.kernel.org>; Fri, 28 Aug 2020 17:13:09 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id k10so556059lfm.5
        for <linux-integrity@vger.kernel.org>; Fri, 28 Aug 2020 17:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNFLw0ot2UvtZC127DBirA3jf4cIL8H0hU80FQO1K7A=;
        b=gbjID+kzOVWiK+deGwiinJV5QV4Z89BLOnxleEu3LAppfx8ENIhXSfNmnlfB4PsdtK
         UEhk8G8v0hi+sXob/fGaj5AGi3zhBxn2R6vprlmtfDeXdaRwJDYlV8q96hbxG5L9x9PD
         ABmCWIRxzrEVWLqvXVrNhY4F08iAwmb9CzGJWPqAkJsMXMfJC9VCJPF7z0OM5tC23ikP
         pTujYlVn6LqsOtiVSfysTWx8oTB4WTFC0x+XRhsM/XIQKy41AP2DUIdh13QMzYrmF2XP
         mpj6nAGRkXa0Y68QVBM2YQETdozRxN+OOZHNPJ1du11vHYnpuZh7FNcNb2ooAFgpLjdh
         2P4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNFLw0ot2UvtZC127DBirA3jf4cIL8H0hU80FQO1K7A=;
        b=sR2TmkpbhHq8dtpDD5BPHA5Gf/CkCheYYMr7bhfZbtMNj5tovRm9f4WXZiwjsooCBx
         ZoabBOaGcwQ+fejuMRkIXgk0VeLUDQxDbo5mJ/AVVLyFPw4y6IUVXHGncIpzoW9lUW+X
         61lXBx/rn0knNnch/973HBA6d73fWzKu++TzYjRPRvcxeN3A7slh87Mymu2bPKb2Xxfc
         qmsnolcxkjCYmRSJbq5U5YGT5VOBCNTyCxDvrPqHFY+3qieJNdcNsH+ZCGnI2jObYtnw
         KSgneJoF+BPYaoJbdgzdP8Hme3M8b6kRJ7NDO1uMzBP0VYh5KvVmIUqOX1DZIVzSSQfx
         X1Eg==
X-Gm-Message-State: AOAM5310d8osE8DIJwKV+eIweUSHX3BZrn9lDktZ3qoxpWZe4ph1lSEK
        7WJY0vRahYoSGjyS0gYQQiNlkq8Ue8et2d5aNqcZ56oswpU=
X-Google-Smtp-Source: ABdhPJx2xyl3K5lI/hsxFB3WkFMvENn/Qc6nBnM3s9YlZXNtcDyFZ3YWQl2S+DMfVdMEiPn9zhc0olHuVSh8QdiKITM=
X-Received: by 2002:a19:915b:: with SMTP id y27mr460577lfj.134.1598659987782;
 Fri, 28 Aug 2020 17:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <1586994699.3931.18.camel@HansenPartnership.com>
 <20200827152445.15439-1-jandryuk@gmail.com> <20200828231823.GA20705@linux.intel.com>
In-Reply-To: <20200828231823.GA20705@linux.intel.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Fri, 28 Aug 2020 20:12:55 -0400
Message-ID: <CAKf6xpvJTChV5+pULrWwx7JX+jS6r8nM9mGEBJLQN3P4D1uO_g@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis: work around status register bug in
 STMicroelectronics TPM
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Omar Sandoval <osandov@osandov.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 28, 2020 at 7:18 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Aug 27, 2020 at 11:24:45AM -0400, Jason Andryuk wrote:
> > James Bottomley wrote:
> > >On Wed, 2020-04-15 at 15:45 -0700, Omar Sandoval wrote:
> > >> From: Omar Sandoval <osandov@fb.com>
> > >>
> > >> We've encountered a particular model of STMicroelectronics TPM that
> > >> transiently returns a bad value in the status register. This causes
> > >> the kernel to believe that the TPM is ready to receive a command when
> > >> it actually isn't, which in turn causes the send to time out in
> > >> get_burstcount(). In testing, reading the status register one extra
> > >> time convinces the TPM to return a valid value.
> > >
> > >Interesting, I've got a very early upgradeable nuvoton that seems to be
> > >behaving like this.
> > >
> > >> Signed-off-by: Omar Sandoval <osandov@fb.com>
> > >> ---
> > >>  drivers/char/tpm/tpm_tis_core.c | 12 ++++++++++++
> > >>  1 file changed, 12 insertions(+)
> > >>
> > >> diff --git a/drivers/char/tpm/tpm_tis_core.c
> > >> b/drivers/char/tpm/tpm_tis_core.c
> > >> index 27c6ca031e23..277a21027fc7 100644
> > >> --- a/drivers/char/tpm/tpm_tis_core.c
> > >> +++ b/drivers/char/tpm/tpm_tis_core.c
> > >> @@ -238,6 +238,18 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
> > >>    rc = tpm_tis_read8(priv, TPM_STS(priv->locality), &status);
> > >>    if (rc < 0)
> > >>            return 0;
> > >> +  /*
> > >> +   * Some STMicroelectronics TPMs have a bug where the status
> > >> register is
> > >> +   * sometimes bogus (all 1s) if read immediately after the
> > >> access
> > >> +   * register is written to. Bits 0, 1, and 5 are always
> > >> supposed to read
> > >> +   * as 0, so this is clearly invalid. Reading the register a
> > >> second time
> > >> +   * returns a valid value.
> > >> +   */
> > >> +  if (unlikely(status == 0xff)) {
> > >> +          rc = tpm_tis_read8(priv, TPM_STS(priv->locality),
> > >> &status);
> > >> +          if (rc < 0)
> > >> +                  return 0;
> > >> +  }
> > >
> > >You theorize that your case is fixed by the second read, but what if it
> > >isn't and the second read also returns 0xff?  Shouldn't we have a line
> > >here saying
> > >
> > >if (unlikely(status == 0xff))
> > >     status = 0;
> > >
> > >So if we get a second 0xff we just pretend the thing isn't ready?
> >
> > Thanks for the fix, Omar!
> >
> > I tried the patch and it helps with STM TPM2 issues where commands fail
> > with the kernel reporting:
> > tpm tpm0: Unable to read burstcount
> > tpm tpm0: tpm_try_transmit: send(): error -16
> >
> > My testing was with 5.4, and I'd like to see this CC-ed stable.
> >
> > When trying to diagnose the issue before finding this patch, I found it
> > was timing sensitive.  I was seeing failures in the OpenXT installer.
> > The system is basically idle when issuing TPM commands which frequently
> > failed.  The same hardware booted into a Fedora Live USB image didn't
> > have any TPM command failures.  One notable difference between the two
> > is Fedora is CONFIG_PREEMPT=y and OpenXT is CONFIG_PREEMPT_NONE=y.
> > Switching OpenXT to PREEMPT=y helped some, but there were still some
> > issues with commands failing.  The second interesting thing was running tpm
> > commands in OpenXT under trace-cmd let them succeed.  I guess that was enough
> > to throw the timing off.
> >
> > Anyway, I'd like to see this patch applied, please.
> >
> > Thanks,
> > Jason
>
> There was v2 sent after this:
>
> https://patchwork.kernel.org/patch/11492125/

Thanks!  That one didn't come up in a search for STM on lore.kernel.org.

> Unfortunately it lacks changelog. What was changed between v1 and v2?
> Why v3 has not been sent yet? I see a discussion with no final
> conclusion.

Looks like v2 added James's suggestion with a comment (sorry the
formating is off):

+ /*
+ * The status is somehow still bad. This hasn't been observed in
+ * practice, but clear it just in case so that it doesn't appear
+ * to be ready.
+ */
+ if (unlikely(status == 0xff))
+         status = 0;

But, yes, the decision on the alternate approach is unresolved.

Thanks again,
Jason
