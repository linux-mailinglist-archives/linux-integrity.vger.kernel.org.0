Return-Path: <linux-integrity+bounces-4723-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA45A2823D
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 03:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D45A18872B9
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 02:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14099212B0A;
	Wed,  5 Feb 2025 02:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nr0R/4JG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5461325A65E;
	Wed,  5 Feb 2025 02:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738724319; cv=none; b=MBxCiRi4VrLnEk1EB3nlH11IRX7QGztAJ/bU5ggRuRAyWathpzIu7K3o3n8DkCaAn2HThRSC6vMEzX3/thCx44HAdluAB3vx5NKxN6+N1hsHivTbs/u7C25iMILNl0j3KLn26VYN9h4HOxImEbXZadTWzQ6n1BQUrFPSMPi2nNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738724319; c=relaxed/simple;
	bh=shUoIGcYgurh8v2FD7MUwTclMgTwolkPwMHqI8gTJ08=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=midrmzBGtozlmiWOk0cqa9lYXdahnKe3KFAXlAaXBs8dBCG+WMc/1f11kULsuVKg0Q3vfa4X5uWYQVegU48N0pwb6TutXqKDbudJ8v0GB2ojT1sNx1ReaopWDk9vX5YgupOKLEJ3OB3rqFRiw+aVbkEdH7yfrP0Y00sQSNLtgAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nr0R/4JG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515186YJ012355;
	Wed, 5 Feb 2025 02:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=shUoIG
	cYgurh8v2FD7MUwTclMgTwolkPwMHqI8gTJ08=; b=Nr0R/4JG/xDUCwC+8GfAvZ
	szUVT46Nh0wD98ZkUQ9FyyJ3CzQiQsw7beI10CqITWPG1ilVTGTBgSYB0zBwjemK
	sE79d5Zv7i7tmffmRPX3geIXpCDKY3DZ6HzpqjPB2XiHnxDyoX2Yw4vtxn/V16Vd
	LV1u41sl2uK2gml4VOPQan3nciN2F78cR2qWqk/TSMVNYUeOoOzGSZsDvh1MuB7t
	+zZxo7v3oJSO1+nNZ2LRcfu3Jh2XydF5DDj0940cfXEHvN/MEW+4zn2I0k0P+QYK
	lIkjQFF2k5/jfcWcvE7JfnLKThDyKIz9UT0bi9TLpcweoGue6P8uCYwxRDwlLrxw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kx29gbxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 02:58:16 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5152wFTn012513;
	Wed, 5 Feb 2025 02:58:15 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kx29gbx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 02:58:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51504wGJ006535;
	Wed, 5 Feb 2025 02:58:14 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hyekek8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 02:58:14 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5152wDRB29426324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 02:58:13 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B054F5805A;
	Wed,  5 Feb 2025 02:58:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1BDB58051;
	Wed,  5 Feb 2025 02:58:12 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.30.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 02:58:12 +0000 (GMT)
Message-ID: <8c0c4283d5a8143d292f0defdf6da69d891d20c0.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity: fix typos and spelling errors
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tanya Agarwal <tanyaagarwal25699@gmail.com>, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        anupnewsmail@gmail.com
Date: Tue, 04 Feb 2025 21:58:12 -0500
In-Reply-To: <20250123193742.2623-1-tanyaagarwal25699@gmail.com>
References: <20250123193742.2623-1-tanyaagarwal25699@gmail.com>
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
X-Proofpoint-GUID: 7e8vAt-eTGZuwX7Q7mkzcr6uur6IdLEB
X-Proofpoint-ORIG-GUID: MGzYpa_64irE_5566kFxa8834MJH-zuN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_10,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 adultscore=0 mlxlogscore=836 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050014

On Fri, 2025-01-24 at 01:07 +0530, Tanya Agarwal wrote:
> From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
>=20
> Fix typos and spelling errors in integrity module comments that were
> identified using the codespell tool.
> No functional changes - documentation only.
>=20
> Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks!

Mimi

