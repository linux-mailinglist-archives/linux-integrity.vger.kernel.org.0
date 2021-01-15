Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7C82F74C4
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Jan 2021 09:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbhAOI7Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 03:59:24 -0500
Received: from mail.rosalinux.ru ([195.19.76.54]:46812 "EHLO mail.rosalinux.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbhAOI7X (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 03:59:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 2C880E25DECE5
        for <linux-integrity@vger.kernel.org>; Fri, 15 Jan 2021 11:58:40 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id T_lh7tMojXu2 for <linux-integrity@vger.kernel.org>;
        Fri, 15 Jan 2021 11:58:39 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 2C151E25DECE7
        for <linux-integrity@vger.kernel.org>; Fri, 15 Jan 2021 11:58:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 2C151E25DECE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=A1AAD92A-9767-11E6-A27F-AC75C9F78EF4; t=1610701119;
        bh=VMyqU5X5F142E5ER3KVzhrc1REsO3KbJDYc2yKbD1m8=;
        h=From:To:Message-ID:Date:MIME-Version;
        b=GF0JCqEuGrJgfbqiGg4swgORcmLC0V/j9dXVjJRHJ6eot2HEC6KHDqi8CyKmRV6MX
         SRDe7HZzMZCXIP+5aMCDxftzOraSEPZGihpVt3AQXFVKTfrZoh4T1EtPfBdmHBScop
         uXm52pJC9XeKFXK8kCVmlzOAlGw1HoiRSH5+bJ7bgM/Myp5T9i6uLEDnJ7Y5PvXibE
         7nHHICUxNqblz7eDX2bBbR6GeHR0kq/ECo8UzKmAka+s9b50EPLZWGRydcWXDY5l74
         4LiFoHd+guuOLk3AJc11916gqPKBDXinjdDeGn6ylHdeC5cYYVNXLmF5ucPB+RAEEV
         foRtKeL7VaDsw==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cCQIxIZgY94e for <linux-integrity@vger.kernel.org>;
        Fri, 15 Jan 2021 11:58:39 +0300 (MSK)
Received: from rosa2019.1 (broadband-90-154-71-126.ip.moscow.rt.ru [90.154.71.126])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id 0D357E25DECE5
        for <linux-integrity@vger.kernel.org>; Fri, 15 Jan 2021 11:58:39 +0300 (MSK)
Subject: Re: evmctl import -EPERM in initrd (dracut), but works after system
 boot
From:   Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
To:     linux-integrity <linux-integrity@vger.kernel.org>
References: <297dc20a-8045-d945-351d-0e15c134ae71@rosalinux.ru>
 <e7f819bb-d284-7843-dd8c-bbb20bb3d978@rosalinux.ru>
Message-ID: <a4b5a350-b2a6-726e-8f5b-983b68ed5c31@rosalinux.ru>
Date:   Fri, 15 Jan 2021 11:58:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e7f819bb-d284-7843-dd8c-bbb20bb3d978@rosalinux.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

13.01.2021 17:09, Mikhail Novosyolov =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> It is -EACCES, not -EPERM
>
> From strace inside initrd:
>
> 575=C2=A0=C2=A0 write(2, "Importing public key 5ac982c4 fr"..., 98) =3D=
 98
> 575=C2=A0=C2=A0 add_key("asymmetric", NULL, "0\202\2\2040\202\1\356\240=
\3\2\1\2\2\t\0\242\5\2726G\242\331\3220\f\6\10*\205\3\7"..., 648, 1311993=
47) =3D -1 EACCES (Permission denied)
> 575=C2=A0=C2=A0 write(2, "add_key failed\n", 15)=C2=A0 =3D 15
> 575=C2=A0=C2=A0 write(2, "errno: Permission denied (13)\n", 30) =3D 30
>
> 13.01.2021 15:18, Mikhail Novosyolov =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Hello
>>
>> I am trying to make IMA work properly and have faced a strange issue w=
hich I cannot explain.
>>
>> What I want to do is load IMA policy from /etc/sysconfig/ima-policy in=
 initrd (it is loaded OK) and then load a self-created public key, I crea=
ted a pair of keys (using LibreSSL, patch for ima-evm-utils is ready, but=
 I need to make everyting work), and I configured the kernel to make it p=
ossible to load my own key which does not have to be signed with an in-ke=
rnel key. EVM is not configured, only IMA.
>>
>> dracut's itegrity module [1] tries to load the public key inside initr=
d, but receives -EPERM:

I have found a workaround:

add "KeyringMode=3Dshared" to /usr/lib/dracut/modules.d/98dracut-systemd/=
dracut-pre-pivot.service

https://github.com/systemd/systemd/issues/5522 is what made me come to th=
is workaround.

But for now I do not fully understand why this helped and how to solve th=
is problem properly.

Seems that nobody uses dracut+integrity module+_ima keyring (not .ima)...

I've created a bug report in dracut to track this problem: https://github=
.com/dracutdevs/dracut/issues/1007

>>
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: /lib=
/dracut-lib.sh@431(source_all): . //lib/dracut/hooks/pre-pivot/61-ima-key=
s-load.sh
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///l=
ib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@3(source): SECURITYFSDIR=3D=
/sys/kernel/security
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///l=
ib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@4(source): IMASECDIR=3D/sys=
/kernel/security/ima
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///l=
ib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@5(source): IMACONFIG=3D/sys=
root/etc/sysconfig/ima
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///l=
ib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@43(source): '[' '!' -e /sys=
/kernel/security/ima ']'
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[565]: ////=
lib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@51(source): keyctl describ=
e %keyring:.ima
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[565]: Can'=
t find 'keyring:.ima'
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///l=
ib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@51(source): line=3D
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///l=
ib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@52(source): '[' 1 -eq 0 ']'
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[566]: ////=
lib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@55(source): keyctl search =
@u keyring _ima
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[566]: keyc=
tl_search: Required key not available
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///l=
ib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@55(source): _ima_id=3D
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///l=
ib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@56(source): '[' -z '' ']'
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[567]: ////=
lib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@57(source): keyctl newring=
 _ima @u
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///l=
ib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@57(source): _ima_id=3D54136=
3765
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///l=
ib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@62(source): load_x509_keys =
541363765
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///l=
ib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@9(load_x509_keys): KEYRING_=
ID=3D541363765
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///l=
ib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@12(load_x509_keys): '[' -f =
/sysroot/etc/sysconfig/ima ']'
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///l=
ib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@16(load_x509_keys): '[' -z =
'' ']'
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///l=
ib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@17(load_x509_keys): IMAKEYS=
DIR=3D/etc/keys/ima
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[568]: ////=
lib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@20(load_x509_keys): ls /sy=
sroot/etc/keys/ima/x509_evm.der
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///l=
ib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@20(load_x509_keys): PUBKEY_=
LIST=3D/sysroot/etc/keys/ima/x509_evm.der
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///l=
ib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@21(load_x509_keys): for PUB=
KEY in ${PUBKEY_LIST}
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///l=
ib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@23(load_x509_keys): '[' '!'=
 -f /sysroot/etc/keys/ima/x509_evm.der ']'
>>> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[569]: ////=
lib/dracut/hooks/pre-pivot/61-ima-keys-load.sh@30(load_x509_keys): evmctl=
 import /sysroot/etc/keys/ima/x509_evm.der 541363765
>>> =D1=8F=D0=BD=D0=B2 13 14:06:38 rosa2019.1 kernel: random: crng init d=
one
>>> =D1=8F=D0=BD=D0=B2 13 14:06:38 rosa2019.1 kernel: random: 7 urandom w=
arning(s) missed due to ratelimiting
>>> =D1=8F=D0=BD=D0=B2 13 14:06:38 rosa2019.1 dracut-pre-pivot[569]: Read=
ing to /sysroot/etc/keys/ima/x509_evm.der
>>> =D1=8F=D0=BD=D0=B2 13 14:06:38 rosa2019.1 dracut-pre-pivot[569]: Impo=
rting public key 5ac982c4 from file /sysroot/etc/keys/ima/x509_evm.der in=
to keyring 541363765
>>> =D1=8F=D0=BD=D0=B2 13 14:06:38 rosa2019.1 dracut-pre-pivot[569]: add_=
key failed
>>> =D1=8F=D0=BD=D0=B2 13 14:06:38 rosa2019.1 dracut-pre-pivot[569]: errn=
o: Permission denied (13)
>> So, evmctl import /sysroot/etc/keys/ima/x509_evm.der 541363765 got -EP=
ERM from the kernel.
>>
>> Now I do exactly the same in already booted system... and it works, no=
 -EPERM!
>>
>> [root@rosa2019 ima-certs]# evmctl import /etc/keys/ima/x509_evm.der 54=
1363765
>> Reading to /etc/keys/ima/x509_evm.der
>> Importing public key 5ac982c4 from file /etc/keys/ima/x509_evm.der int=
o keyring 541363765
>> keyid: 483258747
>> 483258747
>>
>> [root@rosa2019 ima-certs]# cat /proc/keys | grep ima
>> 20448e35 I--Q---=C2=A0=C2=A0=C2=A0=C2=A0 2 perm 3f010000=C2=A0=C2=A0=C2=
=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0 keyring=C2=A0=C2=A0 _ima: 1
>>
>> Here are related kernel config parts:
>>
>>> [root@rosa2019 ima-certs]# cat /boot/config-5.10.4-generic-5rosa2019.=
1-x86_64 | grep -E '_IMA|INTEGRITY'
>>> CONFIG_BLK_DEV_INTEGRITY=3Dy
>>> CONFIG_BLK_DEV_INTEGRITY_T10=3Dy
>>> CONFIG_DM_INTEGRITY=3Dm
>>> CONFIG_FB_CFB_IMAGEBLIT=3Dy
>>> CONFIG_FB_SYS_IMAGEBLIT=3Dm
>>> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
>>> CONFIG_INTEGRITY=3Dy
>>> CONFIG_INTEGRITY_SIGNATURE=3Dy
>>> CONFIG_INTEGRITY_ASYMMETRIC_KEYS=3Dy
>>> # CONFIG_INTEGRITY_TRUSTED_KEYRING is not set
>>> CONFIG_INTEGRITY_PLATFORM_KEYRING=3Dy
>>> CONFIG_INTEGRITY_AUDIT=3Dy
>>> CONFIG_IMA=3Dy
>>> CONFIG_IMA_MEASURE_PCR_IDX=3D10
>>> CONFIG_IMA_LSM_RULES=3Dy
>>> # CONFIG_IMA_TEMPLATE is not set
>>> CONFIG_IMA_NG_TEMPLATE=3Dy
>>> # CONFIG_IMA_SIG_TEMPLATE is not set
>>> CONFIG_IMA_DEFAULT_TEMPLATE=3D"ima-ng"
>>> CONFIG_IMA_DEFAULT_HASH_SHA1=3Dy
>>> # CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
>>> # CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
>>> CONFIG_IMA_DEFAULT_HASH=3D"sha1"
>>> # CONFIG_IMA_WRITE_POLICY is not set
>>> CONFIG_IMA_READ_POLICY=3Dy
>>> CONFIG_IMA_APPRAISE=3Dy
>>> # CONFIG_IMA_ARCH_POLICY is not set
>>> # CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
>>> CONFIG_IMA_APPRAISE_BOOTPARAM=3Dy
>>> CONFIG_IMA_APPRAISE_MODSIG=3Dy
>>> # CONFIG_IMA_TRUSTED_KEYRING is not set
>>> # CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not se=
t
>>> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=3Dy
>>> CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=3Dy
>>> # CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
>>> [root@rosa2019 ima-certs]# cat /proc/cmdline
>>> BOOT_IMAGE=3D/@rosa201910/boot/vmlinuz-5.10.4-generic-5rosa2019.1-x86=
_64 root=3DUUID=3D745b0c43-6a82-4bce-9821-7f5dd88a9246 ro rootflags=3Dsub=
vol=3D@rosa201910 ima_appraise=3Dlog rd.shell rd.debug resume=3DUUID=3D59=
b4ab95-b679-4c7c-8272-253715edc865
>>> [root@rosa2019 ima-certs]#=C2=A0
>> I do not have ideas how it may happen. Kernel keyring _ima was created=
 by dracut, then evemctl from initrd got -EPERM, but then evmctl worked O=
K with exectly the same keyring from booted system. Could some one please=
 help to track the issue?
>>
>> # evmctl --version
>> evmctl 1.3.2
>>
>> Thanks!
>>
>> [1] https://github.com/dracutdevs/dracut/tree/master/modules.d/98integ=
rity
>>
