Return-Path: <linux-integrity+bounces-7157-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ADAB85873
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 17:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00B87E1931
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 15:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789E630F52D;
	Thu, 18 Sep 2025 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KkybRtPf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA5E30F529;
	Thu, 18 Sep 2025 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208527; cv=none; b=fuAvh17J6YU30JBj1pkK+Rn8Hw6O68Z+uh/xcuiivIxYoBByiwHdx97yPPnTOy60PWnsdw3NiBmwEsuDzIziZmHysIK4jgR0eI61XhxX4Cooxx/wPcL23NANcxms6mkuT2OpWJxXiOu6q9a9Dsf8XELa7o5kGx8rC9vir05S834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208527; c=relaxed/simple;
	bh=7m8Hq61tVZWiz57e9668ITrXwgA2tmBkjlX1GsRuLng=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Hq35fcfcQONwsVYn96taDaMbou9X5jZdvI7EuqcS6sxqZTxDSnqANG8zPvgZL80DOet+yvp7WaTyI8k/B+Ft45SxjUFJqhOFc8CpjB9tvzi5ksiK5RKpt5Jrk0EYKob1ZQxGytseCgc3dW4gtt2RMNlM7h1C3rF5MfwqovumwJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KkybRtPf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I8L6QN011358;
	Thu, 18 Sep 2025 15:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7m8Hq6
	1tVZWiz57e9668ITrXwgA2tmBkjlX1GsRuLng=; b=KkybRtPf2eujPFN+QaAQjw
	+URfkT7SMS+e/kIj6QFcICIYGTLJZY0C7jjXgsQ3hIw8ZP9900j1xhqGitCXakFN
	w1GBaouI7+p90ocokC/kfgZ3lw2SOqiUNigerp6NtmrmCSW1ngPOQgunGWjjtueg
	uboIg3C6mo9RMISG0WAmq2CS1Uqhuj4Pd2D2pXYKr3vALuG1qV6xQ3OeTZyJeDtO
	bDuylOlGEM32AHY0rbR1oTXm68zMw8TdtVipej1OYUJN9mbn5vE/86yxBQ9fxfTt
	QSXV3UQi80ltug1/ZPa1OPwyMCYdp+gLfL06vM/AlwYpwvb2YIsbYhPXt4YyGwug
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4njnan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 15:14:16 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IFEFYE025678;
	Thu, 18 Sep 2025 15:14:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4njnaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 15:14:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IDeb7x022316;
	Thu, 18 Sep 2025 15:14:14 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxpy98c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 15:14:14 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IFEEJZ28443344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 15:14:14 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89E845805F;
	Thu, 18 Sep 2025 15:14:14 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEEBC5805D;
	Thu, 18 Sep 2025 15:14:12 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.89.238])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 15:14:12 +0000 (GMT)
Message-ID: <78e72c9779fdc42425755101de3270308255935c.camel@linux.ibm.com>
Subject: Re: [PATCH v4 16/34] lsm: cleanup the LSM blob size code
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=	 <mic@digikod.net>,
        =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
        Kees Cook
 <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler	
 <casey@schaufler-ca.com>,
        Tetsuo Handa
 <penguin-kernel@I-love.SAKURA.ne.jp>,
        Nicolas Bouchinet
 <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <20250916220355.252592-52-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-52-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Sep 2025 11:14:12 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MN5gmNZl c=1 sm=1 tr=0 ts=68cc21c8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=DfNHnWVPAAAA:8
 a=vpqfxihKAAAA:8 a=xVhDTqbCAAAA:8 a=VnNF1IyMAAAA:8 a=TJvjXSSun--OMuyg4_MA:9
 a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22 a=AULIiLoY-XQsE5F6gcqX:22
 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-GUID: GbhyfS0D7amGsKO1mRlqQOVWYVAAcDB1
X-Proofpoint-ORIG-GUID: i3uhtyHTbV0MkFHx1hY65_2tMW8JTMis
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX5b40MypvQPsQ
 R/VulwDTt69/xvFkcqMUAlrut1dr1iOVuemTU2QWd1t+OKlAj+oQIEY5Zc0yWoAGjKkHCItw6zh
 pwFzFwD1vfLnbhQj/WyXXEdVfT9YWTKr+opxOZDxgcFRhp5SsPPWDCkP33rCK/eGl3URbQQLojP
 uHfQnalEIw04c1h3b1wFryHrVHCk6wjqIXNXPFwlaXBfRWru6Daq3pvofKbl9oEA90KfdGf7n7h
 Kly7Yfjgd3iicKEdaqUc1wv3EPQ/MGxkc01Ftv2jfJ1cAGtzSivVq3ZV2sDf7nZv/piszIVXC5B
 V1vUCx8cDL1shZ68Z1O9E/DMWXMrnDk2iYoO4aPD5vAvpZaBlL8W3mwgfZdgYJt4IGC759m7mgh
 ++vVrOoz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> Convert the lsm_blob_size fields to unsigned integers as there is no
> current need for them to be negative, change "lsm_set_blob_size()" to
> "lsm_blob_size_update()" to better reflect reality, and perform some
> other minor cleanups to the associated code.
>=20
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


