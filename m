Return-Path: <linux-integrity+bounces-4714-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FCAA26913
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2025 01:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310473A371E
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2025 00:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106893C47B;
	Tue,  4 Feb 2025 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TZuhpXxQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB171F949;
	Tue,  4 Feb 2025 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630311; cv=none; b=eQS8hk7cEbLggELj+rvNk3aPsA59SLAGgqpjb07YTzYXuD4d89JwepdxQMXIEAJDRtEz6MrSX2pXz1fD7ImfrNk1dnpiN0fqFl/45Xzw0oxiKvlwbk8ITxFlpY/ytLR09VJFoSNgnt7py6aQkIicP33mzVyjds5P8Wuxqvabe+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630311; c=relaxed/simple;
	bh=BIJ69qUIj/Wtm6K3VCMeO/FzXMFe4y3y0AyW6zn6KOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cuiDE+xL+QNghugS/P8khHA81aILXW5NGH0rpV7KWBOcR0iCPiQpqK+BlI41H9kpFkT0cUnrtqrENIyVx/60jyt3ylx5iT/EJqXYom31kXznO5kQMia+TuSRJUnFQDLrDSMQjO5XWT2zLmhBy6xWXDWiKIKej/CMazA/1Tjm0ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TZuhpXxQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5140SKfo013315;
	Tue, 4 Feb 2025 00:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zURu7c
	RFYgaTclhMaPWE8ZTD4BaYAbPfUWCvWujBMx4=; b=TZuhpXxQ4KEwH3Su09kvXc
	PLKWnRRhwdy2VtSdqX55iLwzJOCLI9qMi0uDgdTrguvHcgJg4PBeExabxe/1hP63
	zUwaNq4aXbxFO90g6uXYg3tLiW2jupxLW8AGB3qyDmNkjfcwDPQh4B9erJ3n0XZS
	Qich9hVfHkIr2h68SbWD9aY6nDNwKFRnZnKiXbSWGo61kd8mRFvV3w/mDMj+UaeG
	ATEl8xdcYOVILY/+UC1nPtTt1y//dh9CGnQXwKduYVndQl7CJRnWdaWQZroBYzT6
	QERuawbOhFkP+8zrlZjdmhLGOjlIC+9M6F1LEgr+D34Agf1//ZYnBXEW62IHqozw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jqm7d7a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 00:50:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513Kgkms021477;
	Tue, 4 Feb 2025 00:50:24 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j0n18py8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 00:50:24 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5140oOxJ29819460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 00:50:24 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61FE958062;
	Tue,  4 Feb 2025 00:50:24 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75EAB5805E;
	Tue,  4 Feb 2025 00:50:23 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.18.96])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Feb 2025 00:50:23 +0000 (GMT)
Message-ID: <8091ed0d942806e16f995e8444da29df7843df62.camel@linux.ibm.com>
Subject: Re: [PATCH v7 0/7] ima: kexec: measure events between kexec load
 and excute
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com
Date: Mon, 03 Feb 2025 19:50:23 -0500
In-Reply-To: <eb2d3b5f-7aca-42c8-9b34-8ca07b8bc060@linux.microsoft.com>
References: <20250203184558.61367-1-chenste@linux.microsoft.com>
	 <eb2d3b5f-7aca-42c8-9b34-8ca07b8bc060@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8KgdoFyypmOzWMISKdhZ-rl885ZAvrsb
X-Proofpoint-ORIG-GUID: 8KgdoFyypmOzWMISKdhZ-rl885ZAvrsb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_10,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502040002

On Mon, 2025-02-03 at 15:25 -0800, steven chen wrote:
> Hi all,
>=20
> The below is the correct version for review.
>=20
> [PATCH v7 0/7] ima: kexec: measure events between kexec load and excute=
=20
> <
> https://lore.kernel.org/linux-integrity/20250203232033.64123-1-chenste@li=
nux.microso
> ft.com/T/#t>
>=20
> Please ignore the this version because patch 5 is missing.
>=20
> I am really sorry to have troubled you.

Thanks, Steven.  I was able to apply the patch set to v6.13.  For some reas=
on, b4
downloads a duplicate 4/7 patch.

Mimi

