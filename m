Return-Path: <linux-integrity+bounces-6155-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13B1AAD609
	for <lists+linux-integrity@lfdr.de>; Wed,  7 May 2025 08:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E129B7BA71B
	for <lists+linux-integrity@lfdr.de>; Wed,  7 May 2025 06:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B7720296C;
	Wed,  7 May 2025 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dSax7/gr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B381A841B;
	Wed,  7 May 2025 06:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746599144; cv=none; b=FQgtkUfz8NLDdM9NgDhiJsR9q/jsObScD4RTZuPK7BM6bplPT+XK1oso7k19899HEoJZR5M7uoPKRTGIhkGOLN6xbfb2zAusGEgzwfrmzYcFauw1PhbqnD11UI6evUV79lsoLbpSs4ucs490ptVQa6TX1NFrpwte9yxCwtVUpmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746599144; c=relaxed/simple;
	bh=kvwKtS+G6N6Uy2Tm3WYCdbWmcbnzZRJ/lMKMFb8zWso=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NJly1E1fTGCNJgXR1tfjzLzh5yNwXtefMzeaYbOjz80FtCd18Zf3xDsfAvIsHntitlL6p7m1mOt3KGiwkjFHRx1g0+kJ4v8bbNi2m+lGCmW7oyPF8jw/OWv2sHql9V3hyua2xgH/wpQOPm4mSvU+Oz2gjKETEn+9iqPjW14u7wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dSax7/gr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546J06iH011055;
	Wed, 7 May 2025 06:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1H2SKd
	w/CJ1oFZysP7AbA7rtWkaow9Z02aBk9jm2tJY=; b=dSax7/grc7WqB/w/bpL/qP
	srxnysIRxGGAAXDI6H07wewjbDmW9dQAKxo3hIx0sAJuRV4Y3UnGCqJTo0TGTh+E
	CSEx4GKSUi74QnnzVHwsttQdyRdXhKiL8GPcX/daPcm1e6gYwCycshMQGispPPPo
	Cuou3Vg4l+Ua0iF6+JtMrw1ue5LgVKtNzLH80ZHBo09C3DONozFyXjRJfWxxp0qw
	WFFAIhDbdC9B38s7KpNzdI9Se8DzWOJZVYBtM5pu6AyAERGdgfNKz2IB+6n/VwcM
	qqusOBll8cO+kIt09bxOjxi8Xwf7a0F9ilw9zWT5w4orqwJl1ZSsTzX2R/7xlUPw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fgvsmunb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 06:25:28 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5476M1Rq015839;
	Wed, 7 May 2025 06:25:27 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fgvsmun8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 06:25:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5475xk1u014583;
	Wed, 7 May 2025 06:25:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypkq40a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 06:25:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5476PPXP40436050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 May 2025 06:25:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69C4420082;
	Wed,  7 May 2025 06:04:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 011B520081;
	Wed,  7 May 2025 06:04:01 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.63.197.14])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 May 2025 06:04:00 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (haven.au.ibm.com [9.63.198.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 37A13600BB;
	Wed,  7 May 2025 16:03:57 +1000 (AEST)
Message-ID: <f950789abaad0e854c4e60c7316b675c712c386f.camel@linux.ibm.com>
Subject: Re: [PATCH 1/3] powerpc/pseries: Correct secvar format
 representation for static key management
From: Andrew Donnellan <ajd@linux.ibm.com>
To: Nayna Jain <nayna@linux.ibm.com>, Srish Srinivasan
 <ssrish@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org
Date: Wed, 07 May 2025 16:03:57 +1000
In-Reply-To: <3fe59767-954b-4c2c-a602-9801f1c1080a@linux.ibm.com>
References: <20250430090350.30023-1-ssrish@linux.ibm.com>
	 <20250430090350.30023-2-ssrish@linux.ibm.com>
	 <87e1185273ce21e5fd69ff071a1be986c2a0301a.camel@linux.ibm.com>
	 <3fe59767-954b-4c2c-a602-9801f1c1080a@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CLAqXQrD c=1 sm=1 tr=0 ts=681afcd8 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=VI1NQ0rgZN61wkHHH4kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QD1K8PZ3uYzMJ7kPAvcb9JP4VkJn7oLp
X-Proofpoint-ORIG-GUID: rztLrWR4sWMaBLVOXO8rmeAHuH-8u504
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDA1NSBTYWx0ZWRfX4xfKB8NZ6lMj ZtfYnsUNf0YlOGsCxzKwCSwj0/7ZlN3V0rIXgktRbJk96/zqTwFBQ7qJYF8HaIgiF/JLG/ZXHLP fwfAFfN8Egegx3Azq06LVxs0lFt5rN7e20WRWDH2PJ3ZltAxbeAfNv2yKK1Djc7/QOjuHCBDB+B
 5kjED0cI8vLL0DVSGP5e0sePnn0Zn4n8YUhQCUGXYqBadtJUHz05ns+OmaSiTCqwQ03cWzz3mbc ZSoHS2RpPBuOSbR0JXN5VxkSA0GXQMDRy3/p40WWRIyvVAp3fa6p/Thlb5JJUm6JYhz/shzMNMK CWAxRkmqguwkzSHnyNA11yoiZ5Opo5bHsCKgKXHCxg87TcMZPlcFirIXEg+1Ty4YPN7di82VJqJ
 DuXhzSc/Oz4AuIOl9chIMEvHa+o4omFhDcj61hplespwcl4lrvYa9iPXXvMWDUUCs9zOhGDl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_02,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=678 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070055

On Tue, 2025-05-06 at 15:27 -0400, Nayna Jain wrote:
>=20
> > It might be better to use something like "ibm,plpks-sb-static" in
> > place
> > of "ibm,plpks-sb-v0" to make it instantly clear that static mode
> > doesn't use the same version numbering scheme as dynamic mode.
>=20
> Yes, "ibm,plpks-sb-static" is more clear compared to "ibm,plpks-sb-
> v0".=C2=A0=20
> However, I am not sure why "static mode doesn't use the same version=20
> numbering scheme as dynamic mode". Infact, as per my understanding,=C2=A0
> it=20
> is part of same versioning system. "0 represent static, 1 represent=20
> dynamic and anything beyond 1 would mean dynamic with additional
> features".
>=20
> Also, wouldn't having "ibm,pkpks-sb-static" and then "ibm,pkpk-sb-v1"
> for dynamic would be bit confusing? I mean being static is clear, but
> what they relate v1 to? Or did you mean to have "ibm,plpks-sb-static"
> and "ibm,plpks-sb-dynamic"=C2=A0 for the two modes?
>=20

I don't feel strongly about this, as long as it's well documented.

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited

