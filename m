Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6C86AEE7A
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2019 17:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbfIJP2e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Sep 2019 11:28:34 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39687 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbfIJP2d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Sep 2019 11:28:33 -0400
Received: by mail-yb1-f196.google.com with SMTP id o80so3447975ybc.6;
        Tue, 10 Sep 2019 08:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vKYdc9cN7UUMlwojbvq9IlbGHtZMRPDdw+6lRqJRyFA=;
        b=HJbBOpaKk5mixp0xoDM8iD6kLK2zZrpVE+7AH1qhOA4SgO+QWGwYERZiSICsYREVl+
         l4uP803Vic4AE7KKCx4DkQXCC6Uy8psO7cVLGqGI2097hYQ5dK1e9OYIEjSmQjJpesTk
         GpjsoXlLp5rUlnQkiskSlqbK39hHVuQICRBH43VDdOK0EDoNNAEgY7YdzZ2KL2bQqMDn
         2DSShvio62+2OcWzwg4pSIN4gALneDBrPysJOm7kF1B98Pfa6rHoOsnxE6JX4OBiT3bQ
         L3Dc4w3DrzjCAYavgCUyb+jnRYz5V9sS//pF2yCnwkP9lH1rtDCzKWz1BvgEHQYADdUq
         JGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vKYdc9cN7UUMlwojbvq9IlbGHtZMRPDdw+6lRqJRyFA=;
        b=Sy9gUY957YLWVn514R5qdXdbd6AYPgKYLRDWD+yQEfhgko2JluJmERkjOMZSQGoXpp
         +tIGdJqAVokxV9U+4XY2xOK+W+fyTqRqSfhGmuARzJmus5EZ5sbyDLOyT576vi2b2Fvx
         drSCHylnG41ic7ZlFZgk2sgJIMd/NtmP0qFLFm9PvO6FtRKi8UAFe9xlmXwcD9v5Ygt5
         oHaf1gEY3/P7jugtW3DSf0jQDY5pn1/aRCF/H7L2TavQKL2IM3HdQ/9FSyhcLXaEzltk
         Ck1wcPts/QGgnKu2ZducckJttmTHhmjXHwN5Up/TtMaVaYrZW/8xSgbMgd7ELZcBDudL
         YM6g==
X-Gm-Message-State: APjAAAX5B78XQOiM0kIzQ5a4nFM10Tce6jyDew8FOgyOBrVV1gCGgNoV
        AcRzDivwGPY2u0Psom+GGL7bffP4Jxngw4QXeFb/7AAidHI=
X-Google-Smtp-Source: APXvYqztz7oapn1LJuLxoz0mf2ylZTwLVr+YBvn8qM++B/ZQxqgzWIZRx7haTmp8EjSfOmdEUIIqSURfLtYgECrDQjM=
X-Received: by 2002:a5b:305:: with SMTP id j5mr20079957ybp.256.1568129312654;
 Tue, 10 Sep 2019 08:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190909090906.28700-1-kkamagui@gmail.com> <20190909090906.28700-3-kkamagui@gmail.com>
 <20190910144215.GA30780@linux.intel.com> <20190910150342.GA1920@linux.intel.com>
In-Reply-To: <20190910150342.GA1920@linux.intel.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Wed, 11 Sep 2019 00:28:18 +0900
Message-ID: <CAHjaAcRf3fcJMp6AwVRTrVaABZVzSkhBwRcpKZogAS4SSDK3zg@mail.gmail.com>
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

>
> On Tue, Sep 10, 2019 at 03:42:15PM +0100, Jarkko Sakkinen wrote:
> > On Mon, Sep 09, 2019 at 06:09:06PM +0900, Seunghun Han wrote:
> > > I got an AMD system which had a Ryzen Threadripper 1950X and MSI
> > > mainboard, and I had a problem with AMD's fTPM. My machine showed an error
> > > message below, and the fTPM didn't work because of it.
> > >
> > > [  5.732084] tpm_crb MSFT0101:00: can't request region for resource
> > >              [mem 0x79b4f000-0x79b4ffff]
> > > [  5.732089] tpm_crb: probe of MSFT0101:00 failed with error -16
> > >
> > > When I saw the iomem, I found two fTPM regions were in the ACPI NVS area.
> > > The regions are below.
> > >
> > > 79a39000-79b6afff : ACPI Non-volatile Storage
> > >   79b4b000-79b4bfff : MSFT0101:00
> > >   79b4f000-79b4ffff : MSFT0101:00
> > >
> > > After analyzing this issue, I found that crb_map_io() function called
> > > devm_ioremap_resource() and it failed. The ACPI NVS didn't allow the TPM
> > > CRB driver to assign a resource in it because a busy bit was set to
> > > the ACPI NVS area.
> > >
> > > To support AMD's fTPM, I added a function to check intersects between
> > > the TPM region and ACPI NVS before it mapped the region. If some
> > > intersects are detected, the function just calls devm_ioremap() for
> > > a workaround. If there is no intersect, it calls devm_ioremap_resource().
> > >
> > > Signed-off-by: Seunghun Han <kkamagui@gmail.com>
> >
> > This problem is still valid and not addressed by Vanya's patch (and
> > should not be as it is a disjoint issue).  However, calling
> > devm_ioremap() is somewhat racy as the NVS driver is not aware of that.
> >
> > My take is that this should be fixed in the code that assigns regions to
> > the NVS driver e.g. it could look up the regions assigned to the
> > MSFT0101 and ignore those regions. In the end linux-acpi maintainers
> > have the say on this but this would be the angle that I'd take to
> > implement such patch probably.
>
> Matthew pointed out that having a hook in NVS driver is better solution
> because it is nil functionality if the TPM driver is loaded. We need
> functions to:
>
> 1. Request a region from the NVS driver (when tpm_crb loads)
> 2. Release a region back to the NVS Driver (when tpm_crb unloads).
>
> My proposal would unnecessarily duplicate code and also leave a
> side-effect when TPM is not used in the first place.
>
> I see this as the overally best solution. If you can come up with a
> patch for the NVS side and changes to CRB drivers to utilize the new
> hooks, then combined with Vanya's changes we have a sustainable solution
> for AMD fTPM.

It's a great solution. I will update this patch on your advice and
send it to you soon.

By the way, I have a question about your advice.
If we handle the NVS region with NVS driver, calling devm_ioremap()
function is fine like crb_ioremap_resource() function in this patch?

>
> /Jarkko
