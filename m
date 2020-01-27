Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA1814A005
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2020 09:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbgA0Isg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jan 2020 03:48:36 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42458 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgA0Isf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jan 2020 03:48:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id y4so9723249ljj.9;
        Mon, 27 Jan 2020 00:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VCcnWs6s8gn29MYaAd9oQBT5MAE70m/6K+dI3egtdag=;
        b=TkCRU32B3zvdFqtWytk2gIyvGmNpvCdc26ssNl5uPcPtF89ktfWW8N7sARpETKLxS+
         cgB857pNCTR6pGsKdOXkMvOGPPVgFvBkU5Uy80ZzUFd7uMRuOPi834ZJrcr77C6un6aI
         SxedSPElnVpLFP3v+kjr1EmQROoqT1z63qJzE4LVnW1ierev84SjACc0wqVY0KVho2JL
         DPyR5sZbk+j5LEBvzHxc/vO2ltU+w1tGb3REpKr8efVL0YgAr81YL3roTJ4ed+4KU4os
         PvQWmIj5M08xp92Knzs1ShRernVWU+BvyhrH6ghk5g95uyOh7w8yRL5/3XMh5sYIFHg8
         4pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VCcnWs6s8gn29MYaAd9oQBT5MAE70m/6K+dI3egtdag=;
        b=eafOJe+D2Zc8izTU1yRc6NLfoE6PBR8qFXxdmUqguz9KSr1ypiIT21UDpuQTR9h46Q
         qiYLY0JaJV37R37+d5dJPF9hQJivNATj7nd8yedLATUztwWJ3ACXUPIEY9CiG55BHWmk
         5FE/W49UdaTZpMNFugRFNIJO6qfndfJxpWkco2EWX5Nut+wA0Y3YkBCun4y7QVZPyUJ4
         UsHboSKSUTvrNMUrYC7l/FxB+SqP0JFBJz0L4xwBEGqF8Gprh9fqTvyRhhIYLCUZsH01
         FX48ZXATvDdJej9nmRmsCTyHHEHVpPjc6JctTuf94ese3HxZk5vWAR6m6+VwUebPnJmQ
         auJQ==
X-Gm-Message-State: APjAAAWYRemhrb5Z9o15y0zg/HcNySPUx7uKKLk/RyYDMjTZ/ehGIedH
        Wr/QsVA9ud8O/ynKdayQGynB9D6WMPwi8pufd/I=
X-Google-Smtp-Source: APXvYqxq6o4JgOHgHipWwikSFjr2/AjO0cQPj15tfmEIrEN0nZiDvF7q48mGKUPWvO0DLdJZIe9S+Bh8gzNtQpV7qno=
X-Received: by 2002:a2e:9110:: with SMTP id m16mr9486657ljg.140.1580114913295;
 Mon, 27 Jan 2020 00:48:33 -0800 (PST)
MIME-Version: 1.0
References: <20200108111743.23393-1-janne.karhunen@gmail.com> <1a8c2fb4698eaa72be219413e373c5829a7cd652.camel@gmail.com>
In-Reply-To: <1a8c2fb4698eaa72be219413e373c5829a7cd652.camel@gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Mon, 27 Jan 2020 10:48:21 +0200
Message-ID: <CAE=NcrYEyfj9028aP+MYAnFJdX9NJ3Lvy1wiECbNv59HRaDMLg@mail.gmail.com>
Subject: Re: [PATCH v2] ima: export the measurement list when needed
To:     david.safford@gmail.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jan 24, 2020 at 4:46 PM <david.safford@gmail.com> wrote:

> > Some systems can end up carrying lots of entries in the ima
> > measurement list. Since every entry is using a bit of kernel
> > memory, allow the sysadmin to export the measurement list to
> > the filesystem to free up some memory.
> >
> > Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
>
> I like this approach, as it will work easily for measurement lists in
> any format, and it will work for user or kernel triggering.

Yes, that was the point..


> I'm getting an OOPS, though, whenever I write a filename to the
> securityfs file (e.g. echo /var/log/ima.log > list_name).
> Here's the relevant from syslog:
>
>   BUG: unable to handle page fault for address: 00005650a0e7fe30
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0001) - permissions violation
>
>   Oops: 0001 [#1] SMP NOPTI
>
>   RIP: 0010:ima_write_list_name+0x35/0x114
>
> I haven't had time to debug this. Any suggestions?

Interesting. I'm not a X86 man, but it looks like a SMAP trap to me.
In other words, the kernel was not allowed to read that
"/var/log/ima.log" string as SMAP protection was active for that piece
of memory. I was under the impression that the SMAP is disabled while
the copy_from_user is running..

I'll try on the X86 hardware and see if I can reproduce, maybe its off
by one read or something. Only X86 target I tested was QEMU.


> > +#define secfs_mnt    "/sys/kernel/security"
> > +#define am_filename  "/integrity/ima/ascii_runtime_measurements"
>
> You probably really want to export the binary data, as that's
> what's needed for attestation. (Or both, but that's trickier.)

That's why the file name was left as an argument to the export
function; you can export either one. I suppose we'd need some setting
to tell it which one to export.


--
Janne
