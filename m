Return-Path: <linux-integrity+bounces-9472-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJMgIV34+2nPJQAAu9opvQ
	(envelope-from <linux-integrity+bounces-9472-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 07 May 2026 04:26:37 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A194E2487
	for <lists+linux-integrity@lfdr.de>; Thu, 07 May 2026 04:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CA90301CCFE
	for <lists+linux-integrity@lfdr.de>; Thu,  7 May 2026 02:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F5C238159;
	Thu,  7 May 2026 02:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gqtbc8f7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EC3199FB0;
	Thu,  7 May 2026 02:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778120795; cv=none; b=ZXRzTs7ZjJq7wW1SXFd1gHd+6S+JIdV7ab4punxN5j6LANIGU2/grfPecIG9WfXUB1KRxkJkvfjezAA8hgn3KWPbgDh9Zf3O/Gu61QvTfen4AxLLa8r1zmFeIJY68KS3RtefTHNNfi8P3FCV/yHMa2V4inZejWNUXDveZ3WgxHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778120795; c=relaxed/simple;
	bh=okhG2EVPEEDPfn7Jo0TsWTzz2U0mvQGQZJTddc93OIo=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Zo48kid4MMrM35NCWf9Tw/ojiC9ULXB3eRJ5DUmNl6t7OwyOD+7sMqJV13RxfB9c8am1clSopfmN6501qoJAtmdADhCZkUyW75lcIjTWk6NwDHjq7zKe4t3CliYLV36IoJu9ZLtIsIlbZIVFz1qSY23dghCpFcswesdSAinTYeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gqtbc8f7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646Ik7vu1531488;
	Thu, 7 May 2026 02:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rQxzSD
	yf9Fj6A4ZENc/ca8mockOKJ3GHbUZjTEAcPwI=; b=gqtbc8f76VQMLM9MVEKnSx
	WBsPN5ldYdwr0g2+kLf/VnsVRBPWafnJfzQJX4mHG3A8FgvHM3Jls4qjXE+dCmmo
	DLfKhjOiylnGG3P3+GCsogdbq9MwF1MDbkNEuX93Ah+x518L3MzlpGIHkJKzQ3P1
	Kuzq36sF8gprkrO3V0Y3b07XgL49P91hFb13fmBpoWXh/PefMYVLtP2blKSBWx+u
	eRTyJNfosWoy7dAAXrLbkytyb5lO2WyQS9bUgy075Hv+bJcNcfu8y91bvW5g94Hg
	esmbCdTpsAtWO7mGL3o+RfOmR7O3PM/bfFdE0OahwxlNmC8tmwonwokM3idbC3uw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4ursj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 02:25:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6472OfTX013583;
	Thu, 7 May 2026 02:25:57 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukqha2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 02:25:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6472PuqM53871096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 02:25:56 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCE365805C;
	Thu,  7 May 2026 02:25:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8287E5805A;
	Thu,  7 May 2026 02:25:54 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.185.101])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 02:25:54 +0000 (GMT)
Message-ID: <461ec995935e2b42a8414f6f87063ff2557bbfb4.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan McDowell
 <noodles@earth.li>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
        sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
        joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
        sebastianene@google.com
In-Reply-To: <19dfb0e2730.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
References: <cover.1777036497.git.noodles@meta.com>
	 <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
	 <afMlgstqahnZg68h@e129823.arm.com>
	 <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
	 <CAHC9VhRsnmPp2KmQAns5uq5qXX5EF2xQQzyfTgrPi4O9AXyPpg@mail.gmail.com>
	 <ba4bf28314b679474a6a8da6298e548e54b3754c.camel@linux.ibm.com>
	 <CAHC9VhRE2kRr1fdDf6xgQgpSrtvqtP8Vy9LVGJhDZFUbzLKGmQ@mail.gmail.com>
	 <ff28c6dcb60c357c752724927addaa8c4fd3bf2c.camel@linux.ibm.com>
	 <CAHC9VhQY2TMkTvQq9P8oZteQWQSr7qq2utOuH+pdVx+8jWLBCw@mail.gmail.com>
	 <a9412fe10e70ce95dd70556ace19368bec5c188c.camel@linux.ibm.com>
	 <CAHC9VhRUgNA=Sj=jhD=zOt8R80Q+FQj+H0nYSy-FAujTL3EKPA@mail.gmail.com>
	 <5debff82dc758d9c91223e4f1f5b9e39a3fcd4f5.camel@linux.ibm.com>
	 <19dfb0e2730.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 22:25:54 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDAxOSBTYWx0ZWRfXznX1S+sn/9ll
 +ZDtGoPGjMHt1C52ETaGJiR87dSppgUqbTeQ5kM8saz3fOvWSKFElBgefGfZN0uth+5dO9QObYr
 wWJcR+RvLTnH2bvFzY7fyHruQhhkgijL1w9gI7fdYWzlwf90hd4vo7ta835xG/B7r+gAOUrbLzk
 Im0kk5Vh0+gYv6BuCkouHaTV4DJnzzmWeGlcOlGAg4lThkM0IYZu1a6fcs/sq1zcIvVEQz2wgeX
 yMXwi+OT1rJklihGuP8Dz3IOUv7287TYbQ32hted2YyHkX4hHoWacBjQ4Ca5zs/7IoJ73EBGQx6
 HoJwfgR1JGH814cKRrDqlwngwhNag3+UkePRvjwYBqiIeVpyy1lhiqnU18j1toLN+b6TmFsqkCW
 FaOwmSJdU7/xsP2oufP2abA3YWld2PD/laBOW8mDgPOGtasjCYhH2ZqOHl1NSylQCQKORF9fFRZ
 i0va2bRZhRNtJAcWHSA==
X-Proofpoint-ORIG-GUID: IVuvrxwTYJaZAGiHieI9ElLz5NfcZcOI
X-Proofpoint-GUID: dFBLB4dzcWwnvHt3QZOfaoUD7XzIN8YQ
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fbf837 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Hs2b41jZhdh1vBShbzsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070019
X-Rspamd-Queue-Id: E5A194E2487
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9472-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,meta.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Tue, 2026-05-05 at 22:11 -0400, Paul Moore wrote:
> On May 5, 2026 9:57:23 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Tue, 2026-05-05 at 18:55 -0400, Paul Moore wrote:
> > > On Tue, May 5, 2026 at 5:05=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.co=
m> wrote:
> > > > On Mon, 2026-05-04 at 16:51 -0400, Paul Moore wrote:
> > > > > On Mon, May 4, 2026 at 8:03=E2=80=AFAM Mimi Zohar <zohar@linux.ib=
m.com> wrote:
> > > > > > On Sun, 2026-05-03 at 12:46 -0400, Paul Moore wrote:
> > > > > > > Regardless, assuming you always want IMA to leverage a TPMs w=
hen they
> > > > > > > exist, your reply suggests that using an initcall based IMA i=
nit
> > > > > > > scheme, even a late-sync initcall, may not be sufficient beca=
use
> > > > > > > deferred TPM initialization could happen later, yes?
> > > > > >=20
> > > > > > Well yeah.  The TPM could be configured as a module, but that s=
cenario is=20
> > > > > > not of
> > > > > > interest.  That's way too late.  The case being addressed in th=
is patch set is
> > > > > > when the TPM driver tries to initialize at device_initcall, ret=
urns
> > > > > > EPROBE_DEFER, and is retried at deferred_probe_initcall (late_i=
nitcall).  Since
> > > > > > ordering within an initcall is not supported, this patch attemp=
ts to initialize
> > > > > > IMA at late_initcall and similarly retries, in this case, at=
=20
> > > > > > late_initcall_sync.
> > > > >=20
> > > > > Okay, so from a TPM initialization perspective you are satisfied =
with
> > > > > a late-sync IMA initialization, yes?
> > > >=20
> > > > No. On some architectures moving IMA initialization from the late_i=
nitcall to
> > > > late_initcall_sync does not miss any measurement records. However, =
as=20
> > > > previously
> > > > mentioned, Linux running in a PowerVM LPAR the move would drop ~30 =
measurement
> > > > records[1].  So no, only if the TPM is not initialized by late_init=
call, should
> > > > IMA retry at late_initcall_sync.
> > >=20
> > > What do you do in the PowerVM LPAR when the TPM is not avaiable at
> > > late initcall and you have to defer IMA initialization until
> > > late-sync?
> >=20
> > Your question is hypothetical ...
>=20
> <heavy eye roll>
>=20
> > ... as the TPM isn't deferred, so IMA doesn't go into
> > TPM-bypass mode.  Testing on a PowerVM LPAR demonstrated that it skips =
~30
> > measurement list records.  So moving the initcall to late_initcall_sync=
 would
> > cause a regression.
>=20
> Let me rephrase to make the question clear - how do you plan to handle a=
=20
> system where you lose measurements by waiting until late-sync, but the TP=
M=20
> is not available at the late initcall.

There have been suggestions to queue the IMA measurements, but that goes ag=
ainst
the "measure before use" principle. The solution is not to defer IMA
initialization for all systems, but to differentiate the boot_aggregate rec=
ord
(boot_aggregate vs. boot_aggregate_late) based on when the TPM becomes avai=
lable
relative to IMA's initcall.  IMA's job is simply to collect and provide the
measurement list.  Based on the attestation service policy, the attestation
service will decide whether a measurement list containing boot_aggregate_la=
te is
acceptable.

Mimi

