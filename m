Return-Path: <linux-integrity+bounces-9087-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN+WFD9PxGljyAQAu9opvQ
	(envelope-from <linux-integrity+bounces-9087-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2026 22:10:23 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD2B32C34E
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2026 22:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9111F301D245
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2026 21:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA443290C4;
	Wed, 25 Mar 2026 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AHMNj0Vt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BE22DC764;
	Wed, 25 Mar 2026 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472854; cv=none; b=iLFRucuK1NS4X6Z5qJlLsIEhn6OBf7MUpAhrVAqsIUw4xfOtMFpJ9PKjK4Wu77o1ebIRe+aPRAmB0iStdNc2xAdVI0YLqNMSr3ny0vsTIMtcK+URV43DhBj9lNBhnha17WLHwqxzBIMXQozDYx1QJZIaYkvRxBfBqEUP9KzMzYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472854; c=relaxed/simple;
	bh=NUsVUckM/rOHdjcBY11KJUeIBLiflQE/CngUZ+I6ZTo=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=IiHrWY+JqB2mYKxQUQ2ftmK9CTKeyip6DI+zjhuaL9RyvIkYe/Zm50/QSDHk7HF+vtjJmJVGK2Iy584EcNwzoDVEykuYkUbV2RQvmviQEOWeVNVNDMq1WkcW85De77UkeZYRPwUeGi/F9OK+B3t31I5NJ2XX6P3DnElo/UV3R+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AHMNj0Vt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PAU3vY014213;
	Wed, 25 Mar 2026 21:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PBVL1Q
	H/uKrOY/RMD7Y/GiF7Mtn6sgUhDJ5eSnsmEXo=; b=AHMNj0Vtol1Ue/b9vWNny1
	1NYODjXvmiJSz7U4UxT/PpWpLp8++u9GSPQNezHArEqiLiKRDOBGvk0CsoU7Pm2w
	iqsxd1nk2UOC7h025sp+Ke/ZPxtZrJKTc2HF4BFiEgXffAV6mz+AxZOOkrfP4Ca1
	loH/wAB6+0uku4RabwY3rj/HDQekS17Ndq2pc5O0zd+NCaS7l6B6M7xcpfqAgKhu
	NPSU4W0/3sMbQoRk8ihYgBypPeYS6n8Mn4r/ji0ygSACN8kVyCjZvIa69PPqCcfx
	NP9+PsO4cwzoMgDzhbvh1U3NfTB+u1PbLn8g+5+EYv7lLRYsN3PFQZiIiPu3XuwQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktv1j1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:07:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PJqlSM026797;
	Wed, 25 Mar 2026 21:07:24 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m05wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:07:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL7Nhw63701318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:07:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33E5158055;
	Wed, 25 Mar 2026 21:07:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 819965804B;
	Wed, 25 Mar 2026 21:07:22 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.80.216])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:07:22 +0000 (GMT)
Message-ID: <d85ded6aa191d2b992d05723dbb92fb6ff39c283.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity: Allow sigv3 verification on
 EVM_XATTR_PORTABLE_DIGSIG
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ebiggers@kernel.org,
        roberto.sassu@huawei.com
In-Reply-To: <6849d94f-6295-486d-aec2-0f2942539b33@linux.ibm.com>
References: <20260325001051.754093-1-stefanb@linux.ibm.com>
	 <3f9e7aa4e22ebaf38735a74b1912cf4601535791.camel@linux.ibm.com>
	 <6849d94f-6295-486d-aec2-0f2942539b33@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Mar 2026 17:07:22 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0LUIyjZlfpjkbn7pnxjStRdsX0PUh5wF
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c44e8c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=nnOYOSgYopN8RwZPrccA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfXy5StQwNcvUEi
 1fkfZjarlfJTU5Kwoexlb4z7oVMt2F/VOAGGwOIOCsdukNM159k1+KWEAbA54+uwEpcZW8Ua+nN
 TFADPEpRCbLbuRcwC6NVayWOcLiVpCu4nCOWg5s5m1SHMNA5jdYXs+MytAVhCsBuurGBdHJlIE6
 KS2yL/WxUqwo/YaXwYBVkoF/UlUKKsj7EvqBSkIElBnMgiP8LmSnk4cYQKdl+ma02luC7IgyMm7
 ABFHg5wfQzUfKtWco5VCemuIN+DeYn/CnchAXGIZWt5liZhr/gOV6d6jiNBkrZ94t9PhLJlE96s
 fzp/9ZIx4eZKRuKoL/btTnU/meHx3EomY65j2pgMzoVg0e9HK7wGGIZg4qGZGeRnVfT4wkLRfij
 KhlFN4PAclrsnsIMfSKrWKqws4btV3Edq/qaz3c+S0tCq48OpCYKYzlccFKjjv6EFINpWCf22Ay
 Ivgq1ST8wG0psRmQCAQ==
X-Proofpoint-GUID: 0LUIyjZlfpjkbn7pnxjStRdsX0PUh5wF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9087-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 3CD2B32C34E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-03-25 at 13:37 -0400, Stefan Berger wrote:
>=20
> On 3/25/26 10:56 AM, Mimi Zohar wrote:
> > On Tue, 2026-03-24 at 20:10 -0400, Stefan Berger wrote:
> > > Allow sigv3 verification on EVM_XATTR_PORTABLE_DIGSIG on RSA, ECDSA,
> > > ECRDSA, and SM2 signatures.
> > >=20
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >=20
> > Thanks, Stefan.
> >=20
> > IMA makes an exception allowing an EVM signature in lieu of an IMA sign=
ature,
> > when there is no IMA signature.  If the IMA policy rule requires an IMA=
 sigv3
> > type signature, then EVM should also require a sigv3 type signature.
>  > > Currently any EVM signature type suffices.
>=20
> Agreed, though it seems to be a problem that also exists with EVM=20
> non-portable signature, which should have a check. I cannot create them=
=20
> easily in my environment, so I cannot test with them.
>=20
> Passing the flags from IMA into EVM is easy. What is a bit more=20
> challenging is the evm_verify_current_integrity code path...

I've queued this patch in next-integrity-testing with the other sigv3 patch=
es,
since enforcing EVM sigv3 should be upstreamed as separate patch.

thanks,

Mimi

