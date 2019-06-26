Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0907C56C5E
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jun 2019 16:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFZOkm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jun 2019 10:40:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41193 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfFZOkm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jun 2019 10:40:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id 205so2476719ljj.8
        for <linux-integrity@vger.kernel.org>; Wed, 26 Jun 2019 07:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFSieBUuyGxTsoChoI1Kg6drR2s6KdAfDv5qlvcL6U4=;
        b=gjjmtx7pQSLXIIPglIXmGlSTAjDSuSeyjiGzL71jUUkSnCusccrysNb3SwVt97+GUD
         oxeu8ymiCZJnqV/vL7dlXOgo5o8IIPugS7Ryb7Pdzu6/h5nc0JOKe//dJ0UOGIoD0jxK
         OkHQuk1t5Sl8m3zFSRGiGv+RQYGxc5dNEBZkdhLI45ATX3mLx1+68cdzbi0bSz2D1KqB
         NpomU+kuGnweJeMmcMZ68zCy2noFhwu/Mu85tq489I8KdqkZG4+UMtqGJWfMkivcXpJh
         zLN83pmP+mFa8IJbToG+iJYMd1u+jNpdHIfTD12UJJdep5ElubPENxXzSV+EFGnJuymf
         oobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFSieBUuyGxTsoChoI1Kg6drR2s6KdAfDv5qlvcL6U4=;
        b=p6QMkYYvOv38X40/mWRS3RGowGdWxPe0LpgEDnpqQgFkpwfwAKCjyEtAIJylu5IeZf
         t0tFoOTRiaFmPlxa/quEED1D8nKNTFgPMj+fkqQY+LRbkbevsCLspzHWDHH/h2AhGgef
         Pjttw9dLFVYnzOEQGv4jKh31KnF2x7Dgk4SqvMss+UA2wBZj5EhiLpiSqg7M5dzO1V8/
         fdIhg6m9FAQXPC/1A8Ug2rNvUVNXcdvLuk+jcsx2WZbcCpQTzIn0psfCZncLuKrZEpNs
         YQ7hkCfQU5qb9h+O7dIcVW01K2rNscD3uLlKKDZThD8raa93xMnXd5hSSe8xqOk9V/i4
         Xe8w==
X-Gm-Message-State: APjAAAV6IK4++35uvI9GPPcqLLnroG4rOoiBrG16UPNk3lQUz5rTrcxH
        RUGLrH8JP3sIKGiFjVdsvkSlEdgvduUDv/IJPH0=
X-Google-Smtp-Source: APXvYqyjlVV9L5GOgYQDqmTeuqiK71QN+BqUttvb4uQvfVYf8MTlQp8n9SNv6pdDWLAnpXVbOgAS8ZoU0iS2otbonLo=
X-Received: by 2002:a2e:b047:: with SMTP id d7mr3236032ljl.8.1561560039763;
 Wed, 26 Jun 2019 07:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190623090027.11852-1-vt@altlinux.org> <1561387352.4340.20.camel@linux.ibm.com>
 <20190624161638.xz6ebfvxzilh2gew@altlinux.org> <1561403393.4340.58.camel@linux.ibm.com>
 <20190624192349.gdp2xbe5c6etaw6v@altlinux.org> <1561405647.4340.63.camel@linux.ibm.com>
 <20190624201156.xrd6lyhrbnpbo2uz@altlinux.org> <1561431368.4340.106.camel@linux.ibm.com>
In-Reply-To: <1561431368.4340.106.camel@linux.ibm.com>
From:   Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date:   Wed, 26 Jun 2019 17:42:05 +0300
Message-ID: <CACE9dm9yO+h8wELkze051n-HN=hPgb=BZdJx-hTra6YUgfWtSA@mail.gmail.com>
Subject: Re: [PATCH v7 00/11] ima-evm-utils: Convert v2 signatures from RSA to
 EVP_PKEY API
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 25, 2019 at 5:56 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Mon, 2019-06-24 at 23:11 +0300, Vitaly Chikunov wrote:
> > Mimi,
> >
> > On Mon, Jun 24, 2019 at 03:47:27PM -0400, Mimi Zohar wrote:
> > > On Mon, 2019-06-24 at 22:23 +0300, Vitaly Chikunov wrote:
> > > >
> > > > > > With and without this change, the sha family is working properly, but
> > > > > > with this patch set, I'm now seeing "sign_hash_v2: signing failed:
> > > > > > (invalid digest)" for gost/streebog.  Previously it worked.
> > > >
> > > > If it worked before this is strange. It should not. What patchset
> > > > version it was?
> > >
> > > No, I'm saying that I built both openssl and the gost engine a while
> > > ago.  There's been some gost engine updates since then, which are
> > > dependent on a newer version of openssl.  So I'll need to rebuild both
> > > openssl and the gost engine in order to re-test.
> >
> > Hm. I don't see a difference in signing code.
> >
> > Only the difference is there was no `log_err("sign_hash_v2: signing
> > failed: (%s)\n", ...)` about singing failure, because, I thought, the
> > caller would report it anyway, because of `return -1`.
>
> Thanks, Vitaly, for all your help.  It's now working properly.
>
> Mimi
>

I tested various generation and verification options and also backward
and forward compatibility.
Everything was fine for me....

-- 
Thanks,
Dmitry
