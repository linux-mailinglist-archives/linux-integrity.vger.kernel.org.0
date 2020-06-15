Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD661F9658
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2020 14:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgFOMP0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jun 2020 08:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbgFOMPY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jun 2020 08:15:24 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E0EC061A0E;
        Mon, 15 Jun 2020 05:15:24 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a137so15671678oii.3;
        Mon, 15 Jun 2020 05:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYfeN+lomf5loXuUSsePWE7mRHJpvA/I4T/5bpNYLAY=;
        b=T4AGUVXndhnCDxHQKxLQEEIc7ZokeMONi82ra0kiJCuQXe9+11agB7ic0ynPmiAoSb
         YidIatx5FjuebJ9yH5fabmkbLzPM+66rbekkPAMm+rocOnEtGC0tqhKCRbibxP78oO8O
         nglHx6uNc6cPOTSvevCrGFEgn98bPyInJoHeLkTMagnFAno4QsEqJ/H06FEGAYr/d9IM
         2guwwi62J8i82MhHKColWTGHiRz3R0EJgpE4xCg3U/x8m0DGrSl9Q9jbFzuju49YurpP
         pG3X7Gdr5W+6C4bKny6xvD4XZIYR2T6lVZJcgdRrCxwHe1yMkwfOT9BMi+EQ5CJxNtHB
         87pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYfeN+lomf5loXuUSsePWE7mRHJpvA/I4T/5bpNYLAY=;
        b=EpJPYeHb9cRA4EvAVOsTIBst+Zreq+VSd2mAi1j05lkbs763B+ngqYpDo5hyQVfObJ
         fA2Pz0b0nBzZlq38vWV//yNA09hJqgBUuByvafpN3VzIC3e+bCwQk4YBanEJECLlLf6D
         01P91GpXbr8hTgp5brQ86a1fwRDUpYtmtFOT5Jz2sSMwI5JQdaIdgdzL6yl37wFo2yeo
         np2zeQwXpOLP2ZB6kShM4UUlLtlVCR9U0ar6aDQGeXWhn8atS5wEtySfLhc70ebt0+dP
         wq1qOMBgaMsuhLIvB+KqUSua/qpcTTY1f3AFhLac8uQDgwmQIarQc4Vetw6jh6DYLbLf
         3Dag==
X-Gm-Message-State: AOAM533SbwHbCLin1jLhT0Eld5FBVPilX3qsbh/Cg1/QRW9yyjub6fKo
        XPuy5dV+pQHJ71BOtZhORNhA1E5j5/XJxnC0MqI=
X-Google-Smtp-Source: ABdhPJztOxHdnvbh3si4JN5xzx3gZccaRMhjgkbZe5bLxwDBW5pTkhmE9ShDj0Bv2mq7su7RD+R2Vcb9E9HVjBArfU4=
X-Received: by 2002:aca:ec97:: with SMTP id k145mr8317724oih.92.1592223323851;
 Mon, 15 Jun 2020 05:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200613024130.3356-1-nramas@linux.microsoft.com>
 <20200613024130.3356-5-nramas@linux.microsoft.com> <CAEjxPJ49UaZc9pc-+VN8Cx8rcdrjD6NMoLOO_zqENezobmfwVA@mail.gmail.com>
In-Reply-To: <CAEjxPJ49UaZc9pc-+VN8Cx8rcdrjD6NMoLOO_zqENezobmfwVA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 15 Jun 2020 08:15:13 -0400
Message-ID: <CAEjxPJ4MMjGGMy5b5pFfdZ=mUiBMv4M558Kwdu_VG8OOCU_aUA@mail.gmail.com>
Subject: Re: [PATCH 4/5] LSM: Define SELinux function to measure security state
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Smalley <stephen.smalley@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 15, 2020 at 7:57 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> I think I mentioned this on a previous version of these patches, but I
> would recommend including more than just the enabled and enforcing
> states in your measurement.  Other low-hanging fruit would be the
> other selinux_state booleans (checkreqprot, initialized,
> policycap[0..__POLICYDB_CAPABILITY_MAX]).  Going a bit further one
> could take a hash of the loaded policy by using security_read_policy()

On second thought, you probably a variant of security_read_policy()
since it would be a kernel-internal allocation and thus shouldn't use
vmalloc_user().

> and then computing a hash using whatever hash ima prefers over the
> returned data,len pair.  You likely also need to think about how to
> allow future extensibility of the state in a backward-compatible
> manner, so that future additions do not immediately break systems
> relying on older measurements.
