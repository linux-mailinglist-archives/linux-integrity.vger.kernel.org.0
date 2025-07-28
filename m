Return-Path: <linux-integrity+bounces-6740-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3593B1397D
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Jul 2025 13:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B113BBF3B
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Jul 2025 11:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8005725D1EE;
	Mon, 28 Jul 2025 11:03:23 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A57C221FD8;
	Mon, 28 Jul 2025 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753700603; cv=none; b=LRX6i+HtkHT063E+2dMZooCWqS18t7EkGWa7aFWF51E+4akHMGXdP0cpG1hGvneyDq8S4TtOnUzf5K2NP47ifvdE6BeRWwihhZvXJ9F4iWC3wsxshYJTNg0H+28cHif7HDt/pmAd2paqzn7lpbkgblMBUSoq7t7YtwaiYgulR6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753700603; c=relaxed/simple;
	bh=CN1jnDvA3LyMBJiEkR5/JGLNsQlLMgk0oGT8Glp2hSs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N+PxVA/ky/X9HRfLNgwLAAznbimT9s4QtIpx0Cj83r5BUQHWqpXCvMQL61lvHO4Lrwnyd6Yg4H/fbAOKoMiUQ2mWqCLDoPyo+8zZHDOFx04tVPgIctoTIEC6c7l3z4nFYH1EWv5TkCnoJLMtLySLR7pLNY/ZXnKsAxJetUV/MmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4brFR26fYVzsS9P;
	Mon, 28 Jul 2025 18:42:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id DC50D1402F6;
	Mon, 28 Jul 2025 18:44:03 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCHEphpVIdo6Vz5AA--.58937S2;
	Mon, 28 Jul 2025 11:44:03 +0100 (CET)
Message-ID: <6c5ebaa88d1ee15046e9ea0bc61d9a843b850200.camel@huaweicloud.com>
Subject: Re: [RFC PATCH v2 31/34] ima,evm: move initcalls to the LSM
 framework
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Paul Moore
	 <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
 selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, Mimi
 Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, Fan
 Wu <wufan@kernel.org>, =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=
 <mic@digikod.net>,  =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, Casey
 Schaufler <casey@schaufler-ca.com>, Tetsuo Handa
 <penguin-kernel@i-love.sakura.ne.jp>, Xiu Jianfeng <xiujianfeng@huawei.com>
Date: Mon, 28 Jul 2025 12:43:50 +0200
In-Reply-To: <st4eimc4lovdeqrtxfhwjpgcblyufzahec2hmtrxvkpp4woejw@iqeuzubt7afe>
References: <20250721232142.77224-36-paul@paul-moore.com>
	 <20250721232142.77224-67-paul@paul-moore.com>
	 <st4eimc4lovdeqrtxfhwjpgcblyufzahec2hmtrxvkpp4woejw@iqeuzubt7afe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCHEphpVIdo6Vz5AA--.58937S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWxur4fXFWrKryxAryfXrb_yoW5ZFyDpa
	nFgayUGr1kZFWIka93C3W5CFyfK39Ygry5Gw15Arn0yF93ur1UWrs7AryUGr1fGrW5Gayx
	twnaqr4akw1DtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFk
	u4UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBGiHHzsDCgAAsE

On Mon, 2025-07-28 at 11:46 +0200, Nicolas Bouchinet wrote:
> Hi Paul,
>=20
> With `CONFIG_INTEGRITY=3Dy` but not `CONFIG_IMA=3Dy` or `CONFIG_EVM=3Dy` =
it
> does not compile :

Hi Nicolas

thanks, I was about to answer too:

Same type of change as for Smack (I didn't check the other LSMs):

diff --git a/security/integrity/initcalls.h
b/security/integrity/initcalls.h
index 5511c62f8166..a0e27fab67db 100644
--- a/security/integrity/initcalls.h
+++ b/security/integrity/initcalls.h
@@ -5,8 +5,23 @@
=20
 int integrity_fs_init(void);
=20
+#ifdef CONFIG_IMA
 int init_ima(void);
+#else
+static inline int init_ima(void)
+{
+       return 0;
+}
+#endif
+
+#ifdef CONFIG_EVM
 int init_evm(void);
+#else
+static inline int init_evm(void)
+{
+       return 0;
+}
+#endif
=20
 int integrity_late_init(void);


Plus:

diff --git a/security/integrity/initcalls.c
b/security/integrity/initcalls.c
index 92ec9f0aa2a7..6afa411068f2 100644
--- a/security/integrity/initcalls.c
+++ b/security/integrity/initcalls.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Platform certificate / keyring initcalls
+ * IMA/EVM initcalls
  *
  */

Thanks

Roberto

> ```
> ld: vmlinux.o: in function `integrity_late_init':
> security/integrity/initcalls.c:32:(.init.text+0x47f85): undefined referen=
ce to `init_ima'
> ld: security/integrity/initcalls.c:36:(.init.text+0x47f96): undefined ref=
erence to `init_evm'
> make[2]: *** [scripts/Makefile.vmlinux:91: vmlinux.unstripped] Error 1
> make[1]: *** [Makefile:1236: vmlinux] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> ```
>=20
> >  security/integrity/Makefile       |  2 +-
> >  security/integrity/evm/evm_main.c |  6 ++---
> >  security/integrity/iint.c         |  4 +--
> >  security/integrity/ima/ima_main.c |  6 ++---
> >  security/integrity/initcalls.c    | 41 +++++++++++++++++++++++++++++++
> >  security/integrity/initcalls.h    | 13 ++++++++++
> >  6 files changed, 63 insertions(+), 9 deletions(-)
> >  create mode 100644 security/integrity/initcalls.c
> >  create mode 100644 security/integrity/initcalls.h
> >=20
> > diff --git a/security/integrity/Makefile b/security/integrity/Makefile
> > index 92b63039c654..6ea330ea88b1 100644
> > --- a/security/integrity/Makefile
> > +++ b/security/integrity/Makefile
> > @@ -5,7 +5,7 @@
> > =20
> >  obj-$(CONFIG_INTEGRITY) +=3D integrity.o
> > =20
> > -integrity-y :=3D iint.o
> > +integrity-y :=3D iint.o initcalls.o
> >  integrity-$(CONFIG_INTEGRITY_AUDIT) +=3D integrity_audit.o
> >  integrity-$(CONFIG_INTEGRITY_SIGNATURE) +=3D digsig.o
> >  integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) +=3D digsig_asymmetric.o
>=20
> ---
>=20
> > diff --git a/security/integrity/initcalls.h b/security/integrity/initca=
lls.h
> > new file mode 100644
> > index 000000000000..5511c62f8166
> > --- /dev/null
> > +++ b/security/integrity/initcalls.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef PLATFORM_CERTS_INITCALLS_H
> > +#define PLATFORM_CERTS_INITCALLS_H
> > +
> > +int integrity_fs_init(void);
> > +
> > +int init_ima(void);
> > +int init_evm(void);
> > +
> > +int integrity_late_init(void);
> > +
> > +#endif
> > --=20
> > 2.50.1
> >=20
>=20
> Nicolas


