Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25CA3732AA
	for <lists+linux-integrity@lfdr.de>; Wed,  5 May 2021 01:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhEDXQi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 May 2021 19:16:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:58075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229960AbhEDXQi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 May 2021 19:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620170131;
        bh=iNvmekSG/CXCqHJ6AELO1RGvs+sqj7XiQLD/Px+qlxw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GQdb4CpOr/f4c0Q5cuFz9LGdn76Lb5jjfzQeo8tCuF70ErDc4SncGEo/HcSfAzR0s
         /X2DOAT3UKxGla429tfBnPFqJNMiPKoXVatbITlAhTiWsnh7X1dC0elzE113mfPgu6
         BGZTm94DJB+ltiWT5DR3uzS8vLFvdq8igzxryH2g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([78.42.220.31]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE27-1ly5Bg2VBr-00KkPv; Wed, 05
 May 2021 01:15:31 +0200
Subject: Re: [PATCH v3 2/4] tpm: Simplify locality handling
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com, keescook@chromium.org,
        jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
 <20210501135727.17747-3-LinoSanfilippo@gmx.de> <YJAby8mmiJ74qWAh@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <6722bf6f-1a3f-ee9c-55e2-cf63c64266a9@gmx.de>
Date:   Wed, 5 May 2021 01:15:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YJAby8mmiJ74qWAh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z8ssrqOzxZVuQxlXNTLwBYYL2DPZR4/MJpqRqYtpkSDKm8U6R21
 QoMfKmIDAfwjfDGgOBoJy40ubeSZS2PTb0MH+bCyCd8z5BCJm/ERS/v4WwIJUvU14dIrxAl
 INwOWVRtWfDt3fyXz1C8zsVSPxXTcZ4gcI4hqsiGEQ5DmSGdMt7t49ukkHCYhCix3oXMd/t
 Fup3D4NtuJ35pCuUtDElg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8qBCPQngce8=:b+5/pJeWP50jDbX5RoAs9W
 aADz77oV1qPV3zKGClfPxFrEp3E/fv0y3zVy0LZwrSS4EU3/NJCOkL3P2RQxKcsiJ1b/rrZ/f
 PseyE/PThIj/AaKpw8x5x0S+t8tJaRi/8u1X9tD8J4lx7vNC+HherGWlsXvAhc2SxCk0ExLH+
 P40lU3c5lHvs3xViEhtTlWPTFdTIOy3zECnvq04jHJAYNKG1J3WJZrf/2azgOrnLXmNo95R5y
 tBRauuAHSi++f2bx59G4rnw7rr7UivzE3lJVG/FOSYCKM9Kim9oSvTi7kdsbZ7oDISI40btWQ
 eAjb8Drhjp3dfRb3Yi6vQ16GY23/LERIvrORDHQXJ7NUMi9gbK1dOtxi18HmyTreG5AuLu5K8
 zC+UOUDm5z+40kDiF3PKHEO6PTVcVTSmi5dCW0TmiB3184as4gcR0FPPRWnj1jBaEX0BtuS+C
 znWWD7VvRmILsRU8E1eptvn8occQQlQUVa2YH6IxRPHvQMzC/YjyQhXYhjlVzU9hbV2wzVw6O
 O7E0QMs3xO8lyXYqJdR/xASCFyLuR2l9mOeR613cWE1fzPRFEYk++QUgaAhYtC72RVNMs4sMh
 LeiPuW14GRJ1LD1TL4B/fWqlIVIaXokCEUhXXOnwq7IsKl7pMISJsF6+6otBphp15V5EIsq3X
 B7jJJwXw7M6FIvapeOPibT/vNw/dn55mioo2xYzE7tNnf8o4PZFaGQhxAUxuUxQj82u74XMfn
 J8YXr3kwgY4bwvQ4f+YGLwxEC9MCwpt5PdP5wfAp9r/YvkPpn0EH1JXWXGVno+YctFT/Ea/lQ
 pOhAZ3KuN7y7q7hJ9H8pHERnjo/CW5YwMko0D1osPjzNhMsoRK6TBpdXS0jyP15A93bpU4Bp2
 K02URKI9ci/iBTCnl4ex4ivyAfBfZFsSRlmhxySUeDOKTkeUrbnsH3Pb5Q9MOoqTkGxBARA+4
 iXc6fKx2hpZXw0wmXBqlY8JdkGGrMlYt0fkW71PQRoZkqdz6YgaRjvYp3nn+P8Hs1+VtQv4Hk
 IyU6wPi1AvmVxZ2KLlU4F/BUfGkWinpkf7z3nY5XDtmcdOV3gXceRhC8FBkNjhBv03jv6/ylA
 QccLPSyfp5IoEXXw53a8OLh7UbbGjv2gsU4gpmgKOut0puEyzt3GLbT0D+c2YXZVN3pvDyu1m
 XsnOf1NXGWMruQH9e7HfFQgdDwXhx1lJVZzbdOjilxZGBT5FnRlBpepZCMG8Ic35Nhyg6AQNK
 6jtZs+6kK8oYlBfcP
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 03.05.21 at 17:50, Jarkko Sakkinen wrote:
> What the heck is "simplification" and what that has to do with fixing
> anything? I don't understand your terminology.


The intention for this patch is not to fix anything. Please read the cover
letter and the commit message.
This patch is about making the locality handling easier by not claiming/re=
leasing
it multiple times over the driver life time, but claiming it once at drive=
r
startup and only releasing it at driver shutdown.

Right now we have locality request/release combos in

- probe_itpm()
- tpm_tis_gen_interrupt()
- tpm_tis_core_init()
- tpm_chip_start()

and there is still one combo missing for

- tpm2_get_timeouts()

which is the reason why we get the "TPM returned invalid status" bug in ca=
se
of TPM2 (and this is the bug which is _incidentally_ fixed by this patch, =
see
below).

And if we are going to enable interrupts, we have to introduce yet another=
 combo,
for accessing the status register in the interrupt handler, since TPM 2.0
requires holding the locality for writing to the status register. That mak=
es
6 different code places in which we take and release the locality.

With this patch applied we only take the locality at one place. Furthermor=
e
with interrupts enabled we dont have to claim the locality for each handle=
r
execution, saving us countless claim/release combinations at runtime.

Hence the term "simplification" which is perfectly justified IMO.

So again, this patch is "only" in preparation for the next patch when inte=
rrupts
are actually enabled and we would have to take the locality in the interru=
pt
handler without this patch.



> On Sat, May 01, 2021 at 03:57:25PM +0200, Lino Sanfilippo wrote:

>> WARNING: CPU: 0 PID: 874 at drivers/char/tpm/tpm_tis_core.c:249 tpm_tis=
_status+0xbc/0xc8 [tpm_tis_core]
>> Modules linked in: tpm_tis_spi tpm_tis_core tpm sha256_generic cfg80211=
 rfkill 8021q garp stp llc spidev v3d gpu_sched vc4 bcm2835_codec(C) cec r=
aspberrypi_hwmon drm_kms_helper drm bcm2835_isp(C) v4l2_mem2mem bcm2835_v4=
l2(C) bcm2835_mmal_vchiq(C) videobuf2_vmalloc videobuf2_dma_contig snd_bcm=
2835(C) videobuf2_memops drm_panel_orientation_quirks videobuf2_v4l2 video=
buf2_common snd_soc_core snd_compress videodev snd_pcm_dmaengine spi_bcm28=
35 snd_pcm mc vc_sm_cma(C) snd_timer snd syscopyarea rpivid_mem sysfillrec=
t sysimgblt fb_sys_fops backlight uio_pdrv_genirq uio ip_tables x_tables i=
pv6 [last unloaded: tpm]
>> CPU: 0 PID: 874 Comm: kworker/u8:1 Tainted: G        WC        5.11.0-r=
c2-LS-HOME+ #1
>> Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
>> Workqueue: events_unbound async_run_entry_fn
>> pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=3D--)
>> pc : tpm_tis_status+0xbc/0xc8 [tpm_tis_core]
>> lr : tpm_tis_status+0xbc/0xc8 [tpm_tis_core]
>> sp : ffffffc0127e38f0
>> x29: ffffffc0127e38f0 x28: ffffffc011238000
>> x27: 0000000000000016 x26: 000000000000017a
>> x25: 0000000000000014 x24: ffffff8047f60000
>> x23: 0000000000000000 x22: 0000000000000016
>> x21: ffffff8044e8a480 x20: 0000000000000000
>> x19: ffffffc011238000 x18: ffffffc011238948
>> x17: 0000000000000000 x16: 0000000000000000
>> x15: ffffffc01141be81 x14: ffffffffffffffff
>> x13: ffffffc01141be7e x12: ffffffffffffffff
>> x11: ffffff807fb797f0 x10: 00000000000019b0
>> x9 : ffffffc0127e38f0 x8 : 766e692064656e72
>> x7 : 0000000000000000 x6 : ffffffc011239000
>> x5 : ffffff807fb628b8 x4 : 0000000000000000
>> x3 : 0000000000000027 x2 : 0000000000000000
>> x1 : 6818b6f22fdef800 x0 : 0000000000000000
>> Call trace:
>> tpm_tis_status+0xbc/0xc8 [tpm_tis_core]
>> tpm_tis_send_data+0x58/0x250 [tpm_tis_core]
>> tpm_tis_send_main+0x50/0x128 [tpm_tis_core]
>> tpm_tis_send+0x4c/0xe0 [tpm_tis_core]
>> tpm_transmit+0xd0/0x350 [tpm]
>> tpm_transmit_cmd+0x3c/0xc0 [tpm]
>> tpm2_get_tpm_pt+0x124/0x1e8 [tpm]
>> tpm_tis_probe_irq_single+0x198/0x364 [tpm_tis_core]
>> tpm_tis_core_init+0x304/0x520 [tpm_tis_core]
>> tpm_tis_spi_init+0x5c/0x78 [tpm_tis_spi]
>> tpm_tis_spi_probe+0x80/0x98 [tpm_tis_spi]
>> tpm_tis_spi_driver_probe+0x4c/0x60 [tpm_tis_spi]
>> spi_probe+0x84/0xf0
>> really_probe+0x118/0x420
>> driver_probe_device+0x5c/0xc0
>> __driver_attach_async_helper+0x64/0x68
>> async_run_entry_fn+0x48/0x150
>> process_one_work+0x15c/0x4d0
>> worker_thread+0x50/0x490
>> kthread+0x118/0x150
>> ret_from_fork+0x10/0x1c
>>
>> The reason for this issue is that in case of TPM 2 function
>> tpm2_get_timeouts() which executes a TPM command is called without a
>> claimed locality. Since with this patch the locality is taken once at
>> driver startup and never released before shutdown the issue does not oc=
cur
>> any more.
>
> Please rather create fix that fixes the issue exactly in the code path.
> I don't want to worry what other things this might do "as a side-effect"=
.

As explained above this patch is not meant to fix a bug in the first place
but rather fixes the bug above incidentally by the locality handling reimp=
lementation.

> Also, lacks the explanation why this patch fixes the issue.
>

The explanation is there:

"The reason for this issue is that in case of TPM 2 function
 tpm2_get_timeouts() which executes a TPM command is called without a
 claimed locality. Since with this patch the locality is taken once at
 driver startup and never released before shutdown the issue does not occu=
r
 any more."

I really dont know how to describe this more clear.


Lino
