Return-Path: <linux-integrity+bounces-7904-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87131CB3D87
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 20:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39D88300AFE2
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 19:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1066128505E;
	Wed, 10 Dec 2025 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gspVwRHB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6A33B8D75;
	Wed, 10 Dec 2025 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765394246; cv=none; b=MN5mhSuEJ6NeK0HJcm+4Cn6D4Qljc5q7PCuT56u0LFB4EVW4sMbI+4lgHpyiia8nL0MM0usBWkobZoSsuDsc6TMypzsXEGOnCZKIJJdBkLeOQ+aDFVZdv5Mk88eLSvE8lGTT8pKHPjbPWhUQuC2hZ0mJj2xr1GNP6kQssKUogNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765394246; c=relaxed/simple;
	bh=8aUFNKHpN2z/hD/eNUCnR/ryfTmjWz/bXKszlla1aHQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=XAW372H+eBRA9Ck5yy1dvVz8ayWchof1Dt/Uspc3tUzKk77WqtjzqBymmEJnLuAaQhCk5w5BXMYDDQlZOFw10s860KVIOG7QEYBjUmFpqGAXFp2RRV4uBhfN91oQonC+2U2k1AR5eqnq7wV+qzZtQ7vR7qXuT/tIwXWL9fvHkFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gspVwRHB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAGDKnT006746;
	Wed, 10 Dec 2025 19:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UAxq1k
	egZYMUt8yoyMfS9GxEA2chxFrFLIcbsDy5MFA=; b=gspVwRHBd4NqrEcNWRdIUo
	5dUx1PtVxrj+dsPnZcKw/8FPk6jFSe+5U5CgWigj255iJJLjSQXDwGdScuhpoGwd
	W7Z5LvoA2EIKc/vz+t3M7611kz8umh/BOcJsZvkJxyXfhTeUBGHk0lqY3XdfNPMU
	aCFGH6XcKIHg44Jbt1pvDad1VFll6Ps3K1UnTmAU6jEC7Rc70tB9Jgvs+qYQPnDZ
	PuyHQb9F/prHm/LYViAXSwjLbX99jySZFJJXLqkIreWnbuMgKy7Ij2U9hpuck4yH
	jNYCZ/lX5rd6qQs3gxmMkI/CBEUQ1ORIcD5O5i+d+QTtFMv6rclzxV96g8QBegxw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvuqs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 19:16:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BAJGwUC002671;
	Wed, 10 Dec 2025 19:16:58 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvuqru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 19:16:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAH0Qjq001998;
	Wed, 10 Dec 2025 19:16:57 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw11jj7g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 19:16:57 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BAJGuSS20906682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 19:16:56 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96D4E5806D;
	Wed, 10 Dec 2025 19:16:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4562E5805C;
	Wed, 10 Dec 2025 19:16:55 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Dec 2025 19:16:55 +0000 (GMT)
Message-ID: <59d76f4a9cbc2016387f3f053e1689d14f3b43fc.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] IMA event log trimming
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        James Bottomley
	 <James.Bottomley@HansenPartnership.com>,
        steven chen
	 <chenste@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, linux-security-module@vger.kernel.org,
        anirudhve@linux.microsoft.com, gregorylumen@linux.microsoft.com,
        nramas@linux.microsoft.com, sushring@linux.microsoft.com
In-Reply-To: <736e21826c6a283d74d592393c392abbff56a409.camel@huaweicloud.com>
References: <20251202232857.8211-1-chenste@linux.microsoft.com>
		 <20251202232857.8211-2-chenste@linux.microsoft.com>
		 <099492ee58996b6f18d73232677757ecadb14cb7.camel@huaweicloud.com>
		 <34d739c2cf15baf78dff5acb7ae3ddd7ad47f219.camel@HansenPartnership.com>
		 <1ca00e3238e804db9280abf8655364c2662754ca.camel@huaweicloud.com>
		 <d0c00469a8501483baffaf1158102c0f2c5211e8.camel@HansenPartnership.com>
	 <736e21826c6a283d74d592393c392abbff56a409.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Dec 2025 14:16:54 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vUheZQnV-em3kNl77Jfe_w5sYTXMWOXT
X-Proofpoint-ORIG-GUID: oIQdssVcx_Axueum6yjpE5HcKjhrdHxu
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=6939c72a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=eSAHqJhRAyoXFonV6roA:9 a=PRpDppDLrCsA:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX8tquqM8KDsQc
 Ry5HXxIaffFcUaHCNxKGL/aTx8D+hJnudGC2JxY/PpZVBxMPhrFyrXB3NtpvTIDxosBa20MOCN+
 8pki/ztEc5xIun0FkDvxR+PJBWSLUUex9yOYj3JKjiVPZ1BDr0DOVURAj8IHqjdz4q4jWRAtG0Q
 GaEseMNawmU3CbRpjurp+tyxwksGgkVylVOLaeF1zJsvpb/f7aUDxgb7C3y0n/gZ/Mwl4cO+35G
 5rpQj2TBv1fHMtf7kX8GpOp3ljL4TyO8NiZE5moTRBRDi/+02rabKxtQ3xQjeoqrvmaAlu+W+Xs
 F1pPRPYWteFlaY7UrOnNBG0ErJIxRmEvxZy5B8A4/D74yeT/9t/DU4iBtn4Jjeq+vRUttjemswV
 YSCkDmsewKddqs5Ka7BhigHtQa7JQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_02,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000

On Tue, 2025-12-09 at 10:36 +0100, Roberto Sassu wrote:
> On Tue, 2025-12-09 at 07:17 +0900, James Bottomley wrote:
> > On Mon, 2025-12-08 at 10:40 +0100, Roberto Sassu wrote:
> > > I have the impression that none the functionality you cited has to be
> > > implemented in the kernel, because the only component one can trust
> > > to verify the integrity of the IMA measurements list is the TPM.
> > > Whether either the kernel or user space retain the measurements is
> > > irrelevant.
> >=20
> > That's correct, I'm not advocating moving quoting into the kernel.  Co-
> > ordinating the trim with where the quote gets you to is phenomenally
> > useful.  While you could theoretically store any mismatch in userspace,
> > having two locations for the log makes it more error prone.
> >=20
> > > I believe that the only role of the kernel is to get rid of the
> > > measurements entries as fast as possible (the kernel would act more
> > > like a buffer).
> >=20
> > I wouldn't say that, I'd say to get rid of measurements that the user
> > has indicated are of no further use\

I really hope I'm wrong, but I don't like the sound of "No further use".  T=
he
complete IMA measurement needs to be saved somewhere to support multiple
verifiers.

>=20
> Different users could have different and conflicting requirements, and
> we would spend time trying to conciliate those. We can avoid that by
> doing it the same for everyone, and the additional cost of handling it
> I believe it is fair.
>=20
> I could accept staging N entries since I already agreed with Gregory
> and Steven, and since it requires only an extra iteration in the linked
> list. The other desired functionality should be implemented in user
> space.
>=20
> > > This was actually the intent of my original proposal in
> > > https://github.com/linux-integrity/linux/issues/1=C2=A0. The idea of
> > > staging (was snapshotting, but Mimi thinks the term is not accurate)
> > > is simply to detach the entire IMA measurement list as fast as
> > > possible. Further read and delete after staging is done without
> > > interfering with new measurements (sure, the detaching of the hash
> > > table is not yet as efficient as I hoped).
> >=20
> > From the application point of view, offloading the log and random
> > points is a bit more work because now the log collector has to be
> > modified to look in multiple locations and we'd also need an agreement
> > of where those locations are and how the log is sequenced in a naming
> > scheme so it's the same for every distribution.  If the application is
> > in charge of trimming the log at a particular point, collection remains
> > the same (it can simply be the existing in-kernel location), so we
> > don't need a cross distro agreement, and the trim can simply be added
> > as an extra function.
>=20
> It could be a single location, the user space program would be
> responsible to present the IMA measurement list as if it was never
> trimmed.

Even if it is a single, new location or user space program/daemon, it needs=
 to
be documented.  The user space program/daemon would be responsible for retu=
rning
the IMA measurement list.

Keylime, for example, supports incremental verification[1], meaning initial=
ly
the verification would be from the beginning of the IMA measurement list, b=
ut
subsequently the verifier could do an incremental verification. For increme=
ntal
verification, state information (e.g. number of records verified, pcr value=
)
needs to be preserved by the verifier, not the kernel.

[1] Keylime commit 7870f45f909f ("ima: Remember the number of lines success=
fully
processed and last IMA PCR value(s)")

--=20
thanks,

Mimi

