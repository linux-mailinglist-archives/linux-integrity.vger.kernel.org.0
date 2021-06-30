Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85E63B8917
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 21:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbhF3TU3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 15:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbhF3TU2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 15:20:28 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59E0C0617AD
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jun 2021 12:17:58 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id p24so4839507ljj.1
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jun 2021 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4T+GID+oMnIZlCqDCJF0ldXeQDAkPgspY/ySOTASFzI=;
        b=OsGeYpUKTFPyN5n360XNZX8s/aqdMHN9tQztcumkZMUEG0EKEgHA2J/bHBhbdu8wiR
         ClWnoPCQmYWxP2n/dlnN1fE0QB/HOvPEfl0TYUAdfEux0/vvSPpQzzuxcD9wpjOUwDnm
         ODKvHI15ym8cJPnCdDXTIIdO883VCyNE7rJaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4T+GID+oMnIZlCqDCJF0ldXeQDAkPgspY/ySOTASFzI=;
        b=Aouul9CnAF+IZx8xKTzLs9ZH+mib+Xb5DNTdA0AJjVYjRaLS1zdJPqlvTKsRokMZFF
         CHNERtMlXj5uRa8GOjPdkRwFtqjxTQi+/ZtlkAcg3r2HryD+efW0SaS1WTRytZt39ghJ
         ggIreJoQzOPsUgn1HoxoTZ1W2xMVWCmfcIupvUYx9psJVSn8KtoIGcyG3eLSviInx8gY
         ZjB1bhb+LR0mwU2hDckXNbkSNeOuFZXyQbfdbcAzL648P3M3saZWyjoVqz9T5SdXBlUc
         lPMeHL47Acqe2sr9Tm3MOtgRfiY98wBll5YydTMMdZUxqp66dz95FnbhDQvwJ6C3NuSF
         dHlw==
X-Gm-Message-State: AOAM531aAB0MHwmEFGrkMKe36tqjzpH/zcD4jeZMV2XdAsnB7yVqpRGj
        0QHIpKX1viH3j7jxanBLIge066Gkb3VcLy9eZfg=
X-Google-Smtp-Source: ABdhPJyuuftIy+oqxHCXs5wUKVN+lGKfM7YLp0dUjD9HRalpINiQJyyVnei6ZB5rhkQHptXpPL+qBg==
X-Received: by 2002:a05:651c:1695:: with SMTP id bd21mr8861844ljb.316.1625080676730;
        Wed, 30 Jun 2021 12:17:56 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id o142sm1996164lfa.299.2021.06.30.12.17.55
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 12:17:56 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id t17so7219343lfq.0
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jun 2021 12:17:55 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr27583898lfc.201.1625080675538;
 Wed, 30 Jun 2021 12:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210629213421.60320-1-stefanb@linux.vnet.ibm.com> <20210629213421.60320-2-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20210629213421.60320-2-stefanb@linux.vnet.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Jun 2021 12:17:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgVZ6PUJ6Q=vqnhSkHnE2Rvr72xPFjoRU4=HHn-Rqxu4w@mail.gmail.com>
Message-ID: <CAHk-=wgVZ6PUJ6Q=vqnhSkHnE2Rvr72xPFjoRU4=HHn-Rqxu4w@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] certs: Trigger creation of RSA module signing key
 if it's not an RSA key
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     Jessica Yu <jeyu@kernel.org>, keyrings@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 29, 2021 at 2:34 PM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> Address a kbuild issue where a developer created an ECDSA key for signing
> kernel modules and then builds an older version of the kernel, when bi-
> secting the kernel for example, that does not support ECDSA keys.

Thanks, these two don't confuse me any more.

                Linus
