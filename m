Return-Path: <linux-integrity+bounces-5105-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5B9A4F965
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 10:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777343A4B18
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 09:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F321FFC73;
	Wed,  5 Mar 2025 09:00:23 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091EE1CD21C
	for <linux-integrity@vger.kernel.org>; Wed,  5 Mar 2025 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741165223; cv=none; b=hGnOY4yYZEmQJYNiOndBTCu/wIelT3jNoANhsg1w2oEUoG2NcYfwPix4k2v4F+JxPc8mOupxL4znemCI2igZyCU7mO8xpq05oLvK9ljaW53i/L/VM1u+xz/fZHenYFMZJxb7AdW+1nUg2H1dhrfpNpFwj3vHA3t58SuzWPr4qDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741165223; c=relaxed/simple;
	bh=9BPeHix2FQ3vx6e+e2oaPyse8S9XaUMVAdSCOXP4Sig=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iowVaqxqZcam2QXnWzChho7hMTUuHaontRfc0ECXlteoRicrFcQd518vlJRx3co7PhKiBbmO1lptx5ycljVWnxpg5NgMsr729D99OjpGt2BicgiyVJDMaOasuaFqRtl4wny03iOeRecxdHtWbya2AjMJKVWR0+aeujf00ui1RSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z75Wg6bsyz9v7VD
	for <linux-integrity@vger.kernel.org>; Wed,  5 Mar 2025 16:37:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id CB78C140203
	for <linux-integrity@vger.kernel.org>; Wed,  5 Mar 2025 17:00:09 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDXP+KTEshnbmWaAw--.23167S2;
	Wed, 05 Mar 2025 10:00:09 +0100 (CET)
Message-ID: <4679907583cfe4d406d43f8e46bada6e9a23c096.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH] ima: add measurement for first unverified write on
 ima policy file
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Enrico Bravi <enrico.bravi@polito.it>, "roberto.sassu@huawei.com"
 <roberto.sassu@huawei.com>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "zohar@linux.ibm.com"
 <zohar@linux.ibm.com>,  "dmitry.kasatkin@gmail.com"
 <dmitry.kasatkin@gmail.com>
Cc: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Date: Wed, 05 Mar 2025 09:59:59 +0100
In-Reply-To: <091e810e9225014ab61fedd868f7fff70e864da4.camel@polito.it>
References: <20250225131255.154826-1-enrico.bravi@polito.it>
	 <ecc4630b5e3161736aa1e32f037facb9123025fc.camel@linux.ibm.com>
	 <013864bca0b53d65b9546125090c8d7776ee565a.camel@polito.it>
	 <9fb7a98bb88c05d953fd90c84c78af0bbd58df9b.camel@linux.ibm.com>
	 <484b1563482aca871a147daeff916fcb0730c6d6.camel@polito.it>
	 <2a6924b36ab41fd5d9666de726b9f4a0754b9cbb.camel@huaweicloud.com>
	 <091e810e9225014ab61fedd868f7fff70e864da4.camel@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwDXP+KTEshnbmWaAw--.23167S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1kCF4rtr1DJr4xuw1fCrg_yoWxAF47pF
	W3Ka4vkr4DXryxAw1xK3WrXr4Fvry8Jw45XryUJryUC3Z0ywnYkw45Jr1YgFs2yr18Jr1j
	qr1YyrW7XF1DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBGfH99oBOQAAsi

On Mon, 2025-03-03 at 10:26 +0000, Enrico  Bravi wrote:
> On Thu, 2025-02-27 at 15:49 +0100, Roberto Sassu wrote:
> > On Thu, 2025-02-27 at 11:36 +0000, Enrico=C2=A0 Bravi wrote:
> > > On Wed, 2025-02-26 at 22:05 -0500, Mimi Zohar wrote:
> > > > On Wed, 2025-02-26 at 22:53 +0000, Enrico=C2=A0 Bravi wrote:
> > > > > On Tue, 2025-02-25 at 20:53 -0500, Mimi Zohar wrote:
> > > > > > On Tue, 2025-02-25 at 14:12 +0100, Enrico Bravi wrote:
> > > > > > > The first write on the ima policy file permits to override th=
e
> > > > > > > default
> > > > > > > policy defined with the ima_policy=3D boot parameter. This ca=
n be done
> > > > > > > by adding the /etc/ima/ima-policy which allows loading the cu=
stom
> > > > > > > policy
> > > > > > > during boot. It is also possible to load custom policy at run=
time
> > > > > > > through
> > > > > > > file operations:
> > > > > > >=20
> > > > > > > cp custom_ima_policy /sys/kernel/security/ima/policy
> > > > > > > cat custom_ima_policy > /sys/kernel/security/ima/policy
> > > > > > >=20
> > > > > > > or by writing the absolute path of the file containing the cu=
stom
> > > > > > > policy:
> > > > > > >=20
> > > > > > > echo /path/of/custom_ima_policy > /sys/kernel/security/ima/po=
licy
> > > > > > >=20
> > > > > > > In these cases, file signature can be necessary to load the p=
olicy
> > > > > > > (func=3DPOLICY_CHECK). Custom policy can also be set at runti=
me by
> > > > > > > directly
> > > > > > > writing the policy stream on the ima policy file:
> > > > > > >=20
> > > > > > > echo -e "measure func=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"audit func=
=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 > /sys/kernel/security/ima/policy
> > > > > > >=20
> > > > > > > In this case, there is no mechanism to verify the integrity o=
f the
> > > > > > > new
> > > > > > > policy.
> > > > > > >=20
> > > > > > > Add a new entry in the ima measurements list containing the a=
scii
> > > > > > > custom
> > > > > > > ima policy buffer when not verified at load time.
> > > > > > >=20
> > > > > > > Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
> > > > > >=20
> > > > > > Hi Enrico,
> > > > >=20
> > > > > Hi Mimi,
> > > > >=20
> > > > > thank you for the quick response.
> > > > >=20
> > > > > > This patch set hard codes measuring the initial custom IMA poli=
cy
> > > > > > rules
> > > > > > that
> > > > > > replace the builtin policies specified on the boot command line=
.=C2=A0 IMA
> > > > > > shouldn't hard code policy.
> > > > >=20
> > > > > My first approach was to define a new critical-data record,=C2=A0
> > >=20
> > > Hi Mimi,
> > >=20
> > > > Hopefully the new critical-data will be of the entire IMA policy.
> > >=20
> > > yes, absolutely.
> > >=20
> > > > > but performing the
> > > > > measurement after the custom policy becomes effective, the measur=
ement
> > > > > could
> > > > > be
> > > > > bypassed omitting func=3DCRITICAL_DATA in the custom policy.
> > > > >=20
> > > > > > I'm not quite sure why you're differentiating between
> > > > > > measuring the initial and subsequent custom IMA policy rules.=
=C2=A0=C2=A0
> > > > >=20
> > > > > My intention is to measure the first direct write (line by line) =
on the
> > > > > policy
> > > > > file, without loading the initial custom policy from a file. This=
 case,
> > > > > if
> > > > > I'm
> > > > > not wrong, is not covered by func=3DPOLICY_CHECK.
> > > >=20
> > > > When secure boot is enabled, the arch specific policy rules require=
 the
> > > > IMA
> > > > policy to be signed.=C2=A0 Without secure boot enabled, you're corr=
ect. The
> > > > custom
> > > > policy rules may directly be loaded without being measured.
> > > >=20
> > > > Why only measure "the first direct write"?=C2=A0 Additional custom =
policy rules
> > > > may
> > > > be directly appended without being measured.
> > >=20
> > > Yes, you right. The aim was to measure (at least) the first one, beca=
use it
> > > substitutes the boot policy, but if you are ok with adding a critical=
-data
> > > record, it would be definitely better.
> >=20
> > Hi Enrico
> >=20
> > in addition to what Mimi suggested, I also like to idea that the
> > POLICY_CHECK hook catches the direct policy loading. That would mean
> > that those updates would be seen if the 'tcb' IMA policy is selected.
>=20
> Hi Roberto,
>=20
> in this case, wouldn't be used the current template? Wouldn't be better t=
o use
> the ima-buf in order to include the textual policy representation?

Hi Enrico

I would use the current template, I don't find any particular issues
for it. Sure, we don't have a file to measure but there are other cases
where in process_measurement() we measure a buffer instead of a file
(when it is called by ima_post_read_file()).

We can have both critical data and POLICY_CHECK measurement.

> In addition, there would be a new record for each line of the input buffe=
r, and
> measuring the input buffer would produce different measurements for the s=
ame
> resulting policy entry, because different or multiple separators can be u=
sed.
>=20
> I opted to perform the measurement in ima_release_policy() because is whe=
re the
> new policy becomes effective after ima_update_policy() and can be done a =
single
> measurement of the new running policy.

I would simply measure what is passed to ima_write_policy() regardless
of whether the policy will be accepted or not. This is more in line
with the trusted computing paradigm of measure & load. If potentially
there is a bug in the policy code, measuring the policy before with a
vulnerable kernel would allow you to see the measurement. After, it
depends on the seriousness of the vulnerability.

Roberto

> The measurement could be done a bit earlier, working on ima_policy_rules =
and
> ima_temp_rules (which basically contains the input buffer) before the spl=
icing,
> so it would be considered the current policy and not the new one. In this=
 case,
> it would work also when ima_policy=3Dtcb is set, and it could be called
> process_buffer_measurement() with POLICY_CHECK, to get a record with the =
entire
> IMA policy.
> What do you think about it?
>=20
> BR,
>=20
> Enrico
>=20
> > I would have recommended to try to add a process_measurement() call in
> > ima_write_policy(), where the buffer to be processed is.
> >=20
> > However, I guess you need to have a valid file descriptor in order to
> > use that function (maybe an anonymous inode?).
> > ima_collect_measurement() should be already able to handle buffers,
> > passed by ima_post_read_file().
> >=20
> > Thanks
> >=20
> > Roberto
> >=20
> > > Thank you,
> > >=20
> > > Enrico
> > >=20
> > > > >=20
> > > > > > Consider defining a new critical-data record to measure the cur=
rent
> > > > > > IMA
> > > > > > policy
> > > > > > rules.=C2=A0 Also consider including the new critical-data rule=
 in the arch
> > > > > > specific policy rules.
> > > > >=20
> > > > > I think that your suggestion, to add the critical-data rule in th=
e arch
> > > > > policy
> > > > > rules, solves the problems of bypassing the measurement and hard =
coding
> > > > > policy.
> > > > >=20
> > > > > Thank you very much for your feedback.
> > > >=20
> > > > You're welcome.
> > > >=20
> > > > Mimi
> > > > >=20
> > >=20
> >=20
>=20


