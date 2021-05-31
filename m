Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE695395ACD
	for <lists+linux-integrity@lfdr.de>; Mon, 31 May 2021 14:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhEaMpH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 May 2021 08:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhEaMo4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 May 2021 08:44:56 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73812C061574;
        Mon, 31 May 2021 05:43:16 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id v5so14794776ljg.12;
        Mon, 31 May 2021 05:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A73j5gfyhf0kaSot1r4cuCgREnISlDQgXL2RSfW904E=;
        b=TVlblWlh307l5p4aWPY8vA4Jihb6CDsGKAr/G9XH/4AqnapaTB3R8huPmSNsVuZx+b
         yzZQ6MSRCncH+7IfjCpYfXUi/XG1Hx9688sqFNArkPEJ5ENbWc6qwmhUTA/IjPpsoLPp
         HpAjNodzljr0vbzRT/h+74w0sYtsbLEMRzfwUtbmKKSo000u8gFjaWHpmPgtvRA90448
         MwO6NsxsLtK1K7xgKubwjGjmC6dpBehlXoufd6CSSV8pHfgzX7ejSedvRUshZ/gk4Xio
         YhWmLxdPe50XPrm6qkLfCFAhaCucxbRuu/CExBhxC+IL+8M7AyUMCBbDQgGl2NvuS90A
         XxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A73j5gfyhf0kaSot1r4cuCgREnISlDQgXL2RSfW904E=;
        b=mT2c6HA6UXIB/BXe0Y1cLbUkhICXvHgcYYQ6ywKVIOSS+H6PvDTrGxGX1rvlKSrhmm
         z9DY9x4obZP+y7TKglMUHDbp77xvhH0xWPBid2dzrfU28yHGLNZE6b+e6X1DTzFVVdce
         RB2eKMIYdPmJ931d0PgISyuLsWDv2E/g4HDEroO+Bk4ecKAR4I4LM3H9jen5xi4zG6ND
         hvB+kMeavQlBqx1Iw2e719/gvbjBW7gio8SmEIVhcIFtMejMbzrQybc4R2qMYjKfVyHd
         Sq54qkK4msT3Uciq4m/jvkrROMD73VmFaihze6UcqU6Cbb89MzZyIsTp7Ic2XO6jTjCm
         QUoQ==
X-Gm-Message-State: AOAM531chcPriWG+y/ZkWrSmy33ZTDDVu/dVryh0EnNg8pSsj6uuCHwF
        E/XjnQOz5UeIsf/54VvmcsB1Ln2NR4kCazAIGzfALnjU
X-Google-Smtp-Source: ABdhPJy2wSR7fuTYBXX5HkgOt6f7QpRaKy1VKFMom6FmaoLaw15313yuwsmOlRJhDm2tsCT3+gTuNcPONDo5b05HaMQ=
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr16911734ljo.94.1622464994778;
 Mon, 31 May 2021 05:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <1622123615-15517-1-git-send-email-herbert.tencent@gmail.com>
 <1622123615-15517-2-git-send-email-herbert.tencent@gmail.com> <47cf4353-b4bb-3907-6017-60bf87805d0c@linux.alibaba.com>
In-Reply-To: <47cf4353-b4bb-3907-6017-60bf87805d0c@linux.alibaba.com>
From:   hongbo li <herbert.tencent@gmail.com>
Date:   Mon, 31 May 2021 20:43:04 +0800
Message-ID: <CABpmuwLUZY=aPjeH=AdPvP2jq2+jnTyUyLLOoAwCg+hBZJB2Xg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] crypto: fix a memory leak in sm2
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>,
        David Howells <dhowells@redhat.com>, jarkko@kernel.org,
        =?UTF-8?B?aGVyYmVydGhibGko5p2O5byY5Y2aKQ==?= 
        <herberthbli@tencent.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Tianjia Zhang <tianjia.zhang@linux.alibaba.com> =E4=BA=8E2021=E5=B9=B45=E6=
=9C=8828=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:27=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi Herbert, Hongbo,
>
> On 5/27/21 9:53 PM, Hongbo Li wrote:
> > From: Hongbo Li <herberthbli@tencent.com>
> >
> > SM2 module alloc ec->Q in sm2_set_pub_key(), when doing alg test in
> > test_akcipher_one(), it will set public key for every test vector,
> > and don't free ec->Q. This will cause a memory leak.
> >
> > This patch alloc ec->Q in sm2_ec_ctx_init().
> >
> > Fixes: ea7ecb66440b ("crypto: sm2 - introduce OSCCA SM2 asymmetric ciph=
er algorithm")
> > Signed-off-by: Hongbo Li <herberthbli@tencent.com>
> > Reviewed-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > ---
> >   crypto/sm2.c | 24 ++++++++++--------------
> >   1 file changed, 10 insertions(+), 14 deletions(-)
> >
>
> Patch 1/7 is an independent bugfix patch. If possible, consider applying
> it first.
>
> The commit message header should start with: crypto: sm2 -
>
> Also added:
>
> Cc: stable@vger.kernel.org # v5.10+
>
> Best regards,
> Tianjia

OK, will send this patch later.

Regards,
Hongbo
