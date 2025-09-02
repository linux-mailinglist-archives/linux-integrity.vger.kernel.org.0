Return-Path: <linux-integrity+bounces-6965-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 980B7B4013C
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 14:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099491B60B2B
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 12:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8782C21C9;
	Tue,  2 Sep 2025 12:50:23 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFCB2C11D4;
	Tue,  2 Sep 2025 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817423; cv=none; b=E4mvI+6/qteJISLErQbuALiiRse3HjRqwJ9DLPZfQG6mzilIgPf+gcAh8ahHq5QK5zrJ0AcyRlI7pKKtR4JRGykcU4/M9BrFsUXUsRIvmpiFuGVy10lhuTkU6/BjDw6ouL+Z/RiCrhT3Nlz1rm1QwESR+8PrWcK1/KBst/iv3aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817423; c=relaxed/simple;
	bh=CRhUELfehvg3qmA0JDdoZTEFgl4js+3iJtNycdeiPS4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z0O9q+laoAN8kT1lMT9RlPF/1kd53HYMrksdjlqAyQ1CbCK1EZIbYx3b5cCG9ZO2ISrYzeGGkFrRJhrHDgy1FTjjy93cjPSdHMvYcN5yzVLNZFOpUl0PPKj4pGLPGkc+GQwvTT37RLH8wOQKMkrIRwAZO7BJV9fMwtwGSV3hgtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cGQXQ2KkqzsZNj;
	Tue,  2 Sep 2025 20:48:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 8D6A0140132;
	Tue,  2 Sep 2025 20:50:16 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwD39qX_57ZoZ3GeAA--.19155S2;
	Tue, 02 Sep 2025 13:50:16 +0100 (CET)
Message-ID: <9f35539de7188c6b853c55b76958a286131f5928.camel@huaweicloud.com>
Subject: Re: [PATCH v3 31/34] ima,evm: move initcalls to the LSM framework
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
 selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, Fan
 Wu <wufan@kernel.org>, =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=
 <mic@digikod.net>,  =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, Casey
 Schaufler <casey@schaufler-ca.com>, Tetsuo Handa
 <penguin-kernel@i-love.sakura.ne.jp>, Nicolas Bouchinet
 <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Date: Tue, 02 Sep 2025 14:50:05 +0200
In-Reply-To: <CAHC9VhS3KdVO9n-dgk1qFzTae0i+Oab8atMmt0CAsMEm1D4v5w@mail.gmail.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
	 <20250814225159.275901-67-paul@paul-moore.com>
	 <CAHC9VhS3KdVO9n-dgk1qFzTae0i+Oab8atMmt0CAsMEm1D4v5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwD39qX_57ZoZ3GeAA--.19155S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw18Xw1kuw45ArW3KryxAFb_yoWxZryUpF
	sFgayUGr1kAFyIkF93A3WYkFyfK3yFgryUGr1Ykr10yasI9r1kWrn7Ary5ur1fGrWYy3WI
	vF4aqr1ak3WDtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUru
	WlDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBGi2lWkE2gABso

On Fri, 2025-08-22 at 16:45 -0400, Paul Moore wrote:
> On Thu, Aug 14, 2025 at 6:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >=20
> > This patch converts IMA and EVM to use the LSM frameworks's initcall
> > mechanism.  There was a minor challenge in this conversion that wasn't
> > seen when converting the other LSMs brought about by the resource
> > sharing between the two related, yes independent IMA and EVM LSMs.
> > This was resolved by registering the same initcalls for each LSM and
> > including code in each registered initcall to ensure it only executes
> > once during each boot.
> >=20
> > It is worth mentioning that this patch does not touch any of the
> > "platform certs" code that lives in the security/integrity/platform_cer=
ts
> > directory as the IMA/EVM maintainers have assured me that this code is
> > unrelated to IMA/EVM, despite the location, and will be moved to a more
> > relevant subsystem in the future.
> >=20
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/integrity/Makefile       |  2 +-
> >  security/integrity/evm/evm_main.c |  6 ++---
> >  security/integrity/iint.c         |  4 +--
> >  security/integrity/ima/ima_main.c |  6 ++---
> >  security/integrity/initcalls.c    | 41 +++++++++++++++++++++++++++++++
> >  security/integrity/initcalls.h    | 28 +++++++++++++++++++++
> >  6 files changed, 78 insertions(+), 9 deletions(-)
> >  create mode 100644 security/integrity/initcalls.c
> >  create mode 100644 security/integrity/initcalls.h
>=20
> Mimi, Roberto, I believe I've incorporated all of your feedback thus
> far, does this patch look okay to you?  If so, can I get an ACK from
> one or both of you?

I just realized that it could be rewritten without exposing the IMA and
EVM init functions. I also added the logic to cleanup the integrity
directory itself.

Sending soon...

Roberto

> > diff --git a/security/integrity/Makefile b/security/integrity/Makefile
> > index 92b63039c654..6ea330ea88b1 100644
> > --- a/security/integrity/Makefile
> > +++ b/security/integrity/Makefile
> > @@ -5,7 +5,7 @@
> >=20
> >  obj-$(CONFIG_INTEGRITY) +=3D integrity.o
> >=20
> > -integrity-y :=3D iint.o
> > +integrity-y :=3D iint.o initcalls.o
> >  integrity-$(CONFIG_INTEGRITY_AUDIT) +=3D integrity_audit.o
> >  integrity-$(CONFIG_INTEGRITY_SIGNATURE) +=3D digsig.o
> >  integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) +=3D digsig_asymmetric.o
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm=
/evm_main.c
> > index db8e324ed4e6..823573bcaa27 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -25,6 +25,7 @@
> >  #include <crypto/hash.h>
> >  #include <crypto/hash_info.h>
> >  #include <crypto/utils.h>
> > +#include "../initcalls.h"
> >  #include "evm.h"
> >=20
> >  int evm_initialized;
> > @@ -1112,7 +1113,7 @@ void __init evm_load_x509(void)
> >  }
> >  #endif
> >=20
> > -static int __init init_evm(void)
> > +int __init init_evm(void)
> >  {
> >         int error;
> >         struct list_head *pos, *q;
> > @@ -1179,6 +1180,5 @@ DEFINE_LSM(evm) =3D {
> >         .init =3D init_evm_lsm,
> >         .order =3D LSM_ORDER_LAST,
> >         .blobs =3D &evm_blob_sizes,
> > +       .initcall_late =3D integrity_late_init,
> >  };
> > -
> > -late_initcall(init_evm);
> > diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> > index 068ac6c2ae1e..a4b88d67ff43 100644
> > --- a/security/integrity/iint.c
> > +++ b/security/integrity/iint.c
> > @@ -11,6 +11,7 @@
> >   */
> >  #include <linux/security.h>
> >  #include "integrity.h"
> > +#include "initcalls.h"
> >=20
> >  struct dentry *integrity_dir;
> >=20
> > @@ -42,7 +43,7 @@ void __init integrity_load_keys(void)
> >                 evm_load_x509();
> >  }
> >=20
> > -static int __init integrity_fs_init(void)
> > +int __init integrity_fs_init(void)
> >  {
> >         integrity_dir =3D securityfs_create_dir("integrity", NULL);
> >         if (IS_ERR(integrity_dir)) {
> > @@ -58,4 +59,3 @@ static int __init integrity_fs_init(void)
> >         return 0;
> >  }
> >=20
> > -late_initcall(integrity_fs_init)
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima=
/ima_main.c
> > index eade8e1e3cb1..06ae59cd77f4 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/iversion.h>
> >  #include <linux/evm.h>
> >  #include <linux/crash_dump.h>
> > +#include "../initcalls.h"
> >=20
> >  #include "ima.h"
> >=20
> > @@ -1202,7 +1203,7 @@ static int ima_kernel_module_request(char *kmod_n=
ame)
> >=20
> >  #endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
> >=20
> > -static int __init init_ima(void)
> > +int __init init_ima(void)
> >  {
> >         int error;
> >=20
> > @@ -1283,6 +1284,5 @@ DEFINE_LSM(ima) =3D {
> >         .init =3D init_ima_lsm,
> >         .order =3D LSM_ORDER_LAST,
> >         .blobs =3D &ima_blob_sizes,
> > +       .initcall_late =3D integrity_late_init,
> >  };
> > -
> > -late_initcall(init_ima);       /* Start IMA after the TPM is available=
 */
> > diff --git a/security/integrity/initcalls.c b/security/integrity/initca=
lls.c
> > new file mode 100644
> > index 000000000000..6afa411068f2
> > --- /dev/null
> > +++ b/security/integrity/initcalls.c
> > @@ -0,0 +1,41 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * IMA/EVM initcalls
> > + *
> > + */
> > +
> > +#include <linux/init.h>
> > +
> > +#include "initcalls.h"
> > +
> > +/**
> > + * integrity_late_init - late_initcalls for IMA/EVM
> > + *
> > + * This helper function wraps all of the late_initcalls for both IMA a=
nd EVM.
> > + * It can be called multiple times, e.g. once from IMA and once from E=
VM,
> > + * without problem as it maintains an internal static state variable w=
hich
> > + * ensures that any setup/initialization is only done once.
> > + */
> > +int __init integrity_late_init(void)
> > +{
> > +       int rc =3D 0, rc_tmp;
> > +       static bool setup =3D false;
> > +
> > +       if (setup)
> > +               return 0;
> > +       setup =3D true;
> > +
> > +       rc_tmp =3D integrity_fs_init();
> > +       if (!rc && rc_tmp)
> > +               rc =3D rc_tmp;
> > +
> > +       rc_tmp =3D init_ima();
> > +       if (!rc && rc_tmp)
> > +               rc =3D rc_tmp;
> > +
> > +       rc_tmp =3D init_evm();
> > +       if (!rc && rc_tmp)
> > +               rc =3D rc_tmp;
> > +
> > +       return rc;
> > +}
> > diff --git a/security/integrity/initcalls.h b/security/integrity/initca=
lls.h
> > new file mode 100644
> > index 000000000000..b56e9c576505
> > --- /dev/null
> > +++ b/security/integrity/initcalls.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef _INTEGRITY_INITCALLS_H
> > +#define _INTEGRITY_INITCALLS_H
> > +
> > +int integrity_fs_init(void);
> > +
> > +#ifdef CONFIG_IMA
> > +int init_ima(void);
> > +#else
> > +static inline int init_ima(void)
> > +{
> > +       return 0;
> > +}
> > +#endif
> > +
> > +#ifdef CONFIG_EVM
> > +int init_evm(void);
> > +#else
> > +static inline int init_evm(void)
> > +{
> > +       return 0;
> > +}
> > +#endif
> > +
> > +int integrity_late_init(void);
> > +
> > +#endif
> > --
> > 2.50.1
>=20


