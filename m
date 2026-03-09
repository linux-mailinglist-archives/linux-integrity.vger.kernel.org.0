Return-Path: <linux-integrity+bounces-8944-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I2XLTgcrmmk/gEAu9opvQ
	(envelope-from <linux-integrity+bounces-8944-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 09 Mar 2026 02:02:48 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61689232FCB
	for <lists+linux-integrity@lfdr.de>; Mon, 09 Mar 2026 02:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF8923010503
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Mar 2026 01:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2974F22156B;
	Mon,  9 Mar 2026 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qRg7p5Oh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEC31F16B;
	Mon,  9 Mar 2026 01:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773018163; cv=none; b=rxmpFdDs5XQc+pHg7felsA+PwU+GfxUAHIBqoGfPeD6r7OgnM/lZdh5L5KUN87BTUKPc1oPchKpYa/dteb7XuxXkMHfE9E0SBIHz+BWVp5cJFMA+R4hyzKjfbdZSI/SkEHLcH3LMAThCu8zsQVzmSXvmAyOaBNC0n+qSY3WcYFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773018163; c=relaxed/simple;
	bh=74etvlk807ljjkZ6toEN/U0VfA3h0gxwcApl7bLvFvo=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=b5J0CVkGPF+4CfaSBQwKvSSo3ytfQH6369hMk5UrWf1m0H+KFv/E3NhwzLCUiGwhwRDqnNRkKYQXkbMpdhAMkHqd8EakaRRwHIoRFWNyTuV1qVRkKWUKguFMwBcOFnsIY+4lAVmnBpH+fK4MyV7ltOnKAdkaAlbrnBQdmVwJZ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qRg7p5Oh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 628JrcRC1223472;
	Mon, 9 Mar 2026 01:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZAx9/o
	wdG0G6ICXDw5HgKVKEoK5USbJOvKksnS4Fpms=; b=qRg7p5Oh1tsCQ+aHqLUuGn
	vCcGGePq9CtuDWvdb9r7Khed2e9ytRaLfOwXyW3/Jg9zXZcToOGDeM0l0nqowUOd
	w3d/mv3o7fb24ykKQuaHxfQC3u3Al6VWdgwk8cpXRaMdWwVODCd0Z5MziawagM9C
	6f10eiFV/OR8wFy4O5vFh/9ibHtVZhmKFkLBMJ8cepxKx8uNX+iiWJ4KU/kWbEz4
	FsRYJc2MR0QO9LSe87nhLGCEBm4aKUSoGQK3Dc56TcOSf6aPlSmIwsalASrRMdDx
	XzHo2vcEjEfiAugaJV+H+vXTUHayzFTFQZqMlcWZo7FlIzh/zRPYseqjdTpiyi7w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcyw4n0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 01:02:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 628Kt5Me009091;
	Mon, 9 Mar 2026 01:02:00 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crxqy350k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 01:02:00 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62911x9X10355338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 01:01:59 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10D7B5805A;
	Mon,  9 Mar 2026 01:01:59 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D67C05803F;
	Mon,  9 Mar 2026 01:01:56 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.45.230])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Mar 2026 01:01:56 +0000 (GMT)
Message-ID: <abb4d186d1ca76c080d5e15bcd9e0019cce3af39.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity: avoid using __weak functions
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman	
 <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik	
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Arnd
 Bergmann	 <arnd@arndb.de>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry
 Kasatkin	 <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>, James Morris	 <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jarkko Sakkinen	 <jarkko@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Coiby Xu <coxu@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Christian Borntraeger	
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Eric
 Snowberg	 <eric.snowberg@oracle.com>,
        Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Andrew Donnellan
 <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        llvm@lists.linux.dev
In-Reply-To: <20260306225648.GC2746259@ax162>
References: <20260306150421.270124-1-arnd@kernel.org>
	 <20260306225648.GC2746259@ax162>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Mar 2026 21:01:58 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDAwNyBTYWx0ZWRfX3/6s09a465jV
 X5RMKcSgniR/weZ24VJoZk55Xtm/lAiCEumDwtMkgbw7l8qHW3aABWu1Ii6bpWYnZo+KZZQR+Ir
 okBtoUHeLT0gp/D7Ttg4TSGALsBlB7VOPMHgSYsUfOLPhRllx72g3i+0cmD9abPmSeIleww4M4Z
 tKuCL8UVJsQD2+0Wwsl2OTwxYSh41iyVrH4F/mCC5TNaJmjxx0Q0/KI7rjoHptb4hdvfPQ8YKwL
 OD51zYKKm6IrMEIis519AD+VSszUibhD+rMGOMxui5yRpF6YPFtx6RbBRIYenbMKSLR1g0f24Od
 QErYubUT6O76OSER0WRppUfj27l/9I103kzAywGBTXI3AJ4KIC96ExFlDz1vm1HehllIaTDs/RE
 XlwpDC+RELOtoHv7PQcAGDrNA/jxyeL83oMycA/ABD0hCuKzBWvO2FlBr1Sx3o/stlk/k90+Y9w
 Dh8CBsJhgwnIYmMUp5g==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69ae1c0a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=i7x0JOCGzW7_FyAnX44A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uteMIeVtaIqwHYQJDjZ7cWbjdPsRQTqb
X-Proofpoint-ORIG-GUID: a4u9xCS4h4_FS-qJnm-SFm-cF9zF4d1h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-08_07,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090007
X-Rspamd-Queue-Id: 61689232FCB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8944-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,arndb.de,huawei.com,gmail.com,paul-moore.com,namei.org,hallyn.com,kernel.org,redhat.com,oracle.com,google.com,lists.ozlabs.org,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-integrity,lkml];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Fri, 2026-03-06 at 15:56 -0700, Nathan Chancellor wrote:
> On Fri, Mar 06, 2026 at 04:03:24PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >=20
> > The security/integrity/secure_boot.c file containing only a __weak func=
tion
> > leads to a build failure with clang:
> >=20
> > Cannot find symbol for section 2: .text.
> > security/integrity/secure_boot.o: failed
> >=20
> > Moving the function into another file that has at least one non-__weak
> > symbol would solve this, but this is always fragile.
> >=20
> > Avoid __weak definitions entirely and instead move the stub helper into
> > an asm-generic header that gets used by default on architectures that
> > do not provide their own version. This is consistent with how a lot
> > of other architecture specific functionality works, and is more reliabl=
e.
> >=20
> > Fixes: a0f87ede3bf4 ("integrity: Make arch_ima_get_secureboot integrity=
-wide")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > This is a larger change than I had hoped for.
> >=20
> > If you prefer a different way to address the build failure, please
> > treat this as a Reported-by when you apply your own fix
> > ---
> >  arch/powerpc/include/asm/secure_boot.h        |  6 +++
> >  arch/powerpc/kernel/secure_boot.c             |  1 -
> >  arch/s390/include/asm/secure_boot.h           |  9 +++++
> >  include/asm-generic/Kbuild                    |  1 +
> >  include/asm-generic/secure_boot.h             | 37 +++++++++++++++++++
> >  include/linux/secure_boot.h                   |  8 +---
> >  security/integrity/Makefile                   |  2 +-
> >  .../integrity/platform_certs/load_powerpc.c   |  2 +-
> >  security/integrity/secure_boot.c              | 16 --------
> >  9 files changed, 56 insertions(+), 26 deletions(-)
> >  create mode 100644 arch/s390/include/asm/secure_boot.h
> >  create mode 100644 include/asm-generic/secure_boot.h
> >  delete mode 100644 security/integrity/secure_boot.c
>=20
> Thanks, I noticed this as well. The version I came up with and have been
> locally testing is the following, which is a little bit more compact.

Thanks Arnd, Nathan. LGTM.  Nathan, could you send a patch with a proper pa=
tch
description.

Mimi

>=20
>  arch/Kconfig                     |  3 +++
>  arch/powerpc/Kconfig             |  1 +
>  arch/s390/Kconfig                |  1 +
>  arch/s390/kernel/ipl.c           | 10 +++++-----
>  include/linux/secure_boot.h      |  4 ++++
>  security/integrity/Makefile      |  2 +-
>  security/integrity/secure_boot.c | 16 ----------------
>  7 files changed, 15 insertions(+), 22 deletions(-)
>=20
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 102ddbd4298e..a6d1c8cc1d64 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1841,4 +1841,7 @@ config ARCH_WANTS_PRE_LINK_VMLINUX
>  config ARCH_HAS_CPU_ATTACK_VECTORS
>  	bool
> =20
> +config HAVE_ARCH_GET_SECUREBOOT
> +	def_bool EFI
> +
>  endmenu
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index c28776660246..e76d6cf0c403 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -1062,6 +1062,7 @@ config PPC_SECURE_BOOT
>  	depends on IMA_ARCH_POLICY
>  	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
>  	select PSERIES_PLPKS if PPC_PSERIES
> +	select HAVE_ARCH_GET_SECUREBOOT
>  	help
>  	  Systems with firmware secure boot enabled need to define security
>  	  policies to extend secure boot to the OS. This config allows a user
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 24695ea29d5b..76f191dd208b 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -181,6 +181,7 @@ config S390
>  	select GENERIC_IOREMAP if PCI
>  	select HAVE_ALIGNED_STRUCT_PAGE
>  	select HAVE_ARCH_AUDITSYSCALL
> +	select HAVE_ARCH_GET_SECUREBOOT
>  	select HAVE_ARCH_JUMP_LABEL
>  	select HAVE_ARCH_JUMP_LABEL_RELATIVE
>  	select HAVE_ARCH_KASAN
> diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
> index 2d01a1713938..3c346b02ceb9 100644
> --- a/arch/s390/kernel/ipl.c
> +++ b/arch/s390/kernel/ipl.c
> @@ -2388,6 +2388,11 @@ void __no_stack_protector s390_reset_system(void)
>  	diag_amode31_ops.diag308_reset();
>  }
> =20
> +bool arch_get_secureboot(void)
> +{
> +	return ipl_secure_flag;
> +}
> +
>  #ifdef CONFIG_KEXEC_FILE
> =20
>  int ipl_report_add_component(struct ipl_report *report, struct kexec_buf=
 *kbuf,
> @@ -2505,11 +2510,6 @@ void *ipl_report_finish(struct ipl_report *report)
>  	return buf;
>  }
> =20
> -bool arch_get_secureboot(void)
> -{
> -	return ipl_secure_flag;
> -}
> -
>  int ipl_report_free(struct ipl_report *report)
>  {
>  	struct ipl_report_component *comp, *ncomp;
> diff --git a/include/linux/secure_boot.h b/include/linux/secure_boot.h
> index 3ded3f03655c..d17e92351567 100644
> --- a/include/linux/secure_boot.h
> +++ b/include/linux/secure_boot.h
> @@ -10,10 +10,14 @@
> =20
>  #include <linux/types.h>
> =20
> +#ifdef CONFIG_HAVE_ARCH_GET_SECUREBOOT
>  /*
>   * Returns true if the platform secure boot is enabled.
>   * Returns false if disabled or not supported.
>   */
>  bool arch_get_secureboot(void);
> +#else
> +static inline bool arch_get_secureboot(void) { return false; }
> +#endif
> =20
>  #endif /* _LINUX_SECURE_BOOT_H */
> diff --git a/security/integrity/Makefile b/security/integrity/Makefile
> index 548665e2b702..45dfdedbdad4 100644
> --- a/security/integrity/Makefile
> +++ b/security/integrity/Makefile
> @@ -5,7 +5,7 @@
> =20
>  obj-$(CONFIG_INTEGRITY) +=3D integrity.o
> =20
> -integrity-y :=3D iint.o secure_boot.o
> +integrity-y :=3D iint.o
>  integrity-$(CONFIG_INTEGRITY_AUDIT) +=3D integrity_audit.o
>  integrity-$(CONFIG_INTEGRITY_SIGNATURE) +=3D digsig.o
>  integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) +=3D digsig_asymmetric.o
> diff --git a/security/integrity/secure_boot.c b/security/integrity/secure=
_boot.c
> deleted file mode 100644
> index fc2693c286f8..000000000000
> --- a/security/integrity/secure_boot.c
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (C) 2026 Red Hat, Inc. All Rights Reserved.
> - *
> - * Author: Coiby Xu <coxu@redhat.com>
> - */
> -#include <linux/secure_boot.h>
> -
> -/*
> - * Default weak implementation.
> - * Architectures that support secure boot must override this.
> - */
> -__weak bool arch_get_secureboot(void)
> -{
> -	return false;
> -}

