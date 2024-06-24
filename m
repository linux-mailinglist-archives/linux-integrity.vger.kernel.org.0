Return-Path: <linux-integrity+bounces-2921-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC8D914F59
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2024 15:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B3E2843F0
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2024 13:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7523B142625;
	Mon, 24 Jun 2024 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kfnR7+z9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96A91411C8;
	Mon, 24 Jun 2024 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237474; cv=none; b=uQUx1EWLOkNa4qmeBtw6AN/8og5dIWVNddOSKu6ATTsDhZ9uozOdroZys1nz6hwK+1hWfjSalgROKoZsKaLctn5P/Yj6Z4wMFjv1T62MhzUQT243cT0Q1hhA2nJHzGJv4WK8Tp+NQRr0SBiAesLrc2Ip+d5msViB6/YURiqBbeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237474; c=relaxed/simple;
	bh=0yxI92P/8LK00PUAQGJcV8c0/upOK1FZgPxXwQQ0Al8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=mrcMlzgDhFI5V61ymZiDfDsoq1feIdn7XJ6ve7aWEGloHuqxDKrY/okR1Larl/2Nf6zANMSpNVzTTiiFOWXVkQh0wfPAgPsn0xYKm5dfVWavtBdVaF5AWGmx1XTp3MKHmzGk/DVPlNV02xD/3jaaKDtj8dGXBSfWXP0Oas9Qk/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kfnR7+z9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ODvAC9022725;
	Mon, 24 Jun 2024 13:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=pp1; bh=
	0yxI92P/8LK00PUAQGJcV8c0/upOK1FZgPxXwQQ0Al8=; b=kfnR7+z9LQDkyT2n
	hLYfofbKwc3kEUSAKPKRbc9DpMkcWg0pThZj53NKp7dXWkFP5PK5psSVu1aEpbGs
	X16gzO6XZBrPiyjrOtfd0P+ZaGeDOLCEyusty9K1L1MMJ+I479XI7qBw4rL2xyVw
	sljtx3UCA1VLNnK2NA7WU1yNMG0U/C7eKgcrlGSWTEAE8wM8mRxoI6JbrOpXI8en
	C6Tm8FOI/s61s0XrB+TecU8QAQAfJPr6f31pF5wIyxnh15eoXC9zRvB3jOMpQDVJ
	oHXG7q9FjvqrMTByV1jhTV5nHbR7+M2PYAqr2N5duO/ZKz9jRid7eKNECtoWzOCl
	Y4NEOQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yy7y20dq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 13:57:20 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45ODvJ7a022895;
	Mon, 24 Jun 2024 13:57:19 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yy7y20dpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 13:57:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45OCa9dH019625;
	Mon, 24 Jun 2024 13:57:18 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9xps3re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 13:57:18 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45ODvGmU11797032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 13:57:18 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B7365805F;
	Mon, 24 Jun 2024 13:57:16 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 133D058056;
	Mon, 24 Jun 2024 13:57:15 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.65.213])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Jun 2024 13:57:14 +0000 (GMT)
Message-ID: <52bffc64dc7db2cc1912544514008eada1e058a7.camel@linux.ibm.com>
Subject: Re: [PATCH v39 01/42] integrity: disassociate ima_filter_rule from
 security_audit_rule
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Paul Moore
	 <paul@paul-moore.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, mic@digikod.net,
        linux-integrity@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Date: Mon, 24 Jun 2024 09:57:14 -0400
In-Reply-To: <aecad5ea129946dbf9cf5013331f9368ceb84326.camel@huaweicloud.com>
References: <20231215221636.105680-1-casey@schaufler-ca.com>
	 <20231215221636.105680-2-casey@schaufler-ca.com>
	 <CAHC9VhT+QUuwH9Dv2PA9vUrx4ovA_HZsJ4ijTMEk9BVE4tLy8g@mail.gmail.com>
	 <CAHC9VhSY2NyqTD35H7yb8qJtJF5+1=Z4MHy_ZpP_b7YDT-Mmtw@mail.gmail.com>
	 <fbf7f344c518d70833398c2365bb2029480bd628.camel@linux.ibm.com>
	 <d953fac4-9dbe-42a0-82eb-35eac862ca6a@huaweicloud.com>
	 <CAHC9VhRKmkAPgQRt0YXrF4hLXCp7RyCSkG0K9ZchJ6x4bKKhEw@mail.gmail.com>
	 <aecad5ea129946dbf9cf5013331f9368ceb84326.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jtA9RUYxkFCrtJv5OMGa8NU1o0JMmskp
X-Proofpoint-ORIG-GUID: 3-yBhrzcszi56fSIXqpkYtsqRqA5YqUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_10,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406240111

On Mon, 2024-06-24 at 10:45 +0200, Roberto Sassu wrote:
> My only comment would be that I would not call the new functions with
> the ima_ prefix, being those in security.c, which is LSM agnostic, but
> I would rather use a name that more resembles the differences, if any.

Commit 4af4662fa4a9 ("integrity: IMA policy") originally referred to these hooks
as security_filter_rule_XXXX, but commit b8867eedcf76 ("ima: Rename internal
filter rule functions") renamed the function to ima_filter_rule_XXX) to avoid
security namespace polution.

If these were regular security hooks, the hooks would be named:
filter_rule_init, filter_rule_free, filter_rule_match with the matching
"security" prefix functions. Audit and IMA would then register the hooks.

I agree these functions should probably be renamed again, probably to
security_ima_filter_rule_XXXX.

Mimi


