Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6127D95D
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Aug 2019 12:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbfHAK1k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Aug 2019 06:27:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46109 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbfHAK1i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Aug 2019 06:27:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id z15so45575840lfh.13
        for <linux-integrity@vger.kernel.org>; Thu, 01 Aug 2019 03:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WavWyKi8xsYiSOtxhL/Mupk8NjZ0g0ho0jTiP91yMfo=;
        b=ILM98uDeH4Kq4OeEe/3O0IuQ1XoT0Qrd38bGRpHpc3YusALaKFR5/NOUMP1lmLymeL
         uerpCmuZR0a1Ra+J73y/ObaEd3+lTlP+dZRGaqKwbJ5arq4Dpi9co1/B/neD92Q2EM9o
         GaJZgvDUjykVsBwgoxzGc0Yi4uiXhFR1WxNFbCKjIyWlRjAqYjRv7UpAuWRa+KOyiTSI
         4ekpU/2spRg64dnda+XLs9xM5a6iUu3cw0WBJ+BV6IV+srs+pRbtYrqupbnr4gqMoCIs
         3kdTbq6UX1CSHZkp7klNL5IqDWMCnxgiRV98mt9LYpxn2mukho+gu6Gs/5Qm/eJnVEHP
         FmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WavWyKi8xsYiSOtxhL/Mupk8NjZ0g0ho0jTiP91yMfo=;
        b=e4ZEy3JCMfqVPPZURLlMZUNFr0HtwVKFDFWqcsZt+HPMl5VIMbxGI9AZgtXNlBbzUL
         ZIQy1wAXJgHZIx2kZqZU5jK16IKuCGjtun3+jaM9YyG1xugRfcpuIBYAf7n1Fd2Dzxbw
         7bPeAZ+0/vejHswGIvAVoeQLFQ7rgCRTdo7/UOi+JsFTbzy5ezBS28f8q+GWojNnm8mw
         93lBLv3S3qwEWDGSnqzfE1jryyyiZvMcV46HbOyc7lCi7kviagsozf2U9zxA9+C9nxaC
         U3Lbb88p3Wn46rw8wbP2SEqsWqh8En6irNMjR0+dABj7sExLKpqWipi+D8C3nxxPF1//
         64bA==
X-Gm-Message-State: APjAAAVkPFHM7lmc4qEP3cCHtMDOkhTN/KlE2JyWDGU4H5ntgVutVAje
        dbyu5Wq38oOZ876u7IRTRSNXFQWOU2sJ9eLtW31zFw==
X-Google-Smtp-Source: APXvYqwcjanstBYp6ci2fM+2NuJ04h4Vkq12OnvRSlbvhbEkiqzESM49hkfaP96wyF8xEMXGU6rNE8v77LiXVZl4mq0=
X-Received: by 2002:ac2:5094:: with SMTP id f20mr63091641lfm.186.1564655256560;
 Thu, 01 Aug 2019 03:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
 <CAFA6WYPJAzbPdcpBqioxjY=T8RLw-73B_hpzX4cGnwVvm5zpJw@mail.gmail.com>
 <CAE=Ncrb23q++z8R8UMbjDE2epEq4YVcNGzrRD31eH3JAooYejg@mail.gmail.com>
 <CAFA6WYOKcOzSwakHhgshZcebD8ZBMSi7xQdjWYFS79=Xc+odOg@mail.gmail.com>
 <CAE=NcrYz8bT9zDhS_ZcvY84fpeTDxZ-KhJKeQGGyf=o4pG2J-Q@mail.gmail.com>
 <19d9be198619e951750dedeb4d0a7f372083b42c.camel@pengutronix.de>
 <CAE=NcraqD9FNM0Gk9UGhPGi3heVzZrAKGc1gNZxoe1OnDaQ=pA@mail.gmail.com>
 <CAFA6WYPt4q+jaJbaoauXKr2qKgBHvtQ663s4t=W3nuPJPe2xpw@mail.gmail.com> <CAE=NcrbujsM8wYJXq+s=o5Vy1xY1b0uKYBGvp6UP5ex70HrB2Q@mail.gmail.com>
In-Reply-To: <CAE=NcrbujsM8wYJXq+s=o5Vy1xY1b0uKYBGvp6UP5ex70HrB2Q@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 1 Aug 2019 15:57:25 +0530
Message-ID: <CAFA6WYNzW-+N3rcKMCJ0wK9peuq97CETnxMSwxixN7844XinTw@mail.gmail.com>
Subject: Re: [Tee-dev] [RFC v2 0/6] Introduce TEE based Trusted Keys support
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
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

On Thu, 1 Aug 2019 at 14:00, Janne Karhunen <janne.karhunen@gmail.com> wrote:
>
> On Thu, Aug 1, 2019 at 10:58 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> > > Anyway, just my .02c. I guess having any new support in the kernel for
> > > new trust sources is good and improvement from the current state. I
> > > can certainly make my stuff work with your setup as well, what ever
> > > people think is the best.
> >
> > Yes your implementation can very well fit under trusted keys
> > abstraction framework without creating a new keytype: "ext-trusted".
>
> The fundamental problem with the 'standardized kernel tee' still
> exists - it will never be generic in real life. Getting all this in
> the kernel will solve your problem and sell this particular product,
> but it is quite unlikely to help that many users. If the security is
> truly important to you, would you really trust any of this code to
> someone else? In this day and age, I really doubt many do.

There are already multiple platforms supported by OP-TEE [1] which
could benefit from this trusted keys interface.

> Everyone
> does their own thing, so this is why I really see all that as a
> userspace problem.
>

IMO, we should try to use standardized interfaces which are well
thought off rather than implementing your own.

[1] https://optee.readthedocs.io/general/platforms.html


-Sumit

>
> --
> Janne
