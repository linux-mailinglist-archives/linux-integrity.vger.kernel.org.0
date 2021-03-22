Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30405343A51
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Mar 2021 08:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhCVHLw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Mar 2021 03:11:52 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62657 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhCVHLY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Mar 2021 03:11:24 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 12M7B1lW083976;
        Mon, 22 Mar 2021 16:11:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Mon, 22 Mar 2021 16:11:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 12M7B1sG083972
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 22 Mar 2021 16:11:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH 2/2] integrity: double check iint_cache was
 initialized
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
References: <20210319200358.22816-1-zohar@linux.ibm.com>
 <20210319200358.22816-2-zohar@linux.ibm.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <8450c80a-104a-3f36-0963-0ae8fa69e0f2@i-love.sakura.ne.jp>
Date:   Mon, 22 Mar 2021 16:10:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210319200358.22816-2-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2021/03/20 5:03, Mimi Zohar wrote:
> The integrity's "iint_cache" is initialized at security_init().  Only
> after an IMA policy is loaded, which is initialized at late_initcall,
> is a file's integrity status stored in the "iint_cache".
> 
> All integrity_inode_get() callers first verify that the IMA policy has
> been loaded, before calling it.  Yet for some reason, it is still being
> called, causing a NULL pointer dereference.
> 
> As reported by Dmitry Vyukov:
> in qemu:
> qemu-system-x86_64       -enable-kvm     -machine q35,nvdimm -cpu
> max,migratable=off -smp 4       -m 4G,slots=4,maxmem=16G        -hda
> wheezy.img      -kernel arch/x86/boot/bzImage   -nographic -vga std
>  -soundhw all     -usb -usbdevice tablet  -bt hci -bt device:keyboard
>    -net user,host=10.0.2.10,hostfwd=tcp::10022-:22 -net
> nic,model=virtio-net-pci   -object
> memory-backend-file,id=pmem1,share=off,mem-path=/dev/zero,size=64M
>   -device nvdimm,id=nvdimm1,memdev=pmem1  -append "console=ttyS0
> root=/dev/sda earlyprintk=serial rodata=n oops=panic panic_on_warn=1
> panic=86400 lsm=smack numa=fake=2 nopcid dummy_hcd.num=8"   -pidfile
> vm_pid -m 2G -cpu host
> 

I tried similar command line (without "-enable-kvm" and without "-cpu host"
as I'm running from VMware, without "-soundhw all", without "-machine q35,nvdimm"
and "-device nvdimm,id=nvdimm1,memdev=pmem1" etc.) on 5.12-rc4. While I was finally
able to hit similar crash when I used "-smp 1" instead of "-smp 4", I suspect
this is not a integrity module's problem but a memory initialization/corruption
problem, for I got various different crashes (INT3) at memory allocation when
I was trimming command line options trying to reproduce the same crash.

Dmitry, do you get different crashes by changing command line arguments?
