Return-Path: <linux-integrity+bounces-8449-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KKmIueeg2kLqQMAu9opvQ
	(envelope-from <linux-integrity+bounces-8449-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 04 Feb 2026 20:32:55 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A53F7EC14E
	for <lists+linux-integrity@lfdr.de>; Wed, 04 Feb 2026 20:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 970CD30055FC
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Feb 2026 19:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09290261B96;
	Wed,  4 Feb 2026 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B+Nt8tJh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA041C6FF5;
	Wed,  4 Feb 2026 19:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770233569; cv=none; b=sP9WqWqvrnMzeBFXdcwjI9iR0jrRlAi1R5QhbNe1YWIU6hvXQGHwT2MTxes6Vb35AjmlftboZFSpwu+ZXwIclHTVMpu+s0NbgvwEMf3LpPjtfawBGY8JaIoGkkhpFw2PvEP6aSippfH2vpJxp2cn0/YkKyMZHIkcDoPfIgbh9OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770233569; c=relaxed/simple;
	bh=rH9R1787ybJtDE973a6z5M9Pcr7s3bh6g8KD53PsfgQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=KurZ8UauVHQyS4k3/6i6nyMKot8SHB9i1Z1tb3tmHBjAJV0tIAHaA3y2gI2zRqlzaNnzCtJRPNZm1jc0Gi6KEHsyNI81dtyOju5a9QCHk0qtU68AezRMlrhuWlLcF0BhdkQTGMIJS4TJnVSk3sdKIRDGqF42d/KCE97Ffn2W0LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B+Nt8tJh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 614FgP3p016682;
	Wed, 4 Feb 2026 19:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rH9R17
	87ybJtDE973a6z5M9Pcr7s3bh6g8KD53PsfgQ=; b=B+Nt8tJhum/xu4+iYIHvrU
	lAPb4bHYetTomUDIHOF7PLN8y11ytZPJwk25ivubkunHcN6+zd9qKyp3kVTeik8R
	8jsdxfz5fvHv5n5o0d1hSMBMujlcebsZY4VXahFwbclfrvCpyYTuDgRXEmOP5vRo
	Dx3actQeLjTIzbXSw0VbA3PxW7jDeT66vLSXD4dm1mpTC2Vzz83OxqyDZWTzrYvl
	qXZ2pLRm9DjBAw5JbvZpeM0yR+ZEZqL6R/w12pfdzSU4OHO9f2DlsFadXYVp0HrM
	8o8s5Xh6TRkV9I6+V53RRwpr6p0GdsemUtcCd0Ir8IOYHpYb6cktGb38eIf4YX0A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c185h127v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 19:32:19 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 614JWIqa006601;
	Wed, 4 Feb 2026 19:32:18 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c185h127r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 19:32:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 614GZHNV029108;
	Wed, 4 Feb 2026 19:32:17 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1v2sev7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 19:32:17 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 614JWGCM3146658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Feb 2026 19:32:16 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAA1658045;
	Wed,  4 Feb 2026 19:32:16 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77C3358054;
	Wed,  4 Feb 2026 19:32:15 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Feb 2026 19:32:15 +0000 (GMT)
Message-ID: <69540ac3aca536db948b6585b7076946a12ebe36.camel@linux.ibm.com>
Subject: Re: [PATCH v4] ima: Fallback to ctime check for FS without
 kstat.change_cookie
From: Mimi Zohar <zohar@linux.ibm.com>
To: Frederick Lawler <fred@cloudflare.com>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner	
 <brauner@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Jeff Layton	
 <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
In-Reply-To: <1da265acd3168a5c2b7390ddafc6a46d5e2d5613.camel@linux.ibm.com>
References: <20260129-xfs-ima-fixup-v4-1-6bb89df7b6a3@cloudflare.com>
		 <42da6a2c72b1093b7aa5106cdce4d0efdbd785ee.camel@linux.ibm.com>
	 <1da265acd3168a5c2b7390ddafc6a46d5e2d5613.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Feb 2026 14:32:15 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=UdxciaSN c=1 sm=1 tr=0 ts=69839ec3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=2jSbwk8brr_atF6LsXUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nTbRgvfqLi5-d5Za5nyD6oDkQlpwtweI
X-Proofpoint-ORIG-GUID: b87UIxxLSNe0TdsT44p_o8YldhxnTBKy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDE0OCBTYWx0ZWRfX3TFWAc4E+U6D
 HwgLFI9EKYhqIGwi5zNNgd1YIHpT+zA+HDGogoFHs30EcCsYnSsGvLOzBdSsN9sUtefbk7HqcRJ
 gy764OSmXgzsTcQPjoINiSxDpsIfSEYrlNbSgyIyczZEsZMxcs6I5dEMgJwwXJgq+xa2h/w+B5a
 MyQh1yBoLXRLFb4rZw3CEyRcIz8PKvtzdwuDRY/bYOQAJJURA1+mYvtQfakx10aqISVDufnYd44
 WQD84yt6cDwEO7UM4U9skrEW46mm3dpyQsLxr6cCdxz5wG9dNVSnQRCk9bgecJl0y1qpmd7dN85
 5DdgKRe735eOn1Z3wPumQh/li0QVIBcrOgQnh/Z+VQQsj6J+Mb3HMT2shpjxXaN/GqpVN/CAKy3
 5rtOmMuphtHSYglLiV5JWwZawNdRU9SMCbHifLOUqhhVeZe7xZZLd3v4pz21pibSTR40tjmrtrW
 GbPHULW5WD4huaMh4OQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_06,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602040148
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8449-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[cloudflare.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,kernel.org,toxicpanda.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.ibm.com:mid]
X-Rspamd-Queue-Id: A53F7EC14E
X-Rspamd-Action: no action

Hi Fred,

On Fri, 2026-01-30 at 08:00 -0500, Mimi Zohar wrote:
> > Examples are fine, but first describe the problem - not detecting file =
change on
> > xfs.
> >=20
> > >=20
> > > In the case of stacking XFS on XFS, an action on either the LOWER or =
UPPER
> > > will require re-evaluation. Stacking TMPFS on XFS for instance, once =
the
> > > inode is UPPER is mutated, IMA resumes normal behavior because TMPFS
> > > leverages generic_fillattr() to update the change cookie.
> >=20
> > This sounds like the same issue - not detecting file change on xfs.=C2=
=A0 The problem
> > is simply manifesting itself on stacked filesystems.
>=20
> Splitting this patch, so that the base XFS changes are in one patch and t=
he
> stacked filesystem changes are in the other, would really help clarify wh=
at is
> needed and the reason why.

Tweaking your script with the following changes, you'll see duplicate audit
entries on the base XFS system, without requiring an overlay filesystem.

echo "audit func=3DFILE_CHECK uid=3D$(id -u nobody)" > "$IMA_POLICY"

setpriv --reuid nobody $PWD/rdwr "$TEST_FILE"
setpriv --reuid nobody $PWD/rdwr "$TEST_FILE"
audit_count=3D$(grep -e "file=3D\"$TEST_FILE\"" /var/log/audit/audit.log | =
grep -c
"comm=3D\"rdwr\"")


"rdwr" is a C program that opens the file read-write, using the open() sysc=
all.

Mimi

