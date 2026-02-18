Return-Path: <linux-integrity+bounces-8512-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBsONV4ilmnYawIAu9opvQ
	(envelope-from <linux-integrity+bounces-8512-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Feb 2026 21:34:38 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7098515978D
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Feb 2026 21:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 559F0300617F
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Feb 2026 20:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C013A248F64;
	Wed, 18 Feb 2026 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Aa1k1C+z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EF13019BE
	for <linux-integrity@vger.kernel.org>; Wed, 18 Feb 2026 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771446874; cv=none; b=SYYHdKzuwbDkMHsX3zc0VFVPbeUD4gZTfOSEC3uMd0tnJBSpiW4qtapOF0LtVg1vl5clAYkccRKmR4X02bTmagP2nAY08i5RcD0X7L3wvBhziZc93In7IMXAA+th/WDr6sCXQacg+5FKNJ757pOfDtColLiEfVbVa8oPIvwBx4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771446874; c=relaxed/simple;
	bh=A7Q+JUcty3eUYeSn8uunWE7txomFOUbFjOJQYTFDUYE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=HB+ZuferLM2YMlBnzVdGto9qlgLvVzP8QPNtWhpEcXd/mFbraWqCHjemnxvE5m4i25EZphyuIUDy8DIWPJlIG2hmINl4D9yMikAsIlLlkP/osjgHIgx5n2Nl9STH4qRe9DHzwHkHaCLv38UsyQf91DGy05nQSn/NlbS0aE/9UKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Aa1k1C+z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61IAaohh3664605;
	Wed, 18 Feb 2026 20:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fZAhBl
	75zpYnOKQseLph/fJLlpU/dYFjLzerWnzVNME=; b=Aa1k1C+zR3+4B5i7i6IchE
	iaZzYeAnMFk9P3YeLVYrIUAUiDKbHMPQ1AVW+0xGShvtTuNq+7hhZ7cQxnT3vpzv
	N0FwXnxAhf881ZaXq/xS9H8vJ/WYpRbe8Hv3gPluNwBrlMP7UtmOTDL2rmxU2m92
	70UzSmujdrWOdDbKOIMmtf39wjpecgXh8jinzT3wdfFoTs5LBYomHEbHH/Jqhp5I
	rJx5PsL5VBhRpV84QA46WIYrCmR53s3nJ1fn1BisyHbYmUE9QeoxJpdizW3kyT1k
	x/5nk6F+N3c3ZzAj7H0PDybVwKVuAN22w0UtlxfK8r8WQmJ1TLskJBnBTTJn8AOA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjj09j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 20:34:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61IHMGAo011912;
	Wed, 18 Feb 2026 20:34:11 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb271fxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 20:34:11 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61IKYAq326149528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 20:34:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B85085805A;
	Wed, 18 Feb 2026 20:34:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69B3E5803F;
	Wed, 18 Feb 2026 20:34:10 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Feb 2026 20:34:10 +0000 (GMT)
Message-ID: <6624db4e55eedb555b38a6b1bd56243493419f5d.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: fallback to using i_version to detect file
 change
From: Mimi Zohar <zohar@linux.ibm.com>
To: Frederick Lawler <fred@cloudflare.com>
Cc: linux-integrity@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Roberto Sassu
 <roberto.sassu@huawei.com>
In-Reply-To: <aY-ApsCkJQ05-FIk@CMGLRV3>
References: <20260213174947.976924-1-zohar@linux.ibm.com>
	 <aY-ApsCkJQ05-FIk@CMGLRV3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Feb 2026 15:34:10 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AwA2tA9nDatGnxNby1ktBijIzjtzg6cu
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=69962243 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EG7W4yiQAAAA:8
 a=GWZrtOqQPpmB_2jjjMAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE3MiBTYWx0ZWRfX5AnNYV+FnIRt
 mQkYunksWDHeASKOchXgXts88p6cqVdAdRgI3VMDS8uNmoiFsvUJ65EB8gjw+y6PT4u3GMpcHQS
 VTtOEyA4aBv0LNbrNOrB4GQ1beqzhGfDZ8tmdYAYBDok2t4joNCF22R+W+TPAUOwa4kg3rnjABA
 UMofyM5PtnYvTH8DIFVaWYYWmouyP91Z8c71t6163NzX9TlvbCpnVnqVUN1Hqq3V+4Db1H6ZLkf
 Rp+8cKL8jzgOQwWM4PWEvT9wA4PHjZGx2KMdW2t+BQrA/J0BdAJeN3IGv5ptKmtth1UUD6uckKy
 aJfcliO18u76t0lx9lxlydRHbxttbWyirxyFG2G3gpWyU5UQ5Zix3ThkLPRYf9M6PeHwq31SPiz
 FRXP5hhSqUNZSaE+3C5oxY4ByVpYuQST/6kWvYksxndgvllK+jU8TfZ/q6QOxQqGXkJHrC82NTi
 m6whbuuwTx/GxMwk5Sw==
X-Proofpoint-GUID: AwA2tA9nDatGnxNby1ktBijIzjtzg6cu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_04,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180172
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8512-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cloudflare.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 7098515978D
X-Rspamd-Action: no action

On Fri, 2026-02-13 at 13:51 -0600, Frederick Lawler wrote:
> On Fri, Feb 13, 2026 at 12:49:47PM -0500, Mimi Zohar wrote:
> > Commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
> > replaced detecting file change based on i_version with
> > STATX_CHANGE_COOKIE.
> >=20
> > On filesystems without STATX_CHANGE_COOKIE enabled, revert back to
> > detecting file change based on i_version.
> >=20
> > On filesystems which do not support either, assume the file changed.
> >=20
>=20
> Tested-by: Frederick Lawler <fred@cloudflare.com>

Thanks, Fred.  It's temporarily queued in the next-integrity-testing branch=
.
>=20

