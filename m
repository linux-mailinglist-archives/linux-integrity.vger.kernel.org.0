Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAD5132EB2
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jan 2020 19:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgAGSwF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jan 2020 13:52:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55587 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728425AbgAGSwF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jan 2020 13:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578423124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VErRlwO5Ymf/mDUAeuLrx6IdZ2Ci3A9/OC+EwB3cogU=;
        b=EJTKJF/6KvLnr6StV47sHeKXipQuvAY3oSMJb5FF1jtA1FcqUjT5ahdLihuDN3W4kt8krx
        oflwXLcuCnerD+jdncmDMkWltrRKqSDlURjHOIOESRASCzzdwAQFCw8M55EpUyJY+VJNbI
        20GxYr7ps+LvvTn+q3VXdhqfrDYFx3Y=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-DaYUn5OtNHy7TToxc2npaw-1; Tue, 07 Jan 2020 13:52:03 -0500
X-MC-Unique: DaYUn5OtNHy7TToxc2npaw-1
Received: by mail-qv1-f72.google.com with SMTP id ce17so499957qvb.5
        for <linux-integrity@vger.kernel.org>; Tue, 07 Jan 2020 10:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=VErRlwO5Ymf/mDUAeuLrx6IdZ2Ci3A9/OC+EwB3cogU=;
        b=a/T1XgQbG4Uc2JqhQKJGmT+SO1dfzsItYfn/WmwKsqzR0e7KYE2kXaL3sKwjLDivXu
         3u5Fcpyo7iOQaaf9io7qJfYDRWh+FTvTUDB+/2hNLM82nA9aNr/Iu2sN2YTcoZOAc8Sk
         Rt7bcE695+eCXRz5ukk4SHsDOLcYdUmk5MkRBvg/jWttOFWs3k3OXXwY/nNQZRj/ZLk8
         ckTgwFdp3RbgRHevW35EieO3MV1yHNzdhnwL4pid+ubC6sU48MbPFs3HRK+cNf7NOC4w
         Ds0eIVLZjaGaRCoPaovKa6t3YJV0NmlshBkAjoyd2qU+DhlzEIO0NyGKLzeySJBFqW3O
         l2iA==
X-Gm-Message-State: APjAAAXTy8vDRxol9qEvIXuxj72yzVwHzKSf/KYWEoYbOjEooenpxXVo
        m19mpsbg3ZFG9Kx4I/83fMkg0yrXEWjsj0FxD2xR1ZS6F9BgGwAzf7hZ3fa0hnnhIRCUZ2WoY3D
        FEcvR17xAM3S90hrq9oSS9mm90ott
X-Received: by 2002:a05:620a:1467:: with SMTP id j7mr743489qkl.76.1578423122088;
        Tue, 07 Jan 2020 10:52:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqyR0JS6estJWyDeOP24MAGmqxrnl0mMWFA6iohfjOV36L4F3MNNN2VxLjUQQMYR1bbDv8jQQg==
X-Received: by 2002:a05:620a:1467:: with SMTP id j7mr743467qkl.76.1578423121800;
        Tue, 07 Jan 2020 10:52:01 -0800 (PST)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id q25sm226420qkq.88.2020.01.07.10.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 10:52:01 -0800 (PST)
To:     Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
From:   Laura Abbott <labbott@redhat.com>
Subject: Bad usercopy from tpm after d23d12484307 ("tpm: fix invalid locking
 in NONBLOCKING mode")
Message-ID: <b85fa669-d3aa-f6c9-9631-988ae47e392c@redhat.com>
Date:   Tue, 7 Jan 2020 13:51:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Fedora got two bug reports https://bugzilla.redhat.com/show_bug.cgi?id=1788653
https://bugzilla.redhat.com/show_bug.cgi?id=1788257 of a usercopy bug from
tpm:

[   67.037526] usercopy: Kernel memory exposure attempt detected from wrapped address (offset 0, size 18446634686907596985)!
[   67.037541] ------------[ cut here ]------------
[   67.037543] kernel BUG at mm/usercopy.c:99!
[   67.037550] invalid opcode: 0000 [#1] SMP PTI
[   67.037553] CPU: 1 PID: 3277 Comm: tpm2-abrmd Not tainted 5.4.7-200.fc31.x86_64 #1
[   67.037555] Hardware name: Dell Inc. Latitude 5580/0FH6CJ, BIOS 1.16.0 07/03/2019
[   67.037562] RIP: 0010:usercopy_abort+0x77/0x79
[   67.037565] Code: 4c 0f 45 de 51 4c 89 d1 48 c7 c2 e3 ce 35 b0 57 48 c7 c6 30 80 34 b0 48 c7 c7 a8 cf 35 b0 48 0f 45 f2 4c 89 da e8 50 6c e4 ff <0f> 0b 4c 89 e1 49 89 d8 44 89 ea 31 f6 48 29 c1 48 c7 c7 25 cf 35
[   67.037567] RSP: 0018:ffffae5b42eabe48 EFLAGS: 00010246
[   67.037570] RAX: 000000000000006d RBX: ffffffffffffffff RCX: 0000000000000000
[   67.037572] RDX: 0000000000000000 RSI: ffff9c83b6257908 RDI: ffff9c83b6257908
[   67.037574] RBP: ffff9c836686c0b9 R08: ffff9c83b6257908 R09: 000000000000007c
[   67.037576] R10: ffffae5b42eabcf8 R11: 0000000000000000 R12: ffff9c836686c0ba
[   67.037578] R13: 0000000000000001 R14: ffff9c836686c010 R15: ffff9c836686c0ba
[   67.037580] FS:  00007fb2dbfff700(0000) GS:ffff9c83b6240000(0000) knlGS:0000000000000000
[   67.037582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   67.037584] CR2: 00007fc1137f3e00 CR3: 00000002205c4002 CR4: 00000000003606e0
[   67.037586] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   67.037588] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   67.037589] Call Trace:
[   67.037595]  __check_object_size.cold+0x46/0x80
[   67.037600]  tpm_common_read+0x74/0x140
[   67.037605]  vfs_read+0x9d/0x150
[   67.037610]  ksys_read+0x5f/0xe0
[   67.037615]  do_syscall_64+0x5b/0x1a0
[   67.037620]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

I think this is related to d23d12484307 ("tpm: fix invalid locking in NONBLOCKING mode")
Specifically, if tpm_try_get_ops fails I don't think we should be putting the error
code in priv->response_length since tpm_common_read doesn't seem to account for
negative errno values.

I don't have a reproducer since this was just what was reported to Fedora's bug
reporter but both reports happened after that commit landed in stable.

Thanks,
Laura

