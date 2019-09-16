Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA411B3684
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 10:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731177AbfIPIm2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 04:42:28 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44537 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfIPIm1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 04:42:27 -0400
Received: by mail-yw1-f68.google.com with SMTP id u187so12634801ywa.11;
        Mon, 16 Sep 2019 01:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9lLqiKGB0dQVyYUgSZL1fkHgw/lvHIOK/4/nOWteAA=;
        b=uqEipHTV0BcVxitEothS1N9y8NQL3B95SpqX4FYqIqDk1GB4emMiW+8jcUvHJyiWkT
         lXGxe7/DVZ7nvEMLlXB898P6kBHK6773kn5YpRxwqJBDwnGkKSpHdhMLBf2mOxdo3X65
         p5YpqQW9Bn4llSvyTnA0KIYkbUdpXap8F/sRdbAh0VIHEbGAOcQz/veNTmG9A3cBB5eL
         slKIkP6wRBN6bA3B0bLE+7QAZsGP3VfKlb8wbRYB0Y9FPSuakf72VpcJNw2ab1TNuWBB
         JP2T65wlRgbOzenVZDqOvWHUhKOO5oZSrR9fd+cMQ4QOPBkZCYgDSEoGnTJKXFWboCsz
         IJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9lLqiKGB0dQVyYUgSZL1fkHgw/lvHIOK/4/nOWteAA=;
        b=H83/myV664Mo7+WOZTMBv2jj3BAdvJzcpQVOeNej84Y7Wd2LzzUM9ZKP1VqQtOAb+3
         zcPEqI/dK6/cI6ZEg83Jgq8bWjwme5Tpg8zQNzB/C6bv5G4FLAHygEjrGvUpTMLlDnUP
         214WDcJx6E73XwvEugjoULop9BW1c+3cj0kfC3HUvM2b3a1O1QejzeIn/2xdAex8XMSr
         mBkaz+tDVOg3foHXZA+l3v8BK7L3uDxzwhzG8ExVk/AjYHyJAsyEndXB71BuAyfBjty5
         sch9yF7Jrzi3vpGM7zqB9ybY6ZztKWlD3G0zFhKBy79hegwpHdcdL07UEe4VcgQ43h46
         lnOQ==
X-Gm-Message-State: APjAAAVic2y/vxxqbHg+K1X6n2Ht8z0wJw4Z+QBw/lNBB8eyqprjZDVQ
        SGJ/i1haZmq+S78qeBkmLEU83yro4h/+aR5xuts=
X-Google-Smtp-Source: APXvYqwFMKP3WwLzaSzVAIThbahveUI12QiKazseEJAIgYGU79tS97X7ESKvi6JNX3UwtFPVXooCaRQberbNFnK+3yk=
X-Received: by 2002:a81:c1:: with SMTP id 184mr44932020ywa.175.1568623345551;
 Mon, 16 Sep 2019 01:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190909090906.28700-1-kkamagui@gmail.com> <20190909090906.28700-3-kkamagui@gmail.com>
 <20190910144215.GA30780@linux.intel.com> <20190910150342.GA1920@linux.intel.com>
 <CAHjaAcRf3fcJMp6AwVRTrVaABZVzSkhBwRcpKZogAS4SSDK3zg@mail.gmail.com>
 <20190913131234.GA7412@linux.intel.com> <CAHjaAcQ07nDbb1NAg4m7bK8szSKVi7b55m7epzxPJjxxttaT0A@mail.gmail.com>
In-Reply-To: <CAHjaAcQ07nDbb1NAg4m7bK8szSKVi7b55m7epzxPJjxxttaT0A@mail.gmail.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Mon, 16 Sep 2019 17:42:14 +0900
Message-ID: <CAHjaAcQVn1c2t80rnsFzKvBH5ZcYgd5aXcUR-GsU_XQk1L08sQ@mail.gmail.com>
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

Sorry for my mistake.
I misunderstood some functions in nvs.c. So I have fixed it and sent
my email again. My email is below.

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
nvs_region_list data.

Therefore, I added some details to your guide. How about this sequence?
1) When tpm_crb driver loads, the driver checks if command/response
buffers are in ACPI NVS area. If so, it requests (or removes) the
buffer regions from NVS driver's nvs_region_list (with
acpi_nvs_unregister() function I will add to the nvs.c driver).

2) If command/response buffers are in ACPI NVS area, tpm_crb driver
calls devm_ioremap() instead of devm_ioremap_resource() like this
patch.

3) When tpm_crb driver unloads, the driver releases (or adds) the
buffer regions to NVS driver's nvs_region_list (with existing
acpi_nvs_register() function in the nvs.c driver).

I think the sequence could solve the problem we concerned.
What do you think about the sequence?

Seunghun
