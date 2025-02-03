Return-Path: <linux-integrity+bounces-4688-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E83A25F2C
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Feb 2025 16:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92CD11884026
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Feb 2025 15:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FBE14F12D;
	Mon,  3 Feb 2025 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lNt2InHP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2108209677
	for <linux-integrity@vger.kernel.org>; Mon,  3 Feb 2025 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738597577; cv=none; b=DQz3ELqNu4OEPVkOfhnyiX5h5LOlpsYHPd1Dg5L10+CgxmvmMHehVBoqKD7zS+qwN+XffiULeLBVApg60aVXp4Y1PD+3nsrF7WAiTYGRBwScGNtyNNZzqqAcG3Hy8QPBOn8mkYPpVEIYHP2ovUsOBbAKvaQ/sIkvqvF9KEHYEfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738597577; c=relaxed/simple;
	bh=jfqYp336tgJfmanRiwA983qSFPBmw9Bio0gNkxBaUMQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I0YZw1003bbTSgOA0fDEB0J5KiCJSHqRtSO7NwKZsNz2lPEmaSft2iCv1nA4bMkDedRI0ohp2VbwF9+QBgGZst/lBpZ3KEbRMWwHz0G0wCtYWMHAWzikvx6Gl89Pzz005GuYCd6sua60C3Wd7EdvJnscxdGXN005J1Y+P604Bg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lNt2InHP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513F5NRj013659;
	Mon, 3 Feb 2025 15:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jfqYp3
	36tgJfmanRiwA983qSFPBmw9Bio0gNkxBaUMQ=; b=lNt2InHPrMZOy2ay8Kv094
	uH/MY0+K37BJ4v4hgBaiyu7M0S+kPZ7LEI1SAKoKuF2jYpKtRxLNhm5aO3ePrjfe
	4vu3fZUPcFwAe8NcBnRRnYvs2BUKNNkbBCiFwwPYrv4KjJ7XUSQBXnn20G+fhlUE
	CpZBNJygSJdf+CiV2UPgDPku27yxpZg/vePoqfJOX6bp/RN86fkXCdMzZCQrbPCG
	UQtBy5srQmqFIrOBHxCb8g5nNOJ1+9RBCZ0jPSAbpPjCgKkLg/FagGa4bLPj2dht
	8UprQ2bvn/0SjdKTNuk0ZbX2vMzyDFo17gLxi4jhu+nZjfY8vLyvzM5CvmH09UTw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jqm7avg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 15:46:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513DBEGg021483;
	Mon, 3 Feb 2025 15:46:08 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j0n16q3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 15:46:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 513Fk7FQ27460202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 15:46:08 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B848958063;
	Mon,  3 Feb 2025 15:46:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7216858052;
	Mon,  3 Feb 2025 15:46:07 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.83.5])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Feb 2025 15:46:07 +0000 (GMT)
Message-ID: <236770773858ed5e619f0a45ed8f2e103e5da9c8.camel@linux.ibm.com>
Subject: Re: [PATCH v3 02/10] IMA: Add TCB policy as an example for
 ima_measurements.sh
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Mon, 03 Feb 2025 10:46:07 -0500
In-Reply-To: <52d6a8c168215e6dafe567b37bf5ac65e3b300eb.camel@linux.ibm.com>
References: <20250114112915.610297-1-pvorel@suse.cz>
	 <20250114112915.610297-3-pvorel@suse.cz>
	 <52d6a8c168215e6dafe567b37bf5ac65e3b300eb.camel@linux.ibm.com>
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
X-Proofpoint-GUID: e-u09LBIrHWITJk6nsB14sQtQt0VvEBF
X-Proofpoint-ORIG-GUID: e-u09LBIrHWITJk6nsB14sQtQt0VvEBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=977 bulkscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030114


> > diff --git
> > a/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tc=
b.policy
> > b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tc=
b.policy
> > new file mode 100644
> > index 0000000000..1e4a932bf0
> > --- /dev/null
> > +++
> > b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tc=
b.policy
> > @@ -0,0 +1,20 @@
> > +dont_measure fsmagic=3D0x9fa0
> > +dont_measure fsmagic=3D0x62656572
> > +dont_measure fsmagic=3D0x64626720
> > +dont_measure fsmagic=3D0x1021994 func=3DFILE_CHECK

Petr, to avoid test failures datafiles/ima_policy/measure.policy should be =
similarly
constrained.

thanks,

Mimi

> > +dont_measure fsmagic=3D0x1cd1
> > +dont_measure fsmagic=3D0x42494e4d
> > +dont_measure fsmagic=3D0x73636673
> > +dont_measure fsmagic=3D0xf97cff8c
> > +dont_measure fsmagic=3D0x43415d53
> > +dont_measure fsmagic=3D0x27e0eb
> > +dont_measure fsmagic=3D0x63677270
> > +dont_measure fsmagic=3D0x6e736673
> > +dont_measure fsmagic=3D0xde5e81e4
> > +measure func=3DMMAP_CHECK mask=3DMAY_EXEC
> > +measure func=3DBPRM_CHECK mask=3DMAY_EXEC
> > +measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
> > +measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
> > +measure func=3DMODULE_CHECK
> > +measure func=3DFIRMWARE_CHECK
> > +measure func=3DPOLICY_CHECK
>=20
>=20


