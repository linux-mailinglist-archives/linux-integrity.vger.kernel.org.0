Return-Path: <linux-integrity+bounces-8324-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E6FLLnwd2lQmgEAu9opvQ
	(envelope-from <linux-integrity+bounces-8324-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jan 2026 23:54:49 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5692D8E137
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jan 2026 23:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EA06301BF65
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jan 2026 22:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EF630ACEB;
	Mon, 26 Jan 2026 22:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bjImzDaz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CC246BF;
	Mon, 26 Jan 2026 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769468070; cv=none; b=r939mJ1/Se4DVDnEt2PbxlHv/ZlNM1dL/tdj6jmEXCaTZb1wK2MMznujUiCDlrHS8e0HogyCNo+YOxIMCvBdi3Rey7v7MjpSu2wNUnESiwk5XDRymvG01+TlxDrRssRh6aU4BfoB8RQDuwFUKf7dty+k+vZEzESn5jL57EiCzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769468070; c=relaxed/simple;
	bh=0t/x1+xmXiNt8wRf4YXLudTNjj/5T79xvMXIXQKW7Gs=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=lXKBn1ijhQmxzcEV29inqU4WFPXbzAnhoKh7qbn5H9bRwBsLg4esjeDQ+rmAdi/p3BJrnP10fS6P2T3LifCsr4Ze+1aeUWetcUO276JFPnmyF3072LRpdl2lzNmn6Zi+8JVL9trijUNt3cFCKLfiUNpj1iMiBMGFwDpJ33PqfaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bjImzDaz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60QF9VVI028672;
	Mon, 26 Jan 2026 22:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V4AraM
	+tjSb7tuquIhdtNApqz2ITqaee/toWx7C1OtQ=; b=bjImzDazxJedK/7gZHibZr
	OwUdbAqm83drlD6GkFF2Vo5BpVMcYoFNsLHpYNSum4fN0lqJC/tXuKp4OX97J2jl
	r5SJS8LXx3Ceg7o0nUxTm18XH34IiVwMzB5HEEcm7NLPWPSpkThat4wSEILX/4mp
	6irhFK5Cyw0hw5C7Qj0doaReQL3Si3pmaFekj//fh23AefncRRKzkWfOCXiLssSp
	80wlM4Noo1pQ5H7oyqHWjSU0GQrU1HvmKY9TwawIcB8umA+zYxoP+BNzo57zGy3t
	6IHk7CDWehv6p/h8h2UchOKs1rq7wTzmpERLLR0CgKmpj7w/1bNnsSmsTYjag9+Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfs4v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 22:54:11 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60QMsAW0026839;
	Mon, 26 Jan 2026 22:54:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfs4uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 22:54:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60QM56sg023722;
	Mon, 26 Jan 2026 22:54:09 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamjp7un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 22:54:09 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60QMs85731261322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 22:54:08 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8D3758058;
	Mon, 26 Jan 2026 22:54:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BF715805C;
	Mon, 26 Jan 2026 22:54:07 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.101.155])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Jan 2026 22:54:07 +0000 (GMT)
Message-ID: <87883fa611e27f8aa018e46e344846d692700402.camel@linux.ibm.com>
Subject: Re: IMA and PQC
From: Mimi Zohar <zohar@linux.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: Simo Sorce <simo@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg
 <eric.snowberg@oracle.com>,
        Eric Biggers	 <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1988760.1769463419@warthog.procyon.org.uk>
References: <821cb2becf70b2dcb903e74685643f8b60a5cbb6.camel@linux.ibm.com>
	 <1783975.1769190197@warthog.procyon.org.uk>
	 <1988760.1769463419@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Jan 2026 17:54:07 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=6977f093 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=9fkz2sjyhvhVFgQLucQA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: og2OEGZQp4SVYi8DyDaPxzNHyV5Nw-5r
X-Proofpoint-ORIG-GUID: ea4Ec5_GoT_pvcjdNgib1LdBfwGH3S0q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE5NSBTYWx0ZWRfXygZqNAyg1Z/3
 /fseEkxemCLBzyG25XzPW5nNTIXlo8P6B4391uX0Cghr4GOPo6PH9A4ajWxsrAfs9EV6oOsJEvr
 FACcfXmSfml5HbVsAEcajznAnQxvWepT4A/KptDwaEF7ZQ6NXgps8NMDGnA1M6BXcJ4cK7cxzek
 oEGxwoz842fHim07mHFq7KpDMA00hf9lXuX5kSn/5+gilvuc2TVHOHqg7QLkJ+wMIp03oHlDSyK
 0q/PN7Ww2lElNoUDV5DVzvKjbtH1FPPs105rb0e+j/1SVyTRPW9x2FFLVb+t2yJ4+/acUz+Kb7n
 qI4iflGzfg8d6+eUc6RgW5QcF6J28nSqsCTogMk345/qe263nqNRAoOWONRNbdluPCDQvxuy3Ap
 yMThs8G3uR+zVHkMWy5tkNim9leffwpsjrOOd94EnF1ZOO0p1grXsf/6dICoeGVPVNlL+gU9arM
 IzqajB31SifOPzr+Hyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601260195
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,huawei.com,gmail.com,oracle.com,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_FROM(0.00)[bounces-8324-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5692D8E137
X-Rspamd-Action: no action

On Mon, 2026-01-26 at 21:36 +0000, David Howells wrote:
> Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> > > Further, we need to think how we're going to do PQC support in IMA -
> > > particularly as the signatures are so much bigger and verification sl=
ower.
> >=20
> > Perhaps, but these same reasons would apply to kernel modules, firmware=
, and
> > the kernel image.  Why would IMA be special?!
>=20
> Scale.  I wouldn't expect more than a couple of hundred or so kernel modu=
le
> and firmware signatures - and, for the most part, that would be done once
> during boot.  On the other hand, I'm assuming that a lot more IMA signatu=
res
> might need checking and maybe more frequently.

Similarly, most file signatures would be verified on boot and the results c=
ached
to limit the performance impact.  The number of file signatures needing to =
be
verified is based on policy.

Mimi

