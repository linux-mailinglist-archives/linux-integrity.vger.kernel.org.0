Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097713EABBD
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 22:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhHLUZE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Aug 2021 16:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhHLUZE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Aug 2021 16:25:04 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607D7C061756;
        Thu, 12 Aug 2021 13:24:38 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id x7so12306056ljn.10;
        Thu, 12 Aug 2021 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6CG3o3I+HjKJvVQCGCvX7uWUTwBUdTeFFPnEP1mNbOU=;
        b=Wpu4nN0dPGJA2bxKXYHplUYBA/HUfNFiZ2u/mLl4ej211QNvN2rnk2K8O8/E7MipHt
         y86diSGPDJgw4L/q+vrnUB7k4t1A8yOxHFa1QDOALl8h/JgrIj+V9jJs5RWHBcfquH5I
         JoY2PUPeaFplD1E9dKF6woomwM8T4lMFiOI8Ao4ykmutg2EAf1AoizEk2fTNHgn6ptoq
         IgHwrrQhBj6zNRTjXJbLRaoD3JD5T6FLosjjXek3+XEQR+Itjoayt8+p4USPy/nLsY81
         6nDGYsL1HU8W1bKFCIQepbb53zwQe/DpQ7ZEldhkVdpeD0Bk1jcHdAzny+0YHDpVvdGI
         fmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6CG3o3I+HjKJvVQCGCvX7uWUTwBUdTeFFPnEP1mNbOU=;
        b=Pm/MmMNTHhZlznr2Uw45nJx6BA1SodSwX11yYgGejcXnPC4hK7UuU1B1OFLsgcQYBb
         HZkGZUS4DYkmBFH/GcY6SYhCzioary2scjKZbwWlQ6prLT9Qb8pSTbtggggHTQq4JWYL
         XqJ8T5WZfeXBZZoeJO7iLltgfa79LIXa+BuzuBfdfHdCkDlFl7hU/RZ6XjzQ5j/yEAym
         GRQbOHhgYNXqcVgFlHAxIkcpR0IRzqU+1cIglkBmIN5rY/NKd0/QRzEHbJge0HKaC6GX
         CxPCyWTMAsukWFq34eX5pOwlsnwG8zr4Bwod8BNdfo/9zToTLFNZVpJRZo5G5Wq/0jgT
         zLgg==
X-Gm-Message-State: AOAM533PbFcc1/gGG026w4ed7FNlbbPEZmZgtGsX03BUUuByyceN9+33
        +azw14Ckf8eddU4Fmt+d7RIs8m7j/dyYYBTuE8o=
X-Google-Smtp-Source: ABdhPJy2UDyQ/AosVXJCeCWM9T3GkHE1E/Jnk5mSaw2nbCDkO69pb19DIJR9purQZoJu5X43o/b4qmdacNN5796oqIw=
X-Received: by 2002:a05:651c:1195:: with SMTP id w21mr37394ljo.211.1628799876819;
 Thu, 12 Aug 2021 13:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <db1c1de0-3672-4bae-ef45-c554379f36f4@omp.ru> <d97d7fdb-1676-9670-6cf5-2427f780ec6f@viveris.fr>
In-Reply-To: <d97d7fdb-1676-9670-6cf5-2427f780ec6f@viveris.fr>
From:   Igor Zhbanov <izh1979@gmail.com>
Date:   Thu, 12 Aug 2021 23:24:30 +0300
Message-ID: <CAEUiM9PRv+WhALQb-1im2_oZzAOvWzrMFrgn5xX9sU1K6DJ6+w@mail.gmail.com>
Subject: Re: [PATCH 1/1] NAX LSM: Add initial support support
To:     THOBY Simon <Simon.THOBY@viveris.fr>
Cc:     Igor Zhbanov <i.zhbanov@omp.ru>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

=D1=81=D1=80, 28 =D0=B8=D1=8E=D0=BB. 2021 =D0=B3. =D0=B2 13:19, THOBY Simon=
 <Simon.THOBY@viveris.fr>:
> Nit: considering that allowed_caps_hex is only used in this function, and=
 that it represents a small amount of
> stack space, couldn't you define it directly in the function?
>
> > +             len =3D strlen(allowed_caps_hex);

It is also used as sysctl parameter input buffer in nax_sysctl_table[]
for "allowed_caps" parameter.
