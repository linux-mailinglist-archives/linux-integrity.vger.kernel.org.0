Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE90EE61C
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2019 18:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfKDRhR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Nov 2019 12:37:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54034 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728174AbfKDRhR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Nov 2019 12:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572889036;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z9/WWV13X4e4aLPiYLwGw/JAHlCpLQuQR6U/XeyPSwg=;
        b=hpuKiy5hIE/BdriQqVe3vUA/UsvP7Txm7ulQ3MFPe+ebB4HVvEUcQLSYaw1+p9lbjABHWM
        9gK1ezv65TtS7MqI5XubRtR12iLkYMD64MwOr2rinJMPT6Vm54K1XSXLfHP98pTdC+P3wH
        lJQrCv5n0OwZqJ2A1XTAjdwh6p7JSNA=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-8ED-DuyTOViyHxc2Yw-0QQ-1; Mon, 04 Nov 2019 12:37:13 -0500
Received: by mail-yb1-f198.google.com with SMTP id t33so13691479ybt.20
        for <linux-integrity@vger.kernel.org>; Mon, 04 Nov 2019 09:37:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=JQEv/C96T+1x0nDTrvMbqa8N2Mf37mdnVCii5ECDYog=;
        b=k43IX0Ox2FcYePxCAqYDlJNJyX6kHlgcVMzs4pLtbCEGHghD7bv0Wq7VnzctR/SBZ0
         4nhSUXs9geuLsQ383l5cAosV0kJI+0yc/z3PUb3pDPoujjHjnDXIQNWqVG4CLrxXKFc3
         A7l/uJndRMKlOi7aHzoouLQBalyGkOPQ79UpnXgRAhWYBkkzmedjTm1G4XY7PhlKdDWw
         10rMi2WyrXdcaUcAIxlaYxC5x7lpTdkgSTjc4U+ziPBpHfoTdG5/Oh72vEqNkIA+In+R
         nxkWfxud6u9mcX3ir+CAg/i0bGCmlDCB27JPxLEjWT/Klu1v5YeyrgliSzpuow7ydlR+
         IQAg==
X-Gm-Message-State: APjAAAVb51w/RxXQJCc+m85yCXXTmU8huszZtO9M96WTYPC/b5PwrvaC
        2FVOsbaeRSNxKNKnVs/CfQxS2eKpZD8bIHmN9M10Yw75eKMD5TElxHjTVaDQUm9li2ApLLfcFvo
        IVbhBTpy/twmjFQ3IXbcXPvkegam5
X-Received: by 2002:a25:41d6:: with SMTP id o205mr12062751yba.412.1572889032864;
        Mon, 04 Nov 2019 09:37:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqwHnt+IfU55hSoZ+vkR0Q3MLgHUgP5ZNaKfym+7yXcB5jwUVaCk/+9wFVcU6Re4Gm5D15/Zxg==
X-Received: by 2002:a25:41d6:: with SMTP id o205mr12062731yba.412.1572889032417;
        Mon, 04 Nov 2019 09:37:12 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id g24sm6018316ywk.94.2019.11.04.09.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 09:37:11 -0800 (PST)
Date:   Mon, 4 Nov 2019 10:37:09 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, tglx@linutronix.de,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH] tpm: remove tpm_dev_wq_lock
Message-ID: <20191104173709.qqmdiacytyimbqhx@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20190211105835.16851-1-bigeasy@linutronix.de>
 <20190211141145.GD8431@linux.intel.com>
 <20191010160313.pdf6ue4r2intbgoh@linutronix.de>
 <20191014193942.GH15552@linux.intel.com>
 <20191028202419.GA7214@linux.intel.com>
 <20191028202637.GB7214@linux.intel.com>
 <20191104143957.onsfuvmwfuvmfuu6@linutronix.de>
MIME-Version: 1.0
In-Reply-To: <20191104143957.onsfuvmwfuvmfuu6@linutronix.de>
X-MC-Unique: 8ED-DuyTOViyHxc2Yw-0QQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon Nov 04 19, Sebastian Andrzej Siewior wrote:
>sorry for that late reply, was traveling=E2=80=A6
>
>On 2019-10-28 22:26:37 [+0200], Jarkko Sakkinen wrote:
>> > OK, so. Gave a relook at this:
>> >
>> > This gives checkpatch.pl error:
>> >
>> > 0012-tpm-remove-tpm_dev_wq_lock.patch
>> > -------------------------------------
>> > ERROR: Please use git commit description style 'commit <12+ chars of s=
ha1> ("<title line>")' - ie: 'commit 9e1b74a63f77 ("tpm: add support for no=
nblocking operation")'
>> > #8:
>> >   9e1b74a63f776 ("tpm: add support for nonblocking operation")
>> >
>> > total: 1 errors, 0 warnings, 7 lines checked
>> >
>> > NOTE: For some of the reported defects, checkpatch may be able to
>> >       mechanically convert to the typical style using --fix or --fix-i=
nplace.
>> >
>> > Please send me a new patch with a legit fixes line. It is a fix to
>> > regression even if it is a cosmetic one.
>> >
>> > I'll drop the current patch from my tree and apply a new one once
>> > I get it from you.
>
>Can you please explain what is wrong with that one? It is exactly as
>suggested by the error line.
>
>> > Thanks.
>> >
>> > /Jarkko
>>
>> AFAIK cc stable triggers stable backport, not fixes line alone (not
>> 100% sure about this though). Anyway even my original response was
>> meant to this patch I recall now that I bumped into that checkpatch
>> error.
>
>The cc: for stable and fixes are high indicators for it to be
>considered. These days even a few keywords in the commit message might
>let Sasha's script decide to pick/suggest a patch for stable.
>
>> /Jarkko
>
>Sebastian

It looks like checkpatch is expecting the word commit to precede the hash o=
n the same line.
I get no errors with the following:

Added in

   commit 9e1b74a63f776 ("tpm: add support for nonblocking operation")

but never actually used it.

Fixes: 9e1b74a63f776 ("tpm: add support for nonblocking operation")
Cc: Philip Tricca <philip.b.tricca@intel.com>
Cc: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

