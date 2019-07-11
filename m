Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACCE466044
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2019 21:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfGKTze (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jul 2019 15:55:34 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44354 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfGKTzd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jul 2019 15:55:33 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so15195232iob.11
        for <linux-integrity@vger.kernel.org>; Thu, 11 Jul 2019 12:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKEGvB7hbPfo85nCRcTIzY9GkrcRv222RzSOPFab/us=;
        b=QSFcdsCwzkkOtVTYGSJYNE6+HBuA3J1EbnAKN2dFJngEjaIMob6GJDSNuJ/GesoNxR
         5dswstzk1JkVPKkVWmoqvsIUODWvMjgcPYH1MCRPpOLAnmuu+A/eCr0svcIL8ES1+ovy
         WN3fyp89Zmgvy2pJg4/RFbtwItAgfHMqg1G1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKEGvB7hbPfo85nCRcTIzY9GkrcRv222RzSOPFab/us=;
        b=oOKsfEzmWABMIczhW6nfzs9PMZveniIJFAYOVA1jRVTMpUMcESYnVEs7EjfJh9W0Fq
         DdgvpJo6dgX4Fln9b51jSt2P2IPPIs8wte/4BNAIL7OuoDJB7qwYQpFDE3SLDTWJH7uI
         LkYSTwVnubrYF3CPUS0BveSgYjyIisoKNCL64jNV7LdTV1wYmQ0KRmFYTWCTAqXrrlOo
         S1hmierZOrj4XnHJK+ZbnCe7Hak1YTbfaOpb9qBpO845tFuvKEhqk+E/iKp/mRnJB4ES
         qLoe1/zWo2cgND+uwt6PRfjzb8NlKtd9qpQLo/NwARkeeyRW4RJTJocW+H9EG1k3OU/f
         MGRw==
X-Gm-Message-State: APjAAAWz4y5VLGrtxSsQ4EOK6xvm2kBSjc2eaKIwAQKLQTz7vMf/xF/K
        L47OO2PYVQtC9JFtE0alHGMXpn0QLE0=
X-Google-Smtp-Source: APXvYqySt1xCPPMhrENI/nP4vyQXUTE9chJbm+itkY/cYR6QRdOACXagTwyiVKE7dABXWnlrgVeGRg==
X-Received: by 2002:a02:7a5c:: with SMTP id z28mr6688125jad.40.1562874932892;
        Thu, 11 Jul 2019 12:55:32 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id s15sm5475501ioe.88.2019.07.11.12.55.32
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 12:55:32 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id h6so15242021iom.7
        for <linux-integrity@vger.kernel.org>; Thu, 11 Jul 2019 12:55:32 -0700 (PDT)
X-Received: by 2002:a6b:5103:: with SMTP id f3mr2268109iob.142.1562874931799;
 Thu, 11 Jul 2019 12:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190711162919.23813-1-dianders@chromium.org> <20190711163915.GD25807@ziepe.ca>
 <20190711183533.lypj2gwffwheq3qu@linux.intel.com> <20190711194313.3w6gkbayq7yifvgg@linux.intel.com>
In-Reply-To: <20190711194313.3w6gkbayq7yifvgg@linux.intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 11 Jul 2019 12:55:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vja80tuLkojoCbrE=vfqvD8EMnzgKiQ1SGcM-2jMGZUw@mail.gmail.com>
Message-ID: <CAD=FV=Vja80tuLkojoCbrE=vfqvD8EMnzgKiQ1SGcM-2jMGZUw@mail.gmail.com>
Subject: Re: [PATCH] tpm: Fix TPM 1.2 Shutdown sequence to prevent future TPM operations
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, "# 4.0+" <stable@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Huewe <peterhuewe@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, Andrey Pronin <apronin@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On Thu, Jul 11, 2019 at 12:43 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Jul 11, 2019 at 09:35:33PM +0300, Jarkko Sakkinen wrote:
> > > Careful with this, you can't backport this to any kernels that don't
> > > have the sysfs ops locking changes or they will crash in sysfs code.
> >
> > Oops, I was way too fast! Thanks Jason.
>
> Hmm... hold on a second.
>
> How would the crash realize? I mean this is at the point when user space
> should not be active. Secondly, why the crash would not realize with
> TPM2? The only thing the fix is doing is to do the same thing with TPM1
> essentially.

I will continue to remind that I'm pretty TPM-clueless (mostly I just
took someone else's patch and posted it), but I will note that people
on the Chrome OS team seemed concerned by the sysfs locking too.
After seeing Jason's message this morning I dug a little bit and found
<https://crbug.com/819265>

-Doug
