Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C423B442A
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jun 2021 15:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhFYNOy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Jun 2021 09:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhFYNOx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Jun 2021 09:14:53 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2F4C061574;
        Fri, 25 Jun 2021 06:12:32 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c23so18952509qkc.10;
        Fri, 25 Jun 2021 06:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EtH+YaguYetgfT8kdoojx9dl0VFAOn0Yx63g1VXsJew=;
        b=ibebuR7OhuuvKztdC31VfGhCLFYwF5mP1pV/+hJ3huZCAhmuaKBvXpB1tjgs9IIMr9
         kTpQ++d8sLN88ao1wBevONYfKDcD/mCLTqaTEEQhvwrAgQ6MhQJ66epchgndDQjHyVh5
         Z+Jmv6umAuv435h93xu44fqA9IkyadeNoFp9G+XwLX2Yjil+8Y+IY3CRxsEvxggMxW7D
         JyeF3c2fUUFPtgYf0vfL3g18kIHJRNdH+wSRaileVeU715wrAIbj7N50gz5J9LsMHEPJ
         IYYVngXW/9d46V1Zn8Uqe1SSGNgswJ0er2+QI/NfBav9egxI0h+kZ3RgR2yGNCxjQPDt
         w3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtH+YaguYetgfT8kdoojx9dl0VFAOn0Yx63g1VXsJew=;
        b=U6s6QHm0iM95vfCwde4UlhuLxEAgr20xrNVk+aTStvskBk03xe7Y7t4OhhwIyX7BYk
         0q7FL+TWFYwJ6EylRJ0Uq7eMwzPXZezi9AOoBoMe2RDDpFfvrozpnROLt1+OvSOzNIoV
         MTjCaFs5m2ZsNkdYJ7I12lZdhicbSZ+3s974Hk37g70coQS+laG5+ClW6cmzqhgWcItW
         N9p/Tufvf2C+iqFXAD3pBiIs+t15SNSBmSlKZvYmNoCyFP8QmKht6Bx16+3vpDtX7k5f
         4aDoYklSfSUfVSYJBPquwco+z/gBeavrNLyWOrEK8x0XOk91NYfF7b5+GkVwijSKAQh1
         k6yA==
X-Gm-Message-State: AOAM532riY9QBMDTOnE/JXVi1h29bbBVfBR7ISSWXjlaPiZKASiFFeET
        FJiXs1HoyX7jRIWXJAscgImxEm2uP2po1uv7sFQ=
X-Google-Smtp-Source: ABdhPJwtcJBfZh6+UIt9Kg9D23mEveqk6UdDJLrv+I1aDYiyVGB7RwiNeAuD+xRyfZcD0pFjoPQMpri+pbEPlM5lJ0o=
X-Received: by 2002:a37:e110:: with SMTP id c16mr11117736qkm.237.1624626751519;
 Fri, 25 Jun 2021 06:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210614201620.30451-1-richard@nod.at> <20210614201620.30451-2-richard@nod.at>
 <CAFLxGvyyybqsgXOQ2f2BmpTCnC=7UdWhwnCpGfZMxYuK-AQ-_w@mail.gmail.com> <20210625122848.GA26048@gondor.apana.org.au>
In-Reply-To: <20210625122848.GA26048@gondor.apana.org.au>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 25 Jun 2021 15:12:20 +0200
Message-ID: <CAFLxGvyFy-BWjLF5z2=TaQ+MPEh+Djj3-PSAMArMoquekLWgBQ@mail.gmail.com>
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

On Fri, Jun 25, 2021 at 2:29 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > This patch was judged as not applicable in your patchwork.
> > Is something missing? How can we proceed?
>
> I'm happy to take this patch.  I marked it as not applicable
> mainly because the other two patches didn't have acks and I'm
> not sure if they were meant for the crypto tree or not.

Maybe we have a chicken/egg situation and integrity folks wait for you. ;-)

> Would you like me to take just the first patch?

IMHO all three patches should go through the integrity tree.
Given that you're fine with the first patch, can you please ack it?

-- 
Thanks,
//richard
