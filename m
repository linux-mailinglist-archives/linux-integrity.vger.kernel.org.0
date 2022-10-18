Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8217603272
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Oct 2022 20:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJRS3d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Oct 2022 14:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJRS3b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Oct 2022 14:29:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BD1AE44
        for <linux-integrity@vger.kernel.org>; Tue, 18 Oct 2022 11:29:27 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gf8so14788503pjb.5
        for <linux-integrity@vger.kernel.org>; Tue, 18 Oct 2022 11:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=480LhGaWcAy9eoC7BPU3SZTwZOUH9kRW24Tgef8tu94=;
        b=kgAqIeyHHPaDLe8rxtC5yrY1QN7M8T05xd5JdHBNKKf76+skqFZ5oYyBQ+r2YPZduV
         8Vezs3vlfr0LsgsfFejvJ1I8PSjH+LtMmVwmFCax9VOsi1qwNLy3bKIjod+0r/hple6j
         HI1+Wh/V14MURwQbYzfDcEdrsD2zx0CGx4os0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=480LhGaWcAy9eoC7BPU3SZTwZOUH9kRW24Tgef8tu94=;
        b=FEZyXUPQZvZ64k7PFdRHID56qVRnY7tjepmuUDharpEbVkD9fBY62UdxkkT+3h2RZ+
         FVdIVNJdKHdFZ/x8r5oI8fuV+It9PlKGecrd/eMOSk+MVgGjTbmeV+8AINevJiDHV6zu
         prVl371Jn4U1bG8cgj8WaqiBPXXsUB9KSUaDF6HMb7Dk0qEZoK0Xvq4tVELRVlPxYcEm
         uBNmso64Farst3b1cpL9za2Ox0EjUzhf7mFz36QFG9NBcwt2GzR1rQyRoi5iCGXcvFr6
         5CbARbFcGhHP1P4zCStte9vrA0Dj1nq0JTQEzpbnRWS7lgc5SKrXLCWVckODv6T/wAT9
         hHHA==
X-Gm-Message-State: ACrzQf1KXksW7zeJv0LoPDmQLfxa57r4jYmCcYO2QJlP5IYYMwifekEz
        jNeX7J+am53Pnj2VM5UHxWUVMQ==
X-Google-Smtp-Source: AMsMyM7yom3/fySRyTiHRRR1TkhJawIBdbnxjC8F5/fsYJ2whSqcpT5edOI3vnEFhCJHDi0euy640Q==
X-Received: by 2002:a17:902:9896:b0:185:45b0:6651 with SMTP id s22-20020a170902989600b0018545b06651mr4366797plp.129.1666117767203;
        Tue, 18 Oct 2022 11:29:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e13-20020a056a0000cd00b0053e8fe8a705sm9861309pfj.17.2022.10.18.11.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:29:26 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:29:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Petr Vorel <pvorel@suse.cz>,
        Jonathan McDowell <noodles@fb.com>,
        Borislav Petkov <bp@suse.de>, Takashi Iwai <tiwai@suse.de>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 4/9] ima: Move ima_file_free() into LSM
Message-ID: <202210181126.E58AB4A0F@keescook>
References: <20221013222702.never.990-kees@kernel.org>
 <20221013223654.659758-4-keescook@chromium.org>
 <20221018150213.7n4sv7rtsh6lshd5@wittgenstein>
 <1b41c633bbd31b82b02fdbae718f2f11ac862181.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b41c633bbd31b82b02fdbae718f2f11ac862181.camel@huaweicloud.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 18, 2022 at 05:32:40PM +0200, Roberto Sassu wrote:
> I also did this work before. In my implementation, I created a new
> security hook called security_file_pre_free().
> 
> https://github.com/robertosassu/linux/commit/692c9d36fff865435b23b3cb765d31f3584f6263
> 
> If useful, the whole patch set is available at:
> 
> https://github.com/robertosassu/linux/commits/ima-evm-lsm-v1-devel-v3

Ah, lovely! Can you pick this back up and run with it? I mainly did
these a proof-of-concept, but it looks like you got further.

-- 
Kees Cook
