Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC8F7D8F0
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Aug 2019 12:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfHAKAV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Aug 2019 06:00:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34484 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfHAKAV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Aug 2019 06:00:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id p17so68762114ljg.1
        for <linux-integrity@vger.kernel.org>; Thu, 01 Aug 2019 03:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7gKvcJabgKuUbvQyf6qVD7f9YQGD2U9hjlCz5FyenjE=;
        b=txHMwmKZEVe1dwKVgNRDOeChaNcOfwWW6SO7gSedbMhpOzA9pGEQq9mcO49z6Dy2nq
         XZyWuFjIrr94RLjep/tAet6DBQKpSwV/mDC6XfoCunkPf9vbhzXgPsigyelRV46JU+xe
         J7xWzK5+5BkhHdA/6IypMjQbxyqn63eNRO/1UvC7UyIATn/QhVzjMh5B8inochEaqOA3
         2t6ad/g+kpwhtVoWx9DFfwqr7P8Cwzey8gO7zTEN2pxnViu9dWy8Unqk8ev4XtKYTzJK
         r5Za5d8YNy3etaA/lLz8F6H7dqnCmoE6cGZ5Q+9f+tAQ0MszPXaB3xbzfBkuRZCdK+ff
         EQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7gKvcJabgKuUbvQyf6qVD7f9YQGD2U9hjlCz5FyenjE=;
        b=l3gdcwPU84rjHiVGcUn/MqfKQe/yjDLHvixMW7K9OLMxSzqHw5X5UiNJ7Q1fIv0Cf3
         o85VjR9CY8Qeu0K7D3jeFOfT88aheyqp5a+LYOk/7Q+iEJQrKwji/SbaREQy/DbtlNo6
         ZCdpzH4Q6+yxX3453CV2F/kD0p9IW10RX+uSjYfPABIfMY0uOgxfvJngxwO4rP8iHhkA
         fKmAFH82Uxv/DcIRArmHr66P7hCEz/4cLZBQUQC92SGK+/ozRSoIdHOAvztojjnA8txI
         OEqsTh9mkcDPzPO2ZhnNx7aytv0ZsVWb+990pgjELLDuGsBRXdG5wdLpMKzyhTcac80H
         YgwA==
X-Gm-Message-State: APjAAAUlOBjV1HSSMeyXuUVz7/vUKYM1948hkJVZzHATEp3jBmln648B
        B7WdoDBr7Cn7G6nNNsFMJyhs8h9j1Ddl2wfkQGWq0g==
X-Google-Smtp-Source: APXvYqyWSE7IQpvuMFy/pIaK7WPbXKuGXqON/op4MJWwDpM4SPonR2MQsrxZdzAgHnF5eZuqmlowswx974SBISxIilQ=
X-Received: by 2002:a2e:301a:: with SMTP id w26mr65927001ljw.76.1564653619372;
 Thu, 01 Aug 2019 03:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
 <CAE=NcrY7b8eTTovOszBhGhVbjfJAXoAYehiUJyPENGfwWoVcPw@mail.gmail.com>
 <CAFA6WYOEqe1a1DCyVYKA+oZaZ0n5hnjxdubstUnrwdUW1-4xHw@mail.gmail.com>
 <CAE=NcraDkm5cxE=ceq_9XkQz=NZ6KdVXkNUsdD4G2LrWz-bpDw@mail.gmail.com>
 <CAFA6WYMOXQbL5OeheFUFpTr8gte8XHHr-71-h8+qX0+R_sekDQ@mail.gmail.com> <CAE=Ncrae6pM+WBDu9eJ7Fw2Fkvf3_YqH5tj9Tt938D4RtWcdSQ@mail.gmail.com>
In-Reply-To: <CAE=Ncrae6pM+WBDu9eJ7Fw2Fkvf3_YqH5tj9Tt938D4RtWcdSQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 1 Aug 2019 15:30:07 +0530
Message-ID: <CAFA6WYOwcO5-cyaJf3tMMAdyVHJo=BzmCWtsjA3S8aj5g-GZxQ@mail.gmail.com>
Subject: Re: [RFC v2 0/6] Introduce TEE based Trusted Keys support
To:     Janne Karhunen <janne.karhunen@gmail.com>
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

On Thu, 1 Aug 2019 at 13:30, Janne Karhunen <janne.karhunen@gmail.com> wrote:
>
> On Thu, Aug 1, 2019 at 10:40 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> > > I chose the userspace plugin due to this, you can use userspace aids
> > > to provide any type of service. Use the crypto library you desire to
> > > do the magic you want.
> >
> > Here TEE isn't similar to a user-space crypto library. In our case TEE
> > is based on ARM TrustZone which only allows TEE communications to be
> > initiated from privileged mode. So why would you like to route
> > communications via user-mode (which is less secure) when we have
> > standardised TEE interface available in kernel?
>
> The physical access guards for reading/writing the involved critical
> memory are identical as far as I know? Layered security is generally a
> good thing, and the userspace pass actually adds a layer, so not sure
> which is really safer?
>

AFAIK, layered security is better in case we move from lower privilege
level to higher privilege level rather than in reverse order.

-Sumit

> In my case the rerouting was to done generalize it. Any type of trust
> source, anywhere.
>
>
> > > > Isn't actual purpose to have trusted keys is to protect user-space
> > > > from access to kernel keys in plain format? Doesn't user mode helper
> > > > defeat that purpose in one way or another?
> > >
> > > Not really. CPU is in the user mode while running the code, but the
> > > code or the secure keydata being is not available to the 'normal'
> > > userspace. It's like microkernel service/driver this way. The usermode
> > > driver is part of the kernel image and it runs on top of a invisible
> > > rootfs.
> >
> > Can you elaborate here with an example regarding how this user-mode
> > helper will securely communicate with a hardware based trust source
> > with other user-space processes denied access to that trust source?
>
> The other user mode processes will never see the device node to open.
> There is none in existence for them; it only exists in the ramfs based
> root for the user mode helper.
>
>
> --
> Janne
