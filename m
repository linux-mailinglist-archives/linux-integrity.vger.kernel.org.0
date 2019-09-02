Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9B45A5DDC
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 00:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfIBWmR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Sep 2019 18:42:17 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43483 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfIBWmQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Sep 2019 18:42:16 -0400
Received: by mail-yw1-f65.google.com with SMTP id n205so5141208ywb.10;
        Mon, 02 Sep 2019 15:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5VinCzEEH/Uk+FyLdBPhobtfKHbcOpqI1/OiKIP+nEo=;
        b=jHjjt3ospKYQOsutK4f7sotSxd5PNU+Zhtq6gx3h/W9EkvCpG9SvLzH97WkKLaE062
         q1y9gHsmmATqN6PU4PJBeCyECIJD9Wcp8AWuRxg5iXHeHav6+iWl/x1n6Pp07alSinLF
         KwwvvfuKbLCxYEhIg9aNeOyrgG9fMxgefSy7A9bPW+yHu7/WRsZ20xr1bFP7ZNDDx1Pf
         KH5jbaYfeN/FQVW270QBJxod5Ip4DIRGhGXPqWCK1QU/ZMuAqkGYr1KwYRQyaYouMb5K
         Q/OEcmdC9yC3WqSdLjr8EJbInqd+bUYt2inTIL5XDtUa+roDzm0GI0RqONjVIyBeyNC/
         1XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5VinCzEEH/Uk+FyLdBPhobtfKHbcOpqI1/OiKIP+nEo=;
        b=SEGVF5lYXYvk95UzoHO1Gw6gmlJNX5X4a0DZ/uQ47Q2xRYu97bVDKGbVktS/mawfqX
         ZvqPhsk0kiPYW512hJNfrpGAGCzvk5Vie3Py6seeJ15264m7bZmB4yhiflarpP//f6Wv
         jH/AnODydSDvNdHqkycZd9xb9dVUefsRKF+rO73TVhkDVi0dVrYpVs4k/XlrJHlL5BY7
         XODQJTYsfElLH+pLoriltIoNkZjKhMLMJMnVNaNpcR15af4LluocUQ+PY/UApzg5B72K
         nC5oG8kg+UlfsStL05G8Fw2uEDSvh43mEUWtBQCJhv5g+JY5BtY8f6JVRVQHMT4m0T/P
         uQtw==
X-Gm-Message-State: APjAAAXyYhFlAwEu62IVvFaAeHUrMZGZzRuIvkKknAtcNZ+tqZjMYQR4
        j2Eze4xtIG9W6J9RGg25d6Fipgfu9cu2z6p38PsJG/OB59Y=
X-Google-Smtp-Source: APXvYqxyKiI05WXxKGwCJSWYmOBkGoTck/rBw0K9RFvGYovmNWY79iFdVOkNY7PlCRWOoUZw/Ns42dntHyRQJday77c=
X-Received: by 2002:a0d:df13:: with SMTP id i19mr22823943ywe.264.1567464135563;
 Mon, 02 Sep 2019 15:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190830095639.4562-1-kkamagui@gmail.com> <20190830095639.4562-3-kkamagui@gmail.com>
 <20190830124334.GA10004@ziepe.ca> <CAHjaAcQ0MrPCZUit7s0Rmqpwpp0w5jiYjNUNEEm2yc1AejZ3ng@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CC59@ALPMBAPA12.e2k.ad.ge.com>
 <CAHjaAcQu3jOSj0QV3u4GSgnhpkTmJTMqckY_cnuzeTY-HNUWcA@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CD06@ALPMBAPA12.e2k.ad.ge.com> <20190902135348.3pndbtbi6hpgjpjn@linux.intel.com>
In-Reply-To: <20190902135348.3pndbtbi6hpgjpjn@linux.intel.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Tue, 3 Sep 2019 07:42:03 +0900
Message-ID: <CAHjaAcR4H6CnHxzR3NHLpMCgdafVHYuKCp4qxUd8b+K0SN34BQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping mechanism for
 supporting AMD's fTPM
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "Safford, David (GE Global Research, US)" <david.safford@ge.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

>
> On Fri, Aug 30, 2019 at 05:58:39PM +0000, Safford, David (GE Global Research, US) wrote:
> > > Thank you for your advice. We also discussed earlier and concluded that
> > > checking and raw remapping are enough to work around this. The link is
> > > here, https://lkml.org/lkml/2019/8/29/962 .
> >
> > I don't see Matthew Garrett's agreement on that thread.
>
> No one has agreed on anything.
>
> /Jarkko

Jarkko,
you gave me good advice related to the NVS area and mapping like below.

"A function that gets region and then checks if NVS driver has matching
 one and returns true/false based on that should be good enough. Then
you raw ioremap() in the TPM driver."

So, I made a patch on your advice and test it. According to my test
result, command and response buffers were saved and restored while
hibernation. And, there was no side-effect because they were just
buffers and hibernation didn't affect the control area of TPM CRB
driver. So, I think that saving and restoring buffers during sleep is
no problem. I also think your advice and solution are clear and good
to work around AMD's fTPM. I will attach my detailed test result soon.

Jarkko,
I have a question. Do you think this patch is not enough to handle
AMD's fTPM problem? If so, would you tell me about it? I will change
my patch.

Seunghun
