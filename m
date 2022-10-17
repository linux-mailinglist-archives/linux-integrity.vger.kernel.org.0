Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBDD601607
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Oct 2022 20:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJQSLK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Oct 2022 14:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJQSLI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Oct 2022 14:11:08 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70D374CC4
        for <linux-integrity@vger.kernel.org>; Mon, 17 Oct 2022 11:11:04 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gf8so11676826pjb.5
        for <linux-integrity@vger.kernel.org>; Mon, 17 Oct 2022 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wk/AfKxmKFFMFtDOBSmyqEUOU7F5xvb3yjHU7rI31n4=;
        b=aIwed63klUDo4ZfnVYo5sFh2Wh9Cyo0Wi7mucCNbpPn+JH2k43Rp/Z8N8K9lf7ujVP
         io8FvnbDY9GHHeAs7p9DDW7PmTsDVyNZcakall+CN5pHextcQxGmP1YY/SIzQ4yZY1K1
         WQcSquaAKvf1om/K6J20YizK63oKDrlaZTL38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wk/AfKxmKFFMFtDOBSmyqEUOU7F5xvb3yjHU7rI31n4=;
        b=Nc7G5+v3EWpn0Tqh6PbvO0SzXAm/Sy/JPtS72C2RPJqLKXtDj/IEzNybEr87qkHKNx
         K04MqVXmN+qBnvDyUx60YUiGGyTlwSTJSrlQnUTaqxAr5sa4cgfRKNEYre6eohDGosKb
         f0OYWLN6H10aJ9OSNMv2HAqzQqY1BLTA0FCyICH9AwJbInZLk/9BzOOjdpZfJnuiy7P4
         lExxDMKIzT5gFrvek4gOI1ncKenzAcnCy08VWLPHoQahGT8k1fZKb3Zq90uSMvVqs6lV
         QnhwvGzbapiBrd4KNiBIbQgAO0LaDse1UXnMDAz/SZA7bHdsYXR1NMtwuBWYklLOrJ02
         4RTQ==
X-Gm-Message-State: ACrzQf1kzhbiKWo9fvNGrFZZxcSJOpMrpMC0wgKwrSGh4qwVGwwDGwUi
        Ixr0V24Kwz5AOnHd0Gc1jWbmLtjMnjweGA==
X-Google-Smtp-Source: AMsMyM7+VVMBV+Yo7/YZZ4yIOQlr/fUEzxuXTxelzcdrHHW0YYgHQNR/3QsalaLB2/Y7RM/OwQi9Nw==
X-Received: by 2002:a17:90b:f02:b0:20a:9965:eeee with SMTP id br2-20020a17090b0f0200b0020a9965eeeemr14825583pjb.182.1666030262802;
        Mon, 17 Oct 2022 11:11:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902c65100b00177faf558b5sm6897713pls.250.2022.10.17.11.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:11:02 -0700 (PDT)
Date:   Mon, 17 Oct 2022 11:11:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/9] integrity: Prepare for having "ima" and "evm"
 available in "integrity" LSM
Message-ID: <202210171101.2E96A7D557@keescook>
References: <20221013222702.never.990-kees@kernel.org>
 <20221013223654.659758-1-keescook@chromium.org>
 <08a8b202-69b4-e154-28f5-337a898acf61@digikod.net>
 <202210141050.A8DF7D10@keescook>
 <0d2b9d34-2eda-8aa6-d596-eb1899645192@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d2b9d34-2eda-8aa6-d596-eb1899645192@digikod.net>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 17, 2022 at 11:26:44AM +0200, Mickaël Salaün wrote:
> 
> On 14/10/2022 19:59, Kees Cook wrote:
> > On Fri, Oct 14, 2022 at 04:40:01PM +0200, Mickaël Salaün wrote:
> > > This is not backward compatible
> > 
> > Why? Nothing will be running LSM hooks until init finishes, at which
> > point the integrity inode cache will be allocated. And ima and evm don't
> > start up until lateinit.
> > 
> > > , but can easily be fixed thanks to
> > > DEFINE_LSM().order
> > 
> > That forces the LSM to be enabled, which may not be desired?
> 
> This is not backward compatible because currently IMA is enabled
> independently of the "lsm=" cmdline, which means that for all installed
> systems using IMA and also with a custom "lsm=" cmdline, updating the kernel
> with this patch will (silently) disable IMA. Using ".order =
> LSM_ORDER_FIRST," should keep this behavior.
> 
> BTW, I think we should set such order (but maybe rename it) for LSMs that do
> nothing unless configured (e.g. Yama, Landlock).

Ah yeah, good point. the .enabled stuff will need to be correctly wired
up. Anyway, it's a good starting point for the conversion, so I'm hoping
it can be carried forward by someone who is not me. :) (Hint hint to the
integrity folks...)

> > > Side node: I proposed an alternative to that but it was Nacked:
> > > https://lore.kernel.org/all/20210222150608.808146-1-mic@digikod.net/
> > 
> > Yeah, for the reasons pointed out -- that can't work. The point is to
> > not have The Default LSM. I do think Casey's NAK was rather prickly,
> > though. ;)
> 
> I don't agree, there is no "the default LSM", and this new behavior is under
> an LSM_AUTO configuration option.

The "config it twice" aspect of the current situation is suboptimal,
yes. Let me go comment on the old thread...

-- 
Kees Cook
