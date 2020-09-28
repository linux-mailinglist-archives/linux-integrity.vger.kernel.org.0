Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D06D27B640
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 22:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgI1U1R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 16:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgI1U1R (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 16:27:17 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD6AC061755
        for <linux-integrity@vger.kernel.org>; Mon, 28 Sep 2020 13:27:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w7so2202073pfi.4
        for <linux-integrity@vger.kernel.org>; Mon, 28 Sep 2020 13:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y9VwOKQaTKYSQSXUB9gnHqjEsWRXrXah3/4TCXnIoXw=;
        b=gV5coDlrIQ17gA4Bo0ACdNsEgKqVbvtIGM6H17GsHnl5PcSKl62gFhM0L0LIMzWWL0
         8dkZzNLEgND/snMm1CAGO+Of3Z5pICNIgxxxXI/pkp25ljbhZwp11SNyW6j2V9ZGG+1v
         PpgxDaQ06MbPtc4W1JS2bTyiqDp9hiAPLRksw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y9VwOKQaTKYSQSXUB9gnHqjEsWRXrXah3/4TCXnIoXw=;
        b=NmowMXTI4UNvPB4BjYFGBvfgzYFmN8KfFRLw2yd0hdUvEtYQEGJSEtIddqTDZSsMgF
         A1GCis6UHR7ffAQLHquGUTlLG3r8SqXXvtsfFzltTw/PqK3cDBMCJcazpllg/oNXpz0N
         44xYIOPJFn5WPbNVy9d2yhlT/FWe6aGneHwNM7AxN7PbEchCtTvR0jGHowJIvyptrpLR
         s5J85Qo3FFuJApPfaVfDntk6lQlQJ7qzVhYhZw1bu9pxySn/pSmn3An8YssX2+h20Gve
         4LxGQ8wA6zRPrbuoFgLbfGhT2xwyN++9T3noyis/YULYgCi2FcgSKfzhKIHCZMxpgcUt
         0yQA==
X-Gm-Message-State: AOAM533Ny3VWHF8Oc8/XMPr0v1eDmUjBBZVao3hdeLNIX0OMOhWO6lbU
        u7c7EqzD4hUIA1HmZgX9ZL0TlQ==
X-Google-Smtp-Source: ABdhPJyLj1+4q1e6YEvELoFc3RHw21MNrAPdge8+pcvlsRa2WfsV65ArAgxFrZdyNwseEtE5Hu1uNg==
X-Received: by 2002:a05:6a00:792:b029:13c:1611:652d with SMTP id g18-20020a056a000792b029013c1611652dmr958353pfu.13.1601324836465;
        Mon, 28 Sep 2020 13:27:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4200:3be0:5808:e111:eba3:c439? ([2601:647:4200:3be0:5808:e111:eba3:c439])
        by smtp.gmail.com with ESMTPSA id 64sm2613065pfd.7.2020.09.28.13.27.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 13:27:15 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <20200928194745.GB125819@linux.intel.com>
Date:   Mon, 28 Sep 2020 13:27:14 -0700
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, why2jjj.linux@gmail.com,
        zohar@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <18048BE4-2700-4BF9-8959-D024ECF0B704@rubrik.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
 <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
 <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
 <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
 <20200928010835.GD6704@linux.intel.com>
 <1F6A3D58-6B60-4FCB-A629-34CE8813E04C@rubrik.com>
 <20200928141613.GB70098@linux.intel.com>
 <E0629B0C-E49F-4FA1-8DBA-E8CB1EDEFD1A@rubrik.com>
 <20200928194745.GB125819@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On Sep 28, 2020, at 12:47 PM, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>=20
> On Mon, Sep 28, 2020 at 10:49:56AM -0700, Hao Wu wrote:
>> Hi Jarkko,
>>=20
>> =
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3=20
>> Is the one introducing the issue since 4.14. Then the other three =
commits
>> changed the relevant code a bit. Probably you can check the timestamp =
/ release version
>> on each commit to understand the relationship.
>>=20
>> I think the original patch commit message can help you understand the =
root cause.
>> Attaching the commit here for your convenience.
>>=20
>> Thanks
>> Hao
>=20
> Please, again, when you respond quote properly instead of putting your
> response on top. Thank you.
>=20
> Yes, I know the issue and it is already documented also in the James'
> earlier patch that did a similar change. I.e. for some reason some =
TPM's
> (or the bus itself) do not like poking it too often.
Yes, probably. Although the issue James=E2=80=99s patch fixes has the =
same error code,
it is about a different issue which is similar.

> So: what if you revert on using msleep(TPM_TIMEOUT) in
> wait_for_tpm_stat(), i.e. revert to the behaviour before the
> aformentioned commit?
I believe that should resolve the issue as well

Thanks
Hao





