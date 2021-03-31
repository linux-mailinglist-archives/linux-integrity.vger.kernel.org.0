Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9E3350678
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Mar 2021 20:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbhCaSgW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 Mar 2021 14:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbhCaSf7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Mar 2021 14:35:59 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE956C061574;
        Wed, 31 Mar 2021 11:35:58 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id 1so14518521qtb.0;
        Wed, 31 Mar 2021 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TnW+eMwf8VjqXvYN2+uEls9zSiM8xbgpZnfblzmT7Rk=;
        b=OXoBi7ZQJeMNsz5QjkZ4wDlks3q4SsHCsdYtaWC8FLARKplDkQ1oZoVeQvXagLweFI
         u2TebfZLjGY3vBcRAqPx4dw4rFPrTV+nNnVvKvl2cVdQnqSYadYbVtvFeqOfZfyASKOS
         NTKWPtJnsqikVv4EVvkNCceKJ6caygF1WpFkWpzYCvhHOBEvxyslKPEZVcah5/lU0+p6
         CwkIJQwb91DR41ylnG5cSt+c21CyHusgkvNlT5Aeb90vB+llYi3Gt1e3mgv8Tg/7Qayl
         C4bSmfEzcsq/0upNzYb+KAC1WcPoRG4GoHU6JNNdp8sZEpveK5txF4k8y5tWpCdw6KRF
         YTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TnW+eMwf8VjqXvYN2+uEls9zSiM8xbgpZnfblzmT7Rk=;
        b=QPNnsUQX+POu+DiXBJYrJeRhA3ogtvR3qwzzcmFYHMi63mfUkQFaSHHttcfWpXeE+f
         njVRYxvit65gC9ktWrNr5ApZqD0BhMiegh3JLm5sE0KfsRLzYkBRk6snIQljx82gXhfk
         kcpar7jKrs7TUeXiiC3fEG9zGJ0WekGZWtThexENJfySJk928eSioHTALJu4sdqmT4/n
         7Cd6gAbVnbsaPPla1h4dm3QwYkSB1QYBoB3cSH3MCTnYclvGl2XW9h3bw7iUnL1rlIaR
         jDiOuXvQS4iQKknU6/GysGgM598F85lYEsrM+C11XdbEzH7u6jyr4aA/HyhGOMARLSQA
         PCDg==
X-Gm-Message-State: AOAM5314C9CU9aj9K2unZvjfpEcPaTqh0URp8x/9TK4TcHYGF7QilcrR
        0NyLp4BOxtnpBhpkUQ2zH+KZSOKYvYQJ52S1Cl7caHDTQDFcPw==
X-Google-Smtp-Source: ABdhPJynmc9icQuVpoLeW7bS+t6PyoRcSmSu5iWuqgMneHOYZDWeCoINSsrVQLU7IH+jMvVb9CuOErd/9Z5ZX29zk5Y=
X-Received: by 2002:ac8:6d2b:: with SMTP id r11mr3644315qtu.245.1617215757388;
 Wed, 31 Mar 2021 11:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de>
In-Reply-To: <319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 31 Mar 2021 20:35:45 +0200
Message-ID: <CAFLxGvwT_y-xxj_81kEyE4X-ydfoPiekTiOeMR1dRP1SpaOh=g@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>, kernel@pengutronix.de,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@penutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Ahmad,

On Tue, Mar 16, 2021 at 6:24 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> +#define KEYMOD "kernel:trusted"

why is the CAAM key modifier hard coded?
I'd love to have way to pass my own modifier.

That way existing blobs can also be used with this implementation.
IIRC the NXP vendor tree uses "SECURE_KEY" as default modifier.

-- 
Thanks,
//richard
