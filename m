Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C869DAE7
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Aug 2019 03:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfH0BGB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Aug 2019 21:06:01 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:40886 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfH0BGB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Aug 2019 21:06:01 -0400
Received: by mail-qt1-f172.google.com with SMTP id g4so9968525qtq.7
        for <linux-integrity@vger.kernel.org>; Mon, 26 Aug 2019 18:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Jo2rX28QdEAbpsi1t7xlBSMUdYjZ8WUbLI0nxYRS78Y=;
        b=BRw2hT2Gq4KH+F9GXY7rPpeCIXCcMglEuoPiuynsW82su9MzJ/izzd1B/xAbmYxd4z
         AvdUFup5mhgPtjRbkClWVKvO+cqScKEiSxMw9CjuT2N97rRn/JZGBhv+l8+ZPmK+MPDp
         8+jag3oQcTRpUDBnXBOxGgYeAa/6Xik7wNbLNXeopvH1qOCeaGDC87wE/ZK3k9wNsaKa
         PycCj6jPK2x5TiiFn1vMQ4bLw5pFeXKG2rWnLlHEvX9U5Wz5SybKjDnVJo9MJYa8NcGJ
         CqSuAYjRLYsk7jBF6IdRgKu0z0ulYLRvK7qxW+ocy0H6hNVMUS65p2eHcG+Ww8YukpDr
         t9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Jo2rX28QdEAbpsi1t7xlBSMUdYjZ8WUbLI0nxYRS78Y=;
        b=Fw2hO/261+JYQ9minlDTbtsxPTz/wHGydTMBdjOfbjw8aWvjfOwc91SeKWJQA8O2/a
         s6qwZ+7crqXu3OqoXPYyOV8HUvXk6R/AHFeULiCkwp8LU4GPQlOwPl6og2yhHrBdppO1
         Aj3Z6pnG5BP0bFRnSG+6R7e8/mGrOI1M4A747rdz7NazyKL2hndb42VGq4fkgdjQmhAb
         gDjdFF653yLep9ellKE2kxeMDC6745FwwR8FGIdNYQUl+t8toUSxPPU2bwq6F5pM1StG
         iqmE9ZOxmxsbJpyUvMmcsXaKACTie8xwhXLxuSCIYPviMpd77OqnDBtPR+Al2tgnZx1L
         SSXw==
X-Gm-Message-State: APjAAAUNh6nENkwGVsjrHGQAhKv0lulT4gU6yJOnVAT9o5QeU71EKu9X
        xdeQ8i0S4jM6V3xsYqaC4lLScmDypok=
X-Google-Smtp-Source: APXvYqy7Z/5lo5gWZPj1YUJtLZKmDnsz8rOfSLA/IZZtlO49Hd2A3pKPUdLrZQtHSDkmNVP4xZxMkA==
X-Received: by 2002:aed:30e5:: with SMTP id 92mr20680063qtf.12.1566867960594;
        Mon, 26 Aug 2019 18:06:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id m3sm7245527qki.10.2019.08.26.18.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Aug 2019 18:06:00 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i2Pvr-0000R8-F3; Mon, 26 Aug 2019 22:05:59 -0300
Date:   Mon, 26 Aug 2019 22:05:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Piotr =?utf-8?B?S3LDs2w=?= <piotr.krol@3mdeb.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: TPM 2.0 Linux sysfs interface
Message-ID: <20190827010559.GA31752@ziepe.ca>
References: <3329329f-4bf4-b8cd-dee8-eb36e513c728@3mdeb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3329329f-4bf4-b8cd-dee8-eb36e513c728@3mdeb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 27, 2019 at 01:24:55AM +0200, Piotr Król wrote:
> Hi all,
> I'm moving here discussion that I started with Jarkko and Peter on LinkedIn.
> 
> I'm preparing for 2 talks during LPC 2019 System Boot MC and one of it
> will discuss TPM 2.0 sysfs support [1]. This was discussed couple times
> [2] and explained why it is not done yet by Jarkko [3].
> 
> Why is this important?
> - there seem to be no default method to distinguish if we dealing with
> TPM 1.2 or 2.0 in the system
> - distros use various tools to detect TPM based on sysfs (e.g. Qubes OS
> scripts)
> - tpm2-software has ton of dependencies, is not easy to build,
> development is way faster then distros can manage and packages are often
> out of date or even broken, so using it can be troublesome
> - for deeply embedded systems adding fully-featured tpm2-software
> doesn't make sense e.g. if we just need PCRs values
> 
> Jarkko comment on detecting 1.2 vs 2.0:
> "Detecting TPM 2.0 is dead easy: send any idempotent TPM 2.0 command and
> check if the tag field matches 0x8002 (TPM_NO_SESSIONS). The sysfs
> features for TPM 1.2 are for the large part useless as you can get the
> same data by using TPM commands."
> 
> Ok, but doesn't this mean I need TPM2 software stack?
> Peter mentioned that it can be tricky to invoke such tools early in boot
> process.
> 
> Finally, I do not feel expert in the field of Linux integrity and don't
> want to argue for sysfs if it doesn't make sense for TPM 2.0, but if
> that's the situation I would like to know what are the best practices to
> solve above issues. If you think there is something important to be
> discussed in above context please let me know.

The sysfs is not done, fundamentally, because the sysfs structure of
the existing TPM1 stuff is grandfathered in, and doing anything like
it for TPM2 is a complete NAK for not following the normal sysfs
interface design rules, particularly of one value per file. This is a
big part of why it was dropped for TPM2.

So exposing PCRs and things through sysfs is not going to happen.

If you had some very narrowly defined things like version, then
*maybe* but I think a well defined use case is needed for why this
needs to be sysfs and can't be done in C as Jarkko explained.

A good reason would be something like needing to trigger a systemd
unit from udev.

Jason
