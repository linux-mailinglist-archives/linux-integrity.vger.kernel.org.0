Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256C236295C
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Apr 2021 22:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245450AbhDPUdB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Apr 2021 16:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245017AbhDPUdA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Apr 2021 16:33:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAC9C061574;
        Fri, 16 Apr 2021 13:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=5JpOyi2btqDexH91tjXQOgOsvUakTgPwzwHL+y/0r+w=; b=gnOA+R9LoD3iBsz3nvsKcyYqNt
        zRjyXfTIagRzAzxD8dN6roXXW+9kAWTt1iQta3S3cAd1DGFMZdUmpv2lserftPVS61X4pKEWtkRlK
        VW1lk1GFZXiL0MP4F5rKnZ9uwR6mCnFAM5RrqxlqVcFoASuJ+4LKsaEEi0oorzRFABkRiQbzFTzKA
        49PemZEACFvqainzKYZP3a5Aw1xXbDsSpUes3hQ+iRjOjqn1lQo4FWn9zO6k+CusTna2/+Z0dMrCl
        YvWN5xLtzOSmgQkUxe0y6LdMCxewWR7ZQ1bwS7HMYk3C/UgcGDaDgy8nNZPPr81MtchBDrl2t8Aj4
        afL/PiCQ==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.253])
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lXV8V-00APsR-GY; Fri, 16 Apr 2021 20:32:25 +0000
Subject: Re: linux-next: Tree for Apr 16 (IMA appraise causing build error)
To:     Nayna <nayna@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <20210416213625.14542675@canb.auug.org.au>
 <80839e94-f72c-4d2c-6b3a-b68beea72a27@infradead.org>
 <3b06deaa-2ec1-88cd-87aa-970b9fa4315a@linux.vnet.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8fbd9822-bc70-f103-ace9-22733b8475e5@infradead.org>
Date:   Fri, 16 Apr 2021 13:32:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <3b06deaa-2ec1-88cd-87aa-970b9fa4315a@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 4/16/21 1:25 PM, Nayna wrote:
> 
> On 4/16/21 2:53 PM, Randy Dunlap wrote:
>> On 4/16/21 4:36 AM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20210415:
>>>
>> I noticed this build error message (on an i386 build):
>>
>> ../certs/Makefile:52: *** Could not determine digest type to use from kernel config.  Stop.
>>
>> and when I was checking on why it happened, I noticed that
>> # CONFIG_MODULES is not set
>>
>> and hence
>> ifndef CONFIG_MODULE_SIG_HASH
>> $(error Could not determine digest type to use from kernel config)
>> endif
>>
>> CONFIG_MODULE_SIG_HASH is not set/enabled/defined.
>>
>> However, the .config file does have
>> CONFIG_IMA_APPRAISE=y
>> # CONFIG_IMA_ARCH_POLICY is not set
>> # CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
>> CONFIG_IMA_APPRAISE_BOOTPARAM=y
>> CONFIG_IMA_APPRAISE_MODSIG=y
>>
>> as well as
>> CONFIG_MODULE_SIG_FORMAT=y
>>
>> due to a "select" by IMA_APPRAISE_MODSIG.
>> (although I see that MODULE_SIG_FORMAT does not depend on MODULES)
>>
>>
>> Is there anything that you can do (or recommend) to prevent
>> the build error?
>>
>>
>>
>> BTW, it looks like this:
>> config IMA_APPRAISE_REQUIRE_MODULE_SIGS
>>     bool "Appraise kernel modules signatures"
>>     depends on IMA_APPRAISE_BUILD_POLICY
>>
>> could also depend on MODULES.
>>
>>
>>
>> Full i386 randconfig file is attached.
> 
> 
> With the new patchset "ima: kernel build support for loading the kernel module signing key", there shouldn't be a difference when generating the config file between MODULE_SIG and IMA_APPRAISE_MODSIG. Both prompt for the hash algorithm.

That patchset appears to be included in today's linux-next 2021-04-16.

> Can you please explain how you generate randconfig? Do you use make xconfig?

with the 'make randconfig' command.


-- 
~Randy

