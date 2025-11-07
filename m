Return-Path: <linux-integrity+bounces-7605-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC42C3FDD3
	for <lists+linux-integrity@lfdr.de>; Fri, 07 Nov 2025 13:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595C63B4F73
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Nov 2025 12:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6843271F5;
	Fri,  7 Nov 2025 12:13:57 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F81A28C5AA;
	Fri,  7 Nov 2025 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762517637; cv=none; b=Du3DWbRX0tkITRQ6yKsw5ank64dCilXbaqKQFMsxVl6z8OH1cfE1zzhleujutEL4pGBay5TuqIEqbaAl5+B6CjjkJ16fqsAySkdNpbeBVczZTJCZpxq5qpPStcAlUe9TZZn/k79BFPMEkCH0rEUMogbk2pW5oChYTKMPTSCprqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762517637; c=relaxed/simple;
	bh=5ZjVwpww/EY5br3PGL108fifenvPQfsey3Rhb2cSp7E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KCldKmAhnaApQN2aFQ094EGKc5PgHEh0dGNONMj1izjQxURSwSCI7BO6eGOD5dYj36SzfFXl1rezNAgBiV5PgzozDa9M2b5VKmkBDuQ1TshSmxyFWiH42F1IiG/hwhHMClKEymneN9I5W4vNkAAOk7m1G5J8x92VUSKi9t/ghOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d2yDb0ffbz1HBKN;
	Fri,  7 Nov 2025 19:55:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 77416140276;
	Fri,  7 Nov 2025 19:56:23 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwA39h1d3g1pGVOpAQ--.55115S2;
	Fri, 07 Nov 2025 12:56:22 +0100 (CET)
Message-ID: <17e3438f72fd684c0db5c895f824d5e10445ec3c.camel@huaweicloud.com>
Subject: Re: [Patch V1] ima: avoid duplicate policy rules insertions
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Tahera Fahimi <taherafahimi@linux.microsoft.com>, zohar@linux.ibm.com, 
 roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com,  linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org,
 code@tyhicks.com
Date: Fri, 07 Nov 2025 12:56:10 +0100
In-Reply-To: <aQ3QV03_PtB4qg32@gardel-login>
References: <20251106181404.3429710-1-taherafahimi@linux.microsoft.com>
	 <1cc67c25a141aef8982840898a6e7397cbdf10d9.camel@huaweicloud.com>
	 <aQ3QV03_PtB4qg32@gardel-login>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwA39h1d3g1pGVOpAQ--.55115S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyxKF1DGr47XryUGF45Wrg_yoW5Wr4rpF
	W3Ka4qka1kXr1SyrsF93WxX3WFkrZYv345GrZ0k348Aa45G3ZrGw1ftFy5u343Arnakw1j
	vFWFqayUZas8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBGkNTvkEvAACsp

On Fri, 2025-11-07 at 11:56 +0100, Lennart Poettering wrote:
> On Fr, 07.11.25 10:44, Roberto Sassu (roberto.sassu@huaweicloud.com) wrot=
e:
>=20
> > On Thu, 2025-11-06 at 18:14 +0000, Tahera Fahimi wrote:
> > > Prevent redundant IMA policy rules by checking for duplicates before =
insertion. This ensures that
> > > rules are not re-added when userspace is restarted (using systemd-sof=
t-reboot) without a full system
> > > reboot. ima_rule_exists() detects duplicates in both temporary and ac=
tive rule lists.
> >=20
> > + Lennart
> >=20
> > Hi Tahera
> >=20
> > thanks for the patch!
> >=20
> > Wouldn't be better to enhance systemd-soft-reboot to not send the same
> > IMA policy again?
>=20
> the soft-reboot logic doesn't load the IMA policy. It's just that
> soft-reboot means we reexec PID1: the old pid1 gets replaced by the
> new one. And that new PID1 then initializes as it usually would, and
> loads security policies again. It currently has support for selinux
> policies, ima, ipe, smack.
>=20
> These policies are supposed to *replace* whatever was loaded
> before. Looking at our IMA logic, this doesn't happen right now
> though, it just adds stuff:

From a functional perspective. As far as integrity is concerned, you
would probably agree that just replacing PID 1 does not mean resetting
the integrity of the system to a known state (all the other processes
are still running). Due to that, I think the concept of soft-reset
should not be applied to the kernel.

> https://github.com/systemd/systemd/blob/main/src/core/ima-setup.c
>=20
> Is there a way to replace the old IMA policy with the new, with the
> current IMA userspace interface? If so, we should probably make use of

No, only the IMA boot policies specified in the kernel command line can
be reset (only once, and not completely, secure boot rules still
persist despite user space loads a new policy). New rules are append-
only.

> that in systemd, and replace the policy that way. Or in other words:
> under the assumption that one can flush out the old IMA policy and
> replace it with a new one, I think this should be fixed in systemd,
> not the kernel. (of there's no api for flushing out the old
> policy/replacing it with the new, then of course we need something
> like that in the kernel first).

Assuming that technically it is feasible to flush the old IMA policy
(except for the permanent secure boot rules). What it would be the
additional value of changing the policy on the fly on the same system
as before, but with a different PID 1?

Regarding the duplicate IMA policy load, I guess you could probably
store the digest of the currently loaded policy in the systemd state
and not doing it again after soft-reboot, if the digest matches.

Roberto

> My understanding of IMA is kinda limited though. I just know what we
> do in our codebase.
>=20
> Lennart


