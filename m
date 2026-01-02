Return-Path: <linux-integrity+bounces-8161-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E168ACEF196
	for <lists+linux-integrity@lfdr.de>; Fri, 02 Jan 2026 18:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE609300F89E
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jan 2026 17:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F74A2F7444;
	Fri,  2 Jan 2026 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IJZn8vfi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C260D1D5CD1;
	Fri,  2 Jan 2026 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767376137; cv=none; b=JQ7G7aERYDTkloUN+v4f0t9Irhqy7A44pHl7qgCm6ge7WVhzbdCQwKx+U5KsdlWoOCpVE9n72uwHR19mIfK7asy8cS7LJaOlAZxowcHvXSOQRXE5cA4JiljHEGPrLk4H7E/776Igt2QB1z9PuDmO2U/R0ysKjVUztblk4EVOIP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767376137; c=relaxed/simple;
	bh=dCvSZMHRcIMvmMrk8Xrdw9qHq3fJKcUlxZqsI0VmiWg=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=mIotwwGDmqh32ErqaI9dCcraCJEWzsIILTB7V3ZQD6UZrHJs0jI7J9B6nxIUNA0wu5tWTP4qiosTu2ksoyVAWHnCB5f8DmMl1IhMWHvdCyYHjdBB5s1DyTrkdr76jumzowwDZNVxc9+nreAj1zgc9rqpa5KSdnsVT+RHh3KfTug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IJZn8vfi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 601Ksb03012496;
	Fri, 2 Jan 2026 17:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dCvSZM
	HRcIMvmMrk8Xrdw9qHq3fJKcUlxZqsI0VmiWg=; b=IJZn8vfi+DxfslAX9b0UJH
	6R58TPo0+eFtgYhZ3s0rKmT6H2BZfXa9rzn05tVNffDrmekru8vyx0Wz+nuR1BTR
	BnXRhb3caDH/0nvx5pb4U3VBog7TUHBsXhetZcaqagmEcx4hh0wAqhlYgiEklVWj
	0VAuQSlKexwe+UmnzPrrq1bvqbRIqXd8bHHzxjOynQJrLht8sKA77+l09CXjXRKm
	F/tPfITw01yC9OjeXIWds64Elyt8/By4Cp9YfRsai/Oo+E6lExF2rIAoAzbiz0dE
	hgUafzfVk6ncsPBFWVBqfn4vXykrYlh1zOvOmEVSsSG9SOVs9ZYlXqVzEQvlzePg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba73w5b0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Jan 2026 17:48:42 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 602Hh28L004763;
	Fri, 2 Jan 2026 17:48:41 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba73w5b0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Jan 2026 17:48:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 602FWKkX003076;
	Fri, 2 Jan 2026 17:48:40 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bavg279g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Jan 2026 17:48:40 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 602HmdhL22807084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Jan 2026 17:48:39 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A1D15803F;
	Fri,  2 Jan 2026 17:48:39 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9452F58054;
	Fri,  2 Jan 2026 17:48:37 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.43.105])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Jan 2026 17:48:37 +0000 (GMT)
Message-ID: <02583d9d0691468e7facfbbc9a13b591fbdaadb2.camel@linux.ibm.com>
Subject: Re: [PATCH v2 6/6] docs: trusted-encryped: add PKWM as a new trust
 source
From: Mimi Zohar <zohar@linux.ibm.com>
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, nayna@linux.ibm.com, rnsastry@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20251217172505.112398-7-ssrish@linux.ibm.com>
References: <20251217172505.112398-1-ssrish@linux.ibm.com>
	 <20251217172505.112398-7-ssrish@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Jan 2026 12:48:37 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bqQUh9EJFkG1jRU0auuKMxYkwrx6rNqK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE1OSBTYWx0ZWRfX1BXqiSNK8fx+
 Vx5+FlFJ4qDFD6cxTRDSmrrxfWez+1x6Viv0jExQMb8ypAaxoQ80dcqNwI2JV9NNScCCJBWAAtT
 U0/APwC2YKYpdBKvxZOyDE0tKNcnv88lfFWwNRxNduQa90i09lEWUryDbFrmZZhMqiaZNUPNU0p
 U5HF6JfLokqdSZeMNYmbXd0/hwxL9PwmPNK7ofSrBMUdHV0Fn3W9Yg2KNTwIN46rT4E18TKVqQ0
 lb1UuJZ3Qk9da2tMRabLrstKCOVw0iNJXmLJpZHtuVbZ+xYHjYeBbAiNwRt3nnTbaRat6C68W9V
 LBN1A3+POYjxseC2asAd1AN3xx4rt/A8aQXr0ff73TG9Pvs+eVGMcOgfMi2PANWgPmHr1KZ/j5e
 ipI4qr0NODKBojM4imHVWOQ9c92WDT3tDovXwAXfkF25od7e4ypY5KbRseQCMc6N8pW6+uQcC5r
 8AGnzQivA9Q7xlJwFwg==
X-Authority-Analysis: v=2.4 cv=fobRpV4f c=1 sm=1 tr=0 ts=695804fa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=sgltXFsEcmSdi6oR4GcA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-GUID: Opj_w7Q9PCZHxaSEFXVcrEa_BqVYe0v4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601020159

On Wed, 2025-12-17 at 22:55 +0530, Srish Srinivasan wrote:
> From: Nayna Jain <nayna@linux.ibm.com>
>=20
> Update Documentation/security/keys/trusted-encrypted.rst and Documentatio=
n/
> admin-guide/kernel-parameters.txt with PowerVM Key Wrapping Module (PKWM)
> as a new trust source
>=20
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Thanks, Nayna, Srish.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>



