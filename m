Return-Path: <linux-integrity+bounces-4294-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044F69E5A35
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Dec 2024 16:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3E51881820
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Dec 2024 15:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D48321C164;
	Thu,  5 Dec 2024 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tu9yZa6v"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685F2217735;
	Thu,  5 Dec 2024 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413790; cv=none; b=JYFwySHQUyaZbPKWw9wrQVi66oQ22ZrKb+0M+3Cad5tCfVc11EBY1I0daKVJUHUbiHGv6p/i/vhRDNyOKcVpIQpxsej6pQ3dw1fRSkoGyY2zKDShiWRCUkUZ3O1kxVnHB0wpkHB1cR+tSUh0BLpqe3UutXsWMs+LL0SwojRD0BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413790; c=relaxed/simple;
	bh=5Y+c4NHFD6cgzhHRlErjUw+WUmpChw84padaTrK+qWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQ8lOIuyrcxryEEc+8kZmjjIkIO2ocvUzlTurDScNS0+piTVEAKum2W5yKzYKBtvz2YINxgz5b4mjNkbjVWThO3HFQbTsQ5h0W15L4GkDSHWjVapKcafqSyulBntXNJAU0bj06cSrKPVBULqs66plNZ41UofixEhjUQlHv9gWVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tu9yZa6v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5Cp9La010713;
	Thu, 5 Dec 2024 15:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uvOX/k
	j0bum17cJw1LcCJxvsbQYNRZs9luwHtHlOAbo=; b=tu9yZa6v1TgZSzNl8wCRbc
	T7QdCyPuJouGt6QLkeBpFeaN3injwium7tmKJ9AowwRpQrdE41jXehK/Qm4HhknO
	lnQPliWWC9lj7HZM+hQwMXefPuynlsj3HkBVerGzARjWj1VrqTajVdlFCHMeVoIf
	ErRfnaOpR8Ra/ae7kqNB+kc09TUpQ+3EDVnWwX1+6Hrh31oo9wq6ctolQeAybvxl
	XYqvCnuo++1lthxIG77sX2frxNVLZQrZiLMK74lOrjzRZB5CMg8jDxpPamAdEzdS
	zb2hvGF+RRD+ig306vTx5sbnjDAqHiJQIZr/PpS4QJ/jyc5FQp7vY3nX14HS+sRg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b24rbsqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 15:44:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5BlFZc007467;
	Thu, 5 Dec 2024 15:44:26 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 438f8jtcye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 15:44:26 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B5FiP7c50135712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Dec 2024 15:44:25 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C27258058;
	Thu,  5 Dec 2024 15:44:25 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CCBB5805B;
	Thu,  5 Dec 2024 15:44:24 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Dec 2024 15:44:24 +0000 (GMT)
Message-ID: <2a449edc-a642-4e6b-a55f-2eb03e5b15ce@linux.ibm.com>
Date: Thu, 5 Dec 2024 10:44:23 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ima: instantiate the bprm_creds_for_exec() hook
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        roberto.sassu@huawei.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>,
        Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>,
        audit@vger.kernel.org
References: <20241203233424.287880-1-zohar@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241203233424.287880-1-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tx5W64ZXXLFvZsf-j4fPoGFnWV7eEydM
X-Proofpoint-ORIG-GUID: tx5W64ZXXLFvZsf-j4fPoGFnWV7eEydM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=776 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050112



On 12/3/24 6:34 PM, Mimi Zohar wrote:
> Like direct file execution (e.g. ./script.sh), indirect file exection
> (e.g. sh script.sh) needs to be measured and appraised.  Instantiate
> the new security_bprm_creds_for_exec() hook to measure and verify the
> indirect file's integrity.  Unlike direct file execution, indirect file
> execution is optionally enforced by the interpreter.
> 
> Differentiate kernel and userspace enforced integrity audit messages.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Tested-by: Stefan Berger <stefanb@linux.ibm.com>


