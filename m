Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9491A413
	for <lists+linux-integrity@lfdr.de>; Fri, 10 May 2019 22:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfEJUqE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 May 2019 16:46:04 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33229 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfEJUqD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 May 2019 16:46:03 -0400
Received: by mail-oi1-f193.google.com with SMTP id m204so5520087oib.0
        for <linux-integrity@vger.kernel.org>; Fri, 10 May 2019 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aj6INEqnnfoQNhyU5G7iw5JJmBhRXMSKlpuNHBS6Zik=;
        b=RUS1u52QMGXhtmf6NRCHIrzXEoaN3rFUW9pkgWLoZZ/UVaEQXywiJB9ZHGrvG+E5ca
         2GGYdp0mldCJnm1zE4Png/lpgHEWd0dki4rG2TWPVZNwPtjkH+onGmDNDap4ySjHRU5L
         ijk4gDOGgTTThNQTw5ZrovFwcwUUSI/K/+IuGRIx5qmh597mFvjxEiphK3DcL8ooFbWQ
         RBcyReeKi40Rtp24bcEnymoPElT6C/olCSYSrSYR6wHWipzRbOvrrPOMPa+oHTSeRWzd
         dAD9v7yG8hRCFFwcxwj2TLXadD6bRo2gBoaS2yo7q6lALLa0PJwQdD5xqR5xHr8xJArg
         tDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aj6INEqnnfoQNhyU5G7iw5JJmBhRXMSKlpuNHBS6Zik=;
        b=dyMwfLfH7HtiNj6lHJTGQdIC9PZOKU3lcivHFhPOf75cM10/b+PRyGeETtped4P19Q
         RYrH4eSCRudiToXc+/V2JBfNwTjE5RL4kbC9idVk/lHTiJiVfcVe4BkGvtuW/M0rwGL4
         eW9zZI1rFM9i24MAxBCysMJTUTGCKgfkvvPGMwjjwCoQ6BGu0IBAYxVyIaYmeq1Fho9X
         nb21iY+hVCv3CVwsoCyxI8XjMAiIBX0hV/O+2Xt/nexzbCrtBPqkelP9dGCeRwo9vbCF
         57gS+LqxmdVfM0P2bEgbQL1zw9LUg/ECRtCC0HW5vpLToCHvoGZ2Pig/qVsmgGgNpUOM
         /RBg==
X-Gm-Message-State: APjAAAVCVy4yC/PLJBw//mguXPe0CRRetSPh3RiYiqhmVlngoH9v+y1O
        9BAs9ORU6xhNMA9Ewz6ANBjWiA==
X-Google-Smtp-Source: APXvYqyErglKg5iNl3+gNAkIG/E1H2w5zvgHUFe+9TQW6qpQh3DFRs8JwhYnl/pmUpL9cX/YWphefQ==
X-Received: by 2002:a54:4e1d:: with SMTP id a29mr512160oiy.92.1557521162786;
        Fri, 10 May 2019 13:46:02 -0700 (PDT)
Received: from [192.168.1.5] (072-182-052-210.res.spectrum.com. [72.182.52.210])
        by smtp.googlemail.com with ESMTPSA id r23sm1303599otg.49.2019.05.10.13.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 13:46:02 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        viro@zeniv.linux.org.uk
Cc:     linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com,
        arnd@arndb.de, james.w.mcmechan@gmail.com
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
 <fca8e601-1144-1bb8-c007-518651f624a5@landley.net>
 <bf0d02fc-d6ce-ef1d-bb7d-7ca14432c6fd@huawei.com>
 <1557488971.10635.102.camel@linux.ibm.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <3a9d717e-0e12-9d62-a3cf-afb7a5dbf166@landley.net>
Date:   Fri, 10 May 2019 15:46:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557488971.10635.102.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/10/19 6:49 AM, Mimi Zohar wrote:
> On Fri, 2019-05-10 at 08:56 +0200, Roberto Sassu wrote:
>> On 5/9/2019 8:34 PM, Rob Landley wrote:
>>> On 5/9/19 6:24 AM, Roberto Sassu wrote:
> 
>>>> The difference with another proposal
>>>> (https://lore.kernel.org/patchwork/cover/888071/) is that xattrs can be
>>>> included in an image without changing the image format, as opposed to
>>>> defining a new one. As seen from the discussion, if a new format has to be
>>>> defined, it should fix the issues of the existing format, which requires
>>>> more time.
>>>
>>> So you've explicitly chosen _not_ to address Y2038 while you're there.
>>
>> Can you be more specific?
> 
> Right, this patch set avoids incrementing the CPIO magic number and
> the resulting changes required (eg. increasing the timestamp field
> size), by including a file with the security xattrs in the CPIO.  In
> either case, including the security xattrs in the initramfs header or
> as a separate file, the initramfs, itself, needs to be signed.

The /init binary in the initramfs runs as root and launches all other processes
on the system. Presumably it can write any xattrs it wants to, and doesn't need
any extra permissions granted to it to do so. But as soon as you start putting
xattrs on _other_ files within the initramfs that are _not_ necessarily running
as PID 1, _that's_ when the need to sign the initramfs comes in?

Presumably the signing occurs on the gzipped file. How does that affect the cpio
parsing _after_ it's decompressed? Why would that be part of _this_ patch?

Rob
