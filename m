Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AB61C4AE9
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2020 02:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgEEAQZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 May 2020 20:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgEEAQY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 May 2020 20:16:24 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5107AC061A0E
        for <linux-integrity@vger.kernel.org>; Mon,  4 May 2020 17:16:24 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j14so11383673lfg.9
        for <linux-integrity@vger.kernel.org>; Mon, 04 May 2020 17:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QiqUUss2jL8iYfIE6Bd+6noVnRyNqoTAQ9IVKOuRQgM=;
        b=N4s+XP8Hut8idJW2OzJ7P2a4JzXglSpVAIJjOBw2Ld+5maAmt0BoeQ06cj4QDsgGDE
         6NAcJbsXytHSsE4lwzCkdHu0rpMzM+wisgaZcziE5fWQOQV64jlS0LdKr7xstsB9UVpj
         mvdwkKwFKgiksfSm/EgH/UxIAAWrqnO8bFFX0Lexs6cbcyu8KkMMItlCihp8z7iDO0ss
         aNEAOQneXGQzOZoCkFT5iHrMhaq7DQ80aKybV35v5cm2xpXcpz7v57rzUH81ux+HoSU3
         DZiwpOXUYwj1/gR1uVO5SGmB9WkBXR5UKZl8CKlSKBHoyL8UsOZlR+02AseogMgZ52Np
         grdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QiqUUss2jL8iYfIE6Bd+6noVnRyNqoTAQ9IVKOuRQgM=;
        b=UdHnsk0BKiVYU/UkHeeiSPvi4l2Cy7FkzxJtqHalZOx54lcjYCXmoCTRxC9lyuXtej
         BnBNxGDK7ypthP4VEZ2WRDUbQdUWGLaFajsclZsy5KZwWD0/Avc9vYGHgdfhXuf0ywZY
         laKOjDmTjVMEiEWmm+9BX/cWEcRP2dBRBdTlHnXE6C0xi+5skFUfdIig8z7fq3Nzfnaf
         TVHb4oDADq4e/muZEc5hr+9fPtmqh+4nkEpAFBmyNAOy/PKQCmEKyE3SCVaoWT2RRc5B
         q5uh3aLROLNgp1n62zqnyn8YkLszSc2yNJE1dH35yYCMhBV+dcPUFjiCcMvBbU4Ayy8J
         KHcA==
X-Gm-Message-State: AGi0PuZg+9MVgEGeDmDfbyArd/9Pk4SLmkuIbeH8EK9uZOopDSbdYaNy
        Os+tUiRb5+DS4BzyRxIzniNpuNm3nnq0XXCBpNc3Gg==
X-Google-Smtp-Source: APiQypJGv5tcseONQbK5x2mnROWwvW0Pn8R67E8fsfoelBLNFOf4MQLot2TT1lmzTeAvYKM70sV8eZFtKle0oWz4pT4=
X-Received: by 2002:a05:6512:104a:: with SMTP id c10mr5802lfb.184.1588637782543;
 Mon, 04 May 2020 17:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <1588627060-7399-1-git-send-email-zohar@linux.ibm.com>
In-Reply-To: <1588627060-7399-1-git-send-email-zohar@linux.ibm.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 5 May 2020 02:15:56 +0200
Message-ID: <CAG48ez2PwqoDBx0pkZKFHvMXHNqAc8AfuTR5oPoF-obHqUo0zQ@mail.gmail.com>
Subject: Re: [RFC PATCH] ima: verify mprotect change is consistent with mmap policy
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 4, 2020 at 11:18 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> Files can be mmap'ed read/write and later changed to execute to circumvent
> IMA's mmap appraise policy rules.  Due to locking issues (mmap semaphore
> would be taken prior to i_mutex), files can not be measured or appraised at
> this point.  Eliminate this integrity gap, by denying the mprotect
> PROT_EXECUTE change, if an mmap appraise policy rule exists.

Just keep in mind that there are other ways to create executable
mappings containing controlled code; e.g. PROT_EXEC with
MAP_ANONYMOUS, or writing to /proc/self/mem (which is a debugging API
that works entirely without ever making the VMA writable - I had an
old series to provide LSM hooks for that stuff at
<https://lore.kernel.org/lkml/1478142286-18427-3-git-send-email-jann@thejh.net/>,
but I guess I must have forgotten about it or something...).
