Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AB71FA3CE
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 00:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgFOW60 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jun 2020 18:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOW60 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jun 2020 18:58:26 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD5EC08C5C2
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jun 2020 15:58:25 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l27so19340896ejc.1
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jun 2020 15:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=immT4WkLnda6YfNKYGwHA9yJDk2kiBhS/pGbh2mQjPk=;
        b=osDCo+V4i6RfQ9YW4YDYILIZNvZoI+Ny/6fv///i+0Cnhy882MZDO+KHnTAOtwpO+B
         8yI6URlUs0bSn9QkaXsPwbbmNdxmG6ij3zJdphYY/9THZIEhI/GAHR8mPoy2F+XgrEGX
         9WEiEBPC/MDGSTAKBf4X9BSdo9ksaetEO4mGEOSeVm9jTNDyp6B4D4GXkIcUjNlKSwI1
         J9vAUhCkNsJserK6QmEqWNTwF0OeANvwRlMz8gZbmKZr6MCDbVyWoOxHH8XSmKLisV81
         YV1mmTnHjGeZLvZOasGFl7ftWD0+TM1eJJL4h6eK0pU5ctWBcApr+NqvsEHxmGLiMRh6
         i4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=immT4WkLnda6YfNKYGwHA9yJDk2kiBhS/pGbh2mQjPk=;
        b=TMFK4XcFiTxbJRpkw4eHzWcsywi2mtXE1vTyg36iqZZTonloIqLSw9mdAS/2mVEqms
         2eswLpM8xY/IJfgya2E8wTgYngEExmuLhcyx2xMEZGTxvPlhUzDVjwGdk/jrgpCup6Nh
         mF92bKVIoAQwMXgE7EuBSHqW4IThkk/kEUv8mBiZbUvZ7AyIboCRhP7KUUuEkicEnzCH
         idQngMe0OirtOCq2i1ErkQWwnl2pITqLtmCbulKmhv98MQYUOi53b4A+b4umUiT7lGkU
         WtWN9KHXuwcuNkDVk/R0VrS27stBPNEBbDbH6jCXsY1Y2rrLyLiibdsFGzs3D+IoY4pP
         KLnQ==
X-Gm-Message-State: AOAM531mODAxVlNhlB3yKd0VvJQfl19asETGT22cayVWYZJm0QalfZ5e
        bMPOG8kGEqFun4EJe6q/wGQeP2rsdNErgfa3m8NK
X-Google-Smtp-Source: ABdhPJz59Qp09HBaGGrVxVf2joidqjdaTot5Cni90eRr1tEiWW7ztppOOClTAF7v0Wc9hS6nXdg99/Q7znc2zKHsCjk=
X-Received: by 2002:a17:906:ecef:: with SMTP id qt15mr77860ejb.91.1592261904302;
 Mon, 15 Jun 2020 15:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200611000400.3771-1-nramas@linux.microsoft.com>
 <1591989920.11061.90.camel@linux.ibm.com> <42482562-d74c-2678-069f-1d8ef4feffac@linux.microsoft.com>
 <8800031.dr63W5FlUW@x2>
In-Reply-To: <8800031.dr63W5FlUW@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Jun 2020 18:58:13 -0400
Message-ID: <CAHC9VhT6JSLBD-JMfQbn9eUsUg=juznRz41DTOaia-=WhrAAuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] integrity: Add errno field in audit message
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>, rgb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 15, 2020 at 6:23 PM Steve Grubb <sgrubb@redhat.com> wrote:
> On Friday, June 12, 2020 3:50:14 PM EDT Lakshmi Ramasubramanian wrote:
> > On 6/12/20 12:25 PM, Mimi Zohar wrote:
> > > The idea is a good idea, but you're assuming that "result" is always
> > > errno.  That was probably true originally, but isn't now.  For
> > > example, ima_appraise_measurement() calls xattr_verify(), which
> > > compares the security.ima hash with the calculated file hash.  On
> > > failure, it returns the result of memcmp().  Each and every code path
> > > will need to be checked.
> >
> > Good catch Mimi.
> >
> > Instead of "errno" should we just use "result" and log the value given
> > in the result parameter?
>
> That would likely collide with another field of the same name which is the
> operation's results. If it really is errno, the name is fine. It's generic
> enough that it can be reused on other events if that mattered.

Steve, what is the historical reason why we have both "res" and
"result" for indicating a boolean success/fail?  I'm just curious how
we ended up this way, and who may still be using "result".

-- 
paul moore
www.paul-moore.com
