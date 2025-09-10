Return-Path: <linux-integrity+bounces-7046-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0B2B516DA
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Sep 2025 14:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2FA1C84438
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Sep 2025 12:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DEA23E335;
	Wed, 10 Sep 2025 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YGKNY0yQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B175308F17;
	Wed, 10 Sep 2025 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507212; cv=none; b=S6eOceLSa8+ipQuo4NnYtyb8iVU715I2ebrHV79lmqR44ZLTPXzlXIebxBCDPKKL/PGyiJt1mR53VyJVJ0j2XAjLDkRw+79Y1I19DNUvgfDWxlMu3zFU23BtIlG5nJtWBvw9+kpNp2L5gs4qWo7vSQtXr9iqE7jxfSviEE3sdlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507212; c=relaxed/simple;
	bh=qkwNMal94C2ttuQj7wWGPkCgDpYPmniry8rLcINBo+A=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=iD9wXKrM3lqsRVq1W/KBHIK7PGulGFBhaS8X8a7KF8pl1hr+pEFMhTd388gLUwL6dGVzJ6n6o7kvr4G+7gW4nB5Tf8Bcmr58UkIniEDnqhKPkdXF6t/4+NYAQCAS7Wr1oCJgFLriscF5ba05f42HpkWqb0OlZEV5b3CCZmdN+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YGKNY0yQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A36AB0030930;
	Wed, 10 Sep 2025 12:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=e6fGPS
	SfpKL/rhEcy+cii3OS7AvabJz7ZbeGn4yhaa8=; b=YGKNY0yQuKICIaSCj9PT/6
	ndrf7hlhfPIHyTahjGp316vh8/olNhI3cnUefXk3S9mG762G5a4BHyecT4BKZNV8
	isgBipX9UftG6GUb/d5iyEaxjksO8FtPYHkG4ZOL9/n0jjRQHvQtBS79JpDi75p+
	UX8aqyjOJrWRFuecxMRyRT2EMOXPoK/GulOUHY+j2UKlMFdiWd9pZYG8V/ijj6oY
	qSrS2rxhlF/BH7VP6lNnEQo/Ffm+xejU7cT2eiJzdDuv2CCH3AHTI407GX7rd2ut
	+oYi/AgLTzK9UCVyOY1BioBtPqUeiFmLKxI8KXQBZX/m7aVKp8VlWFbc20lsgAdQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xyd2v1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 12:21:36 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58ACGkcF022786;
	Wed, 10 Sep 2025 12:21:35 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xyd2v1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 12:21:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58A8kVKV011446;
	Wed, 10 Sep 2025 12:21:34 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9ugkj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 12:21:34 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58ACLYT231130146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 12:21:34 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A69A58059;
	Wed, 10 Sep 2025 12:21:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA07A58043;
	Wed, 10 Sep 2025 12:21:33 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.153.78])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 12:21:33 +0000 (GMT)
Message-ID: <6f2b7320b691669068dda110c29c25f8aae2f244.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: don't clear IMA_DIGSIG flag when setting non-IMA
 xattr
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>
Cc: linux-integrity@vger.kernel.org, Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore	
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	
 <serge@hallyn.com>,
        "open list:SECURITY SUBSYSTEM"	
 <linux-security-module@vger.kernel.org>,
        open list	
 <linux-kernel@vger.kernel.org>
In-Reply-To: <wwcnoevou44eoe3ner4oegtdsdg46tlvwidu3ynobs7huac7ae@ljivg5ksohxv>
References: <20250902042515.759750-1-coxu@redhat.com>
	 <d252b04934908e7e65a3299bfeffc282c7b0b12f.camel@linux.ibm.com>
	 <53wb5tzech2k4k25xy2heq7ohmp2elw2a7l4x3nfk6fajfydur@5thsinydau5x>
	 <13d7fcfecb06423294ae0553c9a561f4cc8faf67.camel@linux.ibm.com>
	 <9fb8781bfb9c9ae9dd0a1413e23cae20dcd7356a.camel@linux.ibm.com>
	 <wwcnoevou44eoe3ner4oegtdsdg46tlvwidu3ynobs7huac7ae@ljivg5ksohxv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Sep 2025 08:21:33 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8NiL41lmb0L21-LN2OPXr-F6zWuczHAL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfX5g7WJRVXGsu6
 lpulLxcw2YPXMpC8s5owVMH95mgvfONTlAgy9I5lWhyu6DAtfO6eGVbAg25I9BzUnq4bG+Q/ejJ
 85ksDMcZo6k3p/ocxBE9peGk/09mqQBzpbxZTFtXnOWmCWlWmH7gU9lqAmiTj//7jig0AqfJtcO
 7CHTiKFc4FmJHBztx7jOf6cFN17SsurN2xL5Z8LBFIZtqur5SlLchQxheHtEnuZuk9Kah3+uWQr
 l+Q9Xe7Obb/jv5EnFYK2P5uyaKNUdF4aPjlkDqTArMQyIErX8Wg6foIlKRYviy+s+u3MbMNV1sf
 MoKPYhKeDOV+1/uvCUNS56AEh8mVoAlkZnjKTeSNYwWHPGlx1EZpSPkA6qFUA8B4Ip1KdwCmKop
 BWxfYXep
X-Proofpoint-GUID: Zu65Kpz4lQjIXHxvkV7tCSx_Sd8IB_c_
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68c16d50 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=l0XoPeyDebXZSsvv9nAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_01,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

On Wed, 2025-09-10 at 09:36 +0800, Coiby Xu wrote:
> On Mon, Sep 08, 2025 at 04:58:05PM -0400, Mimi Zohar wrote:
> > On Mon, 2025-09-08 at 10:53 -0400, Mimi Zohar wrote:
> > > Hi Coiby,
> > >=20
> > > On Mon, 2025-09-08 at 19:12 +0800, Coiby Xu wrote:
> > > > >=20
> > > > > Even without an IMA appraise policy, the security xattrs are writ=
ten out to the
> > > > > filesystem, but the IMA_DIGSIG flag is not cached.
> > > >=20
> > > > It seems I miss some context for the above sentence. If no IMA poli=
cy is
> > > > configured, no ima_iint_cache will be created. If you mean non-appr=
aisal
> > > > policy, will not caching IMA_DIGSIG flag cause any problem?
> > >=20
> > > Sorry.  What I was trying to say is that your test program illustrate=
s the
> > > problem both with or without any of the boot command line options as =
you
> > > suggested - "ima_appraise=3Dfix evm=3Dfix ima_policy=3Dappraise_tcb".=
  Writing some
> > > other security xattr is a generic problem, whether the file is in pol=
icy or not,
> > > whether IMA or EVM are in fix mode or not.  The rpm-plugin-ima should=
 install
> > > the IMA signature regardless.
> >=20
> > My mistake.  An appraise policy indeed needs to be defined for the file
> > signature to be replaced with a file hash.
>=20
> Thanks for the clarification! rpm-plugin-ima does try to install IMA
> signature as shown from the following strace output,

Agreed. I was referring to the SELinux label, which would be installed for =
new
files, but not necessarily re-installed on existing files.  The test progra=
m
simplified testing.  Thank you.

Mimi

