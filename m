Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC7E29DE78
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Aug 2019 09:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfH0HMg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Aug 2019 03:12:36 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33497 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfH0HMg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Aug 2019 03:12:36 -0400
Received: by mail-yw1-f67.google.com with SMTP id e65so7551395ywh.0;
        Tue, 27 Aug 2019 00:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tu5xcNElhBaNnfeG0jVQbHeyzi3d6ikBp6zzIrvcXtw=;
        b=cp3gfkFiu31HWR9vnfOFwlABLnsyBxCJ9ycKKjNtISpm2YWxnn5n+AiDgdO+CMtqzx
         mB+V8ZjrjTbxAIlyLglRqu8OFbw23CSxqufF8vtslc8c9N/b+suywUCnupVMHzEnJdVT
         MwPvD1zlTGnBQTSEWhwoHmltmguEFtVvUfeokgxYqhwgegYCq5j1edE6otSMcbOQXgQ8
         SHSZevGIzuKpcKzFwggCpRV6aDFZQhAfsEsx08Sln1pg5q0xa7KMRRGOSLZl0KOdsdFW
         zF9r3o6dTT6XkC0LC4MJ0XfW0PBlt7xadJ4lwdXY7MJwkTKd8aSGqvLhMWXmE/EIQINO
         1igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tu5xcNElhBaNnfeG0jVQbHeyzi3d6ikBp6zzIrvcXtw=;
        b=s8vew9CUwa1ghp9Vg1DoUZJ4LPpt7l0cJn82LaBsBT83+qjgQQRFh87oBHXj5zfnh1
         XyR61GPSAFx44Yj7/2BNGhw6zN0ER21hzLwTBH5fKAQDehwz7+KRBMtlb0DJZLM2FhZj
         vfpe0fodisbOG0LUvaHqHgt+4Vf66kz4JcTD1A+FRHHB/K/lpECFke9V84G1OreW8yUD
         jqnDu1TmOA4Fhlk/b7DFmkw6UDz2Yykz8PYXAXNL5eSfhvYoYBbDHJzPQj7PZfn/zTbs
         Bcue/dp+vnzw1rixqF7+QGhCwhZT2vXBDnwjsK5flqqkhxqtwb7T8tOTGEgXJKlieAVw
         w0eQ==
X-Gm-Message-State: APjAAAWhg/6s3xRYO156pex94LQta8ocCU8Riqsjxy4w73Mc3k9Id0AL
        OvTgKOaK5Ro0COsLHZFrLJ2buvDBzydrEEHFRuY=
X-Google-Smtp-Source: APXvYqykMWKW8pwv+Tys0T7QhtHLFhPv95dbvkyOqQBMPqRNahlsqWe1Z35At/qshXxc70ZxCuZ7yUTjVqhfzKH63EU=
X-Received: by 2002:a0d:d596:: with SMTP id x144mr14943989ywd.69.1566889955150;
 Tue, 27 Aug 2019 00:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190826074400.54794-1-kkamagui@gmail.com> <20190826113239.2tliwil35gsqap54@linux.intel.com>
In-Reply-To: <20190826113239.2tliwil35gsqap54@linux.intel.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Tue, 27 Aug 2019 16:12:23 +0900
Message-ID: <CAHjaAcTw5O+UNf6OEhLFaosx+4Yx6HtxbJ4RQsPPBVUUhANh4g@mail.gmail.com>
Subject: Re: [PATCH] tpm: tpm_crb: Fix an improper buffer size calculation bug
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

>
> On Mon, Aug 26, 2019 at 04:44:00PM +0900, Seunghun Han wrote:
> > I'm Seunghun Han and work at the Affiliated Institute of ETRI. I found
>
> You can drop the first sentence from the commit message. The SoB below
> is sufficient.

Thank you, and I will remove it from next version of the patch.

> > a bug related to improper buffer size calculation in crb_fixup_cmd_size
> > function.
>
> The purpose is to cap to the ACPI region when we partially overlap to
> workaround BIOS's reporting corrupted ACPI tables so that we don't get
> failure from devm_ioremap().
>
> The only funky thing in that function is that it lets through a buffer
> that is fully outside the ACPI region. There actually exists hardware
> with this configuration.

Yes, I know it. However, my machine has two ACPI regions (command
buffer and response buffer) below, and the crb_fixup_cmd_size()
function couldn't check the point, "a buffer that if fully outside the
ACPI region". I will explain the exact case at the end of my email.

79a39000-79b6afff : ACPI Non-volatile Storage
  79b4b000-79b4bfff : MSFT0101:00
  79b4f000-79b4ffff : MSFT0101:00

> > When the TPM CRB regions are two or more, the crb_map_io function calls
> > crb_fixup_cmd_size twice to calculate command buffer size and response
> > buffer size. The purpose of crb_fixup_cmd_size function is to trust
> > the ACPI region information.
>
> This is not true. The driver deals with only one ACPI region ATM.

Yes, the driver deals with only one ACPI region, and it works fine in
most cases. However, two ACPI regions are in the system like above,
then crb_map_io() function calls crb_map_res() function twice.
crb_map_res() function calls devm_ioremap_resouce(). So, TPM CRB
driver handles two separated regions, command buffer and response
buffer. I will also explain in detail at the end of my email.

>
> > However, the function compares only io_res argument with start and size
> > arguments.  It means the io_res argument is one of command buffer and
> > response buffer regions. It also means the other region is not calculated
> > correctly by the function because io_res argument doesn't cover all TPM
> > CRB regions.
>
> The driver gets command and response buffer metrics from the TPM2 ACPI
> table, not from the ACPI region.

I'm sorry for my mistake. I checked it.

>
> > To fix this bug, I change crb_check_resource function for storing all TPB
> > CRB regions to a list and use the list to calculate command buffer size
> > and response buffer size correctly.
>
> This cannot be categorized as a bug. It is simply as new type of hardware.
> Can you explain in detail what type of hardware are you using?

I will also explain it at the end of my email.

>
> > ---
> >  drivers/char/tpm/tpm_crb.c | 50 ++++++++++++++++++++++++++------------
> >  1 file changed, 34 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> > index e59f1f91d7f3..b0e94e02e5eb 100644
> > --- a/drivers/char/tpm/tpm_crb.c
> > +++ b/drivers/char/tpm/tpm_crb.c
> > @@ -442,6 +442,9 @@ static int crb_check_resource(struct acpi_resource *ares, void *data)
> >           acpi_dev_resource_address_space(ares, &win)) {
> >               *io_res = *res;
> >               io_res->name = NULL;
> > +
> > +             /* Add this TPM CRB resource to the list */
> > +             return 0;
> >       }
> >
> >       return 1;
> > @@ -471,20 +474,30 @@ static void __iomem *crb_map_res(struct device *dev, struct crb_priv *priv,
> >   * region vs the registers. Trust the ACPI region. Such broken systems
> >   * probably cannot send large TPM commands since the buffer will be truncated.
> >   */
> > -static u64 crb_fixup_cmd_size(struct device *dev, struct resource *io_res,
> > +static u64 crb_fixup_cmd_size(struct device *dev, struct list_head *resources,
> >                             u64 start, u64 size)
>
> With a quick spin w/o knowing the details of the hardware I'm dealing
> with it you should probably reduce the fixup function as
>
> static u64 crb_fixup_cmd_size(struct device *dev, struct resource *io_res,
>                               u64 start, u64 size)
> {
>         if (start + size - 1 <= io_res->end)
>                  return size;
>
>         dev_err(dev,
>                  FW_BUG "ACPI region does not cover the entire command/response buffer. %pr vs %llx %llx\n",
>                  io_res, start, size);
>
>         return io_res->end - start + 1;
> }
>
> Then call this inside the loop.

Thank you for your advice. I will change it on your advice.

>
> Looking at your change it does not make much sense to me.
>
> There is a weird asymmetry in it:
>
> 1. The code loops through all found ACPI regions when looking for
>    intersections with the command and response buffers.
> 2. The devm_ioremap() is done only to the last seen ACPI region. Why the
>    multiple regions matter for fixup's but not in this case?
>
> /Jarkko

I got an AMD system which had a Ryzen Threadripper 1950X and MSI
mainboard. I had a problem with AMD's fTPM, and my machine showed an
error message below.

[  5.732084] tpm_crb MSFT0101:00: can't request region for resource
[mem 0x79b4f000-0x79b4ffff]
[  5.732089] tpm_crb: probe of MSFT0101:00 failed with error -16

When I saw the iomem, I found two fTPM regions were in the ACPI NVS
area. The regions are below.

79a39000-79b6afff : ACPI Non-volatile Storage
  79b4b000-79b4bfff : MSFT0101:00
  79b4f000-79b4ffff : MSFT0101:00

I analyzed this issue and will explain in detail what happened in my system.
1) When the system was booted, acpi_bus_scan() function found two
MSFT0101:00 resources and inserted them into iomem_resource. The
regions were [0x79b4b000-0x79b4bfff] and [0x79b4f000-0x79b4ffff]. From
now, I will call the first one Region A and the second one Region B.

2) When the tpm_crb driver was loaded, crb_map_io() function was
called. Then, crb_map_io() called acpi_dev_get_resources(), and it got
Region B for the io_res variable because it found the last region from
iomem_resource as you said.

3) crb_map_io() function called devm_ioremap_resource() with io_res
(Region B). However, it returned fail because ACPI NVS area was set to
the busy area.

4*) So, I removed the busy bit from ACPI NVS by changing
do_mark_busy() function. I sent the patch to you and here is the link,
https://lkml.org/lkml/2019/8/26/163 . After patching it,
devm_ioremap_resource() returned successfully. Then, crb_map_io()
called crb_map_res() with io_res and buf->control_address variables,
and it also returned successfully.

5)  crb_map_io() got command buffer's physical address and size from
priv->regs_t->ctrl_cmd_pa_high/low and ctrl_cmd_size. The results were
that cmd_pa was 0x79b4b000 and the size was 0x4000. cmd_pa was in
Region A, however, io_res was Region B as I mentioned before. So, when
crb_map_io() called crb_fixup_cmd_size() with io_res and 0x4000
arguments, the function returned 0x4000, not 0xfff becuase cmd_pa was
outside of Region B.

6) crb_map_io() called crb_map_res() with io_res (Region B), cmd_pa
(Region A), and cmd_size (0x4000), then the crb_map_res() tried to
call devm_ioremap_resource() because io_res didn't contain cmd_pa and
size. But, Region A's size was 0xfff, so devm_ioremap_resource()
couldn't allocate resource and failed. If crb_fixup_cmd_size()
compared cmd_pa/size with all regions, it could find Region A and
return the correct size 0xfff.

7*) So, I changed crb_fixup_cmd_size() with the attached patch so that
it compared arguments with all regions. After that, the function
returned the correct size 0xfff, and crb_map_res() added Region A and
returned successfully.

8) crb_map_io() got response buffer's physical address and size from
priv->regs_t->ctrl_rsp_pa and ctrl_rsp_size. The results were that
rsp_pa was 0x79b4f000 and the size is 0x4000. rsp_pa was in Region B,
and the new crb_fixup_cmd_size() I fixed returned 0xfff.

9) crb_map_io() called crb_map_res() with rsp_pa (Region B) and
rsp_size (0xfff) because cmd_pa (0x79b4b000) was not equal to rsp_pa
(0x79b4f000). The function returned successfully, and TPM was also
registered successfully.

10*) After applying my patches, AMD's fTPM worked fine and final iomem is below.

79a39000-79b6afff : ACPI Non-volatile Storage
  79b4b000-79b4bfff : MSFT0101:00
    79b4b000-79b4bfff : MSFT0101:00
  79b4f000-79b4ffff : MSFT0101:00
    79b4f000-79b4ffff : MSFT0101:00

Lastly, I would like to answer your two questions and request something.

> 1. The code loops through all found ACPI regions when looking for
>    intersections with the command and response buffers.

As I said, the purpose of the code loop is to find the exact buffer
size and so that I don't get failure from crb_map_res and(). If it
doesn't check all regions, then it returns the passed size again and
causes failure.

> 2. The devm_ioremap() is done only to the last seen ACPI region. Why the
>    multiple regions matter for fixup's but not in this case?

Actually, if the system has two regions as you have seen above,
devm_ioremap() is called again because of crb_map_res() function. So,
multiple regions are matters in this case.

If you are OK, I would like to make a patch v2 on your advice. I also
would like to ask you about the other patch I sent to you,
https://lkml.org/lkml/2019/8/26/163 . Would you give me some advice
about them?

Seunghun
