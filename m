Return-Path: <linux-integrity+bounces-5132-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC01A54545
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 09:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949B016E392
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 08:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B036A2080E0;
	Thu,  6 Mar 2025 08:47:49 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E716719C54C
	for <linux-integrity@vger.kernel.org>; Thu,  6 Mar 2025 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250869; cv=none; b=WHTw4yhTu4NgNcjwAxws2yO51ENWRenOdbrugz7Ftpqd1cwwAubFd6DkD/ONOhzNwhxlMNEYXx4h+3uIIO5bkoOe6SAct4g5Jv+sl+Iaprclz3hmN1XF5LbxmUOAFLoK+4ExVKHp2Uf+aveO7kK5mjRLCkiqx6ltxZwat+7YmqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250869; c=relaxed/simple;
	bh=0ViUWIvd+csvzg4HXih9wEPRslj9jOlXn7MzgkcZnjA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JdAGGLtw0RAKYIa7fRItqqFkC0oNRpPCdXIMCov3IONK7YbkX3ks6hqnBwyNXD4Wf1Rq4Cb51dQpui1VGouv+MfRsnjNVRFlDYHMcIImEGZuR8upQ+YnpmZ/dOwFlVajKsXA4GGnxcmwWySykah6AfGBZ/x3YeXFJTFJg8LEjIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4Z7jj52D4JzpTZj
	for <linux-integrity@vger.kernel.org>; Thu,  6 Mar 2025 16:47:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 8EF971400D8
	for <linux-integrity@vger.kernel.org>; Thu,  6 Mar 2025 16:47:39 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCHC0okYclng86uAw--.14009S2;
	Thu, 06 Mar 2025 09:47:39 +0100 (CET)
Message-ID: <a4081237104bc5fdb7e8e316f8ea281b3ed1617d.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH] ima: add measurement for first unverified write on
 ima policy file
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Enrico Bravi <enrico.bravi@polito.it>, "roberto.sassu@huawei.com"
 <roberto.sassu@huawei.com>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "zohar@linux.ibm.com"
 <zohar@linux.ibm.com>,  "dmitry.kasatkin@gmail.com"
 <dmitry.kasatkin@gmail.com>
Cc: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Date: Thu, 06 Mar 2025 09:47:29 +0100
In-Reply-To: <f0eb80a5e6e436721e22448de625951d60010013.camel@polito.it>
References: <20250225131255.154826-1-enrico.bravi@polito.it>
	 <ecc4630b5e3161736aa1e32f037facb9123025fc.camel@linux.ibm.com>
	 <013864bca0b53d65b9546125090c8d7776ee565a.camel@polito.it>
	 <9fb7a98bb88c05d953fd90c84c78af0bbd58df9b.camel@linux.ibm.com>
	 <484b1563482aca871a147daeff916fcb0730c6d6.camel@polito.it>
	 <2a6924b36ab41fd5d9666de726b9f4a0754b9cbb.camel@huaweicloud.com>
	 <091e810e9225014ab61fedd868f7fff70e864da4.camel@polito.it>
	 <4679907583cfe4d406d43f8e46bada6e9a23c096.camel@huaweicloud.com>
	 <f0eb80a5e6e436721e22448de625951d60010013.camel@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCHC0okYclng86uAw--.14009S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFykXF4fJF43WFyfAw4xZwb_yoW3Ar15pF
	W5ta4jkr4DXry8Ar17K3WrXr1FvryUJw45XryUJr1UAwn0yr18Kr45Jr1Y9Fn7Jr18Jw1j
	qr15trW7XF1UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBGfH99oLJwAIs-

On Thu, 2025-03-06 at 08:20 +0000, Enrico  Bravi wrote:
> On Wed, 2025-03-05 at 09:59 +0100, Roberto Sassu wrote:
> > On Mon, 2025-03-03 at 10:26 +0000, Enrico=C2=A0 Bravi wrote:
> > > On Thu, 2025-02-27 at 15:49 +0100, Roberto Sassu wrote:
> > > > On Thu, 2025-02-27 at 11:36 +0000, Enrico=C2=A0 Bravi wrote:
> > > > > On Wed, 2025-02-26 at 22:05 -0500, Mimi Zohar wrote:
> > > > > > On Wed, 2025-02-26 at 22:53 +0000, Enrico=C2=A0 Bravi wrote:
> > > > > > > On Tue, 2025-02-25 at 20:53 -0500, Mimi Zohar wrote:
> > > > > > > > On Tue, 2025-02-25 at 14:12 +0100, Enrico Bravi wrote:
> > > > > > > > > The first write on the ima policy file permits to overrid=
e the
> > > > > > > > > default
> > > > > > > > > policy defined with the ima_policy=3D boot parameter. Thi=
s can be
> > > > > > > > > done
> > > > > > > > > by adding the /etc/ima/ima-policy which allows loading th=
e
> > > > > > > > > custom
> > > > > > > > > policy
> > > > > > > > > during boot. It is also possible to load custom policy at
> > > > > > > > > runtime
> > > > > > > > > through
> > > > > > > > > file operations:
> > > > > > > > >=20
> > > > > > > > > cp custom_ima_policy /sys/kernel/security/ima/policy
> > > > > > > > > cat custom_ima_policy > /sys/kernel/security/ima/policy
> > > > > > > > >=20
> > > > > > > > > or by writing the absolute path of the file containing th=
e
> > > > > > > > > custom
> > > > > > > > > policy:
> > > > > > > > >=20
> > > > > > > > > echo /path/of/custom_ima_policy >
> > > > > > > > > /sys/kernel/security/ima/policy
> > > > > > > > >=20
> > > > > > > > > In these cases, file signature can be necessary to load t=
he
> > > > > > > > > policy
> > > > > > > > > (func=3DPOLICY_CHECK). Custom policy can also be set at r=
untime by
> > > > > > > > > directly
> > > > > > > > > writing the policy stream on the ima policy file:
> > > > > > > > >=20
> > > > > > > > > echo -e "measure func=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"audit fu=
nc=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 > /sys/kernel/security/ima/polic=
y
> > > > > > > > >=20
> > > > > > > > > In this case, there is no mechanism to verify the integri=
ty of
> > > > > > > > > the
> > > > > > > > > new
> > > > > > > > > policy.
> > > > > > > > >=20
> > > > > > > > > Add a new entry in the ima measurements list containing t=
he
> > > > > > > > > ascii
> > > > > > > > > custom
> > > > > > > > > ima policy buffer when not verified at load time.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
> > > > > > > >=20
> > > > > > > > Hi Enrico,
> > > > > > >=20
> > > > > > > Hi Mimi,
> > > > > > >=20
> > > > > > > thank you for the quick response.
> > > > > > >=20
> > > > > > > > This patch set hard codes measuring the initial custom IMA =
policy
> > > > > > > > rules
> > > > > > > > that
> > > > > > > > replace the builtin policies specified on the boot command =
line.=C2=A0
> > > > > > > > IMA
> > > > > > > > shouldn't hard code policy.
> > > > > > >=20
> > > > > > > My first approach was to define a new critical-data record,=
=C2=A0
> > > > >=20
> > > > > Hi Mimi,
> > > > >=20
> > > > > > Hopefully the new critical-data will be of the entire IMA polic=
y.
> > > > >=20
> > > > > yes, absolutely.
> > > > >=20
> > > > > > > but performing the
> > > > > > > measurement after the custom policy becomes effective, the
> > > > > > > measurement
> > > > > > > could
> > > > > > > be
> > > > > > > bypassed omitting func=3DCRITICAL_DATA in the custom policy.
> > > > > > >=20
> > > > > > > > I'm not quite sure why you're differentiating between
> > > > > > > > measuring the initial and subsequent custom IMA policy rule=
s.=C2=A0=C2=A0
> > > > > > >=20
> > > > > > > My intention is to measure the first direct write (line by li=
ne) on
> > > > > > > the
> > > > > > > policy
> > > > > > > file, without loading the initial custom policy from a file. =
This
> > > > > > > case,
> > > > > > > if
> > > > > > > I'm
> > > > > > > not wrong, is not covered by func=3DPOLICY_CHECK.
> > > > > >=20
> > > > > > When secure boot is enabled, the arch specific policy rules req=
uire
> > > > > > the
> > > > > > IMA
> > > > > > policy to be signed.=C2=A0 Without secure boot enabled, you're =
correct. The
> > > > > > custom
> > > > > > policy rules may directly be loaded without being measured.
> > > > > >=20
> > > > > > Why only measure "the first direct write"?=C2=A0 Additional cus=
tom policy
> > > > > > rules
> > > > > > may
> > > > > > be directly appended without being measured.
> > > > >=20
> > > > > Yes, you right. The aim was to measure (at least) the first one, =
because
> > > > > it
> > > > > substitutes the boot policy, but if you are ok with adding a crit=
ical-
> > > > > data
> > > > > record, it would be definitely better.
> > > >=20
> > > > Hi Enrico
> > > >=20
> > > > in addition to what Mimi suggested, I also like to idea that the
> > > > POLICY_CHECK hook catches the direct policy loading. That would mea=
n
> > > > that those updates would be seen if the 'tcb' IMA policy is selecte=
d.
> > >=20
> > > Hi Roberto,
> > >=20
> > > in this case, wouldn't be used the current template? Wouldn't be bett=
er to
> > > use
> > > the ima-buf in order to include the textual policy representation?
> >=20
> > Hi Enrico
> >=20
> > I would use the current template, I don't find any particular issues
> > for it. Sure, we don't have a file to measure but there are other cases
> > where in process_measurement() we measure a buffer instead of a file
> > (when it is called by ima_post_read_file()).
> >=20
> > We can have both critical data and POLICY_CHECK measurement.

CRITICAL_DATA and POLICY_CHECK are separate hooks.

They can do measurement differently, CRITICAL_DATA can be for measuring
the current state of the full policy, while POLICY_CHECK could be for
policies sent to the kernel.


> Hi Roberto,
>=20
> sorry, I didn't get this point. What do you mean?
>=20
> > > In addition, there would be a new record for each line of the input b=
uffer,
> > > and
> > > measuring the input buffer would produce different measurements for t=
he same
> > > resulting policy entry, because different or multiple separators can =
be
> > > used.
> > >=20
> > > I opted to perform the measurement in ima_release_policy() because is=
 where
> > > the
> > > new policy becomes effective after ima_update_policy() and can be don=
e a
> > > single
> > > measurement of the new running policy.
> >=20
> > I would simply measure what is passed to ima_write_policy() regardless
> > of whether the policy will be accepted or not. This is more in line
> > with the trusted computing paradigm of measure & load. If potentially
> > there is a bug in the policy code, measuring the policy before with a
> > vulnerable kernel would allow you to see the measurement. After, it
> > depends on the seriousness of the vulnerability.
>=20
> Ok perfect, I get your point. Thank you for the explanation.

Welcome.

Roberto

> Enrico
>=20
> > Roberto
> >=20
> > > The measurement could be done a bit earlier, working on ima_policy_ru=
les and
> > > ima_temp_rules (which basically contains the input buffer) before the
> > > splicing,
> > > so it would be considered the current policy and not the new one. In =
this
> > > case,
> > > it would work also when ima_policy=3Dtcb is set, and it could be call=
ed
> > > process_buffer_measurement() with POLICY_CHECK, to get a record with =
the
> > > entire
> > > IMA policy.
> > > What do you think about it?
> > >=20
> > > BR,
> > >=20
> > > Enrico
> > >=20
> > > > I would have recommended to try to add a process_measurement() call=
 in
> > > > ima_write_policy(), where the buffer to be processed is.
> > > >=20
> > > > However, I guess you need to have a valid file descriptor in order =
to
> > > > use that function (maybe an anonymous inode?).
> > > > ima_collect_measurement() should be already able to handle buffers,
> > > > passed by ima_post_read_file().
> > > >=20
> > > > Thanks
> > > >=20
> > > > Roberto
> > > >=20
> > > > > Thank you,
> > > > >=20
> > > > > Enrico
> > > > >=20
> > > > > > >=20
> > > > > > > > Consider defining a new critical-data record to measure the
> > > > > > > > current
> > > > > > > > IMA
> > > > > > > > policy
> > > > > > > > rules.=C2=A0 Also consider including the new critical-data =
rule in the
> > > > > > > > arch
> > > > > > > > specific policy rules.
> > > > > > >=20
> > > > > > > I think that your suggestion, to add the critical-data rule i=
n the
> > > > > > > arch
> > > > > > > policy
> > > > > > > rules, solves the problems of bypassing the measurement and h=
ard
> > > > > > > coding
> > > > > > > policy.
> > > > > > >=20
> > > > > > > Thank you very much for your feedback.
> > > > > >=20
> > > > > > You're welcome.
> > > > > >=20
> > > > > > Mimi
> > > > > > >=20
> > > > >=20
> > > >=20
> > >=20
> >=20
>=20


