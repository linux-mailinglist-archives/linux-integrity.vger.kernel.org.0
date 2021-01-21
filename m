Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52E02FF029
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Jan 2021 17:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbhAUQYt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Jan 2021 11:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387844AbhAUQY3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jan 2021 11:24:29 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9FDC061786
        for <linux-integrity@vger.kernel.org>; Thu, 21 Jan 2021 08:23:48 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c127so2037848wmf.5
        for <linux-integrity@vger.kernel.org>; Thu, 21 Jan 2021 08:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zG4fhjKVJiNuv6SqQJL4fQU8mayLNazz740d5icTHSk=;
        b=ACQBorxu3/kwafewpeR3kASLaNW2qE3a+LeKpdv3M3TLSCnWLdjLbiYm+U6tjQV+RE
         ONy6LTJsNkMfU+MGdsm7xL5NqmfuKLFh3dXnZQWL0a9fSUos9Vn/jhVqCi8fwXEkaXOm
         5r+qexj+CeJ4/QQuaWLRcx++MWLjWrFRcA0Hehd6iwC0yUiCQNK02Y8hmvyyuEk9Rq1v
         r4BY60ZDPS+O6KufQY1Mm1oLPkkbwJCAs+zhkqu28cyPxoux8LhD31uZFLpShOmd/5N4
         UL7P/WTIhQcMzzt/lHKN+qZneImjTFe6iL/lNR9+SiBQseOY7Gc21I8BWl+cMlEz2R3y
         o7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zG4fhjKVJiNuv6SqQJL4fQU8mayLNazz740d5icTHSk=;
        b=sitI6qW89Bos92bdVwk/fdqNS8gG+6G3Bgts4/XRqYmgSn2At7sGNF9L4dmiHDQe1H
         VZuAaPHCn7y+c1M5hHDPhVN1DlUqvG8Selv8e7uMxmFcQw80oNk/DgUqJOI968BZoU+M
         aRhWyS5uIvsAI+PzCxd5V4eIglEBHF/4gUcXiBx4XPvGe9iZAaA/1jvst79t09Chh6nt
         eHVnrQx9cQzcSX+EX29cDaaZUxKUojMAGrgpOwTue/uS3zypUjokDGu748NtLEenlUdB
         kPkd6d3z0Q+ruB7LK6L+66a/LyfHa8QSVyHzkZt5+44MvrQ9XZ1texCEkV8MfoQEVf/0
         uRBg==
X-Gm-Message-State: AOAM532t6kMUWFlzOSn1E/dk4DliT+vVVx+pIqNZkktF8DRuLrETMZOv
        oYL2svkqD1VX17BqI14/FBMI7A==
X-Google-Smtp-Source: ABdhPJy7Jlp7SoWm7votj5JQCx3T1dGKSThe0DyKuoodKhe3dXjGdBt2Qq4v/5CcRHsGUxbv38P4cw==
X-Received: by 2002:a1c:2501:: with SMTP id l1mr129269wml.41.1611246227264;
        Thu, 21 Jan 2021 08:23:47 -0800 (PST)
Received: from ?IPv6:2a01:e0a:3cb:7bb0:7932:cf59:b36c:1f60? ([2a01:e0a:3cb:7bb0:7932:cf59:b36c:1f60])
        by smtp.gmail.com with ESMTPSA id w13sm9082040wrt.52.2021.01.21.08.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 08:23:46 -0800 (PST)
Subject: Re: [PATCH v8 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        op-tee@lists.trustedfirmware.org, Jonathan Corbet <corbet@lwn.net>,
        James Bottomley <jejb@linux.ibm.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <X/x+N0fgrzIZTeNi@kernel.org>
 <CAFA6WYOUvWAZtYfR4q8beZFkX-CtdxqwJaRQM+GHNMDfQiEWOA@mail.gmail.com>
 <X/+m6+m2/snYj9Vc@kernel.org>
 <CAFA6WYNyirit_AFhoE+XR9PHw=OjRgEdXDqz1uanj_SN2NXeMw@mail.gmail.com>
 <YAa0ys4YJcZtKdfF@kernel.org> <YAeH2pb8szQyjusL@kernel.org>
 <CAFA6WYP5G6NfGk96ePOC+2kpD6B+4hz9nywyUM9Nh=dJDYMiuA@mail.gmail.com>
 <01000177223f74d3-1eef7685-4a19-40d2-ace6-d4cd7f35579d-000000@email.amazonses.com>
 <dc3979e8-6bf0-adb7-164d-d50e805a048f@forissier.org>
 <YAmYu9FxWcLPhBhs@kernel.org> <YAmcyKnYCK+Y4IGW@kernel.org>
From:   Jerome Forissier <jerome@forissier.org>
Message-ID: <1486cfe8-bc30-1266-12bd-0049f2b64820@forissier.org>
Date:   Thu, 21 Jan 2021 17:23:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YAmcyKnYCK+Y4IGW@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/21/21 4:24 PM, Jarkko Sakkinen wrote:
> On Thu, Jan 21, 2021 at 05:07:42PM +0200, Jarkko Sakkinen wrote:
>> On Thu, Jan 21, 2021 at 09:44:07AM +0100, Jerome Forissier wrote:
>>>
>>>
>>> On 1/21/21 1:02 AM, Jarkko Sakkinen via OP-TEE wrote:
>>>> On Wed, Jan 20, 2021 at 12:53:28PM +0530, Sumit Garg wrote:
>>>>> On Wed, 20 Jan 2021 at 07:01, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>>>>>
>>>>>> On Tue, Jan 19, 2021 at 12:30:42PM +0200, Jarkko Sakkinen wrote:
>>>>>>> On Fri, Jan 15, 2021 at 11:32:31AM +0530, Sumit Garg wrote:
>>>>>>>> On Thu, 14 Jan 2021 at 07:35, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>>>>>>>>
>>>>>>>>> On Wed, Jan 13, 2021 at 04:47:00PM +0530, Sumit Garg wrote:
>>>>>>>>>> Hi Jarkko,
>>>>>>>>>>
>>>>>>>>>> On Mon, 11 Jan 2021 at 22:05, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Tue, Nov 03, 2020 at 09:31:44PM +0530, Sumit Garg wrote:
>>>>>>>>>>>> Add support for TEE based trusted keys where TEE provides the functionality
>>>>>>>>>>>> to seal and unseal trusted keys using hardware unique key.
>>>>>>>>>>>>
>>>>>>>>>>>> Refer to Documentation/tee.txt for detailed information about TEE.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>>>>>>>>>>>
>>>>>>>>>>> I haven't yet got QEMU environment working with aarch64, this produces
>>>>>>>>>>> just a blank screen:
>>>>>>>>>>>
>>>>>>>>>>> ./output/host/usr/bin/qemu-system-aarch64 -M virt -cpu cortex-a53 -smp 1 -kernel output/images/Image -initrd output/images/rootfs.cpio -serial stdio
>>>>>>>>>>>
>>>>>>>>>>> My BuildRoot fork for TPM and keyring testing is located over here:
>>>>>>>>>>>
>>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/buildroot-tpmdd.git/
>>>>>>>>>>>
>>>>>>>>>>> The "ARM version" is at this point in aarch64 branch. Over time I will
>>>>>>>>>>> define tpmdd-x86_64 and tpmdd-aarch64 boards and everything will be then
>>>>>>>>>>> in the master branch.
>>>>>>>>>>>
>>>>>>>>>>> To create identical images you just need to
>>>>>>>>>>>
>>>>>>>>>>> $ make tpmdd_defconfig && make
>>>>>>>>>>>
>>>>>>>>>>> Can you check if you see anything obviously wrong? I'm eager to test this
>>>>>>>>>>> patch set, and in bigger picture I really need to have ready to run
>>>>>>>>>>> aarch64 environment available.
>>>>>>>>>>
>>>>>>>>>> I would rather suggest you to follow steps listed here [1] as to test
>>>>>>>>>> this feature on Qemu aarch64 we need to build firmwares such as TF-A,
>>>>>>>>>> OP-TEE, UEFI etc. which are all integrated into OP-TEE Qemu build
>>>>>>>>>> system [2]. And then it would be easier to migrate them to your
>>>>>>>>>> buildroot environment as well.
>>>>>>>>>>
>>>>>>>>>> [1] https://lists.trustedfirmware.org/pipermail/op-tee/2020-May/000027.html
>>>>>>>>>> [2] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#qemu-v8
>>>>>>>>>>
>>>>>>>>>> -Sumit
>>>>>>>>>
>>>>>>>>> Can you provide 'keyctl_change'? Otherwise, the steps are easy to follow.
>>>>>>>>>
>>>>>>>>
>>>>>>>> $ cat keyctl_change
>>>>>>>> diff --git a/common.mk b/common.mk
>>>>>>>> index aeb7b41..663e528 100644
>>>>>>>> --- a/common.mk
>>>>>>>> +++ b/common.mk
>>>>>>>> @@ -229,6 +229,7 @@ BR2_PACKAGE_OPTEE_TEST_SDK ?= $(OPTEE_OS_TA_DEV_KIT_DIR)
>>>>>>>>  BR2_PACKAGE_OPTEE_TEST_SITE ?= $(OPTEE_TEST_PATH)
>>>>>>>>  BR2_PACKAGE_STRACE ?= y
>>>>>>>>  BR2_TARGET_GENERIC_GETTY_PORT ?= $(if
>>>>>>>> $(CFG_NW_CONSOLE_UART),ttyAMA$(CFG_NW_CONSOLE_UART),ttyAMA0)
>>>>>>>> +BR2_PACKAGE_KEYUTILS := y
>>>>>>>>
>>>>>>>>  # All BR2_* variables from the makefile or the environment are appended to
>>>>>>>>  # ../out-br/extra.conf. All values are quoted "..." except y and n.
>>>>>>>> diff --git a/kconfigs/qemu.conf b/kconfigs/qemu.conf
>>>>>>>> index 368c18a..832ab74 100644
>>>>>>>> --- a/kconfigs/qemu.conf
>>>>>>>> +++ b/kconfigs/qemu.conf
>>>>>>>> @@ -20,3 +20,5 @@ CONFIG_9P_FS=y
>>>>>>>>  CONFIG_9P_FS_POSIX_ACL=y
>>>>>>>>  CONFIG_HW_RANDOM=y
>>>>>>>>  CONFIG_HW_RANDOM_VIRTIO=y
>>>>>>>> +CONFIG_TRUSTED_KEYS=y
>>>>>>>> +CONFIG_ENCRYPTED_KEYS=y
>>>>>>>>
>>>>>>>>> After I've successfully tested 2/4, I'd suggest that you roll out one more
>>>>>>>>> version and CC the documentation patch to Elaine and Mini, and clearly
>>>>>>>>> remark in the commit message that TEE is a standard, with a link to the
>>>>>>>>> specification.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Sure, I will roll out the next version after your testing.
>>>>>>>
>>>>>>> Thanks, I'll try this at instant, and give my feedback.
>>>>>>
>>>>>> I bump into this:
>>>>>>
>>>>>> $ make run-only
>>>>>> ln -sf /home/jarkko/devel/tpm/optee/build/../out-br/images/rootfs.cpio.gz /home/jarkko/devel/tpm/optee/build/../out/bin/
>>>>>> ln: failed to create symbolic link '/home/jarkko/devel/tpm/optee/build/../out/bin/': No such file or directory
>>>>>> make: *** [Makefile:194: run-only] Error 1
>>>>>>
>>>>>
>>>>> Could you check if the following directory tree is built after
>>>>> executing the below command?
>>>>>
>>>>> $ make -j`nproc`
>>>>> CFG_IN_TREE_EARLY_TAS=trusted_keys/f04a0fe7-1f5d-4b9b-abf7-619b85b4ce8c
>>>>>
>>>>> $ tree out/bin/
>>>>> out/bin/
>>>>> ├── bl1.bin -> /home/sumit/build/optee/build/../trusted-firmware-a/build/qemu/release/bl1.bin
>>>>> ├── bl2.bin -> /home/sumit/build/optee/build/../trusted-firmware-a/build/qemu/release/bl2.bin
>>>>> ├── bl31.bin ->
>>>>> /home/sumit/build/optee/build/../trusted-firmware-a/build/qemu/release/bl31.bin
>>>>> ├── bl32.bin ->
>>>>> /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-header_v2.bin
>>>>> ├── bl32_extra1.bin ->
>>>>> /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-pager_v2.bin
>>>>> ├── bl32_extra2.bin ->
>>>>> /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-pageable_v2.bin
>>>>> ├── bl33.bin ->
>>>>> /home/sumit/build/optee/build/../edk2/Build/ArmVirtQemuKernel-AARCH64/RELEASE_GCC49/FV/QEMU_EFI.fd
>>>>> ├── Image -> /home/sumit/build/optee/build/../linux/arch/arm64/boot/Image
>>>>> └── rootfs.cpio.gz ->
>>>>> /home/sumit/build/optee/build/../out-br/images/rootfs.cpio.gz
>>>>>
>>>>> 0 directories, 9 files
>>>>>
>>>>> -Sumit
>>>>
>>>> I actually spotted a build error that was unnoticed last time:
>>>>
>>>> make[2]: Entering directory '/home/jarkko/devel/tpm/optee/edk2/BaseTools/Tests'
>>>> /bin/sh: 1: python: not found
>>>>
>>>> I'd prefer not to install Python2. It has been EOL over a year.
>>>
>>> AFAIK, everything should build fine with Python3. On my Ubuntu 20.04
>>> machine, this is accomplished by installing package "python-is-python3"
>>> (after uninstalling "python-is-python2" if need be).
>>>
>>> $ ls -l /usr/bin/python
>>> lrwxrwxrwx 1 root root 7 Apr 15  2020 /usr/bin/python -> python3
>>
>> Right, just found about this in unrelated context :-) [*]
>>
>> Hope this will work out...
>>
>> [*] https://github.com/surge-synthesizer/surge/pull/3655
> 
> Now I get
> 
> Traceback (most recent call last):
>   File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/RunTests.py", line 36, in <module>
>     allTests = GetAllTestsSuite()
>   File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/RunTests.py", line 33, in GetAllTestsSuite
>     return unittest.TestSuite([GetCTestSuite(), GetPythonTestSuite()])
>   File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/RunTests.py", line 25, in GetCTestSuite
>     import CToolsTests
>   File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/CToolsTests.py", line 22, in <module>
>     import TianoCompress
>   File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/TianoCompress.py", line 69, in <module>
>     TheTestSuite = TestTools.MakeTheTestSuite(locals())
>   File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/TestTools.py", line 43, in MakeTheTestSuite
>     for name, item in localItems.iteritems():
> AttributeError: 'dict' object has no attribute 'iteritems'

Right. Same here after removing all traces of Python2 from my system :-/

A couple of fixes are needed:
1. EDK2 needs to be upgraded to tag or later [1]
2. The PYTHON3_ENABLE environment variable needs to be set to TRUE [2]

[1] https://github.com/OP-TEE/manifest/pull/177
[2] https://github.com/OP-TEE/build/pull/450

HTH,
-- 
Jerome
