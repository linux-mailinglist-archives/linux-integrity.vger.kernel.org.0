Return-Path: <linux-integrity+bounces-6154-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92236AAD5D6
	for <lists+linux-integrity@lfdr.de>; Wed,  7 May 2025 08:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054DC16F5D1
	for <lists+linux-integrity@lfdr.de>; Wed,  7 May 2025 06:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A231F8ACA;
	Wed,  7 May 2025 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p18VrMVR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AB71CAA87;
	Wed,  7 May 2025 06:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746598663; cv=none; b=ZFjBXfGZeAJzpOpPKHbcuqBRcMiyNJTO3XoDWS0hq3qz1cKDarGBDaW594q4GrwaLon9R6fKLrXuA6f+ugREI24HoMOiknzD5LLoCnQWfW/7XSr5tyrzD+QlA9LjdHiQYcvjqiYl81VFx1a4z6YCcRlS3UUnGF8I3QLTykx/CoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746598663; c=relaxed/simple;
	bh=x8gMHvAd52GGLXQSLhIavEwkHRtRgHwT8CNmeqeeJEM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K9jUkrojhF3o0dS56L8n9YN55a4Gr/WsZutWmbDyRzKi49tYxg+qlFUxOYzRlCsKxN6+zTbyz7nHBiJQqX1NYcc9icGdu4I/AZNPxxptFQYsITM9sVomi7cr6mtFCFISBKQp8hvRq4ve63KKX8Wk2mkzuqT9aQuJTR7JxdlYptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p18VrMVR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546Lgbsi017652;
	Wed, 7 May 2025 06:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=q2mJKU
	g1tUiVhDgsXqIjw0hWzdyfFMnBvVtWrB+aK1o=; b=p18VrMVRhaAqLLJchkjXJd
	GTsHu6RuGy35S2KImfWTbDMxolCEBTYPi9JwofZ9K6N8bm10BlldGAma3DEsuls3
	OPN4qv59KGkv0ZrLMdIr2UH+6cNIxZusI/amAjYAVoJlkVPk9AoZwW8RiY7q8nZ4
	vTlqjklcdAx2l6myoVpmE1yBzjHJnRLfowUqCbR9hF2hYa+KequdEZgY5I2aKFU6
	/gHTX5tG0F4l1A9VcuUFkAVxi0kH1ts8+MYB/tOuMY2PkWBWBFXKgOdJjnf3hG58
	ONEO9ZnR+9Y3vXII2Wp1mUCX4p08EIUOMgtRJ+usmkoAtDjnao4pSKKPssuGy1ug
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ftjw1qr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 06:17:23 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54769wMm009335;
	Wed, 7 May 2025 06:17:23 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ftjw1qr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 06:17:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54747RF1001272;
	Wed, 7 May 2025 06:17:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dwftfgm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 06:17:22 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5476HKsW51970520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 May 2025 06:17:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C419A20191;
	Wed,  7 May 2025 06:17:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6057820194;
	Wed,  7 May 2025 06:17:20 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.63.197.14])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 May 2025 06:17:20 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (haven.au.ibm.com [9.63.198.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 157CE600BB;
	Wed,  7 May 2025 16:17:18 +1000 (AEST)
Message-ID: <24106430db9693f580c3765206257677c10e4375.camel@linux.ibm.com>
Subject: Re: [PATCH 1/3] powerpc/pseries: Correct secvar format
 representation for static key management
From: Andrew Donnellan <ajd@linux.ibm.com>
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, zohar@linux.ibm.com,
        nayna@linux.ibm.com, linux-kernel@vger.kernel.org
Date: Wed, 07 May 2025 16:17:17 +1000
In-Reply-To: <2b7145a2-1cfb-4b1a-929c-10a03747119e@linux.ibm.com>
References: <20250430090350.30023-1-ssrish@linux.ibm.com>
	 <20250430090350.30023-2-ssrish@linux.ibm.com>
	 <87e1185273ce21e5fd69ff071a1be986c2a0301a.camel@linux.ibm.com>
	 <2b7145a2-1cfb-4b1a-929c-10a03747119e@linux.ibm.com>
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
X-Proofpoint-GUID: T2zuHdKPoneGx6U0Oag-MWwuSf1oy_IE
X-Proofpoint-ORIG-GUID: dYDczGWAl_g1Yeu0mEYo2aRaGcQqzvg-
X-Authority-Analysis: v=2.4 cv=R4ADGcRX c=1 sm=1 tr=0 ts=681afaf3 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=1mVJ_uiqAAAA:8 a=VnNF1IyMAAAA:8 a=ZL5jSCTfk5O3AX6_IFcA:9 a=QEXdDO2ut3YA:10
 a=h67g7WpEjx8dfGT80pje:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDA1NSBTYWx0ZWRfX3bjV2ZTOBwZI AoZee1AuWXHL3mEOVESyROCsB8QVcI191swW8dFRPXbvA1vNtAxpVuu+9WFt7fjz6JpQcUdXubo wPFkuM2fN70bmTaEboG5YEtpSuy102YWQnotoo10ZYv+ZaiHxdPuLL1V2VU43BcJqyyhsO8cLbZ
 M/yqVwqbj258hYXKoeFovDyYDCqGOUS0Q5pfwi9yVpHSAIz1Pn5O21PQKul8m4v6Z7sMyf7WYCc tIQoG9HUDDIXPU1suhNl1wjlzssX6QCAtXyqD6iphGdOFXS+pYutxgLDf7HUBEBBVXhE3f9Eclv epYvWyx7ubFKO3C8Y+hp/GNbHLgunLGG4VgG5tye3AtxdDamWQbcVxl0TkZ267lqajre4S8NBaq
 WzyVp3Ec5zvLG9YSqezNG3QAv48XAA0JK5kfoEAqNWs9uCZWZ+D1fGqWKhy8TsZS0lCzB7JH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_02,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070055

On Wed, 2025-05-07 at 00:29 +0530, Srish Srinivasan wrote:
> > > +	rc =3D plpks_read_fw_var(&var);
> > > +	if (rc) {
> > > +		pr_info("Error %ld reading SB_VERSION from
> > > firmware\n", rc);
> > We need to check for -ENOENT, otherwise this message is going to be
> > printed every time you boot a machine in static mode.
> Yes, I agree with your concern. I just want to add that, as per my=20
> understanding, we need to check for both -ENOENT and -EPERM,
> as explained below:
>=20
> As per H_PKS_READ_OBJECT semantics described in the PAPR v10.60=20
> (https://files.openpower.foundation/s/XFgfMaqLMD5Bcm8),
>=20
> * If the object is not world readable, verify that the consumer
> password=20
> matches the stored value in the hypervisor. Else return H_AUTHORITY.
> * Verify if the object exists, else return H_NOT_FOUND.
> * Verify if the policy for the object is met, else return
> H_AUTHORITY.
>=20
> So, the hypervisor returns H_NOT_FOUND only for the authenticated=20
> consumer. For unauthenticated consumers, which is the case here,
> it would return H_AUTHORITY.

We expect SB_VERSION to always be world-readable, I think? In which
case it shouldn't return H_AUTHORITY / -EPERM, ever, and if it does
that's an error which should be handled as an error. Or am I
misinterpreting the spec here?


--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited

