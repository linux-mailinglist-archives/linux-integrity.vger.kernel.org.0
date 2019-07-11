Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A78F5660B4
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2019 22:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbfGKUd0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jul 2019 16:33:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33343 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729616AbfGKUd0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jul 2019 16:33:26 -0400
Received: by mail-io1-f66.google.com with SMTP id z3so15580454iog.0
        for <linux-integrity@vger.kernel.org>; Thu, 11 Jul 2019 13:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rQWFvQ45gUjO8JhBu1BZ8yG6gJGSx9SFOsZLTKRxg8=;
        b=h8dfg609t0LWfBFR5ij3Lmr6akiDQjlKwkNM+EqaXfWfEs3eMurxebMJ4NX+Q/+AHp
         gw9VhCYI2l7gWg29DRK1Tu6Pnkq1wrfbM6+b/N7FBPHBeZRa+Ndj9LGLz0VP+AThoBLB
         Nez7ayFrx66wd69B+IJKnJJI/+jw5QJkwVSGPquFF1hdedJ8uTkS5E+qfIN4DMN+32di
         Zob7A8SodxjQnJl0hLOccP8fh3gglPHU5ggURbusWF616wk+75rrxToYXKqJgMsAmST7
         vwwqqXXGMzo91euWDVUrM0yOmwUs292hYbXizxw+ozpQh9NBz1kZWBTD3ECrUq032fRl
         U48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rQWFvQ45gUjO8JhBu1BZ8yG6gJGSx9SFOsZLTKRxg8=;
        b=bWenkx9X/QcGWstJeHst+kapMNyBYQCThZi9AlLhpdcWEEW4hr/TZmucMaiyfFzD3W
         5AH5kd2/empNbFaMm5Knbk/CEqq7UrwHJNaIikPLrNmOwQOiOk2tzQkvUxAuHM9D51zF
         iA3jrUWigXIPfTh2wdE17gp5SkqolKGRUbTUpok08OSeV9GX6CZU9OvntVNXMGUp6c/j
         O1vKHO/YKodzSl9OKKa8luqVNsVB+ls4jDMGf0T4y3cKQQD4XKnJff1jmoqggwfpFRJP
         fjc6qGAzoeEbFn4pq28mmLwIziawG8i1mNAFvsg0jTpZt8Rl216lvFqEseMdf3wSJ8yd
         8cXQ==
X-Gm-Message-State: APjAAAVpkgLoe/i7d+O9EYpb13PraqrFUNJc2Lzl8S853iZIEg79oX+e
        vWe35grqV/G1ub/kZvPss1HVpNSDfDInNR2bU9hmJBEa1UI=
X-Google-Smtp-Source: APXvYqwDgkvNEPSUYh8/ZFQ6yCS54ifuJJcYqOEv/n7MelLIW9JH5L58ISp5Pd71W3fDzVpIuiG5W8MN+PN2Dq64MnE=
X-Received: by 2002:a6b:f114:: with SMTP id e20mr3646041iog.169.1562877205424;
 Thu, 11 Jul 2019 13:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7BC7@ALPMBAPA12.e2k.ad.ge.com>
 <20190711145850.GC25807@ziepe.ca> <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7C56@ALPMBAPA12.e2k.ad.ge.com>
 <20190711185027.GG25807@ziepe.ca> <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7CFE@ALPMBAPA12.e2k.ad.ge.com>
In-Reply-To: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7CFE@ALPMBAPA12.e2k.ad.ge.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 11 Jul 2019 13:33:14 -0700
Message-ID: <CACdnJutS4-N0GgtYPy9GGJ8dVf48VZGF5AFL2raB55bSPKUpNw@mail.gmail.com>
Subject: Re: [PATCH] tpm_crb - workaround broken ACPI tables
To:     "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 11, 2019 at 12:32 PM Safford, David (GE Global Research,
US) <david.safford@ge.com> wrote:
> As far as I can tell, some OEMs simply are putting bad data in the tables.
> I have seen at least one report where a BIOS update did fix the problem.

The issue is that the CRB region is mapped into a region marked as
ACPI NVS. drivers/acpi/nvs.c claims this region and as a result a
resource conflict is generated. Since Windows is clearly fine with
other drivers using ACPI NVS regions, the correct fix involves
figuring out a way to either share these resources or allow tpm_crb to
reclaim the region from the NVS driver. Note that the NVS driver's
behaviour is to save and restore NVS regions over suspend/resume, so
simply forcibly allocating the resource will result in two separate
codepaths touching the region on resume - this seems like a bad
outcome. Ideally this could be solved generically, but practically
(given we've only seen this around TPMs, as far as I can tell) adding
a hook to nvs.c that allowed drivers aware of the issue to have the
space handed off to them might be easier.

Have you seen this on any non-AMD systems?
