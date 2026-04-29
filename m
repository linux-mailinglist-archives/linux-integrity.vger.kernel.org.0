Return-Path: <linux-integrity+bounces-9358-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIxBHU4K8mlXnAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9358-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 15:40:30 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 91778494FE4
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 15:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06C853009805
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 13:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5A13FE35A;
	Wed, 29 Apr 2026 13:33:58 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2793FD129;
	Wed, 29 Apr 2026 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469638; cv=none; b=nilPBgJGU5bwftit51zkQJgdZP77/f8EL7sQbUWWzj/G/8B0yOfGmdiswhpOgNjNd8XzMh6Aqp3sicLtHMne3XD3B+mOBf/LMRhRBdibaBQ4GF18bvzUc5uBVvyLMDSWQt/9R99s0vNsyYJ5AM9qXNQ+fRmxH/4R7Qh3v524/Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469638; c=relaxed/simple;
	bh=RtVxhdA8HcPFpzc6VqaKYSDDTN/K2BuRD6IhM1UOsDk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gKNdKmfpd1N7QlQ7qkzzxomNadsyWwRf6dJSGQwNe2qpz89ZPomthl8wCXCjUnBmQ8+GjDavhs7uuDi3L9UUpJrmUciCT5uMTk5/Q9rG+KVNPLYYXbTy8hqR9e7I5/k/HwgW8GD70XmuAKukC3f1qEUJhjZZaOiIfDZjbRvDjkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4g5J7D2jypzwPDw;
	Wed, 29 Apr 2026 21:29:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 1F2864056A;
	Wed, 29 Apr 2026 21:33:44 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwD3qKKpCPJpsYU_AA--.18035S2;
	Wed, 29 Apr 2026 14:33:43 +0100 (CET)
Message-ID: <e325b7a8041b7122e8415de9193f4fe1be04bb02.camel@huaweicloud.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, roberto.sassu@huawei.com, Jonathan
 McDowell <noodles@earth.li>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-integrity@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  kvmarm@lists.linux.dev,
 jmorris@namei.org, serge@hallyn.com,  dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, jarkko@kernel.org,  jgg@ziepe.ca,
 sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org, 
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
 catalin.marinas@arm.com, will@kernel.org, noodles@meta.com, 
 sebastianene@google.com
Date: Wed, 29 Apr 2026 15:33:27 +0200
In-Reply-To: <CAHC9VhS_WgwhW_NDO91LoTeSzdieGqbwqnwPq8KpavH1_Lwi7g@mail.gmail.com>
References: <aeoAlVEwzRUPrlVe@e129823.arm.com>
	 <aeoRxWPyOHGJd+Jh@e129823.arm.com> <aeoWO2Cwo04YYu2l@earth.li>
	 <bd908e28298d968740d03c97bc7e441de188b7b4.camel@linux.ibm.com>
	 <aeokwrC86WI7uT+K@e129823.arm.com> <aeomlp3I0eVE5mce@earth.li>
	 <aeotq8nPVu4wvEx5@e129823.arm.com>
	 <e4e242ae5533d5762a3647186a178764881bf9ff.camel@linux.ibm.com>
	 <aephL3MzYoqFGaT5@e129823.arm.com>
	 <CAHC9VhRQWHEWQ5NzOPiu8jtYv6UsRm8WVS4fd74AbkOcAd4y_g@mail.gmail.com>
	 <aesGU8a3mbVzvteH@e129823.arm.com>
	 <CAHC9VhSaT_quKYnpFjAfqvL07JNbWMgM6c4pB9F46NHawX3DCA@mail.gmail.com>
	 <014cf39aa8d6a0bcfa1a95c069675977ac67b843.camel@linux.ibm.com>
	 <CAHC9VhTW3=RJ8L91RWXYYA9tFjfSXGN-DMEEwdiD6big9H57Ew@mail.gmail.com>
	 <1f78fc75b2e95239973612a4b6c4cc782960b7ac.camel@linux.ibm.com>
	 <CAHC9VhS4JmPmCJrYTdbjxb3TO-uK6cB3Zij-ef=wswGce2BGzg@mail.gmail.com>
	 <1e51c2fd090e5ceb07b1d09e50650c70fd3ccdb1.camel@linux.ibm.com>
	 <CAHC9VhS_WgwhW_NDO91LoTeSzdieGqbwqnwPq8KpavH1_Lwi7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwD3qKKpCPJpsYU_AA--.18035S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4DZF17Ww1xtFyxJry3CFg_yoW8WrWkpF
	W2q34FkaykJFWrAwn7Jw4xXw10qr93Wry7Jrn0gFyUAws09r1qgrs3K3yYkFy8urs3WayY
	qFWqq398u3ZxZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIF
	4iUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBGnx6jgC6QABs3
X-Rspamd-Queue-Id: 91778494FE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arm.com,huawei.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,gmail.com,oracle.com,kernel.org,ziepe.ca,meta.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9358-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.304];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[]

On Mon, 2026-04-27 at 21:31 -0400, Paul Moore wrote:
> On Fri, Apr 24, 2026 at 6:49=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> =
wrote:
> > On Fri, 2026-04-24 at 18:10 -0400, Paul Moore wrote:
> > > (I'm assuming you meant initcall and not syscall above, but if you're
> > > talking about something else, please let me know.)
> > >=20
> > > Saying that you aren't comfortable moving IMA initialization to
> > > late-sync is inconsistent with allowing IMA initialization to be
> > > deferred to late-sync.  Either it is okay to initialize IMA in
> > > late-sync or it isn't.  You must pick one.
> >=20
> > Yes, we're discussing late_initcall and late_initcall_sync.
> >=20
> > I prefer to look at it as being pragmatic. I'd rather err on the side o=
f caution
> > and not move the syscall to late_initcall_sync, than move it.
>=20
> If you were truly erring on the side of caution you wouldn't allow
> late-sync initialization without knowing if it was safe or not.
> Determine whether IMA initialization is safe at late-sync.  If it is
> safe, move the init to late-sync; if not, keep it at late and figure
> out another mechanism to sync with the TPM availability.  If needed,
> you could probably use the LSM notifier to enable the TPM driver to
> signal when it is up and running.

Yes, I agree with you, or transition or not.

However, all of this looks very fragile and easy to be broken. If we
want to be on the safe side, we can use any notification mechanism that
is suitable, but at the same time from IMA side we need to deny any
file access that would require a measurement until the TPM comes up.

If you accept this, I don't have any problem to move to late_sync.

Roberto


