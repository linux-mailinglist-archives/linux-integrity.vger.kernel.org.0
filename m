Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAD92A9FC8
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Nov 2020 23:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgKFWQA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Nov 2020 17:16:00 -0500
Received: from mail.rosalinux.ru ([195.19.76.54]:35534 "EHLO mail.rosalinux.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728131AbgKFWP7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Nov 2020 17:15:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id CE212DB8EE21B;
        Sat,  7 Nov 2020 01:15:55 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hopWbOV1vp0F; Sat,  7 Nov 2020 01:15:55 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 39947DB8EE204;
        Sat,  7 Nov 2020 01:15:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 39947DB8EE204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=A1AAD92A-9767-11E6-A27F-AC75C9F78EF4; t=1604700955;
        bh=Ue6ZRRrBPjLGXdUu0xLub/SlWb78cpWnaDjMIMfLwtY=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=epSn7RlOjWUtFh7BHOK1XvN0CObN775w+8XVtsGUayqKCgKwhZRthfZKOGGSbF3S/
         IAgkLGfnDSZrqK6AZGsKQFBMDcoYtLyWEQOyeB7ff1K/kK9um3C5M6pA2bxTa3XZQu
         /0LCBQHDJ0Z5UXIudPIVMbGuZmcMMVcJw3fSweCkTXFznw4neYgsQ5Xj+B1QEB5aMl
         7y83QiolwCudSIkFBKL+7YQD/AFKngOm6oxnJ1BDZQkEirTu1kx5PVYpD+How10b4M
         Bq77WCz9PumvMTzB/EtdKJREXjJm1slBjSmiYTN2fj86aAwS4/Sqxc5rwwrKPzNeDv
         TIbzG5r6Wzpfg==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IvHGINrad3MD; Sat,  7 Nov 2020 01:15:55 +0300 (MSK)
Received: from [192.168.1.173] (broadband-90-154-71-72.ip.moscow.rt.ru [90.154.71.72])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id C71ACDB8D6477;
        Sat,  7 Nov 2020 01:15:54 +0300 (MSK)
Subject: Re: Selinux policy for x509_ima.der public certificate loaded by
 kernel during boot
To:     rishi gupta <gupt21@gmail.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org, selinux@vger.kernel.org
References: <CALUj-gt8KD4Cc-zgvXP-8vNdR3RB_Sdx7yd2cv7GX_wBCM6gEQ@mail.gmail.com>
 <28afd683-8423-0331-4b7d-ec71d46be30c@rosalinux.ru>
 <CALUj-gtyVJ9nLYWYbX2Oa9=dcCYqc2H0RkO4HQcJKj2ejAfSYg@mail.gmail.com>
From:   Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Message-ID: <bdd1becf-c72d-876a-cd9b-cef7b6fe55e9@rosalinux.ru>
Date:   Sat, 7 Nov 2020 01:15:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALUj-gtyVJ9nLYWYbX2Oa9=dcCYqc2H0RkO4HQcJKj2ejAfSYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


06.11.2020 18:50, rishi gupta =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Fri, Nov 6, 2020 at 8:42 PM Mikhail Novosyolov
> <m.novosyolov@rosalinux.ru> wrote:
>> 06.11.2020 15:22, rishi gupta =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> I am getting below error as selinux is denying access to the .ima
>>> keyring. Looking for guidance for asymmetric public key selinux
>>> policy.
>>>
>>> [  172.014855] integrity: Request for unknown key 'id:87deb3bf' err -=
13
>> I am getting the same error without selinux.
> If I make selinux permissive, it works for me. So I know in my case
> the problem is selinux.
>>> [  172.015035] audit: type=3D1800 audit(1604596570.579:240): pid=3D82=
5
>>> uid=3D1021 auid=3D4294967295 ses=3D4294967295
>>> subj=3Dsystem_u:system_r:mydaemon_t:s0-s15:c0.c1023 op=3D"appraise_da=
ta"
>>> cause=3D"invalid-signature" comm=3D"mydaemon"
>>> name=3D"/usr/lib/libstdc++.so.6.0.25" dev=3D"ubifs" ino=3D14353 res=3D=
0
>> Selinux context is just logged here. It has nothing to do with reasons=
 of ivalid signature. Public key seems to be not loaded.
> Basically when we access a file, driver checks if selinux allow access
> to it or not. In my case this function is returning -EACCES
> https://github.com/torvalds/linux/blob/master/security/keys/permission.=
c#L88
>>> (a) Do I need to set the selinux context of file
>>> /etc/keys/x509_ima.der. If yes what it should be.
>>> (b) Do I need to set some selinux rule for .ima keyring. If yes how. =
I
>>> tried a lot but could not find any resource.
>> Usually IMA policy is loaded before SELinux policy I think
> I am using the policy defined in ima_policy driver as of now. My kernel=
 is 4.14.
What is "ima_policy driver"? How does selinux and IMA policies get loaded=
 on your system?
>>> Regards,
>>> Rishi
