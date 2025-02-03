Return-Path: <linux-integrity+bounces-4702-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D32A26711
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Feb 2025 23:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFBF3A3E5F
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Feb 2025 22:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5508C2744D;
	Mon,  3 Feb 2025 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AXMVv0+9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E791FFC7D;
	Mon,  3 Feb 2025 22:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622744; cv=none; b=c5S0Cb6OLHDziaYKBb3lTaIdA2v2bBknqpP5uM1X+gLfix4Tudu2yDq3VX7GNH2aX9jpESE0Ldeo/OYn13IF8JdJfltKhA+hVT/vRCO90bQkHYMlp6itphf5jBLJKh+2OfIxzGtA0S+b6KJbIcCRluV1WmmF6cuvzZ5D/d3Qu0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622744; c=relaxed/simple;
	bh=p+u2z/Ts/LT6PtTkaWiVagg/BvIfy13aOSTGOYoxTG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sa73/ErJKZUtn3iKQyRNza1UQ437h/ZaLcvfD1Tj/qXGpyzsljUC0ZCoZkjG+dwbBnjQ8dGSSUt5x/oj/qdq1G6T2lDdiT47AuAcjFLBgPV3ZYlGdrKk26TJClxJxVw/J3deh+jxiEMVsEOHk+qg72pdpG0K2qkKpBouInse7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AXMVv0+9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513FeQrV015310;
	Mon, 3 Feb 2025 22:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p+u2z/
	Ts/LT6PtTkaWiVagg/BvIfy13aOSTGOYoxTG8=; b=AXMVv0+9eJrTOik+ywky3J
	AaFadllkrIodUt1qZGIoUtNxeKJTraQa1WVrNBzlyorO1ST2LVQUvvo7NcrTPKI3
	hWWIlXYtSfQQcplJhfoyXzaCswG6lTDGa/czwMLKxXjTV/j8Qs42VngfR00kmBz9
	end2ws/5iDwEovfEGsOpqyvHt2nrinH9ufAGHkN9Oz8o7dxC4LeQdwhBbXrUt95g
	jllr1DTeDX4OAH2FH6Xp+PLLQYzbp+G5z7OHXLVoB0rrGlIc5+M7ZLNAnml7VRxE
	nZ3GvO3rbJKaG4eFfnWC816j6MTM15N9v94oj3NBHCvzE6oEyL/h/ezi6TxxKiyQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jqm7ct6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 22:44:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513KQPpG005258;
	Mon, 3 Feb 2025 22:44:13 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05jrd5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 22:44:13 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 513MiDDP13173268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 22:44:13 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44E7858055;
	Mon,  3 Feb 2025 22:44:13 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61F7558043;
	Mon,  3 Feb 2025 22:44:12 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Feb 2025 22:44:12 +0000 (GMT)
Message-ID: <64f329c9-2912-4e7d-9475-b16fa0ac1d04@linux.ibm.com>
Date: Mon, 3 Feb 2025 17:44:12 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] ima: kexec: measure events between kexec load and
 excute
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com
References: <20250203184558.61367-1-chenste@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250203184558.61367-1-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ViUeqqliz0kJJ_jnOdhPWASG3FyCpIc8
X-Proofpoint-ORIG-GUID: ViUeqqliz0kJJ_jnOdhPWASG3FyCpIc8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=814 bulkscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030164



On 2/3/25 1:45 PM, steven chen wrote:

It looks like 5/7 is missing.
Does it apply to 6.13?



