Return-Path: <linux-integrity+bounces-4812-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEC7A341E2
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2025 15:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121373AB064
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2025 14:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CB0281359;
	Thu, 13 Feb 2025 14:24:10 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9188D281353
	for <linux-integrity@vger.kernel.org>; Thu, 13 Feb 2025 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456650; cv=none; b=q+d4oirD/UodNhzvmxSKp3mpur4Pna8dCedKGeG+bIedtLyaq971OwB6cG35NIyS0PQmmXcZhn2k9kRRj5uHp81ls0GFXA5Vrsv822ZdYi6tL1Z3DQvzQOM6ZdH+1osQ2gmKMNOAnHPNrPP/2dbkOMxBKP/UjMugaqB49ZqTKFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456650; c=relaxed/simple;
	bh=qzEAWYMDjfnshH5UqSBuxr2QKwmXoTdzmqaire+hHgM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UAlPwjrluZwZGXkMVhyre0VyuN4BpV8RMh3jMvkCOMhFdwqK9vTFcT3L5Rh4JqOZE9qV4fnfT2RrHhGra9P0nUKoVYKdZPcRINAgA9WOZXW9GB9BvXv6i380XnmBFAk0xOzhcUWNfEv6VNOf3a1tNc+iOP0+rtZFs5fNa5TsM9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4YtxFf5nc2z9v7J2
	for <linux-integrity@vger.kernel.org>; Thu, 13 Feb 2025 21:42:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id CAA03140109
	for <linux-integrity@vger.kernel.org>; Thu, 13 Feb 2025 22:05:22 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDHmkka_K1n2kNtAg--.2704S2;
	Thu, 13 Feb 2025 15:05:21 +0100 (CET)
Message-ID: <a35aa6f1578a2bf5084a6e4541eb2a567109aca5.camel@huaweicloud.com>
Subject: Re: [RFC] Issue of  historical file and script invocation when
 using IMA for runtime attestation
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: "Wang, Nicholas" <chenkai3@illinois.edu>, 
	"linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>
Date: Thu, 13 Feb 2025 15:05:11 +0100
In-Reply-To: <6165162.lOV4Wx5bFT@nicoripper>
References: <6165162.lOV4Wx5bFT@nicoripper>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDHmkka_K1n2kNtAg--.2704S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFyUJr13urWfAr4Uur1rWFg_yoW7WF1kpF
	WYg39xKF4kA3WxK3srAw17XFWSk393Jay5Wr1DG34UAan8uryv9rWxK3yYvFZ8CrnY93Wj
	vr1Y934qka4DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBGetmdcD2AADsL

On Thu, 2025-02-13 at 12:57 +0000, Wang, Nicholas wrote:
> Linux-integrity community,
>=20
> Hi, I'm Nicholas Wang from UIUC, and we are researching the potential=20
> challenges of a remote runtime attestation tool using IMA, Keylime, under=
 a=20
> simulated deployment environment. In the process, we conducted multiple=
=20
> experiments, and we encountered some issues that we realize may not be ab=
le to=20
> be solved entirely in userspace.

Hi Nicholas

thanks a lot for your questions. Will try to answer to the best of my
knowledge.

> To sum up the first issue, IMA may not reflect the whole picture of invoc=
ation=20
> or activation history. In particular, we are in question about "Once the=
=20
> earlier measurements are verified, there is no need to verify them again"=
=20
> according to IMA event log documentation. First off, Keylime uses directo=
ries=20
> or paths for matching and ignoring files in their policy file; in IMA pol=
icy,=20
> "dont_measure" filters out filesystems. We see two potential scenarios in=
 which=20
> malicious actors may silently bypass the attestation. We assume Keylime u=
ser=20
> does not use "dont_measure" filters in IMA policy and IMA indeed measured=
=20
> everything while Keylime attest the digests according to its own policy.=
=20

I think the basic principle of the dont_measure rules, is that the
files in the pseudo filesystems are kernel-controlled, meaning that
they don't have random content but they have to be formatted according
to what the kernel expects (needs to be verified if it is the case).
Sure, also tmpfs is skipped, but in this case the initial state is that
the volume is empty and it is the running system filling it. It is more
a problem of run-time integrity, rather than load-time.

> Keylime would filter and ignore certain files based on its own directorie=
s and=20
> file filtering, and such ignored files would only appear in IMA log once =
as long=20
> as the system is not rebooted. Now the issue arises: 1. if the file being=
 moved=20
> within the same filesystem, it will never re-appear in IMA logs even with=
=20
> further invocations, as IMA treated them the exact same file. This may al=
low an=20

Yes, we are not giving trusted path guarantees. In the past there was a
patch set from Dmitry Kasatkin about directory protection
(https://lwn.net/Articles/574221/), but the work didn't progress.

What matters from the IMA point of view is what the process reads, as
it has the potential of corrupting the process. From where data are
read, it is not relevant for the purpose of assessing whether or not
the process got access to malicious data.

> attack to persist throughout until a fresh reboot. 2. In case of a long-l=
ived=20
> system which has patched a vulnerable version of one software, the old,=
=20
> vulnerable version which has been in the IMA log before will not appear i=
n=20
> case of further activation before a reboot. Thus, we believe that the des=
ign=20
> which measures each file once may in some cases not reflect a comprehensi=
ve=20
> state of the machine to meet runtime attestation needs.

Yes, we still need to have a good rollback detection, for example by
adding a measurement of outdated binaries. We still need to come up
with a good solution.

> The other issue we run into is script invocation. We find this is tricky =
as we=20
> realize that scripts being too versatile and hard to enforce the attestat=
ion=20
> upon execution, and executing them directly (through shebang) versus pass=
ing=20
> it to interpreters/shell as arguments results in a drastically different=
=20
> attestation result as the latter only attests the interpreter binary itse=
lf.=20
> While a naive solution would be turning on attestation for file read oper=
ations=20
> in IMA policy or use SELinux file types to facilitate, however, we suspec=
t it=20
> would still be an unmanageable task with unbearable performance. As the n=
ature=20
> of the problem is essentially to distinguish code from data, the only=20
> reasonable solution we currently have thought is to have interpreters=20
> themselves to do the task, and indicate IMA what is code through API.=20
> Alternatively, the only probable way would be any attestation tool eventu=
ally=20
> had to have their own kernel modules and extended file types for IMA poli=
cy,=20
> and decide on what to be measured in separate components.

Michael Salakun upstreamed a patch set to let the interpreters query
the kernel (also IMA) on whether or not a script should be executed:

https://lore.kernel.org/linux-integrity/20241212174223.389435-1-mic@digikod=
.net/


Following on that, Mimi upstreamed a patch:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/s=
ecurity/integrity/ima/ima_main.c?h=3Dv6.14-rc2&id=3D95b3cdafd7cb74414070893=
445a9b731793f7b55

that makes IMA measure scripts even if they are passed as argument to
the interpreter.

All the interpreters need to be extended to make such kernel query, but
potentially scripts would be measured regardless of how they are
invoked.

Roberto

> We wonder whether there is or has been discussions around these questions=
. If=20
> so, we would like to learn more about any ongoing efforts or plan on chan=
ging=20
> the current situation, or if not, would like to hear the opinions from th=
e=20
> kernel community regarding the two issues.
>=20
> Best regards,
>=20
> --
> Nicholas Wang


