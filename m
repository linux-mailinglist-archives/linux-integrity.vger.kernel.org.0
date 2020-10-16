Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD19290CE5
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Oct 2020 22:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407663AbgJPUv4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Oct 2020 16:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732579AbgJPUv4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Oct 2020 16:51:56 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C09C061755;
        Fri, 16 Oct 2020 13:51:55 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r4so5639621ioh.0;
        Fri, 16 Oct 2020 13:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3iRQz1Y4EjtL/zm7xtJOoKw/y4Z4fC/UfX5G2HjfOfA=;
        b=DTKxfLT9qPTRmpVDMyjjStu8lMoH5InFR7MMemOpvmXyhEszgMkAhgTAPhVHrIHNqV
         2zb7xJg7Jq9RpxkgmbE/E4NYuZ9atcNIc/rhJuXl/KS7jEI1wO5t70USNS/Pgr6PsyME
         /PAWKsmW+27lOTpLSpH0wFqeDm4dZ8vaune/XiCk6DBUZwKen1Mns5qd4W+YWeikcVx/
         UfPh8h5ZHdKVFMg39pSE+YS6LfofroyEZbF9NE9TwPacH4qwsi8kq1esfkSwitNyGa/F
         AbDeUgzROTPQQ0155OVmO4E7UNj4M/6cH8Wl2sIyIAulO0FOuL5LnMXqYNq50pEs7tn8
         0atA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3iRQz1Y4EjtL/zm7xtJOoKw/y4Z4fC/UfX5G2HjfOfA=;
        b=lsJ2hUv4w1vJoglWYlHV8xutlGGSnmzMyC7fX3+RGWTTVlkVY4fC3925ZMexum3qig
         plI+Q9OiOPU/VWUDGELjh7BZwb6t/6T7eydIXPeHn+sNlx7GKF2gCBJIe6DXZgI+OqfJ
         Xw1WJPmkdx7t3A49/F1JVqLn+LgAGgiEul6eyxU2lhVdV5+LofXM2DkptG6AZIakx+Iu
         QnD8Zmq3yPh7bWzNjvvFTosdeJOGcanJa9xYYOngqcB2mG/3T8Sk1wusZs688uii6+gj
         oxJ6rNHVgGajQcMUMuJtPJDZfZ8d4nUbH+l4sE4iVlFx6PpUOq5CrLIw6Kox1UwCtp4Y
         EzCg==
X-Gm-Message-State: AOAM532otci3Lqg801IOra1c2+chvs47YAhpdVRYLJSQMLPVRrT3Smij
        LAugGMgm6Bs1Xrp6xYbK1tY=
X-Google-Smtp-Source: ABdhPJzztWiZTCGYMZtjZZ8pBvCLaA7A2d0XRv+qhOiv2muZA//Rjui/vVkVwPn3uUY6NW2zcQc4sg==
X-Received: by 2002:a02:1cc1:: with SMTP id c184mr4196277jac.29.1602881514264;
        Fri, 16 Oct 2020 13:51:54 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p12sm3929524ili.14.2020.10.16.13.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 13:51:53 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 16 Oct 2020 16:51:51 -0400
To:     Daniel Kiper <daniel.kiper@oracle.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH 07/13] x86: Secure Launch kernel early boot stub
Message-ID: <20201016205151.GA1618249@rani.riverdale.lan>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-8-git-send-email-ross.philipson@oracle.com>
 <20200924173801.GA103726@rani.riverdale.lan>
 <c9ab2edf-1aaf-a1c9-92d5-2d37382a3163@oracle.com>
 <20200925191842.GA643740@rani.riverdale.lan>
 <d34c189c-4528-0458-0b84-cfd36dc068b3@oracle.com>
 <20201015182654.lgtht5fd2aaunczu@tomti.i.net-space.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201015182654.lgtht5fd2aaunczu@tomti.i.net-space.pl>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 15, 2020 at 08:26:54PM +0200, Daniel Kiper wrote:
> 
> I am discussing with Ross the other option. We can create
> .rodata.mle_header section and put it at fixed offset as
> kernel_info is. So, we would have, e.g.:
> 
> arch/x86/boot/compressed/vmlinux.lds.S:
>         .rodata.kernel_info KERNEL_INFO_OFFSET : {
>                 *(.rodata.kernel_info)
>         }
>         ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")
> 
>         .rodata.mle_header MLE_HEADER_OFFSET : {
>                 *(.rodata.mle_header)
>         }
>         ASSERT(ABSOLUTE(mle_header) == MLE_HEADER_OFFSET, "mle_header at bad address!")
> 
> arch/x86/boot/compressed/sl_stub.S:
> #define mleh_rva(X) (((X) - mle_header) + MLE_HEADER_OFFSET)
> 
>         .section ".rodata.mle_header", "a"
> 
> SYM_DATA_START(mle_header)
>         .long   0x9082ac5a    /* UUID0 */
>         .long   0x74a7476f    /* UUID1 */
>         .long   0xa2555c0f    /* UUID2 */
>         .long   0x42b651cb    /* UUID3 */
>         .long   0x00000034    /* MLE header size */
>         .long   0x00020002    /* MLE version 2.2 */
>         .long   mleh_rva(sl_stub_entry)    /* Linear entry point of MLE (virt. address) */
>         .long   0x00000000    /* First valid page of MLE */
>         .long   0x00000000    /* Offset within binary of first byte of MLE */
>         .long   0x00000000    /* Offset within binary of last byte + 1 of MLE */
>         .long   0x00000223    /* Bit vector of MLE-supported capabilities */
>         .long   0x00000000    /* Starting linear address of command line (unused) */
>         .long   0x00000000    /* Ending linear address of command line (unused) */
> SYM_DATA_END(mle_header)
> 
> Of course MLE_HEADER_OFFSET has to be defined as a constant somewhere.
> Anyway, is it acceptable?
> 
> There is also another problem. We have to put into mle_header size of
> the Linux kernel image. Currently it is done by the bootloader but
> I think it is not a role of the bootloader. The kernel image should
> provide all data describing its properties and do not rely on the
> bootloader to do that. Ross and I investigated various options but we
> did not find a good/simple way to do that. Could you suggest how we
> should do that or at least where we should take a look to get some
> ideas?
> 
> Daniel

What exactly is the size you need here? Is it just the size of the
protected mode image, that's startup_32 to _edata. Or is it the size of
the whole bzImage file, or something else? I guess the same question
applies to "first valid page of MLE" and "first byte of MLE", and the
linear entry point -- are those all relative to startup_32 or do they
need to be relative to the start of the bzImage, i.e. you have to add
the size of the real-mode boot stub?

If you need to include the size of the bzImage file, that's not known
when the files in boot/compressed are built. It's only known after the
real-mode stub is linked. arch/x86/boot/tools/build.c fills in various
details in the setup header and creates the bzImage file, but it does
not currently modify anything in the protected-mode portion of the
compressed kernel (i.e. arch/x86/boot/compressed/vmlinux, which then
gets converted to binary format as arch/x86/boot/vmlinux.bin), so it
would need to be extended if you need to modify the MLE header to
include the bzImage size or anything depending on the size of the
real-mode stub.
