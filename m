Return-Path: <linux-integrity+bounces-9479-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJK5Brmc/GnWRwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9479-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 07 May 2026 16:07:53 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 628504E9D57
	for <lists+linux-integrity@lfdr.de>; Thu, 07 May 2026 16:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBEF0302DF52
	for <lists+linux-integrity@lfdr.de>; Thu,  7 May 2026 14:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1930536A008;
	Thu,  7 May 2026 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rWIIQGqO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41373F20E3;
	Thu,  7 May 2026 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778162500; cv=none; b=MxZLLuKD0ohX4YxpKv/e0w4LQN//wPeEaoekHZtV7OGOis+SirRpNDPNLgZL5+Db3w1cYYD1CsCoA/5OSldSyzCX8tTb/EJuni/Zjr67R/HaIsxxME0VayfXPGT/KsgkxcdHEjVKyN1N3Hf9qvP0EywQwAnWC/qAhPsE/y3ALYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778162500; c=relaxed/simple;
	bh=QlgeF9pQz9DhiBq008/l2KPV+NgTf5Ys4pRNpYb2aeE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=NF0QyFbQ38uDYcTLMZgkAdJD84Z9DPUfp1ipmUVGksI8NTQ31PultMqMYNpJp1mJB+k3ohQT/T/mm6rpqnuHCRXNLXNgoNrc2QIl1ekQO7MsT4uZo5E1/MsC2/SuDTzIWALvBwrZ/TXSein8I2mejrcWLT3Rr0fNGlunaNnqQL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rWIIQGqO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647BJdhk2510470;
	Thu, 7 May 2026 14:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oWtZDR
	H0XY4nauxzG4LAo3FtS1diyaJai6sOkl7fPQs=; b=rWIIQGqO5ieaq2jgp0h46T
	4fkuwRSNebflUT/BhuDUB6kpY6AintAlvo2zEvDOdVfqd6boVkNyAs6meD4A/FFQ
	KFr4tK7B6j3yRiWpd2J8rmgXoHJBgKXWaDUXEYbDFFTY1VX/VMe2LeHoiLsdOmhL
	1HbkTq0gdlRtHmizJnotlGIQxkwUkWrdnOjOoDAjG5DuwzyFwr5VwP7lYcNXIbmk
	DDQwML4lkooRevRkN8ftspbYJffqpZ/d4cNTA90J0CU2/woiAuzqM5X9wVmVYxi5
	hJVTkci3lIGaZrGg0Y9DioUdZUTIDOp73jUquvbtfifvrIjI5GtH2LOS89aOHpcg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4xub3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 14:00:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647DsTLf030229;
	Thu, 7 May 2026 14:00:57 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuywbyfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 14:00:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647E0T5a31523562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 14:00:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3305A5805A;
	Thu,  7 May 2026 14:00:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8868B58052;
	Thu,  7 May 2026 14:00:55 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.30.146])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 14:00:55 +0000 (GMT)
Message-ID: <adbf47af6a52b3da7a1e502037fdcac92ed63089.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Paul Moore
	 <paul@paul-moore.com>
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
In-Reply-To: <8c99263d8e63100e0b5e6c8cf739f7f6e7e79f6b.camel@huaweicloud.com>
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
		 <461ec995935e2b42a8414f6f87063ff2557bbfb4.camel@linux.ibm.com>
	 <8c99263d8e63100e0b5e6c8cf739f7f6e7e79f6b.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 10:00:55 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzNiBTYWx0ZWRfXxfALLztlGl7O
 tSbUOVQ3WbBM1bCCw1QNc8e46+M02jlRVTzWpNfWqV4U4JYHyDBSb2F2Vj00SQKW1n/4sA6Cuge
 RLHY0vuM/M1XTJDJnGzrrF5HF0oLVqqXgzvkR7Ruexa1itwjH9dJZ/xyEiP4xo/6fF447binzzB
 75wqfSNI7nok9TxDlUiRhfFQxu7TIM+X7JNVVY6I3bFW411fYwah3kBn8xu4wFlY5f8WkFtIF8G
 GHzgTjorO//v02HL0BQwnEv6Ywtq72RMr7rc1qXN6z/TwqniSLS/2Zy02CYKg1hrnxXdyfeaBkR
 IDalQF57kTg7knAnD3MdOB3f+orldz3xGdFCvxkl8QSHPPr8xdomE8Hgo1IGEAmMhO0hRfJhWVu
 2+sU/An7SAhWiG+aHD8pW4yWeLMghEWvpGPxH5Y350JV7VRJRatU5ue+ERXEVT17nyQW0V5CQvD
 ltTOzRTGcHdMiptRffg==
X-Proofpoint-ORIG-GUID: 4Ev7-NHEpeuk_LfgDJ-Qhn0RMmKkW_iI
X-Proofpoint-GUID: IvDOIm6WvmeJI_VGRy5Jq49N0vizzzck
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fc9b1b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=eeChVw4XoIuzKrOC7zMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070136
X-Rspamd-Queue-Id: 628504E9D57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9479-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,meta.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Thu, 2026-05-07 at 10:10 +0200, Roberto Sassu wrote:
> On Wed, 2026-05-06 at 22:25 -0400, Mimi Zohar wrote:
> > On Tue, 2026-05-05 at 22:11 -0400, Paul Moore wrote:
> > > On May 5, 2026 9:57:23 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > On Tue, 2026-05-05 at 18:55 -0400, Paul Moore wrote:
> > > > > On Tue, May 5, 2026 at 5:05=E2=80=AFPM Mimi Zohar <zohar@linux.ib=
m.com> wrote:
> > > > > > On Mon, 2026-05-04 at 16:51 -0400, Paul Moore wrote:
> > > > > > > On Mon, May 4, 2026 at 8:03=E2=80=AFAM Mimi Zohar <zohar@linu=
x.ibm.com> wrote:
> > > > > > > > On Sun, 2026-05-03 at 12:46 -0400, Paul Moore wrote:
> > > > > > > > > Regardless, assuming you always want IMA to leverage a TP=
Ms when they
> > > > > > > > > exist, your reply suggests that using an initcall based I=
MA init
> > > > > > > > > scheme, even a late-sync initcall, may not be sufficient =
because
> > > > > > > > > deferred TPM initialization could happen later, yes?
> > > > > > > >=20
> > > > > > > > Well yeah.  The TPM could be configured as a module, but th=
at scenario is=20
> > > > > > > > not of
> > > > > > > > interest.  That's way too late.  The case being addressed i=
n this patch set is
> > > > > > > > when the TPM driver tries to initialize at device_initcall,=
 returns
> > > > > > > > EPROBE_DEFER, and is retried at deferred_probe_initcall (la=
te_initcall).  Since
> > > > > > > > ordering within an initcall is not supported, this patch at=
tempts to initialize
> > > > > > > > IMA at late_initcall and similarly retries, in this case, a=
t=20
> > > > > > > > late_initcall_sync.
> > > > > > >=20
> > > > > > > Okay, so from a TPM initialization perspective you are satisf=
ied with
> > > > > > > a late-sync IMA initialization, yes?
> > > > > >=20
> > > > > > No. On some architectures moving IMA initialization from the la=
te_initcall to
> > > > > > late_initcall_sync does not miss any measurement records. Howev=
er, as=20
> > > > > > previously
> > > > > > mentioned, Linux running in a PowerVM LPAR the move would drop =
~30 measurement
> > > > > > records[1].  So no, only if the TPM is not initialized by late_=
initcall, should
> > > > > > IMA retry at late_initcall_sync.
> > > > >=20
> > > > > What do you do in the PowerVM LPAR when the TPM is not avaiable a=
t
> > > > > late initcall and you have to defer IMA initialization until
> > > > > late-sync?
> > > >=20
> > > > Your question is hypothetical ...
> > >=20
> > > <heavy eye roll>
> > >=20
> > > > ... as the TPM isn't deferred, so IMA doesn't go into
> > > > TPM-bypass mode.  Testing on a PowerVM LPAR demonstrated that it sk=
ips ~30
> > > > measurement list records.  So moving the initcall to late_initcall_=
sync would
> > > > cause a regression.
> > >=20
> > > Let me rephrase to make the question clear - how do you plan to handl=
e a=20
> > > system where you lose measurements by waiting until late-sync, but th=
e TPM=20
> > > is not available at the late initcall.
> >=20
> > There have been suggestions to queue the IMA measurements, but that goe=
s against
> > the "measure before use" principle. The solution is not to defer IMA
> > initialization for all systems, but to differentiate the boot_aggregate=
 record
> > (boot_aggregate vs. boot_aggregate_late) based on when the TPM becomes =
available
> > relative to IMA's initcall.  IMA's job is simply to collect and provide=
 the
> > measurement list.  Based on the attestation service policy, the attesta=
tion
> > service will decide whether a measurement list containing boot_aggregat=
e_late is
> > acceptable.
>=20
> Agreed on no violation of the measure and load principle.
>=20
> But also the two boot_aggregate solution does not work. If there are
> measurements before boot_aggregate_late, they can corrupt the system
> without noticing, and the corrupted system would emit the
> boot_aggregate measurement (non-late) to pass verification.

This is a risk management issue. The conservative option is to continue
initializing IMA only at late_initcall, as we have been doing, and accept t=
he
late TPM initialization limitation. The alternative is to also allow IMA to
initialize at late_initcall_sync, controlled by a Kconfig option, so that
existing systems are unaffected while systems with late TPM initialization =
can
opt in to boot_aggregate_late support.

Mimi

