Return-Path: <linux-integrity+bounces-9524-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LXDIGbjAmpEyQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9524-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2026 10:23:02 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A6C51C9F0
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2026 10:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB1E2307F837
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2026 08:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215C147DD73;
	Tue, 12 May 2026 08:18:21 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3960D29BD82;
	Tue, 12 May 2026 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573901; cv=none; b=bONN+XCu30sMBHh+2jHRg927ic+AEKNfvzbn+Tm8+asSz9Vncm6N8/T2qJ0m1itdrcm2Ko2Oqw5Qq4hgw18+pdrvGN+vtMO/8mq46PRvsMMbvj3+VCbyhstQgyLkgqbHZ4LGhxJhwNjLIQI+sTykrigCgVtBDo+6go/AtJcSkFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573901; c=relaxed/simple;
	bh=Kk5Il7+9Z1Ur24aGWBRquaBy1XtTuRa0+pxsahwPl7I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ugBoj7Hb8vGynOH80oHl3oRYivjPoQjNb0pYyL1dgHiiFdmpceFzYZ3/+IA9qh4vrdo1gzWBuUDxKb9GdzgFKLfDABRhB81WD7UBHyZ6+Cub4AxW8Qv8eZsF0aNElLaepZjbKHFBsyI4XXnffLnSBEwEQ3/Lu+oshUvujmR5+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gF8VV30N7z1HCcQ;
	Tue, 12 May 2026 16:13:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id A101A40565;
	Tue, 12 May 2026 16:18:09 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAnjKU34gJqEyMEAQ--.40892S2;
	Tue, 12 May 2026 09:18:09 +0100 (CET)
Message-ID: <2302296a13b847960dbdbab3cf5518b275938838.camel@huaweicloud.com>
Subject: Re: [PATCH v5 00/13] ima: Introduce staging mechanism
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, steven chen
	 <chenste@linux.microsoft.com>, corbet@lwn.net, skhan@linuxfoundation.org, 
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	gregorylumen@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
Date: Tue, 12 May 2026 10:17:55 +0200
In-Reply-To: <aaed52cf-26e1-4c40-812d-3788024ce5b5@linux.microsoft.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
	 <99c30be6-8b0f-486a-890c-cf74c5930726@linux.microsoft.com>
	 <aaed52cf-26e1-4c40-812d-3788024ce5b5@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAnjKU34gJqEyMEAQ--.40892S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr1UAr18Aw48tw1DAF4DXFb_yoW7Zr17pa
	ykt3WjkrWkJ34xCrn7Jr18CryFkrWxJ3WDGrnxJa48AFs8Aryjvr4Yvw1Y9FnxJr48tr1U
	tr15t343Z3WqyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFk
	u4UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgALBGoBvDMJrgABsP
X-Rspamd-Queue-Id: D8A6C51C9F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9524-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[linux.microsoft.com,lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.934];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 2026-05-11 at 10:29 -0700, Lakshmi Ramasubramanian wrote:
> On 5/7/2026 9:47 AM, steven chen wrote:
> > >=20
> > > Usage
> > > =3D=3D=3D=3D=3D
> > >=20
> > > The IMA staging mechanism can be enabled from the kernel configuratio=
n
> > > with the CONFIG_IMA_STAGING option.
> > >=20
> > > If it is enabled, IMA duplicates the current measurements interfaces
> > > (both binary and ASCII), by adding the _staged file suffix. Both the
> > > original and the staging interfaces gain the write permission for the
> > > root user and group, but require the process to have CAP_SYS_ADMIN se=
t.
> > >=20
> > > The staging mechanism supports two flavors.
> > >=20
> > > Staging with prompt
> > > ~~~~~~~~~~~~~~~~~~~
> > >=20
> > > The current measurements list is moved to a temporary staging area, a=
nd
> > > staged measurements are deleted upon confirmation.
> > >=20
> > > This staging process is achieved with the following steps.
> > >=20
> > > =C2=A0=C2=A0 1.=C2=A0 echo A > <original interface>: the user request=
s IMA to stage the
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entire measurements list;
> > > =C2=A0=C2=A0 2.=C2=A0 cat <_staged interface>: the user reads the sta=
ged measurements;
> > > =C2=A0=C2=A0 3.=C2=A0 echo D > <_staged interface>: the user requests=
 IMA to delete
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 staged measurements.
> > >=20
> > > Staging and deleting
> > > ~~~~~~~~~~~~~~~~~~~~
> > >=20
> > > N measurements are staged to a temporary staging area, and immediatel=
y
> > > deleted without further confirmation.
> > >=20
> > > This staging process is achieved with the following steps.
> > >=20
> > > =C2=A0=C2=A0 1.=C2=A0 cat <original interface>: the user reads the cu=
rrent measurements
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list and determines what the val=
ue N for staging should be;
> > > =C2=A0=C2=A0 2.=C2=A0 echo N > <original interface>: the user request=
s IMA to delete N
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 measurements from the current me=
asurements list.
> >=20
> > This submission proposes two ways for log trimming:
> >=20
> > *Flavor 1:* Staging with prompt
> > *Flavor 2:* stage and delete N
> >=20
> > Functionally, both approaches address the same problem, but *Favour 2=
=20
> > *is the
> > stronger design and should be preferred. There is no good reason to kee=
p=20
> > *Flavor 1.*
> >=20
> >  From a kernel implementation perspective, *Flavor 2 *is more efficient=
=20
> > because it
> > minimizes the time spent holding the list lock (can=E2=80=99t be shorte=
r). It=20
> > also substantially
> > reduces the amount of kernel-side logic, removing nearly half of the=
=20
> > code required
> > by the alternative approach.
> >=20
> >  From a user-space perspective, *Flavor 2 *results in a much cleaner=
=20
> > model. It avoids
> > the need to track and reconcile both old and staged lists in user space=
=20
> > as well as
> > two lists (cur and staged) in the kernel space, which simplifies log=
=20
> > trimming logic
> > and reduces maintenance overhead. In addition, it preserves the existin=
g=20
> > external
> > behavior by not exposing any staged list to user space.
> >=20
> > Overall, *Flavor 2 *provides the same functional result with lower=20
> > kernel complexity,
> > shorter kernel list lock hold time, and a simpler user-space interface.=
=20
> > For those
> > reasons, it is the preferable approach and *Favour 1* does not appear t=
o=20
> > offer sufficient
> > justification to keep both implementations.
> >=20
> > Steven
>=20
> Roberto, Mimi:
>=20
> I want to add on to the point Steven has brought up.
>=20
> With "Stage and Delete N" approach, we have the following sequence of=20
> tasks for trimming the IMA log:
>=20
> 	1. User mode locks the IMA measurement list through the "write interface=
".
> 		a. While this prevents any other user mode process from updating the=
=20
> IMA log, kernel can still add new IMA events to the measurement log
> 	2. User mode reads the TPM Quote and the IMA measurement events and=20
> sends it to the remote attestation service
> 	3. Once the remote service has successfully processed the IMA events,=
=20
> the user mode determines the number of IMA events "N" to be removed from=
=20
> the measurement list maintained in the kernel
> 	4. User mode provides the value "N" to the kernel
> 	5. Kernel now determines the point at which to snap the IMA measurement=
=20
> list using "N" - without holding a lock
> 	6. Then, the kernel lock is held and the list is snapped at the point=
=20
> determined in the previous step thus keeping the kernel lock time to the=
=20
> minimum.
> 	7. Now, user mode removes the "write" lock on the IMA measurement list
>=20
> With the above, we believe "Stage and Delete N" alone is sufficient to=
=20
> trim IMA log.

Hi Lakshmi

I'm happy to support your trimming method. Just does not fit with my
use case. I would like to keep both.

Thanks

Roberto

>   -lakshmi
>=20
> > > =C2=A0 .../admin-guide/kernel-parameters.txt=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> > > =C2=A0 Documentation/security/IMA-staging.rst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 163 +++++++++
> > > =C2=A0 Documentation/security/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 2 +
> > > =C2=A0 security/integrity/ima/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 +
> > > =C2=A0 security/integrity/ima/ima.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 32 +-
> > > =C2=A0 security/integrity/ima/ima_api.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> > > =C2=A0 security/integrity/ima/ima_fs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 315 ++++++++++++++=
++--
> > > =C2=A0 security/integrity/ima/ima_init.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +
> > > =C2=A0 security/integrity/ima/ima_kexec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 53 ++-
> > > =C2=A0 security/integrity/ima/ima_queue.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 283 ++++++++++++++--
> > > =C2=A0 11 files changed, 803 insertions(+), 73 deletions(-)
> > > =C2=A0 create mode 100644 Documentation/security/IMA-staging.rst
> > >=20


