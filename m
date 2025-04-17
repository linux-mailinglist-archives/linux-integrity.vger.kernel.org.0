Return-Path: <linux-integrity+bounces-5923-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC67A91104
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Apr 2025 03:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C1B3BEDFB
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Apr 2025 01:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704872DFA56;
	Thu, 17 Apr 2025 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n86RXRgp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F1C1547C9;
	Thu, 17 Apr 2025 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744852208; cv=none; b=qA6Pda2msgauAxAqtpQfdfHyTxdxS1a4H3Gv41ZBWdgkdNpxxzVlUCH7ttTKMxjUzrLxgPn/hTWcTSL2mtzheL+BVO1WfCvJ5hZS/e/knq/kiu2adCmEmtwXmzW/8opVgkeEiK5X+YjKNxV0bL+PtzuiUQHDf45DDrnw4oIR5Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744852208; c=relaxed/simple;
	bh=sCk4s2BEvqzj6Ctkri/ogbGb7GtmwjvsewhjBHtEO70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kz4SvGp531L9HMUkO0o8Yp4SOGBXlWPbf8BSaMjARdialJrRKe/XsqLDYX+kPhwG3inCC1e6L1T7DBehWlMH/+byuzNgkgBWt9SNutXJWodH/ajUBqf+hEpjwZP0Wi13VMWUeo/pXgkO+2Z3YsC+EJ1MWEhT/Azk/mVSJo+zsyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n86RXRgp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GLW826019008;
	Thu, 17 Apr 2025 01:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ah/lLz
	BmfOIHy5wOwIFiZy+sp117fbDDGICRD88/xh8=; b=n86RXRgper66X0nQGr/SIC
	rYc7HochvI/iHrEML50CySpLEsaptWcfK7HSgDf7O8qS6C/zNnQPxwfo4pgb6+eX
	AkQxleDMoK8rlIxBFadOqGo2jcEr4rie3dbIIax0MMF++ZMn6pd0zad6QNsvFpZx
	/0fSVrfPEJLBVnApDjCByVBoqWCvNyqec4O5LUGn4DvyKYCUyG7xKmK24f0qfszi
	hQAonjj02jIGh2uAOBqZQy5tHmE96XC2phK+ohnOB0X9wmvLcUwp4SoheHCcLnKg
	2b1tARm921vHxIxNAf0JizkFpHIPUNgWVtNyCYPGmfBx29Pn784UoflR7LhTwiSQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mhu0r9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 01:09:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53GNSmTf010392;
	Thu, 17 Apr 2025 01:09:27 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qkaym2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 01:09:27 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53H19QBm24380138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 01:09:27 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96C895805F;
	Thu, 17 Apr 2025 01:09:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DADCF5805A;
	Thu, 17 Apr 2025 01:09:24 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Apr 2025 01:09:24 +0000 (GMT)
Message-ID: <4a2f7fde-99ee-4bcd-a97d-fe0db418fd5f@linux.ibm.com>
Date: Wed, 16 Apr 2025 21:09:24 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/9] ima: kexec: measure events between kexec load and
 execute
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250416021028.1403-1-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Hvd2G1TS c=1 sm=1 tr=0 ts=680054c8 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=yMhMjlubAAAA:8 a=VnNF1IyMAAAA:8 a=KXIcZCm0EDoHl9fo71cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: j6fdTeznLc-rslj-Y7d3L1utxejtCVup
X-Proofpoint-GUID: j6fdTeznLc-rslj-Y7d3L1utxejtCVup
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_09,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170006



On 4/15/25 10:10 PM, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
> 
> The current kernel behavior is IMA measurements snapshot is taken at
> kexec 'load' and not at kexec 'execute'.  IMA log is then carried
> over to the new kernel after kexec 'execute'.
> 
> Currently, the kernel behavior during kexec load is to fetch the IMA
> measurements log from TPM PCRs and store it in a buffer. When a kexec
> reboot is triggered, this stored log buffer is carried over to the second
> kernel. However, the time gap between kexec load and kexec reboot can be
> very long. During this time window, new events extended into TPM PCRs miss
> the chance to be carried over to the second kernel. This results in
> mismatch between TPM PCR quotes and the actual IMA measurements list after
> kexec soft reboot, which in turn results in remote attestation failure.

Tested-by: Stefan Berger <stefanb@linux.ibm.com> # ppc64/kvm


