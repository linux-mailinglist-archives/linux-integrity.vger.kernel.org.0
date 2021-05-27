Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DF53925BB
	for <lists+linux-integrity@lfdr.de>; Thu, 27 May 2021 05:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhE0EB1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 May 2021 00:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhE0EB0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 May 2021 00:01:26 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58768C061574;
        Wed, 26 May 2021 20:59:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso1598405pji.0;
        Wed, 26 May 2021 20:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CwJa9nyqlqCt77gVhSX/xZUpA0UZxXHUYvWYQO1UcMg=;
        b=KGF9E4uxfWz7Ag1nKZWTYtd657AM/2PP57fOjnW6cSQLrop5rW+VvXsBIYeS/PRPzb
         YJERPGG8Jz1eWeqZ1ovKYWPWNCasaJB9v3i3MuwG3U7frrwNbAlSoaAwiPiVXhowjb9u
         xU8+hAsCJkSiWacdJTqeEKjF6pO+mvLA/Dvn65zcsRyQs0yigBylK6q40GcCT0jU0ur9
         aZIrVveqSpNTlGsQ8y9GJZ3yNMK2DqvCf0RlQYBbIEvxGGEFh4hHus5GD7RKoagAP2G5
         MggG3zffVYlfhaH6PKQQ88/AHZ5N68AAIRvKKSHDruZ6Bs7UMjO2aEhAJO7uCyT8spSO
         zT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CwJa9nyqlqCt77gVhSX/xZUpA0UZxXHUYvWYQO1UcMg=;
        b=Ys26w4+jO3OEnriKE2IkUEukCY8uC3pziqh5roc+YdaTpHuy91mWYjflAaSCJcKaKV
         3LPVp1S31PGlg9kz8r1tddpg0URbpj8Mzn9Qds2oBSxVUNmm9dxz1bRgBK6GIn2TgENJ
         ZQ3KYg8mpfdySHECyGHJ1Btmg58xwJ1whgfpx2PnGkWulP7GHwhwsVmepsEyKBWeK9tu
         DbyupL4nk7vOSdxct8R892bjGtvL5DPAfz28bpeIvp4eGhl5B5sytdp/gNYALWnDQLwB
         qySUL1Ic6nDFTZp69bBf3EePJ0lUBjxjie9EmDJe3B/aN1dt0+Bm/GHTt15F4nHIWX6T
         0A8w==
X-Gm-Message-State: AOAM531dljbideZWhCsF3z2shnNSLmOmEhCTc3w1yS9CySfLDu8cOzyq
        YJt3vR+5ftNHbt9ZV9aj8Q6thdsYAReoSiy8Gwg=
X-Google-Smtp-Source: ABdhPJwtGHquYYAtj27J7pShiolK5GoSm2juTToMnTQs+gBKCAfMQR2mSN+DVvjOrkzGF2CS4Yd0YWlX/cWz6uXL2QA=
X-Received: by 2002:a17:903:31d3:b029:ee:bccd:e686 with SMTP id
 v19-20020a17090331d3b02900eebccde686mr1437923ple.1.1622087992635; Wed, 26 May
 2021 20:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <CADG95vuR1=dvgsf6bvNCRNsvDEJ=YwFgfvqJWRkNvD=rrYUaYA@mail.gmail.com>
 <b348c8687d5b40919d8625f4c096d4e2@huawei.com>
In-Reply-To: <b348c8687d5b40919d8625f4c096d4e2@huawei.com>
From:   Bighead Wang <ex200208049@gmail.com>
Date:   Thu, 27 May 2021 11:59:41 +0800
Message-ID: <CADG95vuTMGQY1HbPuHhD9kTEegUBFf75Nen2jPRZq4Xp_51wZw@mail.gmail.com>
Subject: Re: EVM gives no_label error due to security_kernfs_init_security
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto
Thank you for the reply

Before I try this patch, I am sorry that I forget to mention that I
have loaded the EVM HMAC key in initramfs during system bootup.
Therefore, I don't think this patch will fix this issue although I
will give it a try. Because when issue happens, the key has already
loaded.

Thanks !

Roberto Sassu <roberto.sassu@huawei.com> =E6=96=BC 2021=E5=B9=B45=E6=9C=882=
5=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:29=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> > From: Bighead Wang [mailto:ex200208049@gmail.com]
> > Sent: Tuesday, May 25, 2021 11:19 AM
> > In cgroup filesystem, security_kernfs_init_security() will initialize
> > the security data for newly created kernfs node after kernel 5.2.,
> > however, new EVM xattr value is not initialized, and the no_label
> > error appears when evm_verify_hmac() is triggered.
> >
> >
> > The detailed description:
> > When system boots up with IMA/EVM and SELinux enabled, we get:
> > " May 25 14:13:01 raspberrypi audit[1212]: INTEGRITY_METADATA pid=3D121=
2
> > uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:ini=
t_t
> > op=3Dappraise_metadata cause=3Dno_label comm=3D"(systemd)"
> > name=3D"cgroup.procs" dev=3D"cgroup2" ino=3D1360 res=3D0 errno=3D0 "
> >
> > The root cause is that our customized SELinux file_contexts file does
> > not contain the line "/sys/fs/cgroup/.*     <<none>>".
> > When systemd relabels directories under /sys/fs/cgroup/ during
> > booting, it will set SELinux label inside the iattr member of kernfs
> > node, and then security_kernfs_init_security() will initialize the
> > security data at the time new kernfs node created.
> > After systemd executes something to trigger evm_verify_hmac(), we get
> > this no_label error.
> >
> > In evm_verify_hmac(), if there is no EVM xattr value, it will check
> > any other xattr values protected by EVM exist or not.
> > In this situation, there is no EVM xattr value (got from the iattr
> > member of kernfs node in cgroup filesystem), but SELinux label (also
> > got from the iattr member of kernfs node instead of from inode)
> > exists.
> > To sum up, the error seems to me is EVM mechanism doesn't initialize
> > EVM xattr value in kernfs node.
>
> Hi Hank
>
> this patch should help:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git=
/commit/?h=3Dnext-integrity-testing&id=3D4a804b8a4572dfc81c3a59709d49ae206e=
4370ba
>
> Could you please try it?
>
> Thanks
>
> Roberto
>
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Li Peng, Li Jian, Shi Yanli
>
> > The environment:
> > /proc/version: Linux version 5.13.0-rc3-v7l+ (bighead@52-0453463-02)
> > (arm-linux-gnueabi-gcc (GCC) 9.1.0, GNU ld (GNU Binutils) 2.32) #1 SMP
> > Tue May 25 12:33:01 CST 2021
> > /proc/sys/kernel/tainted: 0
> > Operating System: Raspbian GNU/Linux 10 (buster)
> > Architecture: armv7l
> > systemd version: systemd 241 (241) +PAM +AUDIT +SELINUX +IMA
> > +APPARMOR
> > +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ
> > +LZ4
> > +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2
> > default-hierarchy=3Dhybrid
> > IMA/EVM kernel parameter: ima_policy=3Dappraise_tcb ima_appraise=3Dfix
> > SELinux kernel parameter: security=3Dselinux selinux=3D1 (permissive mo=
de)
> >
> > How to reproduce the error in Raspbian:
> > 1. Prepare an environment which SELinux and IMA/EVM are enabled and
> > boot up with kernel parameters: security=3Dselinux selinux=3D1
> > ima_policy=3Dappraise_tcb ima_appraise=3Dfix evm=3Dfix
> > 2. Remove the line "/sys/fs/cgroup/.*     <<none>>" in file_contexts
> > file, and fully relabel all system with SELinux official reference
> > policy
> > 3. Walk through all regular files and generate ima/evm hash:
> > /usr/bin/find / -type f -uid 0 -exec sh -c "< '{}'" \;
> > 4. Reboot with kernel parameters: security=3Dselinux selinux=3D1
> > ima_policy=3Dappraise_tcb ima_appraise=3Dfix
> > 5. After boot up, you will get this EVM no_label error message
> >
> > Reproduce the error directly:
> > 1. Prepare an environment which SELinux and IMA/EVM are enabled and
> > boot up with kernel parameters: security=3Dselinux selinux=3D1
> > ima_policy=3Dappraise_tcb ima_appraise=3Dfix evm=3Dfix
> > 2. Fully relabel all system with SELinux official reference policy
> > 3. Walk through all regular files and generate ima/evm hash:
> > /usr/bin/find / -type f -uid 0 -exec sh -c "< '{}'" \;
> > 4. Reboot with kernel parameters: security=3Dselinux selinux=3D1
> > ima_policy=3Dappraise_tcb ima_appraise=3Dfix
> > 5. sudo setfattr -n security.selinux -v system_u:object_r:cgroup_t
> > /sys/fs/cgroup/unified
> > 6. sudo mkdir /sys/fs/cgroup/unified/testevm
> > 7. sudo chmod +x /sys/fs/cgroup/unified/testevm/cgroup.procs: you will
> > get this EVM error message
> >
> > Reference:
> > Kernel config: https://140.96.154.7:5001/sharing/9cPNowmhK
> > Journal log: https://140.96.154.7:5001/sharing/sRISz6IPt
> > Patch for security_kernfs_init_security() :
> > https://lore.kernel.org/selinux/20190130114150.27807-1-
> > omosnace@redhat.com/
> >
> > --
> > Best Regards,
> > Hank Wang



--=20
Best Regards,
=E7=8E=8B=E7=A6=B9=E8=BB=92 Hank
