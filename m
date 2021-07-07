Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80043BF05A
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 21:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhGGTju (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 15:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhGGTjt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 15:39:49 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B122FC061574
        for <linux-integrity@vger.kernel.org>; Wed,  7 Jul 2021 12:37:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f13so7040562lfh.6
        for <linux-integrity@vger.kernel.org>; Wed, 07 Jul 2021 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPg1H7me9qbdg7UVxK09AOFutkX6+2jjmGZLpP+9rFE=;
        b=Gk8b0Lglm9tXpIUGTSA+BdAdYFO01tU4/ih0LElLxUv84iB5oXNSeu91aDRJ/CLOd2
         hJCmRSTZ03TY7odHpSknbfl7YLtvbiU4e0ZAVnWMlHzlY4eKn29VkADWqWGvZgDIUHS2
         qr8tUuOReXID4F77MCK1ebc5hdK98+Fqzg0GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPg1H7me9qbdg7UVxK09AOFutkX6+2jjmGZLpP+9rFE=;
        b=kPHRM3+SMiFbAAsqKGae8y43kjIOJ5R9XzjvtkqJFbOrv8PqOHOXLuBsX9aAVYdKLv
         KvM8TFFFuGgG4m1NMf5dQZUqdjHJwiKgERidh5S5Z/tkpOO1Zz1Yqn5zo6DOR0wNdlAW
         1ad49AI/10ysZxl6Cn9KTmeSq6jyNcTYhYxL1JAtJx0X1eUSVQECCBRoVWm7aNVKz7FY
         D3R8uIHOiT5hB6A0pdNud8OEQJsCFxxbs/Svcpb8FQWwWXtvVq7zoNJ3ZRBE0xBGCitd
         DhlKmRJAnRieWVw7rO1B5OGQ+V4dfP9onbbZwdZWM6b2eybc9NH1lNXFGCasuEX8HdYP
         RDjA==
X-Gm-Message-State: AOAM530F4w0ZFuRHXsqi/RS+ANag4ha4GKlN8easgg4iKg4HgHCZcDrn
        nYJDSeFyjTjpdqPOCa62orbj7lT8+0Bw18VkUK8=
X-Google-Smtp-Source: ABdhPJzQqVGP2YeWiWHBL8l8KTT5QwRtt3yUCvrqOx9lvCTB49olNxSH5CkSlzCnr716/12cNG8KKQ==
X-Received: by 2002:a05:6512:32a4:: with SMTP id q4mr15375633lfe.252.1625686625969;
        Wed, 07 Jul 2021 12:37:05 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id f20sm720154lfh.168.2021.07.07.12.37.05
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 12:37:05 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id q18so7061941lfc.7
        for <linux-integrity@vger.kernel.org>; Wed, 07 Jul 2021 12:37:05 -0700 (PDT)
X-Received: by 2002:a2e:b55b:: with SMTP id a27mr9830494ljn.251.1625686299582;
 Wed, 07 Jul 2021 12:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210707024403.1083977-1-eric.snowberg@oracle.com> <20210707024403.1083977-6-eric.snowberg@oracle.com>
In-Reply-To: <20210707024403.1083977-6-eric.snowberg@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Jul 2021 12:31:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEncBgRdv0FZjmZGQP5tzcdYA0XJrxmBEOevi06dimtw@mail.gmail.com>
Message-ID: <CAHk-=wgEncBgRdv0FZjmZGQP5tzcdYA0XJrxmBEOevi06dimtw@mail.gmail.com>
Subject: Re: [PATCH RFC 05/12] integrity: Introduce mok keyring
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        scott.branden@broadcom.com, Wei Yongjun <weiyongjun1@huawei.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, nramas@linux.microsoft.com,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Jones <pjones@redhat.com>, Gary Lin <glin@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jul 6, 2021 at 7:45 PM Eric Snowberg <eric.snowberg@oracle.com> wrote:
>
> Introduce a new keyring called mok.  This keyring will be used during
> boot. Afterwards it will be destroyed.

Already discussed elsewhere, but yeah, when using TLA's, unless they
are universally understood (like "CPU" or "TLB" or whatever), please
spell them out somewhere for people who don't have the background.

I saw that you said elsewhere that MOK is "Machine Owner Key", but
please let's just have that in the sources and commit messages at
least for the original new code cases.

Maybe it becomes obvious over time as there is more history to the
code, but when you literally introduce a new concept, please spell it
out.

           Linus
