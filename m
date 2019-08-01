Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30EB47D58E
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Aug 2019 08:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbfHAGg7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Aug 2019 02:36:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35249 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbfHAGg6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Aug 2019 02:36:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so68265353ljh.2;
        Wed, 31 Jul 2019 23:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X9ZQbHrGzFtjEODVBGVi3gOgXCwBSDCk0xPlVmAv39c=;
        b=Irrr23fMhTG6al2CUIKvRGL5QX0PhtRLcRnbsblPKgEqQOxD8SJoM0uIVm3vH8a07y
         sps88K+hpaaGuRLYTRBAE727L6SCNxZHl98YcWCGE2nZBlrKZCFqhQYnFQa3O46eY8lL
         /DxLFOpm2FTCNqNU9snTg9au+8PRn02r+vYkQ8uFHGAqYPis0WcrgzH4YS4+SDBfQEoV
         7J4/uuOHdv42lZlMfAfkuWhF1r6IfctmUnPGE8QearmzNB3FBL+pVJ7DCBccFWYyYHn4
         IiZQ1ElUjB3Z1LOP9E4MADCJzJeaPW8qtNE1bgA7zqga8L4CC95+lpKWT1r1gq4voAWE
         6ZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X9ZQbHrGzFtjEODVBGVi3gOgXCwBSDCk0xPlVmAv39c=;
        b=NpDDvPthk+qRlJgv2aSBvSwFoTO3c1qKXNcXYY2a/Rzt2TJ4I1jz6fmSE5Mjp8P0ka
         SXHSo4Kpq9FnPNsGHlNN3TpCzamab0TwyV9YOAZM64/TLO0wJnS8vgVteBVjXAKYOb79
         u+97/EVjZTXpY02Hg2nZLQ9QXuref1mzVVUqNpQlO2BUabyqH+5QKKiNVCKFQnN/fZOJ
         m94CE75ahEa6bxUJ5IRPu9T+GXlvnF9rHxZjO3K8gqmXzNQny9GyA6VK3QQViPs0UmB7
         PwKBTOQBRPiWPklaOq3V6GqKERTo4g/3zXer3Wd5873cuI/o+EaClUdKU6Weh5CPE4t8
         MepQ==
X-Gm-Message-State: APjAAAXPkYLGoxx6gr40BSrgGJqjVoBcEwth09DSpRZcfYol95v3h7PF
        A/nCj3wpuLFFcssUuaDe0ocvHGh5zns7eSFKSvM=
X-Google-Smtp-Source: APXvYqxL/s6TY+Lcm9PtMPnltGMxl9EapEj/9hC3l7HRYjwRx4X4cLUEHb7EUd4m82x93CeGKns2H6cCLt/hUSnHVmU=
X-Received: by 2002:a2e:b1c1:: with SMTP id e1mr31450663lja.228.1564641416029;
 Wed, 31 Jul 2019 23:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
 <CAFA6WYPJAzbPdcpBqioxjY=T8RLw-73B_hpzX4cGnwVvm5zpJw@mail.gmail.com>
 <CAE=Ncrb23q++z8R8UMbjDE2epEq4YVcNGzrRD31eH3JAooYejg@mail.gmail.com> <CAFA6WYOKcOzSwakHhgshZcebD8ZBMSi7xQdjWYFS79=Xc+odOg@mail.gmail.com>
In-Reply-To: <CAFA6WYOKcOzSwakHhgshZcebD8ZBMSi7xQdjWYFS79=Xc+odOg@mail.gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 1 Aug 2019 09:36:44 +0300
Message-ID: <CAE=NcrYz8bT9zDhS_ZcvY84fpeTDxZ-KhJKeQGGyf=o4pG2J-Q@mail.gmail.com>
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

On Wed, Jul 31, 2019 at 5:23 PM Sumit Garg <sumit.garg@linaro.org> wrote:

> > I guess my wording was wrong, tried to say that physical TEEs in the
> > wild vary massively hardware wise. Generalizing these things is rough.
> >
>
> There are already well defined GlobalPlatform Standards to generalize
> the TEE interface. One of them is GlobalPlatform TEE Client API [1]
> which provides the basis for this TEE interface.

I'm aware of it - I have implemented a large part of the GP TEE APIs
earlier (primarily the crypto functions). Does the TEE you work with
actually support GP properly? Can I take a look at the code?

Normally the TEE implementations are well-guarded secrets and the
state of the implementation is quite random. In many cases keeping
things secret is fine from my point of view, given that it is a RoT
after all. The secrecy is the core business here. So, this is why I
opted the userspace 'secret' route - no secrets in the kernel, but
it's fine for the userspace. Umh was a logical fit to implement it.


--
Janne
