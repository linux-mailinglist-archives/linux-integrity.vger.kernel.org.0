Return-Path: <linux-integrity+bounces-6311-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADF8AC5A55
	for <lists+linux-integrity@lfdr.de>; Tue, 27 May 2025 21:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2601BA7E40
	for <lists+linux-integrity@lfdr.de>; Tue, 27 May 2025 19:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B641F8F04;
	Tue, 27 May 2025 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T7vJdhhU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825591990A7;
	Tue, 27 May 2025 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748372597; cv=none; b=fBd063U0q+9uKc8BIgHGYxb+S+cA1OmkoxGu62Ka9nSrm+uDmCCjb58XvFK3KXAkyn0Tqo5JRUa8lt1obrHL/SjT9dbkPyf9C8DGKtc5sSKvFfhsybaI03iWTdy2qh20b7By/yGRRkzvSvCrZzpPlRhKneVNBcyHBttDAH+qo4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748372597; c=relaxed/simple;
	bh=doMS0trNlP/kwdokYAMx2s7mxwnpc0nNhX83X3QDP4E=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=pjbOshe7qPalx/7c4Zq61dkXf+I9kUAmYSyErDWtTn8LYfMYGUPmMDd5zWYdTZ2/yZkPZY8NAa6n8P1rpImj5H4Ij0cMQQ9VOUbfRl3Y8f8dp6rHiHua7iBjQMa+s6W04/ALPg9PwzTm78qAJlcJ0+kZyeAv7jXTBTdM9NVmLZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T7vJdhhU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RGHNHx004950;
	Tue, 27 May 2025 19:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Us8SyY
	ruv+FTdPUtNEtd3t+r94/trKQpiChagfVzK9Y=; b=T7vJdhhUvXPR0mc9VYwrPI
	b0/u45ypLmm30hLwQSa+fEa0GmlyeZtYo2zK2R4kk5Rdjs963LSpkxt7nVhK3bHw
	4i708vj7HC5zCMapQ/MnFLj+g+as8Kx+Ctqn7W6G28LWhGq7eK0opFOGGbRbMxOs
	dDowdTY7mO7RE7Ul5qLi12c2uCUyGCzqpd3ui1VRn11WSyYz+kXNrwgdjw7LnEUq
	+HsCGr1CjRULRGJID8hAx29dXFlsdjmWtJ8h54UlHMl4HBxxcaN4G30+CN+l4isa
	7+cGAF3KoxIg4ilH7iveKKSzl5YElE53l3GuskCSEO23dWXuJhbcb/Nag318p0HA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46wgsj0tbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 19:02:45 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54RJ2iXG025065;
	Tue, 27 May 2025 19:02:44 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46wgsj0tbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 19:02:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54RHOl9r028925;
	Tue, 27 May 2025 19:02:43 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46usepv0n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 19:02:43 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54RJ2g2D31261292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 19:02:42 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B11E058057;
	Tue, 27 May 2025 19:02:42 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05D5C5805D;
	Tue, 27 May 2025 19:02:42 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 May 2025 19:02:41 +0000 (GMT)
Message-ID: <f04a8c07d7da1df2cd5b74f04d253611bab9f1ad.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: prevent concurrent list operations in
 ima_lsm_update_rules
From: Mimi Zohar <zohar@linux.ibm.com>
To: Zhao Yipeng <zhaoyipeng5@huawei.com>, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        janne.karhunen@gmail.com
Cc: morgan@kernel.org, lujialin4@huawei.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250527125103.751077-1-zhaoyipeng5@huawei.com>
References: <20250527125103.751077-1-zhaoyipeng5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 May 2025 15:02:41 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IcmHWXqa c=1 sm=1 tr=0 ts=68360c55 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=i0EeH86SAAAA:8 a=RwKbe1zy0JAV_bTXriMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDE1OSBTYWx0ZWRfX/6shcxoJEONO gYcVKbllMdMawPpJ3afG3OzQfw2liWwHHYVMY6GnEppEzyiiuIqEVIBvxN+9lO8x0z46RlR+W2U TUmIEGeF1lc6fdySL28lqfd9CSFvL/8iRLcals9RkBft7IxcahZvD8RntLNL/GQAG8WQgLFjKTh
 RyzlbyFdBnW4XZxdmFEGsAB4X8tUH5T8du+a5XpBaCWWshpOxZchjXMz94UUK0Ji0uTzIZ1XtZz IaNh//hbenDd/vDBoBkJAdzvxb/5lFxc4KROkNEn/aWeNw0kN/Qj18G0U+UDKWRQtFtYkaAv8qE vVMiTyNeSv3E/dszGT3yST+pQzrRoxBvp0dLWiU8lydNiVUcYOXOofaXG29hvPAJfcEz9nCL776
 3DAnhngmQuF/NWjfMBIyFAjfuTIbyLnzHT5gbBPXK+n5xaHOcKBUu4cPhXBs4zoOQc6lerrN
X-Proofpoint-ORIG-GUID: xI2bhaKHgDBJDtf61pJ-5YsBPSzD1fSV
X-Proofpoint-GUID: k8z10pVxgJ3YBUWhTOvC1EEXI1_ELafR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_09,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 mlxlogscore=996 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505270159

On Tue, 2025-05-27 at 20:51 +0800, Zhao Yipeng wrote:
> The current implementation of IMA policy list replacement via
> list_replace_rcu may trigger general protection faults under concurrent
> load policy operations. This occurs when a process replaces a node in
> ima_policy_rules list and sets old->prev =3D LIST_POISON2, while another
> parallel process still holds references to the old node. Subsequent list
> operations on the poisoned pointer result in kernel panic due to invalid
> memory access.
>=20
> To resolve this, introduce a mutex lock (ima_rules_mutex) in
> ima_lsm_update_rules() to protect. ima_update_policy() also use the
> ima_policy_rules. Introduce a mutex lock in it.

A new IMA policy may replace the existing builtin policy rules with a custo=
m
policy. In all other cases, the IMA policy rules may only be extended.  Wri=
ting
or extending the IMA policy rules requires taking the ima_write_mutex.

There's no need for a new mutex.

Mimi

>=20
> Fixes: b16942455193 ("ima: use the lsm policy update notifier")
> Signed-off-by: Zhao Yipeng <zhaoyipeng5@huawei.com>
> ---
> =C2=A0security/integrity/ima/ima_policy.c | 10 +++++++++-
> =C2=A01 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/security/integrity/ima/ima_policy.c
> b/security/integrity/ima/ima_policy.c
> index 128fab897930..d27e615e97d5 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -471,6 +471,8 @@ static bool ima_rule_contains_lsm_cond(struct
> ima_rule_entry *entry)
> =C2=A0	return false;
> =C2=A0}
> =C2=A0
> +static DEFINE_MUTEX(ima_rules_mutex);
> +
> =C2=A0/*
> =C2=A0 * The LSM policy can be reloaded, leaving the IMA LSM based rules =
referring
> =C2=A0 * to the old, stale LSM policy.=C2=A0 Update the IMA LSM based rul=
es to reflect
> @@ -481,16 +483,19 @@ static void ima_lsm_update_rules(void)
> =C2=A0	struct ima_rule_entry *entry, *e;
> =C2=A0	int result;
> =C2=A0
> +	mutex_lock(&ima_rules_mutex);
> =C2=A0	list_for_each_entry_safe(entry, e, &ima_policy_rules, list) {
> =C2=A0		if (!ima_rule_contains_lsm_cond(entry))
> =C2=A0			continue;
> =C2=A0
> =C2=A0		result =3D ima_lsm_update_rule(entry);
> =C2=A0		if (result) {
> +			mutex_unlock(&ima_rules_mutex);
> =C2=A0			pr_err("lsm rule update error %d\n", result);
> =C2=A0			return;
> =C2=A0		}
> =C2=A0	}
> +	mutex_unlock(&ima_rules_mutex);
> =C2=A0}
> =C2=A0
> =C2=A0int ima_lsm_policy_change(struct notifier_block *nb, unsigned long =
event,
> @@ -1038,9 +1043,12 @@ int ima_check_policy(void)
> =C2=A0 */
> =C2=A0void ima_update_policy(void)
> =C2=A0{
> -	struct list_head *policy =3D &ima_policy_rules;
> +	struct list_head *policy;
> =C2=A0
> +	mutex_lock(&ima_rules_mutex);
> +	policy =3D &ima_policy_rules;
> =C2=A0	list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu=
);
> +	mutex_unlock(&ima_rules_mutex);
> =C2=A0
> =C2=A0	if (ima_rules !=3D (struct list_head __rcu *)policy) {
> =C2=A0		ima_policy_flag =3D 0;


