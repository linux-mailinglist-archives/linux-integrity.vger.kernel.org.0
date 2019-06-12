Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C541742A9A
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jun 2019 17:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfFLPQH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jun 2019 11:16:07 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36638 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbfFLPQH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jun 2019 11:16:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id q26so12457906lfc.3
        for <linux-integrity@vger.kernel.org>; Wed, 12 Jun 2019 08:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YMusDYqalyv6pSFgNwPF4uKK+xbujszHazgInidAJjY=;
        b=Q90p5Iy5nY+5qK8J0YqslmnGkaZ2iwBDq4pyJAywiMsz2C3QwATrz7NQrLc5pGxWhS
         qus4894GAdS3fYkeWcUtJiCGmFclvQlmqvBAzIx+HHBrC0KroATQwxpCOcjPMKYRPCZf
         K2jMa0u60l4MkW07IjX6rS2RVjct7qxBYBZC2CaF873OtUXqQhaetEk5mswWLhCRs5JJ
         ujnL0lGBnbqS4xjB3gpsUi+6OqFkcz/r+ha4XlxnGYzWod02CJV1PEjVasAZba7uvVc9
         FZ92PVNUZRJkayLdyozPUvL5qOOtxrklkXQeU0NNI2ezIOoROxFVujhTZmMk6Y0cx0AR
         GB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YMusDYqalyv6pSFgNwPF4uKK+xbujszHazgInidAJjY=;
        b=Ecc0SCLQj5t38CAQT8VDSzyJAeQ3aUwJVN+eiBQIlC//X0BAVds3TFwmnjEivz6Q6u
         4D8vdFWb5n0IOuT1AEzq82HBJ8IXN81LzlNArwLfl/J9LkdJIRYMftWBCAI3CsvlN4dq
         d6Kg7Xukfb10hAXB9/6vcqlHEUBk5wdnsTkbPYhGZp6xBSwwN9t99v4EqIMHXIFsGP7g
         YoHguSbLxq5Izf9qfD7/okAuExoQ75w1U0RKYXyJHk7FTtKnKDnqEPZqrposvzl/OUuW
         ClvgeMZPlfzF6ve57W9/sZCGGAHpL3igTRaUVqPpzGFxj7bTB3Mv/XdGyE20tMtbLBfN
         W+Ug==
X-Gm-Message-State: APjAAAVTXCY3nnsam0/vWECLNdoelDwagZ1dd4izVLaBjpOjfhBG2WPh
        OhHx9qWKA8IMWquD0WVfDnwZPjKA2v9dXsVCTsOg6J4=
X-Google-Smtp-Source: APXvYqyN6xVD96Jl8RDKNEI6HwNcqB1yanl1Pp+ZZ6oaxLPKOeAYdSl7QnbgMOG4UnWkxhi0P2GplkRuBKmiRCHX95M=
X-Received: by 2002:a19:7716:: with SMTP id s22mr24175955lfc.64.1560352565001;
 Wed, 12 Jun 2019 08:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190612074456.2504-1-janne.karhunen@gmail.com> <1560346093.4578.18.camel@linux.ibm.com>
In-Reply-To: <1560346093.4578.18.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Jun 2019 11:15:54 -0400
Message-ID: <CAHC9VhRbO-ua-0Y=17zg97+oopXaj_eYBRzadrgSrG=twSjYRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] LSM: switch to blocking policy update notifiers
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Janne Karhunen <janne.karhunen@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 12, 2019 at 9:28 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> Hi Paul,

/me waves

> On Wed, 2019-06-12 at 10:44 +0300, Janne Karhunen wrote:
> > Atomic policy updaters are not very useful as they cannot
> > usually perform the policy updates on their own. Since it
> > seems that there is no strict need for the atomicity,
> > switch to the blocking variant. While doing so, rename
> > the functions accordingly.
> >
> > Changelog v2
> > - Rebase to 'next-queued-testing'
> >
> > Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
> > Acked-by: Paul Moore <paul@paul-moore.com>
>
> The patches need to be upstreamed together.  Do you have any problems
> with my upstreaming them via linux-integrity?

Nope, I've been operating under the assumption that you would be
taking both patches via the linux-integrity tree.

-- 
paul moore
www.paul-moore.com
