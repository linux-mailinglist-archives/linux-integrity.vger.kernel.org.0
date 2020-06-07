Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A09F1F0F5F
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Jun 2020 21:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgFGT7X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Jun 2020 15:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgFGT7W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Jun 2020 15:59:22 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556BAC08C5C3
        for <linux-integrity@vger.kernel.org>; Sun,  7 Jun 2020 12:59:21 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s1so17891869ljo.0
        for <linux-integrity@vger.kernel.org>; Sun, 07 Jun 2020 12:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfFkjoxj9fOIuKPRJb0FDkBxNdU4BLvuGT9ldDD2gzo=;
        b=Z/UxSQFSg3CDWwOVJuymkitl0NLXIOoRBih0s5v1TS0bvysDNE7rbLrJqwHBvcXhIc
         lHvnCJXF/bTw/cJJkyXraQFWjE5VkIE4f7yumSh8zxnuOzwkU+uZYNxoNLZrPUU7QZWm
         matRTgJ+GFJInbWVu4kDVi/ok+81m/ZgikWSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfFkjoxj9fOIuKPRJb0FDkBxNdU4BLvuGT9ldDD2gzo=;
        b=b439FmZTKQtYBqFFoV43AIaGKKBgWA036MfSKqayjHN8zuL7/dhNyfzZqZ2WeUUh8O
         5nAZrvW2GtpbHH9oyRnaAHv2wppdvV2spMlWy5fmxKrVykw+Rc0bx/Mut8s3lT5K9TyA
         qRrIm6HoDXE1U26OL+JGDFPL27Jr5MHPY+0R83jgbuON4mRkzzDwlTTaAOKtpnuiHrKY
         Pyiqow4P4Jo+o1zeUpG7KZqiWNfgWqCirD2KkRyDd1eAlqtT8cZrdlQGUnBeZnANPFgW
         5OU+ZM8MAlj4xzHdVVMe4dyxFfqj02fvzsrpkJO+2yNhs7XkzrZtQoqbqIZzBuzEm4tI
         ZJdQ==
X-Gm-Message-State: AOAM53030K1Vw1+qLWQIZ2oVq134ixx2OJ8Szc2sc3RA3gsT+1pJQyHz
        9UpWTSmyuUJWd99QioL6TEyw0ZCAbgU=
X-Google-Smtp-Source: ABdhPJyNcqmVAMSj78wSKM4gMB0KNBWuniuHf7Xw52fganwjKVQKmP/y9KticxYc5y7tlgKs/+uiVA==
X-Received: by 2002:a05:651c:554:: with SMTP id q20mr9630790ljp.137.1591559959532;
        Sun, 07 Jun 2020 12:59:19 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id t19sm3815080lft.47.2020.06.07.12.59.18
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 12:59:18 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id y11so16216928ljm.9
        for <linux-integrity@vger.kernel.org>; Sun, 07 Jun 2020 12:59:18 -0700 (PDT)
X-Received: by 2002:a2e:8991:: with SMTP id c17mr8444228lji.421.1591559957881;
 Sun, 07 Jun 2020 12:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <1591376548.5816.14.camel@linux.ibm.com>
In-Reply-To: <1591376548.5816.14.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Jun 2020 12:59:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whV2B4fPSkHA1Z6qEbwRTcJF0gYWBfAuqSGG+p-05HtfQ@mail.gmail.com>
Message-ID: <CAHk-=whV2B4fPSkHA1Z6qEbwRTcJF0gYWBfAuqSGG+p-05HtfQ@mail.gmail.com>
Subject: Re: [GIT PULL] integrity subsystem updates for v5.8
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 5, 2020 at 10:03 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> The main changes are extending the TPM 2.0 PCR banks with bank
> specific file hashes, calculating the "boot_aggregate" based on other
> TPM PCR banks, using the default IMA hash algorithm, instead of SHA1,
> as the basis for the cache hash table key, and preventing the mprotect
> syscall to circumvent an IMA mmap appraise policy rule.

I'm not sure why I didn't notice this during my test builds, but this
results in a new warning:

  WARNING: modpost: vmlinux.o(.text+0x496264): Section mismatch in
reference from the function ima_calc_boot_aggregate() to the function
.init.text:ima_pcrread()
  The function ima_calc_boot_aggregate() references
  the function __init ima_pcrread().
  This is often because ima_calc_boot_aggregate lacks a __init
  annotation or the annotation of ima_pcrread is wrong.

and I think the warning is real - and the problem is real, not just a
missing annotation.

It looks like ima_calc_boot_aggregate() may be called not only at init
time (ima_eventdigest_init() is referenced from "struct
ima_template_field supported_fields[]", for example)

So calling an __init function would be very wrong, because it might be
gone by that time.

Hmm?

                Linus
