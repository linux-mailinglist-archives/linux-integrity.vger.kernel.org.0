Return-Path: <linux-integrity+bounces-6007-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2568A997C6
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Apr 2025 20:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667543B2D1D
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Apr 2025 18:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085CE28D853;
	Wed, 23 Apr 2025 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YIcrqmnP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EC8288C9A;
	Wed, 23 Apr 2025 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745432539; cv=none; b=nU0IBRkTbazHRlCuetOxbfZfQ3jIk0opplDcMVfPS2334PYWQNLnALiXqWWNVnGHZBCELCXDivzu76bNad9GKLxXTtoLOS3AlWZ4StQvjvx7Ae9NmX91S64l/JlRpCbLmP6bPYPeAhL0aB6HwY5k+nRy6xLUsTpV9/g2Co9PZuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745432539; c=relaxed/simple;
	bh=PWWju0lVKK/tapHVY9eYrl1sK2Ap+YQ8ODhkeluNm5o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tbezS8ogWr9v0TwqpkzIvI9wQkF2vbHuiN11SEscwYy75hTPdoH6HM9WIxoYBqzlGbERYSbxALK4XnoxZrR0Zb5LXe3hGxLhaUqSQ/SRuOpv2CeqV/lFwMia/WHjM7kRyEsq7YvELWcXVfOM91ZaM6LaPxjjwQq8cHSkYL30hks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YIcrqmnP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NFWbV4007064;
	Wed, 23 Apr 2025 18:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PWWju0
	lVKK/tapHVY9eYrl1sK2Ap+YQ8ODhkeluNm5o=; b=YIcrqmnPhBckVUR2GZ0zar
	vBrmDagpuzE3c3vtkrP/3AS9A3YKYRB6ThBNg/nS0TBrvUIa7znPvvmQlHMDsWtj
	PG2194ADUFFSJs19Ov4A3Zqvr5MXmNzjOhp8P8p6XtbDL63PvJH7aFzi2izGZvOu
	eavpRUQ9IBToSThhxDpxt/N95l4XQNBVoUDSFqczmpTL+/1qJubSYhsPCgIuzRcq
	5cHNh3KMiBnzmDxxJFbrPPlMOiVkPgiVIXaCvKqayafVXihWOmWPu8IOH+cYGVOd
	TJtHiHWxM6D/Cmz/xNuiIZGzxd6vAaJ5hjbqTA1/rMNfZPPAZwvkms1p+D723x4w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466psnv3bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 18:21:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53NEwVKq001305;
	Wed, 23 Apr 2025 18:21:47 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxvann-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 18:21:47 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53NILko323200312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 18:21:46 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8482058055;
	Wed, 23 Apr 2025 18:21:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E74A458063;
	Wed, 23 Apr 2025 18:21:44 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 18:21:44 +0000 (GMT)
Message-ID: <ce242647f121c90047b491fbe7305603dcfec6fd.camel@linux.ibm.com>
Subject: Re: [PATCH v13 3/9] kexec: define functions to map and unmap
 segments
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Wed, 23 Apr 2025 14:21:44 -0400
In-Reply-To: <99e18151-2866-4646-8532-3d10d63279b9@linux.microsoft.com>
References: <20250421222516.9830-1-chenste@linux.microsoft.com>
	 <20250421222516.9830-4-chenste@linux.microsoft.com>
	 <f2f4a873489b28d3baa4ac1f6073a49fe888d120.camel@linux.ibm.com>
	 <99e18151-2866-4646-8532-3d10d63279b9@linux.microsoft.com>
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
X-Proofpoint-GUID: H_6UjrJAn-ekq9km0DL4j7ghNYsSHKdm
X-Authority-Analysis: v=2.4 cv=BIezrEQG c=1 sm=1 tr=0 ts=68092fbc cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=D4UNMVMJWTiIgZffb2gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDEyNyBTYWx0ZWRfX6apwzi04KfUn D31XsCfRues7E9xY4+jvJThcr8o30g8jPw8EserUGcyB+lelLdo5Bd8b9gcRZ2W4buyC0Cw3Mf9 4g47DjR5t4cxrNDpAo3DS43MIScIwVqYKw52VEtQJoVspAT5Gz987DBQNLrOxejoniJXxzBH/zB
 XZQiJKUfnVr/aCIFGogwAbMNL5gPc/EEHcPNqe4ReRvj+Lc8wWboie68vsTrDUh1BilYCXasP/I wVAkK/5gt7pUQqP3l/He9O7g3lX96bkwktJODA+SBYFYYOPrJtfDhR23qhjau4Arn0quNseHhP0 ugRiJvGnO5VMSRDpfW10npIo0R7RsjYk/o6jt+WSOzNHkfmXgJQx2TMMg8ooHFoCk4sXQ1T5iBC
 0grY+/IKSbcowHvfoIqPBcFTX6HtWWIGj5OA7offpBmfY3lEXF9j2Nj7Q4NMi4bpAQgKti+E
X-Proofpoint-ORIG-GUID: H_6UjrJAn-ekq9km0DL4j7ghNYsSHKdm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_10,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=924 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230127

On Wed, 2025-04-23 at 08:29 -0700, steven chen wrote:
[ ... ]=20
>=20
> Hi Mimi,
>=20
> Could you help to add
> Tested-by tag for this patch set: "Tested-by: Stefan Berger=20
> <stefanb@linux.ibm.com> # ppc64/kvm"

Already done.

> Reviewed-by tags "Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>" to=
=20
> patch 1, 5, 6, 9.

I'm pretty sure that Stefan added his Reviewed-by tags to the entire patch =
set.
As soon as we hear back from him, I'll add his tags.

Mimi

>=20
> Thanks a lot.
>=20
> Hi Stefen,
>=20
> Thanks for your help all the time and sorry missing tags to show your wor=
k.
>=20
> Sorry again,
>=20
> Steven
>=20
>=20


