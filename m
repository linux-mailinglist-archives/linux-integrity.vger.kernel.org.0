Return-Path: <linux-integrity+bounces-1452-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF3B861F49
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 22:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979D01C216F3
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 21:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973201482F2;
	Fri, 23 Feb 2024 21:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MTEhndBP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EEF1F600
	for <linux-integrity@vger.kernel.org>; Fri, 23 Feb 2024 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708725264; cv=none; b=egNZGKxBJZ53ghET4VFxsfoKW6YXwFvlr79X+Ka4TvKK54vzlVChDt+gngeyOKYWt5oM5eU1Lr3zoGf3QCrLSS6mOhDrImLHq9hhG9lnmbyjVzvMr/OYdZX+4Ldy0oLBlK3D1eWUZ4Wy8gspdLtIT5jCdAvvlP3n+zNfwljKkwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708725264; c=relaxed/simple;
	bh=acSyOYPGsKbnT3j5HW3/XAUyx9Mlch7wh+yuYGa+i0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JvcL6JBD0GDEI6utXRn47tLrzmuPDX3SuWIDThoVSIFdMr1hIgBp/0GtgIBmVHZzl/LrbWjmPAh0vjxrWtkaOt1Gj67ZJxQQfU9dKNI2tR6SPoQV4F89fY1uAUIpeiRP/7ifRrqw3dA7c+bDjE4d2/AiCDaupS+KRv4v8kzi+Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MTEhndBP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NLQYi9025773
	for <linux-integrity@vger.kernel.org>; Fri, 23 Feb 2024 21:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HUcbR5hNHBliJdRKRF5bPA9XRhchGbUfQLxc7tPJAYg=;
 b=MTEhndBPw6yFOamYJ3CrG1OtZyke1viVwNtubIMijMoVlIaBLlHU9AYqycrsmja/kRTw
 589VvkxovR26qnfxLcFsuq/L+7nI5HlkS9deN+NzUf1tFWt0j9Pu1kFBlCmhSBRkVlJk
 DZXl/WhuAsL23XU47PU5z2JUrkqAaiU2iExGTSk8MYvX+0zfPHJMJeZNK+Uoh4r1J+Ny
 /7SguXi3mSf0dp2WYiYKem6UJ2WKhx5A0WvXNS4FQZt7ZPOboZv2KRed8WP9LvavfYjW
 Vtzb9FbBGnKZL9yHrUMGelPw+oGXwrI+Q3M3UPQ45qbVh7z3FzSBfe1s1nFta2hPoxn3 pA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wf0nnkr89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 23 Feb 2024 21:54:21 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NLPBot013472
	for <linux-integrity@vger.kernel.org>; Fri, 23 Feb 2024 21:54:21 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h10p4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 23 Feb 2024 21:54:21 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NLsICo15860352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-integrity@vger.kernel.org>; Fri, 23 Feb 2024 21:54:20 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F99558059
	for <linux-integrity@vger.kernel.org>; Fri, 23 Feb 2024 21:54:18 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBB7158067
	for <linux-integrity@vger.kernel.org>; Fri, 23 Feb 2024 21:54:14 +0000 (GMT)
Received: from [9.2.202.85] (unknown [9.2.202.85])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP
	for <linux-integrity@vger.kernel.org>; Fri, 23 Feb 2024 21:54:12 +0000 (GMT)
Message-ID: <b5ee92ba-6f05-4ff6-92b7-700235abfd7e@linux.ibm.com>
Date: Fri, 23 Feb 2024 16:54:11 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils: PATCH v1 1/1] Change license to LGPL-2.0-or-later
 and GPL-2.0-or-later
Content-Language: en-US
To: linux-integrity@vger.kernel.org
References: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
From: Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OPmiqqG81UdY7PgXptPvt3fVSSqKVZBH
X-Proofpoint-GUID: OPmiqqG81UdY7PgXptPvt3fVSSqKVZBH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1011 suspectscore=0
 mlxlogscore=761 lowpriorityscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230157



On 2/21/2024 3:11 AM, Dmitry Kasatkin wrote:
> Currently libimaevm provided by this project is used by the tool evmctl,
> which is also provided by this project.
> 
> An issue was reported about using libimaevm with other software. Its
> GPL2-only license makes it incompatible to use with other licenses, in
> particular GPL3-only.
> 
> To address this issue, change the project license to GPL-2.0-or-later
> and libimaevm to LGPL 2.0 or later.
> 
> Signed-off-by: Dmitry Kasatkin<dmitry.kasatkin@gmail.com>

Acked-by: Ken Goldman <kgold@linux.ibm.com>

