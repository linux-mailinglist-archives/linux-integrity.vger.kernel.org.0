Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE2F27B876
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Sep 2020 01:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgI1XvE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 19:51:04 -0400
Received: from linux.microsoft.com ([13.77.154.182]:46878 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgI1XvE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 19:51:04 -0400
Received: from [192.168.1.12] (c-24-16-6-251.hsd1.wa.comcast.net [24.16.6.251])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6885420B7178;
        Mon, 28 Sep 2020 15:31:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6885420B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601332299;
        bh=bD9fMoyf3+5YIghWGXuM1TXkhY1JnyytLtuTzPy6xVw=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=kwxDYxZhx8J7OYvu0uoTsu3xM8DtVWv4mKe5+nkr0pEYWhXxNZF3Pnk30npAy73fK
         iEovSUM3jUBwJtKRInEBVSEKyufMKVxwV/UE6+oTg28F2Rhi+ImIULyjLaMVLuSXBA
         dg4bSMtr2QCmAvkJNeupxkudp5rfiC4Nz4JbQaXU=
Subject: Re: Fwd: How to extract linux kernel version information from a
 kernel image?
To:     "Kayaalp, Mehmet" <Mehmet.Kayaalp@unh.edu>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <b8e9ee52-c0fd-a6cf-3054-4220636a60e9@linux.microsoft.com>
 <8bc330b9-d680-c00a-4bc1-c35cb21d2b34@linux.microsoft.com>
 <a1c877b3-9f99-04a6-2f21-495fc62d0591@unh.edu>
From:   Raphael Gianotti <raphgi@linux.microsoft.com>
Message-ID: <7ac370dd-20d5-757b-1574-d151332527f3@linux.microsoft.com>
Date:   Mon, 28 Sep 2020 15:31:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <a1c877b3-9f99-04a6-2f21-495fc62d0591@unh.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/25/2020 4:06 PM, Kayaalp, Mehmet wrote:
> On 9/24/20 4:05 PM, Raphael Gianotti wrote:
>> Forwarding this here since the final intent here is an IMA related
>> change to see if anyone has any suggestions.
>>
>>
>> -------- Forwarded Message --------
>> Subject:        How to extract linux kernel version information from a
>> kernel
>> image?
>> Date:   Fri, 18 Sep 2020 12:47:13 -0700
>> From:   Raphael Gianotti <raphgi@linux.microsoft.com>
>> To:     linux-kernel@vger.kernel.org
>>
>>
>>
>> Hi,
>>
>> I have been investigating a way to extract the version strong from a
>> kernel image (e.g., vmlinux). The version string I've been looking at is
>> essentially the linux_banner symbol.
>>
>> We'll use IMA to measure the version string on the kexec system call,
>> providing a way for an attestation service, for instance, to attest to
>> what version of the kernel is running on the client.
>>
>> I haven't found a way to extract the version from the image that isn't
>> simply searching the whole image for it. I was hoping someone here may
>> be able to point me to a better approach to retrieve the linux_banner
>> symbol value from an image or  any existing kernel code that does
>> similar parsing.
>>
>> If that matters for any suggestions, my current focus is on ARM64 images
>> (if the code ends up having to be arch specific).
>>
>> Thanks,
>>
>> -Raphael
>>
> In Linux/x86 Boot Protocol [1], the kernel header contains a pointer to
> the kernel_version string at offset 020E (2-byte value):
>
>       # hexdump -s 0x020E -n 2 -e '/2 "%x"'
> /boot/vmlinuz-5.4.0-48-generic; echo
>       3900
>
> Starting after the header (512 bytes), the string is 0x3900 bytes into
> the vmlinuz file:
>
>       # dd bs=1 skip=$((0x3900+512)) if=/boot/vmlinuz-5.4.0-48-generic
> |tr -s '\000' '\n'|head -n 1
>       5.4.0-48-generic (buildd@lcy01-amd64-010) #52-Ubuntu SMP Thu Sep 10
> 10:58:49 UTC 2020
>
> In ARM64, the vmlinux is stripped of symbols and compressed into the
> bzImage. To find the linux_banner, System.map file is needed:
>
>       # grep ' linux_banner$' /boot/System.map-5.4.0-48-generic
>       ffff800010df00d0 R linux_banner
>
> The offset into the file can be found by subtracting the load address:
>
>       # grep ' _head$' /boot/System.map-5.4.0-48-generic
>       ffff800010080000 t _head
>
>       # zcat /boot/vmlinuz-5.4.0-48-generic | dd bs=1
> skip=$((0xffff800010df00d0-0xffff800010080000)) | tr -s '\000' '\n' |
> head -n 1
>       Linux version 5.4.0-48-generic (buildd@bos02-arm64-053) (gcc
> version 9.3.0 (Ubuntu 9.3.0-10ubuntu2)) #52-Ubuntu SMP Thu Sep 10
> 11:01:50 UTC 2020 (Ubuntu 5.4.0-48.52-generic 5.4.60)
>
> [1]: https://www.kernel.org/doc/html/latest/x86/boot.html
>
> Mehmet

Regarding the arm64 vmlinux files, I've noticed in some, if you run the 
file command for them in the terminal, it does give a "not stripped" 
string in its result. Also, for those files, objdump does print out 
symbols, including linux_banner. I've found that out last Friday and I 
am in the process of looking at what the code for objdump to see how it 
finds the symbols there and see if I can get its value from the image. I 
wonder if I am missing something and that reported linux_banner symbol I 
get from objdump is not what I think it is, so do let me know if I am 
just wasting my time in investigating that when it comes to arm64.

Thanks,

Raphael

