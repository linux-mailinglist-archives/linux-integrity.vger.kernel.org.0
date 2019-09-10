Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA23AAE338
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2019 07:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfIJFNm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Sep 2019 01:13:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43621 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390663AbfIJFNm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Sep 2019 01:13:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id q27so12345401lfo.10
        for <linux-integrity@vger.kernel.org>; Mon, 09 Sep 2019 22:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbhnljMSvrm4Eb/KXzc+RpovBmrskcbXiFtPe30EOeo=;
        b=dDI98vuEiKdWP044Aq60Rfs0oVNhOMLnqb+v8cd/nTLiWGWoxrC7bK0bJlXRGRLBWl
         OkruDqTbEF1MnjTQ6LzIql/IbBNIRZemt+ZekjNNAlLCnGNGHw5R6WdjyzVFf7CGPDVc
         PsMjA2VoJvMCymcb6foSlZXXaG72LlL1wV+1USmkdEO44wBORSJ+x4HP2Gw4+GFOsUZt
         fxW7SavC5G3u0iF5rRcCYdV5Y2tOpnk2HcgI8z1MIdSdwNbdHxSWBlmCEpsTYA4hx5vI
         57rqDjmabd8C+dThEAzBiAJgAUCE0u+iGYrXDMHwb7xoTfjlax833P1oVLn6rP0yifyl
         jZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbhnljMSvrm4Eb/KXzc+RpovBmrskcbXiFtPe30EOeo=;
        b=dJpM3ED8+S/07y9QCrUgKT4M63JM/RzSJHX67nFEJD/M670uLz6ntMDkt+uGzn3AQy
         x+HQnLebnUtbmbFtfCvFgx866LaZ+edfWHYyKybN3F6kc0leNCnt90XEYOOv84g+m2ei
         +9wJRqJCcArxL6aX6HFDEWC2ndDoIwN4D8FI9ZspYz+TMEn+PGSxwVge3mgvcMVmF70g
         mgZPkYtA1Ag/8WRhFNVltXoC9mDLWWu8jxVSoJyK9EenZ/6P9UhXfJd1eUCCoxLyAPm1
         yEo4NW44B7wzHdowFmZYJCNu0FUeRp8Kfv6pBDW5Jh9T0uUYcFDm5nWlZi6+zgzJZA3s
         aPKw==
X-Gm-Message-State: APjAAAUQxHXVbWbuKW3KV6vHipJjuv9tdF5gRBM7MpGkV2iF/kjEEN70
        eEqjT7xBW7xLonMy1zOWH+lRg9vDsPMKahGP9Wjagw==
X-Google-Smtp-Source: APXvYqyu4qmBvYdKY60qaEbXVW0h3uzrHlcJ4EuNULoC/qTrXN/8mpok0DsyaFuatghwy6m3s6/T0/Rwhw152lylZqY=
X-Received: by 2002:a19:f806:: with SMTP id a6mr18607616lff.151.1568092420328;
 Mon, 09 Sep 2019 22:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <c253ca7292b397f1352d2ee00fce0b011f84abff.camel@linux.intel.com>
 <1567952431.4614.140.camel@linux.ibm.com> <CAFA6WYPq8Tq6=jTqnWQf9w9pzdJu8AcX-CFBWPwoVmMaLEJKhg@mail.gmail.com>
 <20190909163643.qxmzpcggi567hmhv@linux.intel.com>
In-Reply-To: <20190909163643.qxmzpcggi567hmhv@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 10 Sep 2019 10:43:27 +0530
Message-ID: <CAFA6WYP6enHJBSsgzvTqzFEQwaW3ye2NrdnaxDMRCS1BC8mpsw@mail.gmail.com>
Subject: Re: KEYS-TRUSTED git
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 9 Sep 2019 at 22:06, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Sep 09, 2019 at 11:57:45AM +0530, Sumit Garg wrote:
> > For Trusted Execution Environment (TEE) as a new "trust" method, I
> > have tried to document it here [1]. Please share your thoughts on this
> > patch [1] in case I missed something. I would be happy to incorporate
> > your feedback. Also, can you elaborate on "comparison to the TPM",
> > what specifics parameters are you looking for documentation?
>
> I think the right order is actually:
>
> 1. Set up the GIT tree.
> 2. Merge your TEE patches (when they pass the review phase).
> 3. Come up with the documentation.

Sounds good to me.

-Sumit

>
> /Jarkko
