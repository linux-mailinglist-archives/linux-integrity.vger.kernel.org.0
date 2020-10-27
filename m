Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED0629C8E7
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Oct 2020 20:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503675AbgJ0T3r (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Oct 2020 15:29:47 -0400
Received: from mail.rosalinux.ru ([195.19.76.54]:39766 "EHLO mail.rosalinux.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1829990AbgJ0T3r (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Oct 2020 15:29:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 25900DDEC956E;
        Tue, 27 Oct 2020 22:29:45 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id iq2fQaJOxZPC; Tue, 27 Oct 2020 22:29:44 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 67389DDEC956F;
        Tue, 27 Oct 2020 22:29:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 67389DDEC956F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=A1AAD92A-9767-11E6-A27F-AC75C9F78EF4; t=1603826984;
        bh=iDp5FUz0DPlIEw4CCxf18qLnnBTyg+5SyvW/Jfouk54=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=uVTO0kiIFbvFsX0LTBNQsEwg/4zbfwH0psWUP4uRpVhpKjTJD7FB9tZ/sf9jg4HH9
         AXq/rW4koA0zC5VyiyrbFDEzXm3+9FdzhLCs8xPDVzZ81kiKmCetJKpewwgXsKhlQo
         /hOT3a3qpTIOcfeEIw7o3q0IdjW/7Nt2gnBlQNbOqhxHg0oaGZvcoCf9v8W/rn9LTx
         BzF1NM9Pviesg0Yn4wZZrkdTMr/JmdbuOg8cAygMuVwoTaUBgD1HFEL54s9pjPZBFe
         ShvbafYJ8vR9ldnofnBQR0kL2YbJaV1R+1leGEgu6OujLz03D4Ex5xOyfpAcnqX6KC
         mHhFdYS7LYpbA==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GVWlWXnQpr-V; Tue, 27 Oct 2020 22:29:44 +0300 (MSK)
Received: from [192.168.1.173] (broadband-90-154-70-7.ip.moscow.rt.ru [90.154.70.7])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id CE913DDEC956E;
        Tue, 27 Oct 2020 22:29:43 +0300 (MSK)
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
 <d0d1ad6c-5569-486c-3131-9b4845bd6495@rosalinux.ru>
 <6d213e5decd0bf1290ae37e2da353aae504f2581.camel@linux.ibm.com>
From:   Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Message-ID: <bd321cc1-260c-0ed2-2143-dac2b7489903@rosalinux.ru>
Date:   Tue, 27 Oct 2020 22:29:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6d213e5decd0bf1290ae37e2da353aae504f2581.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


27.10.2020 22:06, Mimi Zohar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Tue, 2020-10-27 at 21:51 +0300, Mikhail Novosyolov wrote:
>> Hello,
>>
>> 27.10.2020 19:06, Mimi Zohar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> [Cc'ing Wartan Hachaturow]
>>>
>>> Hi Wartan,
>>>
>>> On Tue, 2020-10-20 at 20:02 +0200, Petr Vorel wrote:
>>>>>> [1] https://bugs.debian.org/972459 linux: Reenable CONFIG_IMA
>>>>> I wasn't aware that because of lockdown, IMA was disabled.  Thank y=
ou
>>>>> for reporting and updating the IMA w/lockdown status.
>>>> Feel free to comment it, please. It'd be nice to have IMA in Debian =
(not sure
>>>> about Ubuntu status).
>>>>
>>>> @Dmitry: do you plan to update Debian package? (you're the listed ma=
intainer,
>>>> although the package was signed by Wartan Hachaturow).
>>> Earlier this year Dmitry Eremin-Solenikov posted a patch to add
>>> libressl support to ima-evm-utils.  Part of the reason for our adding
>>> travis support was in order to create a testing matrix for testing
>>> openssl, libressl, ibmtss and tpm2-tss, which further led to the
>>> travis-docker distro support.  (Due to some issues, the libressl
>>> support was not upstreamed.)
>> Mimi, it was me who posted patch for LibreSSL ("[PATCH] ima-evm-
>> utils: Fix compatibility with LibreSSL"), but unfortunately I did not
>> have enough time to finish it properly (I am very sorry...).
>>
>> I was just going to try a newer version of ima-evm-utils and, if
>> possible, continue upstreamizing support of LibreSSL. also, a
>> colleague of mine made an additional patch which requires separate
>> upstreamization. Was there another patch from Dmitry about which I do
>> not know
> Mikhail, my mistake.  Thank you for the correction!   Testing the
> libressl changes should be a lot easier now.  Please remember to
> include a distro travis.yml example.

What do you mean? Do you mean adding testing of building ima-evm-utils ag=
ainst LibreSSL?

Which environment is used there and which ones are available? There are n=
ot many dsitros where LibreSSL is pre-packaged [1], in many of them it is=
 not updated often enough.
I would choose either ROSA where I myself maintain LibreSSL and ima-evm-u=
tils or Arch Linux, is at least Arch Linux available in CI/CD environment=
?
Won't we have to deal with often breakages of other parts of the rolling =
Arch Linux?

Also, I can just build LibreSSL from source in any available distro, e.g.=
 Ubuntu, but the pipeline will take a lot more time.

How do we better deal with it?

[1] https://repology.org/project/libressl/versions

