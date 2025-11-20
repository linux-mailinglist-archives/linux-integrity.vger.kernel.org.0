Return-Path: <linux-integrity+bounces-7652-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB273C76908
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Nov 2025 23:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4783635755D
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Nov 2025 22:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1D6274669;
	Thu, 20 Nov 2025 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DAYH/jnb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C8B2D5957;
	Thu, 20 Nov 2025 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763679540; cv=none; b=JeHGdJ5jjVbFECb+RzgDAh72dcwhLLbGcU0xw0h05ju+KT0gypax/FYIJyz/TEV5s3tU/JhkWwnDWm4ri+ojjFsSG8h8XrfpBhQ7V1f1wpql9U5SE9It+B/BcKVJGsxR3Ub071tNNzJ51wXjnwKAEfiVP9P1BijTQDvpN0qhjH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763679540; c=relaxed/simple;
	bh=6varjGVoghbrxaJNTd9/vs6UCISW7yj5NXv8Kb8iGcA=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=VExZMbfnG2s3X/q0Di2jiAmlU0JOA4uy4RbBYI/teIg2zIsk66OWMyBkAu50rHLCVaazOQISJjabk2QcG6Tugaf9qBbcOTq5nODlmzkCDDMvYn03N3tdVKJD9+8iEDkIbSJyXtVwZbVkQHbWrnC4JlN75slSAuD6mceRmaQ8ehc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DAYH/jnb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKCdFYA008180;
	Thu, 20 Nov 2025 22:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=X8ESIu
	xGa0urWInKm/jtDHCZjCajdpBZ+uDD8wnQTg4=; b=DAYH/jnbRGKje5HiUigWfe
	sUwDwRWQv7rM9rei4G6SuTDZ2rJFbDET4FOxcErH3+ORJlFZQUcWztlg4nn7AYb1
	ypIqlVEMhKt7TmxODDn+PkWkuyRMqBa5D/6HsPPDyPXIVME+9v9pH+s3ZsUNratf
	CWvdo+bhkKBNTNVocQ6cLPwwkuSPVDCFHv6BMFZQbr+13re7MnrtKsnlQXvafJcU
	4QxpUqEIwCTwocCce+AREBT/roI7dGv0Be/kfT+4jIGJJnh/+dhXvQRR1G1FNQdd
	s+vs33jKiG7sLrKX22Om5A2ExMATIpQWzIMu8C1qelNVVf4g6+S8+K3Qejoh72xA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmsym68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 22:58:45 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AKMpF0p013951;
	Thu, 20 Nov 2025 22:58:44 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmsym65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 22:58:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKKufLi017319;
	Thu, 20 Nov 2025 22:58:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af6j20uaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 22:58:43 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AKMwhp725821894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 22:58:43 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AB235805D;
	Thu, 20 Nov 2025 22:58:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5754258052;
	Thu, 20 Nov 2025 22:58:42 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Nov 2025 22:58:42 +0000 (GMT)
Message-ID: <629289c119a1a71d8d7a1208ec3676e006d4d527.camel@linux.ibm.com>
Subject: Re: [RFC v1 0/1] Implement IMA Event Log Trimming
From: Mimi Zohar <zohar@linux.ibm.com>
To: Anirudh Venkataramanan <anirudhve@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin	
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E .
 Hallyn"	 <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Steven
 Chen	 <chenste@linux.microsoft.com>,
        Gregory Lumen
 <gregorylumen@linux.microsoft.com>,
        Lakshmi Ramasubramanian
 <nramas@linux.microsoft.com>,
        Sush Shringarputale
 <sushring@linux.microsoft.com>
In-Reply-To: <20251119213359.39397-1-anirudhve@linux.microsoft.com>
References: <20251119213359.39397-1-anirudhve@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Nov 2025 17:58:41 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ITM2na6PgFhDrri4SEYnAYiHq9Hs-drS
X-Authority-Analysis: v=2.4 cv=Rv3I7SmK c=1 sm=1 tr=0 ts=691f9d25 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CL4gKq6V0-V22j3Sb8oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rMqzK7i88w7fsMUXseNT49kMFkZQffkB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX0z+UvLXbqoZV
 X3JIH7hqM3G6B54iM3Bhwa94PimxPKKSpqM2YspiTx5t/x9wLACMXRIzOg0cImK2uKwgGWUw/9O
 ALkYX/REeoKPCi+/bOOA8FPIfURbkalBJ5tgsYwuWl9Ig6COs09ajcYtKVOHqOd3w4Ze9Qe31r3
 Gko27jZWFoJ4ZUzh8R4pSZwpIlxKpamfH6hRCC09u1bhXwGh5VRkTpcHg+Udlb3TC+2kvSOGMFi
 SBYiuIUcKOx6HAo5itRJYhZTF+VDCz5+9FlQORQ8SFb/9tAg6zkYFE5fG7ikqDcUOw0FFRHZ05q
 9+9gdOall9ammx1bXLDIT2VeTSqmVlUe4jn3ppogAAa3dEUdpsPf1uqtCVt0OkkxMQZMCwRCToz
 bH5WAb/EP0ebmbjtSDwQ2bsCuD7Cqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_09,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1011 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

On Wed, 2025-11-19 at 13:33 -0800, Anirudh Venkataramanan wrote:
>=20
>=20
>  2. The kernel uses the userspace supplied PCR values to trim the IMA
>     measurements list at a specific point, and so these are referred to a=
s
>     "trim-to PCR values" in this context.
>=20
>     Note that the kernel doesn't really understand what these userspace
>     provided PCR values mean or what IMA event they correspond to, and so
>     it does its own IMA event replay till either the replayed PCR values
>     match with the userspace provided ones, or it runs out of events.
>=20
>     If a match is found, the kernel can proceed with trimming the IMA
>     measurements list. This is done in two steps, to keep locking context
>     minimal.
>=20
>     step 1: Find and return the list entry (as a count from head) of exac=
t
>             match. This does not lock the measurements list mutex, ensuri=
ng
>             new events can be appended to the log.
>=20
>     step 2: Lock the measurements list mutex and trim the measurements li=
st
>             at the previously identified list entry.
>=20
>    If the trim is successful, the trim-to PCR values are saved as "starti=
ng
>    PCR values". The next time userspace wants to replay the IMA event log=
,
>    it will use the starting PCR values as the base for the IMA event log
>    replay.

Depending on the IMA policy, the IMA measurement list may contain integrity
violations, such as "ToM/ToU" (Time of Measurement/Time of Use) or "open-
writer". Either the userspace supplied PCR values will not match any measur=
ement
record or the PCR values will be "fixed" to match the well known violation =
hash
value extended into the TPM.  Depending on how the userspace PCR values wil=
l
subsequently be used, saving the "fixed" PCR values could result in whitewa=
shing
the integrity of the measurement list.

--=20
thanks,

Mimi

