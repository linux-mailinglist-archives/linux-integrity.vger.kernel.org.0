Return-Path: <linux-integrity+bounces-5101-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603ECA4F468
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 03:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8030716D230
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 02:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ADF13D279;
	Wed,  5 Mar 2025 02:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gIC32lJS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECDC82C60;
	Wed,  5 Mar 2025 02:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741140515; cv=none; b=QrjXtlQHsgs7R4JRUlYJ/rnGryMVqgneT1Km6U2YEo4ds2gfC/ImSJWJgowmYjO9ouLN81dh1bsBZrGlVUqY8BlQR2Ak8yUV8BZN1lkkWCxMMVNYi1jc/2u+mhMwbZvrvTDvRGrWkRqpM17gmNOJDvxxiQ+oE7cpXZwhBPD9l0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741140515; c=relaxed/simple;
	bh=2qaY55EbUClEFWlHR/dlU8zjvd4SCa1PdEWwBvUXdWA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u31r+HCxtIw2+J+Y2aNxj5Lf2dnQwRPHI4yjuIWiz5HkvQGP5p3uWfEfD/Ml4psegXwJI+R0LTC2esjkfNTn4EVqUnm7FpDTa+XiUHmzRBcfPVaaTfRXWSCpQ/JN4BFO6OErPkFsD4qLX/r2VZxj1n9DkMQAFsxiyud7/XH1pnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gIC32lJS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524KchQO014502;
	Wed, 5 Mar 2025 02:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8zXsNO
	fgaDdCDO14Py7QD/hmFwzYTQByJPaKXkUaR6Q=; b=gIC32lJSVEyLINqvFLXLRa
	uI/NC1wwUV3+nliKUOQm72wVa3WKDJuaNnH9hAtKXR6N3gOe6oq+sJCgok3Rg3Xy
	P+MtaFW3lcVdQyDASoXnYBEpzItyCjRr+qnD9OYJ4ANOOQb08JAZOJM65uXHzkZo
	gRvu7iIw4qzJDC8cLJih7taCx0Vw34hJJBd9i0mU72IXHfymyM5f2+XixCHlEZeo
	5ddSk80Lxz+A4nt7j63DJtM1hXuwVI0X1OKKiCNv4P4zlbjwdZ9/hCMlsVNt3qHp
	9Y1y0pQtsGLfx928uVVRTJ/5RsgNoithOiZleWgx9gJ6WmkugCVC3dNix59lS9Qg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568r0h0px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 02:08:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524NZWpa013743;
	Wed, 5 Mar 2025 02:08:02 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2krdvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 02:08:02 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 525282Us48824582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 02:08:02 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF4CD58056;
	Wed,  5 Mar 2025 02:08:01 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD72F5803F;
	Wed,  5 Mar 2025 02:08:00 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.117.76])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 02:08:00 +0000 (GMT)
Message-ID: <3aadae5d35af3f984b9e8bc548d73bb878d666bd.camel@linux.ibm.com>
Subject: Re: [PATCH v9 1/7] ima: copy only complete measurement records
 across kexec
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Tue, 04 Mar 2025 21:08:00 -0500
In-Reply-To: <20250304190351.96975-2-chenste@linux.microsoft.com>
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
	 <20250304190351.96975-2-chenste@linux.microsoft.com>
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
X-Proofpoint-GUID: CAoPRjNKVmPFluf5VdmaD1zxNex0Mc7D
X-Proofpoint-ORIG-GUID: CAoPRjNKVmPFluf5VdmaD1zxNex0Mc7D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_01,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=983
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503050013

On Tue, 2025-03-04 at 11:03 -0800, steven chen wrote:
>=20
>  - Compared the memory size allocated with memory size of the entire=20
>    measurement record. Copy only complete measurement records if there=
=20
>    is enough memory. If there is not enough memory, it will not copy
>    any IMA measurement records, and this situation will result in a=20
>    failure of remote attestation.

In discussions with Tushar, I was very clear that as many measurement recor=
ds as
possible should be carried over to the kexec'ed kernel.  The main change be=
tween
v8 and v9 was to make sure the last record copied was a complete record.

Mimi

