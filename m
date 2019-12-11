Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D30A011BAFB
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 19:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbfLKSGG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 13:06:06 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45650 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730621AbfLKSGF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 13:06:05 -0500
Received: by mail-yb1-f195.google.com with SMTP id i3so9353945ybe.12
        for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2019 10:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mzph4oRYSdP4XB6lnmsVX28t3uDJtwjo66piREwlnZo=;
        b=CJ3seZm3TNcFL0JuYlD82O0DXLlJhLI2L0gi5h5SiNm2+s8CUp6Q8oweDq3/j38gpI
         8tF1VvFdOXPaLMnJlwyE0+6HFdWAWF3tnAGlg7ZHd/VKihXM1V08GEOVE30822XMdn3I
         dbFmsuJVyT64fcZSYlUTIXoNE3Huf8Nv9z5HDdOerv35oorKROPYxJ+V3Q1miJ1+bUCK
         xDSHV6xMMTNN9n4Yt8cm5Ci7Dz+BgSTPbiECkALqzUHeRtihEJGe57bCcsf5nIeATGo8
         7S4ssremZfvXcWA3rmNmKy6q00iTjk02pBPOBq3meSfS8dDy5el9GO388Xt/a0c6macK
         Ab1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mzph4oRYSdP4XB6lnmsVX28t3uDJtwjo66piREwlnZo=;
        b=oE1ODQEir1zSuYFmJg22trxFWlZLWmZwHOSJQha3xIrMg/PU1oA3RPcKeRNEcoVA07
         Uo4F1zWKJwUqBGa+SWwRZ4b19XZv71Bi52RtWbVQuQIa55pkTOBY49/QLax9ijGZmOb3
         hYZoYTy6MoGJB4HLwe45C78xFP5uhX603j17eTufvmy7jvd+AB/py39S0aaekeEmRifu
         guvvqb1ehw3c17GFhbAMG2ozFgF9qTAW2Ammy7iRmZGP4VXpDiXvM2poz38e8XoyC7AO
         DgTBodMqlqeKmuCCbqHoAdNhl1FJeUkDcubsuOmH0BFeLwGmgNyT0aaMBeMT34yRXFbq
         SyWA==
X-Gm-Message-State: APjAAAV0Ta5Wbz+ADbn/C13IhuqLr9d2HGbQOOwFPYukRskW5VKeWqFk
        y+lyM/kSopKSCL73Qicp8UxLwPwe4Y+08ew4tS9w5g==
X-Google-Smtp-Source: APXvYqyO2/s0U2KFrlOdyOXWx12vh5Q2gWo9cY+d2QONSuipAFzpcXSOZnRUQukVA1QPy8HGFOxXm4YZ6Tzhcq5W7Bg=
X-Received: by 2002:a25:5008:: with SMTP id e8mr940654ybb.277.1576087564293;
 Wed, 11 Dec 2019 10:06:04 -0800 (PST)
MIME-Version: 1.0
References: <20191210210735.9077-1-sashal@kernel.org> <20191210210735.9077-238-sashal@kernel.org>
 <CABXOdTdO16V4AtO1t=BwXW2=HAtT6CYoSddmrn5T2qZP9hs0eQ@mail.gmail.com> <20191211175651.GK4516@linux.intel.com>
In-Reply-To: <20191211175651.GK4516@linux.intel.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 11 Dec 2019 10:05:52 -0800
Message-ID: <CABXOdTcsnAVaPo-492tVPtjOYMbNtu2Zvz4GwSBGcDEHAMGw5Q@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.4 277/350] tpm: Add a flag to indicate TPM power
 is managed by firmware
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "# v4 . 10+" <stable@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 11, 2019 at 9:57 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Dec 10, 2019 at 01:32:15PM -0800, Guenter Roeck wrote:
> > On Tue, Dec 10, 2019 at 1:12 PM Sasha Levin <sashal@kernel.org> wrote:
> > >
> > > From: Stephen Boyd <swboyd@chromium.org>
> > >
> > > [ Upstream commit 2e2ee5a2db06c4b81315514b01d06fe5644342e9 ]
> > >
> > > On some platforms, the TPM power is managed by firmware and therefore we
> > > don't need to stop the TPM on suspend when going to a light version of
> > > suspend such as S0ix ("freeze" suspend state). Add a chip flag,
> > > TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED, to indicate this so that certain
> > > platforms can probe for the usage of this light suspend and avoid
> > > touching the TPM state across suspend/resume.
> > >
> >
> > Are the patches needed to support CR50 (which need this patch) going
> > to be applied to v5.4.y as well ? If not, what is the purpose of
> > applying this patch to v5.4.y ?
> >
> > Thanks,
> > Guenter
>
> Thanks Guenter. I think not.
>
Thought so. In that case this patch should be dropped.

Guenter
