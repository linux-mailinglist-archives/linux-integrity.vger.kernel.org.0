Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00271DF2F4
	for <lists+linux-integrity@lfdr.de>; Sat, 23 May 2020 01:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbgEVXZS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 May 2020 19:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387449AbgEVXZR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 May 2020 19:25:17 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF34C08C5C0
        for <linux-integrity@vger.kernel.org>; Fri, 22 May 2020 16:25:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id v2so810902pfv.7
        for <linux-integrity@vger.kernel.org>; Fri, 22 May 2020 16:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xcdARewyTG4POyZ7ltQhfJJu9Qv+Bxm+E+lkKjlpIsE=;
        b=fTK4N1uv4Kn/dR2zzPbD0jHTR52W93tW49eGy+Fa0Hl+4Be6712kZ/QI6oxwFpFI/a
         ZHU1PWctlZrqE3qr5XCDpuTkl3C2l7HVsfv5S3tv6i6eNIa81bBVA7dSqbl/5Pq6FUZs
         ABEWWzVogKKhogjSPk2sGmAiiVj+evSbq4uJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xcdARewyTG4POyZ7ltQhfJJu9Qv+Bxm+E+lkKjlpIsE=;
        b=SzfZylWYBUnm/o97+TX2srcqdhor6hk7ImlVfCXbRIwyHZVmd4iE//SWP+442xsEY4
         dvK4aEtS4N61O/Gf6c3LldTPAnAkCIPGnaTIQ2yb6HCeiwHnRByQf5v//8D/WgytUUYH
         qGzWIzH5mInGANJi8k6mxAjR8ESTsIV/E4S1Gr7fTjVFRmF/08gOkcJ5A+e90hV5UDRv
         pLvHqI6nbATH+iXEBc429wHJJLvVD6zylEg18obv6MIeGCeqKl5lJtutkQnYwYKD87D2
         K+TUvepAb5EUg51fG6+6diTHGfz5XO8xiBnxnoNJFDYmF0Yi0TLUKkhbeqY9Mb3ZJKsk
         EW1Q==
X-Gm-Message-State: AOAM530ZlibICmQYYpiAY/eIrri/kYp6jzdcyVASprO22wWYnTia9c++
        V6IF7FTQmVLLOACu9aiYtgNC9g==
X-Google-Smtp-Source: ABdhPJxYA3M7TqBzRS04SzG465as6Jpo33/yu9zFOYOedvseWiYUZylkj5NdgSLEDNI/UVu5rIrHaw==
X-Received: by 2002:a62:2f45:: with SMTP id v66mr6455014pfv.45.1590189916382;
        Fri, 22 May 2020 16:25:16 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m12sm7637602pjs.41.2020.05.22.16.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 16:25:15 -0700 (PDT)
Subject: Re: [PATCH 0/3] fs: reduce export usage of kerne_read*() calls
To:     Kees Cook <keescook@chromium.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        ebiederm@xmission.com, jeyu@kernel.org, jmorris@namei.org,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, nayna@linux.ibm.com,
        dan.carpenter@oracle.com, skhan@linuxfoundation.org,
        geert@linux-m68k.org, tglx@linutronix.de, bauerman@linux.ibm.com,
        dhowells@redhat.com, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513181736.GA24342@infradead.org>
 <20200515212933.GD11244@42.do-not-panic.com>
 <20200518062255.GB15641@infradead.org>
 <1589805462.5111.107.camel@linux.ibm.com>
 <7525ca03-def7-dfe2-80a9-25270cb0ae05@broadcom.com>
 <202005221551.5CA1372@keescook>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <c48a80f5-a09c-6747-3db8-be23a260a0cb@broadcom.com>
Date:   Fri, 22 May 2020 16:25:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <202005221551.5CA1372@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Kees,

On 2020-05-22 4:04 p.m., Kees Cook wrote:
> On Fri, May 22, 2020 at 03:24:32PM -0700, Scott Branden wrote:
>> On 2020-05-18 5:37 a.m., Mimi Zohar wrote:
>>> On Sun, 2020-05-17 at 23:22 -0700, Christoph Hellwig wrote:
>>>> On Fri, May 15, 2020 at 09:29:33PM +0000, Luis Chamberlain wrote:
>>>>> On Wed, May 13, 2020 at 11:17:36AM -0700, Christoph Hellwig wrote:
>>>>>> Can you also move kernel_read_* out of fs.h?  That header gets pulled
>>>>>> in just about everywhere and doesn't really need function not related
>>>>>> to the general fs interface.
>>>>> Sure, where should I dump these?
>>>> Maybe a new linux/kernel_read_file.h?  Bonus points for a small top
>>>> of the file comment explaining the point of the interface, which I
>>>> still don't get :)
>>> Instead of rolling your own method of having the kernel read a file,
>>> which requires call specific security hooks, this interface provides a
>>> single generic set of pre and post security hooks.  The
>>> kernel_read_file_id enumeration permits the security hook to
>>> differentiate between callers.
>>>
>>> To comply with secure and trusted boot concepts, a file cannot be
>>> accessible to the caller until after it has been measured and/or the
>>> integrity (hash/signature) appraised.
>>>
>>> In some cases, the file was previously read twice, first to measure
>>> and/or appraise the file and then read again into a buffer for
>>> use.  This interface reads the file into a buffer once, calls the
>>> generic post security hook, before providing the buffer to the caller.
>>>    (Note using firmware pre-allocated memory might be an issue.)
>>>
>>> Partial reading firmware will result in needing to pre-read the entire
>>> file, most likely on the security pre hook.
>> The entire file may be very large and not fit into a buffer.
>> Hence one of the reasons for a partial read of the file.
>> For security purposes, you need to change your code to limit the amount
>> of data it reads into a buffer at one time to not consume or run out of much
>> memory.
> Hm? That's not how whole-file hashing works. :)

>
> These hooks need to finish their hashing and policy checking before they
> can allow the rest of the code to move forward. (That's why it's a
> security hook.) If kernel memory utilization is the primary concern,
> then sure, things could be rearranged to do partial read and update the
> hash incrementally, but the entire file still needs to be locked,
> entirely hashed by hook, then read by the caller, then unlocked and
> released.
>
> So, if you want to have partial file reads work, you'll need to
> rearchitect the way this works to avoid regressing the security coverage
> of these operations.
I am not familiar with how the security handling code works at all.
Is the same security check run on files opened from user space?
A file could be huge.

If it assumes there is there is enough memory available to read the 
entire file into kernel space
then the improvement below can be left as a memory optimization to be 
done in
an independent (or future) patch series.

> So, probably, the code will look something like:
>
>
> file = kernel_open_file_for_reading(...)
> 	file = open...
> 	disallow_writes(file);
> 	while (processed < size-of-file) {
> 		buf = read(file, size...)
> 		security_file_read_partial(buf)
> 	}
> 	ret = security_file_read_finished(file);
> 	if (ret < 0) {
> 		allow_writes(file);
> 		return PTR_ERR(ret);
> 	}
> 	return file;
>
> while (processed < size-of-file) {
> 	buf = read(file, size...)
> 	firmware_send_partial(buf);
> }
>
> kernel_close_file_for_reading(file)
> 	allow_writes(file);
>
>

