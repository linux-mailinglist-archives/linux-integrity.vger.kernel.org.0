Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EED3D021F
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jul 2021 21:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhGTSkf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jul 2021 14:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbhGTSjg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jul 2021 14:39:36 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F374C061574;
        Tue, 20 Jul 2021 12:20:08 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d15so293672qte.13;
        Tue, 20 Jul 2021 12:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zFuzNBIJ3SOuNszQPtdyxiTi9yoIw9/CFgzpID1S2XU=;
        b=gp7M1QghoO41WNBVmXuuTneI1Vq3cIRZrRygM7/0rnzOtNhjGFBpPckaBnDsYpz2/J
         uQOZ9shSUn/+MPbMg3ZzbO2VD77Pt1tcALFBRn12Uwh7wHtAD3sWOhaQYgAUkhDzb2W7
         kV8KK10Wz9W/YsAXeAShXJlQVRowN33Tyd03Nfz2ud3LllXPJ4zFmFhduNExqhAz2UY3
         u6yLQnJWJDZbUsOt+NbQP/V+hM/YYvVt1ycnQJB1oGKnFSLCu4U1MYawVnfCjTl8yQfZ
         g3ixrsadSGTvcu8Wk9XVHeLXMPf9llKChDxC7aW0Zy3pVty51zt6w/HY0j1t12BQGUbs
         b5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zFuzNBIJ3SOuNszQPtdyxiTi9yoIw9/CFgzpID1S2XU=;
        b=BMygT8rqHUeqRWOmwYncvq7du60Vxu8O2yC9xV4Q2jWs9qZNWZUs9YKaFp3YXI8eZK
         MARrgB3XO8nI9grGoRPqUWNLU5E668QUSZy9n0H5gz6pjMbklI9dO2WgKo050wAVKEms
         EyyV0J3YTkSorfvu0GyQ7I/GOijK2CR8Rx8RjVwjNAihCMsbnYv2Xmzc9D3vNXlTZCT6
         RGI/KqhDenBYxrbZ86mJJK/EnwKIdJoJMv0di27S7PvDRWL2dNpu+Mif5QwXQSMeGBRQ
         B3uqoVBltaI3XFnENr0wYhSfSYkTxLb5vsNtYlg+7A1iURCPUnYuGttDQQCjA4g7jCRo
         QXaQ==
X-Gm-Message-State: AOAM532TJ+WFy5yTcu3BsbYnZ9AuULpZnVJZqKqqZSW8fq+NYYD5JrDf
        /1cFA1ZSISJLZJOojq7mXhKaT7X7VMUznuHNn6aigh166l8=
X-Google-Smtp-Source: ABdhPJyjmHyDnctsEMKBkZr9phS/9jJZ60CBbfNFwXeQRHc/Wl9jbZ6ktVF6XY6s6JAzaTOSk28akcrADfNwmOUSenM=
X-Received: by 2002:a05:622a:138d:: with SMTP id o13mr27796695qtk.245.1626808807804;
 Tue, 20 Jul 2021 12:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1dfbb73645d917b3c76d01290804a3410bd9932e.1624364386.git-series.a.fatoum@pengutronix.de>
 <39e6d65ca5d2a0a35fb71d6c1f85add8ee489a19.1624364386.git-series.a.fatoum@pengutronix.de>
 <1850833581.13438.1625172175436.JavaMail.zimbra@nod.at> <2f608e5a-5a12-6db1-b9bd-a2cd9e3e3671@pengutronix.de>
 <783613027.15909.1625223222889.JavaMail.zimbra@nod.at> <ac8ef66f-4d57-ead0-d1b3-e97220463241@pengutronix.de>
In-Reply-To: <ac8ef66f-4d57-ead0-d1b3-e97220463241@pengutronix.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 20 Jul 2021 21:19:56 +0200
Message-ID: <CAFLxGvxr94apP2jaT0tB6JRDtv_ivrguXK2Ykd3zer_4xtJ+2w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Richard Weinberger <richard@nod.at>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        kernel <kernel@pengutronix.de>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        horia geanta <horia.geanta@nxp.com>,
        aymen sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        davem <davem@davemloft.net>, Udit Agarwal <udit.agarwal@nxp.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        david <david@sigma-star.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        "open list, ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 2, 2021 at 2:37 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> > Both is possible. If the string starts with "0x" it needs to be decoded to a
> > 128 bit key. Otherwise it has to be a up to 16 byte string.
>
> Fine by me. Looking forward to your patches. :-)

I'm not sure how to proceed.  Should I base my changes on this series
or do you plan to send an updated
version soon?
Maybe it makes also sense to base my DCP patch set on yours.

Trusted Keys maintainers, what do you prefer?

-- 
Thanks,
//richard
