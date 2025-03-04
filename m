Return-Path: <linux-integrity+bounces-5070-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08716A4E681
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 17:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0FE188741E
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 16:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD92823957E;
	Tue,  4 Mar 2025 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="enFC4w7i"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F42259CB4;
	Tue,  4 Mar 2025 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104946; cv=none; b=pwtYwCsgzj5FBwKsClWUal6gR5q8/JQIjEQcmzWJ9g2Q8GvGU6djEFbcT4LUEoShCOZPyl6iShSMEIsLdtqj5mtyc6XDnKirE0dmxRTSAPwD3vjfPF44o9wxhHZkYwPTZMGqj0R8Sv0eEiSLe0YVbASE01dWK+X/uU3ywkpm99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104946; c=relaxed/simple;
	bh=fIpTyWL6ayzFDuJIGBcstdA8O3+/QfyIGVuGPadTW0E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YfpZAMl2BAqFplRe6Rspvc2d+PP0Pr9tQco5jTzqxTzTJvkr4jrHNq2kvG/aUut445no4J6QIS3yg8b6YSI2EYnRWWrszlFRgTkwi1UUqHSUUS4DCW8pCuqC01Nm5AAmk3dd2O8Xy0btg/ebe5yWJFgwcOozEglN2Z3UK1Elzzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=enFC4w7i; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524E3Ku9019009;
	Tue, 4 Mar 2025 16:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+IoJ+2
	H9c2CFdb09znTxlwvThy3kn7nz7db1xHQkKkM=; b=enFC4w7iAxa7xBJJ50nn5r
	YHwcsrqCj91bKzXNDMt/lK3Da6qrxKeOdyw55vTS+5tSRh/LCW7VTHne1QB6PDCH
	E04yAMBr5R0IT1MIh+lsBn12jaenqDXOL0kCAMHHp2uTEbSNtevMf7+6e0dWDjb3
	0lY9UYLFpaVgOmnxytJ40rCGXSXuXH4TBYq/l7WJhu8JIKDqVnSBaTqC7YQ2TDxY
	0QahawjYm0acYxmOxim50YEc2M6BG6sI/rWcct/6OOuBbSKYvlDUKuuZPlrWfyX+
	nVpHiXi756zfn953xIufU7xfTR8gGUa/HI/Lm5pZABYEOnqa+UXBjLdlMmRhLMTg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4562xpgp2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 16:15:18 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 524GFI8F012989;
	Tue, 4 Mar 2025 16:15:18 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4562xpgp2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 16:15:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524Fxqlx013776;
	Tue, 4 Mar 2025 16:15:16 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kp52f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 16:15:16 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524GFGpZ53936398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 16:15:16 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4700E58060;
	Tue,  4 Mar 2025 16:15:16 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A27758050;
	Tue,  4 Mar 2025 16:15:14 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.136.132])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 16:15:14 +0000 (GMT)
Message-ID: <6828fbeeff42ce962cc0195466760ea136f9c049.camel@linux.ibm.com>
Subject: Re: [PATCH v8 2/7] kexec: define functions to map and unmap segments
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>
Cc: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
        dyoung@redhat.com, Mike Rapoport
 <mike.rapoport@gmail.com>
Date: Tue, 04 Mar 2025 11:15:13 -0500
In-Reply-To: <Z8FDlp8QvnSR58Vd@MiWiFi-R3L-srv>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
	 <20250218225502.747963-3-chenste@linux.microsoft.com>
	 <Z7wOPiDfy/vtrkCS@MiWiFi-R3L-srv>
	 <55acf768b52b47dd9d33fa0486772d8c7ae38779.camel@linux.ibm.com>
	 <Z8FDlp8QvnSR58Vd@MiWiFi-R3L-srv>
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
X-Proofpoint-ORIG-GUID: -oBsvbmbJu1H4kuwA-IK6n9CtSiRlunB
X-Proofpoint-GUID: _0Rk9JlUBxHxaloj8zlUADdSvGWN6oiI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_06,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503040129

On Fri, 2025-02-28 at 13:03 +0800, Baoquan He wrote:
> On 02/27/25 at 10:41am, Mimi Zohar wrote:
> > [Cc'ing Mike Rapoport]
> >=20
> > On Mon, 2025-02-24 at 14:14 +0800, Baoquan He wrote:
> > > Hi Steve, Mimi,
> > >=20
> > > On 02/18/25 at 02:54pm, steven chen wrote:
> > > > Currently, the mechanism to map and unmap segments to the kimage
> > > > structure is not available to the subsystems outside of kexec.  Thi=
s
> > > > functionality is needed when IMA is allocating the memory segments
> > > > during kexec 'load' operation.  Implement functions to map and unma=
p
> > > > segments to kimage.
> > >=20
> > > I am done with the whole patchset understanding. My concern is if thi=
s
> > > TPM PCRs content can be carried over through newly introduced KHO. I =
can
> > > see that these patchset doesn't introduce too much new code changes,
> > > while if many conponents need do this, kexec reboot will be patched a=
ll
> > > over its body and become ugly and hard to maintain.
> > >=20
> > > Please check Mike Rapoport's v4 patchset to see if IMA can register
> > > itself to KHO and do somthing during 2nd kernel init to restore those
> > > TPM PCRs content to make sure all measurement logs are read correctly=
.
> > > [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
> >=20
> > Hi Baoquan,
> >=20
> > I was hoping to look at Mike's patch set before responding, but perhaps=
 it is
> > better to respond earlier rather than later with my initial thoughts.
> >=20
> > The IMA measurement list isn't stored in contiguous memory, but has to =
be
> > marshalled before being carried across kexec, and then unmarshalled to =
restore
> > it after the kexec.  Roberto Sassu has been thinking about changing how=
 the IMA
> > measurement list is stored so marshalling/unmarshalling wouldn't be nec=
essary.=20
> > Making both this change and using KHO going forward would be a good ide=
a.
> >=20
> > However, that sort of change wouldn't be appropriate to backport.  So t=
he
> > question comes down to whether being unable to attest the measurement l=
ist,
> > because the measurements are copied too early at kexec load, but the TP=
M is
> > being extended through kexec exec, is considered a bug.  If that is the=
 case,
> > then I suggest finish cleaning up and upstreaming this patch set so tha=
t it
> > could be backported.
>=20
> Ah, I understand your concern. There are stable kernels or distros
> kernels which need be taken care of. If then, we can continue to work on
> polishing this patchset, as you have pointed out, there are still room
> in this patchset to improve before merging.

Thanks, Baoquan!

I've already provided feedback on the IMA related patches.  Hopefully that =
will
be it.

Mimi



