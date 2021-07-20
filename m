Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834D03D0360
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jul 2021 22:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbhGTUJh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jul 2021 16:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237970AbhGTT5d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jul 2021 15:57:33 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B608CC061574;
        Tue, 20 Jul 2021 13:38:09 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id w26so469531qto.9;
        Tue, 20 Jul 2021 13:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uhJDEodH1yw/K8SgUN/yQPj6QfswnQRoLXT9NJLX4jQ=;
        b=sRFWu2X/37KyrIRC/Ee0whTh60sAZvseALcf/YWuo+qRJbIthIIrxIXqGT8/Cg/ZPf
         Fdw1KpIYtcigTQbIeHtX3E4CZ5OEUhgAL115aD6/u7h+aPe8V5p9UHEbGP4rs2kDFEd4
         mRocR57sdxdxUmYfo6sCpFbtrgezBweI4aXMEN5cb4xZk4sQuanotjRMJeZvbTLvhw0m
         gL3qYm3ArSrHC9/JWsF904LfdMaJdMIe3VzDDNvNfs+i70jQ9vVbcnZQwcwehn+zyAZw
         QCRljqBwgDSyDS856mlCE9N52P37ao2PIAEd7st+zclyVQ6zz+KfQ3H55fxKEGvO129M
         U0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uhJDEodH1yw/K8SgUN/yQPj6QfswnQRoLXT9NJLX4jQ=;
        b=DJcYDemQgTRbOiLvhKqbQWw6sGyxLsw6qLmWXnmh6PVbTrlOanrLPLcUfsDgtxLBeo
         1Uqgii54RvQ+weldo1FXkaCbkvkgwX6ka6IChmjrwJNRW4AmY1Gepgi+jLTvfBCB1Bbt
         aI0gqPAG8rcpoNo+UYsq7IlCx/QZoBjqk80/He8YeJi8Zmvfu1qq3kJ5+SQxEKfma1hx
         lEYss5rZCRkx9OuOxgj9D+tI+Hadkza2P3aBpSuTfzgPTFIkCxnwJltBEK7WZ2TZvgJi
         Vx9tHL6Kxpr76ZqW5oh+XGhFJ0pr4LUXI8NqcllBoOJ+5XCb/vOzSH6Z6dBed61m7lo7
         Q3Qw==
X-Gm-Message-State: AOAM530aYt9F773KuV6XjA6xVZ7AC0Us4BdGXEr9VW2Qr1ic+BY9D7RD
        hpYs2vBPH6TPD1F5VkymUK34BXD4wIpxGbkjcr0=
X-Google-Smtp-Source: ABdhPJzKbzRuSFMwsIcAKjxgt66Cj/VfmkGl8d6QZc7DgNNxohAaGjry2ZWWegKWeNBoHA+LaSsjHwDAOBK07Fm95Fc=
X-Received: by 2002:a05:622a:138d:: with SMTP id o13mr28072669qtk.245.1626813488854;
 Tue, 20 Jul 2021 13:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1dfbb73645d917b3c76d01290804a3410bd9932e.1624364386.git-series.a.fatoum@pengutronix.de>
 <39e6d65ca5d2a0a35fb71d6c1f85add8ee489a19.1624364386.git-series.a.fatoum@pengutronix.de>
 <1850833581.13438.1625172175436.JavaMail.zimbra@nod.at> <2f608e5a-5a12-6db1-b9bd-a2cd9e3e3671@pengutronix.de>
 <783613027.15909.1625223222889.JavaMail.zimbra@nod.at> <ac8ef66f-4d57-ead0-d1b3-e97220463241@pengutronix.de>
 <CAFLxGvxr94apP2jaT0tB6JRDtv_ivrguXK2Ykd3zer_4xtJ+2w@mail.gmail.com> <40e167cca7b59fc4e11f45ba807486e11eade419.camel@linux.ibm.com>
In-Reply-To: <40e167cca7b59fc4e11f45ba807486e11eade419.camel@linux.ibm.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 20 Jul 2021 22:37:57 +0200
Message-ID: <CAFLxGvyiWLwH30XnD5GxqYX2WduxLC-kK7Non5O5N=up6RswGg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Richard Weinberger <richard@nod.at>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
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

On Tue, Jul 20, 2021 at 10:24 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > I'm not sure how to proceed.  Should I base my changes on this series
> > or do you plan to send an updated
> > version soon?
> > Maybe it makes also sense to base my DCP patch set on yours.
> >
> > Trusted Keys maintainers, what do you prefer?
>
> Jarkko sent an email saying he is on vacation for 2 weeks.   James was
> on vacation as well.   If there is something that needs immediate
> attention, please let me know.

Oh, let them enjoy their well deserved vacation.
There no need to hurry. :-)

-- 
Thanks,
//richard
