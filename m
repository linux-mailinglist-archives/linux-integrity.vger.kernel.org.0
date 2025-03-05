Return-Path: <linux-integrity+bounces-5113-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F35E7A4FE99
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 13:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA013AAD70
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 12:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386E6242939;
	Wed,  5 Mar 2025 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WwfjqxBS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847261EA7DB;
	Wed,  5 Mar 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741177695; cv=none; b=GC0MbJ83jPA6EKzr3HG8/366ge0Pl3jTEHEamHoSqXtAeHOuZxuOboqirX8i/YZ/nCD5ypgwgBmRjAl0EfoJPewK+4shSqO5/1/h07I+B99WDhHmI0R3bWaIYzNEtnfHycqKmVD0UMVEqMGhLaK2tDOpmM1lcUlseNrD5YDiebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741177695; c=relaxed/simple;
	bh=Y3/gEqSNTPTGDmKmgZmEHhOnQWViQQKthNK4JDKCRSQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ATKZfouSUT+oadLRoE09SICOVt3poxOzWclvtsxV14jqLI8reAEJnx5dVwx3zkdkZSUnpoakGxI7aUtiDht/QW4VW5uXyNKwMthS53fR1rziNW0x29CljYMxFHOdtMMLWVhZCUENQCRi/DxvnncJaoMsHegAkaMtqodAdJICiUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WwfjqxBS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525A7vNi014667;
	Wed, 5 Mar 2025 12:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Md/Snk
	5p9sNZnLIho40zGrrO+am14oZcFnJQ7JNna9U=; b=WwfjqxBS/+97sKDxCVYFlL
	vMdNh4h4lVwyIbj5kKBtpjCNMeXhrk72pvbnqZ6OnMSybU+uXjWG8UJ6EsO7AmDs
	ksy1w6VrSbVTrj6r/xT89Nc8uFK/K6vxNDVmZJedYzS+SbgvK1KtFkkcIPxcFH/e
	E9kfoVCHVsiX31puZKqy2m/cAWRx+WD/DvJvAMdO2Zr6J1ybevE//5+yW7ho2FtP
	A53oQdYkFik29+vIhVBUTKzh491xvxwKQLdBC8pTEjJYzJnm9QRBEduDHVlW/lRW
	GcDlTvfXnsj/bb7jzOs6L6jcShZJ5eQfo+7cPwIhlT5Nz4FE86GsdVZ2KQIMztbA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568r0kfdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 12:27:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5258mWB6020800;
	Wed, 5 Mar 2025 12:27:43 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esk2e2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 12:27:43 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 525CRhVQ33030860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 12:27:43 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 038685805F;
	Wed,  5 Mar 2025 12:27:43 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B05658053;
	Wed,  5 Mar 2025 12:27:41 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.124.31])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 12:27:41 +0000 (GMT)
Message-ID: <fe6e3c1333a50d66dc876b5a196d3491170802a8.camel@linux.ibm.com>
Subject: Re: [PATCH v9 1/7] ima: copy only complete measurement records
 across kexec
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>, steven chen <chenste@linux.microsoft.com>
Cc: stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
        roberto.sassu@huawei.com, eric.snowberg@oracle.com,
        ebiederm@xmission.com, paul@paul-moore.com, code@tyhicks.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Wed, 05 Mar 2025 07:27:40 -0500
In-Reply-To: <Z8g+uhZQ6totYLmp@MiWiFi-R3L-srv>
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
	 <20250304190351.96975-2-chenste@linux.microsoft.com>
	 <Z8g+uhZQ6totYLmp@MiWiFi-R3L-srv>
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
X-Proofpoint-GUID: UwpSgXRFf13zE8n_AFST4KQ1dLsi0RaD
X-Proofpoint-ORIG-GUID: UwpSgXRFf13zE8n_AFST4KQ1dLsi0RaD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_05,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503050099

On Wed, 2025-03-05 at 20:08 +0800, Baoquan He wrote:
> On 03/04/25 at 11:03am, steven chen wrote:
> > Carrying the IMA measurement list across kexec requires allocating a
> > buffer and copying the measurement records.  Separate allocating the
> > buffer and copying the measurement records into separate functions in
> > order to allocate the buffer at kexec 'load' and copy the measurements
> > at kexec 'execute'.
> >=20
> > This patch includes the following changes:
>=20
> I don't know why one patch need include so many changes. From below log,
> it should be split into separate patches. It may not need to make one
> patch to reflect one change, we should at least split and wrap several
> kind of changes to ease patch understanding and reviewing. My personal
> opinion.

Agreed, well explained.

Mimi

>=20
> >  - Refactor ima_dump_measurement_list() to move the memory allocation
> >    to a separate function ima_alloc_kexec_file_buf() which allocates
> >    buffer of size 'kexec_segment_size' at kexec 'load'.
> >  - Make the local variable ima_kexec_file in ima_dump_measurement_list(=
)
> >    a local static to the file, so that it can be accessed from=20
> >    ima_alloc_kexec_file_buf(). Compare actual memory required to ensure=
=20
> >    there is enough memory for the entire measurement record.
> >  - Copy only complete measurement records.
> >  - Make necessary changes to the function ima_add_kexec_buffer() to cal=
l
> >    the above two functions.
> >  - Compared the memory size allocated with memory size of the entire=
=20
> >    measurement record. Copy only complete measurement records if there=
=20
> >    is enough memory. If there is not enough memory, it will not copy
> >    any IMA measurement records, and this situation will result in a=20
> >    failure of remote attestation.
> >=20
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > Signed-off-by: steven chen <chenste@linux.microsoft.com>


