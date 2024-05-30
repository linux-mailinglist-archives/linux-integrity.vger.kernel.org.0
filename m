Return-Path: <linux-integrity+bounces-2717-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFAD8D4D89
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 16:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7EC1F21B50
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 14:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31381176237;
	Thu, 30 May 2024 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WTopETGU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB8117D8A9;
	Thu, 30 May 2024 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078099; cv=none; b=MIGaK3e6rN0x0WeMzVtGyCnxU7USCKLQ8yXHV8pjzpnwF0qhlWVMJGwFzd7RUJ0MWgHiTltdmWsDECtzAolLFW6wQQxGpCiC/uTLR75L925njG5648D8tESalyn/6olPD+Y/KaBOb+ZIuwCdmwn96OGFbAiWS8kvyvYqbt73W7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078099; c=relaxed/simple;
	bh=EZ6CNDZ/17E/DkuT+VWNmITW9/kfR2rHBbFL3oFnVPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RckPjLl2p8ueT0WnxINvBllUNQBcX2SAgJYZcFrt81v97kPN2W7xpTTS9MOHyWQYn50QxOPrV7yL4fjk4ZQW/iOSK5ERf68zYUoeLnAmji42p+M1T2ktLJTs1h2eMjyZv8XEVog/jMQcHD/udl8ZNpkZIMSCDD5K0ADF5ZbKlD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WTopETGU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44U5hH0r015684;
	Thu, 30 May 2024 14:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s5xSVs/mPJRwYaKkrhVOTQmXac0Ej6Efg8321SwZZhI=; b=WTopETGUSoLaAfHj
	yzsAv5EnJuQB+SALUtOVsJow/qAJHrbdkYAprpyf7UIizMkBFCzkQ94ZvaQGnRZr
	gzl2DvXF2XFoGTR/+tIf+66a5EkkMkuSJdEb2KXJ1gvfJ5RRtLO1pHhHu2wb4ieL
	pCi81c69EI2HcKNz5rd+3QFPjER0FJQUQ8HVZDPTfJ4i97x4ceCwxLKZYaJ0YIux
	cZ+HCFxzGTRbPz1XvphL2iEkEzJH/NztJ61mFvbzP8osozOrny18z7T2ERFcFIn2
	wqldoairb4vsR7cRDB7D2vBgdqAjvX6LUE44zy6vQSkYVh4XjIuV5pISQFn+CnNA
	3xW74A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ydyws3uyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 14:07:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44UE7qYU018637
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 14:07:52 GMT
Received: from [10.110.109.163] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 07:07:50 -0700
Message-ID: <18ca9445-588c-4c41-b274-8f7f0ea589b5@quicinc.com>
Date: Thu, 30 May 2024 07:07:49 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KEYS: trusted: add MODULE_DESCRIPTION()
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley
	<James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
CC: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240529-md-trusted-v1-1-56c9a0ae8e28@quicinc.com>
 <D1MQK4XPVIUW.2EUDV0050EY5L@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <D1MQK4XPVIUW.2EUDV0050EY5L@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0eo2TFYGszRQoY_vu6BJyUxnh2959CFl
X-Proofpoint-GUID: 0eo2TFYGszRQoY_vu6BJyUxnh2959CFl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_09,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=819
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405300107

On 5/29/2024 10:39 PM, Jarkko Sakkinen wrote:
> On Thu May 30, 2024 at 4:02 AM EEST, Jeff Johnson wrote:
>> Fix the 'make W=1' warning:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in security/keys/trusted-keys/trusted.o
> 
> Maybe instead:
> 
> """
> KEYS: trusted: Add the missing MODULE_DESCRIPTION()
> 
> kbuild reports:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in security/keys/trusted-keys/trusted.o
> 
> Add the missing MODULE_DESCRIPTION() macro invocation.

Can do, v2 coming...



