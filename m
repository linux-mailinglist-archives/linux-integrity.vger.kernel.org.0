Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98BDEB39AB
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 13:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfIPLqK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 07:46:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36474 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfIPLqK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 07:46:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so5794886ljj.3;
        Mon, 16 Sep 2019 04:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9nRUSFMMMTBahdL0zPsPWqmNCPwIReETeD7CWvMjV44=;
        b=Nc6aTwkuTLYeviVZiPgrSANSpK9oSoASeyMnRU9wlmjBEyx8j2k5WjNthGj3sODHUH
         3x3nYr7OiAgNfhU4AiF9tjp1AHwFWyYFx3K64PyEsEXuc4BtxFhhewxCagCxMshMwkK3
         6i91P2EdKMspueFMWdfOsQlZQoBXujNSSzBwNLDVdD4ESklhqFs2H7BOBKQcsoY5gR2U
         2sJM6yVOUocsv/taUDwfwZPn+GvfEWtfvTZPPw20nG5S84cPsgOWJSIhoY1BlsGXNMC1
         8TrzG9x/amuAMgLyrj3iruOjXz0yXhO4lqADmzSnlDL01ou0jbBrniO0x+q0lzSaKa+v
         CAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9nRUSFMMMTBahdL0zPsPWqmNCPwIReETeD7CWvMjV44=;
        b=Ys2gx52BSqDrmLIiU6FzJ4s/YPql+GBvuxSTkE0h5RQO9YHi8L5gEOEb+vQ4xIUuyP
         OGNqREeYZG/9NRaWVTEd/lCXKu6o5biktulknccWQi0WzMu5M3JLHnE+rb6S3XfEYeVV
         vAbIU2XZT5ZANjRndO7j07M3Yk8cFs6HVjP5ejkCaug2/qJ+XDX8z8BwjkyeR5UF746+
         2Ya9J6Pnd70Jd72KA8yZfCcHIIoJZhrjfcCovBwJ+kU7QQQthe1uAJbSwnzLj+n8tr86
         A+8Bd+YAbzHqaBI6D/qE/mBFdoKInLm41x+8lAq/2rH7QMtqgJXoZ1rLBg6cewE2Fu5N
         8vfA==
X-Gm-Message-State: APjAAAVGvxGs74lswO7KEOuL9v6LrgnQLW/CYes2reXz6VNrfb16dtwt
        dQjNIibhTB7AygFlFgn91qoP5jczSSSmoUm9SMCIPA==
X-Google-Smtp-Source: APXvYqwsTh4KNDke38S9xtq8ckfHNlWDqiFIq+7xmbYbRI7/TBp6Cx+kO6rrDFD7rnp4zT1LzLB/Do1Fjhn/a104aA0=
X-Received: by 2002:a2e:9c99:: with SMTP id x25mr37293703lji.9.1568634368063;
 Mon, 16 Sep 2019 04:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190902094540.12786-1-janne.karhunen@gmail.com>
 <20190909213938.GA105935@gmail.com> <CAE=NcraXOhGcPHh3cPxfaNjFXtPyDdSFa9hSrUSPfpFUmsxyMA@mail.gmail.com>
 <20190915202433.GC1704@sol.localdomain>
In-Reply-To: <20190915202433.GC1704@sol.localdomain>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Mon, 16 Sep 2019 14:45:56 +0300
Message-ID: <CAE=NcrbaJD4CaUvg1tmNSSKjkG-EizNM7GUaztA0=fiUCo03Cg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ima: keep the integrity state of open files up to date
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>, linux-mm@kvack.org,
        viro@zeniv.linux.org.uk,
        Konsta Karsisto <konsta.karsisto@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Sep 15, 2019 at 11:24 PM Eric Biggers <ebiggers@kernel.org> wrote:

> > > This still doesn't make it crash-safe.  So why is it okay?
> >
> > If Android is the load, this makes it crash safe 99% of the time and
> > that is considerably better than 0% of the time.
> >
>
> Who will use it if it isn't 100% safe?

I suppose anyone using mutable data with IMA appraise should, unless
they have a redundant power supply and a kernel that never crashes. In
a way this is like asking if the ima-appraise should be there for
mutable data at all. All this is doing is that it improves the crash
recovery reliability without taking anything away.

Anyway, I think I'm getting along with my understanding of the page
writeback slowly and the journal support will eventually be there at
least as an add-on patch for those that want to use it and really need
the last 0.n% reliability. Note that even without that patch you can
build ima-appraise based systems that are 99.999% reliable just by
having the patch we're discussing here. Without it you would be orders
of magnitude worse off. All we are doing is that we give it a fairly
good chance to recover instead of giving up without even trying.

That said, I'm not sure the 100% crash recovery is ever guaranteed in
any Linux system. We just have to do what we can, no?


--
Janne
