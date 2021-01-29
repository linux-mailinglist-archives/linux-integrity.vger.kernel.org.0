Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A63308449
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Jan 2021 04:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhA2DjW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Jan 2021 22:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhA2DjV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Jan 2021 22:39:21 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DF7C061573
        for <linux-integrity@vger.kernel.org>; Thu, 28 Jan 2021 19:38:41 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id q12so10536251lfo.12
        for <linux-integrity@vger.kernel.org>; Thu, 28 Jan 2021 19:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PuwJteoXwJBHsZo/AeV/9OQpx+tnLiPJLnbPShZBUBc=;
        b=NG1kV18DBBmRpbuQdSU1iwTNhIM+0aoPpvwgB24STtrCB9udnCanFVWj42c2rrto06
         gTg2jdx72Ip8d4XpMkqdw/eiXvAnxeFLydyB7IELtDRRjl6nI92tDzn+x33PpZ+QG8ek
         78HO7td9x1VnR+7mugl5BtiGYCHSrS9OocjsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PuwJteoXwJBHsZo/AeV/9OQpx+tnLiPJLnbPShZBUBc=;
        b=C31wN4aX4vuei1y12IN4Y4evEM9GOlu8M14Bn0fQKrnfj6vai9ZXim4pnD9B2IRfNU
         NEFge8g1PPJtsvDZyNrswT5SHLWKjIlex2Eaw9GlQ2ihVzZR2qy45GTqkeRtO7Fx6JxO
         FT7wQAoItqKG9pM4vI9Y8lJKfgdrbEezO+7n4bCeiWM0TihzSuxQJwSVjOoHnS+wWZbS
         2GjLnE77yR/udV1KGeb+3tApKXMAlgXU9eDJ7F5bNIVXVFiYsLgaShtBARtJvFqWIQcU
         AQ8mU9q2JVeMaOMg3kSHcJBK/2w0R8KlYongFGM1to60+raYbAuVD3Jwqd7YfGtOUuLR
         cBkw==
X-Gm-Message-State: AOAM533pG6zf/5rCQr1soCptCrvrE6BoajpPE7Nhvp4ea+DPDdwPjRdy
        DvntZGqnkGCAAXr6WIAFt5yE7YB/iHCo3g==
X-Google-Smtp-Source: ABdhPJxiJiQa5cJZMUPrJFUo0BgZc8vd+Jah/20T/nGe9NcdaITXPtbExixTtibpjs0uMoJoDmUfDg==
X-Received: by 2002:a19:8cc:: with SMTP id 195mr1033383lfi.504.1611891519330;
        Thu, 28 Jan 2021 19:38:39 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id v12sm1876139lfi.147.2021.01.28.19.38.37
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 19:38:38 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id e2so6917262lfj.13
        for <linux-integrity@vger.kernel.org>; Thu, 28 Jan 2021 19:38:37 -0800 (PST)
X-Received: by 2002:a05:6512:516:: with SMTP id o22mr689075lfb.487.1611891517411;
 Thu, 28 Jan 2021 19:38:37 -0800 (PST)
MIME-Version: 1.0
References: <YBNcv8jLEDE8C/IW@kernel.org>
In-Reply-To: <YBNcv8jLEDE8C/IW@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Jan 2021 19:38:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjk7zEOFEjGWZmGF8_dcitBQ_dPUMSkr-g7B7cYcXGvSQ@mail.gmail.com>
Message-ID: <CAHk-=wjk7zEOFEjGWZmGF8_dcitBQ_dPUMSkr-g7B7cYcXGvSQ@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd updates for v5.12-rc1
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 28, 2021 at 4:54 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> This contains bug fixes for tpm_tis driver, which had a racy wait for
> hardware state change to be ready to send a command to the TPM chip. The
> bug has existed already since 2006, but has only made itself known in
> recent past.

Hmm. Is this for the next merge window? The subject line implies that,
as does the addition of the cr50 driver.

But the commentary about fixes implies that at least part of it should
be in 5.11?

            Linus
