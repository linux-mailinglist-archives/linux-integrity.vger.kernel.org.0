Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DDD56A537
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jul 2022 16:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiGGOPo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jul 2022 10:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiGGOPn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jul 2022 10:15:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D08C2F38E
        for <linux-integrity@vger.kernel.org>; Thu,  7 Jul 2022 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657203342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Snse6WNAbXQDgwuAFPKIs/eg6AGY2otiMBS6p+tZq8Q=;
        b=AI4GdB253ugo4pYDVhIzZOK6gHWsxVNxinesDRl6y+cDtf12fw597Hf4ANg2Uftdp3Jl/r
        D45Gdgeq8VltK1r6SLtax1OGHqyksOufUULsvn4a7iA4DnNiPIEIY2vGaAHTc5+2lWwx24
        eLnfynmZHQat3qldFEHqLriAZrPMWhg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-IJEMS1NLNMmuJUyLELifhA-1; Thu, 07 Jul 2022 10:15:41 -0400
X-MC-Unique: IJEMS1NLNMmuJUyLELifhA-1
Received: by mail-pf1-f200.google.com with SMTP id ay16-20020a056a00301000b00528c0c726f8so2958472pfb.16
        for <linux-integrity@vger.kernel.org>; Thu, 07 Jul 2022 07:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Snse6WNAbXQDgwuAFPKIs/eg6AGY2otiMBS6p+tZq8Q=;
        b=TAqOerw39G5m40tmvKPJ1n9A7YvqCcBO3jqCa9AimvJqdE9In5ZzL7LvZxrDlS9r45
         BqUrpyHwr5DMIUoqm/DfMEqsH4r45THJTAqIlSrgzOEKKnj/GYMorfjL6wVerJ/440v+
         v7q/sGJcOzEdxP1WTWxfJFvfOImzqMQVyD/E+KBV7JyO7m6PC3EKMP5dkolKhjj5ktIu
         g7RiodyLd3E18j6yzyw0C+fwnyQ9wmryKLE+v7XoQpI5QI8bzu2fbrNqoYBzoTsdDbND
         5RCT/QcEE/vl6G0o8nID7ovSIIFG+bDVv8F06Lf1g6qxEWISO0fXHqqSg4cvvRjl3GLg
         ghBw==
X-Gm-Message-State: AJIora+x29aPKr6Hno8Jfe1LWrznhI3dQeMwNpBuidHi/R9jZyImXhM2
        FanBCLh4On5T/zfLlvOayZvHZVIOMqyMPoMGmxV1WMoCrs0LzOPDYJZFAZ2mWf2vPJJ0umLSr1Y
        Q2DUZOXQNnWecwWpZMOE8tO/ttn+p
X-Received: by 2002:a05:6a00:1d9e:b0:528:a33a:22b9 with SMTP id z30-20020a056a001d9e00b00528a33a22b9mr10537534pfw.7.1657203339902;
        Thu, 07 Jul 2022 07:15:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tuWzdyOy7C3Ub7vTA/s057bMHl2QvOk3c7J797qqSRQnzwd0elRhBJpWmYXea++UlYeQjR1w==
X-Received: by 2002:a05:6a00:1d9e:b0:528:a33a:22b9 with SMTP id z30-20020a056a001d9e00b00528a33a22b9mr10537501pfw.7.1657203339558;
        Thu, 07 Jul 2022 07:15:39 -0700 (PDT)
Received: from localhost ([240e:3a1:31b:3d30:c711:d753:abde:647d])
        by smtp.gmail.com with ESMTPSA id o197-20020a62cdce000000b005292729cc5csm203757pfg.160.2022.07.07.07.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 07:15:38 -0700 (PDT)
Date:   Thu, 7 Jul 2022 22:10:29 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Will Deacon <will@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>
Subject: Re: [PATCH v9 0/4] unify the keyrings of arm64 and s390 with x86 to
 verify kexec'ed kernel signature
Message-ID: <20220707141029.tj6zerqd6dcu2wrr@Rk>
References: <20220704015201.59744-1-coxu@redhat.com>
 <711440de6340ef6ad73e4db5edd36fc391b8a11d.camel@linux.ibm.com>
 <20220706114806.GB2403@willie-the-truck>
 <45013a3990af13449c2d0deadab419e5d437eae7.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <45013a3990af13449c2d0deadab419e5d437eae7.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On Wed, Jul 06, 2022 at 10:33:50AM -0400, Mimi Zohar wrote:
>On Wed, 2022-07-06 at 12:48 +0100, Will Deacon wrote:
[..]
>> It looks like this series is ready to go, but it's not clear who should
>> pick it up. Eric -- would you be the best person? Otherwise, I'm happy to
>> take it via the arm64 tree (on its own branch) if that would be helpful.
>
>Unless Eric is interested, I was asked to pick this patch set up.

Thanks! FYI, Andrew has queued up Naveen's patch set "[PATCH 0/2] kexec:
Drop __weak attributes from functions" though:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-nonmm-unstable

With Naveen's patch set, "[PATCH v9 1/4] kexec: clean up
arch_kexec_kernel_verify_sig"" can be dropped. If you need me to send a
new version, please let me know.

>
>thanks,
>
>Mimi
>

-- 
Best regards,
Coiby

