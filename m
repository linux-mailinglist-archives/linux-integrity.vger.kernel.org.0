Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4C87BECD
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Jul 2019 13:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfGaLDH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 Jul 2019 07:03:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42557 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfGaLDH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Jul 2019 07:03:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id t28so65154235lje.9;
        Wed, 31 Jul 2019 04:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IFRGzyEL5FegIt7aRlMOhE1NrhMFglg5rQhwfiI4MTU=;
        b=t3yZ6aH2FGBHy+wItFkigTDbGuodvFqDBP9LLZ1ezF/hRA9iBG+tI8Y6yqDtmaQ3yb
         CgfYFWmgAsPe3H2r/B9xtkHmrbxuM6xu8di2tSUcH6nrX9f4tOD+q1v96H4WMDjn7WhF
         IduAU2KNawBQKquPtTshfKt1InFmcmlcAl93N4w5Q+Anqdx//0pEDNk/tkrFdNKMi801
         a6zWOJL9lKr8IvCERg5QZjBrccmirkTUK6jiLrQhn7earUZz4+yLbUekT7u0LbAEKCwi
         FnP/5JpZDZgJ4RriT/3pt1GfJ41toYMcI++Y67bUJ7mUubYbdoWbliSjj5eaj/Yhacz6
         FLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IFRGzyEL5FegIt7aRlMOhE1NrhMFglg5rQhwfiI4MTU=;
        b=HhyCNZe2EVdO6n31yWN4FNWvz0cylxV9PZTZJRLBSxZRlHROc0yxYZ+uIyhAdxZp0h
         Lwa8P1vxJ7ueBFV69/60kSzZKkTiHxgyUsX0zjcPUMqkcMGtdYAInhMYr0fuQacx62ky
         ppIj4jxjZ8LeG/t33miCiSZJjBevkoFSkpZmqtdSjLcVbLS6dh13oJHjoW7t2hojVVtA
         H77hFLqMtpk9UG/Qve4MTLvNxh9G7SYzR2hLZvqR1c7P5NuxEijakGnYky/4lGJ/tTHz
         YAhY9wq5vLaR4SAShE1Vq0U7JMPtUrhEubBJh7IUbP5lDXKXThDB9AUAYSSA/Xi7xDks
         Kz3Q==
X-Gm-Message-State: APjAAAXbu+Myp9ZvM3wJtSwfAQaSprb159lPXsRq0yoGp8297JveVhLm
        NcoYS1TxU3dwydxwqv7UlWH4W314L9lP77bYjP4=
X-Google-Smtp-Source: APXvYqxN2K3v5gLjmpzGiaVvo7hS3EevA6OWULpgUCjzPqTrwdrg+mN+g/JP+riwWs36n/w7jJKvYH0piH3zz1jK4KQ=
X-Received: by 2002:a2e:864d:: with SMTP id i13mr56738466ljj.92.1564570984704;
 Wed, 31 Jul 2019 04:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com> <CAFA6WYPJAzbPdcpBqioxjY=T8RLw-73B_hpzX4cGnwVvm5zpJw@mail.gmail.com>
In-Reply-To: <CAFA6WYPJAzbPdcpBqioxjY=T8RLw-73B_hpzX4cGnwVvm5zpJw@mail.gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 31 Jul 2019 14:02:53 +0300
Message-ID: <CAE=Ncrb23q++z8R8UMbjDE2epEq4YVcNGzrRD31eH3JAooYejg@mail.gmail.com>
Subject: Re: [RFC v2 0/6] Introduce TEE based Trusted Keys support
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, dhowells@redhat.com,
        jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 31, 2019 at 1:26 PM Sumit Garg <sumit.garg@linaro.org> wrote:

> > Interesting, I wrote something similar and posted it to the lists a while back:
> > https://github.com/jkrh/linux/commit/d77ea03afedcb5fd42234cd834da8f8a0809f6a6
> >
> > Since there are no generic 'TEEs' available,
>
> There is already a generic TEE interface driver available in kernel.
> Have a look here: "Documentation/tee.txt".

I guess my wording was wrong, tried to say that physical TEEs in the
wild vary massively hardware wise. Generalizing these things is rough.


> > I implemented the same
> > thing as a generic protocol translator. The shared memory binding for
> > instance already assumes fair amount about the TEE and how that is
> > physically present in the system. Besides, the help from usage of shm
> > is pretty limited due to the size of the keydata.
> >
>
> If you look at patch #1 and #2, they add support to register kernel
> memory buffer (keydata buffer in this case) with TEE to operate on. So
> there isn't any limitation due to the size of the keydata.

Ah, didn't mean that. Meant that the keydata is typically pretty small
in size, so there is limited benefit from passing that in via shm if
that complicates anything.


-- 
Janne
