Return-Path: <linux-integrity+bounces-8301-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gINEEkjNc2kCywAAu9opvQ
	(envelope-from <linux-integrity+bounces-8301-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jan 2026 20:34:32 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F247A2C8
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jan 2026 20:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1D45303789D
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jan 2026 19:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2015243968;
	Fri, 23 Jan 2026 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E4YdWHvM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA511F75A6;
	Fri, 23 Jan 2026 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196855; cv=none; b=TnCZbDuxk0fwYeTMb3qvquh6fpZO/6WsZcN5VNX3mebHOPppKcj5ppJPV+wbvTJUSr9aTT/aMhz7VAMuk79nmxw4CPxRmFqZ78b7Jov20F/3T+BX6Q5avjcilDkWaKSIi0yF5XWPdQEJhP9NKhf08rAnl+FqwaFgqfIpF7+ITmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196855; c=relaxed/simple;
	bh=xuQr9Z0QS6Fl+Zy9Z56YcysxtYuM9CRIRlkRPvngG20=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=UQSGeqMV0f2xMM5CAk2b3Rl45hY+irW2iW9evUW8ANSYHWPlKhj4Lb66HH1BKB+tYh2odFyEMSU/tG3r+YHoN2aj9NIwoyia3xqaCG/8/7iR8uTfR5BdCRddkXHje7o6259pLYWBpDS/AD9ZsVxo8Ke9qYQD4+NI+9HqijVnLvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E4YdWHvM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60NEGIPe019632;
	Fri, 23 Jan 2026 19:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=46aSM1
	ukj3dOAPDlSxPx6TNEdWRvoAhJb9J4xQ0omM0=; b=E4YdWHvMhCbeRM/WtVgfli
	4r/zbUZaWKUorzaVOKhNJ/pXDNZV1avxPPWtj1gU4Z14Ig1zz7OsaawWVAgBMlHq
	aFuM8oA+CvtXI/b+eCaPrsUXNzOqDN6H2aS3Vah5ONt0S4HH4VyTXtiXta6N7Jtc
	tDWzRWm0iR6vHqI8ojqlvkkB4sVVDgtxIfFEAGm4WCkiLq+wxlafzaVFYc/GiDAZ
	b9vNTxHLAAQmXKFUJU9hxijOO5oRJqbzcO738MEpHug1F5Nb1X64EKkJOxT4KVIL
	z4FuFc1CXgwqtS0OEZkMZTGM1claFID0yK7R76+13no+Lc8/X/CsJSgz/7yL2H3A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br256hyeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 19:33:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60NGwS24027220;
	Fri, 23 Jan 2026 19:33:57 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrnjxuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 19:33:57 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60NJXvLZ33161852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 19:33:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AF5858051;
	Fri, 23 Jan 2026 19:33:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94A865805C;
	Fri, 23 Jan 2026 19:33:56 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.82.113])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Jan 2026 19:33:56 +0000 (GMT)
Message-ID: <6492e9877a11d1c959fb33e59e07dd7d9e8547d4.camel@linux.ibm.com>
Subject: Re: [PATCH] evm: Use ordered xattrs list to calculate HMAC in
 evm_init_hmac()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, paul@paul-moore.com,
        Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <20260122080717.1772063-1-roberto.sassu@huaweicloud.com>
References: <20260122080717.1772063-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Jan 2026 14:33:56 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE0MyBTYWx0ZWRfX36qPtpJu7J2t
 YITwnLvsBdlpRc4HoRWfVwSaeSqcRz42X509rP1nkN0AcM/9wW+9TdHhvbCHemV1wPJicmuYhGb
 asQw157kK026o8JJGOkJLRza70Sp33LSpJv/LCh+g4Nb+TZGoTh11Cqlonwr7Pp8Vu0WpcTyUs9
 Ca2p3q0lIctMPzd6iU3yokdHm5y6RuYDBTpDXwfN6HWU5kCT42/rc5Pnzav8pC4BOnYq3L2EjTd
 5lf264x2a1HDUr3hTsRgc8g9wy8b9yJkzxhNr5aJdNLOGSaQlGVcmAcCbtT2mSVqelxUOUascvy
 Wl3YukLB/aJ/ZV69w6xEcnzllMb+YVOBlO0aH0lDlrD8HdoM+6SP6u7qnTteKzxzA7IxYWrpX0D
 vXXlk8hUdVjlndYWJodougHOJ0+YBDaFJpPq03ThkGaBWWVjUqKHLwk7KtyQXzz4g1OW2519kDB
 35ivbXeXgeMf1DCqnEg==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=6973cd27 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=Rs3fgSgONZKKpvqWV8cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QjburpyhoeJg8ilwM7kVyN3Cnb4LCgTR
X-Proofpoint-ORIG-GUID: QjburpyhoeJg8ilwM7kVyN3Cnb4LCgTR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601230143
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8301-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-integrity];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: A2F247A2C8
X-Rspamd-Action: no action

On Thu, 2026-01-22 at 09:07 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Commit 8e5d9f916a96 ("smack: deduplicate xattr setting in
> smack_inode_init_security()") introduced xattr_dupval() to simplify setti=
ng
> the xattrs to be provided by the SMACK LSM on inode creation, in the
> smack_inode_init_security().
>=20
> Unfortunately, moving lsm_get_xattr_slot() caused the SMACK64TRANSMUTE
> xattr be added in the array of new xattrs before SMACK64. This causes the
> HMAC of xattrs calculated by evm_init_hmac() for new files to diverge fro=
m
> the one calculated by both evm_calc_hmac_or_hash() and evmctl.
>=20
> evm_init_hmac() calculates the HMAC of the xattrs of new files based on t=
he
> order LSMs provide them, while evm_calc_hmac_or_hash() and evmctl calcula=
te
> the HMAC based on an ordered xattrs list.
>=20
> Fix the issue by making evm_init_hmac() calculate the HMAC of new files
> based on the ordered xattrs list too.
>=20
> Fixes: 8e5d9f916a96 ("smack: deduplicate xattr setting in smack_inode_ini=
t_security()")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks, Roberto.  The patch is now queued in next-integrity.

