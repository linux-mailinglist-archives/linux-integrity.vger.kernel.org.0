Return-Path: <linux-integrity+bounces-7201-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8383FB8B092
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 21:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01D657A50EB
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 19:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A493264A77;
	Fri, 19 Sep 2025 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cxhFb3iS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9FB19DF4A;
	Fri, 19 Sep 2025 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758308648; cv=none; b=Ah3+c5iJGhR8M7xc4a672spotNcdARMlaYZz6Lgpta9W9gpncBkUHCCRtdQJgoeS//aup95y6H9yoJKqgAYuNKFrszCzQ2/LWRJdWk1W0zjbrSPGSBw8s9WzRkOMOEahIaZy1+LS0lU2ccLTkuxcGXqIHT5Hw3D2/riykjhLZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758308648; c=relaxed/simple;
	bh=43lJ80IgUYC0beczoXJXTnUkAbEw/5IJ5QruoKL7+nc=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=hIhi90arZDmmjBJa9KgsBq67L2/yq+izPoBXi4Bzh/88kmrJ3LmYXhC86tRLoI7wZEFr4Q94JgwNjRFOuGVIV7vfE8wIzTNjJ17fhyEH8Vbc+0jlCSm3zZJ5QtPtuprUWnHwsIIUajPye4IhgAe3X9UhqW7AEtxMigs3l7q/5mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cxhFb3iS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JCbAGR000767;
	Fri, 19 Sep 2025 19:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4u9t55
	05BgE5ygjqrFPkD7ybYHpR8/HVQC1D+C9a7LI=; b=cxhFb3iSm3g99TZH75ygOT
	KE4W6YBI5c9Kgn3QxCodEOxuijOYXPNdMlG+7iwQtqU0Mh5BXK5GsiMP40fpuCkk
	7BnpNnq0ujVg8IobJKogITlaZ3WecOBEV64coapb36h3DaTvwGCQbPlKyAFL3kAD
	+ocHiRWegSQaydYbWXRRN8QMgcOGSIe7EcRczLYCcxGLn+C16OFVdQy80+FScat/
	NS8vuF1ypCI4Em7ndkm2OSvmP0IPecgxWCP7+/0clomEG2KF4wS4Knq8MdLVcoOy
	hpq+d796Xqlh27C+nVLLAvLQMWCMDmpkQZnFy0VtNeMAhuyKcH4muXJ2+2gI4ZbA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 498dtwsmr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 19:02:55 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58JJ2s1T032253;
	Fri, 19 Sep 2025 19:02:54 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 498dtwsmqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 19:02:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58JIDPMI027341;
	Fri, 19 Sep 2025 19:02:54 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495menn9xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 19:02:54 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58JJ2hwO28049952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 19:02:43 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A75485803F;
	Fri, 19 Sep 2025 19:02:53 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CE605804E;
	Fri, 19 Sep 2025 19:02:52 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.19.242])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 19:02:52 +0000 (GMT)
Message-ID: <603c96a486c97e20a4e86580e207cce9cac90239.camel@linux.ibm.com>
Subject: Re: [PATCH v4 10/34] lsm: rework lsm_active_cnt and lsm_idlist[]
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
In-Reply-To: <20250916220355.252592-46-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-46-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Sep 2025 15:02:51 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EYvIQOmC c=1 sm=1 tr=0 ts=68cda8df cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vpqfxihKAAAA:8 a=DfNHnWVPAAAA:8
 a=xVhDTqbCAAAA:8 a=VnNF1IyMAAAA:8 a=LGCPmzUi5DsE2mMO-XcA:9 a=QEXdDO2ut3YA:10
 a=AULIiLoY-XQsE5F6gcqX:22 a=rjTVMONInIDnV1a_A2c_:22 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-ORIG-GUID: gt-Ij9-dJalWa18m7M0LWq8vISRj6uB3
X-Proofpoint-GUID: kQdGB35A49Er4mvEPmqFPIR9aWJq0pda
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA2NSBTYWx0ZWRfX8eXQa1jDooZ9
 p1D2G2C6mq0NHF6VZdHUxic1mV+I2H/YFLWE3Y8WVcSv3JFEfI7yUqfpBcgPz2q0T7neOqhkCJR
 A6PBc3YNjrfXOPuJSE4OVXkKKCagCcMd186L8qDWxThXCfgSHlyZLZNC7F35gGklJfqCjSTxj7B
 L3pY8j9qfBhZ0P9maBrfgmgUpdHJVjyOY/3l3zDNUcbrKZZeIWqhQpTX49LAkm7XmlZNs277iB9
 TZKb38gREZrpnOvGe1wzFb02ucC6zX6yGoiYUlsu5JqzPkpn+4Qy8vU/tVEBy6XABIlg8uAjA9I
 KrnIFSe3zXkzV6zMdCePxF6wPoe/IPqqJN6wNJSMXcOy1f4hYoFqe09tyivmzT9xtd7+zyBXatq
 8m+T/HCp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180065

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> Move the LSM active count and lsm_id list declarations out of a header
> that is visible across the kernel and into a header that is limited to
> the LSM framework.  This not only helps keep the include/linux headers
> smaller and cleaner, it helps prevent misuse of these variables.
>=20
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johhansen@canonical.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  include/linux/security.h | 2 --
>  security/lsm.h           | 5 +++++
>  security/lsm_init.c      | 6 ------
>  security/lsm_syscalls.c  | 2 ++
>  security/security.c      | 3 +++
>  5 files changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 521bcb5b9717..8560c50edd2e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -167,8 +167,6 @@ struct lsm_prop {
>  };
> =20
>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1=
];
> -extern u32 lsm_active_cnt;
> -extern const struct lsm_id *lsm_idlist[];
> =20
>  /* These functions are in security/commoncap.c */
>  extern int cap_capable(const struct cred *cred, struct user_namespace *n=
s,
> diff --git a/security/lsm.h b/security/lsm.h
> index 0e1731bad4a7..dbe755c45e57 100644
> --- a/security/lsm.h
> +++ b/security/lsm.h
> @@ -7,6 +7,11 @@
>  #define _LSM_H_
> =20
>  #include <linux/lsm_hooks.h>
> +#include <linux/lsm_count.h>
> +
> +/* List of configured LSMs */
> +extern unsigned int lsm_active_cnt;
> +extern const struct lsm_id *lsm_idlist[];
> =20
>  /* LSM blob configuration */
>  extern struct lsm_blob_sizes blob_sizes;
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 2e76cefb1585..9e495a36a332 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -217,12 +217,6 @@ static void __init initialize_lsm(struct lsm_info *l=
sm)
>  	}
>  }
> =20
> -/*
> - * Current index to use while initializing the lsm id list.
> - */
> -u32 lsm_active_cnt __ro_after_init;
> -const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
> -
>  /* Populate ordered LSMs list from comma-separated LSM name list. */
>  static void __init ordered_lsm_parse(const char *order, const char *orig=
in)
>  {
> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index 8440948a690c..5648b1f0ce9c 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -17,6 +17,8 @@
>  #include <linux/lsm_hooks.h>
>  #include <uapi/linux/lsm.h>
> =20
> +#include "lsm.h"
> +
>  /**
>   * lsm_name_to_attr - map an LSM attribute name to its ID
>   * @name: name of the attribute
> diff --git a/security/security.c b/security/security.c
> index ff6da6735e2a..add46073af0c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -73,6 +73,9 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIA=
LITY_MAX + 1] =3D {
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] =3D "confidentiality",
>  };
> =20
> +unsigned int lsm_active_cnt __ro_after_init;
> +const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
> +
>  struct lsm_blob_sizes blob_sizes;
> =20
>  struct kmem_cache *lsm_file_cache;


