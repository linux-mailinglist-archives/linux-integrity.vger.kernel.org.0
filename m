Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9F62AF5AB
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Nov 2020 17:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgKKQDb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Nov 2020 11:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgKKQDY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Nov 2020 11:03:24 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF1DC0617A6
        for <linux-integrity@vger.kernel.org>; Wed, 11 Nov 2020 08:03:23 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id l12so2446658ilo.1
        for <linux-integrity@vger.kernel.org>; Wed, 11 Nov 2020 08:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t1jRZwSuuEQg/bscnGGcsBqPGqmw90tTjNeAiADGZWQ=;
        b=J0hJSJOtZ8cKp8g+AeRYn4zxI0z474RogLJ5yTPblSThyhiNsosQswbzULN0LbKveR
         X0HAP1BB/hEjAalzEOtQYXHKBPj76Ny52sSHtoN3iZ+Hs8inttTe9EdPQNaO01FSCro6
         PYFW08h9SJjByeNV57EQfbTW7Znk7xIl6IRI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t1jRZwSuuEQg/bscnGGcsBqPGqmw90tTjNeAiADGZWQ=;
        b=JN4llvFWBH0XDaIDmwQ+nV86cqnBDkAd3Db3FkAOoPOPazvEFgk1cc4k6muYxo4MVQ
         /73k+cTuS/KSBBlI8jXjNF5MkZzZaC6m+PRdqMcgLv8CLpKPIahPdfGoCihkdrPZBHV7
         8HOhbTZkgzrWP06K5RCrMXJLpwsvzneOFUGN8X0o7oXv2r28G/oSyuqxgVJ4kcHKQ1EJ
         29DypuBYQjEAHTK70aMnV4tZPFLBvPJHvQi6vQTb1fiGDtE9690VYFdrU7Nja0BxuP3u
         7BNZkxcpqpa1+qQzdYVWIuL5Y20oN28/Toil8KTu9FjnoBAQc9EIaC7Nu8FNEBiZ+8jn
         zOLQ==
X-Gm-Message-State: AOAM531Ywx4iNDAauxw6X/46e3PiDVRpeYs+dda+cM3/pQs6YNJi/Rj6
        4M7mbFaab/r3tMJMu79qLQku7A==
X-Google-Smtp-Source: ABdhPJzfuPKbLPy0S959f+cmN74uBmhaZrB/aTXCrRPM53UdGcZ4oGHwyut2AWmWt1ZgJZjUJccyXg==
X-Received: by 2002:a92:6c11:: with SMTP id h17mr12292757ilc.270.1605110603170;
        Wed, 11 Nov 2020 08:03:23 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x14sm1533054ior.7.2020.11.11.08.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 08:03:22 -0800 (PST)
Subject: Re: [PATCH 00/13] Introduce seqnum_ops
To:     Matthew Wilcox <willy@infradead.org>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        peterz@infradead.org, rafael@kernel.org, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        minyard@acm.org, arnd@arndb.de, mchehab@kernel.org,
        rric@kernel.org, valentina.manea.m@gmail.com, shuah@kernel.org,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, skhan@linuxfoundation.org
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <20201111043304.GS17076@casper.infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e84de5d0-f2b2-5481-eb8e-47370d632c4d@linuxfoundation.org>
Date:   Wed, 11 Nov 2020 09:03:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201111043304.GS17076@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/10/20 9:33 PM, Matthew Wilcox wrote:
> On Tue, Nov 10, 2020 at 12:53:26PM -0700, Shuah Khan wrote:
>> There are a number of atomic_t usages in the kernel where atomic_t api
>> is used strictly for counting sequence numbers and other statistical
>> counters and not for managing object lifetime.
> 
> We already have something in Linux called a sequence counter, and it's
> different from this.  ID counter?  instance number?  monotonic_t?  stat_t?
> 

No results for monotonic_t or stat_t. Can you give me a pointer to what
your referring to.

thanks,
-- Shuah
