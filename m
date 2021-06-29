Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E443F3B79B4
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jun 2021 23:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhF2VLo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Jun 2021 17:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbhF2VLn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jun 2021 17:11:43 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6E2C061760
        for <linux-integrity@vger.kernel.org>; Tue, 29 Jun 2021 14:09:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id h15so748068lfv.12
        for <linux-integrity@vger.kernel.org>; Tue, 29 Jun 2021 14:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ufhNGJM6dupE9a4agTQdLDUGNF4cDrUnY1xzGz95jgI=;
        b=aDr/YTJVuUV+pIqHaKqDg8QAHteUWgCGsccfCsaPnIaYMaJh8zaB3QeqE+joYNuYhk
         HwpuTmtuRFdbTbzpflY7gXOC/VSVFPtN7BPo9QPNtZOdBiFE6oZqxJULHLgTT7gbRPVi
         3SmUUkFXTpeknxb4X/MwdfDj6tOBHTgCCI/oI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ufhNGJM6dupE9a4agTQdLDUGNF4cDrUnY1xzGz95jgI=;
        b=AFNeePwKfkxEe6vQDTYvA4SMMimGg1oDFTcV1HgWdjSEv1Y6ssRcDekgU5B9Giy62N
         99kLqmOztuJ/dg+i/kx5zKFiDtb/TymZMHwLY1IDTVPSaLMohduBOSLk9sW7KvjwOQOO
         wwKNZN6ZjDBJcBonzhD9qH9R8bwtFtAP1j4OmXdVmGHG7yjPsy0eGL+EVQ/gyGaav9R4
         JTB/7YoT5uXYLiwn+k7BOQgOjgyNsKCdq3AnR0XWHq+WgQ4dhp/tSzDWDdp00sbKamcv
         tXtjIY8akH4BNclrnmOocuT35B6nM0llMLMoxGawRoo3mIurko0sAm2CWsOArj47Znq0
         Pn/g==
X-Gm-Message-State: AOAM533i/ZFYHvM8JnDNzgStv5Qg4T3gGNUsTVvd+2C6bmtoM8qOB3z/
        btZ3zrBZ06teDHLFF9bR8BPkSMMJZ7T8DPD/IJk=
X-Google-Smtp-Source: ABdhPJy39I76g3wkSAUcN3pJruLI4bN3bDO+zx6K3N4SC2mOc8+1tCAnHTR6DEBcWdYBInXCMHgn4A==
X-Received: by 2002:a05:6512:557:: with SMTP id h23mr24911531lfl.253.1625000951212;
        Tue, 29 Jun 2021 14:09:11 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id d5sm1739096lfs.1.2021.06.29.14.09.10
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 14:09:10 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id f13so13230ljp.10
        for <linux-integrity@vger.kernel.org>; Tue, 29 Jun 2021 14:09:10 -0700 (PDT)
X-Received: by 2002:a2e:a276:: with SMTP id k22mr5224283ljm.465.1625000950503;
 Tue, 29 Jun 2021 14:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210623135600.n343aglmvu272fsg@kernel.org> <CAHk-=whhEf=xJz=rdcLWNnRU1uR6Ft-mn6xNrOg3OcQ=5cX6BQ@mail.gmail.com>
 <20210629202041.4ptesmrs67hkbzxn@kernel.org>
In-Reply-To: <20210629202041.4ptesmrs67hkbzxn@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Jun 2021 14:08:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=who-5aibKGaCgn75KjDDJ_0OVR5SiXPJhvgvLT+BGN8kQ@mail.gmail.com>
Message-ID: <CAHk-=who-5aibKGaCgn75KjDDJ_0OVR5SiXPJhvgvLT+BGN8kQ@mail.gmail.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER changes for v5.14
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 29, 2021 at 1:20 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> Since there was still a new fix for the series [*], I'd rather refine
> the pull request without these patches, and not risk them being blocker
> for the rest of the commits.

They seemed to be just the last two commits at the end of the series,
so I could take everything up to 0178f9d0f60b ("tpm: Replace
WARN_ONCE() with dev_err_once() in tpm_tis_status()") perhaps?

I can do that even without a new pull request (I've done that kind of
thing before where I decide to pull everything but the last few
commits). But admittedly I'd prefer to see a new pull request just so
that I get a signed tag (which I wouldn't get if I just merged that
top commit).

                     Linus
