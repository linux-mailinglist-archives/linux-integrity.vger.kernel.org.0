Return-Path: <linux-integrity+bounces-4165-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116F69D2E4F
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 19:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9FF9B3E39B
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 18:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4451D1E8E;
	Tue, 19 Nov 2024 18:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bybPnNME"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B81D0164;
	Tue, 19 Nov 2024 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039849; cv=none; b=MA9JQqQmwyIcaDkaLUkHVCYRHNvhvsuuV78iWa5akKYQRIm2KuJgufsIwTA8qUZmPwbz/wMfR1ss2jpEKaYkrRAuIqwXvYWDzgIkr5OmirnWJueSvbOE+K+vTk8dC4iIt+qRwhL2L0vyB9rTNdeSH5bHL7ScMj9VEvjUvHCy1LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039849; c=relaxed/simple;
	bh=00N6d3fq1vN0i91RXeimmFleEY7w+R+iFQQlmAiWUoA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uP3t5AGqSZ3kK/tbDRZlB0ryn87QM+AwRwwfT56UWIMzNpocTq0qAfp4G58pBigSGy3QQFtir7usaRfu2H5fLwLQQVv7M19i/YpGihX6x1BwOc9QAhM523nGYBQ9AQ43U9c6H3NtCduBynh/hc0iDtsWVd4l2QjpTaW/GLUzzus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bybPnNME; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJDMSXk016076;
	Tue, 19 Nov 2024 18:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rnZhD+
	ID/LMS+Nr00/1M7SEoYQBZvFHRkYGvYtfv7sU=; b=bybPnNME6w7s0KL23VRCD7
	sXDTCCRYeHe4jz1KMD9A7mc0Q3M8+i18R39AQ2h+YWztmLfjOKWneQasRwkoim8u
	AqnrOqMt4xmjk0UJ2BW1bQcscoaubE5fdo9DtBMp19pL9njbIddZ1MKRATclAH7A
	8p0UVyd3930ewr21caxY1cTXUhsdOqgIuoAqNIznP/d/SeirALkDVkNucUDXDM1m
	QS459xeBXHwHcTIGmLZ1iaIB++xlWeM7WBFbzPtbqCGw6w3AE45+3dI+e9Lt+zTA
	4WW2eZmxf/DUAy1QOrU/9ajX3sYGWso455PjQyEC7UHUdu1muZ3yZiGXqfepm86g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xhtjrshj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 18:10:14 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AJI6n8Z026354;
	Tue, 19 Nov 2024 18:10:13 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xhtjrshc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 18:10:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJBupUI021792;
	Tue, 19 Nov 2024 18:10:12 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y6qmw32f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 18:10:12 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AJIACnc59703638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 18:10:12 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09D2558052;
	Tue, 19 Nov 2024 18:10:12 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE7E158045;
	Tue, 19 Nov 2024 18:10:10 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Nov 2024 18:10:10 +0000 (GMT)
Message-ID: <b89a084a98e7427911ac4344225eca99a04a52fb.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: kexec: Add RCU read lock protection for
 ima_measurements list traversal
From: Mimi Zohar <zohar@linux.ibm.com>
To: Breno Leitao <leitao@debian.org>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        Thiago Jung Bauermann
 <bauerman@linux.vnet.ibm.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        noodles@earth.li
Date: Tue, 19 Nov 2024 13:10:10 -0500
In-Reply-To: <20241104-ima_rcu-v1-1-5157460c5907@debian.org>
References: <20241104-ima_rcu-v1-1-5157460c5907@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6KE2p3ayPT6aqwHI3JjzhenjP_Q-NCvb
X-Proofpoint-GUID: y5i2EbHVmUtOxXQb_GpwSFzEZjUWj1HC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411190134

Hi Breno,

On Mon, 2024-11-04 at 02:47 -0800, Breno Leitao wrote:
> Fix a potential RCU issue where ima_measurements list is traversed using
> list_for_each_entry_rcu() without proper RCU read lock protection. This
> caused warnings when CONFIG_PROVE_RCU was enabled:
>=20
>   security/integrity/ima/ima_kexec.c:40 RCU-list traversed in non-reader =
section!!
>=20
> Add rcu_read_lock() before iterating over ima_measurements list to ensure
> proper RCU synchronization, consistent with other RCU list traversals in
> the codebase.

The synchronization is to prevent freeing of data while walking the RCU lis=
t. In
this case, new measurements are only appended to the IMA measurement list. =
 So
there shouldn't be an issue.

The IMA measurement list is being copied during kexec "load", while other
processes are still running.  Depending on the IMA policy, the kexec "load"=
,
itself, and these other processes may result in additional measurements, wh=
ich
should be copied across kexec.  Adding the rcu_read_{lock, unlock} would
unnecessarily prevent them from being copied.

There have been discussions about deferring copying the IMA measurement lis=
t
from kexec "load" to later at "exec" and about trimming the IMA measurement
list.  At least for now, neither of these changes have been upstreamed.

Perhaps add a comment as a reminder as to why it is currently safe.

Mimi
=20
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: 7b8589cc29e7 ("ima: on soft reboot, save the measurement list")
> ---
>  security/integrity/ima/ima_kexec.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/=
ima_kexec.c
> index 52e00332defed39774c9e23e045f1377cfa30d0c..3b17ddb91d35ac806aedd2ee9=
70ff365675dac0b 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -37,6 +37,7 @@ static int ima_dump_measurement_list(unsigned long *buf=
fer_size, void **buffer,
> =20
>  	memset(&khdr, 0, sizeof(khdr));
>  	khdr.version =3D 1;
> +	rcu_read_lock();
>  	list_for_each_entry_rcu(qe, &ima_measurements, later) {
>  		if (file.count < file.size) {
>  			khdr.count++;
> @@ -46,6 +47,7 @@ static int ima_dump_measurement_list(unsigned long *buf=
fer_size, void **buffer,
>  			break;
>  		}
>  	}
> +	rcu_read_unlock();
> =20
>  	if (ret < 0)
>  		goto out;
>=20
> ---
> base-commit: f488649e40f8900d23b86afeab7d4b78c063d5d1
> change-id: 20241104-ima_rcu-ee83da87d050
>=20
> Best regards,


