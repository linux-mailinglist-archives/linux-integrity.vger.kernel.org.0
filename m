Return-Path: <linux-integrity+bounces-5654-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26506A7F3A8
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 06:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0A5177560
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 04:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CE3205AD6;
	Tue,  8 Apr 2025 04:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o360SZ94"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B13435973;
	Tue,  8 Apr 2025 04:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744087081; cv=none; b=a4oqYqw3VzSbyf+QlQ23zeJwEz9FHn879SDxMgVqROt5PlUBi+zF4EKE/OV0If2XL2C3yUCq7ZzRMHiegL4CUznEPtl1CEJRtqPcfv5h3EZ27em/Aqrx7qr6lkilN3uWKQQp2QbjRogse2QqMcFctSpbhIq54z28bZTnlwJGluE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744087081; c=relaxed/simple;
	bh=RwwtO6VWJ58Zy3Fp8T7yb+bv3KPB5bJPxC6K6T2hwnc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s2O0x8qntpd739s6meRB92Nie72KdWAyLnGNlg9DWchJwYNoQEEZgkjy0kKRyS6IxcQ5ra++pfek/D2nETzlkrnkvRHWHpdoK2NtJ3yZxMye9FWTDl/TfCMLiqo18ZPtdX6931EEcTGQi3GENBa90UCo22U7gHBGr+DLGYiOdQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o360SZ94; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537MAIsc000417;
	Tue, 8 Apr 2025 04:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jJywaq
	rnmlK5U5SI9yto+vFRj86TY6JyAJ3Ep7jYLJ4=; b=o360SZ94vhQ3my70zmepWJ
	QmjXcFQ2mCm4GoSJFKEL/yayUdn02lrloiJi3eM+IcqcueGHz/liv4r2jGN2TGNs
	zth7LPvFYgamRnKev9mTgpSoBtQXblE7raBV9aq1W91RmHqEbeoty16NZ9VUl1sx
	APzKq9SN9+ZpuABcEu+N/Rk8f7gnDD8vpeIJYC4Gedbnk76NJBPbRdhSHFgNVkFL
	okOGxT9Q642l0eztsidi+mOdrCmHIA0QH7204IRXm/T1kcaAbymBzLPSNf/2K66I
	ZNOW1d+w27Dioiy4WfYdLKKWRUUPg1wNlFYO/J6nJLiGHZTNXmy7359tt9bVVr2w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ver7c3qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 04:37:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53845sJ8017457;
	Tue, 8 Apr 2025 04:37:32 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2kgumy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 04:37:32 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5384bV7L20775588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Apr 2025 04:37:31 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64F2358059;
	Tue,  8 Apr 2025 04:37:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82F5C58058;
	Tue,  8 Apr 2025 04:37:29 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.146.87])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Apr 2025 04:37:29 +0000 (GMT)
Message-ID: <9d1af6223f17ec0d99635bac7ca208226e5eb8d2.camel@linux.ibm.com>
Subject: Re: [PATCH v11 1/9] ima: rename variable the set_file "file" to
 "ima_kexec_file"
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
Date: Tue, 08 Apr 2025 00:37:29 -0400
In-Reply-To: <20250402124725.5601-2-chenste@linux.microsoft.com>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
	 <20250402124725.5601-2-chenste@linux.microsoft.com>
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
X-Proofpoint-ORIG-GUID: ZfBJAJSs4vOr0HlDsxMARqpGUmja_62D
X-Proofpoint-GUID: ZfBJAJSs4vOr0HlDsxMARqpGUmja_62D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_01,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 adultscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080030

Please fix the Subject line: change set_file -> seq_file

On Wed, 2025-04-02 at 05:47 -0700, steven chen wrote:
> The current kernel behavior is IMA measurements snapshot is taken at
> kexec 'load' and not at kexec 'execute'. IMA log is then carried
> over to the new kernel after kexec 'execute'. However, the time gap
> between kexec load and kexec reboot can be very long. During this
> time window, new events extended into TPM PCRs miss the chance
> to be carried over to the second kernel.
> =20
> To address the above, the following approach is proposed:
>   - Allocate the necessary buffer during the kexec load phase.
>   - Populate this buffer with the IMA measurements during
>     the kexec execute phase.
>=20
> In the current implementation, a local variable "file" of type seq_file
> is used in the API ima_dump_measurement_list() to store the IMA measureme=
nts
> to be carried over across kexec system call. To make this buffer accessib=
le
> at kexec 'execute' time, rename it to "ima_kexec_file" before making it
> a file variable to better reflect its purpose.

Only the reason for the variable name change is needed.  Please remove
everything else.

>=20
> Renaming the local variable "file" of type seq_file defined in the=20
> ima_dump_measurement_list function to "ima_kexec_file" will improve code
> readability and maintainability by making the variable's role more explic=
it.

As previously mentioned, there is a difference when naming local and file s=
tatic
global variables. Variable naming is described
https://www.kernel.org/doc/html/v4.10/process/coding-style.html#naming

-> Before making the local ima_dump_measurement_list() seq_file "file" vari=
able
file static global, rename it to ima_kexec_file.

thanks,

Mimi


