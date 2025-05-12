Return-Path: <linux-integrity+bounces-6176-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B483BAB3400
	for <lists+linux-integrity@lfdr.de>; Mon, 12 May 2025 11:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560FE18962A4
	for <lists+linux-integrity@lfdr.de>; Mon, 12 May 2025 09:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487C925DD1B;
	Mon, 12 May 2025 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C5H0PpXT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EE025E45B;
	Mon, 12 May 2025 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747043486; cv=none; b=abybgH1+MEvLvqXk19e0EJe+k7JvgqAIC2kdWLpP3k5AGb8lEZbF9b2YyyDx6P4p9OM+vN1UMsx9uSOxTN4a7dRunRxmKGV1d0QBLiQrNnJkyLObCJp2ZzJcZ3sI8bdFQlxYTYjU0yccV7q1qU+upL1x1InbYRJpbIb7IzDtdFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747043486; c=relaxed/simple;
	bh=P7bI12/G0BIVIVUm5nBDuryjFpyH9SLNZCMRed4WGXQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KmJacQLJdaxoH4sGxUVqXf99C/uy665+tZobvGeV5A3RwKro82dKvLzkv0oo1QRUIFCaD7qgDn3wLawWfTs5il5D6gU8ElG0oZ8cN7NIIaomPqsfKahULMnYeNQoS82ePkthiQ7GTyJUwGFnoss+pyDfGlzfeN0Ysz24sDADt+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C5H0PpXT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C6IYHc024139;
	Mon, 12 May 2025 09:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=StebqR
	iYq/ajV6Ebilq0GoKOhhCVhDSrElqu38WL0rE=; b=C5H0PpXT+Gvr5kl80N8tKz
	Yyi1yU3qExBmAvSogdskB5wJXZNeiaGBQp+6yAni81Vjpgtr/l4hLUZXANYG+SyW
	ow1aXGotRNOk6ixo6rjd3TTAQhsBAgRsdZ0wrOXtl7Xm0+FsBiCerjXSE6JyYGh5
	NsmoFNMnK/wEum8uvQUPl/Qo49DvRQbKrX//nxFgpjCq9AP/F7u+hMmq7w6Ig3/4
	SLWTlaDVZNx4rpbE8n4Mezv9B1dNYiR3zrKj4JqQgq0e9Xx+Q/eGYdpnp1Nw94WU
	gGDS3fFgP62NBe740UcoprMW5kV6dtSCOQwcJS5NjXRyjvoFAK6OkTNJoVORrUqQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kbksrvqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 09:51:08 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54C9gOP6016866;
	Mon, 12 May 2025 09:51:08 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kbksrvqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 09:51:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54C9LNRE025954;
	Mon, 12 May 2025 09:51:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jj4nnatd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 09:51:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54C9p4A354985204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 09:51:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE73420075;
	Mon, 12 May 2025 09:51:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C76C20072;
	Mon, 12 May 2025 09:51:04 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.63.197.14])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 May 2025 09:51:04 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (haven.au.ibm.com [9.63.198.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 6F5BB6057F;
	Mon, 12 May 2025 19:51:00 +1000 (AEST)
Message-ID: <0c0daff7b3674d2520e0fe24af4afcac49b53049.camel@linux.ibm.com>
Subject: Re: [PATCH 1/3] powerpc/pseries: Correct secvar format
 representation for static key management
From: Andrew Donnellan <ajd@linux.ibm.com>
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, zohar@linux.ibm.com,
        nayna@linux.ibm.com, linux-kernel@vger.kernel.org
Date: Mon, 12 May 2025 19:51:00 +1000
In-Reply-To: <e80c83a1-77db-452e-8a5d-d435e61bd544@linux.ibm.com>
References: <20250430090350.30023-1-ssrish@linux.ibm.com>
	 <20250430090350.30023-2-ssrish@linux.ibm.com>
	 <87e1185273ce21e5fd69ff071a1be986c2a0301a.camel@linux.ibm.com>
	 <2b7145a2-1cfb-4b1a-929c-10a03747119e@linux.ibm.com>
	 <24106430db9693f580c3765206257677c10e4375.camel@linux.ibm.com>
	 <e80c83a1-77db-452e-8a5d-d435e61bd544@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DrhW+H/+ c=1 sm=1 tr=0 ts=6821c48c cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=C5xzFnOTFPq8S06TRoEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDEwMCBTYWx0ZWRfXzVZkhw+yTy+A M5jizEdOED5m0IcC3vyJZvje28UsrBI3a+h1h8a1YhA0pRRIGUXwsaNQGcoaqqBC35mhzr/fZR4 gaeRXB/9fFuYHgfcRislT3fA8eRu5gcVRS2EIjr0BKlALvDHBQkvjAwymNvNFN6tKbBxrDXKWXP
 I1jMPdfRGE5vDt0s7ThfWlxvTecnbv4sQ00lSQK3n/g60R3UlFRIfnM/qkahd4Y5YK6VezmYoLZ FdTGFapmGISsrQPEWos303nL1DiR2EQavZmktYC0K1XrPSxwOuuVoB/TLPQUx707oPVQ8UXHIgK ZRZxR78LwnpQQRys/GcL+Mdkqd5Hw+vVlAuLpTVX8Xn0v6Cahn8wOjzlfH8uRrt6/qmcTnEOgcf
 ryzVINFz5EQzhf3Tpo36Hw8+1w9NMomOvM24EB6KRsnoIuOJNNs5CvHF7iDuWWjUeRGJAOey
X-Proofpoint-GUID: SDHQGz6jmyBWzSs1kw_OvZcKdte8zTvC
X-Proofpoint-ORIG-GUID: ZMKHPW1qGe7sDeCHOu0qskAGPbwcPAlS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=990
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120100

On Wed, 2025-05-07 at 21:18 +0530, Srish Srinivasan wrote:
> > We expect SB_VERSION to always be world-readable, I think? In which
> > case it shouldn't return H_AUTHORITY / -EPERM, ever, and if it does
> > that's an error which should be handled as an error. Or am I
> > misinterpreting the spec here?
>=20
> Yes, SB_VERSION is world-readable and should not return H_AUTHORITY
> in=20
> the case of dynamic key management mode. However, in
> the case of static key management mode, when SB_VERSION does not
> exist,=20
> the hypervisor tries to authenticate the consumer. If the
> authentication is successful, H_NOT_FOUND is returned, else
> H_AUTHORITY=20
> is returned. The intention behind authenticating the
> consumer when the object is not found is to ensure that a=20
> non-authenticated consumer is unable to conclude on the absence of
> the object. Here, when the kernel tries to read the non-existent=20
> SB_VERSION, it fails the authentication check and therefore,
> gets the H_AUTHORITY error code.

Ah, I see my confusion: if the object *doesn't exist*, then it
obviously can't be a world-readable object, thus triggering the
password verification. In which case, we do need to catch -EPERM.

Thanks for correcting me!

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited

