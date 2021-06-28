Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B5D3B68DA
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Jun 2021 21:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbhF1TO1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Jun 2021 15:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbhF1TOY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Jun 2021 15:14:24 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99E7C061574
        for <linux-integrity@vger.kernel.org>; Mon, 28 Jun 2021 12:11:56 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id x20so20522442ljc.5
        for <linux-integrity@vger.kernel.org>; Mon, 28 Jun 2021 12:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z2eTGBF8cKmK4hfSJJaTRWNwJ/wQm5OHrYYniY5NRgQ=;
        b=PcxaghaLpMh+T26+vpvO+N/uXCxKEoqeVARQ7ZqZ5OhEITda3Zv1QXIrakDQ26Tbkq
         aU1zITj3NW/CPLK31OfGi4rtkLgsYRrW/0Tfoi+2Gf5BsHR9d7y0C1si/zKVAssOnH+t
         ZnS8HNKd9db3/SQvssXSJ660cuIhHSvMz/LBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z2eTGBF8cKmK4hfSJJaTRWNwJ/wQm5OHrYYniY5NRgQ=;
        b=Kcl0uB1khXFvUYaagIUHUaExA34ds1yYAHul9r/FFEGSzIf/dJvU+UyoZqe95ePbCv
         7MftIICOBrfxP9+4fgCbss4lPor0kUxD/wfZia+cv0m8Ld4vfZii1kfn4YX9KfWzItA2
         orME/2HbXY1dHKUhgKTb6rKyLRE5+0k2JUMADipwFm8RUg2ho/LYb9VjvZ16omu7m69A
         gJK8tpS2kd5noWAV/YRRqxcCKRU0QZiWOdKVpdv7nReCgDLUvpCmPwX72RWlOUSRDJuC
         2NX/53YsDrG7HgpqRyUy9TJ8o8ZGGbdkZ14+mthZHQfBTzt5gWKpmsjr9CFnUA2tFM/T
         XQyg==
X-Gm-Message-State: AOAM533XVYn4BdgO+pARI26gbfKoEpR+ubNQNgVK6qtcCd6rlXJvmtSy
        5tZ3OaPwmYdxfhIxkb4PKneVqhLerxFivdM+
X-Google-Smtp-Source: ABdhPJyr+Sdvhuv629N4b+F2qGesQ44O1OoANCKXmXPOdwysESXAKawqeGKzra8lThocbzyk1obruw==
X-Received: by 2002:a2e:8518:: with SMTP id j24mr701075lji.104.1624907514905;
        Mon, 28 Jun 2021 12:11:54 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id p24sm1097827lfo.0.2021.06.28.12.11.54
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 12:11:54 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id d16so34482919lfn.3
        for <linux-integrity@vger.kernel.org>; Mon, 28 Jun 2021 12:11:54 -0700 (PDT)
X-Received: by 2002:ac2:4950:: with SMTP id o16mr12794197lfi.487.1624907513712;
 Mon, 28 Jun 2021 12:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210623135600.n343aglmvu272fsg@kernel.org> <CAHk-=whhEf=xJz=rdcLWNnRU1uR6Ft-mn6xNrOg3OcQ=5cX6BQ@mail.gmail.com>
 <8de9d45e-4389-8316-b0d0-e9a43be9fade@linux.ibm.com>
In-Reply-To: <8de9d45e-4389-8316-b0d0-e9a43be9fade@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Jun 2021 12:11:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibQ3ahmo0m3BynA3bw2Fkhv0OfMJuV0+wEMwg93Fbj0g@mail.gmail.com>
Message-ID: <CAHk-=wibQ3ahmo0m3BynA3bw2Fkhv0OfMJuV0+wEMwg93Fbj0g@mail.gmail.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER changes for v5.14
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 28, 2021 at 11:33 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>
> The removal is triggered by the user changing the type of key from what
> is in the keyfile.

I understand.

But if I earlier pointed the kernel config to one my RSA keys, and
then I change some key type config option to something else, I sure as
hell don't want to perhaps lose my key as a result.

Yes, one common situation is that the key is some automatically
generated one. That's what I use personally - I want a temporary key
that is thrown away and never exists except for validating that "yup,
I built these modules for this kernel". Removing that temporary key is
fine.

But if I pointed MODULE_SIG_KEY to something outside the kernel build,
I sure as hell don't want the kernel build deleting it. Ever. In fact,
it should never write to it. It should extract the key information
from it, and nothing else.

So no. No backups either. Because there is not a single valid
situation where you'd want a backup - because the kernel build should
never EVER modify the original.

Maybe I misunderstand what is going on, but I think the whole thing is
completely wrongly designed. The _only_ key that the kernel build
should touchn is the auto-generated throw-away one (ie
"certs/signing_key.pem"), not CONFIG_MODULE_SIG_KEY in general.

                 Linus
