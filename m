Return-Path: <linux-integrity+bounces-4498-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3B69FEC93
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Dec 2024 04:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B74573A04A4
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Dec 2024 03:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6467C13A41F;
	Tue, 31 Dec 2024 03:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UWm6AWcm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD07C42070
	for <linux-integrity@vger.kernel.org>; Tue, 31 Dec 2024 03:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735616628; cv=none; b=lJsTSbg9MI+wh3NXhQFRtMPrqyv+4PZjJEWfg54YhQrsl2aZ1aLpnXY6pBNXJybGhfYNC6q+BOi/Zb9IIcA/I8o/K3xdCLdzSBoomI11q7x+8jKjNyh5pB9LMcU+Ybqclw44KKy5QUDlBV4UmuTcyro6PDsOLYXHdHvS2+OaB8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735616628; c=relaxed/simple;
	bh=2x0ersSil89Ra/K2VpQX2shXFCQnQSiOwOj6FPEn0xk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CoXBmTt49ehb6SCFipZfgtiJdtlURMV/xeEvJ5FaTz9y3DCpy7zctKsTKU6OgzOjXde9BRI2iyBKAr6AhyXb5wgMy4p5ctOLOmiTSq92gJk5SjpLrwpDlMsIyw68qjo6lL+ETKS+HNYAVx+HeZ67hIahdlJPujk71L6uzwk4UNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UWm6AWcm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BUNwUY2024058;
	Tue, 31 Dec 2024 03:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YpKVFy
	GMBfIPOZWg4R8WEyPbBwaaIwFcma+92rf1Fsw=; b=UWm6AWcmnKXQJ5l+mI3Poi
	Los8ZedfjhiMFWfqj8AaSkUXWsucf1O22RrdMXxNMCYc/mhqDQW6zUxKSF6NJUpK
	7IthrOJkpv08nPW+A9CBuKlRBeeHp3srd6dCQUvsF3tp1kFJfN4DqWwE5Mp4KIXT
	6K3Qe51Bbdpe9dsSj1sRAuCAaNHpalrswAm4sNW1ta0djLIVddzNIGU8HIOsBZQe
	AMVNIBEp0117AZy7DxWKqYxUqri088sY2tTZ4UiYZlz7Gq19ajC6SNTL4Z9ktXch
	wSnVtTT/l8NYxS9DNkQmY8QIAClTGjuZCc36lwNwFc+yH+Hcq+5BDjBTOwOgvGUg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43v5nh8gwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Dec 2024 03:43:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BV0nbPv027055;
	Tue, 31 Dec 2024 03:43:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43txc1rd5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Dec 2024 03:43:39 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BV3hdSk30868046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Dec 2024 03:43:39 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 138DB5805A;
	Tue, 31 Dec 2024 03:43:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99C2F58054;
	Tue, 31 Dec 2024 03:43:38 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.96.225])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Dec 2024 03:43:38 +0000 (GMT)
Message-ID: <35af7de88f6961817a9df23c55104d20c32d2680.camel@linux.ibm.com>
Subject: Re: [PATCH v2 6/8] IMA: Add example policy for ima_violations.sh
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Mon, 30 Dec 2024 22:43:38 -0500
In-Reply-To: <20241213222014.1580991-7-pvorel@suse.cz>
References: <20241213222014.1580991-1-pvorel@suse.cz>
	 <20241213222014.1580991-7-pvorel@suse.cz>
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
X-Proofpoint-ORIG-GUID: tsqu5O78B3Ou64dEJdY-YoxMBY2hxBjD
X-Proofpoint-GUID: tsqu5O78B3Ou64dEJdY-YoxMBY2hxBjD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412310027

Hi Petr,

On Fri, 2024-12-13 at 23:20 +0100, Petr Vorel wrote:
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  .../integrity/ima/datafiles/ima_violations/violations.policy     | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima=
_violations/violations.policy
>=20
> diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_violat=
ions/violations.policy b/testcases/kernel/security/integrity/ima/datafiles/=
ima_violations/violations.policy
> new file mode 100644
> index 0000000000..5734c7617f
> --- /dev/null
> +++ b/testcases/kernel/security/integrity/ima/datafiles/ima_violations/vi=
olations.policy
> @@ -0,0 +1 @@
> +func=3DFILE_CHECK

"[PATCH v2 1/8] IMA: Add TCB policy as an example for ima_measurements.sh"
contains two rules to measure files opened by root on file open.

measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0

If the 'tcb' or equivalent policy is loaded, there is no need to load anoth=
er
policy rule.=20

Thanks,

Mimi

