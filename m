Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C058423D136
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 21:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgHET5l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Aug 2020 15:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgHEQns (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 12:43:48 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E86C034612;
        Wed,  5 Aug 2020 05:46:04 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c12so24490446qtn.9;
        Wed, 05 Aug 2020 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=th4R0mCDoEKdxtP92DcRMWCvQNUwMm704tc+tQsZ6e8=;
        b=CMnzX/BkmrlbcfiKr7JDmYk704xsWGknJKvd+HQfxigZlMYUd2JDxLZZJ7AM4TB3Tu
         xU1b2tTVbUxTEcVS0keHcGIOcvDbg0Mc9e44uwsdob+ZBmNGkINJPYUrbXW1+jGpvTLK
         q6HKh3ivwm3nAHOgsJQDTdhdUercSIIvr6v7SehaOwRjst4uDAortgK+6vcDK5Dt5wZ8
         7kUHi9Unn4E4nmWDGVLlM94Hu3Od0H2KdOl1Ckkp64W9ckafVFOmZQUWzAWqj8Ku24va
         Sz1jmJ4MtajaF/nWDfSRh9FPkplHRF/31M1d8qwy/IO2PlKYQYUCF5z60bd5zaEURRNn
         opGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=th4R0mCDoEKdxtP92DcRMWCvQNUwMm704tc+tQsZ6e8=;
        b=PJU27bSOqH20mghqx6QETZ0jSO+leoLP6wgwFCxeCMoJxxR1avg5sGLxBV5C+cPUlc
         DWT59RCsiIlY1lNKB2ljAAxaaye8nYTELA9ol90rCBwnZ4fRp3mypKEu4ClarcOlNlo/
         Mj5hbDAFi2xQ1B9ayJsfebza8jQN/03qzPHK4pD58uZlkqzVokPhxZ+jiG4PctwxOjkL
         o5GmfBbc9GkYf7yef6Jd0KTixNhiE6um2UNKuFWC7xQEfVGkC86IYOm2RJYVlOfYePhi
         s0sT/DQyDxxqH440UK1xmxoCxUCQEtLeMFR9C2+65b5SWVkUO/2o7UierPSmAlPjdwao
         NSuQ==
X-Gm-Message-State: AOAM5328/6BBHHHxelk2/fXz5Nva/BZcrwv045lqswa5StGURkOzNZQl
        DqdRMnnhaq0sKbou7glOiZG7CberAiY=
X-Google-Smtp-Source: ABdhPJxrH4/VsLOKixqcHuZDqId9PnSjHLiReskUJRab0cl4DnJUCIsc2KvflzT6+UowANCjwPVYXw==
X-Received: by 2002:ac8:6f51:: with SMTP id n17mr3057373qtv.233.1596631562731;
        Wed, 05 Aug 2020 05:46:02 -0700 (PDT)
Received: from [192.168.1.190] (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id j15sm1410469qkl.63.2020.08.05.05.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 05:46:01 -0700 (PDT)
Subject: Re: [PATCH v6 1/4] IMA: Add func to measure LSM state and policy
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200805004331.20652-1-nramas@linux.microsoft.com>
 <20200805004331.20652-2-nramas@linux.microsoft.com>
 <4b9d2715d3ef3c8f915ef03867cfb1a39c0abc54.camel@linux.ibm.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <f88bf25e-37ef-7f00-6162-215838961bb0@gmail.com>
Date:   Wed, 5 Aug 2020 08:46:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4b9d2715d3ef3c8f915ef03867cfb1a39c0abc54.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/4/20 11:25 PM, Mimi Zohar wrote:

> Hi Lakshmi,
>
> There's still  a number of other patch sets needing to be reviewed
> before my getting to this one.  The comment below is from a high level.
>
> On Tue, 2020-08-04 at 17:43 -0700, Lakshmi Ramasubramanian wrote:
>> Critical data structures of security modules need to be measured to
>> enable an attestation service to verify if the configuration and
>> policies for the security modules have been setup correctly and
>> that they haven't been tampered with at runtime. A new IMA policy is
>> required for handling this measurement.
>>
>> Define two new IMA policy func namely LSM_STATE and LSM_POLICY to
>> measure the state and the policy provided by the security modules.
>> Update ima_match_rules() and ima_validate_rule() to check for
>> the new func and ima_parse_rule() to handle the new func.
> I can understand wanting to measure the in kernel LSM memory state to
> make sure it hasn't changed, but policies are stored as files.  Buffer
> measurements should be limited  to those things that are not files.
>
> Changing how data is passed to the kernel has been happening for a
> while.  For example, instead of passing the kernel module or kernel
> image in a buffer, the new syscalls - finit_module, kexec_file_load -
> pass an open file descriptor.  Similarly, instead of loading the IMA
> policy data, a pathname may be provided.
>
> Pre and post security hooks already exist for reading files.   Instead
> of adding IMA support for measuring the policy file data, update the
> mechanism for loading the LSM policy.  Then not only will you be able
> to measure the policy, you'll also be able to require the policy be
> signed.

To clarify, the policy being measured by this patch series is a 
serialized representation of the in-memory policy data structures being 
enforced by SELinux.  Not the file that was loaded.  Hence, this 
measurement would detect tampering with the in-memory policy data 
structures after the policy has been loaded.  In the case of SELinux, 
one can read this serialized representation via /sys/fs/selinux/policy.  
The result is not byte-for-byte identical to the policy file that was 
loaded but can be semantically compared via sediff and other tools to 
determine whether it is equivalent.


