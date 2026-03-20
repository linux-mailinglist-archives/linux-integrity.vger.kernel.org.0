Return-Path: <linux-integrity+bounces-9020-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNMnN0aEvWnQ+gIAu9opvQ
	(envelope-from <linux-integrity+bounces-9020-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Mar 2026 18:30:46 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 109AC2DEA6F
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Mar 2026 18:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E60613024BE4
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Mar 2026 17:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2723C13F0;
	Fri, 20 Mar 2026 17:29:28 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3691D3D413A;
	Fri, 20 Mar 2026 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027768; cv=none; b=jFavgmi5t9PtUvlJQeOuLh6EOnQO8563hmCus6vgz6RqQmtt09BjdRRBmV4P2WQvsdTpXQNdQS67pbJSj7Lmj3m3QdTZL5fRyi3GYvE0rcNsGwKWl3r8tr9wpZMBglxvw2zDq1QajrLd7EI36RMqh0atbn7WnEG857R05/+avcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027768; c=relaxed/simple;
	bh=c49IGyyGDvIrFwfhXir8KcKksBvBrXcBqDsBoNvcKrI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=REVQYJHa0/9hIkQvnz0SMh0Tsvjp0JvAsgsAr3uo8+f0+vzM/BdT3wCD2kuoGHdwVwNVQyPXPYZE4KL4rU3xj0+dHXPhKYCGeMsQ9bS1hVqpu+U/pShzCpDCWw/vep/K1H1+3X/boRtiWQ/MnXcBUnUCFSIlr7jg5OZruSn1Dn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4fcprG0CqbzpV3H;
	Sat, 21 Mar 2026 01:06:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id CBC4340567;
	Sat, 21 Mar 2026 01:10:18 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwD3x4Rvf71pCrrQAA--.25877S2;
	Fri, 20 Mar 2026 18:10:18 +0100 (CET)
Message-ID: <332fc1447c03893988620189a40501cccaa8b4c5.camel@huaweicloud.com>
Subject: Re: [PATCH v3 3/3] ima: Add support for staging measurements for
 deletion
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: steven chen <chenste@linux.microsoft.com>, Mimi Zohar
 <zohar@linux.ibm.com>,  corbet@lwn.net, skhan@linuxfoundation.org,
 dmitry.kasatkin@gmail.com,  eric.snowberg@oracle.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com, Roberto Sassu
	 <roberto.sassu@huawei.com>
Date: Fri, 20 Mar 2026 18:10:05 +0100
In-Reply-To: <c9258708-2db2-4c08-998f-e67a681781da@linux.microsoft.com>
References: <20260311171956.2317781-1-roberto.sassu@huaweicloud.com>
	 <20260311171956.2317781-3-roberto.sassu@huaweicloud.com>
	 <587e11bf4d29552bbbfc029f716146e8ebfca1eb.camel@linux.ibm.com>
	 <25e0a273-9044-4e0d-9812-0171ec99e1b7@linux.microsoft.com>
	 <ffe1d4645a66a690892163be8e16c4b5d24a690d.camel@linux.ibm.com>
	 <c9258708-2db2-4c08-998f-e67a681781da@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwD3x4Rvf71pCrrQAA--.25877S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF43XF43Jry3GrWkCFyUKFg_yoW8uFWfpa
	9aq3WxCr4DJ34rAr1ktw1DCr1I9w1vyw4UWr1kt34rA3Z8JFn2vFs0y3yUXrZ0krZ3Ka1q
	va1UtrZ8Xa1DtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBGm8tCsMhQABsV
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9020-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[linux.microsoft.com,linux.ibm.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.762];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 109AC2DEA6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-03-20 at 09:58 -0700, steven chen wrote:
> On 3/20/2026 5:41 AM, Mimi Zohar wrote:
> > On Thu, 2026-03-19 at 14:31 -0700, steven chen wrote:
> >=20
> > > > - Support for deleting N measurement records (and pre-pending the r=
emaining
> > > > measurement records)
> > > Is there any problem to bring work of "stage" step together to the
> > > deletion step?
> > >=20
> > > "Trim N" method does everything that "staged" method can do, right?
> > > what's the "stage" method can do but "trim N" method can't do?
> > >=20
> > > in user space, if in "staged" state, no other user space agent can
> > > access the IMA measure list, right?
> > >=20
> > > Could you explain the benefit of bringing the "stage" step?
> > The performance improvement is because "staging" the IMA measurement li=
st takes
> > the lock in order to move the measurement list pointer and then release=
s it.
> > New measurements can then be appended to a new measurement list.  Delet=
ing
> > records is done without taking the lock to walk the staged measurement =
list.
> >=20
> > Without staging the measurement list, walking the measurement list to t=
rim N
> > records requires taking and holding the lock.  The performance is depen=
dent on
> > the size of the measurement list.
> >=20
> > Your question isn't really about "staging" the measurement list records=
, but
> > requiring a userspace signal to delete them.  To answer that question, =
deleting
> > N records (third patch) could imply staging all the measurement records=
 and
> > immediately deleting N records without an explicit userspace signal.
> >=20
> > I expect the requested "documentation" patch will provide the motivatio=
n for the
> > delayed deletion of the measurement list.
> >=20
> > Mimi
>=20
> "Staging" is great on reducing kernel IMA measurement list locking time.
>=20
> How about just do "stage N" entries and then delete the staged list in=
=20
> one shot?
> It means merge two APIs into one API
>  =C2=A0 =C2=A0 int ima_queue_stage(void)
>  =C2=A0 =C2=A0 int ima_queue_delete_staged(unsigned long req_value)
>=20
> The kernel lock time will be the same. And user space lock time will be=
=20
> reduced.

It is not the same. The walk on the staged list is done without holding
ima_extend_list_mutex.

Roberto


