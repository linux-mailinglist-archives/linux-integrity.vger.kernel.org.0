Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6B93BF164
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 23:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhGGV2y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 17:28:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbhGGV2y (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 17:28:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2606D619CB;
        Wed,  7 Jul 2021 21:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625693173;
        bh=/pVy166dfy+UrmpILZTvgIelpcvDiZkfwT6maygMI/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tbKfcOA64mpmf+AGiUavBt1B1NVDwqFMS6+zQUbbhUqwGaoOGsOJ/Ok5fCMXIUbgy
         7YSLAzBg/uu7pkeLxWnHmRHpyldzZK/D9MmS53D0vZjCxEuBk+eNGlFKFcMWIOAAJ7
         eOqYIKKWJ4r7zfKeQWUVn+DN3T67mYzZrzVwRFdH98KkmjFs4SERirmFaAgHYPQYj+
         3XdjnGjrQ5AYqGhXHHMwX+wXH1W7PuLap8pIB2lU/t6XLK9hfDvHygvpRqW5hBEkMv
         /rK9GWJHE1ySC3pOPXX6mcAaose2oadoQWgtB0kAxMahQo32o5wVza3rs/HK52ThDT
         1RNdJyn4LWSDg==
Date:   Thu, 8 Jul 2021 00:26:11 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
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
Subject: Re: [PATCH RFC 05/12] integrity: Introduce mok keyring
Message-ID: <20210707212611.pdkmkxhqomkf4ngg@kernel.org>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
 <20210707024403.1083977-6-eric.snowberg@oracle.com>
 <CAHk-=wgEncBgRdv0FZjmZGQP5tzcdYA0XJrxmBEOevi06dimtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgEncBgRdv0FZjmZGQP5tzcdYA0XJrxmBEOevi06dimtw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 07, 2021 at 12:31:23PM -0700, Linus Torvalds wrote:
> On Tue, Jul 6, 2021 at 7:45 PM Eric Snowberg <eric.snowberg@oracle.com> wrote:
> >
> > Introduce a new keyring called mok.  This keyring will be used during
> > boot. Afterwards it will be destroyed.
> 
> Already discussed elsewhere, but yeah, when using TLA's, unless they
> are universally understood (like "CPU" or "TLB" or whatever), please
> spell them out somewhere for people who don't have the background.
> 
> I saw that you said elsewhere that MOK is "Machine Owner Key", but
> please let's just have that in the sources and commit messages at
> least for the original new code cases.
> 
> Maybe it becomes obvious over time as there is more history to the
> code, but when you literally introduce a new concept, please spell it
> out.
> 
>            Linus
> 
I'd suggest for the short summary:

"integrity: Introduce a Linux keyring for the Machine Owner Key (MOK)"

Given that "keyring" is such a saturated and ambiguous word, and this not a
subsystem patch for keyring itself, it should be explicit what is meant by
a keyring.

/Jarkko
