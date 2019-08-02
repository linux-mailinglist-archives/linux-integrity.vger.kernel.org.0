Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 678E8802CC
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2019 00:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392465AbfHBWcu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Aug 2019 18:32:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37882 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbfHBWct (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Aug 2019 18:32:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so36697348pfa.4
        for <linux-integrity@vger.kernel.org>; Fri, 02 Aug 2019 15:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=n5198bNj6xPak5lp58GNW9TiROyPem4hWkPcBo68qJw=;
        b=fJUKQPS4pUns/qKXB+E5BbeFgPkGidQpfEH8g6hM69aPN76Y1i67uQjOOeHi7lrYPo
         d3WKO/R9GPfN1KmGOxeAUoqQ55H5FFnoARVKVbO1GFDznbpI+vtlz706kJeP2LPv/jFa
         weroVvlRGLXE51CXD9p4jLERwtuQBpgfNSiOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=n5198bNj6xPak5lp58GNW9TiROyPem4hWkPcBo68qJw=;
        b=D7jlRV9C18KvQ/jvJv53SFNbX8XxMrJiR1y2cUyX9BTNGDzFURp5w/szJVf8UXLvkN
         ZkXMl2m/DmL00QDDmImvpsQ752GHSb4I1/5AOrMrg++swHrj8ZtoitFzlwK0Z2RDege1
         gKO9xxw9exLcpm0K82aCmVkq0cyGn66N8/mReS7533K3bo9SbOjf06MT+eYratmTpn0R
         FGF+10nXCLL9G7AVQYdMkR8PEno9v64ZdrYfmhJUOEanOSkDg0R6odFICGD5PsH67mGA
         QerduPbWJLXLuOsdCDyyxpWhxQWeroG9eJ9T9/hOmOywq6loITSjDoc+UJG6aQlNxJWE
         JtHQ==
X-Gm-Message-State: APjAAAUkwxHHdc+Ae0kOZICKIBmn1cmGyyHu9B7zL7c70V7qmN/0pkLn
        VzMfWjP/gs61fcFiVBBFCffAvQ==
X-Google-Smtp-Source: APXvYqwfzXrcyiQxegqrN4/Tyx7c3hgH+H9yHvJhJCR5t6RjCTviiais+rAQt8xp6KJPksScapQpRQ==
X-Received: by 2002:a17:90a:bf0e:: with SMTP id c14mr6096070pjs.55.1564785169042;
        Fri, 02 Aug 2019 15:32:49 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 4sm88158926pfc.92.2019.08.02.15.32.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 15:32:48 -0700 (PDT)
Message-ID: <5d44ba10.1c69fb81.a5654.3c8a@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190802204318.5aktcn7xnvzcwvqj@linux.intel.com>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-6-swboyd@chromium.org> <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com> <5d2f7daf.1c69fb81.c0b13.c3d4@mx.google.com> <ef7195c5-4475-3cb1-6ded-e16d885d1a55@infineon.com> <20190802204318.5aktcn7xnvzcwvqj@linux.intel.com>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
User-Agent: alot/0.8.1
Date:   Fri, 02 Aug 2019 15:32:47 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Jarkko Sakkinen (2019-08-02 13:43:18)
> On Thu, Jul 18, 2019 at 06:47:14PM +0200, Alexander Steffen wrote:
> > On 17.07.2019 21:57, Stephen Boyd wrote:
> > > Quoting Alexander Steffen (2019-07-17 05:00:06)
> > > > On 17.07.2019 00:45, Stephen Boyd wrote:
> > > > > From: Andrey Pronin <apronin@chromium.org>
> > > > >=20
> > > > > +static unsigned short rng_quality =3D 1022;
> > > > > +module_param(rng_quality, ushort, 0644);
> > > > > +MODULE_PARM_DESC(rng_quality,
> > > > > +              "Estimation of true entropy, in bits per 1024 bits=
.");
> > > >=20
> > > > What is the purpose of this parameter? None of the other TPM drivers
> > > > have it.
> > >=20
> > > I think the idea is to let users override the quality if they decide
> > > that they don't want to use the default value specified in the driver.
> >=20
> > But isn't this something that applies to all TPMs, not only cr50? So
> > shouldn't this parameter be added to one of the global modules (tpm?
> > tpm_tis_core?) instead? Or do all low-level drivers (tpm_tis, tpm_tis_s=
pi,
> > ...) need this parameter to provide a consistent interface for the user?
>=20
> This definitely something that is out of context of the patch set and
> thus must be removed from the patch set.

Ok. I've dropped this part of the patch.

