Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBE828FB47
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Oct 2020 00:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbgJOWjN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Oct 2020 18:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731737AbgJOWjM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Oct 2020 18:39:12 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1A3C061755
        for <linux-integrity@vger.kernel.org>; Thu, 15 Oct 2020 15:39:12 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p9so416046ilr.1
        for <linux-integrity@vger.kernel.org>; Thu, 15 Oct 2020 15:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PNVrwMcnpoNgjo7pv1tG0HCQUnvlJcJ2814AD4JKcFM=;
        b=J94LJU5muwRZIsgz8mPHI8YTSPXXMEOOp/j+Q3/Zja0KLC2A+9A2nCasco0twNVWxC
         M/7fX4khWEJR6X/kPciQbeSFErasTH8dd6YwWcxMR1tnV/V+lVafryieYobdDNI/fYA3
         cYkIFT3VJki6ao6ktFlEFEplVUWAge4OiuV36CXZ3SFSQV843MY4FdEVCzejz01p8qPQ
         weXsFIZYRZdRVsJ+Q4+i8gMn737PzPngpV+mNXNFaBWhY1Z8j4sny9lQxmr+4zYGS7AA
         eiIW+eOt5TLxBP+jSWNduRjARS8c+DkekgjAWJMNYsu3SMr6hNRftE6jJE71eJv7CExu
         veaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNVrwMcnpoNgjo7pv1tG0HCQUnvlJcJ2814AD4JKcFM=;
        b=rNCZov03SnFLU2Q5rinO7Atvw60RQhPHu6L0ILZcAQAM/ILD/GCTkvOmBsAq3w5xZw
         qFVy5kedpkypVeQdx0ns5gBSWhmn8bwOxaZIKABSRHSkuM2g5Y1VcX7FcvjhKG3Frm2h
         /FTuX/RRx0lJqwmWh4ThifyWRpN2AdUe6hsDVz06o+IWVxiWXIxBdKWb6iV2WtU1SkUK
         ojLGBbpBgfiWvUtFPAo8BqOEDg8kNhbiuonDsewYHeFAP7ivA8o8dzCw9iuv9JZL8yVg
         2Xc+lzzh6ZoSxu84JSxNlc4a/MLdCL5gD3ypvEpIapFqTRNUL+FT/tVKZoBEoCh+8Y8/
         H6MA==
X-Gm-Message-State: AOAM532+ZSpMjHBeLsnIwsFSO/dlNwqxrl7tCTRVgrXMtkjv9rgoZAIP
        m6/mDpaF+DfhL34mqoqcafUl9qCAhxeMkacfhlaBsft0YbcQVg==
X-Google-Smtp-Source: ABdhPJyk8Tjkk9vcLuLb5hD3TuJwuAigYpozkOYwv+5NxEhE7O5qlBn4CuGfGZOnJPBnctys9I/DFnpva394MUKiD24=
X-Received: by 2002:a92:85cf:: with SMTP id f198mr552326ilh.158.1602801551801;
 Thu, 15 Oct 2020 15:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201015214430.17937-1-jsnitsel@redhat.com>
In-Reply-To: <20201015214430.17937-1-jsnitsel@redhat.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 15 Oct 2020 15:39:00 -0700
Message-ID: <CACdnJuuAyBYacCiOOZ8-L-0Xnfa3+pCVY_oejOJ8RPzuG2QgrQ@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis: Disable interrupts on ThinkPad T490s
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko@kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Hans de Goede <hdegoede@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 15, 2020 at 2:44 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>
> There is a misconfiguration in the bios of the gpio pin used for the
> interrupt in the T490s. When interrupts are enabled in the tpm_tis
> driver code this results in an interrupt storm. This was initially
> reported when we attempted to enable the interrupt code in the tpm_tis
> driver, which previously wasn't setting a flag to enable it. Due to
> the reports of the interrupt storm that code was reverted and we went back
> to polling instead of using interrupts. Now that we know the T490s problem
> is a firmware issue, add code to check if the system is a T490s and
> disable interrupts if that is the case. This will allow us to enable
> interrupts for everyone else. If the user has a fixed bios they can
> force the enabling of interrupts with tpm_tis.interrupts=1 on the
> kernel command line.

I think an implication of this is that systems haven't been
well-tested with interrupts enabled. In general when we've found a
firmware issue in one place it ends up happening elsewhere as well, so
it wouldn't surprise me if there are other machines that will also be
unhappy with interrupts enabled. Would it be possible to automatically
detect this case (eg, if we get more than a certain number of
interrupts in a certain timeframe immediately after enabling the
interrupt) and automatically fall back to polling in that case? It
would also mean that users with fixed firmware wouldn't need to pass a
parameter.
