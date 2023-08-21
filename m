Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D2E78276E
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Aug 2023 12:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjHUKza (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Aug 2023 06:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjHUKz2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Aug 2023 06:55:28 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97237E2
        for <linux-integrity@vger.kernel.org>; Mon, 21 Aug 2023 03:55:23 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-64c1d487e72so16534546d6.0
        for <linux-integrity@vger.kernel.org>; Mon, 21 Aug 2023 03:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692615322; x=1693220122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiI/WQOuZTfR/t2f6lJi1LF56QHzapL/gSCpBEw2/yI=;
        b=voaF9uP3moLZFKmDpjoVS5/VO/S6kYiSBNTYymR1j73z7PoSrQ1s6VP0BDhTvFbm55
         47+aPF1HBWybY5GORChwQ8XPjPvBxIHJjtb7/+tHXqLwoByMxyoRKpYiSM7V5TMGwBpc
         uaDXdSlNPlg7soenxcXG85MEaQX0KmZStM1bGmAH1+NX3+v26r+0H1NRUKqUFJqb3DkN
         PSxNi5d45d+AgRBY1HrtiDFQH4r7FmnixPJXuGuSlTi5LrqQgRl5QXFAoudUQheE0oTz
         ODeRABiRk4fXvbW8uYFfzprhwMY9FPETVIW3Ok4NmIlsN5liVC5mP6M8D4uu9dXgsvtG
         YzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692615322; x=1693220122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiI/WQOuZTfR/t2f6lJi1LF56QHzapL/gSCpBEw2/yI=;
        b=cbSr44gzNcOE+g8aIkGGhIHCPlMWcDz4gjM4+mGkosCYeyXACFQ2kxa3Tl7kSYofOX
         j1OZcPQgwMa60gI3WJrG2FL+by1VCqiVPDkRhGgm+2jrljw6C6W1yV5nvqtasoy++vk8
         pVvvsq21dMjKAnQzA8vQGiZAWZSjGsv1RwRlFQnMXUV7AjO9KIM6v+fh+r42Ay99aEwZ
         91tAHDvmWVYGEp4EXRFEyvFXHTmkbTEPLIxaEb8utnjWQWAdwDEQOAPNHIgWHS+aBF8A
         JVVdRIKkjvUcwGVZgXdHEmPXSWO+mz+jPRGqawr5mXSfDfZ87Lt0g3JQPW0yMj4d8cXU
         3QNw==
X-Gm-Message-State: AOJu0YyLwaAckq7VbLfwExWsW5wbplKSaRjPIMhRaVAT29R5aQSVqdsQ
        1Kjk2zfeC1VHOu1yAe4akXl89jTnr4sw/+4deomWBA==
X-Google-Smtp-Source: AGHT+IGhBYQ09T4ZsvRgLhFVbDcJZ6bPFOy6hWqSHBVAWat7aAmK5pCE/wWJSXRBSvLxvq4t8vX4VWqE8CWt7pRFElg=
X-Received: by 2002:a0c:f910:0:b0:647:248b:3614 with SMTP id
 v16-20020a0cf910000000b00647248b3614mr6297972qvn.4.1692615322740; Mon, 21 Aug
 2023 03:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230803123515.4018838-1-jens.wiklander@linaro.org>
 <CAFA6WYMzBJTNUxh6b-y=a_NND8FX65YjEP4i-HPS4tQ-Qfm+0w@mail.gmail.com>
 <CAHUa44ET3Oqc4Yq8E4ouAjn5dF9ygxoXyWh0sjFF_vPoooxrnA@mail.gmail.com>
 <CAHUa44HpkxDPgdh1B_bFOVPSOETk3F_ZicdnhmuVOux+5fd7sA@mail.gmail.com>
 <CAFA6WYMdROqkNbfbOkm22AYR1vnNa83dttf-4rF6pp1dZDym3Q@mail.gmail.com> <CAFA6WYOhSAY68S=pqW5=YU=gCo7LHYELt1A7mAx-0revWH5XpA@mail.gmail.com>
In-Reply-To: <CAFA6WYOhSAY68S=pqW5=YU=gCo7LHYELt1A7mAx-0revWH5XpA@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 21 Aug 2023 12:55:11 +0200
Message-ID: <CAHUa44GjxLxzDSRsufvR35HRYpJ0S9iAXaN8cMz-V1B=HVBzHw@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: tee: use tee_shm_register_alloc_buf()
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 21, 2023 at 11:35=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
[snip]
> Actually thinking about it more, let's rework
> tee_shm_register_kernel_buf() to be tee_shm_register_kernel_pages() to
> get aligned as we agreed here [1]. This would then shift the
> responsibility to check for duplicate pages to kernel clients rather
> than the TEE driver (don't need to bother about sub page buffers).
>
> [1] https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedf=
irmware.org/thread/Y224PTCQZPKLH2INVWWPRUZM4MDUPYL7/

Sounds good, I assume this will not affect tee_shm_alloc_kernel_buf().

Thanks,
Jens
