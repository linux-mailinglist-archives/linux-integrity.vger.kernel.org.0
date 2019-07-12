Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE24675F6
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jul 2019 22:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfGLUgg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jul 2019 16:36:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40513 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfGLUgf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jul 2019 16:36:35 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so23194214iom.7
        for <linux-integrity@vger.kernel.org>; Fri, 12 Jul 2019 13:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hPjxy1Y4XykRaQARrUP5zc9rIpF9JunleJZPwGG4+e8=;
        b=a9jlvT5CA2lEzGQaLJG5Y8fmuDn62tCkfEvFBEr8PQ8l+PhCaIxk7nBltZ6NnSeoy7
         drk/yeP2Nykr35aI/h1NC62BiQguksF4VpmUQjYD+jfvzLeYflQZ3tXcI4+SuPxmikx9
         7+ZpFbZHSkkjyoDzNkaUiMXgZvg5PWfKYcv/DfY8j8RG367t2AchA5YUqwQ9OzJsoITt
         Slwh7VUG+0hM970jYu4jL3yR8IRT5RazzeTTKLjpZaOYQH458cOk2bwTbSejUxsOKs4Z
         3mL7sGrvN6kzDb2fsO7vSBOt/igzidHVTpAa6vfLteddQWsYjNm7JPj8iEds0SFoueyO
         qgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hPjxy1Y4XykRaQARrUP5zc9rIpF9JunleJZPwGG4+e8=;
        b=W6UyNn9YKJiNhwyILZ+mx2HOJIwL0RnUraIA9AwWDN6Wu1ha6883DFukERqOAavfod
         SwXEXUBuqPVSTQ4NCnyUQZFsHziVnIij7ChH1KNPUD2arIn/GHYZasGT66bT64FuR4vl
         GIyYIPRwXMfeexnvXGPPu+ie+dr81m4rD9aCsvngk1ol9ttAw12/8Zs5DxM/XzRqgxA6
         q8jI3gwcGeUhoeZoIa4T5od4P5Pqg8Ae2wGexBJDcap9mNnfcFNMqBx4D/V1d8iff/j6
         YOicjRSQWfDIQu8Oy8ra8nE0YCQaqTgrvBYzY9oENckvSFSjjB1Fik3FtdwN5m3MDreH
         S/5w==
X-Gm-Message-State: APjAAAVfwtCKiI2OaquagcFhE0bKzGN50I1WXqK9AC6u8x1DZxBeSlQW
        Yu3NDN1QniPRCNaNuw2vVHhYOMpNeBPvaQTJe/C6nw==
X-Google-Smtp-Source: APXvYqxiJlAoA+H5V7CIgFUuCbZioJ9vuXMZe8tHqd+cYgzorj0TQewL4zUA5YxIRwabtYo+qE5JHocW/MZnikyvAgM=
X-Received: by 2002:a6b:8f47:: with SMTP id r68mr13429943iod.204.1562963794817;
 Fri, 12 Jul 2019 13:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7BC7@ALPMBAPA12.e2k.ad.ge.com>
 <20190711145850.GC25807@ziepe.ca> <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7C56@ALPMBAPA12.e2k.ad.ge.com>
 <20190711185027.GG25807@ziepe.ca> <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7CFE@ALPMBAPA12.e2k.ad.ge.com>
 <CACdnJutS4-N0GgtYPy9GGJ8dVf48VZGF5AFL2raB55bSPKUpNw@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7E2A@ALPMBAPA12.e2k.ad.ge.com>
 <CACdnJutmhRyGjiumXbzai1fTNqcYMRthzTfMsiQgzKFtu3+teA@mail.gmail.com> <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7F56@ALPMBAPA12.e2k.ad.ge.com>
In-Reply-To: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7F56@ALPMBAPA12.e2k.ad.ge.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 12 Jul 2019 13:36:23 -0700
Message-ID: <CACdnJusqAbBxJTzQttF6DwU1efz336xA4o2uchnV9OFbMB+n1A@mail.gmail.com>
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

On Fri, Jul 12, 2019 at 12:05 PM Safford, David (GE Global Research,
US) <david.safford@ge.com> wrote:

> UEFI - the laptop dmesg e820 follows:

Could you boot with efi=debug and attach the EFI memory map?
