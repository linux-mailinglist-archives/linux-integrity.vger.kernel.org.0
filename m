Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE89B375A
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 11:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbfIPJnt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 05:43:49 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39640 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbfIPJns (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 05:43:48 -0400
Received: by mail-yb1-f194.google.com with SMTP id o80so9639874ybc.6;
        Mon, 16 Sep 2019 02:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yjNunVcFcb1AtMRe3JD5r9e1bCJQZPifOYDK4iB7laQ=;
        b=LYPv16VLQwZa7Bei4G3tjlpPS6x1Jw1XJLzRZr+qI62qk3OAtJl/49pqjKISLXCMkW
         /5hkxaj9gS/N4RtlHrh7+xo+UmCtBhoXSrCdIAOZ/zcpQU6bnkETmhHa0pRbl1XpUk2I
         gKhf8sdHseMWCnmwEBzPzPidfveK22nJQNKokdTWxzch0JzPcOmG901heP0xZduiVN6W
         j8NqPyU7PLAe7JK7oBDD/OPwuJgakSR/Kk+JC3VG+vhOhGZWw4QK3VNyvEQrSFYDCC5v
         at4SFm67c7C5hlJMcBO7RGXXRYSsmfyMoKAxhRdkTx9tkd5qb64tCPJ4euNcCsMYyB/4
         jicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yjNunVcFcb1AtMRe3JD5r9e1bCJQZPifOYDK4iB7laQ=;
        b=VOWQLyDwfIr+qdIz3Mt+MYYBkJjlJ8EmhDvZT06Kfg1BTNBcViZGV56N6cLADfRPkh
         qScckhc8xZu0w+gPo5ppAaB1r8qxPcpRr4VnQD5fhPKr9+Q7m8AAitUZPIFF1EADSza7
         C7ekO7nehxNR8EMNNtPYN5twwwBYOR+rmzA83tpJV/AhDAnPLuEnWfPuHpCQXl+ms3s6
         5xSuqkFIVFVO/886NEFFwr/NaPxcDiAI0ht0MpODR/vSESGsApRJ6pMDYWjeSlSmyoMY
         8T+rhjvczWnSdXzFoG0beVpOhMW/6+mMfAApPBeF17v+5hKjZq99ba3w6BuAxRT7mLLQ
         scTA==
X-Gm-Message-State: APjAAAUMRfXcw5RfejIFQQ9Y3AjqC/yy7zJ5hTAhUfW7vyPQ1qWBPDnD
        BgncRRS3Jype5uY0cihSyXm1gsCh68iFUSvaNyI=
X-Google-Smtp-Source: APXvYqwQDZFclRdgOtaQowhwK27Fc2pfXt3l3C4LUVD7DeLpAv1lK3aEV8FvVRMisUkyNWnCVqlNWBY49goAWr2jCh4=
X-Received: by 2002:a25:40cc:: with SMTP id n195mr8705599yba.341.1568627027653;
 Mon, 16 Sep 2019 02:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHjaAcStAfarJoPG0tbSY0BVcp0-7Lvah2FdpmC_eCFfxaSVFw@mail.gmail.com>
 <20190913140006.GA29755@linux.intel.com> <20190913140218.GB29755@linux.intel.com>
 <CAHjaAcSBCDnn7CwXfxYcfmRnAF2jdud1Sjwng_jtd8ASVS28Sg@mail.gmail.com> <20190916090741.GA31747@linux.intel.com>
In-Reply-To: <20190916090741.GA31747@linux.intel.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Mon, 16 Sep 2019 18:43:36 +0900
Message-ID: <CAHjaAcSixHporRbU0Y-h-NKRQR2pHqti2qnEtowc2oZkiPOORA@mail.gmail.com>
Subject: Re: [PATCH v2] Fix fTPM on AMD Zen+ CPUs
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Vanya Lazeev <ivan.lazeev@gmail.com>, arnd@arndb.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> Eessentially what you want to do is to detach and backup the original
> NVS resources and put them back to the list with insert_resource() when
> tpm_crb is removed. At least I think this is what should be done but you
> should CC your patch also to the ACPI list for feedback.
>
> /Jarkko

Yes, you are right. But, what I really want to do is requesting
command/response buffer regions from NVS driver and releasing them. To
detach and backup the original NVS resources with insert_resource() or
remove_resource() are not needed maybe.

I have some idea about it, so I have sent an email to you. Would you
check the email and give comments? The link is here,
https://lkml.org/lkml/2019/9/16/112 .

Seunghun
