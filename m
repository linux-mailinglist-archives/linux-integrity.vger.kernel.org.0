Return-Path: <linux-integrity+bounces-9681-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLa3LxerFWpuXgcAu9opvQ
	(envelope-from <linux-integrity+bounces-9681-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 16:15:51 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD11A5D7453
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 16:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD38230136E5
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 14:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1AD3FE35A;
	Tue, 26 May 2026 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IyPDDu/L"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3747837B415;
	Tue, 26 May 2026 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804636; cv=none; b=Vatev2CvvbQ2kGjltjLIGB/7zihIkV8guGT6kcyQayKRkjZGb8eSY1itW8GFpC/WQGcA+y6kIvYSOeRItEjHXTNc6bW6Jk0AmyKja4Xn8U0lJTymSDQgpfAlB5NQa+l4IGdG4zixN9UyuuhVQA8Tjy6asFFl+JbGoV7srrSs6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804636; c=relaxed/simple;
	bh=mf1IOQWlnc6zQF6HWyGaFflc/mPXBki32bUROyZWCXU=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=a3vtcvYYu8u1XfyXUqp7GaXsD4Inmiemlre/7qkCVZzXamJa0pfQrkQ8EzT3WKq12CW61o2l5Qzl6JU5TlvwYGtT/6y0de9rTL7s9JrOEja0x5QYiFo0G+NY2ZdWmU3nqPyqNmegf3PPfEgcHcksFZ4vXKYdhoNgqLUtNgnCWas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IyPDDu/L; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QAvgeb829592;
	Tue, 26 May 2026 14:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WMj1wY
	0Czpl5GreJRKqAJyIGPNYvsrXhwZAqrMmKMPA=; b=IyPDDu/LXD6VI5O/XUYiH9
	TySDdeItbSRcKEnpBTkK1kZwgymbl7rnOkuEGUQAv2b/ksA0bNJ/x3tuBJaFstwn
	Q2+B0Vs7x6EH3yuZEaA5qHClhG4r3PkLITon05E0J7+aLcX+JABg7HkFmRRNGsaW
	YfyoTcB9lCA27lBjJ3XiyHl9NJcqxyidveBEECZRlZqeRF2a8D4yJK79HEiQloVq
	MT0RfxDKBqLXX/6B5u7Eg+ZJBP3WEHAlS+kwOG1loqEMvMrNj4gWZwujCmZckHXd
	04ss/7rlexJtr8FoKCVoBKMmsfOEZKipRqQlgO+SuZjU9iAjHFk1TWAdCLYCVvQA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4numj88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 14:10:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64QE95nH027609;
	Tue, 26 May 2026 14:10:11 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ebrsg9f4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 14:10:10 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64QEAAWT30147250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 14:10:10 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F96C58050;
	Tue, 26 May 2026 14:10:10 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE5975805E;
	Tue, 26 May 2026 14:10:08 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.63.240])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 May 2026 14:10:08 +0000 (GMT)
Message-ID: <1d32dca26bec72bcfdc326359a17edfeb65b0a3f.camel@linux.ibm.com>
Subject: Re: [PATCH v5 00/13] ima: Introduce staging mechanism
From: Mimi Zohar <zohar@linux.ibm.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        steven chen	
 <chenste@linux.microsoft.com>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com,
        Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <aaed52cf-26e1-4c40-812d-3788024ce5b5@linux.microsoft.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
	 <99c30be6-8b0f-486a-890c-cf74c5930726@linux.microsoft.com>
	 <aaed52cf-26e1-4c40-812d-3788024ce5b5@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 10:10:08 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyMSBTYWx0ZWRfXyXXNfOjAxKsS
 gZp588DcnO5iV3mAzQfRZwRsA404TwNt000/t3mgOLc1FUlXU7CpV3cEdEgqnoprztvchJrqw1c
 Gu7Cj9KqMbVbuZYxzI0BPykmnilk/TpYCIOVf2/Tggp7qQN8crTruCt/DJ9xLT7paN2xHhwJtZT
 pxyWgSSWa/BNWj/qARCZr7cfFayDY3vHGnRV0bJcjvggO/ZQETApSHOsGCq00t/Tkl0RuY/DZfq
 S1I7xP6ouAAfHgil+wPYgMXtCKF5Gt+i3jH0cvSs4xcq/Upd6z++iM15En403H9JpzOI2RCpSU7
 tBnMMMRM9fpH0bOmpEMnKz6MRHhId9Ttdbg7MlOc3K6Ewu1OtdWRT9nQVBiYWafxLZzi+CJiFt2
 rL0PTXreKHje4pvqpo+g9XcervDHXicALfW8siAzECANrWqqK805Lzc7FCiAHgdrvFmYkAbPFXB
 oepEpZ4gVOtM8QDFzNw==
X-Authority-Analysis: v=2.4 cv=UtJT8ewB c=1 sm=1 tr=0 ts=6a15a9c4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=kPIizgvigglXtppSoNsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mMfsEd4qTK_7e7dHtnDYd7lPKgGQUPYO
X-Proofpoint-GUID: Y6nRJVe9UEGzdMXZoqjiPx922OgtK00S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260121
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9681-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[linux.microsoft.com,huaweicloud.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: CD11A5D7453
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-05-11 at 10:29 -0700, Lakshmi Ramasubramanian wrote:
> Roberto, Mimi:
>=20
> I want to add on to the point Steven has brought up.
>=20
> With "Stage and Delete N" approach, we have the following sequence of=20
> tasks for trimming the IMA log:
>=20
> 	1. User mode locks the IMA measurement list through the "write interface=
".
> 		a. While this prevents any other user mode process from updating the=
=20
> IMA log, kernel can still add new IMA events to the measurement log
> 	2. User mode reads the TPM Quote and the IMA measurement events and=20
> sends it to the remote attestation service
> 	3. Once the remote service has successfully processed the IMA events,=
=20
> the user mode determines the number of IMA events "N" to be removed from=
=20
> the measurement list maintained in the kernel
> 	4. User mode provides the value "N" to the kernel
> 	5. Kernel now determines the point at which to snap the IMA measurement=
=20
> list using "N" - without holding a lock
> 	6. Then, the kernel lock is held and the list is snapped at the point=
=20
> determined in the previous step thus keeping the kernel lock time to the=
=20
> minimum.
> 	7. Now, user mode removes the "write" lock on the IMA measurement list
>=20
> With the above, we believe "Stage and Delete N" alone is sufficient to=
=20
> trim IMA log.

Prior versions of removing measurement records (aka "trimming") were reject=
ed
for being overly complicated, locking, requiring a new record type, and cod=
e
quality.  Patch 11 ("stage and delete N") is much better, but the level of
precision in removing only those measurements records needed for the TPM qu=
ote
seems necessary only if the records are not being saved.

The reason for the two methods might be the same =E2=80=94 removing measure=
ment records
from the IMA measurement list =E2=80=94 but the motivation for the two meth=
ods does not
appear to be the same. The motivation for Patch 9 ("stage and delete") is
clearly to free kernel memory by exporting and saving the measurement recor=
ds.

Remember, the only reason for upstreaming a feature to remove measurement
records from the IMA measurement list is to address the kernel memory issue=
 =E2=80=94
clearly not to drop measurement records and break attestation.

Upstreaming patch 11 (stage and delete N) would be a concession for your
environment, but is definitely not the recommended solution.

Mimi

