Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD5E347196
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Mar 2021 07:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbhCXGYd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Mar 2021 02:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbhCXGYK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Mar 2021 02:24:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C0EC0613DC
        for <linux-integrity@vger.kernel.org>; Tue, 23 Mar 2021 23:24:10 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i26so14387564lfl.1
        for <linux-integrity@vger.kernel.org>; Tue, 23 Mar 2021 23:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=91gjQEIhYRpIwdrlAB3Zu/S2nP17uZud9Feh2dBN07U=;
        b=gNIKNEr3KsNITZziqCwsa5Z7lse71dcG+0BTeE9/Ek71ioXa3pZdVeH0Ll0Wlm9DU7
         KNzaQEGsPdm3N4BHNqwOiFAQiaFvJop8pXRF+G7sBdIYJ1lumkBkllLlDxo2rWXbzgu+
         3vXw57dW2/h1AJAE1pSS5mkVXS/0L/YeDnt6+frkXhNB2+WYiFw2n3Iow13Np6ABmvPJ
         Uza12nOoaGTppCYkwvwjYyafCd/Q7rXiadv3BgZP+Prua7u2145HHe2r3DVYvFWGCeQ7
         IOUccxnxWCOPHtIi4kDIZmm0Zjo4fRvOJrWUxc6I04aXPhhmu2Ti5vWtOZKHTOCpvvEk
         xvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=91gjQEIhYRpIwdrlAB3Zu/S2nP17uZud9Feh2dBN07U=;
        b=jIEPH408kVqZrDoM+txWPuKS6+5nrtHJfwWHzOFTmzEMfPmnzM076ED18UTbUwysPQ
         NNal8DaM4mdPkFt2Q/T6eiW/LTdMYuIAX4OKcOVETdAR4mqM+cmzxJjc0xE7hjQUshvH
         yHGumGzEy9a5rGkxi3d9WsIPbnu500w0ZxvzLsTAvCaqwToQxcO+GY8HTxn96XOiXrtl
         a6rgCBBITw4kVOtjmfY4+QFjUagvBE3a3Pl8iT1GnOWU/AexsAtDYgsBYZ2PLcS+pVWp
         uHGhyXAIj8AGR2jFJMcQOqvGVDCW21eMEOVrkXE6aL/NYCFk+De0fl/qSbYNh3Zc95LR
         pBvg==
X-Gm-Message-State: AOAM532U23Uh3SdyHegXUJV7VavZB9ChONlVqC6XuJ0+T0uH7EAhpnN9
        sqkPa4ncoy+/U4rmk8R0P0+BCuUcM1sOxVmjWtRroA==
X-Google-Smtp-Source: ABdhPJxIIMd/c0aL0BXBbBT8gbEyXiKm+E34v5FP6ythJ1yP+S65b48zqE2oFdc800/mKt6OeYj1gK1sUSIdMN96RGw=
X-Received: by 2002:ac2:5509:: with SMTP id j9mr1035675lfk.302.1616567048746;
 Tue, 23 Mar 2021 23:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <f0f43b30-3dfb-c2a0-7f69-6e5488f871cd@nxp.com> <8b72335f-6ecd-3683-af82-ab5ca96d9528@pengutronix.de>
In-Reply-To: <8b72335f-6ecd-3683-af82-ab5ca96d9528@pengutronix.de>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 24 Mar 2021 11:53:57 +0530
Message-ID: <CAFA6WYPfOuerX0Q5HizARfdYFOQa5gUrpHt7bN9==aaV1Tka9A@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 23 Mar 2021 at 22:04, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Horia,
>
> On 21.03.21 21:01, Horia Geant=C4=83 wrote:
> > On 3/16/2021 7:02 PM, Ahmad Fatoum wrote:
> >> This patch series builds on top of Sumit's rework to have the CAAM as =
yet another
> >> trusted key backend.
> >>
> > Shouldn't the description under TRUSTED_KEYS (in security/keys/Kconfig)
> > be updated to reflect the availability of multiple backends?
>
> This is indeed no longer correct. It also depends on TCG_TPM, which AFAIU
> is not really needed for the new TEE backend.
>
> @Sumit, can you confirm?
>

Yes, that's correct. Let me share a separate patch to fix that.

-Sumit

> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
