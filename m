Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79F8574FD1
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jul 2022 15:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbiGNNu5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Jul 2022 09:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240010AbiGNNu0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jul 2022 09:50:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5A815A2C5
        for <linux-integrity@vger.kernel.org>; Thu, 14 Jul 2022 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657806621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HqRw1G8aZam6OHUc5a/z5Gnu6/RwvclS67B8cHWbrGA=;
        b=QS7dk2ntuxceXG2vj6A1aTruzvijuyzrjW2/6Ya+Lq7ImfcbV0neHXc6I+MFC35MIU7ftk
        OJXvE1PHxvEjrYB6dFw1PK5kGwIegoTHTBeD1va8Cw6kxnoTY5a/TBHhbONl0EG870/+id
        khuYzDCMX3FPylcUKI4y9Dy2VyMrumg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320--3dOk8uQPcKEtQJSceBfvw-1; Thu, 14 Jul 2022 09:50:20 -0400
X-MC-Unique: -3dOk8uQPcKEtQJSceBfvw-1
Received: by mail-pj1-f72.google.com with SMTP id 92-20020a17090a09e500b001d917022847so1324685pjo.1
        for <linux-integrity@vger.kernel.org>; Thu, 14 Jul 2022 06:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HqRw1G8aZam6OHUc5a/z5Gnu6/RwvclS67B8cHWbrGA=;
        b=DjrgIYigXmHVf6QWZOXalZ8PKVff6VXRg48PPQgKCYRyF5qtn7BTXXnk/cU9nlTjMh
         ts+tHGvLLXMpNyIAkvexGDSfBNFG/6GQU+x/FYJcQ5IpUkSB56o/fV7/z3jn9lPfwF//
         LTZLLoVBfNVoZ2qnFVxc+LGJPIu0Gi5XlFKTEePSvNsyiDNBF74Axy78RC92XUgO2EES
         RGQrH2ecN3ELo6vktMv/eTyrXx1LPTHvbd8TSFtiZq/yTw9Pb0woI5r7wKaTKZ1EKVSW
         6AGgLnFBiDpvFVHviz4BTNT0qVz0qXDCeCvVfdu7JirfZoCgQF8PMu72anyzhr3sLaU7
         yS7Q==
X-Gm-Message-State: AJIora/cyC8hlffm2aTRTaFnXexbodUvhFG+WZB99gD7TdUKM0mtYo7n
        T8FQkRDK1eYZTFJDEoWFAzlVBn11KYGLUlFyqAmWtxXQoKAJy8a7RRumnn6wLFJRJci/11YoTCu
        yeiAC8U0NKZwTPxLZpvLv3qeeyd4Q
X-Received: by 2002:a17:902:f68c:b0:16c:4eb6:913c with SMTP id l12-20020a170902f68c00b0016c4eb6913cmr8356012plg.2.1657806618472;
        Thu, 14 Jul 2022 06:50:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ubfYsFNwV/IDviweRzJNFs2D5e+LIyoL2+y7WGNS1yi9NhFkim8OrEWegyv2jH+eXRVL67hg==
X-Received: by 2002:a17:902:f68c:b0:16c:4eb6:913c with SMTP id l12-20020a170902f68c00b0016c4eb6913cmr8355975plg.2.1657806618165;
        Thu, 14 Jul 2022 06:50:18 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x7-20020a1709027c0700b0016cae5f04e6sm1487526pll.135.2022.07.14.06.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:50:17 -0700 (PDT)
Date:   Thu, 14 Jul 2022 21:48:45 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     akpm@linux-foundation.org, Will Deacon <will@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>
Subject: Re: [PATCH v9 0/4] unify the keyrings of arm64 and s390 with x86 to
 verify kexec'ed kernel signature
Message-ID: <20220714134845.ypm25hxk773qxe7v@Rk>
References: <20220704015201.59744-1-coxu@redhat.com>
 <711440de6340ef6ad73e4db5edd36fc391b8a11d.camel@linux.ibm.com>
 <20220706114806.GB2403@willie-the-truck>
 <45013a3990af13449c2d0deadab419e5d437eae7.camel@linux.ibm.com>
 <20220707141029.tj6zerqd6dcu2wrr@Rk>
 <bf0d023a719db587ba8dc5ef7559f3d0b9542cd5.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bf0d023a719db587ba8dc5ef7559f3d0b9542cd5.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 07, 2022 at 06:28:50PM -0400, Mimi Zohar wrote:
>On Thu, 2022-07-07 at 22:10 +0800, Coiby Xu wrote:
>> Hi Mimi,
>>
>> On Wed, Jul 06, 2022 at 10:33:50AM -0400, Mimi Zohar wrote:
>> >On Wed, 2022-07-06 at 12:48 +0100, Will Deacon wrote:
>> [..]
>> >> It looks like this series is ready to go, but it's not clear who should
>> >> pick it up. Eric -- would you be the best person? Otherwise, I'm happy to
>> >> take it via the arm64 tree (on its own branch) if that would be helpful.
>> >
>> >Unless Eric is interested, I was asked to pick this patch set up.
>>
>> Thanks! FYI, Andrew has queued up Naveen's patch set "[PATCH 0/2] kexec:
>> Drop __weak attributes from functions" though:
>> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-nonmm-unstable
>>
>> With Naveen's patch set, "[PATCH v9 1/4] kexec: clean up
>> arch_kexec_kernel_verify_sig"" can be dropped. If you need me to send a
>> new version, please let me know.
>
>I'm not quite sure how to handle the prerequisite patches being in
>Andrew's tree, without his creating a branch with just the two commits.

FYI, I just sent v10 based on Naveen's patch set and it targets
next-integrity since Mimi is going to pick it up.

>
>thanks,
>
>Mimi
>

-- 
Best regards,
Coiby

