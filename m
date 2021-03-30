Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E771434F3BF
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Mar 2021 23:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhC3VvQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Mar 2021 17:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhC3VvE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Mar 2021 17:51:04 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67095C061574;
        Tue, 30 Mar 2021 14:51:04 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id cx5so8961070qvb.10;
        Tue, 30 Mar 2021 14:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+K4nfDlNqS+buaOaVq0AwqLIJ0qhfMJqcEYS+OVTapc=;
        b=NDqsZVY+29ySsRg/3HK1AA9ORV4ajVk3u617yrGmsZWxFWcoaAYGq23GczTy0umqTH
         zbXaf9OVWiu4k1LhyQJVkrAiM/MoA0COtEgwl/dMRGUTGnDkmq6gwsdcB771g4tFCljH
         kQ3GH6/35vFXENrtuus3SAZ08usNE50+792tG7PfsyK7dvTRmdQeq9MXS0tcx9T0WgYy
         Zsv1nC2/iKlh50dieaiECdA/DZTmSORJRjmK8233DGdyXd7o4kiI9iiTfuxcf38Rpxtt
         Q9Txi/rmBlh5W9mSla1tJWDeLLfKG0USMfQlMXWS74O2US11V9sk26jcukF5Q7gPj5kD
         1IfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+K4nfDlNqS+buaOaVq0AwqLIJ0qhfMJqcEYS+OVTapc=;
        b=KSTZi/AMVFLr18G1q7C23TRYLo3xSiucZ7YkjnaK7etCb4N+R68cWroTmr6LEKUBki
         10YY4A5ov7927g35oPJK+oUP17yMV74y647l52jZJCPWkiQpx7x9jKEAdzrw6JpsduOP
         weSVxTXOBWLR8/ivgCXtbBjrjZY2aOhQrbskWrac3OhGS1lS6g4lNjwAyt4Ad+8se5EW
         P5hsAv2meKfkyRn4RlcmhHUwAiDI/U+qzT2zbg2Y6oNrmr+VUV9B6y4fCEk/3ic/9dji
         AkUCg2KfBwMCYXmZztnh1flpY6fHZXWvwR9MDbBPkkGd7jsWFkwUcmLELAfqJWGerDq7
         33Qw==
X-Gm-Message-State: AOAM5304/aDWEgAG4NKcTpgHTzfusD5x7erYtevhwRcd2WIy/xm5OQYW
        F79lg9EOhly25ZkXcfIN3bX8FAkP6xX0uVSseME=
X-Google-Smtp-Source: ABdhPJyslbdbjpfFB3Lq8Z40X1hr6APZEGUsaFpYs3kEAQ437pGTOonhltLSjPHd1MsDmKhxXgHtxg3plK2vT4EC3XE=
X-Received: by 2002:ad4:57a5:: with SMTP id g5mr215200qvx.60.1617141063684;
 Tue, 30 Mar 2021 14:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <CAFLxGvzWLje+_HFeb+hKNch4U1f5uypVUOuP=QrEPn_JNM+scg@mail.gmail.com> <ca2a7c17-3ed0-e52f-2e2f-c0f8bbe10323@pengutronix.de>
In-Reply-To: <ca2a7c17-3ed0-e52f-2e2f-c0f8bbe10323@pengutronix.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 30 Mar 2021 23:50:52 +0200
Message-ID: <CAFLxGvyj1aZ_3MuxJC6onejchV_6A8WbNR1vTLpSBF5QTxvLyQ@mail.gmail.com>
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

>     TABLE="0 $BLOCKS crypt $ALGO :32:trusted:$KEYNAME 0 $DEV 0 1 allow_discards"
>     echo $TABLE | dmsetup create mydev
>     echo $TABLE | dmsetup load mydev

Do you also plan to add support for this to cryptsetup?

David and I have added (rough) support for our CAAM/DCP based keyrings
to cryptsetup:
https://github.com/sigma-star/cryptsetup/tree/rw/plain

I'm pretty sure with minimal changes it will work with your recent approach too.

-- 
Thanks,
//richard
