Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8408AED993
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2019 07:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfKDG7C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Nov 2019 01:59:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36961 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfKDG7B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Nov 2019 01:59:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id v2so16303606lji.4
        for <linux-integrity@vger.kernel.org>; Sun, 03 Nov 2019 22:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ef40HtgLagkWmNMc93ySVU+8+raGbvhremm/3vIkPJs=;
        b=vvdCJc1RINMcL5JoJz312DaAniIDfMzCcnwAI/nzlhioj8GGGYgW5khIKfb5WKPoih
         qMp+vCbDbemdWq8i0Mf58v3uh/mu8EhKBMgRhulZLShXtK+MNVeAUm7PQ2aQiAtYd/+j
         Jg6nmlI9XTaqFYG/d/qIJDVf1ikfm6/i0iK1k912esWDVF1151DSFoBkdr1dAOlWvfmC
         jsn+40LPewRJA3SIUnwPlyony4u564JLgwa29HfMy3fBdaUY2d1amOC0D3N4Y4FXSyEs
         uXfrP9qkdne00KhZwEYKvXolsJ2gV5a0/Mi5PvdRJEwJ90Nr/tnHijeE3ql/YqVMQM1K
         AvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ef40HtgLagkWmNMc93ySVU+8+raGbvhremm/3vIkPJs=;
        b=SH3U7ysPK3uKM7V1MN8jnXxEJS2bUY4JCkf+xR4RwHqZ4qSvhnrWGr7LoChz0cfqoB
         wzE7etsXBg1f8rLqoD5/jYnsrbg9LEcXrbJlIYRyM37g5t/fBHpKkZtcwN6Ix7QY48bx
         nG6aWXUbJi5KtEKQD+Ll00z0suNGjnbhL5tttR0IHDzgEgOudm4vjB/FsKxxLLQM0rJ+
         DJoqVMVpndQF0q253Qq4un8Uz4795tji+CpdMrX669LJ25f+iznBM/PSB9Odd/uqW5MS
         uOi7ftMBS8uwpo+WtIFfrF7BlYsN/ySpzo8/ewiUJn7ycU5btkkNMJThFiasL0TBiOpm
         O4rQ==
X-Gm-Message-State: APjAAAVEuWkVLTJnXPeM5S5ZsKG5FOZsIehf/l7TELvOgTYmqMy1xT+j
        gGmenNV/CP5TRILLmJvBDJ7Kg1ogBTXZzkc/JUagMQ==
X-Google-Smtp-Source: APXvYqwDEcaV1wOC5X14ad1vPw2VW4B5zXbZYrai12akzfGxkCIeR+UrJYYWYChUz2q1aw4cIzuU9bUsn4PO7ZkCq3g=
X-Received: by 2002:a2e:9a12:: with SMTP id o18mr9966567lji.191.1572850738786;
 Sun, 03 Nov 2019 22:58:58 -0800 (PST)
MIME-Version: 1.0
References: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
 <1572530323-14802-7-git-send-email-sumit.garg@linaro.org> <20191031214745.GG10507@linux.intel.com>
 <CAFA6WYMkE928v-v76gGtWmsS0PwRp-OHUtkS0+Ts4V6x0AKBqQ@mail.gmail.com> <20191101201957.GA8369@linux.intel.com>
In-Reply-To: <20191101201957.GA8369@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 4 Nov 2019 12:28:47 +0530
Message-ID: <CAFA6WYNwSSaZv5OM=q+LCyn0mEdpg7K+W_v2_NBHhtktg1BFXw@mail.gmail.com>
Subject: Re: [Patch v3 6/7] doc: keys: Document usage of TEE based Trusted Keys
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>, dhowells@redhat.com,
        Jonathan Corbet <corbet@lwn.net>, jejb@linux.ibm.com,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Stuart Yoder <stuart.yoder@arm.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2 Nov 2019 at 01:50, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Nov 01, 2019 at 03:04:18PM +0530, Sumit Garg wrote:
>
> > Isn't this statement contradicting with your earlier statement
> > regarding the right order would be to complete TEE patches review
> > first and then come up with documentation here [2]?
> >
> > [1] https://lore.kernel.org/linux-integrity/1568025601.4614.253.camel@linux.ibm.com/
> > [2] https://lore.kernel.org/linux-integrity/20190909163643.qxmzpcggi567hmhv@linux.intel.com/
>
> With the intersecting issues, namely key generation and conflicting
> keyctl parameters, that was not a well considered statement.

Okay, let me work on documentation first, but I think resending whole
patch-set just for documentation review and rework would be an
overkill. Would minor revisions of this patch only like v3.1, v3.2
etc. work for you? And later I could send next version of this
patch-set once we agree on documentation.

-Sumit

>
> /Jarkko
