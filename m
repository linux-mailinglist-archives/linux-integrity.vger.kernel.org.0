Return-Path: <linux-integrity+bounces-7174-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA69B8631C
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 19:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806EC188E4E6
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 17:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0463265CAB;
	Thu, 18 Sep 2025 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r22YuGnp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D649A264A72;
	Thu, 18 Sep 2025 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216234; cv=none; b=dBm/H6ayQJCK4lYr1ehTvYMqq6ac4NQOkksXd4s6BpslpF9zy64LTfPW4C7RAw/5C5Ai07Z2Wq+Ie3PTZCzYwupJAOCEXX6z4RBChFCcrdEo5ZtmkDnaHljatnkdQ4u7VXpaO+u531qsY4GSI9gv9a9mKu2IR/Z+6A+V9i6sNIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216234; c=relaxed/simple;
	bh=Nf7dNiF43W8KUqsLZiqy4+fTyKDxTCAcaKg7fwxMtLk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=mm1T980Sx9u/MPmGRtByLfcxW5CRMfjtXB5ugIjUDM7NRoN3iNFaQNuMIfzdzTSw17wxeqSxRxM/p7+bIVkxoPVrtBS/lsC2JpJXtdIo2oXHDg+Ghi3P6CUb+PU5kGvtIguIqgz1lNGDHNxl2ZWH+Zg3E6Q0Bw+hdBbySdnZvBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r22YuGnp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IDtNIO023783;
	Thu, 18 Sep 2025 17:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Nf7dNi
	F43W8KUqsLZiqy4+fTyKDxTCAcaKg7fwxMtLk=; b=r22YuGnpwsVxBch/UYigQq
	jitCKzaq27AmcCA7Fe4wwjyoGE54wP75e4e6tJlPVciZo2b20rtjbVvwINE7j9kc
	xUH5orZEJ1++6flxudx8HKKLA3H5TPARORi2joXqfG8T1DNw0gae/oi4B8GM+6LZ
	Y3aZ7clm+SZTlFpZNSqgZJ8vbgpC/SMLf0nzOjOYDHhaWCvip7bF5ceTta7/ctCa
	kE5naQIrkmtJ456U/WPDdFNc5V9Nr9TDSUY4vlJTscG6YC7N5dxmpNLB+aHAKXC/
	A8v4DIImqOcysV/M+oC6JeX3yl/Pzak2sW8zuSE3qflOsZ+B3RvVrv4imO8tCqqg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4quae4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 17:22:50 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IHMngr008366;
	Thu, 18 Sep 2025 17:22:49 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4quae2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 17:22:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IGGEtT005981;
	Thu, 18 Sep 2025 17:22:48 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxug458-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 17:22:48 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IHMm1823397114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 17:22:48 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1348B58063;
	Thu, 18 Sep 2025 17:22:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 420BF58061;
	Thu, 18 Sep 2025 17:22:47 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 17:22:47 +0000 (GMT)
Message-ID: <2bde04515347e50b00026754764c76c2998dff28.camel@linux.ibm.com>
Subject: Re: [PATCH v4 22/34] lsm: group lsm_order_parse() with the other
 lsm_order_*() functions
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
In-Reply-To: <20250916220355.252592-58-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-58-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Sep 2025 13:22:46 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wV7C2xoEkaZPhBE-EJEqo9sSYIg7_JbB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXyPBNQQ4XfbiW
 QUlcjJoWkH/A/viOq0SiEpxpKLC4c7C30Ji7OkO8LpvQW4OViJ9WCgqqFmiCMGbKD21cP1xsa7r
 2tw1a09URdv/jBkT7Ryia0ICXF4wLQKuB1k7aMQVCBPfcWf9evo2PUPGw1iYvrUoDz+7KZInzFf
 eVqgOINd0aAx2Z2IxcY/X8jx+dGKTqJNiffXxy2TXXM6dbBAlOc/cyuj1euFeVxzXzX/l0rrKwD
 zy0gkO8G3Wc0PvJwjGVt8viG3yTuEH0kLT4Pg6eg/3ruLAB+jGfO+mIAtFL1zZfzBiFCk8LYrLy
 v1Wy277PdmqRHsIQTlKiXLscpckx+jIyMks1Shiia0ZIJoMvCh1kN0Rib2soiT+J5evuaXF/VrV
 6m1Q8wtQ
X-Authority-Analysis: v=2.4 cv=R8oDGcRX c=1 sm=1 tr=0 ts=68cc3fea cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vpqfxihKAAAA:8 a=DfNHnWVPAAAA:8
 a=xVhDTqbCAAAA:8 a=VnNF1IyMAAAA:8 a=jeTWaIcxhKW1VuSt1_MA:9 a=QEXdDO2ut3YA:10
 a=AULIiLoY-XQsE5F6gcqX:22 a=rjTVMONInIDnV1a_A2c_:22 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-GUID: ZUkc37i-X5viiXUHlPSVrfxjELcQbhnw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> Move the lsm_order_parse() function near the other lsm_order_*()
> functions to improve readability.
>=20
> No code changes.
>=20
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johhansen@canonical.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

