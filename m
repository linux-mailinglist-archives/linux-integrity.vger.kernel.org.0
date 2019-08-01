Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 525BF7D573
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Aug 2019 08:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbfHAGVy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Aug 2019 02:21:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39843 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbfHAGVy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Aug 2019 02:21:54 -0400
Received: by mail-lf1-f68.google.com with SMTP id v85so49273523lfa.6;
        Wed, 31 Jul 2019 23:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1vSZqJMnvEYK79BuKh6WUgr+O0wW6TMjJ9YpHKa1USU=;
        b=Arm8SbO3zGrCc5avNA7dsMeg85DbeTjU5zzCj7quGtHPNxa8/SQT6F5BxoH/oW9lU+
         rxTr+oQxxUsihwCoaxsTIyiDxgny9BvFH1L8WxV3tlw2KRSZPI+I16EN+PzHL0wEaHUC
         +wk5CNLeGxCaTXsaXuQW46Zml1KG+s2Q/hXX165ScX10Rhvf74bOIcX4NlnjS54S8AHI
         xxbUlheuiKF7RwuNv+h83UPOZrSFZ33E+Xxk7rMCrOZA2taAypqDXjNgZlx09PmqGlUu
         hhWb44TjnRf0xQuebHwAMIC2EBjamD7JbUM+fNSQmxuS4VBghCU1+21vEVInMcUZd824
         MIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1vSZqJMnvEYK79BuKh6WUgr+O0wW6TMjJ9YpHKa1USU=;
        b=mbrCGxUODrxQXCwo2X2gWQS2vKP4+VyXUKTwc9WJEt7HFuu4Uhd2GYdX+LgUrUoHk0
         17u1HT54TVSXox3DW3o1dOkgzwpc6IJIXDabA8pXCDG6KFZw7ia6GxCC2PDZom29tGBC
         dWaTuFSxXH0E6VLrkqwHADahw2rFpXfB2WytsciYKdgJNWMvS7YKVTnweXX6ErccqzzY
         1ZuX2R8G3piYFqapH4UAbmqTNdhItcAjqfrtK4h+nR9Fws8xfBfqPXndt8m5Sx/Hjdn0
         i+uhgMynLT633kvHzy/WZbWN5XPWiAKgPcxN9EG+m21zu7GHJ+R2Uy4DbN5HvV948kVX
         oRcg==
X-Gm-Message-State: APjAAAWkKO1OChjVwrawXHg7oEB9/4FMlw93cFNPKNo9V0tZ3VWZbtvL
        K3YYvxC3bqQArpfQ8bfKj4nGtXTt3RTO++UldCI=
X-Google-Smtp-Source: APXvYqwHSeFpB9tSV0Ei5U+HuQh1iF1dV3lxekEtE3WsWY2xkt0Unm2jUg3lSom7xaUo+nfynVkJjq4uUMXG5qYU6Jk=
X-Received: by 2002:a19:641a:: with SMTP id y26mr58261160lfb.29.1564640511451;
 Wed, 31 Jul 2019 23:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
 <CAE=NcrY7b8eTTovOszBhGhVbjfJAXoAYehiUJyPENGfwWoVcPw@mail.gmail.com> <CAFA6WYOEqe1a1DCyVYKA+oZaZ0n5hnjxdubstUnrwdUW1-4xHw@mail.gmail.com>
In-Reply-To: <CAFA6WYOEqe1a1DCyVYKA+oZaZ0n5hnjxdubstUnrwdUW1-4xHw@mail.gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 1 Aug 2019 09:21:39 +0300
Message-ID: <CAE=NcraDkm5cxE=ceq_9XkQz=NZ6KdVXkNUsdD4G2LrWz-bpDw@mail.gmail.com>
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

On Wed, Jul 31, 2019 at 4:58 PM Sumit Garg <sumit.garg@linaro.org> wrote:

> > To clarify a bit further - my thought was to support any type of trust
> > source.
>
> That could be very well accomplished via Trusted Keys abstraction
> framework [1]. A trust source just need to implement following APIs:
>
> struct trusted_key_ops ts_trusted_key_ops = {
>        .migratable = 0, /* non-migratable */
>        .init = init_ts_trusted,
>        .seal = ts_key_seal,
>        .unseal = ts_key_unseal,
>        .get_random = ts_get_random,
>        .cleanup = cleanup_ts_trusted,
> };

Which is basically the same as implementing a new keytype in the
kernel; abstraction is not raised in any considerable manner this way?

I chose the userspace plugin due to this, you can use userspace aids
to provide any type of service. Use the crypto library you desire to
do the magic you want.


> > With the
> > user mode helper in between anyone can easily add their own thing in
> > there.
>
> Isn't actual purpose to have trusted keys is to protect user-space
> from access to kernel keys in plain format? Doesn't user mode helper
> defeat that purpose in one way or another?

Not really. CPU is in the user mode while running the code, but the
code or the secure keydata being is not available to the 'normal'
userspace. It's like microkernel service/driver this way. The usermode
driver is part of the kernel image and it runs on top of a invisible
rootfs.


--
Janne
