Return-Path: <linux-integrity+bounces-4285-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0609E4607
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2024 21:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6E54B645B6
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2024 19:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C3018B483;
	Wed,  4 Dec 2024 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VvfbCTKZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9F923919E;
	Wed,  4 Dec 2024 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338883; cv=none; b=SAiYSjgLOFEY6d/QI1gnFad/B66SzfOtrYOzrl17xKYdH9HLu4irDAFWYbRoMLEdrptXe//Op285xZLqgmMQ1CY3aA+3R2dayJWAoaDp64h4ECo9kT+/FUvUuI5KlfnOVNpuuP7QoIO146zS13avlXD3rMipaIqok/ELDdVxw+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338883; c=relaxed/simple;
	bh=xkZy/pQ+OeGQWc4fc9qLDdCaCE+8Z5gET/Yw5h4KJMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXmtoglzQeb6XF6LX5Fafo6ltgJY99QKlzqcAT7//RHd6fBIJxxrl3dlIbzsL3sCFAOKLWR5FNy/1/jas5fT7ueAxD4gthIAb2g8bd8KdcF1Wm7olZUGmIYyObJDVieDqoxe6n7gxoyFV9ey/fyQGQHsBdGxTtmxhv7NkSUy7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VvfbCTKZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4EUZN9030901;
	Wed, 4 Dec 2024 19:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bh6Pxw
	j1FsDkyxDwrs4rxad34Vi2YynyVRDjhM3onXk=; b=VvfbCTKZlzIYb9yw+RX4Q9
	tPudWHBq6/L3fxdEVqsCve79IRa/wquMnkleLpaI8qmfYVyWc6vSjDF31OH2zkkM
	cSovpm7atSb8hx3I6zIZozvsbc75dahv9YNelP4DC7L2VTAWzvZxGnpOujhiDQa+
	hYQdAEol1FdkIR7Y8KekjXJUrdEmZUfBE2P0CrYahViJqEL0UHzR1diuOQMr9uoO
	g2RsL5m63019JKThOa8GIqNSrRm/jCQhIDInu/DNbf0xq5uTFVV+mhOGukbelhPp
	7hHnf2j2M3FCQ0euUQI0EMpTU6EqBgN63qOatg2oQWSBl/5ZjQqcqFYO43pOJqng
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43arwg9cur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 19:01:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4HQF5x005253;
	Wed, 4 Dec 2024 19:01:03 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43a2kxn09a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 19:01:03 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B4J137N18940476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Dec 2024 19:01:03 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F9BB58060;
	Wed,  4 Dec 2024 19:01:03 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B15745805E;
	Wed,  4 Dec 2024 19:01:02 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Dec 2024 19:01:02 +0000 (GMT)
Message-ID: <c1c61f20-a4ee-437f-840b-2433345e74b6@linux.ibm.com>
Date: Wed, 4 Dec 2024 14:01:02 -0500
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
X-Proofpoint-GUID: mC0ha7hRiqZdNT34QdUcWhi1xFxNfG-U
X-Proofpoint-ORIG-GUID: mC0ha7hRiqZdNT34QdUcWhi1xFxNfG-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=879 phishscore=0
 bulkscore=0 clxscore=1011 adultscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040145



On 12/3/24 6:34 PM, Mimi Zohar wrote:
> Like direct file execution (e.g. ./script.sh), indirect file exection

typo: execution

> (e.g. sh script.sh) needs to be measured and appraised.  Instantiate

If I understand the underlying patches correctly then 'sh script.sh' 
would be evaluated with execveat(AT_CHECK) but this requires the execute 
flag to be set. To maintain backwards compatibility  sh cannot assume 
that script.sh has the execute flag set since it doesn't need today:

$ echo 'echo hi' > foo.sh
$ sh foo.sh
hi

the same is true for python:

$ echo 'print("hi")' > foo.py
$ python foo.py
hi

I am not sure which interpreters are going to be able to take advantage 
of this or whether they will behave differently if the x bit is set 
versus when it is not set...?

