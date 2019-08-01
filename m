Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2F17D653
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Aug 2019 09:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfHAHaV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Aug 2019 03:30:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34679 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfHAHaV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Aug 2019 03:30:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id p17so68339621ljg.1;
        Thu, 01 Aug 2019 00:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rdlu4Ad817zx+iOTcsjqQM76adHXpOWbEydNxUMSAfU=;
        b=UzX7Ppc2TrBZ0COGTnbdhjA8/92a3SmUDMUBe7LHJnt7UzjMivXlt5ctFlFa8oCssU
         SYmn0SU0YmBzG+xH1D7Xm6LwZdeQI4DMIuCFZ2apRvrxooP1XuUSa4h0cqvLb+yZ84WV
         gzhVlRU7mA0IUpLblx7J9CW2e26MxMXKOvypsTKT7OA+spMddfGXtcyN9dJUUq1oZ3L2
         WXvXffxmd9eeUSa0XCpuLJgrwP5q0Njaz9GFOXVxMiAPzbRBN62y8b/zTpo9Vvq+4wem
         H3/6ktlq9TuBKIZYLltyIKoSiqKgUj5S5PLdGFqXB4oRQrT7eg2cwmMCz/P449szEX0W
         H97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rdlu4Ad817zx+iOTcsjqQM76adHXpOWbEydNxUMSAfU=;
        b=hNkzAwrdbRsfJhStlM5KWPM6IHEqTqlT31w7Y2vQVHfkv5EOmYrKuNf0uv+9UnqLUP
         JDkfs5TfYgJHtCvgF7d7dGVaO9EkfU0FNZT92K0qEnqYZuyL+MTr+/Fvd1DNgCfWsOFY
         9DW5DAh3ZIflDF5nCRzVH7DwDR4u5MSsT5bXuBJ4v/SjTQc+xw5X6mozi6zhxlfA1Pjl
         zH2esaCyhlp7FXXNrHby9YSW6RwqXtU5tM3nvg2Kg5Q2gMWjlzmjkDhrILJw5pDHngDD
         HHSIYKS8B1QYJRQY2+R2zCKIjGLTKfRPGjPFz2klAM2m4vb3yNpNiSGrUfns0KnTZkAE
         4kXw==
X-Gm-Message-State: APjAAAU/ZXp8pPwlYi6lk4+neztU55IIbSdYv/xBVNVCh92bF3gmGhqU
        /m0LDSjwG/TdnxAdGkMYQK6y33tzBuFIrvVeQXI=
X-Google-Smtp-Source: APXvYqzD4VpesQpUb8MYg+Q5e04vCOtwoAClw957rRW1FlaRZEsQmMx74W0N61umpEVSCQWDHKBhpRkvaPwaSWsWw1Q=
X-Received: by 2002:a2e:1290:: with SMTP id 16mr64210069ljs.88.1564644618088;
 Thu, 01 Aug 2019 00:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
 <CAFA6WYPJAzbPdcpBqioxjY=T8RLw-73B_hpzX4cGnwVvm5zpJw@mail.gmail.com>
 <CAE=Ncrb23q++z8R8UMbjDE2epEq4YVcNGzrRD31eH3JAooYejg@mail.gmail.com>
 <CAFA6WYOKcOzSwakHhgshZcebD8ZBMSi7xQdjWYFS79=Xc+odOg@mail.gmail.com>
 <CAE=NcrYz8bT9zDhS_ZcvY84fpeTDxZ-KhJKeQGGyf=o4pG2J-Q@mail.gmail.com> <19d9be198619e951750dedeb4d0a7f372083b42c.camel@pengutronix.de>
In-Reply-To: <19d9be198619e951750dedeb4d0a7f372083b42c.camel@pengutronix.de>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 1 Aug 2019 10:30:06 +0300
Message-ID: <CAE=NcraqD9FNM0Gk9UGhPGi3heVzZrAKGc1gNZxoe1OnDaQ=pA@mail.gmail.com>
Subject: Re: [Tee-dev] [RFC v2 0/6] Introduce TEE based Trusted Keys support
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, jejb@linux.ibm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dhowells@redhat.com, linux-security-module@vger.kernel.org,
        keyrings@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 1, 2019 at 9:50 AM Rouven Czerwinski
<r.czerwinski@pengutronix.de> wrote:

> > I'm aware of it - I have implemented a large part of the GP TEE APIs
> > earlier (primarily the crypto functions). Does the TEE you work with
> > actually support GP properly? Can I take a look at the code?
>
> AFAIK Sumit is working with the OP-TEE implementation, which can be
> found on github: https://github.com/op-tee/optee_os

Thanks, I will take a look. The fundamental problem with these things
is that there are infinite amount of ways how TEEs and ROTs can be
done in terms of the hardware and software. I really doubt there are 2
implementations in existence that are even remotely compatible in real
life. As such, all things TEE/ROT would logically really belong in the
userland and thanks to the bpfilter folks now the umh logic really
makes that possible ... I think. The key implementation I did was just
an RFC on the concept, what if we start to move the stuff that really
belongs in the userspace to this pseudo-userland. It's not kernel, but
it's not commonly accessible userland either. The shared memory would
also work without any modifications between the umh based TEE/ROT
driver and the userland if needed.

Anyway, just my .02c. I guess having any new support in the kernel for
new trust sources is good and improvement from the current state. I
can certainly make my stuff work with your setup as well, what ever
people think is the best.


--
Janne
