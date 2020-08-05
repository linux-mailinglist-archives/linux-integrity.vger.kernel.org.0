Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEE823D0A8
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 21:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgHETv1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Aug 2020 15:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbgHEQwZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 12:52:25 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D48C001FC5;
        Wed,  5 Aug 2020 08:43:48 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id x6so15102211qvr.8;
        Wed, 05 Aug 2020 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=czjIYKIMqrKx6NztO4qHKv0Vt37ieCFKeMG2O/uHiYg=;
        b=JmbYr8IuLilXgfVziMkJJADX+seDHRIXyosFHEnEGxvzY7/FkcqApH7N3pvh+5shjk
         Q9+bbS8dSq1gjKMskj0yJMF+TGs8ar6xTV30rGxjAP/fH9ccGRnUkkHYZKIAL0kTz8bv
         4RsWkIposRJM9gxUZwrqGEjaFBs+3WCd2Z4rlDquUdCvagBjUsK8TCIKG4nhszIgTF7C
         /+RIvsj8Z8xsySpriyn8IQ8s5w+Y35UKJkcnJ/w9nmh+P7la7XV3+BCAKjqiP5xoY/uL
         Hd7atbVYYzxGQwPODP/fNVBOyjhWPGBcxO5ffP2utZDHNe4ks5lQ1hir+ZTN6OoWcist
         rcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=czjIYKIMqrKx6NztO4qHKv0Vt37ieCFKeMG2O/uHiYg=;
        b=tOddIAlZs1QtERZCJT2irykS6q537sY9OA9SP8r2WEGx5v3cyrYmJcDKs379VZ9DbV
         bmydf3S8uFXWmA2MxirzWcYfuZGIWjDLAEv4vFIrkH7Au7AVnSd0zuUIudmblGBhXigl
         n9k3Ne41Fia9K7cCqL9S5MiCxm9vmaP9Ye/U8fVjCjr2Asxwt1fnPMAR0k+VqFddvLiN
         doYXG9ldx/FRq56MhlfMgrI+iP108Sb1WU+bPWZH8XBKVLzqWDA5IXfu6HlP6xDXWp+d
         avc/bpHIan3JOGA3BK4AWiYsIo8c0axVqukpu7bFCX1QB7UZYAcw+VSHjLH3RWHL+WTW
         VfXA==
X-Gm-Message-State: AOAM5325q1TWjZD7WWDprLoLk9ABGQ02TGN9QHn2hgonKFPbhb5+5PNF
        HG64m1LBcOAxvh5xiBKV+bU=
X-Google-Smtp-Source: ABdhPJyHjyZcUS4lx3kYJlGYbr+5Wv7FvFmaR0g2jYyml05P+PoihEVt8BPlIURWZmvmF7jy8xr56g==
X-Received: by 2002:a0c:b604:: with SMTP id f4mr4418696qve.68.1596642224148;
        Wed, 05 Aug 2020 08:43:44 -0700 (PDT)
Received: from [192.168.1.190] (pool-71-244-252-199.bltmmd.fios.verizon.net. [71.244.252.199])
        by smtp.gmail.com with ESMTPSA id k48sm2611318qtk.44.2020.08.05.08.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 08:43:43 -0700 (PDT)
Subject: Re: [PATCH v6 1/4] IMA: Add func to measure LSM state and policy
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Casey Schaufler <casey@schaufler-ca.com>, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>
References: <20200805004331.20652-1-nramas@linux.microsoft.com>
 <20200805004331.20652-2-nramas@linux.microsoft.com>
 <4b9d2715d3ef3c8f915ef03867cfb1a39c0abc54.camel@linux.ibm.com>
 <f88bf25e-37ef-7f00-6162-215838961bb0@gmail.com>
 <31d00876438d2652890ab8bf6ba2e80f554ca7a4.camel@linux.ibm.com>
 <CAEjxPJ6X+Cqd5QtZBmNm2cujwbg-STfRF7_8i=Ny8yuc6z9BwQ@mail.gmail.com>
 <b7df114e8e0d276e66575b6970a1e459d1dd4196.camel@linux.ibm.com>
 <CAEjxPJ7d1yg659OCU6diXXGqegc_jSzO4ZPhkRqQtJnRn-kC0g@mail.gmail.com>
 <20200805150732.GA4365@sequoia>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <39390a53-51df-12f0-5451-e677ccca581a@gmail.com>
Date:   Wed, 5 Aug 2020 11:43:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805150732.GA4365@sequoia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/5/20 11:07 AM, Tyler Hicks wrote:

> On 2020-08-05 10:27:43, Stephen Smalley wrote:
>> On Wed, Aug 5, 2020 at 9:20 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>>> On Wed, 2020-08-05 at 09:03 -0400, Stephen Smalley wrote:
>>>> On Wed, Aug 5, 2020 at 8:57 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>>> On Wed, 2020-08-05 at 08:46 -0400, Stephen Smalley wrote:
>>>>>> On 8/4/20 11:25 PM, Mimi Zohar wrote:
>>>>>>
>>>>>>> Hi Lakshmi,
>>>>>>>
>>>>>>> There's still  a number of other patch sets needing to be reviewed
>>>>>>> before my getting to this one.  The comment below is from a high level.
>>>>>>>
>>>>>>> On Tue, 2020-08-04 at 17:43 -0700, Lakshmi Ramasubramanian wrote:
>>>>>>>> Critical data structures of security modules need to be measured to
>>>>>>>> enable an attestation service to verify if the configuration and
>>>>>>>> policies for the security modules have been setup correctly and
>>>>>>>> that they haven't been tampered with at runtime. A new IMA policy is
>>>>>>>> required for handling this measurement.
>>>>>>>>
>>>>>>>> Define two new IMA policy func namely LSM_STATE and LSM_POLICY to
>>>>>>>> measure the state and the policy provided by the security modules.
>>>>>>>> Update ima_match_rules() and ima_validate_rule() to check for
>>>>>>>> the new func and ima_parse_rule() to handle the new func.
>>>>>>> I can understand wanting to measure the in kernel LSM memory state to
>>>>>>> make sure it hasn't changed, but policies are stored as files.  Buffer
>>>>>>> measurements should be limited  to those things that are not files.
>>>>>>>
>>>>>>> Changing how data is passed to the kernel has been happening for a
>>>>>>> while.  For example, instead of passing the kernel module or kernel
>>>>>>> image in a buffer, the new syscalls - finit_module, kexec_file_load -
>>>>>>> pass an open file descriptor.  Similarly, instead of loading the IMA
>>>>>>> policy data, a pathname may be provided.
>>>>>>>
>>>>>>> Pre and post security hooks already exist for reading files.   Instead
>>>>>>> of adding IMA support for measuring the policy file data, update the
>>>>>>> mechanism for loading the LSM policy.  Then not only will you be able
>>>>>>> to measure the policy, you'll also be able to require the policy be
>>>>>>> signed.
>>>>>> To clarify, the policy being measured by this patch series is a
>>>>>> serialized representation of the in-memory policy data structures being
>>>>>> enforced by SELinux.  Not the file that was loaded.  Hence, this
>>>>>> measurement would detect tampering with the in-memory policy data
>>>>>> structures after the policy has been loaded.  In the case of SELinux,
>>>>>> one can read this serialized representation via /sys/fs/selinux/policy.
>>>>>> The result is not byte-for-byte identical to the policy file that was
>>>>>> loaded but can be semantically compared via sediff and other tools to
>>>>>> determine whether it is equivalent.
>>>>> Thank you for the clarification.   Could the policy hash be included
>>>>> with the other critical data?  Does it really need to be measured
>>>>> independently?
>>>> They were split into two separate functions because we wanted to be
>>>> able to support using different templates for them (ima-buf for the
>>>> state variables so that the measurement includes the original buffer,
>>>> which is small and relatively fixed-size, and ima-ng for the policy
>>>> because it is large and we just want to capture the hash for later
>>>> comparison against known-good).  Also, the state variables are
>>>> available for measurement always from early initialization, whereas
>>>> the policy is only available for measurement once we have loaded an
>>>> initial policy.
>>> Ok, measuring the policy separately from other critical data makes
>>> sense.  Instead of measuring the policy, which is large, measure the
>>> policy hash.
>> I think that was the original approach.  However, I had concerns with
>> adding code to SELinux to compute a hash over the policy versus
>> leaving that to IMA's existing policy and mechanism.  If that's
>> preferred I guess we can do it that way but seems less flexible and
>> duplicative.
> In AppArmor, we store the sha1 of the raw policy as the policy is
> loaded. The hash is exposed to userspace in apparmorfs. See commit
> 5ac8c355ae00 ("apparmor: allow introspecting the loaded policy pre
> internal transform").
>
> It has proved useful as a mechanism for debugging as sometimes the
> on-disk policy doesn't match the loaded policy and this can be a good
> way to check that while providing support to users. John also mentions
> checkpoint/restore in the commit message and I could certainly see how
> the policy hashes would be useful in that scenario.
>
> When thinking through how Lakshmi's series could be extended for
> AppArmor support, I was thinking that the AppArmor policy measurement
> would be a measurement of these hashes that we already have in place.
>
> Perhaps there's some general usefulness in storing/exposing an SELinux
> policy hash rather than only seeing it as duplicative property required
> this measurement series?

That would be a hash of the policy file that was last loaded via the 
selinuxfs interface for loading policy, not a hash of the in-memory 
policy data structures at the time of measurement (which is what this 
patch series is implementing).  The duplicative part is with respect to 
selecting a hash algorithm and hashing the in-memory policy as part of 
the SELinux code rather than just passing the policy buffer to IMA for 
measurement like any other buffer.  Userspace can already hash the 
in-memory policy data itself by running sha256sum or whatever on 
/sys/fs/selinux/policy, so we don't need to save or expose that separately.


