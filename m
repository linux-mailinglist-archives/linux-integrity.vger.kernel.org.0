Return-Path: <linux-integrity+bounces-3331-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF7195491B
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2024 14:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2A5282743
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2024 12:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E664191F84;
	Fri, 16 Aug 2024 12:47:25 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287E012D1EA;
	Fri, 16 Aug 2024 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812444; cv=none; b=C1jG55o0Shsolt7WNxNCruwrKDvkxwRoNlEnfF8lnBb3TSNldWASbJwBiyXKyugTyXclcDZa+HCvvWZDE/26XEDB+pDCjV5QA5SrNQi1F9qyrkq5z4TvpaCKeg+e1IvusYQK+lnOLO6/Eo6mYw9gArdDRr3JzNEg1nPmrZsoVu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812444; c=relaxed/simple;
	bh=hnHOO/dXQijXQAoNamwVfvpM0tQ1sEtFHK6INknzWBM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C+42VlAet79m06BWR3zFyyxNSRjhN3rLcZ9wgjMa7wV+auLptwiHfyh0UeH2YGnEVukwCeljoHJdHMpEOx6C2i1N6G0RUGwAPvI4MnFhRCUR4djwfKFove/J6sIzHllFtBtIJ1v37+hx0o5DBzK1HeacER/z89zAxU8hORFRCVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Wlh9L2tKDz9v7NG;
	Fri, 16 Aug 2024 20:28:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id B1D7E1405A1;
	Fri, 16 Aug 2024 20:47:08 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCXG4Y_Sr9mPW5NAQ--.27255S2;
	Fri, 16 Aug 2024 13:47:07 +0100 (CET)
Message-ID: <17a57bba3be1f379d274fd83966612ba47d3ea0f.camel@huaweicloud.com>
Subject: Re: [RFC] integrity: wait for completion of i2c initialization
 using late_initcall_sync()
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Romain Naour <romain.naour@smile.fr>, 
	Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 serge@hallyn.com, jmorris@namei.org, paul@paul-moore.com,
 eric.snowberg@oracle.com,  dmitry.kasatkin@gmail.com,
 roberto.sassu@huawei.com, Romain Naour <romain.naour@skf.com>
Date: Fri, 16 Aug 2024 14:46:52 +0200
In-Reply-To: <80af3c293db64365bdadbec122c37de7194fbf51.camel@linux.ibm.com>
References: <20240701133814.641662-1-romain.naour@smile.fr>
	 <c090cd3c-f4c6-4923-a9fa-b54768ca2a26@molgen.mpg.de>
	 <d7429218-7b48-4201-8ad9-63728e188be5@smile.fr>
	 <e197920f27bc67df45327ef56ee509d113435b25.camel@linux.ibm.com>
	 <b551f01f52d5cefea3992f6c75baa0683ed57ac9.camel@linux.ibm.com>
	 <785b9c89-a9a6-427d-8715-110cb638b645@smile.fr>
	 <80af3c293db64365bdadbec122c37de7194fbf51.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCXG4Y_Sr9mPW5NAQ--.27255S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4xCFW3Ary5AFy5AF13Jwb_yoWrGryDpF
	WIqan8KFykG3yrCwnxK3WrWF1Fv397Jr45Xr1rG3s5urn0kr1qgrsavr4Y9F92vr48K3Wj
	vF1IvasFk3WDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYY7kG6xAYrwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU5lksDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBGa+tXAJiwABsK

On Tue, 2024-08-06 at 20:41 -0400, Mimi Zohar wrote:
> On Thu, 2024-08-01 at 12:12 +0200, Romain Naour wrote:
> > Hi Mimi,
> >=20
> > Le 11/07/2024 =C3=A0 16:06, Mimi Zohar a =C3=A9crit=C2=A0:
> > > On Mon, 2024-07-01 at 22:37 -0400, Mimi Zohar wrote:
> > > > Hi Romain,
> > > >=20
> > > > Please limit the subject line to 70 - 75 characters.
> > > >=20
> > > >=20
> > > > On Mon, 2024-07-01 at 16:58 +0200, Romain Naour wrote:
> > > > > > > [1]
> > > > > > > https://lore.kernel.org/linux-integrity/9b98d912-ba78-402c-a5=
c8-154bef8794f7@smile.fr/
> > > > > > > [2]
> > > > > > > https://e2e.ti.com/support/processors-group/processors/f/proc=
essors-forum/1375425/tda4vm-ima-vs-tpm-builtin-driver-boot-order
> > > > > > >=20
> > > > > > > Signed-off-by: Romain Naour <romain.naour@skf.com>
> > > > > >=20
> > > > > > Should this get a Fixes: tag and be also applied to the stable =
series?
> > > > >=20
> > > > > The current behavior can be reproduced on any released kernel (at=
 least since
> > > > > 6.1). But I'm not sure if it should be backported to stable kerne=
ls since it
> > > > > delays the ima/evm initialization at runtime.
> > > >=20
> > > > With the IMA builtin measurement policy specified on the boot comma=
nd line
> > > > ("ima_policy=3Dtcb"), moving init_ima from the late_initcall() to
> > > > late_initcall_sync() affects the measurement list order.  It's unli=
kely, but
> > > > possible, that someone is sealing the TPM to PCR-10.  It's probably=
 not a good
> > > > idea to backport the change.
> > > >=20
> > > > An alternative would be to continue using the late_initcall(), but =
retry on
> > > > failure, instead of going directly into TPM-bypass mode.
> >=20
> > Indeed, it would be better if the IMA (and EVM) can use something like =
EPROBE_DEFER.
>=20
> Yes, "something like EPROBE_DEFER" sounds like the right direction.  Depe=
nding
> on the environment, the TPM initialization delay might be acceptable and =
not
> introduce an integrity gap.
>=20
> For now let's start with just late_initcall() and late_initcall_sync().  =
If the
> TPM hasn't been initialized, not all of ima_init() needs to be deferred t=
o
> late_initcall_sync().

Just a personal opinion. I like the idea of initializing everything as
soon as possible, even if there is no TPM.

However, in the case where only the kernel image has been measured by
the boot loader and one wants measurements with file granularity for
the initial ram disk, deferring the TPM PCR extend I think it is not
acceptable from the trusted computing point of view.

One example would be loading a kernel module while the TPM is still not
available, where the kernel module would be able to escape the
subsequent measurement later when the TPM becomes available.

In this particular case, if there is a measurement policy in place, I
would deny any operation matching the policy, until the TPM is
available (no defer).

If there is really need for allowing something before the TPM is
available, I would pass the digest of what it should be allowed by the
kernel somehow (e.g. from the boot loader, kernel command line?). In
this way, the allowed operations are measured before in the earlier
stages of the boot.

Roberto

> >=20
> > > >=20
> > > > As far as I can tell, everything is still being measured and verifi=
ed, but more
> > > > testing is required.
> >=20
> > Agree, I'm still evaluating the TPM stack when time allows.
> >=20
> > >=20
> > > Romain, Paul, another report of IMA going into TPM-bypass mode is her=
e:=20
> > > https://github.com/raspberrypi/linux/issues/6217.  Deferring IMA init=
ialization
> > > to late_initcall_sync() did not resolve the problem for them.  Please=
 take a
> > > look at the report.
> >=20
> > I don't think that the "mdelay(200)" is really needed when late_initcal=
l_sync()
> > is used. I guess the issue was the spi driver was not builtin, fixed by=
:
> >=20
> > CONFIG_SPI_DESIGNWARE=3Dy
> > CONFIG_SPI_DW_MMIO=3Dy
>=20
> Good to know.
>=20
> thanks,
>=20
> Mimi


