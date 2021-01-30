Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53158309799
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Jan 2021 19:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhA3Sp1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 30 Jan 2021 13:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhA3Sp0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 30 Jan 2021 13:45:26 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE5AC061574
        for <linux-integrity@vger.kernel.org>; Sat, 30 Jan 2021 10:44:45 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id f1so17194393lfu.3
        for <linux-integrity@vger.kernel.org>; Sat, 30 Jan 2021 10:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=89SdszQOEMr4HUN0UTxJxsMmAIYG9ucrs0ELQI8XVrk=;
        b=MptePmMJoBrEaKxom97tw/OO+Bnzv8iV/Ds3P010RVLy81iRtVxmpKXvsO4bKDFrqu
         Xk6uHhbukwFxQrxCat6b8MZ01rWyCyGT4/bBEI3Knjwa0TLln9ZUrZogAhDqxlQlgawR
         ciSDL7wDPtvGzSCWvl/LvwSvl7BPZyVr+M7DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=89SdszQOEMr4HUN0UTxJxsMmAIYG9ucrs0ELQI8XVrk=;
        b=S5forwSWNgaosQ70WFToTDJqS3G+40tM067gjQpW7RJrTRF6Qe/ybp8zqA2SnsiKGN
         qByPkDHn6w6WCY/RjngaOsoaN8IfMjrr2vxZbBmVo2l7jSAj9T5jE2VxQa26RD0F4+Pk
         iBvspZzqqF9GnOpsMXclYPUdImluIEMMz3O2x8Vv1jy0PAVN/dNAVFVy9cej4DKwGaO5
         Ck529vSjW91j3mezULIgZXbGjK+lzEjdyJzPdtghlKhWvQ3pScydQDVjVLGT8e1xHKX8
         hmmDxCP3BPsHrGqtdacbcU23eyS2B2EcMxi21cL9QLrmF806ZX03cr9FgBYbnadCJjLO
         QxSQ==
X-Gm-Message-State: AOAM533fQcT1AL/Ddpj11VUiyjoqeWmN/EQpqq6w7USJ/vMeJFkTqBV1
        Ss6QSOIIbbxH9rSVbxpEDxByuXYzZr2L9A==
X-Google-Smtp-Source: ABdhPJwSv96QKKpAgwUOsqIKVjP6Fanp0qtmolHKjaZY2zx8wDpZH20/vyv7ytGQfPEXm92wL8/p4Q==
X-Received: by 2002:a05:6512:210b:: with SMTP id q11mr5275677lfr.295.1612032282624;
        Sat, 30 Jan 2021 10:44:42 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id c9sm22440lji.121.2021.01.30.10.44.41
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jan 2021 10:44:41 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id p21so17165940lfu.11
        for <linux-integrity@vger.kernel.org>; Sat, 30 Jan 2021 10:44:41 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr4728000lfu.40.1612032280785;
 Sat, 30 Jan 2021 10:44:40 -0800 (PST)
MIME-Version: 1.0
References: <YBNcv8jLEDE8C/IW@kernel.org> <CAHk-=wjk7zEOFEjGWZmGF8_dcitBQ_dPUMSkr-g7B7cYcXGvSQ@mail.gmail.com>
 <YBWUHkbNt6OLoeUq@kernel.org>
In-Reply-To: <YBWUHkbNt6OLoeUq@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Jan 2021 10:44:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=whCPotCrco-Q4hUfgoG3+6uNn_CprxbuV1mQtxJHm0gfg@mail.gmail.com>
Message-ID: <CAHk-=whCPotCrco-Q4hUfgoG3+6uNn_CprxbuV1mQtxJHm0gfg@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd updates for v5.12-rc1
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Jan 30, 2021 at 9:15 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> This was meant for 5.12 but the timing was *way* too early. I'll take this
> one back. Just to unambiguity reasons I'll use tpmdd-next-v5.12-rc1-v2 tag
> for my final v5.12 PR, once I send it.
>
> I considered a bit, and I really think that it would make a lot of sense
> to do a late 5.11 just containing the two commits from James

Ok. I'll ignore this pull request, and will expect the "real" ones later.

Thanks,

             Linus
