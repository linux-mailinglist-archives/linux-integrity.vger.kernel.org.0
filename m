Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBE529FE94
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Aug 2019 11:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfH1JgQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Aug 2019 05:36:16 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35512 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfH1JgQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Aug 2019 05:36:16 -0400
Received: by mail-yb1-f195.google.com with SMTP id c9so583037ybf.2;
        Wed, 28 Aug 2019 02:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m8H1ni9yUIvKX3ot84qs9UAKbQ5sv70F7CGKmm49qW4=;
        b=q3/C+voFtOOZNKoHGbnnO9Lg3fcxIGE+I+t73LnEHRvCavUUPEU4M8v09XScvVHHJ/
         ef4ZUdZ5B8yrQihlHBLcuYYIbJB8Vg05r8uOCN+HZTg4LKguyrltkFdPoEi1axbGEvEP
         0iaNoTsbzz/Kk/j4iq1P01lB5wi1il0lHo1pi9NrM9Y64Lbq1yWjFAMy9y09qG4PRb0L
         VUgYInjsBhqtNX9QPvPVkMhXm27U3ykIq3x3RfMB/oUmAF9WuxrZ84Qw7BDgq43k5jcZ
         HAeYs1jLgBsjddmJ/B81VMz9bCYJzE5DrRUlq8VR3WBzJPxvFOruPuaj70NUEjBfPqB3
         BUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m8H1ni9yUIvKX3ot84qs9UAKbQ5sv70F7CGKmm49qW4=;
        b=sGf1blZZ0RvrK365nWzw5GBGvItBF5N56zXSmOAw92ROSNG33x+7M2UFLQM18kshLt
         aDm93eKqCJdoh3Aeks4tp5AiE0RJ+dVfwKW1TBCMBSQ88q7t9xbSp5h5kYaEpfzRNhAl
         q1wrgmAzupKBaMsRMdh/NDXBgNjLnN+bfyfOywnYL6z6xUx40Dx9er33H1K+m0F5313t
         djD/QT739HUsBpBKQ0IhF9ffAMSOFaSgeXwkFeMo5e50uQXjBGAwYRz7iKC0AiUhFAjM
         bzxppKlJm838MywqCvXg8eldfY2fUlRnQSeJRJU5IBFkkDB4Yjn6iNNtxuSjP0g6nMyI
         h9hQ==
X-Gm-Message-State: APjAAAWGjikjzZtvg4n3hIj+BWPjAfPtksBCjU7DL5+BodxqELvBrp6J
        XFTV3qFEpM9Ug1MXHn8MRIi2hqnuehj2jQfqi/k=
X-Google-Smtp-Source: APXvYqzyAy1t7MyLmD3sjcO183YWsA3wpOmY8Nw7sOWOFmGweBbTSStv7843QVn7kK55nYWg6OxAl6W3a5KktRP/l9M=
X-Received: by 2002:a25:2f42:: with SMTP id v63mr2232165ybv.228.1566984975242;
 Wed, 28 Aug 2019 02:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190826081752.57258-1-kkamagui@gmail.com> <CACdnJutomLNthYDzEc0wFBcBHK5iqnk0p-hkAkp57zQZ38oGPA@mail.gmail.com>
 <CAHjaAcSFhQsDYL2iRwwhyvxh9mH4DhxZ__DNzhtk=iiZZ5JdbA@mail.gmail.com>
 <CACdnJutfR2X-5ksXw4PNUdyH2MJs_mExNCcYPp8NLcPW2EDrYQ@mail.gmail.com>
 <CAHjaAcSpU0eW5PLsEpxTkycwi+wNS67xeizb6_BMM_-qUZYAmg@mail.gmail.com> <20190827171106.owkvt6slwwg5ypyl@srcf.ucam.org>
In-Reply-To: <20190827171106.owkvt6slwwg5ypyl@srcf.ucam.org>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Wed, 28 Aug 2019 18:36:04 +0900
Message-ID: <CAHjaAcSu04J3WqT_vnSnaQuYpFQ+xiXXWxhcCeLQccEq6eQGcQ@mail.gmail.com>
Subject: Re: [PATCH] x86: tpm: Remove a busy bit of the NVS area for
 supporting AMD's fTPM
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

>
> On Wed, Aug 28, 2019 at 01:36:30AM +0900, Seunghun Han wrote:
>
> > I got your point. Is there any problem if some regions which don't
> > need to be handled in NVS area are saved and restored? If there is a
> > problem, how about adding code for ignoring the regions in NVS area to
> > the nvs.c file like Jarkko said? If we add the code, we can save and
> > restore NVS area without driver's interaction.
>
> The only thing that knows which regions should be skipped by the NVS
> driver is the hardware specific driver, so the TPM driver needs to ask
> the NVS driver to ignore that region and grant control to the TPM
> driver.
>
> --
> Matthew Garrett | mjg59@srcf.ucam.org

Thank you, Matthew and Jarkko.
It seems that the TPM driver needs to handle the specific case that
TPM regions are in the NVS. I would make a patch that removes TPM
regions from the ACPI NVS by requesting to the NVS driver soon.

Jarkko,
I would like to get some advice on it. What do you think about
removing TPM regions from the ACPI NVS in TPM CRB driver? If you don't
mind, I would make the patch about it.

Seunghun
