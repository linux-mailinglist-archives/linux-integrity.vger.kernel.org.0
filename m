Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C24B3654
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 10:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfIPISr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 04:18:47 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36230 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfIPISr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 04:18:47 -0400
Received: by mail-yw1-f67.google.com with SMTP id x64so12636433ywg.3;
        Mon, 16 Sep 2019 01:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wYIjQncYfsETIi+DqmO+J0VFI6PHXpC/ptBO4q7LLeo=;
        b=deQhvMCBxsHyXHAMmNd7fHzNXCctNc3oDgqe9Z0W6Fk10S+RdJjh+wN2Lb7FfHqQ03
         JkgqiG6+zy+uZOgTUAf+HBefgc0ttp+iahCy0rsqF4JDXdjnbczh26JMJn+7iIV+0YV6
         UmTgqTKXFiBlk+Opvl5KtyGeS5JARiQx6ZHQR//uw03v8KGbAnYYprABRsyUa+E1cXWX
         hljSgCXbRCBLk3NzbxlcE8RFFW19bf5HI0XbF04BIAexyBk4hQawJW8IIPG2RIvFG2/i
         dFQf2n/OC3wvf4XRcKolZf1VjBCfZeKUwSwT/IUtgnMEiFXu2UV06L3ly3gNXuJyo8LI
         wLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wYIjQncYfsETIi+DqmO+J0VFI6PHXpC/ptBO4q7LLeo=;
        b=sy6fj0zB+fVc6gbkuZj1M/1LKb5ZpTuWD+/HM8Bqe6VDwKP3a7g6wZVf6NbAtkEJGZ
         Y54s2O1tLTiwuyuvSQS2vgaz2enzvMj6uriX3SwWX6XBlGZ6h5oQaG2PzDkMz7/USG/f
         Oln/otSut5FBUlE7kxmozDe2xx/Ffmx/g6EfjiWmiRKr4mfwVwVBogZqjjZ54aaPgAp4
         WCG4YOYqJRUdhFdo9E2NMmLfSNyoFAwdceeXwu1BQxoeK+KBBZDGZokuElvBj/H+5FQ+
         buaoW5AUz6RrfuF76tPtDXVDeF4tmyIqiYn72eepuDMrWCb8W6Z5jwkejpFWJHjeHUGi
         kxVQ==
X-Gm-Message-State: APjAAAVU90weNCXbWhNwI/MhxJKfZJvUiXv0FtqOC9H3wMRU66zsF4Qd
        zaWOuzZC8Qh59sjFvDiPZG+zRJAgQh2/WujKZfI=
X-Google-Smtp-Source: APXvYqxd+o9Zw9GnFd6zl9mo8U29h38L34xFlnr1sy5yK6zpIphmj1vjnp2giE1B7z4j2KcVl8MJjlLszyslm0U9nw8=
X-Received: by 2002:a0d:ccc9:: with SMTP id o192mr42913277ywd.346.1568621924554;
 Mon, 16 Sep 2019 01:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190909090906.28700-1-kkamagui@gmail.com> <20190909090906.28700-3-kkamagui@gmail.com>
 <20190910144215.GA30780@linux.intel.com> <20190910150342.GA1920@linux.intel.com>
 <CAHjaAcRf3fcJMp6AwVRTrVaABZVzSkhBwRcpKZogAS4SSDK3zg@mail.gmail.com> <20190913131234.GA7412@linux.intel.com>
In-Reply-To: <20190913131234.GA7412@linux.intel.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Mon, 16 Sep 2019 17:18:33 +0900
Message-ID: <CAHjaAcQ07nDbb1NAg4m7bK8szSKVi7b55m7epzxPJjxxttaT0A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tpm: tpm_crb: enhance resource mapping mechanism
 for supporting AMD's fTPM
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vanya Lazeev <ivan.lazeev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> > > Matthew pointed out that having a hook in NVS driver is better solution
> > > because it is nil functionality if the TPM driver is loaded. We need
> > > functions to:
> > >
> > > 1. Request a region from the NVS driver (when tpm_crb loads)
> > > 2. Release a region back to the NVS Driver (when tpm_crb unloads).
> > >
> > > My proposal would unnecessarily duplicate code and also leave a
> > > side-effect when TPM is not used in the first place.
> > >
> > > I see this as the overally best solution. If you can come up with a
> > > patch for the NVS side and changes to CRB drivers to utilize the new
> > > hooks, then combined with Vanya's changes we have a sustainable solution
> > > for AMD fTPM.
> >
> > It's a great solution. I will update this patch on your advice and
> > send it to you soon.
> >
> > By the way, I have a question about your advice.
> > If we handle the NVS region with NVS driver, calling devm_ioremap()
> > function is fine like crb_ioremap_resource() function in this patch?
>
> No, you should reclaim the resource that conflicts and return it back
> when tpm_crb is unregistered (e.g. rmmod tpm_crb).
>
> I would try something like enumerating iomem resources with
> walk_iomem_res_desc(). I would advice to peek at arch/x86/kernel/crash.c
> for an example how to use this for NVS regions
>
> Then you could __release_region() to unallocate the source. When tpm_crb
> is removed you can then allocate and insert a resource with data
> matching it had.

Thank you for your sincere advice, and I have some questions about it.
As you know, the core reason of this ACPI NVS problem is that a busy
bit is set to the ACPI NVS area. So, devm_ioremap_resource() function
fails because of it.

If we want to call devm_ioremap_resource() for this case, we maybe
need to rearrange the existing memory layout from the child
relationship to the sibling relationship below. We also need to get
back when tpm_crb unloads.
[ ACPI NVS (parent) [ TPM CMD buffer (child of NVS) ] [ TPM RSP buffer
(child of NVS) ] ]   <--->   [ ACPI NVS head ] [ CMD buffer ] [ NVS
middle ] [ RSP buffer ] [ NVS tails ]

Our concern is a race condition between NVS driver and TPM CRB driver.
In my view, we could solve this problem if we only make and call the
functions you said, requesting and releasing a region from NVS driver.
NVS driver doesn't rely on iomem layout, and it relies on internal
nvs_list data.

Therefore, I added some details to your guide. How about this sequence?
1) When tpm_crb driver loads, the driver checks if command/response
buffers are in ACPI NVS area. If so, it requests (or removes) the
buffer regions from NVS driver's nvs_list (with
suspend_nvs_unregister() function I will add to the nvs.c driver).

2) If command/response buffers are in ACPI NVS area, tpm_crb driver
calls devm_ioremap() instead of devm_ioremap_resource() like this
patch.

3) When tpm_crb driver unloads, the driver releases (or adds) the
buffer regions to NVS driver's nvs_list (with existing
suspend_nvs_register() function in the nvs.c driver).

I think the sequence could solve the problem we concerned.
What do you think about the sequence?

Seunghun
