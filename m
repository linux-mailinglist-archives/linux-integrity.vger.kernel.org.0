Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C596C30B
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2019 00:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfGQWRR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 18:17:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42043 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfGQWRO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 18:17:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so11820168pgb.9
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2019 15:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=ZErEVvJ8JYXA3iwdIxlVCJMYGvo02bLUG34j47nMryY=;
        b=mcIblSSWf5ikEHP4UXr6+aGbHZ5mkPRydF0lr7zooN55M3vESs8uRUSSEpDlP7iK8U
         B59fdDgrNmpranJaP1PUCiwe/DOBSjKgXnclVGjM4ZK2dyRnuTnuxaI7KD2Fyf9s20mi
         6vy1W2HOQv81gXfyJKbN/M9dAyW77DYZx6UpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=ZErEVvJ8JYXA3iwdIxlVCJMYGvo02bLUG34j47nMryY=;
        b=UFX/QUqOU32+TtwRjVqhVIxiEXS9bpwKJxXFzDST0gNE7p+pc+Pf1XNBvMYUuo1jDS
         9nAfSZaBj0YsKE8ZwtmpSdMd0z59fP9faLqFUHwKWdmaaB26vnYOWOLoJNb2MZi778Je
         iSxy+oOrG5p3kzy3xlRpJ7LLCEnslefXBa8iTp2EKH0306FBl8KcTIyScbByrorlKFUE
         I7eUImGx9C/DJW/jyvMjQMwvom9LUMKzQCTXLLXyJxw30DDqy6qpbyNyiqWInMTA0/xX
         fAf62atm+nC9O92TEANcxvd5xac6RHFxM8F/HcQbl5UWMtbqAB495+AXwo8X6SoxHLAz
         Ew5w==
X-Gm-Message-State: APjAAAWJDimvCJ4IeDMWLMn4uufvXBYis+EyfYIEPdx5CjX+C/wGXXoC
        Nycqq8c7eSFha03gbOCPI4cSHA==
X-Google-Smtp-Source: APXvYqw7c35PhAMwlt994MttKuE5saXN+0D4ZP4wuF6qoM7MrH3ycgcxlhbEujoUx2xHbLj0H/dvXQ==
X-Received: by 2002:a17:90a:20a2:: with SMTP id f31mr46455908pjg.90.1563401833612;
        Wed, 17 Jul 2019 15:17:13 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r75sm27395801pfc.18.2019.07.17.15.17.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 15:17:12 -0700 (PDT)
Message-ID: <5d2f9e68.1c69fb81.6e01c.27fe@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5d2f955d.1c69fb81.35877.7018@mx.google.com>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-6-swboyd@chromium.org> <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com> <5d2f7daf.1c69fb81.c0b13.c3d4@mx.google.com> <5d2f955d.1c69fb81.35877.7018@mx.google.com>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 17 Jul 2019 15:17:12 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Stephen Boyd (2019-07-17 14:38:36)
> @@ -131,6 +303,8 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *=
data, u32 addr, u16 len,
> =20
>  exit:
>         spi_bus_unlock(phy->spi_device->master);
> +       phy->last_access =3D jiffies;
> +       mutex_lock(&phy->time_track_mutex);

This should be mutex_unlock().

