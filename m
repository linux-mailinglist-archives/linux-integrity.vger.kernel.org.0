Return-Path: <linux-integrity+bounces-6178-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C063AB34AD
	for <lists+linux-integrity@lfdr.de>; Mon, 12 May 2025 12:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3EFF3B13E7
	for <lists+linux-integrity@lfdr.de>; Mon, 12 May 2025 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E356D25B674;
	Mon, 12 May 2025 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mHVQOE91"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E3F257436;
	Mon, 12 May 2025 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747045014; cv=none; b=kV+Rb7eeRYvIkBfXNKki5v1AIlyrt0Yjf1OVvcoPR53UU2LOJ5UTZDDYd4RZqndKQIF1Af+NuijZcy9q1aGRePGEkFAJUjPUDh3N4In58Mc7DZKE1KMkq+LpDp8Pd9IGGC78K/Gqd8E7Z4yn0pMinhXu21TBMH478CzEMdehzME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747045014; c=relaxed/simple;
	bh=FsBUKuP2Lj+kKciIgCacwau1zeXR4sKd5muEMNCT66I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpcSaer6jrtDPAyfmPOTH9sfbbNfvacaOWoJueeyyZL3sigRGsad01TjhyRoj2mz3o5Dv5LpuRAZCCZRCXm3CG2fdIteGRQ6/jfsWL9TDqOshUFmLshTIuJ6ajoVkO8/HDiUCZbwIjBvju3dN+AJpCb7Ra6BfKMyitoYvIlDPG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mHVQOE91; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CABqdT016690;
	Mon, 12 May 2025 10:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FsBUKu
	P2Lj+kKciIgCacwau1zeXR4sKd5muEMNCT66I=; b=mHVQOE91GiMltvvvNQFpTy
	AkFwcJNkczDgfApP5GuVhBxu5pH6Kw7ioSzoBvnlPKBtbXkqafWlYD08IItOx7Dc
	+1/yV5ZPSwVsrMtzDejL+GyZpBbEnxwaW0QD+4vEj2B+LQe4B4d0dqSWHzE8hC9B
	GWpLKgRl268wKicg30pm/ekwerqHHTVly6RK7Z/Sq4rOUVTRE9ejiE0dNMG+i+BM
	KKmw6RCBu9mTLb/2ygEm0FXR3cJaxsylokDo5s+z8nMYG+KaTcbVWfCAFo5hdonR
	2aPcS+RhrYlLPJ5Zbu0KCN13as8WUB3iZsNt/Jb3aQqsNQu8l5Pw53k+QINhXHVg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46k1k6jndy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 10:16:36 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54CA3wn4004052;
	Mon, 12 May 2025 10:16:36 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46k1k6jndv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 10:16:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54C9J3mT025960;
	Mon, 12 May 2025 10:16:35 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jj4nne1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 10:16:35 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54CAGYL827591334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 10:16:34 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 446335805D;
	Mon, 12 May 2025 10:16:34 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 831A858061;
	Mon, 12 May 2025 10:16:30 +0000 (GMT)
Received: from [9.204.203.112] (unknown [9.204.203.112])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 May 2025 10:16:30 +0000 (GMT)
Message-ID: <416c529c-529e-4b3e-8ee7-218c091e47e8@linux.ibm.com>
Date: Mon, 12 May 2025 15:46:29 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] powerpc/pseries: Correct secvar format representation
 for static key management
To: Andrew Donnellan <ajd@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, zohar@linux.ibm.com,
        nayna@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20250430090350.30023-1-ssrish@linux.ibm.com>
 <20250430090350.30023-2-ssrish@linux.ibm.com>
 <87e1185273ce21e5fd69ff071a1be986c2a0301a.camel@linux.ibm.com>
 <2b7145a2-1cfb-4b1a-929c-10a03747119e@linux.ibm.com>
 <9477e99aa57e432b1e55ebd3e903036e60926014.camel@linux.ibm.com>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <9477e99aa57e432b1e55ebd3e903036e60926014.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dNSmmPZb c=1 sm=1 tr=0 ts=6821ca84 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=zfkpKoCRZlattQDdKtwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: F9CfGFN7YhA5ixo9TiZ7LJm_RYvCo1kw
X-Proofpoint-ORIG-GUID: uJy7dpvhXXAIvFVnvXwWAckcRlol4lnM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDEwNiBTYWx0ZWRfX9YA2N1Bjup4q OWGl1xIvXkgWqoAQHulPO+9NA0WG/vahhW4gIraLp8Sv0GE8MfLaptO6XCfkQdEZm9YrqHH8mSk Gs0waALJO87V4IHFQdUwBmQJtSa+CV9xjW1BgqSoO4BrDvIaZrscTXY3d2FgHr50nImuCUVc5Zf
 2hEmh6rgx1s1mBADn2Wfvgp3FKdao49MekZfzBENFnwsLjz5VTwX54tTDNPNTYRljkbt6yPs7p/ SCYmfzOGnY+2gVqUDeykT5Rk/APIf50WXvfvQeCetipU1yHRcvyR+bKY2UR7LBksJjSeopWoCPs 3+CsV3de587b/4tfoXMAJL4PwbAQRIverPE7bA/uFyZnSw/HZErcSKWfocNhJ9Mbnq4bVEq5U1d
 JhT4jC82ZpZkfoh3KqwousRdHat74Zon3z8K/sOf5H+a0B5iz0yA8mJdbzgjnTQHkjqCXxWR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_04,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120106


On 5/12/25 3:25 PM, Andrew Donnellan wrote:
> On Wed, 2025-05-07 at 00:29 +0530, Srish Srinivasan wrote:
>>> I think you should handle this as the existing code does: if it's
>>> ENOENT, return 0, and for other codes print an error and return -
>>> EIO.
>> Currently, the other layers in the boot stack assume static key mode
>> for
>> any failure in reading SB_VERSION. We added the same interpretation
>> in the kernel to keep it consistent with the other layers, and
>> represent
>> the same to the user. This is the reason for not parsing the error
>> codes
>> when trying to read SB_VERSION, and defaulting to the static key
>> management mode. However, we want the exact error code to be logged
>> for debugging purposes. And, it does make sense to have logging only
>> for
>> error codes other than -ENOENT and -EPERM, as you suggested.
>> Does this sound okay?
> Okay, maybe document explicitly in a comment that we default to static
> mode in the event of any weird errors.
Sure, will do that.
Thank You.
>

