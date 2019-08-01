Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56AC27D7A2
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Aug 2019 10:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfHAIaU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Aug 2019 04:30:20 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46008 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfHAIaU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Aug 2019 04:30:20 -0400
Received: by mail-lf1-f65.google.com with SMTP id u10so10820542lfm.12;
        Thu, 01 Aug 2019 01:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2xNohy2xyMAt9HM3Gyk3aetZhs8G9eF7ELJFgFiK0/I=;
        b=KVeh8Jw9S5Hs+wIxrPmvLbiA/a8qd2ZozSyly4TxKurfCOo1wsw0V1V4FfYAeJ2wAl
         hX+8KRVyClJNg+3FptaphJmcdmM9LnzOh6gagbOFy1eMrZjqDl8bcVFvxVo1dAiR9p+b
         FgdFqaoPZgECEcYJFHKHAoCypPwq4VSG353KdX7BgFGul9ORNUmXLocQaAQdLdRYnRab
         T20nnn0f6BhIpOqtJKrlqaa9f6Yn6/vlQQ1nLKTFluF8kJjAcp5eNSoiPczaPKAQJHFy
         DDP/HFLbIHCTMQOK6z+FkUHrlVi24L40YmEl1myxFuqnS8aWTlzma/wECZhp/dCoKJv3
         W0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2xNohy2xyMAt9HM3Gyk3aetZhs8G9eF7ELJFgFiK0/I=;
        b=LzNOOLJ8i1HHyeTpxE2+GpVdssv8bCiSKiOTnQAdQlI8miOya3BBc4LIBfvHtJGC7r
         ALQRVHHiY8H8dDNkFQ7AeYC9QqEAz42yH7zN05PYFoI32Yw5dlf8lhG2ectZ5Cgf1b/K
         RNP7jdLBOkBBhalOvOneQhubnWbg+XyLUWRFgWGphRltCQLE6+KCq4LLSRlxJo2MoKxK
         j05d1rSCt3hCq+HVXKbThoOpk3VcpPCDnHMNX9tt7QayBBO2ZsZ45iimK08J8mHzp6us
         Mf1qyeUWVuGK4lXxyGk+sMipfaysxbV38mWNuTYZX40/fdWec54Nd1Y7CnkjCxMYcmmi
         nQiA==
X-Gm-Message-State: APjAAAV6Rp+/Wkaudm7wMdKKATfevRsTpz0ZWkmjSDZ00A7YoDAjpx7q
        x56J4fXo+pcpyh//iIf3XYAYG7QlIK1fYBBP4v4=
X-Google-Smtp-Source: APXvYqzzD88SDt0GVEYWnLJkJRlwD14+HIfeihD4WoOdeKaL/6vYosJryMtEFIiIAgKt+K60XVbK4UMpvkES4vMcWVE=
X-Received: by 2002:a19:f806:: with SMTP id a6mr47249319lff.102.1564648217496;
 Thu, 01 Aug 2019 01:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
 <CAFA6WYPJAzbPdcpBqioxjY=T8RLw-73B_hpzX4cGnwVvm5zpJw@mail.gmail.com>
 <CAE=Ncrb23q++z8R8UMbjDE2epEq4YVcNGzrRD31eH3JAooYejg@mail.gmail.com>
 <CAFA6WYOKcOzSwakHhgshZcebD8ZBMSi7xQdjWYFS79=Xc+odOg@mail.gmail.com>
 <CAE=NcrYz8bT9zDhS_ZcvY84fpeTDxZ-KhJKeQGGyf=o4pG2J-Q@mail.gmail.com>
 <19d9be198619e951750dedeb4d0a7f372083b42c.camel@pengutronix.de>
 <CAE=NcraqD9FNM0Gk9UGhPGi3heVzZrAKGc1gNZxoe1OnDaQ=pA@mail.gmail.com> <CAFA6WYPt4q+jaJbaoauXKr2qKgBHvtQ663s4t=W3nuPJPe2xpw@mail.gmail.com>
In-Reply-To: <CAFA6WYPt4q+jaJbaoauXKr2qKgBHvtQ663s4t=W3nuPJPe2xpw@mail.gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 1 Aug 2019 11:30:05 +0300
Message-ID: <CAE=NcrbujsM8wYJXq+s=o5Vy1xY1b0uKYBGvp6UP5ex70HrB2Q@mail.gmail.com>
Subject: Re: [Tee-dev] [RFC v2 0/6] Introduce TEE based Trusted Keys support
To:     Sumit Garg <sumit.garg@linaro.org>
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

On Thu, Aug 1, 2019 at 10:58 AM Sumit Garg <sumit.garg@linaro.org> wrote:

> > Anyway, just my .02c. I guess having any new support in the kernel for
> > new trust sources is good and improvement from the current state. I
> > can certainly make my stuff work with your setup as well, what ever
> > people think is the best.
>
> Yes your implementation can very well fit under trusted keys
> abstraction framework without creating a new keytype: "ext-trusted".

The fundamental problem with the 'standardized kernel tee' still
exists - it will never be generic in real life. Getting all this in
the kernel will solve your problem and sell this particular product,
but it is quite unlikely to help that many users. If the security is
truly important to you, would you really trust any of this code to
someone else? In this day and age, I really doubt many do. Everyone
does their own thing, so this is why I really see all that as a
userspace problem.


--
Janne
