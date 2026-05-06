Return-Path: <linux-integrity+bounces-9457-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WH0jLwig+mk9QgMAu9opvQ
	(envelope-from <linux-integrity+bounces-9457-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 03:57:28 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A594D5776
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 03:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FD46301CF8F
	for <lists+linux-integrity@lfdr.de>; Wed,  6 May 2026 01:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6122773CA;
	Wed,  6 May 2026 01:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aYbrNUsX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DC922FF22;
	Wed,  6 May 2026 01:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032646; cv=none; b=siANn3qeegszsps7/u9lZfpNLs49lU17uasunt553uJZZJ0yq+muKPMMaA8oMfMSF8wXZU5UFQP/dWf+ibQLvq2TjxxdtqUEzr2KE9VBF3pZJ4xqsOEWUwJXsHMgo/XpV0owEykyLDhJ4Xapny229tFUCxhF1dftgsBIniSn1DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032646; c=relaxed/simple;
	bh=pRLc+DC9pw0ytTBglvbMFsKmduXkKxI+sxRLtp0WQEA=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=S6whefWB7igo9fG6roli2fN8/tov4TFczgea5sqPXSjiuwQ0RIx1wv98CaZ9M3ddz4gY6L610WeMVMmqrMnFsob9N8O8bnodVfrB0WPBrbRv0A/8Jsd24kfxbBOGhTd9hV2NHtOfo7hKDMTUrej6EvgyRxECvl/8h5bpOi3gFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aYbrNUsX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645IwSLe2807042;
	Wed, 6 May 2026 01:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mPUXvQ
	r0DL2aUfFDDGcRA7zO6a5bS6JyLG5LMOkTYnY=; b=aYbrNUsXrOVLIHBZV5Q85x
	BsILi4YiLeXFewVtcZzxrPMY+LQixqWlryu562VRcR3UU0fOh5gC7ABLOA9/va4k
	dzLb64+vwGGcZ8TYCQXkaI4ew8vqEFhTpN1p84gciOQSyn17fsP1309DyiGVuHpw
	HgBaX617ElFnq4lukca1UFzXa3lMrlxn7bcjBYurGzll0ha/IGwTD1T2K+NnfsfG
	ZXM8gDJvDBC70ubsjWt+tRpNC8QeqLfJtUmXafLOTflyXgb/C4QitQjGTvI+/r5Q
	BJx1mNWUI+W5u25ZfKfo2HiFgXzxbb5NSO+/rQ5sGBTETBeL0q+4mLHBnLHM0VqQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7ejhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 01:51:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6461di1R000554;
	Wed, 6 May 2026 01:51:54 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3h469n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 01:51:54 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6461pspQ18088522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 01:51:54 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 587685805C;
	Wed,  6 May 2026 01:51:54 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE27D58058;
	Wed,  6 May 2026 01:51:51 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.111.233])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 01:51:51 +0000 (GMT)
Message-ID: <5debff82dc758d9c91223e4f1f5b9e39a3fcd4f5.camel@linux.ibm.com>
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
In-Reply-To: <CAHC9VhRUgNA=Sj=jhD=zOt8R80Q+FQj+H0nYSy-FAujTL3EKPA@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 21:51:51 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDAxMyBTYWx0ZWRfXz6ovra1ZP5dV
 9+4nab46Mm0AiXxdRchnCrnZ6nYbmlX2zpyBXoKIhL9iosrrYx5AkLmtCh4hOAylWClqqxq/AzK
 LdTX3n6OZ5l+YG3jEQHIq76bpB/wCTy55H34eMOuams8C6pBXxjbaWmhC5rMtQJPxzvyNHR/vhj
 HqsUTG5MMv8WTrQ3cpZBazw4cK9C0cuADP0qZxC61YX7o8HcYtKn4iXhJK2ws4z0YGMHo+F5y/v
 rgiuaszci1gcnyyzsS9J5/TYgVXc3zTX34OHidFywnJgPtoeNVwWL7LmnvGh6cYvyv5XziMhVCK
 IvfCUsSphb74suCPm1oO3hVNAUTUMAM7IZ6LmtS98IKCBBtLuXOSnSG5+APSOuP2ZTkKtqkePHX
 wLMcuiO9wzZ54BfN/nT6bRJCkQ6R1siN+R7C9IhAlgU21Hl90jjS+fe1jr+xHxvJ9Qdpkmp/Eg3
 Ff9ZnzjZEx6nwv6CVtQ==
X-Proofpoint-GUID: S5ruvBnGVWmRMC517U5ostDLkLMj2qIw
X-Proofpoint-ORIG-GUID: 3iMKloGi8mSPmMG2C40umVb3LfXDp303
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69fa9ebc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=2NmI_m57lu5WmJoAan0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060013
X-Rspamd-Queue-Id: 20A594D5776
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9457-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,meta.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid];
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

On Tue, 2026-05-05 at 18:55 -0400, Paul Moore wrote:
> On Tue, May 5, 2026 at 5:05=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> > On Mon, 2026-05-04 at 16:51 -0400, Paul Moore wrote:
> > > On Mon, May 4, 2026 at 8:03=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.co=
m> wrote:
> > > > On Sun, 2026-05-03 at 12:46 -0400, Paul Moore wrote:
> > > > > Regardless, assuming you always want IMA to leverage a TPMs when =
they
> > > > > exist, your reply suggests that using an initcall based IMA init
> > > > > scheme, even a late-sync initcall, may not be sufficient because
> > > > > deferred TPM initialization could happen later, yes?
> > > >=20
> > > > Well yeah.  The TPM could be configured as a module, but that scena=
rio is not of
> > > > interest.  That's way too late.  The case being addressed in this p=
atch set is
> > > > when the TPM driver tries to initialize at device_initcall, returns
> > > > EPROBE_DEFER, and is retried at deferred_probe_initcall (late_initc=
all).  Since
> > > > ordering within an initcall is not supported, this patch attempts t=
o initialize
> > > > IMA at late_initcall and similarly retries, in this case, at late_i=
nitcall_sync.
> > >=20
> > > Okay, so from a TPM initialization perspective you are satisfied with
> > > a late-sync IMA initialization, yes?
> >=20
> > No. On some architectures moving IMA initialization from the late_initc=
all to
> > late_initcall_sync does not miss any measurement records. However, as p=
reviously
> > mentioned, Linux running in a PowerVM LPAR the move would drop ~30 meas=
urement
> > records[1].  So no, only if the TPM is not initialized by late_initcall=
, should
> > IMA retry at late_initcall_sync.
>=20
> What do you do in the PowerVM LPAR when the TPM is not avaiable at
> late initcall and you have to defer IMA initialization until
> late-sync?

Your question is hypothetical, as the TPM isn't deferred, so IMA doesn't go=
 into
TPM-bypass mode.  Testing on a PowerVM LPAR demonstrated that it skips ~30
measurement list records.  So moving the initcall to late_initcall_sync wou=
ld
cause a regression.

Mimi

