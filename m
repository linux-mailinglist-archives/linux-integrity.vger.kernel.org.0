Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679CC34F3F1
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Mar 2021 00:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhC3WEp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Mar 2021 18:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhC3WEa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Mar 2021 18:04:30 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC600C061574;
        Tue, 30 Mar 2021 15:04:29 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g15so17462199qkl.4;
        Tue, 30 Mar 2021 15:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rsLcyiUdjDO/JwPlLGDRZPqtjPzq/FefLI/0r769QmU=;
        b=fnuxO4RjIrvHDZ5iK/ytdE3WACshx3AxcJyhSkUNgT5Y1FXc3gOgTDdoJHClzNggxh
         iBcHnl50i/gHSU03HQHZcr2at0f8vJWJC2ryWdkE/legp7YM+7Cc+w4qIw2ze7JvdgS8
         kr4xPTw9Q6xckiwKtC0aSq7ixuiTlyvMuV8hjkJ1BjMKVggsEVmv5luUT0Cn8YZgK6nI
         4z5cjIBXh6Fy5c81Do2qyeUharaKX0PPoD2uCClNIjW7dgU2X3eeOiqyqIRzdmzP6+eP
         HVWAut/yxf7qZBNvpQthz9Abq+MqEixM2r0eskkznkRJOYfnrgMHPhBYpL+NTCz7W1VX
         OzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsLcyiUdjDO/JwPlLGDRZPqtjPzq/FefLI/0r769QmU=;
        b=MuPOq0qhzQHV2vY3kHuzhum1pa+kZs2s1gHlXDQAuPsS0v3cxIZMpwlN4GbNViSS5I
         Pj8GqO4dm9MyuKOJVCSaI/Y7DmrOpRAYK1ZycpeYifwSju0yNae9GyveEcSiDp1Z0ODR
         OxA4MVWTsylZLbifmP/vtJ/T9u+nkuiJUFI/DdDdFSkrmbVJGi3ujH/qk+UhHgtf/UFO
         U89b2f4c0JwiRruHiGRtDhY4YE5esabKT9/R6laCiW+HEp2O+zzjtYVou8MZ1Bzke3OJ
         xJ8DhtmEH5I+Hnnc9CManyzGvznshg9fcr6NbzyRYDNjS2Y+qQIAjIHsN6kaTj+xulAt
         hE7w==
X-Gm-Message-State: AOAM5309oLqb2f5yCkWpDqdm8mKXG9wv9psNMq/rdJEcRaVKVBMDmuEE
        5AiWaEUnJbwKQSgsxU+n98pVJIJBitIz9x7OVs4=
X-Google-Smtp-Source: ABdhPJzDPkf/1Aa4r0AHY7myn8WGS18l9zpACXjvhATeiELfuLBPTtt7chiH9HTWcsTFt6EdhCgi+k0trKe9U+QYL30=
X-Received: by 2002:a05:620a:14ae:: with SMTP id x14mr364123qkj.237.1617141869090;
 Tue, 30 Mar 2021 15:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <CAFLxGvzWLje+_HFeb+hKNch4U1f5uypVUOuP=QrEPn_JNM+scg@mail.gmail.com> <ca2a7c17-3ed0-e52f-2e2f-c0f8bbe10323@pengutronix.de>
In-Reply-To: <ca2a7c17-3ed0-e52f-2e2f-c0f8bbe10323@pengutronix.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 31 Mar 2021 00:04:17 +0200
Message-ID: <CAFLxGvwNomKOo3mQLMxYGDA8T8zN=Szpo2q5jrp4D1CaMHydWA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>, kernel@pengutronix.de,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Ahmad,

On Wed, Mar 17, 2021 at 3:08 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>     keyctl add trusted $KEYNAME "load $(cat ~/kmk.blob)" @s

Is there a reason why we can't pass the desired backend name in the
trusted key parameters?
e.g.
keyctl add trusted $KEYNAME "backendtype caam load $(cat ~/kmk.blob)" @s

-- 
Thanks,
//richard
