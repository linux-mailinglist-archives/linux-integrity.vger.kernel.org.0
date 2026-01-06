Return-Path: <linux-integrity+bounces-8168-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5B5CF61A2
	for <lists+linux-integrity@lfdr.de>; Tue, 06 Jan 2026 01:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A0D830505B2
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jan 2026 00:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32664AEE2;
	Tue,  6 Jan 2026 00:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Br63oekY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FF242AA3;
	Tue,  6 Jan 2026 00:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660382; cv=none; b=vFobZoyzaJOwlZpt4TKDHHRakrPRncHR9v32QIRufo6t2h7C8GCfFtQFEMzgnoNGueieFVTeiJfRIi/TddgfMnrIthbBDFiKgCGf9tdIm7+uBklXTXiW9yxDGAOeYJdf/x1ACOxEb104zpe6n+U7uMoe4BaSxqejERqvW6326EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660382; c=relaxed/simple;
	bh=8I97DERx34VIQhj3u8Ae4zDfeZ7XSi43CSNDQef5UA8=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Xj0VVgMvz99J9RbeC9QBhEqo2TMAfMOoinO5Tjk5qa8BZn1A6a1OsDtG+0b3d0Q2nDR/Qcj+bMho65ZE4jtFYoCJG2e43pIu5hwW2OjwnyIi76DL34ja5mGQE/IUn2AnRtt+o7Jye6YC5Cgw+6LDB7QC2gscMJbTDU4sZJsbp+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Br63oekY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 605D69FW032439;
	Tue, 6 Jan 2026 00:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1OpIPi
	MmhVDGyOlHHXBpaHWNjIBURSYyf75DOkddYWI=; b=Br63oekYnK/QX8AZVNkCuX
	eRhv7RD7pi65qW73AfXNQF9CXBSAg78I8Qyy0WC/JHnc2QFNtNp3o7iFTuWT3Wbq
	K5lO0QipARAfolrZqqTGNhYp6djwF+s4RQ2I5ITRr/vbTtLdvppOTViPx0EWDqNW
	xwEEUWeTTVBuYtVqOS6d3aeC1KZIihSpBIqWr2y90xpowDoNGM/9HcZGWEccYqgG
	h1lhOBIJCm3So1rNtOeU2lCcRwaDqIIkhSWIPlgwQjoVCmPwsZuPv0LBjtt+Sju/
	XzwLlwGUAuy0oG5UyS4uWPVrE/MIl2juUXxrPGmmKCKPNY0rumAzwKxSo4M93U9g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu61rav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 00:45:42 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 6060jfxH021956;
	Tue, 6 Jan 2026 00:45:41 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu61rat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 00:45:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60602YXO015242;
	Tue, 6 Jan 2026 00:45:40 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfdes8wa4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 00:45:40 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6060je7Z25100826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Jan 2026 00:45:40 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2330A5805B;
	Tue,  6 Jan 2026 00:45:40 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BEB558055;
	Tue,  6 Jan 2026 00:45:38 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.32.202])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Jan 2026 00:45:38 +0000 (GMT)
Message-ID: <b43a2f0bea04574186d792a94879c0b1b95e0e86.camel@linux.ibm.com>
Subject: Re: [PATCH RFC] ima: Fallback to a ctime guard without i_version
 updates
From: Mimi Zohar <zohar@linux.ibm.com>
To: Frederick Lawler <fred@cloudflare.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin	
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E.
 Hallyn"	 <serge@hallyn.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner	 <brauner@kernel.org>,
        Josef Bacik
 <josef@toxicpanda.com>, Jeff Layton	 <jlayton@kernel.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
In-Reply-To: <aVxEv3k9YeG1or8z@CMGLRV3>
References: <20251229-xfs-ima-fixup-v1-1-6a717c939f7c@cloudflare.com>
	 <4a4778ff395e533cad86ff3ffbf0ba90c3eb8798.camel@linux.ibm.com>
	 <aVxEv3k9YeG1or8z@CMGLRV3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Jan 2026 19:45:37 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695c5b36 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EG7W4yiQAAAA:8 a=yOQB5vse7dgb-dHuGXkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qLk6VhhnlYLFa6w3evxk7WdcddG93Olf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwMSBTYWx0ZWRfXwX9kqxeyTEw1
 1fFyp1sXf3uWtVhItJUneB1nOKvLcEuqxzs2JuweLzzW3pj1Foh7nm8hdJk8jwZ/VqtcIyqCYXQ
 mEXM3VFCsz/4aYonLfhA3FpAnNPFVpzf3rsQNNSFOiC3O0JEH6MsQCX/5FOmXGSoc5iaaVCkGbY
 hmZrtFAYBHYQJaiTitdPfvI0IS6GeHZnFUbzeH06c3lGSuI+b7JAmf1Fm6W8q8JjYgOZnOMVj0Q
 IBtSNuhlLq/tgCWxpMlVpPmnltc0OhnYeIXnn8o0rZOygPNmlIrg94wfwUjZnuRv2SJ9bswXRbn
 hwhXTpYKhR8dX+QyF8pa06uVvl13iaPdIIaTDcBn9wGO8LqHSyHmAVhm8Xas+Dx9gBMtP6E3fr7
 2i8SFBlmFCTOgJMmFsi4g97rC23Eo1pvDnqDssRvCw+c4A/ycXUIciJsbPMSDRiMd0I9oLEzTeN
 3sIiTkBtXAEa6BZ3kPA==
X-Proofpoint-GUID: LOglKr4cs-wT4bPhJSAOfiF_7f2AHEOH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601060001

On Mon, 2026-01-05 at 17:09 -0600, Frederick Lawler wrote:
> Hi Mimi,
>=20
> On Mon, Jan 05, 2026 at 05:15:15PM -0500, Mimi Zohar wrote:
> > On Mon, 2025-12-29 at 11:52 -0600, Frederick Lawler wrote:
> > > Since commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps"), I=
MA
> > > is no longer able to correctly track inode.i_version due to the struc=
t
> > > kstat.change_cookie no longer containing an updated i_version.
> > >=20
> > > Introduce a fallback mechanism for IMA that instead tracks a
> > > integrity_ctime_guard() in absence of or outdated i_version
> > > for stacked file systems.
> >=20
> > Thanks, Frederick.
> >=20
> > Instead of using the new function name integrity_ctime_guard() to descr=
ibe the
> > change, please describe the change in words.  Perhaps something like: r=
ely on
> > the inode's ctime to detect a file data or metadata change.
> >=20
>=20
> Sure thing, I'll change for the v1.
>=20
> > The purpose of generating a ctime guard value, as opposed to using the =
tv_sec
> > and tv_nsec, I assume is to minimize the amount of memory being saved i=
n the
> > iint.
>=20
> This was Jeff's suggestion. It does serve the purpose on saving
> some memory, but also has some value in the event nsec or sec is zero'd.
> It just needs to be different enough from the last cache'd evaluation.

All of this needs to be described in the patch description and, probably, a
comment before the function.
>=20
> >=20
> > >=20
> > > EVM is left alone since it mostly cares about the backing inode.
> > >=20
> > > Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
> > > Fixes: 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
> > > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > > ---
> > > The motivation behind this was that file systems that use the
> > > cookie to set the i_version for stacked file systems may still do so.
> > > Then add in the ctime_guard as a fallback if there's a detected chang=
e.
> > > The assumption is that the ctime will be different if the i_version i=
s
> > > different anyway for non-stacked file systems.
> >=20
> > Agreed. This patch inverts the i_version test to return immediately if =
the
> > i_version hasn't changed and then checks the ctime guard value.  Is the=
 ctime
> > guard value test simply a performance improvement?
> >=20
>=20
> Kinda. The thought was to make already-audited files that have an
> unchanged i_version since last audit succeed early.
>=20
> Stacking tempfs on XFS for instance, would incur the stat cost each
> evaluation, since the cookie that used to set the i_version on
> evaluation with XFS on 6.12, is now always setting it to zero since 6.13.

So without this patch, there aren't any missing measurements, verifications=
, or
audit records.  Please clarify in the patch description that this is a
performance improvement.

>=20
> > >=20
> > > I'm not too pleased with passing in struct file* to
> > > integrity_inode_attrs_changed() since EVM doesn't currently use
> > > that for now, but I couldn't come up with another idea to get the
> > > stat without coming up with a new stat function to accommodate just
> > > the file path, fully separate out IMA/EVM checks, or lastly add stack=
ed
> > > file system support to EVM (which doesn't make much sense to me
> > > at the moment).
> > >=20
> > > I plan on adding in self test infrastructure for the v1, but I would
> > > like to get some early feedback on the approach first.
> >=20
> > I really appreciate your adding a self test.
> >=20
>=20
> I was poking around last week at some testing platforms, and instead of
> adding to kernel sefltests & setup a VM etc..., to instead add to=20
> Linux Test Project (LTP) if that's fine?

That's perfect.

>=20
> In any case, I can add my test snippet to v1, so you have something
> to review with the patch. That snippet works the same on 6.12 as it
> does on 6.19 with this patch.

Thanks!

