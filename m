Return-Path: <linux-integrity+bounces-5062-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FFDA4DEAB
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 14:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A467AA081
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 13:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE8120127D;
	Tue,  4 Mar 2025 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BKw/QOzl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F46442C
	for <linux-integrity@vger.kernel.org>; Tue,  4 Mar 2025 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093577; cv=none; b=pcu23OrJOCpQsIxEvAKJzLAuzSA/Qi3dBOkASml5f+u5bMcBXA9PtfmaWNUVT/Y23Go5khJd3hJD/52k3ravTlM1M5ItukcsR/UGFbLB3drTXUI3P5icw/mLJNnJ3eYTIVOvQU9xkhc8ZfoTx04Kt8E1/dUtH0QeAw0mEkRlplI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093577; c=relaxed/simple;
	bh=Lsz5QnwY9oQcpnDuh2Ov0XzWcMEPCJOrGrTu9Yv9+vU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G8MrhGI96d79dG7RCJ9Cv2D4cuc7VVN5Scyp0WsqWeLYurgKFv0urh3+FsBPZyYKYzH3ZSdPnpuUsxCPPkHqdYBmEzchcT1mbeVFXdCiGfaZOTj8O/wR+jkYJz9OSoS1f5q0PnJc0+UcP9Z4b5B75aaC/8EGeNJQwATegrs1CFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BKw/QOzl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249qUk4018564;
	Tue, 4 Mar 2025 13:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5NhgvE
	mB//JwLWrL4p9NVehytXsQmTIfoqR3DznckAw=; b=BKw/QOzlCIUUbi/j7Z5X7L
	p8kjlE35oZ/jBgpLkHkkU1GAgAMAsfH1UHGktnsD2eqteNjIlE/PJLnDcPHpjcoj
	H/2TF52BdvXC+1j7sVBJfVQWcTiJvv7r75/HsKmDGHPwOxbSKIvNF5gF6Gbk/+Wo
	rI2Zy4qxuH+emtWj2F8r5XMWlX5milKNOD43nP2BNOpYQhJ89yS5nyGNlHOMPdDt
	hGkzhKYBzlJDD617h/F3KxLqnQ3vGDRybGl5OkkV5u/y7tTsIhRz5mGod0hr/gwO
	l0fQ2P5bWPLZFrVkckDYSNWzCbj8fuVv3aIpkeg8ftvQ+w12zE4vLmZV98HK6z9w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455kmyky3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 13:06:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524AkFkb032216;
	Tue, 4 Mar 2025 13:06:08 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjswpck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 13:06:08 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524D67o420906696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 13:06:07 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D51C58059;
	Tue,  4 Mar 2025 13:06:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACFCA58043;
	Tue,  4 Mar 2025 13:06:06 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.57.16])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 13:06:06 +0000 (GMT)
Message-ID: <30769565910b3198fa8d714b5edb25419fcb1457.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] ima_violations.sh: force $LOG ToMToU violation
 earlier
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Date: Tue, 04 Mar 2025 08:06:06 -0500
In-Reply-To: <20250304125749.GA81126@pevik>
References: <20250304115331.524842-1-zohar@linux.ibm.com>
	 <20250304125749.GA81126@pevik>
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
X-Proofpoint-ORIG-GUID: _8Zetb3FGGs-Lk1GJLKif6CTulfkSx2O
X-Proofpoint-GUID: _8Zetb3FGGs-Lk1GJLKif6CTulfkSx2O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=954
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040106

On Tue, 2025-03-04 at 13:57 +0100, Petr Vorel wrote:
> Hi Mimi,
>=20
> > Violation tests are dependent on searching the $LOG file, which may
> > itself result in a ToMToU violation.  Preempt getting an additional
> > violation during the tests by forcing the $LOG ToMToU violation
> > earlier.
>=20
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  testcases/kernel/security/integrity/ima/tests/ima_violations.sh | 1 +
> >  1 file changed, 1 insertion(+)
>=20
> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violatio=
ns.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> > index 37d8d473c..22863fb72 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> > @@ -30,6 +30,7 @@ setup()
> >  	if [ ! -e "$LOG" ]; then
> >  		tst_brk TCONF "log file not found, install auditd"
> >  	fi
> > +	exec 3< $LOG || tst_brk TBROK "failed to read log file"
> >  	tst_res TINFO "using log $LOG"
>=20
> If you don't mind, I would reverse the order to get info about which log =
is
> used:
>=20
> 	tst_res TINFO "using log $LOG"
> 	exec 3< $LOG || tst_brk TBROK "failed to read log file"

Oh, I see what you mean.  All of the TINFO come first and then an error, if
there is one.  That's fine.

>=20
> Or, if it's needed to for some reason to run it before (no idea why, but =
I might
> miss something), I would merge it as:
>=20
> 	exec 3< $LOG || tst_brk TBROK "failed to read $LOG"
> 	tst_res TINFO "using log $LOG"
>=20
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

thanks,

Mimi


