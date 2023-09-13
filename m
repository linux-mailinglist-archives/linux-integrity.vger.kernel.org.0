Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0022C79F257
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Sep 2023 21:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjIMTqY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Sep 2023 15:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjIMTqV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Sep 2023 15:46:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD5EB7
        for <linux-integrity@vger.kernel.org>; Wed, 13 Sep 2023 12:46:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52e828ad46bso156574a12.1
        for <linux-integrity@vger.kernel.org>; Wed, 13 Sep 2023 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694634376; x=1695239176; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dacT9sVMQZR6IpEeTHkxsBNkLKLIIgVKMRtbWHncpOU=;
        b=ZHE8boA6Z25M5hPdZ+BMd24YaxjIjhtH/tBg614+EkVdfvswGseXwTpFeLGbGsa+CD
         C5UCCOs5xPFNkhQ8bAZGW+9NJjDkUiFGoyaxrujY7QIYz+gpjeEWSYuV7Qdai1xW9mo7
         C1PNr6a6EuOBGa8cqHGdBqH4q4uCHZ2pVjFl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694634376; x=1695239176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dacT9sVMQZR6IpEeTHkxsBNkLKLIIgVKMRtbWHncpOU=;
        b=bvyGAPcj2Ym0gazl0x9Jqn5sMPgZXx+uLV2dmpydeaYAVvWDEE2giyqxH4n4DOjJzt
         6xkZ6X5WZ/grlR5Gjcpy1oLMCbv9Ux1/Qyl/Kt3Z23KY1j/c5MLlenhymTJAABogwW+L
         m8hsltF4tnRDpNG09IK1/r83qyXeWd2LANeo6f6+CedpyF11z443UKwq0EgBbVDjUImo
         9qKyaRItCQE6agIJ8mVsUL/9JDZHtPaWcqaZmeL2nvnxALmWel3HmgMTu2A/Q9vA8YlM
         OvD6Qb+miEczPf90zHiHLQypI6SmoO8Sk81L5b7BOE81AFYyfKRQs4A/9EKFVW2zosWK
         KgCw==
X-Gm-Message-State: AOJu0YycEVTLPzGIbjhypfHWZoukkUFFRKyeD/ejty3eMqsnnHLpeCt4
        Q4n0La66s7zB11x0ygePXlY0gr/soAgxAoqqf3oLFpu0
X-Google-Smtp-Source: AGHT+IEocjZ3d8S+zjfS8BVtdYZpEN7fzYviQa6xqdC7LoTRr99Lp1JGgZtkTOixVrDIk8Z0tS/iYA==
X-Received: by 2002:a17:906:30d0:b0:9a5:c8ad:20be with SMTP id b16-20020a17090630d000b009a5c8ad20bemr2836862ejb.4.1694634370927;
        Wed, 13 Sep 2023 12:46:10 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id g1-20020a170906394100b0099bc038eb2bsm8759408eje.58.2023.09.13.12.46.09
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 12:46:09 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-99bcf2de59cso31848166b.0
        for <linux-integrity@vger.kernel.org>; Wed, 13 Sep 2023 12:46:09 -0700 (PDT)
X-Received: by 2002:a17:906:1099:b0:9a5:da6c:6551 with SMTP id
 u25-20020a170906109900b009a5da6c6551mr2636968eju.62.1694634369429; Wed, 13
 Sep 2023 12:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230912201102.1012306-1-jarkko@kernel.org> <CAHk-=wgLB9_z5TcvRKVsSk3BWPfkDeWN0pDMdEv=-hnrnTgX1Q@mail.gmail.com>
 <CVI1GKA044I2.2A5GRO80ABMNN@suppilovahvero>
In-Reply-To: <CVI1GKA044I2.2A5GRO80ABMNN@suppilovahvero>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Sep 2023 12:45:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiS2rHdPe9qQ4Ahzy6t6hbG18ihsOjBYxn3Nr88yen52A@mail.gmail.com>
Message-ID: <CAHk-=wiS2rHdPe9qQ4Ahzy6t6hbG18ihsOjBYxn3Nr88yen52A@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd changes for v6.6-rc2
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Justin M . Forbes" <jforbes@fedoraproject.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 13 Sept 2023 at 12:32, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> Ok, I'll make something more reasonable.

Well, I took the pull already, just saying "tpm fix".

I assume the only thing the typo actually causes is printk's with a
typo in it. Maybe some sysfs name will be wrong?

That's the kind of information I would have _liked_ to see in the
merge message, but I didn't then delve into just where the class names
might actually be used.

               Linus
