Return-Path: <linux-integrity+bounces-6188-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6AFAB540F
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 13:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F07E27AD343
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 11:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05A823F424;
	Tue, 13 May 2025 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PRDZ1dTH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D94171CD;
	Tue, 13 May 2025 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747136579; cv=none; b=bSjm92OsxTB7qn1VRnKCajxg8C80DDz4m4d4V7sk+oweZU2xl9/jgjh6cWnEHV23DhVhMR3JI+vgiJMQLak9MgqxTS4HkLHsbXc+X6sMxY0BGuy1JZQNfP4T1Gn+lG9Bzr3UT47eM0IQ5lEpy6Nn3xZNy4F2iQdkycgcuvKkgFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747136579; c=relaxed/simple;
	bh=BXZoTSb4aQ9Wtu3tuWW0AsAZj/p2yFulUCCm1/NKIK4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FphS+CwhQEfSVrYyAEOqhTE6KWhwuf/IvNoDTUHzAHERiYgrzx481rLbDJlp/pA/FIeRx1gF0dnSSuGThktWTHteuhc2rk7tqRM31e2qixwzZp6hclaIiGUUiAsdmj3rfLeP4T8j2oQveAa2str2s4k9JMmP505BkBep8VH4/pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PRDZ1dTH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D9F3c3029908;
	Tue, 13 May 2025 11:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BXZoTS
	b4aQ9Wtu3tuWW0AsAZj/p2yFulUCCm1/NKIK4=; b=PRDZ1dTHxB+wW2IKskFaxF
	9/KI6Bcgo61Y730i4lx2NzKw2qlWv3aSEFkpm9tI9z9Nu8d/2AhbmheqILG8fXmZ
	asUSCcajOoU4Lh5mMAc5yq+35Lk9ndTj4o79bTPyizG52bUuWfKodnsJ9bqzZZWH
	xiWkUwbrfwjc7YR/a1vONRV8C86OIPQl8DBYOTOnSOZGUXSigrQbT7hqf8eDNrdb
	U7x7MbT67jo0opM81yuwc2rl0QJvZxNQHADWutzBL1DoDzoptUTImzdP0sDxMED5
	JFuvA0NSoqIBfwmu/BO7nqMxj/5BmqO90BxlQbYwoBVGb0m14X5QRC2PlgCoajsA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46m39j8pba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 11:41:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54DB5Tv8024478;
	Tue, 13 May 2025 11:41:29 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jjmm2sdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 11:41:29 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54DBfTMp29033212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 11:41:29 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45F2858056;
	Tue, 13 May 2025 11:41:29 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 454AF58052;
	Tue, 13 May 2025 11:41:28 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.130.167])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 May 2025 11:41:28 +0000 (GMT)
Message-ID: <71973027bb0fbc436a95e8bb7fbd2b7d2eab95b4.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Kdump kernel doesn't need IMA to do integrity
 measurement
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com
Date: Tue, 13 May 2025 07:41:27 -0400
In-Reply-To: <20250502200337.6293-1-chenste@linux.microsoft.com>
References: <20250502200337.6293-1-chenste@linux.microsoft.com>
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
X-Proofpoint-GUID: iOEulkBYl26x9Ilz2fprraGsqD1yO4zT
X-Proofpoint-ORIG-GUID: iOEulkBYl26x9Ilz2fprraGsqD1yO4zT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDExMCBTYWx0ZWRfXx4Can8PSvMlx vUnHo5sK6RKQqOBsktYUfIOrlvFLhTo0GVAWEmx49wj6RQzhzdH27Nhp61/bXy1XXjWUG1KRDxb HtzJag6Q6I2wdLeL/qKd1sKBSvtY/Z5TUyPwI03klxn8Ofs7rVQblrSRLizGrCGE0rXmCg/LFSB
 A+1JZeQ/9u0uQD7xzHUphUeoM0Q3zidn21ttZTszqsd7qJ5mJL898Ipw2vUgGLjEjpJaElmwlFr mjAyeiKlH82/ixFANG4qGOpW3BhP7XaS2dEfDW6FwSz1fgV5BfmdTRAnlUMar1h1gPJO+YyeRny 35a1VF+qvOXRY60pgVF6rNpAE8sC3lcSf6oBH2rWl4+2tSTqzvIRMqTI4mQqJfg2RHUxd17pv+/
 oviUApI6smnWpZ9l4I2WM2gT5F4s6bhSGEpe8p9uTHfSy14+ivwSRqwLhxJtiVLkogVSQoNP
X-Authority-Analysis: v=2.4 cv=Sfb3duRu c=1 sm=1 tr=0 ts=68232fea cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=yMhMjlubAAAA:8 a=1v2mA-L8tnUgDz3cNWsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 impostorscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130110

Hi Steven,

On Fri, 2025-05-02 at 13:03 -0700, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
>=20
> Kdump kernel doesn't need IMA to do integrity measurement.
> Hence the measurement list in 1st kernel doesn't need to be copied to
> kdump kenrel.

^kernel

Please use "scripts/checkpatch.pl --codespell" to check for typos.

Mimi

>=20
> Here skip allocating buffer for measurement list copying if loading
> kdump kernel. Then there won't be the later handling related to
> ima_kexec_buffer.
>=20
> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>



