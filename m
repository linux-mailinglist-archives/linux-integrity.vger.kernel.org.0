Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3568AEE46
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2019 17:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403830AbfIJPMl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Sep 2019 11:12:41 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34218 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730177AbfIJPMl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Sep 2019 11:12:41 -0400
Received: by mail-yb1-f195.google.com with SMTP id u68so6255786ybg.1;
        Tue, 10 Sep 2019 08:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dBN0mOQb7kVuILysF+ico+GsGc+Un+rEP0RRGf2F7fA=;
        b=eEeKL2c0kgpkANsPqQ+OIL4UrNqXsOrPBNDv5Xhb76Uh8VRM8yrYt8RSubFZZq9FnY
         XAjaFqFhfc4Tn/mPWNpvnB7AebGsGxLQg7jlJuPXz1dm+vuSlzdXZ986Rm042VT9M/7y
         tzNjkF4qB8bJ3YvoaRJVX5BZ+nNbuOpyDAZWGu0PJxn75Uhgkz5VwiS3LgIVAaAFHnbI
         MOI1IaSDmoMObywmoGlSUXpQfRG9DBjQh27guB1HgKqz5MinaEwK2lhx8MyLDs+Wc3z8
         +vg9neqlu5GqBlnCvjB9SjhhCVO/0mYBcHFweHtFnGdcRf2uUG8LqYqHbW51FHjzwhPX
         N2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBN0mOQb7kVuILysF+ico+GsGc+Un+rEP0RRGf2F7fA=;
        b=j5MiRcjcFD9ZGGeHrfJpr0EJ4mbju26VxoQ4vMYIFWFEB+FYND5/GsEeB6gJQM7HIb
         e12LEnjbb+Q7d5YoDOpI0o3z2bOBqZXcLHXq02DAkzH73CLO5w03L9/zOmW420qJsVeg
         xfwAvHX3WJEm85WnYmPaYvT3SS2/bAVG11RSCWfiQQFg1fWNu17IT9ddSpuzFgwA0DHQ
         pclyORe8rNVzsv93OBktEphztCLc8MjgKKVLYGcAAXewoSVHjldIBIZRwChYMgcMYof7
         DBJl3cldXMTPfXMPwPg/pQnFqd6xCjkDI2n3wSSvMQ+qE+CnLhKQNeMZyy1nV9SWAfrZ
         LJBg==
X-Gm-Message-State: APjAAAXTz+sAPMLHtK0LVm+nvk95/Q4mlJE0GU2YTtK7UFKwT9BHDtTD
        G+jPDngu75/5++8PoSWIsPQoCDeFbkwgEwNLy7Y=
X-Google-Smtp-Source: APXvYqzi0rcOSdrW08Ls9qoI4oX8dwob9XnFDdNGrV07kIdOjEbn2N1g/H+DHq2jz1Xlewmr8YljVo4KdeeAJe0784c=
X-Received: by 2002:a25:d751:: with SMTP id o78mr21368658ybg.101.1568128360022;
 Tue, 10 Sep 2019 08:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190909090906.28700-1-kkamagui@gmail.com> <20190909090906.28700-2-kkamagui@gmail.com>
 <20190910123452.GC7484@linux.intel.com>
In-Reply-To: <20190910123452.GC7484@linux.intel.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Wed, 11 Sep 2019 00:12:25 +0900
Message-ID: <CAHjaAcRyd1bSjeD-jJkjzeSGq8gf_f=qz_=wyi1omY7-20xARw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tpm: tpm_crb: enhance command and response buffer
 size calculation code
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

>
> On Mon, Sep 09, 2019 at 06:09:05PM +0900, Seunghun Han wrote:
> > The purpose of crb_fixup_cmd_size() function is to work around broken
> > BIOSes and get the trustable size between the ACPI region and register.
> > When the TPM has a command buffer and response buffer independently,
> > the crb_map_io() function calls crb_fixup_cmd_size() twice to calculate
> > each buffer size.  However, the current implementation of it considers
> > one of two buffers.
> >
> > To support independent command and response buffers, I changed
> > crb_check_resource() function for storing ACPI TPB regions to a list.
> > I also changed crb_fixup_cmd_size() to use the list for calculating each
> > buffer size.
> >
> > Signed-off-by: Seunghun Han <kkamagui@gmail.com>
>
> I think as far as the tpm_crb goes I focus on getting Vanya's change
> landed because it is better structured, more mature and the first
> version was sent couple of weeks earlier. You are welcome to make
> your remarks on that patch.

Thank you for your review. I already knew Vanya's patch,
https://lkml.org/lkml/2019/8/11/151, and this patch didn't work for
me. I also couldn't agree on some points like memory allocating inside
the ACPI walker and changing many parts of TPM driver. I would like to
support AMD's fTPM with the smallest changes since this is a
workaround as you know.

I didn't understand clearly what your point is. Do you want me to
change my patches structurally like Vanya's patch and make patch v3?
or want me to give some advice to Vanya?

>
> /Jarkko
