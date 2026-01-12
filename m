Return-Path: <linux-integrity+bounces-8208-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9076D12FFA
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Jan 2026 15:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1ACC306B780
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Jan 2026 14:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF13272E56;
	Mon, 12 Jan 2026 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dz9XsOnv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4187350D61;
	Mon, 12 Jan 2026 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768226556; cv=none; b=J1lBpv5C/5KmgiP6IfMBPe9rPE6eRmJy3dHNrNpKrn/IwfH+XqOZ3lEYGe6H2glBUj3J9w55/01XZKgKRmJTQ/zzEZdc7xxwQMFtf4/37kuTXi0ZC9OfTvX3tfNIsg6sf6Hbs4AhPBHE5ud1W5oIxzKImxDdD9TwurzO9zl0uX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768226556; c=relaxed/simple;
	bh=mT9VycK03Y2RFrv0IL5bEXswH12iG79ZGfZ39P0N604=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=C92C5JRb88Xy5iS5s2mPTuytKkKQwHNbpaxUgV0My6614TH2geuWyXRJ6OgpkyWLye1moMD+IT8fqs9zKlwfrC6s6rwUYhWn6FgZTd5puIoGUb98H6el+tg34sU2PAFFWH+BA/NssrDo20120zpUyf3U7bKdCSLQTrJ1++03YfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dz9XsOnv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60C7KpCS013676;
	Mon, 12 Jan 2026 14:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3V9d/8
	Xw0hD6CLxhTs403M7kDFPXBd1fKfsTuoLkaSI=; b=Dz9XsOnvKlz/VFwLQaHkIN
	B4lHwjqCDJDZGw628SpoJBl2UVvqEGUVJpM/9PPLzVqHkvNyde5FlqMStocvXiJl
	Owo97niJl9dP9OqdTzg7LWp0srNZOrqg0VrGBdY8U3yD9QR843mha7OGdD22a79U
	WLI2wv4N8FwIaMURItFvPrKqXVHOY5WdnHCo8w1QVZHwE2A3uLfqnBwECn9GJiAQ
	zW/tFi/q5owWhjKuX392ByE6uNcyBCZhWUnpiw1R57kCV/ScLHiCyVpLNr2kA/Jd
	pPPdZyyyO+XzHZ14mugId67AgGTRRDInxXNpK1aL6suB1eM7R4DaEpqCYkbTlvGA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedsq2nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 14:02:07 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60CE0MKs012988;
	Mon, 12 Jan 2026 14:02:06 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedsq2nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 14:02:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60CD73tW002505;
	Mon, 12 Jan 2026 14:02:05 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm13sedt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 14:02:05 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60CE25pg14811848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 14:02:05 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 245CA58062;
	Mon, 12 Jan 2026 14:02:05 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8928D5805A;
	Mon, 12 Jan 2026 14:02:03 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.90.70])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Jan 2026 14:02:03 +0000 (GMT)
Message-ID: <15eaa3613b0552cc48b55972b81882ac1e1d1150.camel@linux.ibm.com>
Subject: Re: [PATCH RFC] ima: Fallback to a ctime guard without i_version
 updates
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jeff Layton <jlayton@kernel.org>, Frederick Lawler <fred@cloudflare.com>
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
 <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        kernel-team@cloudflare.com
In-Reply-To: <25b6d1b42ea07b058be4e4f48bb5a7c6b879b3ed.camel@kernel.org>
References: <20251229-xfs-ima-fixup-v1-1-6a717c939f7c@cloudflare.com>
		 <3ad9ded9b3a269908eee6c79b70dbf432e60ce8d.camel@kernel.org>
		 <aV07lY6NOkNvUk3Z@CMGLRV3> <aV1jhIS24tE-dL9A@CMGLRV3>
	 <25b6d1b42ea07b058be4e4f48bb5a7c6b879b3ed.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Jan 2026 09:02:02 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDExMSBTYWx0ZWRfX3IywhBY2hHsS
 IYFToj2QrBeP9Six137vJRaskBEpy+avdeJz/fYLg96X9LDKBweNNPJf81kOZlHCfKJqb9nEReG
 Hhp24FBLTliG1V4wILxbeflxrPkBYZQ1T5+eotPZ557Jmsx3TZC3J03Zmmh1PivHb9yhGh6H0Yx
 nZNbpbXGXVdF58dhmYX6xbHMsuxxWyyPju8lW8K/kZCXufR0/KaBX4joK8SurQBaA1rHEjrT8Qb
 YPSlTIN0CN4OsN2A6ErgWDEbK12eXTGZex8vaQT0oGku4Ug2/4Y3zYOx+gMxjW7QJWu7ILZsyR9
 uhKb1I8IuLXsAEQa6wozBFb1fmgnyobKj11laT0R03ZDEqTYAPaDpMvVqzyyoOI2HgwRR94iLu+
 Tf7WUOy2r3wGAPjrvdAEyB5cL1YDxFbNUqTbW33l97KS2BzDzKsXLbzouFnrYdY2HH3p4ENK6De
 BaYaYVYSkfcKpGoBYcw==
X-Proofpoint-GUID: XTvekk6vXmC_Mw23sqSGUf07AjPvam4z
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=6964fedf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=H2dI7-eqXuhYRf2exhsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 797W8b3ODnDBSm1sFoh1aUqb2YwNbPNv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601120111

On Tue, 2026-01-06 at 14:50 -0500, Jeff Layton wrote:
> > > > > @@ -54,11 +62,22 @@ integrity_inode_attrs_store(struct integrity_=
inode_attributes *attrs,
> > > > > =C2=A0=C2=A0 */
> > > > > =C2=A0 static inline bool
> > > > > =C2=A0 integrity_inode_attrs_changed(const struct integrity_inode=
_attributes *attrs,
> > > > > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct inode *inode)
> > > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct file *file, struct inod=
e *inode)
> > > > > =C2=A0 {
> > > > > -	return (inode->i_sb->s_dev !=3D attrs->dev ||
> > > > > -		inode->i_ino !=3D attrs->ino ||
> > > > > -		!inode_eq_iversion(inode, attrs->version));
> > > > > +	struct kstat stat;
> > > > > +
> > > > > +	if (inode->i_sb->s_dev !=3D attrs->dev ||
> > > > > +	=C2=A0=C2=A0=C2=A0 inode->i_ino !=3D attrs->ino)
> > > > > +		return true;
> > > > > +
> > > > > +	if (inode_eq_iversion(inode, attrs->version))
> > > > > +		return false;
> > > > > +
> > > > > +	if (!file || vfs_getattr_nosec(&file->f_path, &stat, STATX_CTIM=
E,
> > > > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AT_STATX_SYNC_AS_STAT))
> > > > > +		return true;
> > > > > +
> > > >=20
> > > > This is rather odd. You're sampling the i_version field directly, b=
ut
> > > > if it's not equal then you go through ->getattr() to get the ctime.
> > > >=20
> > > > It's particularly odd since you don't know whether the i_version fi=
eld
> > > > is even implemented on the fs. On filesystems where it isn't, the
> > > > i_version field generally stays at 0, so won't this never fall thro=
ugh
> > > > to do the vfs_getattr_nosec() call on those filesystems?
> > > >=20
> > >=20
> > > You're totally right. I didn't consider FS's caching the value at zer=
o.
> >=20
> > Actually, I'm going to amend this. I think I did consider FSs without a=
n
> > implementation. Where this is called at, it is often guarded by a
> > !IS_I_VERSION() || integrity_inode_attrs_change(). If I'm
> > understanding this correctly, the check call doesn't occur unless the i=
node
> > has i_version support.
> >=20
>=20
>=20
> It depends on what you mean by i_version support:
>=20
> That flag just tells the VFS that it needs to bump the i_version field
> when updating timestamps. It's not a reliable indicator of whether the
> i_version field is suitable for the purpose you want here.
>=20
> The problem here and the one that we ultimately fixed with multigrain
> timestamps is that XFS in particular will bump i_version on any change
> to the log. That includes atime updates due to reads.
>=20
> XFS still tracks the i_version the way it always has, but we've stopped
> getattr() from reporting it because it's not suitable for the purpose
> that nfsd (and IMA) need it for.
>=20
> > It seems to me the suggestion then is to remove the IS_I_VERSION()
> > checks guarding the call sites, grab both ctime and cookie from stat,
> > and if IS_I_VERSION() use that, otherwise cookie, and compare
> > against the cached i_version with one of those values, and then fall
> > back to ctime?
> >=20
>=20
> Not exactly.
>=20
> You want to call getattr() for STATX_CHANGE_COOKIE|STATX_CTIME, and
> then check the kstat->result_mask. If STATX_CHANGE_COOKIE is set, then
> use that. If it's not then use the ctime.
>=20
> The part I'm not sure about is whether it's actually safe to do this.
> vfs_getattr_nosec() can block in some situations. Is it ok to do this
> in any context where integrity_inode_attrs_changed() may be called?=C2=A0

Frederick, before making any changes, please describe the problem you're
actually seeing. From my limited testing, file change IS being detected. A =
major
change like Jeff is suggesting is not something that would or should be bac=
k
ported.  Remember, Jeff's interest is remote filesystems, not necessarily w=
ith
your particular XFS concern.

So again, what is the problem you're trying to address?

Mimi

>=20
> ISTR that this was an issue at one point, but maybe isn't now that IMA
> is an LSM?


