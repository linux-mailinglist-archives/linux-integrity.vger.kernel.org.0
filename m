Return-Path: <linux-integrity+bounces-5143-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B47A55821
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 22:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6241663FF
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 21:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B48927C14A;
	Thu,  6 Mar 2025 21:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CezD1Bis"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FC927C15A
	for <linux-integrity@vger.kernel.org>; Thu,  6 Mar 2025 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294947; cv=none; b=cENJ0jfvAel8W+4hU78Inq9snG7H2ebCwnV09Gb/choX9BaE4p25QgKXLyPpX+TyGLHXgfGi90w+nF15Q7v5CSlkUzjphvkG/CbqCs3VHYC+jIQwfKJny2n4j0xJ+4JvdZMY0c4AcrBSPP6SmiMglE0LVtODbZ8OHNNe0leDVBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294947; c=relaxed/simple;
	bh=KIzB9L0P5j+67GIo5o4poOoQOFZrFpnukv0t4SquZSk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cMgvS0k1a+UieSgbccXtI7lPL4YfLhC88YcQ0Fg20BXPdLF5YkvCiR2Iwka9TLiRPePC+90oCCkq6OeVZxqcbfMC8/0PShl3+VZvAyaCYEJlCo01ZSTOPEQdb7Qg2lwe9QFpv0DgbE6q9qMjKR1J90dy/bWz2dF+Yu2K0AMv1R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CezD1Bis; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526E36wC019215;
	Thu, 6 Mar 2025 21:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KIzB9L
	0P5j+67GIo5o4poOoQOFZrFpnukv0t4SquZSk=; b=CezD1BislMTuZ0MiPPi+qZ
	h88j0/5Y8fwx//bQJ70TorLMI36CU0jJwCL93hExlJTx2EgX1DWGBK2ErSAJZtPN
	e98v++Zcu1jxDp8t0c62NUsb2/AkoaG7Chb+y2tnJ2P0YIVftibYZ9PrUtbejMQh
	5WzDr/I+e9G8uNnDwPUyoDesjMNsKJ1pP9bvkwCSm2pSj5+wH+t0Yfru1jeCaH0w
	kjmIiTOBgUi1Z1m7mQkRSQmJN+ygYyI1dit+F/7+dOicJ6B4ISSp/bec8NJYUA9M
	fBvD5kN5CzdOHHASBJvQfydcFByoco+WtnualOJp/yU59KHFT4U10TCZ0A0idFXw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457d4p26a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 21:02:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 526JY3d1013743;
	Thu, 6 Mar 2025 21:02:17 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2m2vn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 21:02:17 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 526L2GHZ29950610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Mar 2025 21:02:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1E775805D;
	Thu,  6 Mar 2025 21:02:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E56358052;
	Thu,  6 Mar 2025 21:02:16 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Mar 2025 21:02:16 +0000 (GMT)
Message-ID: <a87d1f288726949f330e35df87c9df1f7327d2ac.camel@linux.ibm.com>
Subject: Re: [PATCH v3 5/5] ima_violations.sh: require kernel v6.14 for
 minimizing violations tests
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Date: Thu, 06 Mar 2025 16:02:16 -0500
In-Reply-To: <20250306172622.GB186319@pevik>
References: <20250305145421.638857-1-zohar@linux.ibm.com>
	 <20250305145421.638857-5-zohar@linux.ibm.com>
	 <20250306172622.GB186319@pevik>
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
X-Proofpoint-GUID: 7MErAH1D6imI1QKJsK4vPgwXRJLw_Gqr
X-Proofpoint-ORIG-GUID: 7MErAH1D6imI1QKJsK4vPgwXRJLw_Gqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_06,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 mlxlogscore=737 adultscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060160

On Thu, 2025-03-06 at 18:26 +0100, Petr Vorel wrote:
> Hi Mimi,
>=20
> > Depending on the IMA policy and the number of violations, the kernel
> > patches for minimizing the number of open-writers and ToMToU (Time of
> > Measure Time of Use) violations may be a major performance improvement.
>=20
> I would prefer this to be squashed into "ima_violations.sh: additional
> open-writer violation tests" commit, which adds this incompatibility.
>=20
> But it's a minor detail, therefore I merged whole patchset as is.

Thanks, Petr.

