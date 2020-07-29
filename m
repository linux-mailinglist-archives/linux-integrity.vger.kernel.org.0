Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44E023273C
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jul 2020 23:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgG2V7Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jul 2020 17:59:16 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43910 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgG2V7P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jul 2020 17:59:15 -0400
Received: by mail-lf1-f66.google.com with SMTP id b11so13870573lfe.10
        for <linux-integrity@vger.kernel.org>; Wed, 29 Jul 2020 14:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+1F0YzKT4E2jROFhpkTfqU0QL7yxCGv+PM/T3685PUY=;
        b=B8uBXKKknrY5i+3JEHFL7CTD6jZGRZW6AeMyThwrcBUzluRK9qYPn7s2C5LLRbGwH2
         MOh/RalqAbhC6clJdRKHvHHwsyvO5FaCwNFsVNHMGIzs3Voaf0sWBpMp0jj7dPBW3cJW
         Eax/PL8rMcnvGEvYiwevvJztAzo9i4kwcP8qo7MhoxtcQ30l5R8bRuhCx96HBzQdFeId
         zYSps9zO0GGMRBiOWl6zJUsJVaGRIKGq9u8MdqWPeAbWAsmu9QvLIv4TcG8eZzKrN/x3
         J64o6UeTsqioxI50zI6itfCaGF1rP5qfG49AVT47AwXbuohHq6ysMDwVzJ6ehY+jEH0A
         8rXQ==
X-Gm-Message-State: AOAM533ajC5ZGjzqkEioS2qW43C/B+SFvQn+3pFTquI9bUJvVe16SLcW
        BwCts0MFTJ0SI7qOhDRek8E=
X-Google-Smtp-Source: ABdhPJxdTx4IB3n5vkk9oa8RlYP2ldBrmxhiIvmHlEFvO/caOPz0c6y/0ZHbbrYRT5i6r7Eg0pSXjA==
X-Received: by 2002:a05:6512:36c2:: with SMTP id e2mr8845lfs.98.1596059952508;
        Wed, 29 Jul 2020 14:59:12 -0700 (PDT)
Received: from [10.68.32.147] (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.gmail.com with ESMTPSA id r19sm623880ljc.59.2020.07.29.14.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 14:59:11 -0700 (PDT)
Reply-To: efremov@linux.com
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
References: <bf04bf15-cddd-ce22-926a-8459c1f92779@linux.com>
 <ef2745fddaec4f859cf9852028f650df@huawei.com>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Subject: Re: IMA/EVM interfaces
Message-ID: <b3d93ebd-80a0-4aea-15ef-8bd22241e19f@linux.com>
Date:   Thu, 30 Jul 2020 00:59:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ef2745fddaec4f859cf9852028f650df@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 7/28/20 6:43 PM, Roberto Sassu wrote:
>> From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
>> owner@vger.kernel.org] On Behalf Of Denis Efremov
>> Sent: Tuesday, July 28, 2020 12:32 PM
>> Hi,
>>
>> I've started to add integrity interfaces descriptions to syzkaller
>> (https://github.com/google/syzkaller/pull/1970).
>>
>> I've got a question, if you don't mind:
>>
>> If I write 2 to /sys/kernel/security/integrity/evm/evm before loading keys,
>> subsequent fs operations will fail with -ENOKEY.
>>
>> $ echo 2 > /sys/kernel/security/integrity/evm/evm
>> $ touch test.txt
>> [  526.976855][ T5771] evm: HMAC key is not set
>> [  526.977892][ T5771] evm: init_desc failed
>> touch: cannot touch 'test.txt': Required key not available
>>
>> Is this a desired behavior? Should there be a check in evm_write_key()
>> for loaded keys (encrypted evm-key, keys in _evm, _ima keyrings) before
>> changing the evm_initialized bit? Is it correct to set second bit without
>> first bit?
> 
> Hi Denis
> 
> can you please try this patch?
> 
> https://lore.kernel.org/linux-integrity/20200618160133.937-1-roberto.sassu@huawei.com/
> 
> 

$ cat /proc/cmdline
console=ttyS0 root=/dev/sda earlyprintk=serial ima_appraise=fix evm=fix
$ echo 2 > /sys/kernel/security/integrity/evm/evm
[   44.116084][ T4108] evm: HMAC key is not set
$ touch test.txt
$ cat /sys/kernel/security/integrity/evm/evm
2
$ keyctl add user kmk-user "`cat /etc/keys/kmk-user.blob`" @u
$ keyctl add encrypted evm-key "load `cat /etc/keys/evm-user.blob`" @u
$ echo 1 > /sys/kernel/security/integrity/evm/evm
[  574.328262] evm: key initialized

Regards,
Denis
