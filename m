Return-Path: <linux-integrity+bounces-7508-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE871BF16BA
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Oct 2025 15:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B983B972E
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Oct 2025 13:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515342F617E;
	Mon, 20 Oct 2025 13:05:26 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF53305051;
	Mon, 20 Oct 2025 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965526; cv=none; b=szbUvfU6IhYFO/S0h/yv7mlG8rRiOkTcib9LFSrQuioAmuNJLnuAXtkwCuOo03SWY8Q7yyjal/9rDwyddDVGWVAItodrWsRZAuVEXrEfBjXfRBXLfjNeFI1XhQ5WqdaD++Rmoea+tCyyxuTk2GoIJcA5E9ZTmwMVLInEeEo11VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965526; c=relaxed/simple;
	bh=6JaNTYuzFX194ohi8CEXAnS9b3DUfGnIy3Avrmyk8WU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J6GT0SkMxIuKpOse+19PspvvUQbEwBMwsUo5hIVS8Mb2yyhiqpmQKDiezvTVHXLrUGDHCKZPb4DenjG7WozxOLZaIgHBjUyQ1/iB9nIhWrA+svHdoBuRIXcn1JrZ5jf6lYsNphZaKJxfY8rGHHe5W0/mzc0V4SwJhhr+p7a/yMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4cqw9t2bhSzpTn3;
	Mon, 20 Oct 2025 20:44:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 7C3C71402EC;
	Mon, 20 Oct 2025 20:45:27 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXjnvdLvZoujOSAA--.4456S2;
	Mon, 20 Oct 2025 13:45:26 +0100 (CET)
Message-ID: <1987088bb29971883d2b5c06a31c8114c729422c.camel@huaweicloud.com>
Subject: Re: [PATCH] ima: Fall back to default kernel module signature
 verification
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Coiby Xu <coxu@redhat.com>
Cc: linux-integrity@vger.kernel.org, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>,  Karel Srot <ksrot@redhat.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Date: Mon, 20 Oct 2025 14:45:15 +0200
In-Reply-To: <559f6ebf4a19da321fffc2a3ca180dc3d6216a22.camel@linux.ibm.com>
References: <20250928030358.3873311-1-coxu@redhat.com>
	 <896f4fb0c0146512a66daf0b4c1e033aca4bd6d4.camel@linux.ibm.com>
	 <bcd1f7b48311aff55711cdff4a6cdbb72aae1d04.camel@linux.ibm.com>
	 <xq7bgyg63xlbogcik2we26yr5uf62f6kj3qn7ooljmqaoccrix@kkmuhza5cfdr>
	 <9d279fd3d7b3cbb2778183ec777d6b9da8a64b82.camel@linux.ibm.com>
	 <5bzredottmp2tdm3uebzjfqjr6c7bwssqkrbdqvudruvzr764e@37j6ycjci2sk>
	 <27bb0c218084f51eba07f041d0fffea8971865b9.camel@linux.ibm.com>
	 <z6f4getlayaxaxvlxfxn2yvn5dvhrct64wke4uu2s3dfll3bqq@754bklrku55n>
	 <559f6ebf4a19da321fffc2a3ca180dc3d6216a22.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAXjnvdLvZoujOSAA--.4456S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDGFy7Zr4fAF1UKF15Jwb_yoW5AF15pF
	WkWa4YyrZ5JFn3Jan2vwn8WrWrKrWxG3yUXFn8Kr1kA3W5X3W0vr10yF4Y9F4kXw1Sgw45
	ZrW2kr17Za98ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAHBGj1k+sIuQAAsV

On Mon, 2025-10-20 at 08:21 -0400, Mimi Zohar wrote:
> On Sat, 2025-10-18 at 07:19 +0800, Coiby Xu wrote:
> > > > > 2. Instead of defining an additional process_measurement() argume=
nt to identify
> > > > > compressed kernel modules, to simplify the code it might be possi=
ble to define a
> > > > > new "func" named COMPRESSED_MODULE_CHECK.
> > > > >=20
> > > > > +       [READING_COMPRESSED_MODULE] =3D MODULE_CHECK,  -> COMPRES=
SED_MODULE_CHECK
> > > >=20
> > > > I also thought about this approach. But IMA rule maps kernel module
> > > > loading to MODULE_CHECK. If we define a new rule and ask users to u=
se
> > > > this new rule, ima_policy=3Dsecure_boot still won't work.
> > >=20
> > > I don't have a problem with extending the "secure-boot" policy to sup=
port
> > > uncompressed kernel modules appended signatures, based on whether
> > > CONFIG_MODULE_SIG is enabled.  The new rule would be in addition to t=
he existing
> > > MODULE_CHECK rule.
> >=20
> > I assume once the new rule get added, we can't remove it for userspace
> > backward compatibility, right? And with CPIO xattr supported, it seems
> > there is no need to keep this rule. So if this concern is valid, do you
> > think we shall switch to another approach i.e. to make IMA support
> > verifying decompressed module and then make "secure-boot" to allow
> > appended module signature?
>=20
> Yes, once the rule is added, it wouldn't be removed.  As for "to make IMA
> support verifying decompressed module", yes that might be a better soluti=
on,
> than relying on "sig_enforce" being enabled. IMA already supports verifyi=
ng the
> appended signatures.  A new IMA specific or LSM hook would need to be def=
ined
> after module_decompress().
>=20
> Remember based on policy, IMA supports:
> 1. verifying the signature stored in security.ima xattr
> 2. verifying the appended signature (not for compressed kernel modules)
> 3. verifying both the xattr and appended signatures
> 4. none
>=20
> To prevent 3 - verifying both types of signatures, the IMA arch specific =
policy
> rule only adds the "appraise func=3DMODULE_CHECK ..." rule if CONFIG_MODU=
LE_SIG is
> NOT enabled.  Calling set_module_sig_enforced() from ima_appraise_measure=
ment()
> to set sig_enforce could inadvertently result in requiring both the xattr=
 and
> the appended signature kernel module verification.  To prevent this from
> happening, "sig_enforce" should not be set, only verified in
> ima_appraise_measurement().
>=20
> >=20
> > Another thought is to make CPIO support xattr. Today I realize that
> > ima_policy=3Dsecure_boot can also cause failure of loading kdump kernel=
.
> > So the issue this patch tries to resolves has much less impact than I
> > thought. Maybe we can wait until CPIO xattr support is ready? I'll help
> > review and test Roberto's patches if this is the best way forward.
>=20
> I'm not sure of the status of the CPIO patch set.  Roberto?

I haven't had time to look at it recently. I can take the openEuler
version, address the remaining comments and repost.

Roberto


