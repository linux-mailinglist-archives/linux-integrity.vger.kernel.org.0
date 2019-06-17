Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66D55490E0
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2019 22:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfFQUIW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Jun 2019 16:08:22 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39616 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfFQUIU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Jun 2019 16:08:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id i34so7097299qta.6;
        Mon, 17 Jun 2019 13:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zmogzjeNfdvyQHIHPql3oMPQQB85wlj8S3ap4Uhkqn8=;
        b=XsFyt+CT9YA6cKZgB5FzO7KCsMonBolkQ0HF5RYA++rqoEoi/De5is9wPZT/tX1wpc
         8PMXFD38FNjfEDNsdMx+6yOD6M0qkLSPouFqD+TKj6NvYZNkFm/zncKFoZ8+hJb2pjHj
         NNTx2zwSV6/cEhZeGv5tgAwncJVY96FfH/L7+6bUV+kiBfS4MxYDxrN8CIkSB3RA0PQM
         UlMf1f1LX+D/MX0H6O37ofVuB/3cmrkMHIBCDMcMrWZ/6oCDHejw53xKT2uOOUUZyg4V
         3ps1ODQLukMlf6siHdIkrbjVaYYHOSZ/a7Ew/phRiQhVUcLODc9qjCXfZsZ1O21pVkY6
         aJOA==
X-Gm-Message-State: APjAAAUvS21xsZZy1s6rSKH3FVzV9WQVW1pp4p56uyDVgTYLnMYXOo8O
        +4LVb294H7G85UBFna2UM9bbX9BTAVaAo/JjcwA=
X-Google-Smtp-Source: APXvYqx/EkSHtqxjK+IK19lRpttkWTjepWnFxOKVDYNVPZwMKEsgt97sUiKYUHDMpSqx8lo70kw5hKq/+zvLn7YNsDs=
X-Received: by 2002:ac8:3485:: with SMTP id w5mr18793022qtb.142.1560802099413;
 Mon, 17 Jun 2019 13:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190617115838.2397872-1-arnd@arndb.de> <1560786951.4072.103.camel@linux.ibm.com>
 <1560794826.4072.169.camel@linux.ibm.com>
In-Reply-To: <1560794826.4072.169.camel@linux.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Jun 2019 22:08:02 +0200
Message-ID: <CAK8P3a1Q2JG3KBYNYgWg0_XtGUufNc6zuqcUBqiGSaBRp+au-w@mail.gmail.com>
Subject: Re: [PATCH] ima: dynamically allocate shash_desc
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 17, 2019 at 8:08 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Mon, 2019-06-17 at 11:55 -0400, Mimi Zohar wrote:
> > On Mon, 2019-06-17 at 13:20 +0200, Arnd Bergmann wrote:
> > > On 32-bit ARM, we get a warning about excessive stack usage when
> > > building with clang.
> > >
> > > security/integrity/ima/ima_crypto.c:504:5: error: stack frame size
> > > of 1152 bytes in function 'ima_calc_field_array_hash' [-Werror,-
> > > Wframe-larger-than=]
> >
> > I'm definitely not seeing this.  Is this problem a result of non
> > upstreamed patches?  For sha1, currently the only possible hash
> > algorithm, I'm seeing 664.

You won't see it with gcc, only with clang in some randconfig builds,
I suppose only when KASAN is enabled.

> Every time a measurement is added to the measurement list, the memory
> would be allocated/freed.  The frequency of new measurements is policy
> dependent.  For performance reasons, I'd prefer if the allocation
> remains on the stack.

Is there a way to preallocate the shash_desc instead? That would
avoid the overhead.

        Arnd
