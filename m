Return-Path: <linux-integrity+bounces-7440-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B578CBE4615
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Oct 2025 17:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620FD5465B7
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Oct 2025 15:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B9134DCC5;
	Thu, 16 Oct 2025 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sw18Zmc+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90AE1C84B2;
	Thu, 16 Oct 2025 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630241; cv=none; b=qRH9VTWze4QQCcTphLvyOBuE0RoacM0hq1ko7G27i+GqkGIBK5fygDr8L/kf+tCkitbkT/8706TtrB3fdhyeHp73QNlT2HRMxd1SF7UkhUEHChALMGk2Oo4rtLqVhIrwWOr9p0ygMp2dSyVGHMrlvAMwKcLychJYNsUx/4Yr7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630241; c=relaxed/simple;
	bh=SYa45hx25cLQmL3VVQqKPwG/xeGAWOnrx579yuv3GaQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=L++frCMVaPZYNuEzB1X8t4f0ItqSd40H4ZuGIihAPwGwkBoYQ0gWZibHnuFIhARiNf8O0Zlyu7/7zmCpqNe6UxlWI8IyfFFpCHQ+Si8S2+hTbtWPyrKqXH+rwLK/MKOvsjDAfdA4SBuTKBqn/UjhPNbdAXa6nhadkXVLxJKsQqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sw18Zmc+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GEhaZL023893;
	Thu, 16 Oct 2025 15:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZBQ/2i
	fqW2E+1cTVXp0u1m8h4nXESwupWjr074Mz2IQ=; b=Sw18Zmc+zKPGzv8T1kL1uZ
	znfpTVdRWyjGazZ8L8Rdu202t17b8diSBmFgO3h0uNyKLp+acteZj5Sg3dY4zKgF
	pKSAUTWkKRNhpj8cw73DGIl7qJT8/xHUmtcPqaRREFZ9UQ2tKNBc72V+L4ICnYSE
	EUKXkT89ZTSJlxKPX70ZwQuCN8k+Fut11w6EyoG2kGPBNQQFuIywhofNic1mirEo
	W/p6QKLoFedyVKJZzRN7likZkaepMo1GfjtDP8PFY1i54zb3eZt59BAc+Dc0Kf58
	Deb79RhJ7z48F2/ifsFvwUkSfbawtScUX2jMv/xDbl/KK1A5gcea9bmyBq6CdiSg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49tfxpndpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 15:52:04 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59GFVi64011316;
	Thu, 16 Oct 2025 15:52:04 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49tfxpndpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 15:52:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GF5jt8014981;
	Thu, 16 Oct 2025 15:52:03 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjpafy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 15:52:03 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GFq36a19923590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 15:52:03 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B28F58055;
	Thu, 16 Oct 2025 15:52:03 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A71ED58043;
	Thu, 16 Oct 2025 15:52:02 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 15:52:02 +0000 (GMT)
Message-ID: <73d071ece8b1773740d494868f552abdd99decc6.camel@linux.ibm.com>
Subject: Re: [PATCH 0/2] ima: add dont_audit and fs_subtype to policy
 language
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jann Horn <jannh@google.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin	
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Frank Dinoff <fdinoff@google.com>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
In-Reply-To: <CAG48ez1jqa2y=aTJ=C+s9v0_xhWra7gezdY+BO=Red-XVGNQJQ@mail.gmail.com>
References: <20250926-ima-audit-v1-0-64d75fdc8fdc@google.com>
	 <ef7c07585e41c8afbb2b97df98fd47c9374b15cb.camel@linux.ibm.com>
	 <CAG48ez1jqa2y=aTJ=C+s9v0_xhWra7gezdY+BO=Red-XVGNQJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Oct 2025 11:52:02 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Nc0--kYEShRxm3QIkpg4EHQqOj3FqNui
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDEyNSBTYWx0ZWRfXwq/z6oyx+dwU
 cWIgpcNy9XyHN7aFD0s3ksxjd+Zr/49p6dza3xhzP/QWtPHjDQbkl5lPmDJUDSpwEcNZ0tyXP3e
 uT1mBTPXq/SMAjAJ6cN1XJg/0bhOO2Fwtq2lXxKw1oCgQ5isO1m9kRDvDDyLagPbGhE0pVGZ/Yo
 vIt+mVE5XCdmgW1J6+6JjDWQXZtQobOXGqQlx4SRpjZw0E7p9ZfsmVx3M+evcWMTjVZr9HQ7POX
 hVxYR0ZeNmQdUOM6g+PfphRxtjN2xVOhgRDiaIgyA4i+oTx4J2KJkXcVQia8NNfQklUvHVH2KoQ
 4cj3e+RfHLqLvMmkPDIetCEhX03UZozhKi8K9rcVCSRRhr+rxo8y1hNhCCGeKtXfv+9wPFjptTt
 sMr8Y1ncZk2DSVbBXhbOseiCV8yw1Q==
X-Authority-Analysis: v=2.4 cv=R+wO2NRX c=1 sm=1 tr=0 ts=68f114a4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=xtERp6CFAAAA:8 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=kS468RCDs2ulSmmLPXIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 80tl1vxW4ZnoHF5hAksxOizzIMTcJyza
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510150125

On Tue, 2025-09-30 at 16:26 +0200, Jann Horn wrote:
> On Tue, Sep 30, 2025 at 12:23=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com>=
 wrote:
> > On Fri, 2025-09-26 at 01:45 +0200, Jann Horn wrote:
> > > This series adds a "dont_audit" action that cancels out following
> > > "audit" actions (as we already have for other action types), and also
> > > adds an "fs_subtype" that can be used to distinguish between FUSE
> > > filesystems.
> > >=20
> > > With these two patches applied, as a toy example, you can use the
> > > following policy:
> > > ```
> > > dont_audit fsname=3Dfuse fs_subtype=3Dsshfs
> > > audit func=3DBPRM_CHECK fsname=3Dfuse
> > > ```
> > >=20
> > > I have tested that with this policy, executing a binary from a
> > > "fuse-zip" FUSE filesystem results in an audit log entry:
> > > ```
> > > type=3DINTEGRITY_RULE msg=3Daudit([...]): file=3D"/home/user/ima/zipm=
ount/usr/bin/echo" hash=3D"sha256:1d82e8[...]
> > > ```
> > > while executing a binary from an "sshfs" FUSE filesystem does not
> > > generate any audit log entries.
> > >=20
> > > Signed-off-by: Jann Horn <jannh@google.com>
> >=20
> >=20
> > Thanks, Jann.  The patches look fine.  Assuming the "toy" test program =
creates
> > and mounts the fuse filesystems, not just loads the IMA policy rules, c=
ould you
> > share it?
>=20
> Thanks for the quick review! To clarify, by "toy example" I meant that
> while I was using real FUSE filesystems, the policy I was using is not
> very sensible.
>=20
> I used real FUSE filesystems for this since I figured that would be
> the easiest way to test, https://github.com/libfuse/sshfs and
> https://bitbucket.org/agalanin/fuse-zip. These are packaged in distros
> like Debian (as "sshfs" and "fuse-zip"). I mounted sshfs with these
> commands (mounting the home directory over ssh at ~/mnt/ssh):
>=20
> user@vm:~$ cp /usr/bin/echo ~/ima/
> user@vm:~$ sshfs localhost: ~/mnt/ssh
>=20
> and mounted fuse-zip with:
>=20
> user@vm:~/ima$ zip -rD echo.zip /usr/bin/echo
>   adding: usr/bin/echo (deflated 62%)
> user@vm:~/ima$ mkdir zipmount
> user@vm:~/ima$ fuse-zip echo.zip zipmount/
>=20
> I then ran the executables ~/ima/zipmount/usr/bin/echo and ~/mnt/ssh/ima/=
echo.

Thank you for the instructions.  Due to the holidays, there was a delay. Th=
e
patches are now queued in next-integrity for 6.19.

Mimi


