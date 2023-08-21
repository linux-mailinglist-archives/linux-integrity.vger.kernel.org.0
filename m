Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1488578265D
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Aug 2023 11:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbjHUJf0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Aug 2023 05:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbjHUJfZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Aug 2023 05:35:25 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB5B9D
        for <linux-integrity@vger.kernel.org>; Mon, 21 Aug 2023 02:35:21 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-796d78b3f68so773495241.0
        for <linux-integrity@vger.kernel.org>; Mon, 21 Aug 2023 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692610520; x=1693215320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+YSSgE6ImDsA91XbotUDfbON3t0BPS/XCjpKcgWSDU=;
        b=zwHbc3aBiggXk6rSX3/U9LqgGXSlvEYqTthqwxqg0zSAnui64OVS7yAiueQ+HjoRP2
         JeRze5v/acypzKTsx6aGQ93e01ba7jak10lQJeJUhAhkhZkLbjSpQSWbmU6+GtzgtErX
         W8qv4aE+GW1lhN9bLFgwxlSJMosH9BESGBUxmMqc0c9qwSqNahXNAueGX1s3Rv4KgPJB
         sTYRn+kc9WSnd9fz5vK0fWzBYp0bW9aPGd039FEdfeaJL03rpqJFoAWnVstMB+a8QBL3
         UGbUSw0M0J14/e64F/QNxzKwrI6VWy5Q6JzsNr4/EHikW4wDp/ntYQRob3gAkBZ2tD47
         EEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692610520; x=1693215320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+YSSgE6ImDsA91XbotUDfbON3t0BPS/XCjpKcgWSDU=;
        b=hIqi3o7Rw6AQ9o4k+v82i8z5Ta7tHK9Kbvjmu7lJxtVlvbwVYdzvduIfx1CUm+xbnj
         j1l3AESa9JZqkmRD6KSmxlQelDJsuugC8FBLTeZexpZFAp/K6zpGM3+zap+7LerQOcRK
         LlnO0IS0az8UmWp3JIMs28AojWeG5mmyt4nLuo34FH2A1vLYqB0AhD3j2nNR9VjRcm3Q
         j8S8CuLDta+XwYw56ur4xlMfd9AtgumAUiO9AOhfy8u99K46FYIqQAL+a+MocY62dVLK
         gMuTw6gQ6/wcKHv6muTgC1lZckuPf0P3kdLN8sDrOU9BSsKV3X9yMI1tWFTe1hXCt//G
         jgIg==
X-Gm-Message-State: AOJu0YyDiMQSg0XLyOaWNS39oQEXPCpv0xmM6kYsv7DCwqlokxafWq9V
        EZxgM62czL9Nowf/XuuNRssO6onQQmVPvAxP+lxhVQ==
X-Google-Smtp-Source: AGHT+IEvSV1aXm3AS0VLQbgh5fJN6CFdSFsPuwmGAt3ZEa05TltLOrkCzR1NISRrBlnkSz2YaI4rs0fZOnYD3Uq0j+k=
X-Received: by 2002:a67:d00c:0:b0:445:780:c345 with SMTP id
 r12-20020a67d00c000000b004450780c345mr3958739vsi.20.1692610520127; Mon, 21
 Aug 2023 02:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230803123515.4018838-1-jens.wiklander@linaro.org>
 <CAFA6WYMzBJTNUxh6b-y=a_NND8FX65YjEP4i-HPS4tQ-Qfm+0w@mail.gmail.com>
 <CAHUa44ET3Oqc4Yq8E4ouAjn5dF9ygxoXyWh0sjFF_vPoooxrnA@mail.gmail.com>
 <CAHUa44HpkxDPgdh1B_bFOVPSOETk3F_ZicdnhmuVOux+5fd7sA@mail.gmail.com> <CAFA6WYMdROqkNbfbOkm22AYR1vnNa83dttf-4rF6pp1dZDym3Q@mail.gmail.com>
In-Reply-To: <CAFA6WYMdROqkNbfbOkm22AYR1vnNa83dttf-4rF6pp1dZDym3Q@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 21 Aug 2023 15:05:02 +0530
Message-ID: <CAFA6WYOhSAY68S=pqW5=YU=gCo7LHYELt1A7mAx-0revWH5XpA@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: tee: use tee_shm_register_alloc_buf()
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 21 Aug 2023 at 14:01, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Mon, 21 Aug 2023 at 13:15, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Hi,
> >
> > On Tue, Aug 8, 2023 at 11:07=E2=80=AFAM Jens Wiklander
> > <jens.wiklander@linaro.org> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Mon, Aug 7, 2023 at 9:58=E2=80=AFAM Sumit Garg <sumit.garg@linaro.=
org> wrote:
> > > >
> > > > Hi Jens,
> > > >
> > > > On Thu, 3 Aug 2023 at 18:05, Jens Wiklander <jens.wiklander@linaro.=
org> wrote:
> > > > >
> > > > > Prior to this patch was trusted_tee_seal() and trusted_tee_get_ra=
ndom()
> > > > > relying on tee_shm_register_kernel_buf() to share memory with the=
 TEE.
> > > > > Depending on the memory allocation pattern the pages holding the
> > > > > registered buffers overlap with other buffers also shared with th=
e TEE.
> > > > >
> > > >
> > > > The overlap here is due to the fact that we are registering two arr=
ay
> > > > members of the same struct. This overlap can be removed by register=
ing
> > > > the overall structure at once. But that sounds unnecessary data
> > > > structure type sharing with trusted keys TA.
> > > >
> > > > > The OP-TEE driver using the old SMC based ABI permits overlapping=
 shared
> > > > > buffers, but with the new FF-A based ABI each physical page may o=
nly
> > > > > be registered once.
> > > >
> > > > Would it be possible for OP-TEE FF-A ABI to check if a page is alre=
ady
> > > > registered?
> > >
> > > No, there's no such ABI in the FF-A specification.
> > >
> > > > If it is then just return success with appropriate page
> > > > offset.
> > >
> > > It's more complicated than that. What if only there's a partial regis=
tration?
> > >
> > > > As otherwise this sounds like an unnecessary restriction for
> > > > users. I don't think the problem is only particular to the trusted
> > > > keys driver but can be reproduced for user-space clients as well.
> > >
> > > Indeed, we're dealing with it by using a temporary buffer in the clie=
nt lib.
> > >
> > > >
> > > > >
> > > > > Fix this problem by allocating a temporary page aligned shared me=
mory
> > > > > buffer to be used as a bounce buffer for the needed data buffers.
> > > > >
> > > > > Since TEE trusted keys doesn't depend on registered shared memory
> > > > > support any longer remove that explicit dependency when opening a
> > > > > context to the TEE.
> > > > >
> > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > ---
> > > > >  security/keys/trusted-keys/trusted_tee.c | 68 +++++++++++++-----=
------
> > > > >  1 file changed, 36 insertions(+), 32 deletions(-)
> > > > >
> > > > > diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/=
keys/trusted-keys/trusted_tee.c
> > > > > index ac3e270ade69..3085343c489a 100644
> > > > > --- a/security/keys/trusted-keys/trusted_tee.c
> > > > > +++ b/security/keys/trusted-keys/trusted_tee.c
> > > > > @@ -8,6 +8,7 @@
> > > > >
> > > > >  #include <linux/err.h>
> > > > >  #include <linux/key-type.h>
> > > > > +#include <linux/minmax.h>
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/slab.h>
> > > > >  #include <linux/string.h>
> > > > > @@ -65,38 +66,37 @@ static int trusted_tee_seal(struct trusted_ke=
y_payload *p, char *datablob)
> > > > >         int ret;
> > > > >         struct tee_ioctl_invoke_arg inv_arg;
> > > > >         struct tee_param param[4];
> > > > > -       struct tee_shm *reg_shm_in =3D NULL, *reg_shm_out =3D NUL=
L;
> > > > > +       struct tee_shm *shm;
> > > > > +       uint8_t *buf;
> > > > >
> > > > >         memset(&inv_arg, 0, sizeof(inv_arg));
> > > > >         memset(&param, 0, sizeof(param));
> > > > >
> > > > > -       reg_shm_in =3D tee_shm_register_kernel_buf(pvt_data.ctx, =
p->key,
> > > > > -                                                p->key_len);
> > > > > -       if (IS_ERR(reg_shm_in)) {
> > > > > -               dev_err(pvt_data.dev, "key shm register failed\n"=
);
> > > > > -               return PTR_ERR(reg_shm_in);
> > > > > +       shm =3D tee_shm_alloc_kernel_buf(pvt_data.ctx,
> > > > > +                                      p->key_len + sizeof(p->blo=
b));
> > > > > +       if (IS_ERR(shm)) {
> > > > > +               dev_err(pvt_data.dev, "key shm alloc failed\n");
> > > > > +               return PTR_ERR(shm);
> > > > >         }
> > > > > -
> > > > > -       reg_shm_out =3D tee_shm_register_kernel_buf(pvt_data.ctx,=
 p->blob,
> > > > > -                                                 sizeof(p->blob)=
);
> > > > > -       if (IS_ERR(reg_shm_out)) {
> > > > > -               dev_err(pvt_data.dev, "blob shm register failed\n=
");
> > > > > -               ret =3D PTR_ERR(reg_shm_out);
> > > > > +       buf =3D tee_shm_get_va(shm, 0);
> > > > > +       if (IS_ERR(buf)) {
> > > > > +               ret =3D PTR_ERR(buf);
> > > > >                 goto out;
> > > > >         }
> > > > > +       memcpy(buf, p->key, p->key_len);
> > > >
> > > > These memcpy()'s here and below are undue overheads if we change to
> > > > tee_shm_alloc_kernel_buf().
> > >
> > > There's a bit of overhead when entering and exiting the secure world
> > > too, just to save and restore registers. Anyway, trusted_tee_seal()
> > > doesn't together with FF-A without this patch.
> >
> > By the way, without this patch the kernel fails with:
> > [   12.642071] trusted-key-tee
> > optee-ta-f04a0fe7-1f5d-4b9b-abf7-619b85b4ce8c: blob shm register
> > failed
> > [   12.642576] Unable to handle kernel paging request at virtual
> > address fffffffffffffff3
> > [   12.642668] Mem abort info:
> > [   12.642701]   ESR =3D 0x0000000096000004
> > [   12.642764]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [   12.642821]   SET =3D 0, FnV =3D 0
> > [   12.642864]   EA =3D 0, S1PTW =3D 0
> > [   12.642910]   FSC =3D 0x04: level 0 translation fault
> > [   12.642960] Data abort info:
> > [   12.643006]   ISV =3D 0, ISS =3D 0x00000004
> > [   12.643049]   CM =3D 0, WnR =3D 0
> > [   12.643104] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000043=
bfb000
> > [   12.643197] [fffffffffffffff3] pgd=3D0000000000000000, p4d=3D0000000=
000000000
> > [   12.643654] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> > [   12.643821] Modules linked in:
> > [   12.647781] CPU: 0 PID: 134 Comm: keyctl Not tainted 6.4.0 #1
> > [   12.647990] Hardware name: linux,dummy-virt (DT)
> > [   12.648146] pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BT=
YPE=3D--)
> > [   12.648280] pc : tee_shm_put+0x1c/0x180
> > [   12.648715] lr : tee_shm_free+0x10/0x1c
> > [   12.648773] sp : ffff80000aa33aa0
> > [   12.648822] x29: ffff80000aa33aa0 x28: ffff0000002b7900 x27: ffff800=
00a2f7750
> > [   12.648980] x26: ffff80000aa33cf8 x25: ffff80000a2f76f0 x24: 0000000=
000000020
> > [   12.649088] x23: ffff80000a6b2000 x22: 00000000fffffff3 x21: fffffff=
ffffffff3
> > [   12.649199] x20: fffffffffffffff3 x19: fffffffffffffff3 x18: fffffff=
fffffffff
> > [   12.649307] x17: 62203a6338656334 x16: 623538623931362d x15: 3766626=
12d623962
> > [   12.649414] x14: 342d643566312d37 x13: ffff80000a271ac8 x12: 0000000=
000000363
> > [   12.649523] x11: 0000000000000121 x10: ffff80000a2c9ac8 x9 : ffff800=
00a271ac8
> > [   12.649667] x8 : 00000000ffffefff x7 : ffff80000a2c9ac8 x6 : 0000000=
000000000
> > [   12.649797] x5 : ffff000041ea0c48 x4 : 0000000000000000 x3 : 0000000=
000000000
> > [   12.649912] x2 : 0000000000000000 x1 : 0000000000000000 x0 : fffffff=
ffffffff3
> > [   12.650074] Call trace:
> > [   12.650212]  tee_shm_put+0x1c/0x180
> > [   12.650361]  tee_shm_free+0x10/0x1c
> > [   12.650437]  trusted_tee_seal+0xf4/0x17c
> > [   12.650503]  trusted_instantiate+0x16c/0x1fc
> > [   12.650564]  __key_instantiate_and_link+0x60/0x1f8
> > [   12.650629]  __key_create_or_update+0x2a4/0x460
> > [   12.650691]  key_create_or_update+0x14/0x20
> > [   12.650757]  __arm64_sys_add_key+0xe4/0x244
> > [   12.650822]  invoke_syscall+0x48/0x114
> > [   12.650886]  el0_svc_common.constprop.0+0x44/0xf4
> > [   12.650958]  do_el0_svc+0x3c/0xa8
> > [   12.651015]  el0_svc+0x2c/0x84
> > [   12.651074]  el0t_64_sync_handler+0xbc/0x138
> > [   12.651144]  el0t_64_sync+0x190/0x194
> > [   12.651341] Code: a90153f3 aa0003f4 aa0003f3 a9025bf5 (f8438680)
> > [   12.651654] ---[ end trace 0000000000000000 ]---
> > Segmentation fault
> >
> > So clearly something needs to be done since there's a bug in the error =
path.
> >
> > I'm not overly concerned about the overhead with memcpy(), since we're
> > using relatively small buffers. Kernel clients using large buffers
> > will need a different approach, for example by using page-aligned
> > buffers.
>
> With that too, it is very much possible for kernel clients to share
> the same page for two sub page buffers, correct? IMO, it should be
> handled as part of tee_shm_register_kernel_buf() as you did for
> user-space clients as a short term workaround until we find a real
> fix.
>

Actually thinking about it more, let's rework
tee_shm_register_kernel_buf() to be tee_shm_register_kernel_pages() to
get aligned as we agreed here [1]. This would then shift the
responsibility to check for duplicate pages to kernel clients rather
than the TEE driver (don't need to bother about sub page buffers).

[1] https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfir=
mware.org/thread/Y224PTCQZPKLH2INVWWPRUZM4MDUPYL7/

-Sumit

>
> >
> > Thanks,
> > Jens
> >
> > >
> > > Thanks,
> > > Jens
> > >
> > > >
> > > > -Sumit
> > > >
> > > > >
> > > > >         inv_arg.func =3D TA_CMD_SEAL;
> > > > >         inv_arg.session =3D pvt_data.session_id;
> > > > >         inv_arg.num_params =3D 4;
> > > > >
> > > > >         param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> > > > > -       param[0].u.memref.shm =3D reg_shm_in;
> > > > > +       param[0].u.memref.shm =3D shm;
> > > > >         param[0].u.memref.size =3D p->key_len;
> > > > >         param[0].u.memref.shm_offs =3D 0;
> > > > >         param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT=
;
> > > > > -       param[1].u.memref.shm =3D reg_shm_out;
> > > > > +       param[1].u.memref.shm =3D shm;
> > > > >         param[1].u.memref.size =3D sizeof(p->blob);
> > > > > -       param[1].u.memref.shm_offs =3D 0;
> > > > > +       param[1].u.memref.shm_offs =3D p->key_len;
> > > > >
> > > > >         ret =3D tee_client_invoke_func(pvt_data.ctx, &inv_arg, pa=
ram);
> > > > >         if ((ret < 0) || (inv_arg.ret !=3D 0)) {
> > > > > @@ -104,14 +104,13 @@ static int trusted_tee_seal(struct trusted_=
key_payload *p, char *datablob)
> > > > >                         inv_arg.ret);
> > > > >                 ret =3D -EFAULT;
> > > > >         } else {
> > > > > +               memcpy(p->blob, buf + p->key_len,
> > > > > +                      min(param[1].u.memref.size, sizeof(p->blob=
)));
> > > > >                 p->blob_len =3D param[1].u.memref.size;
> > > > >         }
> > > > >
> > > > >  out:
> > > > > -       if (reg_shm_out)
> > > > > -               tee_shm_free(reg_shm_out);
> > > > > -       if (reg_shm_in)
> > > > > -               tee_shm_free(reg_shm_in);
> > > > > +       tee_shm_free(shm);
> > > > >
> > > > >         return ret;
> > > > >  }
> > > > > @@ -166,11 +165,9 @@ static int trusted_tee_unseal(struct trusted=
_key_payload *p, char *datablob)
> > > > >                 p->key_len =3D param[1].u.memref.size;
> > > > >         }
> > > > >
> > > > > +       tee_shm_free(reg_shm_out);
> > > > >  out:
> > > > > -       if (reg_shm_out)
> > > > > -               tee_shm_free(reg_shm_out);
> > > > > -       if (reg_shm_in)
> > > > > -               tee_shm_free(reg_shm_in);
> > > > > +       tee_shm_free(reg_shm_in);
> > > > >
> > > > >         return ret;
> > > > >  }
> > > > > @@ -183,15 +180,21 @@ static int trusted_tee_get_random(unsigned =
char *key, size_t key_len)
> > > > >         int ret;
> > > > >         struct tee_ioctl_invoke_arg inv_arg;
> > > > >         struct tee_param param[4];
> > > > > -       struct tee_shm *reg_shm =3D NULL;
> > > > > +       struct tee_shm *shm;
> > > > > +       void *buf;
> > > > >
> > > > >         memset(&inv_arg, 0, sizeof(inv_arg));
> > > > >         memset(&param, 0, sizeof(param));
> > > > >
> > > > > -       reg_shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, key=
, key_len);
> > > > > -       if (IS_ERR(reg_shm)) {
> > > > > -               dev_err(pvt_data.dev, "key shm register failed\n"=
);
> > > > > -               return PTR_ERR(reg_shm);
> > > > > +       shm =3D tee_shm_alloc_kernel_buf(pvt_data.ctx, key_len);
> > > > > +       if (IS_ERR(shm)) {
> > > > > +               dev_err(pvt_data.dev, "key shm alloc failed\n");
> > > > > +               return PTR_ERR(shm);
> > > > > +       }
> > > > > +       buf =3D tee_shm_get_va(shm, 0);
> > > > > +       if (IS_ERR(buf)) {
> > > > > +               ret =3D PTR_ERR(buf);
> > > > > +               goto out;
> > > > >         }
> > > > >
> > > > >         inv_arg.func =3D TA_CMD_GET_RANDOM;
> > > > > @@ -199,7 +202,7 @@ static int trusted_tee_get_random(unsigned ch=
ar *key, size_t key_len)
> > > > >         inv_arg.num_params =3D 4;
> > > > >
> > > > >         param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT=
;
> > > > > -       param[0].u.memref.shm =3D reg_shm;
> > > > > +       param[0].u.memref.shm =3D shm;
> > > > >         param[0].u.memref.size =3D key_len;
> > > > >         param[0].u.memref.shm_offs =3D 0;
> > > > >
> > > > > @@ -209,18 +212,19 @@ static int trusted_tee_get_random(unsigned =
char *key, size_t key_len)
> > > > >                         inv_arg.ret);
> > > > >                 ret =3D -EFAULT;
> > > > >         } else {
> > > > > +               memcpy(key, buf, min(param[0].u.memref.size, key_=
len));
> > > > >                 ret =3D param[0].u.memref.size;
> > > > >         }
> > > > >
> > > > > -       tee_shm_free(reg_shm);
> > > > > +out:
> > > > > +       tee_shm_free(shm);
> > > > >
> > > > >         return ret;
> > > > >  }
> > > > >
> > > > >  static int optee_ctx_match(struct tee_ioctl_version_data *ver, c=
onst void *data)
> > > > >  {
> > > > > -       if (ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE &&
> > > > > -           ver->gen_caps & TEE_GEN_CAP_REG_MEM)
> > > > > +       if (ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE)
> > > > >                 return 1;
> > > > >         else
> > > > >                 return 0;
> > > > > --
> > > > > 2.34.1
> > > > >
