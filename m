Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5270E2F27D6
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Jan 2021 06:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbhALF0i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jan 2021 00:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732060AbhALF0i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jan 2021 00:26:38 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8B2C061575
        for <linux-integrity@vger.kernel.org>; Mon, 11 Jan 2021 21:25:57 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id m12so1484226lfo.7
        for <linux-integrity@vger.kernel.org>; Mon, 11 Jan 2021 21:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g5uedHlyKo0jbM2L3sce03wCRnXD2qBFYgsuv3OnBEg=;
        b=UW8/sx2kLLpEuIdfvLMzlufG1I/pYYtS68HrwLOXy7SlVzmK0to3os2IS9S5XuLD6r
         ipMpxePpLuwuVtDk6vjMFuTchmFSBX3arpGOjL1tp8u4+LKRG0QRk7d2VDdCVjVLGTX3
         5T4XXpPhleATfvckzWdUJMeU3CqD6Rzo1MUQIVwti8j+EoVzpjbV5gw9EarEVR3LIq+h
         ku+8eUl9sJVuF0YeB3QVZN3hlv0ia/of9ymYX8pyu6PG5TBvI+ut2JgAmnYS03wzTekd
         uXg4QYWPAnR5eFZ8UKuu0GV8JqvfZkqwc/zVs1lC1URSy0caPO6yvCz+bfh+T8fag0nz
         KrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g5uedHlyKo0jbM2L3sce03wCRnXD2qBFYgsuv3OnBEg=;
        b=VMAM2hGBCWAB850K1ozqE4ZHdVIhdEQpIz6lD80dKXGNRdRO3N8+SeqDjIO4byDRB7
         yl/1Ll4Xbe56bnroJLun9FzbUgvaS9sEuCCMeB+Kltzifppf/sAW914NAjNIbupzHAgI
         mGVgF7jkBDqfVSw+GiZ03Hy0mmd+Z3wyIPBk0PyZD2DXPipQji1arOr1PC2YgZi2BFFU
         LsAkUJvr208Y+KOOrwHhrOUUhDWG0SKuDACkpD/uOWBKbB4AAzV92J3cSY0+fI6JfZJK
         8f6Wg3QEIyOXM73fjKO75pMAKPgvRYr/uwyg2XDl8s+Bflfy7zeX2jI/b4r7RSNdGm8i
         2/7Q==
X-Gm-Message-State: AOAM531EfvPVp/uoTgcKdLkAb3Ysk4VPZVSLSKsIRAWHgcEMqbzGTN4M
        Y3kUl9elvyVq5F2lXl9astZ1CJhlRGIoeg1yr/XbjMPJBqB0xQ==
X-Google-Smtp-Source: ABdhPJwdCvSoj0NVqGd/o38Bt3FgV7AqZmr2g2AJqttjDsKYBu4JSBt1/um1vqoB30efPOuZGjeqdBgmreRMBC/9RY4=
X-Received: by 2002:a05:6512:30d:: with SMTP id t13mr1367008lfp.84.1610429155640;
 Mon, 11 Jan 2021 21:25:55 -0800 (PST)
MIME-Version: 1.0
References: <20201209164249.715178-1-zohar@linux.ibm.com> <20201211081454.GA5262@kernel.org>
 <CAFA6WYMt5+zX09bdgugSq9SgqF=V_OfOZee8fBEAv1thFLs3nA@mail.gmail.com> <X/pxpAfn4MFsXT4g@kernel.org>
In-Reply-To: <X/pxpAfn4MFsXT4g@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 12 Jan 2021 10:55:44 +0530
Message-ID: <CAFA6WYO0CW3k+OCBV2UqM1-kK6Fm1A6PfNpLCOA6g=mwYRgb2Q@mail.gmail.com>
Subject: Re: [PATCH] doc: trusted-encrypted: updates with TEE as a new trust
 source (update)
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Elaine Palmer <erpalmer@us.ibm.com>,
        George Wilson <gcwilson@us.ibm.com>, zgu@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 10 Jan 2021 at 08:46, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Mon, Jan 04, 2021 at 06:06:33PM +0530, Sumit Garg wrote:
> > Hi Jarkko,
> >
> > On Fri, 11 Dec 2020 at 13:44, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >
> > > On Wed, Dec 09, 2020 at 11:42:49AM -0500, Mimi Zohar wrote:
> > > > From: Elaine Palmer <erpalmer@us.ibm.com>
> > > >
> > > > Update trusted key documentation with additional comparisons between
> > > > discrete TPMs and TEE.
> > > >
> > > > Signed-off-by: Elaine Palmer <erpalmer@us.ibm.com>
> > >
> > > Right, so OP-TEE is not the same as TEE. I did not know this and the
> > > patch set does not underline this.
> > >
> > > I re-checked the patches and none of them say explicitly that OP-TEE
> > > is an application living inside TEE.
> >
> > This patch-set provides a trust source based on generic TEE interface
> > where underlying TEE implementations like OP-TEE (drivers/tee/optee/),
> > AMD TEE (drivers/tee/amdtee/) etc. can easily be hooked up. And this
> > is similar to the TPM interface where underlying TPM implementations
> > like discrete TPM, virtual TPM, firmware TPM etc. can be easily hooked
> > up.
> >
> > >
> > > This essentially means that the backend needs to be renamed as "op_tee".
> > >
> >
> > I don't see any need for this, see above.
>
> Right, TEE is a protocol standard, just like TPM, and OP-TEE is one
> implementation of this interface? I.e. OP-TEE does not define API
> that is hard bound to OP-TEE?
>

Yes, OP-TEE doesn't define a hard bound client interface API. The
client API is based on TEE client API specification [1] from
GlobalPlatform.

[1] http://globalplatform.org/specs-library/tee-client-api-specification/

-Sumit

> Better to ask the very basic questions out and loud to get this
> right.
>
> /Jarkko
