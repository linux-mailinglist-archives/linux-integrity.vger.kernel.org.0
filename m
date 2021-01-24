Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C87B301D94
	for <lists+linux-integrity@lfdr.de>; Sun, 24 Jan 2021 17:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbhAXQtJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 24 Jan 2021 11:49:09 -0500
Received: from mout.gmx.net ([212.227.15.15]:43333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbhAXQtH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 Jan 2021 11:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611506846;
        bh=j8tXlItYBBOdkb2zyrPRiETCP+Txht6Wjz91UKm5i60=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HRXIqMfq62mi6YMLnRKrZlPrbYhKq+AvC0cPWs3Uk/seYC4JBE5A9ycKhBlSoHRLf
         klL+tKu/9GJh4mpFKv/rQxhOmPYq7xYEBErEgi9ljqdQfw7fGCqjuHbCbQACummuUV
         tJseGKch+jM3ErD3I17SpuKdNR0k9U0t8Yklfgws=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([78.42.220.31]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRfv-1laJPD2QkD-00btki; Sun, 24
 Jan 2021 17:47:26 +0100
Subject: Re: [PATCH 3/4] tpm: in tpm2_del_space check if ops pointer is still
 valid
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <1610760161-21982-1-git-send-email-LinoSanfilippo@gmx.de>
 <1610760161-21982-4-git-send-email-LinoSanfilippo@gmx.de>
 <YAR+R0c8HYsVUhZQ@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <9bb612ef-75be-f8d4-10a6-7ab5869da18f@gmx.de>
Date:   Sun, 24 Jan 2021 17:47:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YAR+R0c8HYsVUhZQ@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yovjdJoNEM7vO1CMkCb3lPeKQC4GEDsPAAbcC4n/ai75vHUOuCQ
 yLjaETVrj3AfzPuJoV2aPOR01lXdDTYmb/c3bZxUPavl0JL+AIXU4Vcpiy8CGH+vQPblTu4
 /qztcbtjorP+gBE2CEmY6uTY38JpNUCmr8BM5nn8ra2IAv1sded8OguVhbKkUj0U11vlcFe
 Sq7p9gG28D0/zQtPYYKog==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XOxC9a9nPZA=:B452ytGkmvstSaJ0Xzkz9u
 og4WHRDiZiR66KcqmW3IxjS0jOPY8ajFIK0FqHc1dqYJhcJbwmnOlsPzYFrWTinOyH0Y1OQeD
 Mxav7R96bQhrjB5ukzzh027v75eX1ejuX7/1ZEfz24trG4VcUu5MNBLuzWq4biYOYZV8lsXSo
 15KQu4TV8Cy5fxkSxiAHgJ3XuqasFj/64I9DwQrIM//hfXYSY8UENzS4XLEMDI+RRqT9WWx/r
 QzY8aFWGDgvZTfSMLoPmt0x7tEqyPEs0zqK/lrkswuFZsKPHUXVHbV/DNxvfekBoXoyeiWi9h
 SAoO994ZA1CzbpRWs/otS3jjxFN08EI3jztvRLhbuFjnKc65np4ItWLfUFyb+Sx+tQnKKV+dZ
 xwaUu4NSFZD5odoFjTaXD8xh1peTk7SJ3KhVkHW39aVOzDHUjg4/he9K2cpqsOnM11Ns22aCC
 WHqf4ntGQUJHtCot7M0qY+xLH84lTvsczg2yC4eLzgqJeCMAKGX4Yg67CRXo+tSclaULkcbyp
 rQOXbCtk7RNm96MF/C8rnVy5Bfetf2z5/PdXOnhCWqPx5SbnMwZuZKcGpsoNWsAjp5PUJRRas
 weo/bJapc59h1CltrW1aXtxjOJ9JQKEkSvxQKA8HJ0hSqQLdzMT4LCqvepm/MrxYtoYjcf/4f
 5/Kz0kEuuemcIUPBQidUe6Dk/aU3iUsVIYKeJesOfsFgI/DM8XoSQfW8Z3ZqkP/bbCG1vW4RT
 EV9L5Nzk+lgZs37lPUoLoaTGYjeLcBMylopCI+WL2vYFZDM9rY6JYQnZ+i8qdWs6qQ+oUqb7K
 38YqDrsB5FocPK08ZO8kYmG4Nz1beD2gROopQ7XomCBjZMAUKqRIH8IoYpk+d+qrrAxr7Behr
 OOE9fZNuiwofz1gLlA0Q==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi Jarkko,

On 17.01.21 at 19:13, Jarkko Sakkinen wrote:
>
> I have hard time to believe that any of these patches are based on
> actual regressions.
>
> /Jarko
>

patch 1 is indeed wrong (I oversaw the action call in case of error),
so please ignore it.

However patches 2 and 3 are based on bugs I encountered while working with
TPM. I am sorry if I did not make the issues clear enough in the patches
commit messages. Let me try to explain it in more detail:

The bugs showed up after unloading the TPM chip driver module while one
process still had the /dev/tpmrm device open.

It is easy to reproduce:

1. open /dev/tpmrm* and keep it open
2. remove the tpm chip driver (in my case this was tpm_tis_spi)
3. try to write() to the still opened device /dev/tpmrm*


This results in warnings like the following:

Jan 24 14:01:20 raspberrypi kernel: ------------[ cut here ]------------
Jan 24 14:01:20 raspberrypi kernel: WARNING: CPU: 3 PID: 1161 at lib/refco=
unt.c:25 kobject_get+0xa0/0xa4
Jan 24 14:01:20 raspberrypi kernel: refcount_t: addition on 0; use-after-f=
ree.
Jan 24 14:01:20 raspberrypi kernel: Modules linked in: tpm_tis_spi tpm_tis=
_core tpm mdio_bcm_unimac brcmfmac sha256_generic libsha256 sha256_arm hci=
_uart btbcm bluetooth cfg80211 vc4 brcmutil ecdh_generic ecc snd_soc_core =
crc32_arm_ce libaes raspberrypi_hwmon ac97_bus snd_pcm_dmaengine bcm2711_t=
hermal snd_pcm snd_timer genet snd phy_generic soundcore [last unloaded: s=
pi_bcm2835]
Jan 24 14:01:20 raspberrypi kernel: CPU: 3 PID: 1161 Comm: hold_open Not t=
ainted 5.10.0ls-main-dirty #2
Jan 24 14:01:20 raspberrypi kernel: Hardware name: BCM2711
Jan 24 14:01:20 raspberrypi kernel: [<c0410c3c>] (unwind_backtrace) from [=
<c040b580>] (show_stack+0x10/0x14)
Jan 24 14:01:20 raspberrypi kernel: [<c040b580>] (show_stack) from [<c1092=
174>] (dump_stack+0xc4/0xd8)
Jan 24 14:01:20 raspberrypi kernel: [<c1092174>] (dump_stack) from [<c0445=
a30>] (__warn+0x104/0x108)
Jan 24 14:01:20 raspberrypi kernel: [<c0445a30>] (__warn) from [<c0445aa8>=
] (warn_slowpath_fmt+0x74/0xb8)
Jan 24 14:01:20 raspberrypi kernel: [<c0445aa8>] (warn_slowpath_fmt) from =
[<c08435d0>] (kobject_get+0xa0/0xa4)
Jan 24 14:01:20 raspberrypi kernel: [<c08435d0>] (kobject_get) from [<bf0a=
715c>] (tpm_try_get_ops+0x14/0x54 [tpm])
Jan 24 14:01:20 raspberrypi kernel: [<bf0a715c>] (tpm_try_get_ops [tpm]) f=
rom [<bf0a7d6c>] (tpm_common_write+0x38/0x60 [tpm])
Jan 24 14:01:20 raspberrypi kernel: [<bf0a7d6c>] (tpm_common_write [tpm]) =
from [<c05a7ac0>] (vfs_write+0xc4/0x3c0)
Jan 24 14:01:20 raspberrypi kernel: [<c05a7ac0>] (vfs_write) from [<c05a7e=
e4>] (ksys_write+0x58/0xcc)
Jan 24 14:01:20 raspberrypi kernel: [<c05a7ee4>] (ksys_write) from [<c0400=
1a0>] (ret_fast_syscall+0x0/0x4c)
Jan 24 14:01:20 raspberrypi kernel: Exception stack(0xc226bfa8 to 0xc226bf=
f0)
Jan 24 14:01:20 raspberrypi kernel: bfa0:                   00000000 00010=
5b4 00000003 beafe664 00000014 00000000
Jan 24 14:01:20 raspberrypi kernel: bfc0: 00000000 000105b4 000103f8 00000=
004 00000000 00000000 b6f9c000 beafe684
Jan 24 14:01:20 raspberrypi kernel: bfe0: 0000006c beafe648 0001056c b6eb6=
944
Jan 24 14:01:20 raspberrypi kernel: ---[ end trace d4b8409def9b8b1f ]---
Jan 24 14:01:20 raspberrypi kernel: ------------[ cut here ]------------
Jan 24 14:01:20 raspberrypi kernel: WARNING: CPU: 3 PID: 1161 at lib/refco=
unt.c:28 tpm_try_get_ops+0x4c/0x54 [tpm]
Jan 24 14:01:20 raspberrypi kernel: refcount_t: underflow; use-after-free.
Jan 24 14:01:20 raspberrypi kernel: Modules linked in: tpm_tis_spi tpm_tis=
_core tpm mdio_bcm_unimac brcmfmac sha256_generic libsha256 sha256_arm hci=
_uart btbcm bluetooth cfg80211 vc4 brcmutil ecdh_generic ecc snd_soc_core =
crc32_arm_ce libaes raspberrypi_hwmon ac97_bus snd_pcm_dmaengine bcm2711_t=
hermal snd_pcm snd_timer genet snd phy_generic soundcore [last unloaded: s=
pi_bcm2835]
Jan 24 14:01:20 raspberrypi kernel: CPU: 3 PID: 1161 Comm: hold_open Taint=
ed: G        W         5.10.0ls-main-dirty #2
Jan 24 14:01:20 raspberrypi kernel: Hardware name: BCM2711
Jan 24 14:01:20 raspberrypi kernel: [<c0410c3c>] (unwind_backtrace) from [=
<c040b580>] (show_stack+0x10/0x14)
Jan 24 14:01:20 raspberrypi kernel: [<c040b580>] (show_stack) from [<c1092=
174>] (dump_stack+0xc4/0xd8)
Jan 24 14:01:20 raspberrypi kernel: [<c1092174>] (dump_stack) from [<c0445=
a30>] (__warn+0x104/0x108)
Jan 24 14:01:20 raspberrypi kernel: [<c0445a30>] (__warn) from [<c0445aa8>=
] (warn_slowpath_fmt+0x74/0xb8)
Jan 24 14:01:20 raspberrypi kernel: [<c0445aa8>] (warn_slowpath_fmt) from =
[<bf0a7194>] (tpm_try_get_ops+0x4c/0x54 [tpm])
Jan 24 14:01:20 raspberrypi kernel: [<bf0a7194>] (tpm_try_get_ops [tpm]) f=
rom [<bf0a7d6c>] (tpm_common_write+0x38/0x60 [tpm])
Jan 24 14:01:20 raspberrypi kernel: [<bf0a7d6c>] (tpm_common_write [tpm]) =
from [<c05a7ac0>] (vfs_write+0xc4/0x3c0)
Jan 24 14:01:20 raspberrypi kernel: [<c05a7ac0>] (vfs_write) from [<c05a7e=
e4>] (ksys_write+0x58/0xcc)
Jan 24 14:01:20 raspberrypi kernel: [<c05a7ee4>] (ksys_write) from [<c0400=
1a0>] (ret_fast_syscall+0x0/0x4c)
Jan 24 14:01:20 raspberrypi kernel: Exception stack(0xc226bfa8 to 0xc226bf=
f0)
Jan 24 14:01:20 raspberrypi kernel: bfa0:                   00000000 00010=
5b4 00000003 beafe664 00000014 00000000
Jan 24 14:01:20 raspberrypi kernel: bfc0: 00000000 000105b4 000103f8 00000=
004 00000000 00000000 b6f9c000 beafe684
Jan 24 14:01:20 raspberrypi kernel: bfe0: 0000006c beafe648 0001056c b6eb6=
944
Jan 24 14:01:20 raspberrypi kernel: ---[ end trace d4b8409def9b8b20 ]---



After some investigation I found out that the two warnings concerning a re=
fcount
underflow pop up due to an invalid chip->dev. Writing to
/dev/tpmrm* eventually calls tpm_common_write() which makes use of tpm_try=
_get_ops().
The latter function tries to get a ref for chip->dev which at this time al=
ready has
hit 0.

As it turned out, the reference we lack here is exactly the one that is su=
pposed to
be taken in tpm_chip_alloc():

if (chip->flags & TPM_CHIP_FLAG_TPM2)
	get_device(&chip->dev);

If you take a look at these lines and the code above you will figure that =
there
is no program path in which TPM_CHIP_FLAG_TPM2 could ever be set at this t=
ime.
So the reference is never taken, even if we are using TPM2 with /dev/tpmrm=
*.

I tried to follow the history of this bug and it seems to start with commi=
t
fdc915f7f719 which introduced the support for /dev/tpmrm.
This commit seemed to have already in mind that /dev/tpmrm could still be =
opened
after the tpm chip driver has been unregistered.
For this reason an extra reference to chip->dev was taken.
See this excerpt of commit fdc915f7f719:

<SNIP>
+       chip->devs.release =3D tpm_devs_release;
+       /* get extra reference on main device to hold on
+        * behalf of devs.  This holds the chip structure
+        * while cdevs is in use.  The corresponding put
+        * is in the tpm_devs_release
+        */
<SNAP>

This reference was supposed to be freed in tpm_devs_release() as the comme=
nt says:

<SNIP>
+static void tpm_devs_release(struct device *dev)
+{
+       struct tpm_chip *chip =3D container_of(dev, struct tpm_chip, devs)=
;
+
+       /* release the master device reference */
+       put_device(&chip->dev);
+}
<SNAP>

However the code did not work as expected at this time, because the refere=
nce
to chip->devs that we get with device_initalize() is never release.
This prevents tpm_devs_release() from being called which as a consequnce m=
isses
the put on chip->dev we do there.

This led to behaviour which commit 8979b02aaf1d tried to fix.
See the message of this commit:

" The main device is currently not properly released due to one additional
    reference to the 'devs' device which is only released in case of a TPM=
 2.
    So, also get the additional reference only in case of a TPM2."

Actually the additional reference was _never_ released even not in TPM2 ca=
se
(as described above).
The right fix at this point would IMHO have been to make sure that chip->d=
evs
reference is put one more time to make sure that tpm_devs_release() is cal=
led
and also chip->dev is put one more time.

Instead 8979b02aaf1d chose another approach:

+       if (chip->flags & TPM_CHIP_FLAG_TPM2)
+               get_device(&chip->dev);

was introduced to avoid getting the reference in the first place for the n=
on-TPM2 case.
This fixed the non-TPM2 case but now left the TPM2 case without an additio=
nal reference,
too (since as stated above there is nothing that sets the needed flag to g=
rap the ref
for TPM2).

So while before we had taken the ref in both cases TPM2 and non-TPM2 and n=
ever released
it in either case (which was wrong), we now do not take it in neither case=
 (which is
also wrong).

And this is what we have today. If we open /dev/tpmrm* and then unregister=
 the chip
all references to chip->dev are already gone. An attempt to write() to /de=
v/tpmrm* then
results in the reference underflow warning, because we try to grab a ref t=
o chip->dev in
tpm_try_get_ops() while the chip-dev refcount already has hit 0.


So what patch 2 is supposed to do is 1st. revert 8979b02aaf1d:

-       if (chip->flags & TPM_CHIP_FLAG_TPM2)
-               get_device(&chip->dev);
+       get_device(&chip->dev);

to get the extra ref to chip->dev unconditionally as originally proposed b=
y commit
fdc915f7f7193.

And 2nd. fix the actual issue of fdc915f7f7193 namely a missing put of chi=
p->devs to
eventually release the extra reference to the main device (aka. chip->dev)=
.

+       rc =3D devm_add_action_or_reset(pdev,
+                                     (void (*)(void *)) put_device,
+                                     &chip->devs);

I hope this makes patch 2 a bit clearer. Beside an older kernel I tested i=
t
with the mainline kernel and the patch fixes the above issues. However any=
one
is welcome to test it themselfes.
If you are fine with this solution I am going to prepare a v2 which fixes =
the
action handler part. Otherwise please let me know what your concerns are a=
nd
I will try to address it.



Now concerning patch 3: If after steps 1 - 3 above you do

4. close /dev/tpmrm*

you will run into the next issue, which is unrelated to the reference coun=
t bug, namely
a NULL pointer dereference:


=2D--------------- tpmrm_release
Unable to handle kernel NULL pointer dereference at virtual address 000000=
34
pgd =3D 22aa2cf3
[00000034] *pgd=3D00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in: tpm_tis_spi tpm_tis_core tpm ipt_MASQUERADE nf_conntrac=
k_netlink nfnetlink xt_addrtype iptable_nat nf_nat_ipv4 nf_nat br_netfilte=
r bridge stp llc overlay cmac bnep hci_uart btbcm serdev bluetooth ecdh_ge=
neric ftdi_sio brcmfmac usbserial brcmutil sha256_generic cfg80211 rfkill =
raspberrypi_hwmon bcm2835_codec(C) hwmon bcm2835_v4l2(C) v4l2_mem2mem bcm2=
835_mmal_vchiq(C) v4l2_common videobuf2_dma_contig videobuf2_vmalloc video=
buf2_memops videobuf2_v4l2 videobuf2_common videodev vc_sm_cma(C) media ev=
dev ipt_REJECT nf_reject_ipv4 iptable_filter gpio_wdt gpio_keys fixed mcp3=
20x ad5446 industrialio uio_pdrv_genirq spidev uio ip6t_REJECT nf_reject_i=
pv6 xt_recent xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag=
_ipv4 xt_limit ip6t_rt ip6table_filter ip6_tables i2c_dev
ip_tables x_tables ipv6 [last unloaded: spi_bcm2835]
CPU: 1 PID: 1953 Comm: iotedged Tainted: G        WC        4.19.95-rt38-M=
AIN-v7+ #6
Hardware name: BCM2835
PC is at tpm_chip_start+0x1c/0xc0 [tpm]
LR is at tpm2_del_space+0x34/0x88 [tpm]
pc : [<7f98407c>]    lr : [<7f988808>]    psr: 60070013
sp : a5a53e88  ip : a5a53ea0  fp : a5a53e9c
r10: aab63308  r9 : 00000008  r8 : b8fa60a0
r7 : bb40e210  r6 : b379f4d4  r5 : b379f000  r4 : b379f000
r3 : 00000000  r2 : b4c51000  r1 : 00000002  r0 : b379f000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5383d  Table: 259bc06a  DAC: 00000055
Process iotedged (pid: 1953, stack limit =3D 0x128dc27e)
Stack: (0xa5a53e88 to 0xa5a54000)
3e80:                   bbf67078 b379f000 a5a53ec4 a5a53ea0 7f988808 7f984=
06c
3ea0: bbf66000 aab63300 b7fef578 bb40e210 b8fa60a0 00000008 a5a53edc a5a53=
ec8
3ec0: 7f98a7e8 7f9887e0 aab63300 00000000 a5a53f14 a5a53ee0 802f1890 7f98a=
7a8
3ee0: 00000000 00000000 8021add0 aab63300 b4c515e4 b4c51000 80ea6888 b4c51=
614
3f00: ba383200 000000f8 a5a53f24 a5a53f18 802f1a4c 802f1804 a5a53f4c a5a53=
f28
3f20: 8014444c 802f1a40 b4c51000 badfa880 a5a52000 a5a53f54 00000000 00000=
5fc
3f40: a5a53f74 a5a53f50 80127794 801443b4 a5a53f94 a5a53f60 802f096c 80e07=
588
3f60: 00000000 000000f8 a5a53f94 a5a53f78 80128030 80127380 76c156d8 76c15=
6d8
3f80: 00000000 000000f8 a5a53fa4 a5a53f98 801280d0 80127fec 00000000 a5a53=
fa8
3fa0: 80101000 801280bc 76c156d8 76c156d8 00000001 00000000 c6c82300 00000=
001
3fc0: 76c156d8 76c156d8 00000000 000000f8 00000002 00000000 76c1a140 76c17=
000
3fe0: 000000f8 7e960a64 76b96389 76b38746 60070030 00000001 00000000 00000=
000
[<7f98407c>] (tpm_chip_start [tpm]) from [<7f988808>] (tpm2_del_space+0x34=
/0x88 [tpm])
[<7f988808>] (tpm2_del_space [tpm]) from [<7f98a7e8>] (tpmrm_release+0x4c/=
0x5c [tpm])
[<7f98a7e8>] (tpmrm_release [tpm]) from [<802f1890>] (__fput+0x98/0x1e0)
[<802f1890>] (__fput) from [<802f1a4c>] (____fput+0x18/0x1c)
[<802f1a4c>] (____fput) from [<8014444c>] (task_work_run+0xa4/0xc0)
[<8014444c>] (task_work_run) from [<80127794>] (do_exit+0x420/0xc20)
[<80127794>] (do_exit) from [<80128030>] (do_group_exit+0x50/0xd0)
[<80128030>] (do_group_exit) from [<801280d0>] (__wake_up_parent+0x0/0x30)
[<801280d0>] (__wake_up_parent) from [<80101000>] (ret_fast_syscall+0x0/0x=
28)
Exception stack(0xa5a53fa8 to 0xa5a53ff0)
3fa0:                   76c156d8 76c156d8 00000001 00000000 c6c82300 00000=
001
3fc0: 76c156d8 76c156d8 00000000 000000f8 00000002 00000000 76c1a140 76c17=
000
3fe0: 000000f8 7e960a64 76b96389 76b38746
Code: e52de004 e8bd4000 e5903430 e1a04000 (e5932034)
=2D--[ end trace 0000000000000006 ]---

AFAIU this is since at the time the file is closed and the files release()=
 function
is called the chips ops pointer is already NULL. It has been set to NULL a=
t the time
when the chip was unregistered (see tpm_del_char_device()).

The fix here is to first check if the ops pointer is still valid. That sho=
uld be true
as long as the chip has not been unregistered. If the chip has been unregi=
stered
already the ops pointer wont be accessable any more. In this case skip flu=
shing the
sessions.

However please ignore this patch for now, too, since while it works with a=
n older
kernel (4.19 is the one I am working with) it turned out not to be the cor=
rect
solution for the mainline kernel. I would have to take a closer look for t=
he
mainline case and then send a patch as soon as I have one.

Regards,
Lino
