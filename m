Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADBC410349
	for <lists+linux-integrity@lfdr.de>; Wed,  1 May 2019 01:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfD3XYq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Apr 2019 19:24:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36968 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfD3XYq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Apr 2019 19:24:46 -0400
Received: by mail-io1-f68.google.com with SMTP id a23so13753920iot.4
        for <linux-integrity@vger.kernel.org>; Tue, 30 Apr 2019 16:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NOYR2KhGhZxyg8lu/GHuX/TFhKe+D8ltW1/3GJ59UFc=;
        b=WbRfaE6UGT3VK/yxlTLxooQrKvs+QGkNF9jGn5kjVq3kxzbzCm3mZHAh+LlUWlJzpp
         7YtEqKUaIAl4iJagxsqSo0qddRTZAYCoUVdsArvNuzb4mAz93lDqFYQ/HVWYiRPuk/+P
         +/wyaDExYTJo2Cpq/8KQgMChUR4Grx/I9k746VJPEy91ci7yMZjn5J3c1d0pKtl3V19x
         6CjBVdTtz43Nx9Twv6I8P1692mDgqYS+Rt68inGULKFLY4BrH3riRVowNHyEqtnrWCw4
         6BM0Q8ahoNqXQEZMFqwwCXo57dY9/jrSKFjYyYgny4ni4QAAI0x12HKS+AP0cVMIvSbQ
         QRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOYR2KhGhZxyg8lu/GHuX/TFhKe+D8ltW1/3GJ59UFc=;
        b=trqrqxT0SSzPJChsh0yWaU1AsGq7uVbyiSpQAU0XWmObDpiNiPg1SzJROhK3gKJbot
         Pu2/bI0EMQuc2CvkeF17r8+Vn0MBpgZX+J+BE8Y+REKKfwG2eMDgTZS3/d1KHXOijkkx
         aZP/RkIM5I/s9a1B3aODmL88RMhZSNX8haDnw6pGw+Sywek7G7dgkyLavQAIP37myn0Z
         Xlm6reRev9apfyBnAe0hHW+OnDlXjcRU27qbPT0HzRUpVglx5zclQf06hfb6e5kb6Em/
         5OHUni9hH/lVpUSfY4fRCl4vHqoWWeqFZhCtHwCiFxJ1rsGdZR2wbuyqoBXkReuaPV2L
         3vQw==
X-Gm-Message-State: APjAAAWNEJHQVsKvfnAypVGQdGUKGF2dAJOq7+4vxVUWRg1Qpf5zm7la
        PnclfAgsazKFrSMAAY5zRqneiq3mTt9nPK0xSAxoWQ==
X-Google-Smtp-Source: APXvYqwiByU5lsNFstnrJDn/z+lsOfVffLD1j2ViGyf97eSUA3WHGXbAxyNduI8Ob3W0cZnBN0qx3TJYoPHpfQCK4lk=
X-Received: by 2002:a6b:e20e:: with SMTP id z14mr1884246ioc.169.1556666685452;
 Tue, 30 Apr 2019 16:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <f9ad2e46-e458-6c78-76da-b85db4601ee3@linux.microsoft.com>
 <CACdnJuuhiQQ8Uq1A_qfidCLVPVQ_3Ty_Kqg+tQPDx2z3P0Yp9w@mail.gmail.com>
 <6373c67f-ea2f-ae1d-0343-4bb774f1d52f@linux.microsoft.com>
 <CACdnJusXEq=7LXB=Ry0zH4CTRkQLHPC+5DnP07yXi0TNPeCYTw@mail.gmail.com>
 <b4f9cc9d-bded-fb0a-1d53-40fa1460ddec@linux.microsoft.com>
 <CACdnJuuK=BqaHLDFU0+zXk539gobvaJFUpHuNL7nYZcpw8E0ZA@mail.gmail.com>
 <93b9433f-cc99-c1fe-f7d1-bc8d26fd4dc1@linux.microsoft.com>
 <CACdnJuvpe6_O8jPb-2pBPqgAZ7J1NbuPvbOO4kDd4d80k8p8OA@mail.gmail.com> <0dc4e73c-00a8-5023-7065-3b21483a8a14@linux.microsoft.com>
In-Reply-To: <0dc4e73c-00a8-5023-7065-3b21483a8a14@linux.microsoft.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 30 Apr 2019 16:24:34 -0700
Message-ID: <CACdnJusCP5F4B=ybV0rfgrETfFAGE_MDeS44xEJVPKJ1s8rX=g@mail.gmail.com>
Subject: Re: linux-tpmdd self signed kernel failing to boot with secreboot on
To:     Jordan Hand <jorhand@linux.microsoft.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 30, 2019 at 4:00 PM Jordan Hand <jorhand@linux.microsoft.com> wrote:

> No. The only print messages I get are from efi_printk. And they don't
> show up like normal kernel logs do during boot. The purple grub screen
> hangs and the efi_printk messages just print over the top of it.
>
> Although now I'm wondering if the efi_printk messages I added after
> efi_exit_boot_services just aren't showing up because I've exited boot
> services and can no longer call that function (seems reasonable).

Ah, yes, any attempt to efi_printk() after efi_exit_boot_services() is
likely to end badly! In that case can you try the patch in
https://lore.kernel.org/linux-integrity/CACdnJuvYAfFboej4e5jQ=iwhb-5Pi7BgSKEWGqJ0q=uarCoOfQ@mail.gmail.com/T/#m4326297b6aa5ec27948325eb22736871b8aca998
?
