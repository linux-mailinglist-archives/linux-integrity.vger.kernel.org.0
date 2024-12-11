Return-Path: <linux-integrity+bounces-4349-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AD89ECC0E
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 13:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E0D2831F4
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 12:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1277226186;
	Wed, 11 Dec 2024 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LTs51K+S"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5251D225A44
	for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920004; cv=none; b=e0rDFURuzStw2hd6cvbumC8v0ZEy8rqJkSrW2cilxZJFT8ZbtPRBsK1YoO2cBDN2LOnTPRcR6/ekTeLabuFuinKjJQx1xD//9jrpFXqOyeValzwq+JSZt7i2717Bn/H0nXXAVIrq2RGpAq8hV/LZ2jgbdKBpXgYT1olTpTIYFpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920004; c=relaxed/simple;
	bh=bOg7EMg9awgx4SVOOcVHSkbKpQHPMoQZaNDzCA8tnRU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sCbTgtHFUsRi4bLJKKapEk/GD7OhgUtBRYOSmElVpjMed1ixkkwN/hkaJMzxLtTKaYe2/ioR85489B9DhgSqtDhYGTPHpGI8Gtnnik1gYVUHbZxyG6xCH4PvQaLiHOw8fk6Wvhrk8mifqtMcVBEUGdHTgZbbHr9xccLNmEBVFNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LTs51K+S; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBB5ihV008120;
	Wed, 11 Dec 2024 12:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=98ILy9
	FXd3s+YnzM+DjxOSnqwZtrFBOsdam8JBqVAsE=; b=LTs51K+Shqf084UQG1lr8D
	zFhZw0FRr1nI3fS2maNDWy1YfVma068yudfi0SJQfItrAk20Bo95Xu8yvWwWU0Hw
	VhOooNMeqxh2uM+fK0cIbG9As9XJVTYuoxNflniLFgF+IZjGkjDBidtzLg1Lhr5R
	TCW9eedNvCj5NoLBU7u80+lF5bI2k8N7IpN7+213M+Hld34vkLBakqrG9aT00SNW
	SRhXrOWydsQ782mJXIpC2V1DsJeT1O7NZzsVkLDN36IKa5/tK3j8TspLiBLCDEBP
	s1/koERYYci2joZgCNFcbwWgoqkhK/iP3CN93AyMSr4mqY+XcfMMqbuQJvjZKHag
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8w6g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 12:26:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBBRGI6017376;
	Wed, 11 Dec 2024 12:26:35 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d3d1s0x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 12:26:35 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BBCQYbo23790194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 12:26:35 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C05AD58053;
	Wed, 11 Dec 2024 12:26:34 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D1C658059;
	Wed, 11 Dec 2024 12:26:34 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.71.1])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 12:26:34 +0000 (GMT)
Message-ID: <007bb56c0ed893e6b53d31efee1276e7bb91a557.camel@linux.ibm.com>
Subject: Re: [PATCH 1/3] ima: Add TCB policy as an example
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Wed, 11 Dec 2024 07:26:33 -0500
In-Reply-To: <20241126173830.98960-2-pvorel@suse.cz>
References: <20241126173830.98960-1-pvorel@suse.cz>
	 <20241126173830.98960-2-pvorel@suse.cz>
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
X-Proofpoint-GUID: dTMCDa90AAR0I-w2CcqThRvscFCvOcc3
X-Proofpoint-ORIG-GUID: dTMCDa90AAR0I-w2CcqThRvscFCvOcc3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110087

Hi Petr,

On Tue, 2024-11-26 at 18:38 +0100, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Except for the "dont_measure <tmpfs>" rule, the "dont_measure" rules are fo=
r
pseudo filesystems.  Including a "dont_measure <tmpfs>" policy rule was sup=
pose
to be limited to the initramfs, and then replaced with an IMA custom policy=
. I
would either re-order the rules so that the "dont_measure" rules are only b=
efore
the two "func=3DFILE_CHECK" rules or perhaps remove the "dont_measure <tmpf=
s>"
policy rule.  The kernel builtin "tcb" policy should be updated as describe=
d
below.

> ---
>  .../ima/datafiles/ima_measurements/tcb.policy | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima=
_measurements/tcb.policy
>=20
> diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_measur=
ements/tcb.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_m=
easurements/tcb.policy
> new file mode 100644
> index 0000000000..280e6af87c
> --- /dev/null
> +++ b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/=
tcb.policy
> @@ -0,0 +1,20 @@
> +dont_measure fsmagic=3D0x9fa0
> +dont_measure fsmagic=3D0x62656572
> +dont_measure fsmagic=3D0x64626720
> +dont_measure fsmagic=3D0x1021994
> +dont_measure fsmagic=3D0x1cd1
> +dont_measure fsmagic=3D0x42494e4d
> +dont_measure fsmagic=3D0x73636673
> +dont_measure fsmagic=3D0xf97cff8c
> +dont_measure fsmagic=3D0x43415d53
> +dont_measure fsmagic=3D0x27e0eb
> +dont_measure fsmagic=3D0x63677270
> +dont_measure fsmagic=3D0x6e736673
> +dont_measure fsmagic=3D0xde5e81e4

Limit the affect of "dont_measure" rules to just the "func=3DFILE_CHECK" ru=
les, by
moving them to before the "func=3DFILE_CHECK" rules.

> +measure func=3DMMAP_CHECK mask=3DMAY_EXEC
> +measure func=3DBPRM_CHECK mask=3DMAY_EXEC
> +measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
> +measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0

Move above two "func=3DFILE_CHECK" rules to the end.

> +measure func=3DMODULE_CHECK
> +measure func=3DFIRMWARE_CHECK
> +measure func=3DPOLICY_CHECK

thanks,

Mimi

