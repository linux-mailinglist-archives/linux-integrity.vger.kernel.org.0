Return-Path: <linux-integrity+bounces-9612-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMaLH8JoDmob+gUAu9opvQ
	(envelope-from <linux-integrity+bounces-9612-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 04:06:58 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D98BA59DE01
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 04:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62D88300A605
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 02:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A203148C9;
	Thu, 21 May 2026 02:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T5E0tZe7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7BA3033EA;
	Thu, 21 May 2026 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329170; cv=none; b=bWNFa9gnbLzNJ0Fe2EItQaDIKVp7htFBYi9QzLoePvwOKXS/DMHR+eWdwLJXYm7ioxeajNJnwYQ3QjjMLmgNG6dilMHmF/SbWLqRG2UY8KBRQtkeSTWBsXAI8doKCJ3pN1qhDvh1GYzD7c04y2bP7ckMAtqDXF1Z/AR3L9WZFV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329170; c=relaxed/simple;
	bh=T9ZnyXzXONRWtNB7nQp2XMFi/ODMoMxTCNqTj04ZT6Y=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ftGcghUiR1CrXqpf+sCCRhejRk1erXJAYHOWRSvKofaSJpqAO+2teF4b8uk3BVg9Hp67p+tT/M9kTYMdEffHlavCTf3pt91lv7Ekxv7/euqoLI4nQcsO2y1zLEPf44bKYVhY5JVY3J5p6Xmt99JiMYU85Ydh3tFslmHWq2x1Kv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T5E0tZe7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KDtT613690499;
	Thu, 21 May 2026 02:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=T9ZnyX
	zXONRWtNB7nQp2XMFi/ODMoMxTCNqTj04ZT6Y=; b=T5E0tZe7UUonJsBiYJz3mJ
	pd6b/JrqC79HglcOHW2gYyrcIqyK8jC7YowGArXsAGQOuthWnauB2ranqa0xkoLC
	dmROZ3ulUj8jkchsrqrLNASNAgHhskMtaz3Y7kkKUagV7y3UlPZbNO0y38UpKVfc
	YaDKicG12GlK155Y+P7PBkMgoyCHw+k3x1AqNAik5V5Fq/YuefW9jU5z8FqOo05g
	yowKPxDSuJkqFePotOQpyQE2rEBQusvrLAq2Yk2uf7aS7VsDJ0CrfEzEgI3CY07C
	v4Onji+T2LvG1gwk3RefKtwIT8DtS5Mc1treJV4bagjDw76qsOClE7OF0zhgS6CA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawbns0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 02:05:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L1sHch025280;
	Thu, 21 May 2026 02:05:47 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wka1qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 02:05:47 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L25lRr27132606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 02:05:47 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F312C5805A;
	Thu, 21 May 2026 02:05:46 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA0CF58051;
	Thu, 21 May 2026 02:05:45 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.96.83])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 02:05:45 +0000 (GMT)
Message-ID: <8a9b4048f2c6427f7dfe9204e1304226cb4c00a0.camel@linux.ibm.com>
Subject: Re: [PATCH v5 03/13] ima: Introduce per binary measurements list
 type ima_num_entries counter
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <20260429160319.4162918-4-roberto.sassu@huaweicloud.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
	 <20260429160319.4162918-4-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 22:05:45 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAwOCBTYWx0ZWRfX9yyMohqY41tD
 c/CaQr+ly9rC8nP7ZfVYu1X9ntV8YTp8rZCp1de3x6R7SZD0W6NLay9D7preoAkCKyMv4N+epoL
 egK5UZty+RIGYkF2NjvI2sYK44LaLol5eevQKy2ZkJqKvTGac1292tqCUwXDciYj0JMGw0nO41J
 o39Gq6NAq5LtN9tOlqySGmtwjF3NYskcG+gSpmVbi+uXh6sqssLmEl4sAIxxDXQZb4n4711xqYM
 VskTlO7jgJGxe6A4yP3LUSaIl4HZW/MnS3bZeGvOLzy4hqyPON4T+9gBlNaLwGkbxBAFw8ufPUF
 /2V7dFHspyMYH4s/lA4jjZHImN7DpiByDdaXVK86ludVKzpdoHMVVmv+n2iQOKZ14UHlXowIlCq
 ISpJBJGgpgi/xBDPVNDz+9yoLDMW9CjzAxBbsT7yFRaURjcLtzV/SgNo937tffBBI63br6Mr8vp
 53zYrV9WTmgsRdAxhFQ==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0e687c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=qFvNTfHZ_Iwqsdsw8qMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JXgDXTn5XCkYsxx0wICNwaFJhjW7Kpyt
X-Proofpoint-GUID: muKooKU4p8ibLd1zjwSYwGDinzUyzfhM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210008
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9612-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid,huawei.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: D98BA59DE01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-29 at 18:03 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Make ima_num_entries as an array, to have separate counters per binary
> measurements list type. Currently, define the BINARY type for the existin=
g
> binary measurements list.
>=20
> No functional change: the BINARY type is equivalent to the value without
> the array.
>=20
> Link: https://github.com/linux-integrity/linux/issues/1
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>


Thanks, Roberto.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

