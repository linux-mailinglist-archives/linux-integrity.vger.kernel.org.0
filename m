Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E81C99BEE
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Aug 2019 19:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391022AbfHVR3b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Aug 2019 13:29:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46744 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390632AbfHVR3a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Aug 2019 13:29:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id q139so4382735pfc.13
        for <linux-integrity@vger.kernel.org>; Thu, 22 Aug 2019 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=ukVWNvitz/UHIvotHd8untO0xzPRYvc+1WN6pDOo+Js=;
        b=l6U7Lyf0pAC/hPrTqdj669gt+CJ2CBM5J0Opg6CFM4CUAfgfTtm4KpO9FqRIop85Qz
         og1xd2wgn2De8IsjsrP8/RZGxBgAftfBiGPbR1jyBC+m6ItdST7JEQuPdc27GZqj+TUy
         FVB72DFh2flIuP8MmLebo1Fe4pP6NVI95/AvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=ukVWNvitz/UHIvotHd8untO0xzPRYvc+1WN6pDOo+Js=;
        b=VhlHcOQD96OkwnyY/Qb/8xCc3OzH+qWs6nLcyPnpgPN9jgFaNqBLfzxSKoaj/QLTLi
         A9G8vVUpRZCHMMR0S1SA+PxLDvlWxO5gYL2ezwzA3H9zvHqWXFOiDUhcWx2DYxt6Py+H
         KgTdknOMkMZrT32fS9PS4116UmUU4ZdKutHd08r96sqJlllSG6M6AQFKenhTjVAN/ehJ
         E9jv2xZ/PFE2vGaMh0s8nGlvzTccBSl2otf44fQFd9M5a7K0CXeo60xVcuxRK06n9IZP
         FIu0htjLzSvXfbseHgX4HDuRUgS5d2wSYACZtvElbXKXfjBYDqTr3wThjY/ZongZkNUo
         1b8w==
X-Gm-Message-State: APjAAAVDV1mLhP9OVdJKN7AHobjpAP/eo12K3bkn3cnM3v7iMtZ4TjjB
        3gYaOvfKXou82i5K+56T1xlABg==
X-Google-Smtp-Source: APXvYqz4lxbTsv5Z2JO/gKEg6i2DpoNEniiFZCAuMi/Tl3YoY+PSd8B4B3xWz6iKO9e1ZGHdDvWg5A==
X-Received: by 2002:a17:90a:380a:: with SMTP id w10mr798893pjb.138.1566494969205;
        Thu, 22 Aug 2019 10:29:29 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b6sm23644299pgq.26.2019.08.22.10.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 10:29:28 -0700 (PDT)
Message-ID: <5d5ed0f8.1c69fb81.46245.daf8@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190821175846.ewcrpam44fdm27ya@linux.intel.com>
References: <20190812223622.73297-1-swboyd@chromium.org> <20190812223622.73297-5-swboyd@chromium.org> <20190819164005.evg35d2hcuslbnrj@linux.intel.com> <5d5ad7f0.1c69fb81.ebfc2.7e1d@mx.google.com> <20190821175846.ewcrpam44fdm27ya@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH v4 4/6] tpm: tpm_tis_spi: Export functionality to other drivers
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 22 Aug 2019 10:29:27 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Jarkko Sakkinen (2019-08-21 10:58:46)
> On Mon, Aug 19, 2019 at 10:10:08AM -0700, Stephen Boyd wrote:
> > Quoting Jarkko Sakkinen (2019-08-19 09:40:05)
> > >=20
> > > Instead there should be a single tpm_tis_spi driver that dynamically
> > > either TCG or CR50. I rather take some extra bytes in the LKM than
> > > the added complexity.
> > >=20
> >=20
> > Ok. I had that patch originally[1]. Do you want me to resend that patch
> > and start review over from there?
> >=20
> > [1] https://lkml.kernel.org/r/5d2f955d.1c69fb81.35877.7018@mx.google.com
>=20
> What if:
>=20
> 1. You mostly use this solution but have it as a separate source module
>    only.
> 2. Use TPM_IS_CR50 only once to bind the callbacks.
>=20

Ok I think I understand. Take the callback approach from these patches
and combine that with the TPM_IS_CR50 changes I made in [1]. I'll try it
out and resend.

