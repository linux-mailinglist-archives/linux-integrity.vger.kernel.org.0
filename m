Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7183D3B430E
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jun 2021 14:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFYMXv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Jun 2021 08:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhFYMXu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Jun 2021 08:23:50 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE956C061574;
        Fri, 25 Jun 2021 05:21:28 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id bj15so18777906qkb.11;
        Fri, 25 Jun 2021 05:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4Q8/3z6OXZZ/9ZPmsJ32/nlpjgIm8YhI1f+Jp/7/2Y=;
        b=WL+io1HK1tNOQKxbIBVMbIy/T9/bxFpeWFQvqPXHqNMk5T4+AzsEpeX0jFWiv9/8JZ
         jZtyRkg67eHuVI9mrtSDtLdoKttYBAd0QtM+kiimuZXFrImzRoEIj4tiiCiZuZWVK3at
         /2AQyUybsp5Wvx+iUGQt65JBdrZ4UBQ+4YsR+UmhadndSpBw46mHRT+rxy1HlaLvPWmD
         lk6c6KCfWGhg9b0ALrbaPrmS5kl3oyUk15k5Q/4T2sPvGaUwZXqkpGQrqPVjsMUrl/VF
         Aw166696i0P9ahVNEqPGnX1zw3YB7HbKbk5AxMmT1p/qUnAHnZvv8Rqr9wjh4N2KBZsq
         nGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4Q8/3z6OXZZ/9ZPmsJ32/nlpjgIm8YhI1f+Jp/7/2Y=;
        b=WjZGKOXbtkk5rE2Y2IKfbJsfDPIN/ldzTISdruO8cG3RyD17bJAyWfW9edo8AEraH0
         kaw0QpwNmWix8L27DV361ejsLmQIfFpIYpN+oEpXdZfcMJZCjSqITf2MEyzQsRPAIXm9
         fExhZCzFG5UXWbE0NjgA+2JYP0HBJDaQgmAU2T6DooLqea14spAiNjkX13liEiiHwE81
         zG30yGzrsuod9TptlCZxurR8ymXE5HFrl+w/D2nxIA+H4kc/jqi6Xe0LMVw3zgtpVLt5
         p3nj5ARdAZBvoi3nr+kIZZ2Gs4JHYhG5IKGyq3j5wBdcNvP8WqAephuzQcmmWQSWQFCR
         tulA==
X-Gm-Message-State: AOAM531/3NqTRrJ4mGhGn+HTaPbkbMT3tVE28fBRbtm6RIhuxduDrK7V
        mXdBU/59lTOjjeMhMFQlm8I2Rpslmwb6KEVJ74Y=
X-Google-Smtp-Source: ABdhPJx/f94SRCZdAiHGi/ly1dG35ye7G0aXHvgj8OgWk+mDDpVCnednOPUsuVtmlcQHWovAMDoeKz0kkOsoi5QKHGA=
X-Received: by 2002:a37:9005:: with SMTP id s5mr10980983qkd.108.1624623687811;
 Fri, 25 Jun 2021 05:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210614201620.30451-1-richard@nod.at> <20210614201620.30451-2-richard@nod.at>
In-Reply-To: <20210614201620.30451-2-richard@nod.at>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 25 Jun 2021 14:21:16 +0200
Message-ID: <CAFLxGvyyybqsgXOQ2f2BmpTCnC=7UdWhwnCpGfZMxYuK-AQ-_w@mail.gmail.com>
Subject: Re: [PATCH 1/3] crypto: mxs-dcp: Add support for hardware provided keys
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     keyrings@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Fabio Estevam <festevam@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Herbert,

On Mon, Jun 14, 2021 at 10:18 PM Richard Weinberger <richard@nod.at> wrote:
>
> DCP is capable to performing AES with hardware-bound keys.
> These keys are not stored in main memory and are therefore not directly
> accessible by the operating system.
>
> So instead of feeding the key into DCP, we need to place a
> reference to such a key before initiating the crypto operation.
> Keys are referenced by a one byte identifiers.
>
> DCP supports 6 different keys: 4 slots in the secure memory area,
> a one time programmable key which can be burnt via on-chip fuses
> and an unique device key.
>
> Using these keys is restricted to in-kernel users that use them as building
> block for other crypto tools such as trusted keys. Allowing userspace
> (e.g. via AF_ALG) to use these keys to crypt or decrypt data is a security
> risk, because there is no access control mechanism.
>
> Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Cc: David Gstir <david@sigma-star.at>
> Cc: David Howells <dhowells@redhat.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: James Bottomley <jejb@linux.ibm.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: keyrings@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Co-developed-by: David Gstir <david@sigma-star.at>
> Signed-off-by: David Gstir <david@sigma-star.at>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  drivers/crypto/mxs-dcp.c | 110 ++++++++++++++++++++++++++++++++++-----
>  include/linux/mxs-dcp.h  |  19 +++++++
>  2 files changed, 117 insertions(+), 12 deletions(-)
>  create mode 100644 include/linux/mxs-dcp.h

This patch was judged as not applicable in your patchwork.
Is something missing? How can we proceed?

-- 
Thanks,
//richard
