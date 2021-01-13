Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B292F4B36
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Jan 2021 13:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbhAMMYs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 07:24:48 -0500
Received: from mail.rosalinux.ru ([195.19.76.54]:45460 "EHLO mail.rosalinux.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbhAMMYs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 07:24:48 -0500
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jan 2021 07:24:47 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 927FCCB8CEDB3
        for <linux-integrity@vger.kernel.org>; Wed, 13 Jan 2021 15:18:12 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id z-MIR-T1ujKy for <linux-integrity@vger.kernel.org>;
        Wed, 13 Jan 2021 15:18:11 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id C331BCB8CEDB7
        for <linux-integrity@vger.kernel.org>; Wed, 13 Jan 2021 15:18:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru C331BCB8CEDB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=A1AAD92A-9767-11E6-A27F-AC75C9F78EF4; t=1610540291;
        bh=w3dBh/PW+LgnEO90oyF6/FAzaSEVsxzcwm1rdY72pV8=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=nv1MsAaQ1YtQc3q6Z7RI7gMKhM7V9tLVT1rNbMYKr2HzOlWTwUeMCvpMTprFItu+V
         7G9aEft5Xl1rAghq0ngWVsZVKQ/dTr4+9rWu/vgRjDjeTIBETIgBBN0sxFVcDyZ8+u
         nHN9GLHl7BBtfIjon6pbdmc7PnR4Qi2qIegBCMbV98KFCe8vnOuNZLuAzrCHOHoPHW
         N6hE+Ot4OWy9AjOEsI3e3GzBQRcZx854D9Ju7DXOx7tkVuGvtsLA0wnoqDAIcFxdsn
         dQ7faBUDPzf8EUPC8/qANdEnQ6IlVOg7rwbWWTsyAinR2rR3lMe1ROcdHT6T9ToMgh
         XvGCy+SUL4Hgg==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KdNSqapE1ZP9 for <linux-integrity@vger.kernel.org>;
        Wed, 13 Jan 2021 15:18:11 +0300 (MSK)
Received: from rosa2019.1 (broadband-90-154-71-126.ip.moscow.rt.ru [90.154.71.126])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id A1B14CB8CEDB3
        for <linux-integrity@vger.kernel.org>; Wed, 13 Jan 2021 15:18:11 +0300 (MSK)
To:     linux-integrity <linux-integrity@vger.kernel.org>
From:   Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Subject: evmctl import -EPERM in initrd (dracut), but works after system boot
Message-ID: <297dc20a-8045-d945-351d-0e15c134ae71@rosalinux.ru>
Date:   Wed, 13 Jan 2021 15:18:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello

I am trying to make IMA work properly and have faced a strange issue whic=
h I cannot explain.

What I want to do is load IMA policy from /etc/sysconfig/ima-policy in in=
itrd (it is loaded OK) and then load a self-created public key, I created=
 a pair of keys (using LibreSSL, patch for ima-evm-utils is ready, but I =
need to make everyting work), and I configured the kernel to make it poss=
ible to load my own key which does not have to be signed with an in-kerne=
l key. EVM is not configured, only IMA.

dracut's itegrity module [1] tries to load the public key inside initrd, =
but receives -EPERM:

> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: /lib/d=
racut-lib.sh@431(source_all): . //lib/dracut/hooks/pre-pivot/61-ima-keys-=
load.sh
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///lib=
/dracut/hooks/pre-pivot/61-ima-keys-load.sh@3(source): SECURITYFSDIR=3D/s=
ys/kernel/security
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///lib=
/dracut/hooks/pre-pivot/61-ima-keys-load.sh@4(source): IMASECDIR=3D/sys/k=
ernel/security/ima
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///lib=
/dracut/hooks/pre-pivot/61-ima-keys-load.sh@5(source): IMACONFIG=3D/sysro=
ot/etc/sysconfig/ima
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///lib=
/dracut/hooks/pre-pivot/61-ima-keys-load.sh@43(source): '[' '!' -e /sys/k=
ernel/security/ima ']'
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[565]: ////li=
b/dracut/hooks/pre-pivot/61-ima-keys-load.sh@51(source): keyctl describe =
%keyring:.ima
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[565]: Can't =
find 'keyring:.ima'
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///lib=
/dracut/hooks/pre-pivot/61-ima-keys-load.sh@51(source): line=3D
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///lib=
/dracut/hooks/pre-pivot/61-ima-keys-load.sh@52(source): '[' 1 -eq 0 ']'
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[566]: ////li=
b/dracut/hooks/pre-pivot/61-ima-keys-load.sh@55(source): keyctl search @u=
 keyring _ima
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[566]: keyctl=
_search: Required key not available
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///lib=
/dracut/hooks/pre-pivot/61-ima-keys-load.sh@55(source): _ima_id=3D
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///lib=
/dracut/hooks/pre-pivot/61-ima-keys-load.sh@56(source): '[' -z '' ']'
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[567]: ////li=
b/dracut/hooks/pre-pivot/61-ima-keys-load.sh@57(source): keyctl newring _=
ima @u
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///lib=
/dracut/hooks/pre-pivot/61-ima-keys-load.sh@57(source): _ima_id=3D5413637=
65
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///lib=
/dracut/hooks/pre-pivot/61-ima-keys-load.sh@62(source): load_x509_keys 54=
1363765
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///lib=
/dracut/hooks/pre-pivot/61-ima-keys-load.sh@9(load_x509_keys): KEYRING_ID=
=3D541363765
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///lib=
/dracut/hooks/pre-pivot/61-ima-keys-load.sh@12(load_x509_keys): '[' -f /s=
ysroot/etc/sysconfig/ima ']'
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///lib=
/dracut/hooks/pre-pivot/61-ima-keys-load.sh@16(load_x509_keys): '[' -z ''=
 ']'
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///lib=
/dracut/hooks/pre-pivot/61-ima-keys-load.sh@17(load_x509_keys): IMAKEYSDI=
R=3D/etc/keys/ima
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[568]: ////li=
b/dracut/hooks/pre-pivot/61-ima-keys-load.sh@20(load_x509_keys): ls /sysr=
oot/etc/keys/ima/x509_evm.der
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///lib=
/dracut/hooks/pre-pivot/61-ima-keys-load.sh@20(load_x509_keys): PUBKEY_LI=
ST=3D/sysroot/etc/keys/ima/x509_evm.der
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///lib=
/dracut/hooks/pre-pivot/61-ima-keys-load.sh@21(load_x509_keys): for PUBKE=
Y in ${PUBKEY_LIST}
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[554]: ///lib=
/dracut/hooks/pre-pivot/61-ima-keys-load.sh@23(load_x509_keys): '[' '!' -=
f /sysroot/etc/keys/ima/x509_evm.der ']'
> =D1=8F=D0=BD=D0=B2 13 14:06:36 rosa2019.1 dracut-pre-pivot[569]: ////li=
b/dracut/hooks/pre-pivot/61-ima-keys-load.sh@30(load_x509_keys): evmctl i=
mport /sysroot/etc/keys/ima/x509_evm.der 541363765
> =D1=8F=D0=BD=D0=B2 13 14:06:38 rosa2019.1 kernel: random: crng init don=
e
> =D1=8F=D0=BD=D0=B2 13 14:06:38 rosa2019.1 kernel: random: 7 urandom war=
ning(s) missed due to ratelimiting
> =D1=8F=D0=BD=D0=B2 13 14:06:38 rosa2019.1 dracut-pre-pivot[569]: Readin=
g to /sysroot/etc/keys/ima/x509_evm.der
> =D1=8F=D0=BD=D0=B2 13 14:06:38 rosa2019.1 dracut-pre-pivot[569]: Import=
ing public key 5ac982c4 from file /sysroot/etc/keys/ima/x509_evm.der into=
 keyring 541363765
> =D1=8F=D0=BD=D0=B2 13 14:06:38 rosa2019.1 dracut-pre-pivot[569]: add_ke=
y failed
> =D1=8F=D0=BD=D0=B2 13 14:06:38 rosa2019.1 dracut-pre-pivot[569]: errno:=
 Permission denied (13)
So, evmctl import /sysroot/etc/keys/ima/x509_evm.der 541363765 got -EPERM=
 from the kernel.

Now I do exactly the same in already booted system... and it works, no -E=
PERM!

[root@rosa2019 ima-certs]# evmctl import /etc/keys/ima/x509_evm.der 54136=
3765
Reading to /etc/keys/ima/x509_evm.der
Importing public key 5ac982c4 from file /etc/keys/ima/x509_evm.der into k=
eyring 541363765
keyid: 483258747
483258747

[root@rosa2019 ima-certs]# cat /proc/keys | grep ima
20448e35 I--Q---=C2=A0=C2=A0=C2=A0=C2=A0 2 perm 3f010000=C2=A0=C2=A0=C2=A0=
=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0 keyring=C2=A0=C2=A0 _ima: 1

Here are related kernel config parts:

> [root@rosa2019 ima-certs]# cat /boot/config-5.10.4-generic-5rosa2019.1-=
x86_64 | grep -E '_IMA|INTEGRITY'
> CONFIG_BLK_DEV_INTEGRITY=3Dy
> CONFIG_BLK_DEV_INTEGRITY_T10=3Dy
> CONFIG_DM_INTEGRITY=3Dm
> CONFIG_FB_CFB_IMAGEBLIT=3Dy
> CONFIG_FB_SYS_IMAGEBLIT=3Dm
> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> CONFIG_INTEGRITY=3Dy
> CONFIG_INTEGRITY_SIGNATURE=3Dy
> CONFIG_INTEGRITY_ASYMMETRIC_KEYS=3Dy
> # CONFIG_INTEGRITY_TRUSTED_KEYRING is not set
> CONFIG_INTEGRITY_PLATFORM_KEYRING=3Dy
> CONFIG_INTEGRITY_AUDIT=3Dy
> CONFIG_IMA=3Dy
> CONFIG_IMA_MEASURE_PCR_IDX=3D10
> CONFIG_IMA_LSM_RULES=3Dy
> # CONFIG_IMA_TEMPLATE is not set
> CONFIG_IMA_NG_TEMPLATE=3Dy
> # CONFIG_IMA_SIG_TEMPLATE is not set
> CONFIG_IMA_DEFAULT_TEMPLATE=3D"ima-ng"
> CONFIG_IMA_DEFAULT_HASH_SHA1=3Dy
> # CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
> # CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
> CONFIG_IMA_DEFAULT_HASH=3D"sha1"
> # CONFIG_IMA_WRITE_POLICY is not set
> CONFIG_IMA_READ_POLICY=3Dy
> CONFIG_IMA_APPRAISE=3Dy
> # CONFIG_IMA_ARCH_POLICY is not set
> # CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
> CONFIG_IMA_APPRAISE_BOOTPARAM=3Dy
> CONFIG_IMA_APPRAISE_MODSIG=3Dy
> # CONFIG_IMA_TRUSTED_KEYRING is not set
> # CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not set
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=3Dy
> CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=3Dy
> # CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
> [root@rosa2019 ima-certs]# cat /proc/cmdline
> BOOT_IMAGE=3D/@rosa201910/boot/vmlinuz-5.10.4-generic-5rosa2019.1-x86_6=
4 root=3DUUID=3D745b0c43-6a82-4bce-9821-7f5dd88a9246 ro rootflags=3Dsubvo=
l=3D@rosa201910 ima_appraise=3Dlog rd.shell rd.debug resume=3DUUID=3D59b4=
ab95-b679-4c7c-8272-253715edc865
> [root@rosa2019 ima-certs]#=C2=A0
I do not have ideas how it may happen. Kernel keyring _ima was created by=
 dracut, then evemctl from initrd got -EPERM, but then evmctl worked OK w=
ith exectly the same keyring from booted system. Could some one please he=
lp to track the issue?

# evmctl --version
evmctl 1.3.2

Thanks!

[1] https://github.com/dracutdevs/dracut/tree/master/modules.d/98integrit=
y

