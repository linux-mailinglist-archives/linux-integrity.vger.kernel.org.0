Return-Path: <linux-integrity+bounces-2876-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D91590F909
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2024 00:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21AC31C2131D
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jun 2024 22:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E0378B4C;
	Wed, 19 Jun 2024 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eRRI/7Lf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF2822EED;
	Wed, 19 Jun 2024 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718836508; cv=none; b=enVu0jSpTybbNoqvwrnY6u2q0cR7dADWEhCoWxhX4xyyXlh7fUQjJn1sDyY49NzGYYLi0APtN04n4Gj1viVlnAaTGrCvoQ/cSIxpUqrpTe0jWGA8+/QRy8wRV9l/F1exGOgMPRlMt0uS1ZdpCOefb1QYYY20k8TMeKD+4j0vWro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718836508; c=relaxed/simple;
	bh=QtW08RGNREOR+K6tQRGt9K5glWEWCXOUnOSFN+uTMIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CC8dz6SG3mYNHaAoCJQOupJWCbOS2JiawKvmfFjxmDq5ny1gdd/21uAvhJOIIetPxg2lEulTOHplqblE86DCUJd0mkgYD8xYBcA0PJ8w6twlpVyX3NIFZFm/uDFY3iSdhC1q1NJaTkFCnWvsyZczUFJLXolW7DMLMrTATlNR9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eRRI/7Lf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JMSVYt032472;
	Wed, 19 Jun 2024 22:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=f
	vXa5SbWGVQSKFn8wO5u5+scc+ExTDxsloqTzUC0bvs=; b=eRRI/7Lf1Wz1CjpGz
	BtW3y/gM0mdp/jM7ZVxLFWD6Wz9ACjtj9X9sPmvQBxh92OK/VDpitapbce9MAXMD
	nUbU8gU79/CzcQEy67blPzFAn6/yQl3xIjlAsHM7HDr6CkOemejK6HTHw9R6fnKz
	6SP/4N1quCH66sM0Jupzgk1K+Bu6WztLnQshJgu88dS0QjnZYy6Hw+qkKLCYWg24
	iN8ym768Nloo7X6HU0TKr6pquQFLmWIjEiwb1zfwl+1yfP0/8kfdaFOWmHy8nXCS
	6S5f1Uvzq4938tN2M7is3w1W90K7pq/HDaw2skIS2vvm+GsXjzD1OtIxLTiapy9p
	orJMw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yv85gg0pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 22:34:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45JKS22p013512;
	Wed, 19 Jun 2024 22:34:52 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysr0409n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 22:34:52 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45JMYo8A23200496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 22:34:52 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10EDE58065;
	Wed, 19 Jun 2024 22:34:50 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADE8F58052;
	Wed, 19 Jun 2024 22:34:49 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Jun 2024 22:34:49 +0000 (GMT)
Message-ID: <9e167f3e-cd81-45ab-bd34-939f516b05a4@linux.ibm.com>
Date: Wed, 19 Jun 2024 18:34:49 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize
 session support
To: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        jarkko@kernel.org
Cc: linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        naveen.n.rao@linux.ibm.com
References: <20240617193408.1234365-1-stefanb@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240617193408.1234365-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U2oBWoZBpMZVmVt1GDA2XpYdb07ojIV_
X-Proofpoint-GUID: U2oBWoZBpMZVmVt1GDA2XpYdb07ojIV_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190169

Jarkko,
   are you ok with this patch?

   Stefan

On 6/17/24 15:34, Stefan Berger wrote:
> Fix the following type of error message caused by a missing call to
> tpm2_sessions_init() in the IBM vTPM driver:
> 
> [    2.987131] tpm tpm0: tpm2_load_context: failed with a TPM error 0x01C4
> [    2.987140] ima: Error Communicating to TPM chip, result: -14
> 
> Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   drivers/char/tpm/tpm_ibmvtpm.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index d3989b257f42..1e5b107d1f3b 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -698,6 +698,10 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>   		rc = tpm2_get_cc_attrs_tbl(chip);
>   		if (rc)
>   			goto init_irq_cleanup;
> +
> +		rc = tpm2_sessions_init(chip);
> +		if (rc)
> +			goto init_irq_cleanup;
>   	}
>   
>   	return tpm_chip_register(chip);

