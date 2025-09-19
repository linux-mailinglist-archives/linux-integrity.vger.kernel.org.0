Return-Path: <linux-integrity+bounces-7190-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB31B8921F
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 12:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A83E179812
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 10:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DA12FC009;
	Fri, 19 Sep 2025 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I0/8e5M/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C910F27E041;
	Fri, 19 Sep 2025 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278805; cv=none; b=StutJyAC8SIRRJnt/uJDO+DekaPeihLzEYX5502m5EdF18d9xhdSgs60nQpLDQQHDd7xLMe/86FJWMHV52+GjcfWH6/63KPZ7A72tQN3eaMDymCmeoVzUK2+2UZQrE+iuaO6qDHkD1IaB+OkF7eQI/GBXU7Ghlrks6Pod0hXl8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278805; c=relaxed/simple;
	bh=V1zZLkefEeKEnSTxACjzESyhakMgrBrOCPUfcgo0S7E=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=LrVhfxDSgzmtcyshQ8li+f8Y1WKAFZIWk20FZFhnx/PBnASzTP5lHpSlAnNheKGYBXfahkX7aybogiegibwxrI6DRcRZCSyQ63lOTdh9cCyM/J5e3TQ7CdwldJaZTOP9WXQBq64rufySaJr4wur/k+YucVqMrDvmThjzRWEjSPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I0/8e5M/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J4UYZX011472;
	Fri, 19 Sep 2025 10:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2APfFR
	r91pMLh+/XYgfOyO2KzbwZ3/c9cwJFZDa96iQ=; b=I0/8e5M/iM08gjrmcNstKs
	TeFJgNMQRmb0wf0gn32gVYFOzVdr2EToITxKr2fhuABLfPOPtEN8EPPnNTXWr7XX
	lRRbdhJluawIQ6zXAaw7hjJJJfUj5wi+UQDy5RygurUswSdBb/OQPUBvBiNPE4m/
	R+mGJVDt6fLQwYwoXZVWBy/s67kJT4SVMP+EeHS1lIL0H8a+tMraSVscShemXcQY
	SUb12BXW6IUo60+FBse7Gc39+oocNO3k/q938kbNnbFJqKwr9lKN44YFg42NRqoF
	7sIzwFYZNwq9cJWsZVOmyA8GCcppU8FQoJj9kX9YGWDqTyyR+//N6/7frBdnxK5A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4jg3et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:45:42 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58JAQMHp021250;
	Fri, 19 Sep 2025 10:45:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4jg3ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:45:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58J9JCU4029817;
	Fri, 19 Sep 2025 10:45:41 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kb1bmv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:45:41 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58JAjeKM31261360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 10:45:40 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47FCA58058;
	Fri, 19 Sep 2025 10:45:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59A6958059;
	Fri, 19 Sep 2025 10:45:39 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.169.163])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 10:45:39 +0000 (GMT)
Message-ID: <bde9bb270dd045ec60dd95a791f4fab75fbb18ab.camel@linux.ibm.com>
Subject: Re: [PATCH v4 05/34] lsm: integrate report_lsm_order() code into
 caller
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=	 <mic@digikod.net>,
        =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
        Kees Cook
 <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler	
 <casey@schaufler-ca.com>,
        Tetsuo Handa
 <penguin-kernel@I-love.SAKURA.ne.jp>,
        Nicolas Bouchinet
 <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <20250916220355.252592-41-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-41-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Sep 2025 06:45:39 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Qf5mvtbv c=1 sm=1 tr=0 ts=68cd3456 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vpqfxihKAAAA:8 a=DfNHnWVPAAAA:8
 a=xVhDTqbCAAAA:8 a=VnNF1IyMAAAA:8 a=sapI--1WW6SfE11a4LkA:9 a=QEXdDO2ut3YA:10
 a=AULIiLoY-XQsE5F6gcqX:22 a=rjTVMONInIDnV1a_A2c_:22 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-ORIG-GUID: DUY0T2PhXetbH5NGbo6DXHc0RW5njL5Y
X-Proofpoint-GUID: 32cIq0Fvrz3lcSS4Sp_wA8rjMC4GSMhl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX8ao3kGyeIwHZ
 pd5GUKuodbzKH28hZgHAms4Y0feu7lWN4Aacs1mX9Di60d4xYIhnKD10U7nzXXQASKLsnegIyYP
 MqAcFA/u1MT0Jzg2cznBa/psurEF5vJj2kAy8ejtWadELiNbH3awGVQZJoYZufvp3IuVYC5j+Eg
 KlYO5Xu85gpwnm6T3kWle5eWBtEml8dah0nBHUgQ5YXebvtpZIFt3sxo4cc7UueDiRB2uhlHdX8
 NGCMtpsm2i3XJnObSZrW5uJuyHVa1aChHAco5iXHpCeQKfsoOhAwJaWm5AfQnXTjt2gh1tA56wR
 Jw5OLPwGb50Na/Xr/y+H4yrNHPReFk1/pE/rm/KpsZMzyKd+ObU74GP/9LFWdapVyNtVPfwnSYD
 fVBq8sc8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> With only one caller of report_lsm_order(), insert the function's code
> directly into the caller and ger rid of report_lsm_order().
>=20
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johhansen@canonical.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  security/lsm_init.c | 33 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)
>=20
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 18828a65c364..09afa7ad719e 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -291,26 +291,6 @@ static void __init ordered_lsm_parse(const char *ord=
er, const char *origin)
>  	kfree(sep);
>  }
> =20
> -static void __init report_lsm_order(void)
> -{
> -	struct lsm_info **lsm, *early;
> -	int first =3D 0;
> -
> -	pr_info("initializing lsm=3D");
> -
> -	/* Report each enabled LSM name, comma separated. */
> -	lsm_early_for_each_raw(early) {
> -		if (is_enabled(early))
> -			pr_cont("%s%s", first++ =3D=3D 0 ? "" : ",", early->name);
> -	}
> -	lsm_order_for_each(lsm) {
> -		if (is_enabled(*lsm))
> -			pr_cont("%s%s", first++ =3D=3D 0 ? "" : ",", (*lsm)->name);
> -	}
> -
> -	pr_cont("\n");
> -}
> -
>  /**
>   * lsm_early_cred - during initialization allocate a composite cred blob
>   * @cred: the cred that needs a blob
> @@ -341,7 +321,9 @@ static void __init lsm_early_task(struct task_struct =
*task)
> =20
>  static void __init ordered_lsm_init(void)
>  {
> +	unsigned int first =3D 0;
>  	struct lsm_info **lsm;
> +	struct lsm_info *early;
> =20
>  	if (chosen_lsm_order) {
>  		if (chosen_major_lsm) {
> @@ -357,7 +339,16 @@ static void __init ordered_lsm_init(void)
>  		lsm_prepare(*lsm);
>  	}
> =20
> -	report_lsm_order();
> +	pr_info("initializing lsm=3D");
> +	lsm_early_for_each_raw(early) {
> +		if (is_enabled(early))
> +			pr_cont("%s%s", first++ =3D=3D 0 ? "" : ",", early->name);
> +	}
> +	lsm_order_for_each(lsm) {
> +		if (is_enabled(*lsm))
> +			pr_cont("%s%s", first++ =3D=3D 0 ? "" : ",", (*lsm)->name);
> +	}
> +	pr_cont("\n");
> =20
>  	init_debug("cred blob size       =3D %d\n", blob_sizes.lbs_cred);
>  	init_debug("file blob size       =3D %d\n", blob_sizes.lbs_file);


