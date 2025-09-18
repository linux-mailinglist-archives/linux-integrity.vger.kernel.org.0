Return-Path: <linux-integrity+bounces-7166-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F02B85DF6
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 18:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211A71888D0D
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93435313E34;
	Thu, 18 Sep 2025 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="poF5yL86"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1311A2FABEB;
	Thu, 18 Sep 2025 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211004; cv=none; b=eETVftmf2tyTJJyrNA26mi5nnJZbHeqzzRRX2RBNDHNlBMQyDOvFgB3AcosO32mV5KphQMTs1TE9qj1z619QQPxtgY62OSymAPvMVJU0LeZxi8hAj3FISMIXCmHmjTtzzpa9du0pKjWnIolaXlITcCtZKYWq11NhHR8J4tinW88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211004; c=relaxed/simple;
	bh=6/6dBpxU8c9wdOpZ8abnVBRgrJzGfjXZX9zXO8XunME=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=F5VROUNfDbb5rCitTAMVBmPyjq5PHSngBkxtG0YnPCBwD/bBa3RInIA+ZEv72e8ngfes/S62mJXK30MxE0ElQYEcNl5UhRJWt7yU6nubqzYpJXdzAgKzXTQjkB/kBVePAqHcn0Srgu9LZ9zRqcT0186eztfT5EW2ztYDXHnnIHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=poF5yL86; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IEeloN032503;
	Thu, 18 Sep 2025 15:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Zv1sdV
	XL0j+FjBWjSs+vnS1w2cKhXRowFw/PtoHWez0=; b=poF5yL86Juw5cK7O/xt3Pm
	vEbslx/o4mgxBeQNP10hhw90ZuCKSJGa0i0UW8JTPyEx1ypJOPDUSgKeQ+Xp5mgs
	ZMUAaIubfCrYb/EiJiC49ySu/PPBihX4+LkPIbNyUChmSv1+PeKqkkX+rj0IUPp7
	bsviqaucVObEC5XW6Et/KgJd6H+qiDqvNDaOemJ+4j9So7545XdPPsfl8fjM/PFh
	5wO3euvsL38ekLypvZtELX1e7YR9vhrkbfEZjDP3E/Y0mF9yiZdUnZ2y5C+LdxeW
	WYBjmjMsgyjqgFRy+DPigXlLBSKbPTEtKrWo0g30dBYG8yQkM1K3LSm63nlK542A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hu9wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 15:55:39 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IFmLE6015785;
	Thu, 18 Sep 2025 15:55:38 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hu9w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 15:55:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IE4gSb018821;
	Thu, 18 Sep 2025 15:55:37 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mq99n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 15:55:37 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IFtadl30933566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 15:55:36 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7458A58063;
	Thu, 18 Sep 2025 15:55:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB8365804B;
	Thu, 18 Sep 2025 15:55:34 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.89.238])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 15:55:34 +0000 (GMT)
Message-ID: <3715abc0a4599d9e87c80725b3a130c44f23c372.camel@linux.ibm.com>
Subject: Re: [PATCH v4 15/34] lsm: rename/rework ordered_lsm_parse() to
 lsm_order_parse()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=	 <mic@digikod.net>,
        =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
        Kees Cook
 <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler	
 <casey@schaufler-ca.com>,
        Tetsuo Handa
 <penguin-kernel@i-love.sakura.ne.jp>,
        Nicolas Bouchinet
 <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <CAHC9VhSxookZfVQhDMdrikmFrk0VoUhEwMx0FR5DS3JfK_MY9Q@mail.gmail.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-51-paul@paul-moore.com>
	 <8b560b9522c1c42e26a108e2f9b2977901d73649.camel@linux.ibm.com>
	 <CAHC9VhSxookZfVQhDMdrikmFrk0VoUhEwMx0FR5DS3JfK_MY9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Sep 2025 11:55:34 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qknqBBrdMym24o1fj8ISTmVOiy0TCLH6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX7UPU9UcK/LMt
 O/3qep6q/iZPW77a45hvSkSJ0QaoViG8uYBrVITe4WOn3emvotxMcAThoD+qq/kZWfp2il76xss
 n5ldQxb8FwJQ+AkJDOvQz1aWEhXsvyL9F1HZcYpOQ/UEDtrAkQZXqy+UewQMU6SAorlbyrgY1ni
 aZ2bgMVEIqKr+H5hHfOJixONmvkWauJj3XANJqTBR1kGB+IJlI1lIDU2LKSq6r6t1LSGiMs9RqX
 IPq4Ujz5XhxdGW0Xfiack33SXXPaZtdm7CXZafdCKcWmaO1E0x6KVZwgTQ3q+PbaHoC+TJJEqK5
 DEdiiuXMFLUb8oM4cPhJhMUVlaDq+gC2ijBzQO0bN0VcNZ5va8i9PesYuT6Y02gqGP7tp2DY6oL
 y2ZQBqq3
X-Proofpoint-GUID: TLGi3_3T2zgGLK1OCA_GmON5TNiGooI_
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68cc2b7b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=3KOuIhcLQ1ZirLif2jMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204

On Thu, 2025-09-18 at 11:38 -0400, Paul Moore wrote:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 /* Normal or "mutable" LSMs */
>=20
> > =C2=A0 What are "mutable" LSMs?!

<snip>

> As the "or" would indicate, they are "normal" LSMs where the ordering
> is mutable, as opposed to the "first" or "last" LSMs.

Yes, of course I understand that.  Still would have been clearer adding the=
 word
"Normal or "mutable" LSM ordering".

Mimi




