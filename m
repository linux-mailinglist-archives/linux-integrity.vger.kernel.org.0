Return-Path: <linux-integrity+bounces-4950-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA540A3E679
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 22:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84CE700813
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 21:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806211D54D1;
	Thu, 20 Feb 2025 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iehyQrlU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062991B4247
	for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2025 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086303; cv=none; b=XEG+jSBYlPufp15fsWHVPAy/ukhlsBihYAeeeUPUe+bMcBdGjUzQLWys8Mx+Iy6XLfgSoyiKJPjMHXD5+fglE/bwA8dMnANFIYSIqI0cCUD8Cx7pdW6CLsR1blE29hTzn41k257vrNQfXjTLRVRGgh10hsy1FlDt1ZSgoeYu+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086303; c=relaxed/simple;
	bh=CECIM3ylgWl8kOUYRPZdcobMX6X8Kq0bDAbPeqhI/7g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kVkVMgO/5Y0mW/t+8WE9MYx9B2Ro8FJf5BK3jzLRdwsS3EPxuqghNG7J8RuG8OSMX9J3/dj8qX7kdp2QyKN7qM6sL45V6WexGOHo528f77AbT2NNmr42Xo3ULN5xRAXCIshF6mVKqsgYRjQAPzkqkpEJ+1HF6UTvGK4KdIgCCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iehyQrlU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KH2295009394;
	Thu, 20 Feb 2025 21:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CECIM3
	ylgWl8kOUYRPZdcobMX6X8Kq0bDAbPeqhI/7g=; b=iehyQrlUm/iBMEoRW6At/g
	gfSmDPBK3NYKb9aZDyuQ3eyXp7dfoJXMi/rpGft5Kkcy3nu6lfKkqrXeSKrb4Efc
	IFjippFxJE64nPMzrrt4YtR6oP8onI/dQlDiR020L8hAr7CMwISmi8pD1q5P1m+E
	LjUldm3Fu8rfD8Xt09QlQrQZSNYa4yUTUJAIy2y9tePf4IDO083RPHXqAvoDd9mX
	C96xi1S22A0W+jSm1lB0R5Q0T9alZTgPCEsMy6VMk7wkCnNRviTGPb9mGw0z56Su
	PHZhMVTgMpKBTwQ8pwi0adZ0XSqH9xmQjn44HXklZTxP/auyH0rCeVMiWZk+UO5g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wtfa5ffd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 21:18:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KIOoeG002297;
	Thu, 20 Feb 2025 21:18:12 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03xc9uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 21:18:12 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KLIATg57410016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 21:18:11 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D27CE5805D;
	Thu, 20 Feb 2025 21:18:11 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92C3958057;
	Thu, 20 Feb 2025 21:18:11 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 21:18:11 +0000 (GMT)
Message-ID: <2637152a2715b8e84e966b12bc9c9cb1c27592c2.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 3/3] ima: additional ToMToU violation tests
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        Stefan Berger
	 <stefanb@linux.ibm.com>
Date: Thu, 20 Feb 2025 16:18:11 -0500
In-Reply-To: <c625586b0dbc4302dfb7adf4acb0c891b74cf8bc.camel@linux.ibm.com>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
	 <20250220160054.12149-3-zohar@linux.ibm.com>
	 <20250220181604.GA2709977@pevik>
	 <fd10e47b4c8b6af0e8d37975cdf1e82133add8c3.camel@linux.ibm.com>
	 <20250220191342.GA2716312@pevik>
	 <c625586b0dbc4302dfb7adf4acb0c891b74cf8bc.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AWoWgqrAzt09j6hVZYlotmDefz7qbX7n
X-Proofpoint-GUID: AWoWgqrAzt09j6hVZYlotmDefz7qbX7n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=849
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200140

On Thu, 2025-02-20 at 15:22 -0500, Mimi Zohar wrote:
> On Thu, 2025-02-20 at 20:13 +0100, Petr Vorel wrote:
> > > On Thu, 2025-02-20 at 19:16 +0100, Petr Vorel wrote:
> > > > Hi Mimi,
> >=20
> > > > > Kernel patch "ima: limit the number of ToMToU integrity violation=
s"
> > > > > prevents superfluous ToMToU violations.=C2=A0 Add corresponding L=
TP tests.
> >=20
> > > > > Link:
> > > > > https://lore.kernel.org/linux-integrity/20250219162131.416719-3-z=
ohar@linux.ibm.com/
> > > > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> >=20
> > > > Unfortunately tests fail on both mainline kernel and kernel with yo=
ur patches.
> >=20
> > > The new LTP IMA violations patches should fail without the associated=
 kernel
> > > patches.
> >=20
> > > > Any hint what could be wrong?
> >=20
> > > Of course it's dependent on the IMA policy.=C2=A0 The tests assume be=
ing booted with the
> > > IMA
> > > TCB measurement policy or similar policy being loaded.=C2=A0 Can you =
share the IMA
> > > policy?
> > > e.g. cat /sys/kernel/security/ima/policy
> >=20
> > > thanks,
> >=20
> > > Mimi
> >=20
> > Now testing on kernel *with* your patches. First run always fails, rega=
rdless
> > whether using ima_policy=3Dtcb or
> > /opt/ltp/testcases/data/ima_violations/violations.policy).
> >=20
> > Kind regards,
> > Petr
>=20
> I'm not seeing that on my test machine.=C2=A0 Could there be other things=
 running on your
> system causing violations.=C2=A0 In anycase, your original test was less =
exacting.=C2=A0=C2=A0
> Similarly,
> instead of "-eq", try using "-qe" in the following test and removing the =
subsequent new
> "gt" test.

-> "-ge"

>=20
> if [ $(($num_violations_new - $num_violations)) -eq $expected_violations =
]; then
>=20


