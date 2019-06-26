Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C681B56D49
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jun 2019 17:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfFZPGb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jun 2019 11:06:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38189 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfFZPGb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jun 2019 11:06:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id b11so1819832lfa.5
        for <linux-integrity@vger.kernel.org>; Wed, 26 Jun 2019 08:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3cH1Y4aBWEMFJQX38HW8JdfIOPoxC5RYjXfM83gmtWA=;
        b=bZTzfrcqAlDn8L0WGr6EwsII9Fr/WpGr0H/BGih7tOYPArjstLy1DTdO0DAP2DkPOL
         x5XoQ+BhuJa+9rhm6Pnciak2tnxpLGZjYNnugfk17mEdfNPLWvUyw/dzxK5LVAiAktml
         cmDnxNrT/vRHgpzQPAPqL4Sgp91QTjsXAQiNn2NAsIy4GoRqMQF4whEeOwODV1Q0bTCb
         +geArbGv2LhwoCxuzCzOA11KcCz+4Vyl7xzbxQH/dx3xRvRnJjrQIRCIQj7vne7OQio1
         oGTVKYno4yLCxzIgiCoY5tX1dCBSPXbklCGh+sE54/TnC/FgvjqvgeSRWRRzSaEAFQt8
         JqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3cH1Y4aBWEMFJQX38HW8JdfIOPoxC5RYjXfM83gmtWA=;
        b=amMj4vDo1NDf7rieLBGANitHN/UFhCP0xXvCS7Wd3HeTjC0Pll4KAv/FHxR2d7shnl
         QZFKuV/to/rxstkTu263XCfy6I42A4EXYAtx+kLCyUg765GJEpZV185lf9F++qBQRhiN
         YRqBqvNTCkh3NTkX3SxqYFS1mDmBy+ImP813OECGxzec5nC2fxrrgu8d+3NosDI33ICY
         bQUCSItc/do4n8HanFZMuPmuzSTm5KNB6f3EIF6UuJryLLY6ayvUCJM1I12TPKw9f3Kq
         ZI8tN0oJ4m+35UOwJZdjj5n5Hxl+F6PUi0wcVj5buimq5FlvmbPGqhHc1PMbQJJXde2q
         nEQw==
X-Gm-Message-State: APjAAAUVCrGzm0JiWbfnZ5VBCcEncOaXex9pk/XDPMasCY2+upaSObK+
        KgxYWW9X5MKVfGqgdBDaWa8cbJ8BIuO1EeXoNE4=
X-Google-Smtp-Source: APXvYqw2zKHjeRGt/eIcSoBMfadCOSoYapAIhoDcyfuEXfzye5fx4H46XuYT7/Nx1syHSHO8YQNXJXabBlJSlNE0lmk=
X-Received: by 2002:a19:8cc:: with SMTP id 195mr3010341lfi.150.1561561588879;
 Wed, 26 Jun 2019 08:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190623090027.11852-1-vt@altlinux.org> <1561387352.4340.20.camel@linux.ibm.com>
 <20190624161638.xz6ebfvxzilh2gew@altlinux.org> <1561403393.4340.58.camel@linux.ibm.com>
 <20190624192349.gdp2xbe5c6etaw6v@altlinux.org> <1561405647.4340.63.camel@linux.ibm.com>
 <20190624201156.xrd6lyhrbnpbo2uz@altlinux.org> <1561431368.4340.106.camel@linux.ibm.com>
 <CACE9dm9yO+h8wELkze051n-HN=hPgb=BZdJx-hTra6YUgfWtSA@mail.gmail.com> <1561561373.4101.96.camel@linux.ibm.com>
In-Reply-To: <1561561373.4101.96.camel@linux.ibm.com>
From:   Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date:   Wed, 26 Jun 2019 18:07:54 +0300
Message-ID: <CACE9dm8AN2x==Hpdy5X3ENU=Z_XAT2Vbty1DXH-o2t=xuqSZuw@mail.gmail.com>
Subject: Re: [PATCH v7 00/11] ima-evm-utils: Convert v2 signatures from RSA to
 EVP_PKEY API
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 26, 2019 at 6:03 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Wed, 2019-06-26 at 17:42 +0300, Dmitry Kasatkin wrote:
> > On Tue, Jun 25, 2019 at 5:56 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >
> > > On Mon, 2019-06-24 at 23:11 +0300, Vitaly Chikunov wrote:
> > > > Mimi,
> > > >
> > > > On Mon, Jun 24, 2019 at 03:47:27PM -0400, Mimi Zohar wrote:
> > > > > On Mon, 2019-06-24 at 22:23 +0300, Vitaly Chikunov wrote:
> > > > > >
> > > > > > > > With and without this change, the sha family is working properly, but
> > > > > > > > with this patch set, I'm now seeing "sign_hash_v2: signing failed:
> > > > > > > > (invalid digest)" for gost/streebog.  Previously it worked.
> > > > > >
> > > > > > If it worked before this is strange. It should not. What patchset
> > > > > > version it was?
> > > > >
> > > > > No, I'm saying that I built both openssl and the gost engine a while
> > > > > ago.  There's been some gost engine updates since then, which are
> > > > > dependent on a newer version of openssl.  So I'll need to rebuild both
> > > > > openssl and the gost engine in order to re-test.
> > > >
> > > > Hm. I don't see a difference in signing code.
> > > >
> > > > Only the difference is there was no `log_err("sign_hash_v2: signing
> > > > failed: (%s)\n", ...)` about singing failure, because, I thought, the
> > > > caller would report it anyway, because of `return -1`.
> > >
> > > Thanks, Vitaly, for all your help.  It's now working properly.
> > >
> > > Mimi
> > >
> >
> > I tested various generation and verification options and also backward
> > and forward compatibility.
> > Everything was fine for me....
>
> Thanks!  Did you review the code as well?  Can I take this as a
> Reviewed-by or an Acked?
>
> Mimi
>

Hello,

Yes, I reviewed as well.
Looks fine for me...

I have one minor spotted from diff, I can reply in other email...
It can be updated later..

You can put "Acked"

Dmitry

-- 
Thanks,
Dmitry
