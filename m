Return-Path: <linux-integrity+bounces-7658-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9549BC7A94E
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Nov 2025 16:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BAE3A05A7
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Nov 2025 15:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8DC2C028A;
	Fri, 21 Nov 2025 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iG08a2oP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE72277CBF;
	Fri, 21 Nov 2025 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763739503; cv=none; b=diRvASY7aKgVel53FJ2kYrmwoCygNuCTbQ2u+VZbUI78WuoNfJ70F3tv/El+chCjzLApHjWCwuCsgdkosqmxovHUogs1OncnCGiiowb97TnGTW3UpORnlsWvvdgFxDbAWzCTto3qosdvcTudLGArnvTZPi6mOqvLDI/g3amwQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763739503; c=relaxed/simple;
	bh=4hdIvqlYYwOST62CezvgRrxud4tyBrXo/4O5lrgugx4=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=c19DrnxkDaS6OJ5XXhe4gmzOxlK1zPSeJFlVuzvHASvhjOPN8xJI2+XJSsLQ3bn240X9C+703KUuMtJ4RMK6LVdA62VRdVm4qAkHB9B0XsHaF/y4NG/nL7ouJO0fqtl7SM6gP2vlx/IvqWEx456zlLkeULgwgO9xYe4IjcOPWJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iG08a2oP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALE7U9M013975;
	Fri, 21 Nov 2025 15:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9uvpeu
	gAJT+jvnOmxXNuodJVl4KxJHP+fjJPjqvut5A=; b=iG08a2oPhBjrDeTjRDrpkH
	Sk6lnHyyS5PIfYh6R9KEVd0mjDG9WZbYJHC0gN0vznmx+ZOE+ZjDaLG02cXIdfXR
	LNioa3Z6PH2MyPKMsJ/0YdOjCJwSk12thVGYj+KFLmBF9HMBuKpQH5e2H3kLJg2I
	GfW5E1UOxO/pI+mfyPShhHlEkDpL02/S7UcDt2oqwgTmtgrwA5oiwo5wHlZ6QQge
	cfwM+qnuCE13AIfNUnlXy7ZfFrmDBsRIWOrsi/bwHIeN3g1VHn+UcuqP/bsFXs5B
	Lq7mMuIzwrPkJYkzmftynzWOWX0Q7sk1sUZh1pSSYYxvIXeWwzqZUfpFpjcgmc6w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejgxb74v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 15:38:07 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ALFWQEK025505;
	Fri, 21 Nov 2025 15:38:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejgxb74s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 15:38:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALCH8CE022354;
	Fri, 21 Nov 2025 15:38:06 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af4uncxx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 15:38:06 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ALFc5AH23921214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 15:38:05 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC73B58062;
	Fri, 21 Nov 2025 15:38:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C00D5805E;
	Fri, 21 Nov 2025 15:38:05 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.152.207])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Nov 2025 15:38:05 +0000 (GMT)
Message-ID: <c846d6966822b3822a4386c8fc36e658139ac427.camel@linux.ibm.com>
Subject: Re: [PATCH -next] ima: Handle error code returned by
 ima_filter_rule_match()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Zhao Yipeng <zhaoyipeng5@huawei.com>, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com
Cc: lujialin4@huawei.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251120071805.1604864-1-zhaoyipeng5@huawei.com>
References: <20251120071805.1604864-1-zhaoyipeng5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Nov 2025 10:38:04 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x5-8fcud3X9kdQsyEkM351qSSQhWEzV_
X-Authority-Analysis: v=2.4 cv=YqwChoYX c=1 sm=1 tr=0 ts=6920875f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=R9X4wcUyAwSOqeJDW9UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NQU1QvnrC6qYe-nw630ft6alrzbjeudf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX9XszSELlgbrl
 bAWFlimLpFTasUvRRldJJPpTkiGEIirNGd8CV2A3/u/0vWT5CVNCR0hIg53JjuIxozPPOZucCCq
 He0Qpuq4oKvMpOHDsi7VNlBDNlh7vOOvgwrbvCNpCuIpyHfFnKHcGrYwoQSa8++8+wMGL15BO1U
 55oGTCyIzOgJNnVlptcg2GVHzfp3YEDygLjlXVoszomaEduJpVa6N2HYLIoUdB4iNcVzuXFV6g0
 MnhkOTEAW1Wku8CreVZCpZ0qe+MQCEr1y4cXXtl30HuOXIrJfzZnXHNuyIATLeNZYZB+haCFdcn
 fUwucR6EJi7t6QsjrRJCE059v7yAfRjefZEcQqvkLi7JI3jAacpEbrS50Tv2GOb+xcXmyjVtF+N
 JS8zVUzBqjM+1PvrvUyBjQcBmjEAbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032

On Thu, 2025-11-20 at 15:18 +0800, Zhao Yipeng wrote:
> In ima_match_rules(), if ima_filter_rule_match() returns -ENOENT due to
> the rule being NULL, the function incorrectly skips the 'if (!rc)' check
> and sets 'result =3D true'. The LSM rule is considered a match, causing
> extra files to be measured by IMA.
>=20
> This issue can be reproduced in the following scenario:
> After unloading the SELinux policy module via 'semodule -d', if an IMA
> measurement is triggered before ima_lsm_rules is updated,
> in ima_match_rules(), the first call to ima_filter_rule_match() returns
> -ESTALE. This causes the code to enter the 'if (rc =3D=3D -ESTALE &&
> !rule_reinitialized)' block, perform ima_lsm_copy_rule() and retry. In
> ima_lsm_copy_rule(), since the SELinux module has been removed, the rule
> becomes NULL, and the second call to ima_filter_rule_match() returns
> -ENOENT. This bypasses the 'if (!rc)' check and results in a false match.
>=20
> Call trace:
>   selinux_audit_rule_match+0x310/0x3b8
>   security_audit_rule_match+0x60/0xa0
>   ima_match_rules+0x2e4/0x4a0
>   ima_match_policy+0x9c/0x1e8
>   ima_get_action+0x48/0x60
>   process_measurement+0xf8/0xa98
>   ima_bprm_check+0x98/0xd8
>   security_bprm_check+0x5c/0x78
>   search_binary_handler+0x6c/0x318
>   exec_binprm+0x58/0x1b8
>   bprm_execve+0xb8/0x130
>   do_execveat_common.isra.0+0x1a8/0x258
>   __arm64_sys_execve+0x48/0x68
>   invoke_syscall+0x50/0x128
>   el0_svc_common.constprop.0+0xc8/0xf0
>   do_el0_svc+0x24/0x38
>   el0_svc+0x44/0x200
>   el0t_64_sync_handler+0x100/0x130
>   el0t_64_sync+0x3c8/0x3d0
>=20
> Fix this by changing 'if (!rc)' to 'if (rc <=3D 0)' to ensure that error
> codes like -ENOENT do not bypass the check and accidentally result in a
> successful match.
>=20
> Fixes: 4af4662fa4a9d ("integrity: IMA policy")
> Signed-off-by: Zhao Yipeng <zhaoyipeng5@huawei.com>

Thank you. The patch is now queued in next-integrity.

Mimi

