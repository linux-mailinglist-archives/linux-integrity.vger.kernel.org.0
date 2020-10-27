Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF7129C95D
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Oct 2020 21:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830630AbgJ0UBl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Oct 2020 16:01:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33073 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1830629AbgJ0UBk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Oct 2020 16:01:40 -0400
Received: by mail-ed1-f65.google.com with SMTP id v4so141581edi.0
        for <linux-integrity@vger.kernel.org>; Tue, 27 Oct 2020 13:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=uFi34OV4Jke17cvhjF6nf7DkFmdg5nIpdrhUjA1qsaA=;
        b=GtTVHeYt1Dx8jncbJfJsDLGx4EpjCZWJp+2ILlI9FZ2+yU69sI9CLsNS2ga5tyU2tD
         EnrkGOctu8ia0BxWejTBUz0SM9Qe/FkcD/zwyvHS+v6SySUV6NYUhwdpJ72ed5eoCIAd
         jV7XmEPGgG6jQnmydAXQJQk/Jm9bbmbjLCLHzJ4VhNCexq1W+sP0M91GuLZfJIYJ6DEx
         r2UZ5dRxPiUaDN161bkYljiZ/Ecj/Gqzgq04BNnjk3hlGkNgv+eDjTLeZ0f8LHLhxSvo
         J9XqcS7mb0+M9VEXy5fBc3K0pknJKprl60xIDVmAcgAoEtmUIXHZfb56Ei4AThUlBNPv
         q8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=uFi34OV4Jke17cvhjF6nf7DkFmdg5nIpdrhUjA1qsaA=;
        b=c2rAwHDE5iEyFoFJYbyK/mVpvZbkFqphrJoXYQNN1ghBwX1Or63JSlR/gYCtW45evA
         DScKhN2jsFNZkNhVQ+5ZBHh3vBQfmMjkgT7Q8dH/4MD/Fle4Y4EAR/V6wj6ULHALVmUX
         YDxkAuqqgD0gyjrSKe0seNRbjL+svEl4h9zikY/MoKmWGCeoOLUsGmXM5Pja1WrM0RUK
         X4EF7D9YgtaIniY3DoA7jaAeRmUiNC3j0k0G/pXiTdJrrzLNvOxQPkUHDKGQPglNL8se
         w5s1v+qxv5MT4mERLa3cpjHU2KOGq2RyQyoxbV+G4Uqhlo7Xgzd3LTBS6MBfdBGrrptu
         L53Q==
X-Gm-Message-State: AOAM532SNg00P4o5CKy0nz9CY35CDXT6OiH9nGub9BqUvdVFxwIze0D9
        1s3uTjjR11E60SIfFDKrlZQqVtfm1EglLQ==
X-Google-Smtp-Source: ABdhPJwc6FI8yXyWrjmk68bmJbN6blNI6lzuzc101Kd7kaW+56hwYzGWUwkovFdzxgSurbrAchGIeg==
X-Received: by 2002:aa7:c694:: with SMTP id n20mr4201831edq.160.1603828897842;
        Tue, 27 Oct 2020 13:01:37 -0700 (PDT)
Received: from x230 ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id q9sm1615904ejr.115.2020.10.27.13.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 13:01:37 -0700 (PDT)
Date:   Tue, 27 Oct 2020 21:01:35 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Wartan Hachaturow <wart@debian.org>,
        linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH ima-evm-utils] boot_aggregate.test: Skip if CONFIG_IMA
 not enabled
Message-ID: <20201027200135.GB7513@x230>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20201019200803.35255-1-petr.vorel@gmail.com>
 <e274a823ca408f33c11ea03878442189e62d9f9b.camel@linux.ibm.com>
 <20201020180231.GA14580@dell5510>
 <26b4d298f9a71a796793f2ce730a95ebec442f29.camel@linux.ibm.com>
 <d0d1ad6c-5569-486c-3131-9b4845bd6495@rosalinux.ru>
 <6d213e5decd0bf1290ae37e2da353aae504f2581.camel@linux.ibm.com>
 <bd321cc1-260c-0ed2-2143-dac2b7489903@rosalinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd321cc1-260c-0ed2-2143-dac2b7489903@rosalinux.ru>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

...
> > Mikhail, my mistake.  Thank you for the correction!   Testing the
> > libressl changes should be a lot easier now.  Please remember to
> > include a distro travis.yml example.

> What do you mean? Do you mean adding testing of building ima-evm-utils against LibreSSL?
Yes, I understand Mimi wants this.

> Which environment is used there and which ones are available? There are not many dsitros where LibreSSL is pre-packaged [1], in many of them it is not updated often enough.
Look at the supported distros in travis/ in next or next-testing branch.
Could you use some bleeding edge distro (Tumbleweed or Fedora?)
You could handl LibreSSL vs. openSSL with variable, similarly like IBM TSS and
Intel TSS are handled (with $TSS variable).

> I would choose either ROSA where I myself maintain LibreSSL and ima-evm-utils or Arch Linux, is at least Arch Linux available in CI/CD environment?
> Won't we have to deal with often breakages of other parts of the rolling Arch Linux?

> Also, I can just build LibreSSL from source in any available distro, e.g. Ubuntu, but the pipeline will take a lot more time.
Please use distro package. Not only it's faster (as you noted), but it also
covers more users (IMHO most of the people use distro package, not a git version).

> How do we better deal with it?

Kind regards,
Petr

> [1] https://repology.org/project/libressl/versions
