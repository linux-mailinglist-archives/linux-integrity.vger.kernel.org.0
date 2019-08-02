Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD0F802FC
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2019 00:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392527AbfHBWuu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Aug 2019 18:50:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46921 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbfHBWuu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Aug 2019 18:50:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id c3so13580652pfa.13
        for <linux-integrity@vger.kernel.org>; Fri, 02 Aug 2019 15:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=sXQ0BKzSp5Bptj9KeGCTuwE2we871dDx6C7SldYlGLw=;
        b=TS9vAWJI7uCOK3lIDDY06BHC2SU9jVPvgGZh7ucSu1sPJkLeahqYiuIv9WsuM9tIhO
         eu43t4v19IQjoosdxhPYVAdhJnI6xkDmRO4boUEedx5RIjIH8HaCS4NaZ8+BzQlJpojR
         R5IfJBexqJsJ6dAeReSg6ssv8fBlHY+RM7MXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=sXQ0BKzSp5Bptj9KeGCTuwE2we871dDx6C7SldYlGLw=;
        b=cF9D82FH6WkVZO3nimUT1AucAJkvN/tZKXhDG/bR+kLE4sD3ItLrh2lc+vZwDYldtW
         RIQkVkxOsERnF63ZXPqrQCIVdITIGZL/kwb/pYtDmPI79N/Fz/+MROxpkOxyF4MqrKZA
         rTCb9+mMrEkFMcviE2ubz0AEsKaiuBmQf42ajAuIPtierY2/CrC8TFfU5WWnNuBHaonH
         3k3I00qut1h4UWMxN8Jnkrey99vQkgFE3PM3g9Z2ekxsfAGF3IWDaj4rlhZm6tcXBwlK
         UItOikdAMRY529kkXqNOThBimrLU02CQuI68Wqld6mM3/a1ZrRl7GN2YMXndGbLOLZyU
         iYZA==
X-Gm-Message-State: APjAAAU8YmZ32ZBnk9wBZSyGIk9II2riK0rCdcnHYNIh7ONeUePwB7av
        Pwm3povWLtx+vQbDnREAtTsiRw==
X-Google-Smtp-Source: APXvYqyoiPnSF1BqK7yJw4hJLDH4R41i/VJWmhEUS/PRtoalaM4/f8sPwAojO9sGngCZ9vk5FcfxdQ==
X-Received: by 2002:a65:6093:: with SMTP id t19mr46551080pgu.79.1564786249619;
        Fri, 02 Aug 2019 15:50:49 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 143sm117330886pgc.6.2019.08.02.15.50.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 15:50:49 -0700 (PDT)
Message-ID: <5d44be49.1c69fb81.8078a.4d08@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5d2f54db.1c69fb81.5720c.dc05@mx.google.com>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-2-swboyd@chromium.org> <20190717113956.GA12119@ziepe.ca> <5d2f4ff9.1c69fb81.3c314.ab00@mx.google.com> <20190717165011.GI12119@ziepe.ca> <5d2f54db.1c69fb81.5720c.dc05@mx.google.com>
Subject: Re: [PATCH v2 1/6] hwrng: core: Freeze khwrng thread during suspend
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
To:     Jason Gunthorpe <jgg@ziepe.ca>
User-Agent: alot/0.8.1
Date:   Fri, 02 Aug 2019 15:50:48 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Stephen Boyd (2019-07-17 10:03:22)
> Quoting Jason Gunthorpe (2019-07-17 09:50:11)
> > On Wed, Jul 17, 2019 at 09:42:32AM -0700, Stephen Boyd wrote:
>=20
> Yes. That's exactly my point. A hwrng that's suspended will fail here
> and it's better to just not try until it's guaranteed to have resumed.
>=20
> >=20
> > It just seems weird to do this, what about all the other tpm API
> > users? Do they have a racy problem with suspend too?
>=20
> I haven't looked at them. Are they being called from suspend/resume
> paths? I don't think anything for the userspace API can be a problem
> because those tasks are all frozen. The only problem would be some
> kernel internal API that TPM API exposes. I did a quick grep and I see
> things like IMA or the trusted keys APIs that might need a closer look.
>=20
> Either way, trying to hold off a TPM operation from the TPM API when
> we're suspended isn't really possible. If something like IMA needs to
> get TPM data from deep suspend path and it fails because the device is
> suspended, all we can do is return an error from TPM APIs and hope the
> caller can recover. The fix is probably going to be to change the code
> to not call into the TPM API until the hardware has resumed by avoiding
> doing anything with the TPM until resume is over. So we're at best able
> to make same sort of band-aid here in the TPM API where all we can do is
> say -EAGAIN but we can't tell the caller when to try again.
>=20

Andrey talked to me a little about this today. Andrey would prefer we
don't just let the TPM go into a wonky state if it's used during
suspend/resume so that it can stay resilient to errors. Sounds OK to me,
but my point still stands that we need to fix the callers.

I'll resurrect the IS_SUSPENDED flag and make it set generically by the
tpm_pm_suspend() and tpm_pm_resume() functions and then spit out a big
WARN_ON() and return an error value like -EAGAIN if the TPM functions
are called when the TPM is suspended. I hope we don't hit the warning
message, but if we do then at least we can track it down rather quickly
and figure out how to fix the caller instead of just silently returning
-EAGAIN and hoping for that to be visible to the user.

This patch will still be required to avoid the WARN message, so I'll
resend with the Cc to crypto list so it can be picked up.

