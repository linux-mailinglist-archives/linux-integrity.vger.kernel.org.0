Return-Path: <linux-integrity+bounces-8986-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KuPIlVMs2mjUQAAu9opvQ
	(envelope-from <linux-integrity+bounces-8986-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2026 00:29:25 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E62A627B457
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2026 00:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BD8F3002F91
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Mar 2026 23:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495383BA246;
	Thu, 12 Mar 2026 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ff2LExjI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7519381AF0;
	Thu, 12 Mar 2026 23:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773358162; cv=none; b=Ye+Pdc9jw8JEHGGvWUdYNIwsQyzv+Lb5ff5kjH7avSbba4xR3NPdrJtqeFn3x5ildaARCTZg7lCJ375yJKlQHk8YSdMmlnDKhWRHYZ7Fl4oRsfFMUh30Srn41W54xjTUA5oRLiBxFcndT3rmV3j0OEZ4jiyjFtTpwZ4gjiOF6Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773358162; c=relaxed/simple;
	bh=HVckZe6uOXFDzy2maMy8UWVoRAnqAMdmbw/yWetzAIA=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=W7OiI2JdOQJmxh1X/7ToHc2l/Zxdpf/arE2fGs/63A53I8G/Gnmg6MSOuKEmVo6myiZMzVi1TMrtL8PAnYZMTapN7zZnfQujG825i19Ur4Siav43QGOesRK4J7M58i593o5PEXXjDYGBMx4NnEoTmG13ETYZDsU71bJpq4zP9aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ff2LExjI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CE4dbr2277871;
	Thu, 12 Mar 2026 23:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YdGHaX
	tsaBMc2cJi7xl+DfXdP8fIaVn5mRlM2pdVS1Q=; b=Ff2LExjIZwqY2NYQw3xueC
	Ew76mBShDoz1f1O9Mw0OX6haiSqeoiAmuU2uWZinKWgilxqZMZlZdb0Vg3eVbdSe
	orhifVJZpCiOjTVNc8TQ0eRNsudebE2tAlYKdiodE1xqdzQV4J9/PXhxMQhxQoTa
	YwclPkzT0Aw/aD9BGU4hhHS2RjhiFcgFa0mi1hSz6QIVBkCu3oT0pav2nbYGrlbz
	JU1qepbj2G7WEmEcw8XXhErcSeJIrQpoibNjSqPwyQxTatgZ9aFfwykC8BobOOKh
	ihurPfA208TzxmLuoJU/BY/sMN3wDW1f+1JC6veRavwx/lO/S9B5r6HGSuJWoWmA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91n8mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 23:29:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62CIU6UJ008855;
	Thu, 12 Mar 2026 23:29:07 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha74f46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 23:29:07 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62CNT6QD33882692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 23:29:06 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 711A358052;
	Thu, 12 Mar 2026 23:29:06 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE80D58045;
	Thu, 12 Mar 2026 23:29:05 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.148.157])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2026 23:29:05 +0000 (GMT)
Message-ID: <1c5f16f0913bae48bf2f24feaaaf3525ecdf4c97.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: remove buggy support for asynchronous hashes
From: Mimi Zohar <zohar@linux.ibm.com>
To: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260312053933.53012-1-ebiggers@kernel.org>
References: <20260312053933.53012-1-ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Mar 2026 19:29:05 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: tuFJD93rQt2-ourjkBQZvSV0CRkMpYfG
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b34c44 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=M1lwNKzopv0IjOVRZAQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE4NSBTYWx0ZWRfXwv2Jxp38834c
 gOCp/l5g3cTuTyuWT7i8kqx3LQYILKHyFC0PEHvLBGZzJWbmtqrXVqx4gKLvgUmfwb71gO1wfhx
 EnJnbDchfqVPWHxG/Aesx9wZXD1S3LaiBvk6f4xPHWK+2xgJO19J6rxDH6i3FfeULnzzdr8ZzXA
 88AeuM8Wc36TOfItqmmqf3QxFK9G7X8VS5zaKeMc62CS+onk4MshdYiN9IuxxMXo+jbB9YFguWW
 sXEJaagm/6QOao4Xhh3FugvWpHungCIsFh8wF5I0SZk2t8kt4FTUBVtaWOTgAm1qDq/QaGCCpTw
 +YA89n6RmS5Be+Lz7bprBSj8cq9ZWN/F8iU9OqpbJ4L6HjWKf2SujsYkGWKUzIlR25My9vvWtJO
 5zX33KmbEvdrdVl6qLSL555KxSJpIihjmWQ9XXudDhVog33bBCW0+7FzS2qETJprOnTxYe6ETRa
 xjChO4FrZj5OXdX5tOg==
X-Proofpoint-ORIG-GUID: SQaYzt5GqpusUkQQv835gltrlGmbVQDs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_03,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120185
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8986-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,huawei.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: E62A627B457
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-03-11 at 22:39 -0700, Eric Biggers wrote:
> IMA computes hashes using the crypto_shash or crypto_ahash API.=C2=A0 The
> latter is used only when ima.ahash_minsize is set on the command line,
> and its purpose is ostensibly to make the hash computation faster.
>=20
> However, going off the CPU to a crypto engine and back again is actually
> quite slow, especially compared with the acceleration that is built into
> modern CPUs and the kernel now enables by default for most algorithms.
> Typical performance results for SHA-256 on a modern platform can be
> found at https://lore.kernel.org/linux-crypto/20250615184638.GA1480@sol/
>=20
> Partly for this reason, several other kernel subsystems have already
> dropped support for the crypto_ahash API.

The performance benefit was the ability of reading and filling a buffer fro=
m=20
disk, which was slow, while the other buffer was sent to the crypto engine.

I'm all for removing extraneous code.  I'll give it a couple of days, befor=
e
queuing the patch in case there are any objections.

thanks,

Mimi

