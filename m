Return-Path: <linux-integrity+bounces-5006-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C41A48238
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2025 15:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12941663AC
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2025 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE9F25BAD9;
	Thu, 27 Feb 2025 14:50:19 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7F6241129
	for <linux-integrity@vger.kernel.org>; Thu, 27 Feb 2025 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667819; cv=none; b=KTbNbyH4gGBrVDdgDky9kwOqFUloAYShksAeIfJ44Jy1wkdHN0u9BVHZNtCZDR65qGFqgPQ8okzpiO15N9kIkqpTinIEn7uoL2ntikhTAHICVF4RpUMlLp4AWcLqv3KvccbGP99CtlxgBYyyZK03O4oCCLYzDQp9bLaYBw5fspM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667819; c=relaxed/simple;
	bh=UqWx/GoII9p/cY0pguogwDFaZAndewTBOZpBj/zMYOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aHqPIYozMChE6Ii0k5sA6C1XrwT5MVuv5ok8SWPkoNOrJe31GjDmP+iOn6IM+4E3FzjNdRpSJt35ZwZKy5AbIqbGhPWdQXSFdV8c6QCLwn6Q2Fk8E7B8vwEP2wMADW/EZj2dZc+bybc4WTWZwVXnjJAVfyp6nWrsq6DIswadOkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4Z3Z4Z2kwQzpT07
	for <linux-integrity@vger.kernel.org>; Thu, 27 Feb 2025 22:49:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id DD966140393
	for <linux-integrity@vger.kernel.org>; Thu, 27 Feb 2025 22:50:07 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCnLUyZe8BngX9GAw--.61035S2;
	Thu, 27 Feb 2025 15:50:07 +0100 (CET)
Message-ID: <2a6924b36ab41fd5d9666de726b9f4a0754b9cbb.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH] ima: add measurement for first unverified write on
 ima policy file
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Enrico Bravi <enrico.bravi@polito.it>, "roberto.sassu@huawei.com"
 <roberto.sassu@huawei.com>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "zohar@linux.ibm.com"
 <zohar@linux.ibm.com>,  "dmitry.kasatkin@gmail.com"
 <dmitry.kasatkin@gmail.com>
Cc: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Date: Thu, 27 Feb 2025 15:49:57 +0100
In-Reply-To: <484b1563482aca871a147daeff916fcb0730c6d6.camel@polito.it>
References: <20250225131255.154826-1-enrico.bravi@polito.it>
	 <ecc4630b5e3161736aa1e32f037facb9123025fc.camel@linux.ibm.com>
	 <013864bca0b53d65b9546125090c8d7776ee565a.camel@polito.it>
	 <9fb7a98bb88c05d953fd90c84c78af0bbd58df9b.camel@linux.ibm.com>
	 <484b1563482aca871a147daeff916fcb0730c6d6.camel@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCnLUyZe8BngX9GAw--.61035S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw1kCFWftrykCw1UKFyDKFg_yoWrCF4fpF
	WYka4vkF1DXryxAw1xKF1FgF4FvrWkJ3y5Xry5JryUC3Z0kFn5Kw45tr1Ygr18tr48Gr1j
	qr1YvrW3X3WDXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBGfADtkFWgACsk

On Thu, 2025-02-27 at 11:36 +0000, Enrico  Bravi wrote:
> On Wed, 2025-02-26 at 22:05 -0500, Mimi Zohar wrote:
> > On Wed, 2025-02-26 at 22:53 +0000, Enrico=C2=A0 Bravi wrote:
> > > On Tue, 2025-02-25 at 20:53 -0500, Mimi Zohar wrote:
> > > > On Tue, 2025-02-25 at 14:12 +0100, Enrico Bravi wrote:
> > > > > The first write on the ima policy file permits to override the de=
fault
> > > > > policy defined with the ima_policy=3D boot parameter. This can be=
 done
> > > > > by adding the /etc/ima/ima-policy which allows loading the custom=
 policy
> > > > > during boot. It is also possible to load custom policy at runtime
> > > > > through
> > > > > file operations:
> > > > >=20
> > > > > cp custom_ima_policy /sys/kernel/security/ima/policy
> > > > > cat custom_ima_policy > /sys/kernel/security/ima/policy
> > > > >=20
> > > > > or by writing the absolute path of the file containing the custom
> > > > > policy:
> > > > >=20
> > > > > echo /path/of/custom_ima_policy > /sys/kernel/security/ima/policy
> > > > >=20
> > > > > In these cases, file signature can be necessary to load the polic=
y
> > > > > (func=3DPOLICY_CHECK). Custom policy can also be set at runtime b=
y
> > > > > directly
> > > > > writing the policy stream on the ima policy file:
> > > > >=20
> > > > > echo -e "measure func=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"audit func=3DBPR=
M_CHECK mask=3DMAY_EXEC\n" \
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 > /sys/kernel/security/ima/policy
> > > > >=20
> > > > > In this case, there is no mechanism to verify the integrity of th=
e new
> > > > > policy.
> > > > >=20
> > > > > Add a new entry in the ima measurements list containing the ascii=
 custom
> > > > > ima policy buffer when not verified at load time.
> > > > >=20
> > > > > Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
> > > >=20
> > > > Hi Enrico,
> > >=20
> > > Hi Mimi,
> > >=20
> > > thank you for the quick response.
> > >=20
> > > > This patch set hard codes measuring the initial custom IMA policy r=
ules
> > > > that
> > > > replace the builtin policies specified on the boot command line.=C2=
=A0 IMA
> > > > shouldn't hard code policy.
> > >=20
> > > My first approach was to define a new critical-data record,=C2=A0
>=20
> Hi Mimi,
>=20
> > Hopefully the new critical-data will be of the entire IMA policy.
>=20
> yes, absolutely.
>=20
> > > but performing the
> > > measurement after the custom policy becomes effective, the measuremen=
t could
> > > be
> > > bypassed omitting func=3DCRITICAL_DATA in the custom policy.
> > >=20
> > > > I'm not quite sure why you're differentiating between
> > > > measuring the initial and subsequent custom IMA policy rules.=C2=A0=
=C2=A0
> > >=20
> > > My intention is to measure the first direct write (line by line) on t=
he
> > > policy
> > > file, without loading the initial custom policy from a file. This cas=
e, if
> > > I'm
> > > not wrong, is not covered by func=3DPOLICY_CHECK.
> >=20
> > When secure boot is enabled, the arch specific policy rules require the=
 IMA
> > policy to be signed.=C2=A0 Without secure boot enabled, you're correct.=
 The custom
> > policy rules may directly be loaded without being measured.
> >=20
> > Why only measure "the first direct write"?=C2=A0 Additional custom poli=
cy rules may
> > be directly appended without being measured.
>=20
> Yes, you right. The aim was to measure (at least) the first one, because =
it
> substitutes the boot policy, but if you are ok with adding a critical-dat=
a
> record, it would be definitely better.

Hi Enrico

in addition to what Mimi suggested, I also like to idea that the
POLICY_CHECK hook catches the direct policy loading. That would mean
that those updates would be seen if the 'tcb' IMA policy is selected.

I would have recommended to try to add a process_measurement() call in
ima_write_policy(), where the buffer to be processed is.

However, I guess you need to have a valid file descriptor in order to
use that function (maybe an anonymous inode?).
ima_collect_measurement() should be already able to handle buffers,
passed by ima_post_read_file().

Thanks

Roberto

> Thank you,
>=20
> Enrico
>=20
> > >=20
> > > > Consider defining a new critical-data record to measure the current=
 IMA
> > > > policy
> > > > rules.=C2=A0 Also consider including the new critical-data rule in =
the arch
> > > > specific policy rules.
> > >=20
> > > I think that your suggestion, to add the critical-data rule in the ar=
ch
> > > policy
> > > rules, solves the problems of bypassing the measurement and hard codi=
ng
> > > policy.
> > >=20
> > > Thank you very much for your feedback.
> >=20
> > You're welcome.
> >=20
> > Mimi
> > >=20
>=20


