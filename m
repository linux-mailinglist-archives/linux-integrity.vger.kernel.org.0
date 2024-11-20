Return-Path: <linux-integrity+bounces-4177-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD29B9D4333
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Nov 2024 21:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4B62805FF
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Nov 2024 20:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2861BBBE8;
	Wed, 20 Nov 2024 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pzC8QRXd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F015C165EFA;
	Wed, 20 Nov 2024 20:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732135163; cv=none; b=n+8mTybOS5B4AoJ4nNz4360CszXGqa2lmBLAR/trTHG787JtrwsXFu00RvFOhU4ndAlSXVUjX6+dcI2OY9h1iQ9gNiuvzFcFrzFqlAMY8P5DhxFtUuarQ8onw13OyBpr8iQmBH/wfOoGmxTv4Qac47X1t+ndupoEspEciauBZXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732135163; c=relaxed/simple;
	bh=Tzn76we2GTFyNHZGWQiBFSyVYvershnmKtDGNW8elto=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kUGnjif6I8fOc8KDSja0k42g/OyAVs7BjFcB5doCBiTtcHuPzbISOVm3L0eKpIdtHiCmjz6uyi34nN9dVi7jFl4mXJSEb1eA1PKouLjOTHVhHhGALjG51DVogTFX3cJIx0rpuqNzgRXW9IBlHtPU9o2FizQWb/EHOUZLPECFink=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pzC8QRXd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKHS9Wk024342;
	Wed, 20 Nov 2024 20:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2j4aSP
	SVSBojoB4IzTo0vBEcDKUSurMXvDL4C4/c85A=; b=pzC8QRXd0YKDLFbHstGPD8
	EeugYdVOYkzobBBTDoByUMu/UcxaaB1xuU7eREv+Q8FdtIKVJr7GRZ5fdb90gW1j
	RL1lyog9pPCaYgrG4emNCiUhZQfSmY/GhdMC8hesdejBgpFrp8oBxd2DiTBAYgEV
	OpYfGb27JUFocqLt2sIw3Ga0vQeetT2zscR7ZASW5gYsCS8DbDRsh2rzJ34eEf0U
	qRz7nWlvfd9mVZeJ3kjwq2NCzHqkDcQXw5ru02+GKFteqfIUTTYaEBWkhjifEnlw
	yMt8/YWJ3OapBcvQQI91t1fAm/6EyFAwUBbLv7jIHtcnL7ENIO2pX6y8KtAZnSVQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xgttfekq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 20:38:49 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AKKcn8E016657;
	Wed, 20 Nov 2024 20:38:49 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xgttfekn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 20:38:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKJtJ7q025906;
	Wed, 20 Nov 2024 20:38:48 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y8e1f9yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 20:38:48 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AKKclHg50201296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 20:38:47 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A1025805A;
	Wed, 20 Nov 2024 20:38:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A7E358054;
	Wed, 20 Nov 2024 20:38:46 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Nov 2024 20:38:46 +0000 (GMT)
Message-ID: <5a315c98bcb8b900c8f4bac06fdfccec1308fcce.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: kexec: Add RCU read lock protection for
 ima_measurements list traversal
From: Mimi Zohar <zohar@linux.ibm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E.
 Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thiago Jung Bauermann
 <bauerman@linux.vnet.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        noodles@earth.li
Date: Wed, 20 Nov 2024 15:38:45 -0500
In-Reply-To: <Zz48LjTS_r-j9Qny@gmail.com>
References: <20241104-ima_rcu-v1-1-5157460c5907@debian.org>
	 <b89a084a98e7427911ac4344225eca99a04a52fb.camel@linux.ibm.com>
	 <Zz48LjTS_r-j9Qny@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZYB-crtMbPLlFFNlx3eNIRMKql0Hcf7X
X-Proofpoint-ORIG-GUID: UMzIkNF1mY9_Kzvnnbq9AuBVvpEJKJY6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411200143

On Wed, 2024-11-20 at 19:44 +0000, Breno Leitao wrote:
> Hello Mimi,
>=20
> On Tue, Nov 19, 2024 at 01:10:10PM -0500, Mimi Zohar wrote:
> > Hi Breno,
> >=20
> > On Mon, 2024-11-04 at 02:47 -0800, Breno Leitao wrote:
> > > Fix a potential RCU issue where ima_measurements list is traversed us=
ing
> > > list_for_each_entry_rcu() without proper RCU read lock protection. Th=
is
> > > caused warnings when CONFIG_PROVE_RCU was enabled:
> > >=20
> > >   security/integrity/ima/ima_kexec.c:40 RCU-list traversed in non-rea=
der section!!
> > >=20
> > > Add rcu_read_lock() before iterating over ima_measurements list to en=
sure
> > > proper RCU synchronization, consistent with other RCU list traversals=
 in
> > > the codebase.
> >=20
> > The synchronization is to prevent freeing of data while walking the RCU=
 list. In
> > this case, new measurements are only appended to the IMA measurement li=
st.  So
> > there shouldn't be an issue.
> >=20
> > The IMA measurement list is being copied during kexec "load", while oth=
er
> > processes are still running.  Depending on the IMA policy, the kexec "l=
oad",
> > itself, and these other processes may result in additional measurements=
, which
> > should be copied across kexec.  Adding the rcu_read_{lock, unlock} woul=
d
> > unnecessarily prevent them from being copied.
>=20
> Thank you for the detailed explanation. Since rcu_read_lock() operations =
are
> lightweight, I believe keeping them wouldn't impact performance significa=
ntly.

It's not a question of performance, but of missing measurements in the IMA
measurement list.

>=20
> However, if you prefer the lockless approach, I would suggest adding an
> argument to list_for_each_entry_rcu() to keep the warning out. What are
> your thoughts on this?

Yes, this is better.

thanks,

Mimi
>=20
> Author: Breno Leitao <leitao@debian.org>
> Date:   Mon Nov 4 02:26:45 2024 -0800
>=20
>     ima: kexec: silence RCU list traversal warning
>=20
>     The ima_measurements list is append-only and doesn't require rcu_read=
_lock()
>     protection. However, lockdep issues a warning when traversing RCU lis=
ts
>     without the read lock:
>=20
>       security/integrity/ima/ima_kexec.c:40 RCU-list traversed in non-rea=
der section!!
>=20
>     Fix this by using the lockless variant of list_for_each_entry_rcu() w=
ith
>     the last argument set to true. This tells the RCU subsystem that
>     traversing this append-only list without the read lock is intentional
>     and safe.
>=20
>     This change silences the lockdep warning while maintaining the correc=
t
>     semantics for the append-only list traversal.
>=20
>     Signed-off-by: Breno Leitao <leitao@debian.org>
>=20
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/=
ima_kexec.c
> index 52e00332defed..9d45f4d26f731 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -37,7 +37,8 @@ static int ima_dump_measurement_list(unsigned long *buf=
fer_size, void **buffer,
>=20
>  	memset(&khdr, 0, sizeof(khdr));
>  	khdr.version =3D 1;
> -	list_for_each_entry_rcu(qe, &ima_measurements, later) {
> +	/* This is an append-only list, no need to hold the RCU read lock */
> +	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
>  		if (file.count < file.size) {
>  			khdr.count++;
>  			ima_measurements_show(&file, qe);
>=20
>=20


