Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3F77D6D4
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Aug 2019 10:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfHAIAF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Aug 2019 04:00:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37351 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbfHAIAF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Aug 2019 04:00:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id z28so14180137ljn.4;
        Thu, 01 Aug 2019 01:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VAiKQtrdWdpAymEw2Fi6xVY10VrsZzJSh6lsPenXn5c=;
        b=KyWodxvzOSUl5vMHnbnrwzIAAyi2FLqjzsrJG4CDOo0xubx8uDbAyXqHvMjXb2EZKR
         3OTkmSgzUW5s4OFzZOJtJzkxL2Vw9tpTOsPuHNmJL10tEdjzf6+u9Z5Dm7Ybjzo2Fsnq
         upL41HGVkP0Apu7kDsQGa73HXRgsYJ4eGQN4LQaCrmmTCyKiMdEQRG2WVK4rAboEaFkL
         GR3a+bW/b/pBTN2NDcQHelOqJxfXR1ACeiixyEc+ACqJNOoNIwLeHNt7Gkj296UvulJw
         dWF9aAtR4dZnfFwdJPh3B21ex1Yyr1oWQ/ZqlU8QV6eNaXvHxEZcelG2uu1GWLoxBxgQ
         663w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VAiKQtrdWdpAymEw2Fi6xVY10VrsZzJSh6lsPenXn5c=;
        b=GvMWCV/U9YOcLE4xcfMJjDR2SgtqeDGi7BJRHME7AqL7mr1ixuAmutOym0m4hpP9gI
         9KJJiLh0a33oWkNvIlGJye3VJr7FaBpYMltsPF9ZuwiNyVThVc7NF9sCkmpaeL+VW8S6
         JzHBjf3FlyEYnvmCpoytOs3XjGzzCn0mZtlv4yiOnhnRm9vts48kC8gObXYDu9acLLD6
         pbfAi5YymPeSa+la3G9jxEYjwOe/rxKK2TfAp80/A1tUUKudy7iAtQiRqmlNFesL/EmR
         ZOAG9VHLTE4JURgLRx0s0RPI0IYEwJ7AaY7xTuQbEpn6wiGR9N33TA0caDofY0MQk0Gu
         psaA==
X-Gm-Message-State: APjAAAV4H70kcD1p9bp7ucO1MXqQOHlQUUBk8sp+jH9za1IPL0ZpS3Zt
        FL3iuRp9YJZkNG9rqQicEvdIFpDW58lVPftCJTA=
X-Google-Smtp-Source: APXvYqx/gMgcGF2V7ylKamWcGjf6XGcn5JGjdm2r9vJ2Njp1NLJnu7wpmlveYBCUT/NrzJhe5JXapFqEUKI15zJ5ClQ=
X-Received: by 2002:a2e:5d92:: with SMTP id v18mr67333062lje.9.1564646402586;
 Thu, 01 Aug 2019 01:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
 <CAE=NcrY7b8eTTovOszBhGhVbjfJAXoAYehiUJyPENGfwWoVcPw@mail.gmail.com>
 <CAFA6WYOEqe1a1DCyVYKA+oZaZ0n5hnjxdubstUnrwdUW1-4xHw@mail.gmail.com>
 <CAE=NcraDkm5cxE=ceq_9XkQz=NZ6KdVXkNUsdD4G2LrWz-bpDw@mail.gmail.com> <CAFA6WYMOXQbL5OeheFUFpTr8gte8XHHr-71-h8+qX0+R_sekDQ@mail.gmail.com>
In-Reply-To: <CAFA6WYMOXQbL5OeheFUFpTr8gte8XHHr-71-h8+qX0+R_sekDQ@mail.gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 1 Aug 2019 10:59:51 +0300
Message-ID: <CAE=Ncrae6pM+WBDu9eJ7Fw2Fkvf3_YqH5tj9Tt938D4RtWcdSQ@mail.gmail.com>
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

On Thu, Aug 1, 2019 at 10:40 AM Sumit Garg <sumit.garg@linaro.org> wrote:

> > I chose the userspace plugin due to this, you can use userspace aids
> > to provide any type of service. Use the crypto library you desire to
> > do the magic you want.
>
> Here TEE isn't similar to a user-space crypto library. In our case TEE
> is based on ARM TrustZone which only allows TEE communications to be
> initiated from privileged mode. So why would you like to route
> communications via user-mode (which is less secure) when we have
> standardised TEE interface available in kernel?

The physical access guards for reading/writing the involved critical
memory are identical as far as I know? Layered security is generally a
good thing, and the userspace pass actually adds a layer, so not sure
which is really safer?

In my case the rerouting was to done generalize it. Any type of trust
source, anywhere.


> > > Isn't actual purpose to have trusted keys is to protect user-space
> > > from access to kernel keys in plain format? Doesn't user mode helper
> > > defeat that purpose in one way or another?
> >
> > Not really. CPU is in the user mode while running the code, but the
> > code or the secure keydata being is not available to the 'normal'
> > userspace. It's like microkernel service/driver this way. The usermode
> > driver is part of the kernel image and it runs on top of a invisible
> > rootfs.
>
> Can you elaborate here with an example regarding how this user-mode
> helper will securely communicate with a hardware based trust source
> with other user-space processes denied access to that trust source?

The other user mode processes will never see the device node to open.
There is none in existence for them; it only exists in the ramfs based
root for the user mode helper.


--
Janne
