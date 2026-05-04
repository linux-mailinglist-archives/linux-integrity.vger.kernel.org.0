Return-Path: <linux-integrity+bounces-9409-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKCiLw6L+Gl+wQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9409-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 04 May 2026 14:03:26 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 564F04BCB9B
	for <lists+linux-integrity@lfdr.de>; Mon, 04 May 2026 14:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A78E630067BC
	for <lists+linux-integrity@lfdr.de>; Mon,  4 May 2026 12:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401FC3CBE9E;
	Mon,  4 May 2026 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qMq4yCIV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038993C1980;
	Mon,  4 May 2026 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896204; cv=none; b=ub2u17OSoZomkqxcAAfVJNmz+un3k7mPBAsm4A21XSbjIpNbRXMrMulYjjyIEkGOflQH6KnHu3CSMB/nikTHHOoF2KfIAUs+IysNEP5xvGASi/L7/3sCMxzwEOJcUDlodrGYLLiW6FJY8J3vyiHBklq0ujsofJfQw7c5aULn4CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896204; c=relaxed/simple;
	bh=/X6RS1Fqu7I3voeFmchwbuKmcgmlda7edLIPfQe8NzE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=mOmZVxotX5uiKaEqqTOGdTAN3krP/5fgeWAoKCpLrrCavd9pkWR4dgLYTEG0Tz8PVQOlCHfmimmLZ/d+3P3dAMcZ44yebidwPGR405jQDQP0tzwFFNT8GXvVvPmtMXnunnSZUMo2/Y/w9xn6XGk0xA4KmxeELZEjeHVZWFzM40Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qMq4yCIV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6447sMqf852737;
	Mon, 4 May 2026 12:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=l04vgr
	hiUBVJ40ibTRxasIaQMDV+oR0MUnO977L5BNY=; b=qMq4yCIVP5pOXgmriDeS8z
	2i5OoS7ezJBicI9G3O7lt8iJIu9r7mKgYDj2yQxvTP2o1rft0/gRpqU8MOEtUsl6
	2dr6DI02Oty2Tf6Ku3m9SEbToQXjl/sBbrUECu1FoGPl0HBsuZql5Kb3f1LSQ5Wo
	XNOf2cbppkKV9xWK/F080sNR/TopaV1cXQdpkZtM53lNPP85i91qajzSgrkMHYRI
	ORBFNskXcwMddg825hCZ9rMVzwTrvz0lP0+0iT0dZrlOchC3V/tzuSli5KxHVKpC
	SyGc6fLOtWfqiG9S2rPIvRLpBod6n7aKM5yxGxsT48UNGVDWaFJp2V6mGihbDoog
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4em46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 12:02:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644BsXqP030860;
	Mon, 4 May 2026 12:02:51 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9y4q8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 12:02:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 644C2oI236962950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 12:02:50 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F5E358056;
	Mon,  4 May 2026 12:02:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BD0C5803F;
	Mon,  4 May 2026 12:02:48 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.125.169])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 May 2026 12:02:48 +0000 (GMT)
Message-ID: <ff28c6dcb60c357c752724927addaa8c4fd3bf2c.camel@linux.ibm.com>
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
In-Reply-To: <CAHC9VhRE2kRr1fdDf6xgQgpSrtvqtP8Vy9LVGJhDZFUbzLKGmQ@mail.gmail.com>
References: <cover.1777036497.git.noodles@meta.com>
	 <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
	 <afMlgstqahnZg68h@e129823.arm.com>
	 <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
	 <CAHC9VhRsnmPp2KmQAns5uq5qXX5EF2xQQzyfTgrPi4O9AXyPpg@mail.gmail.com>
	 <ba4bf28314b679474a6a8da6298e548e54b3754c.camel@linux.ibm.com>
	 <CAHC9VhRE2kRr1fdDf6xgQgpSrtvqtP8Vy9LVGJhDZFUbzLKGmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 08:02:48 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEyMyBTYWx0ZWRfX3lMCQg2GdYj4
 zb2CMGSv1FXRAseLkhlhbewvpipIcXqCuAAgkCPXN1KvrRXdayHGQOiX/xUxPm7WC7yvK3xuCpO
 rYTn+YW2RUnrBzbtgMxhAmOrmjmqxSAvesI4dG+D7MAMezH+PAWholxiSC67tqx+CwgyG9rLVVu
 UQq4MmEplwy2wpaOuAQHLdjLRZbjqtx4cs3/yAB2VphrYiReNq8YVBGKBA/kJ3oTG4xRNXgt2/b
 xr+Zr0ru+u5buZEDsjzzmMeOxNOb+2GW+VFSUDN9fCyhAp0CjfaCJiH4vPej8PBBfikpWx5Aw5F
 YRELIQ8yCl//aGuk7w3mErQdmaTerpRh7XN3BgH64nSx4M2x5tvJJS3zb/DBAEueK5CRDprMGx8
 wJwhtBuxYaXPcQ1jh+kh9xHVxcDS+uDgovoOwv9tINNgr23a7PbmmIXOHrgBKzg6dKi5i5e44o0
 lGF83L9CkswtGdJYtfA==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69f88aec cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=HoVq9zYKdZc2vep7obkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: iXpw0SMeopALzrzjBD9UShBrcyb1LlDE
X-Proofpoint-ORIG-GUID: 5uQlSXbiDIA3UYiMMFtdaLflhQcXZ96V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040123
X-Rspamd-Queue-Id: 564F04BCB9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9409-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,meta.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]

On Sun, 2026-05-03 at 12:46 -0400, Paul Moore wrote:
> Regardless, assuming you always want IMA to leverage a TPMs when they
> exist, your reply suggests that using an initcall based IMA init
> scheme, even a late-sync initcall, may not be sufficient because
> deferred TPM initialization could happen later, yes?

Well yeah.  The TPM could be configured as a module, but that scenario is n=
ot of
interest.  That's way too late.  The case being addressed in this patch set=
 is
when the TPM driver tries to initialize at device_initcall, returns
EPROBE_DEFER, and is retried at deferred_probe_initcall (late_initcall).  S=
ince
ordering within an initcall is not supported, this patch attempts to initia=
lize
IMA at late_initcall and similarly retries, in this case, at late_initcall_=
sync.

Mimi

