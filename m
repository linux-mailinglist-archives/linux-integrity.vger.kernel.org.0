Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37DC4D8F1D
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Oct 2019 13:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390970AbfJPLQd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Oct 2019 07:16:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41867 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390947AbfJPLQd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Oct 2019 07:16:33 -0400
Received: by mail-lf1-f65.google.com with SMTP id r2so17100041lfn.8;
        Wed, 16 Oct 2019 04:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxVNF9emcO9vOzZ5Qy5dhVZsoYfmUatJ5whvaHZ26tU=;
        b=c7TFCwPEtNzGt1V0t4kWXCiAXCN1SJiuzGxoyRVZuHYGJ9bA5iimWG2Rv/WOHzx9tQ
         0c5fuV90QpWy0gWsi97R3hhepPTY3KPW6mkkl8PrOTW/TOMRKad5bCnkWgJDDsu3bFRq
         nknIEmWqKKp9i48gTwBzl6URFhks1NDyJM84oMpcA7CPid2RMjgOEA7fDap5nVusZzUA
         8VP5We8KOnFuV7XptNybusmv9XJmZ+fKYORmkbTAIwjF+d0ehj16N2RGdmGwzjABMX8w
         7YLEc+uLjG1sddE2SGXMcejGPXgvsqiMNlWl/zCzPnbhoi9vOJZnkhDlSIVkMkl44aG5
         iuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxVNF9emcO9vOzZ5Qy5dhVZsoYfmUatJ5whvaHZ26tU=;
        b=oszuGkJEPcCn4wwLdXk4TltBCmLSxJsjVCEnALTD3VQ7J5uaU7n4zsIjzBLVhbo7eo
         ihzfv9Chg3fcgJwnSfrQF++PNwbXDnxosSxbJqUNPFAHqEiOWAbLoQvLGE2bkeMf+Mrz
         6/2tBNf6S7qSlzf3pjSHldUxy8g3rxrNKZsV6KDGKg18GXWI81oBcEc8lOlUWZV3YZJS
         qAenKAyk9xt5MkK+9D979jMyt9fLNnwzyZ1Z/zHOv4sY5SQQ+u6Kh6XCfMWQ9O25kyF7
         8sihlzbHnbQPYIp6wmKveUrymkVZkgt3HR9nhAea1gwkXm1pDGk6Y9NnfrZDz9pDGja5
         hjpQ==
X-Gm-Message-State: APjAAAVnwbgJTzIvZxEq15e2rB/4TL/AHvFhL64muOrFVYJgtI8ndldz
        XLeOYhBHG9YbJZn6B0luD4o2E6WHKaMm07CJN9s=
X-Google-Smtp-Source: APXvYqwRjFDkFx/43M2eXk4OoUppcwOlsECBDKNqWNiS1H42r6Ekg79etDPeqGnuibPhM2Qnm1SuI+RP+gp2lW1DJag=
X-Received: by 2002:a05:6512:30d:: with SMTP id t13mr17409610lfp.150.1571224591326;
 Wed, 16 Oct 2019 04:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191015124702.633-1-jarkko.sakkinen@linux.intel.com>
 <CAE=NcraH_6nDe4Ax9axsbsrMf+EggCQFibY3dpNNgGm7NYTtJQ@mail.gmail.com> <20191016104110.GB10184@linux.intel.com>
In-Reply-To: <20191016104110.GB10184@linux.intel.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 16 Oct 2019 14:16:20 +0300
Message-ID: <CAE=Ncrb_7wQsv0_EvZWe5-WA2UU_GywgfnVo7hC-FDTY6bzpFQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: Salt tpm_get_random() result with get_random_bytes()
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        David Safford <david.safford@ge.com>,
        Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 16, 2019 at 1:41 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:

> > > get_random_bytes().  TPM could have a bug (making results predicatable),
> > > backdoor or even an inteposer in the bus. Salting gives protections
> > > against these concerns.
> >
> > The current issue in the randomness from my point of view is that
> > encrypted filesystems, ima etc in common deployments require high
> > quality entropy just few seconds after the system has powered on for
> > the first time. It is likely that people want to keep their keys
> > device specific, so the keys need to be generated on the first boot
> > before any of the filesystems mount.
>
> This patch does not have the described issue.

My understanding was that you wanted to make the tpm_get_random() an
alternative to get_random_bytes(), and one reason why one might want
to do this is to work around the issues in get_random_bytes() in early
init as it may not be properly seeded. But sure, if you this wasn't
among the problems being solved then forget it.


--
Janne
