Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8587462B1
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jul 2023 20:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjGCSre (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jul 2023 14:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGCSre (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jul 2023 14:47:34 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484B4E71
        for <linux-integrity@vger.kernel.org>; Mon,  3 Jul 2023 11:47:32 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-55ae51a45deso2366386a12.3
        for <linux-integrity@vger.kernel.org>; Mon, 03 Jul 2023 11:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688410052; x=1691002052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kN9o72g+S+fr453o45UGKHe2553NpYDOTlk2hs27c8U=;
        b=b9iCvxxHye8HsmgiBQdPV5wB3f1FHMfAOiUqp/E9CmOP7x6AhyW5/oynel97W2sEmn
         FvScJKeTY17iuoxKWd3fJHBDoV3jQ5VhDZhAiDH7gJxV6cBYtNcXXCFvQiJuShNtQGJA
         4z03TR4FvqYVUbHwqT8AyLfVintdaAK9d5apw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688410052; x=1691002052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kN9o72g+S+fr453o45UGKHe2553NpYDOTlk2hs27c8U=;
        b=gQTV1YgAQYIbzKme76982BkS3WpQBDPsdxVEItKAKfYKtHDSyFKPuviA+2lTmTDJHc
         iLi1ulWxIZXBE4Ky8SVCFNT/k3Nhj2GPtuXJIY2YCKQ+Vv3bE3dg/Ywypd4N3y6Rx4O9
         pW85ssvWRASa9a+/R8MRO9a3XZPWPQxuZO5Fsa93flup+0Era8VX/IwGnknZG2orFBzJ
         8P7R7u9JI6ceWjIMkkD1mOKi56oKU+lh5PNjMCoVaD/f2acPMNBUyWK7l7fb1HgtlW7i
         bvUjAtOS4hNjJyWC2Qu1yLZIq7HaYliCUcrkKoVXtNb+ZevHUiMZ0hkF8YZRRPoeAWRk
         VSxw==
X-Gm-Message-State: AC+VfDz9hWDKJQCV2OFfkBeNCP8S4q8w9oiXPZXOnwJ9pNrvXk4PPspA
        2eGNVlDloC1V6VMvqHRGPMxmiw==
X-Google-Smtp-Source: ACHHUZ7Uw6JIzie0IqBbLm1Jpta+I6oauYqzRMNr4YquzVcV9CbMBRcoIqPoHfkBX5hGG4i8DnEZeA==
X-Received: by 2002:a05:6a20:6a0f:b0:126:f64b:668e with SMTP id p15-20020a056a206a0f00b00126f64b668emr11925154pzk.5.1688410051738;
        Mon, 03 Jul 2023 11:47:31 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jf5-20020a170903268500b001b7eeffbdbfsm14742165plb.261.2023.07.03.11.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:47:31 -0700 (PDT)
Date:   Mon, 3 Jul 2023 11:47:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        LuisChamberlain <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig <hch@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [QUESTION] Full user space process isolation?
Message-ID: <202307031140.D52C63D46@keescook>
References: <eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com>
 <CAG48ez2oRPBdbfoNxGcV85CXFx1Su+dmhoWXE6rWsXui6_OTPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2oRPBdbfoNxGcV85CXFx1Su+dmhoWXE6rWsXui6_OTPg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 03, 2023 at 05:06:42PM +0200, Jann Horn wrote:
> But I'm not convinced that it makes sense to try to draw a security
> boundary between fully-privileged root (with the ability to mount
> things and configure swap and so on) and the kernel - my understanding
> is that some kernel subsystems don't treat root-to-kernel privilege
> escalation issues as security bugs that have to be fixed.

There are certainly arguments to be made about this, but efforts continue
to provide a separation between full-cap uid 0 and kernel memory. LSMs
like Lockdown, IMA, and LoadPin, for example, seek to close these gaps,
and systems are designed with this bright line existing between kernel
and root (e.g. Chrome OS). I'm sure there are gaps in attack surface
coverage, but since work continues on this kind of hardening, I'd hate
to knowingly create new attack surface. Providing uid 0 with kernel
memory access should continue to be mediated by at least Lockdown, and
if there are gaps in coverage, let's get them recorded[1] to be fixed.

-Kees

[1] https://github.com/KSPP/linux/issues

-- 
Kees Cook
