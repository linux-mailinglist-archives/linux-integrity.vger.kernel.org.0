Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D5229C7E4
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Oct 2020 19:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897398AbgJ0S5z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Oct 2020 14:57:55 -0400
Received: from mail.rosalinux.ru ([195.19.76.54]:35980 "EHLO mail.rosalinux.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897368AbgJ0S5y (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Oct 2020 14:57:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 97124DC8993C4;
        Tue, 27 Oct 2020 21:51:55 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id r0Oc8ydLUol1; Tue, 27 Oct 2020 21:51:55 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 1FF54DC8993C5;
        Tue, 27 Oct 2020 21:51:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 1FF54DC8993C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=A1AAD92A-9767-11E6-A27F-AC75C9F78EF4; t=1603824715;
        bh=e6fK8X1XngjpqP8g53zG471V314227VjboyO4KjWlHw=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=qTslcug10Ki3eGEZN49CC+gaM/OVy3jhJ0c7HPYdVB5vE7b7hutQwCQhhkcDoVvzx
         v3UdEITt08a0IgJVd+f+C4YXxQWJ1vGlO89YZL/iHQnDgQhZM4qR1ee6XlhC6wVBO+
         ri0ftjb44jcvZVN4B1IZp0FLx4xIhQ5/HLhGYVQfK7ld9GMC8tszEman1aWtiTug9e
         6lHAKFujBe0XtJ3MhOEEuQxpkKJNhEMwSfbpFv6fias6DuekDV8wd/vGtcJ/VLXgN6
         1P5vf2L8jfeokWpksllEml4lPl5JnQdABwB8QXJ3OX2tHeGmPXPe6dgNxrqQh7afEZ
         YNSXTtwaWLtjA==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id neJH_KrNmFi5; Tue, 27 Oct 2020 21:51:55 +0300 (MSK)
Received: from [192.168.1.173] (broadband-90-154-70-7.ip.moscow.rt.ru [90.154.70.7])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id 97242DC8993C4;
        Tue, 27 Oct 2020 21:51:54 +0300 (MSK)
Subject: Re: [PATCH ima-evm-utils] boot_aggregate.test: Skip if CONFIG_IMA not
 enabled
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Petr Vorel <petr.vorel@gmail.com>,
        Wartan Hachaturow <wart@debian.org>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
References: <20201019200803.35255-1-petr.vorel@gmail.com>
 <e274a823ca408f33c11ea03878442189e62d9f9b.camel@linux.ibm.com>
 <20201020180231.GA14580@dell5510>
 <26b4d298f9a71a796793f2ce730a95ebec442f29.camel@linux.ibm.com>
From:   Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Message-ID: <d0d1ad6c-5569-486c-3131-9b4845bd6495@rosalinux.ru>
Date:   Tue, 27 Oct 2020 21:51:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <26b4d298f9a71a796793f2ce730a95ebec442f29.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: ru-RU
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

27.10.2020 19:06, Mimi Zohar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> [Cc'ing Wartan Hachaturow]
>
> Hi Wartan,
>
> On Tue, 2020-10-20 at 20:02 +0200, Petr Vorel wrote:
>>>> [1] https://bugs.debian.org/972459 linux: Reenable CONFIG_IMA
>>> I wasn't aware that because of lockdown, IMA was disabled.  Thank you
>>> for reporting and updating the IMA w/lockdown status.
>> Feel free to comment it, please. It'd be nice to have IMA in Debian (n=
ot sure
>> about Ubuntu status).
>>
>> @Dmitry: do you plan to update Debian package? (you're the listed main=
tainer,
>> although the package was signed by Wartan Hachaturow).
> Earlier this year Dmitry Eremin-Solenikov posted a patch to add
> libressl support to ima-evm-utils.  Part of the reason for our adding
> travis support was in order to create a testing matrix for testing
> openssl, libressl, ibmtss and tpm2-tss, which further led to the
> travis-docker distro support.  (Due to some issues, the libressl
> support was not upstreamed.)

Mimi, it was me who posted patch for LibreSSL ("[PATCH] ima-evm-utils: Fi=
x compatibility with LibreSSL"), but unfortunately I did not have enough =
time to finish it properly (I am very sorry...).

I was just going to try a newer version of ima-evm-utils and, if possible=
, continue upstreamizing support of LibreSSL. also, a colleague of mine m=
ade an additional patch which requires separate upstreamization. Was ther=
e another patch from Dmitry about which I do not know

