Return-Path: <linux-integrity+bounces-8452-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAX9BRschGmyywMAu9opvQ
	(envelope-from <linux-integrity+bounces-8452-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Feb 2026 05:27:07 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86331EE8A2
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Feb 2026 05:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 413BF3010BA7
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Feb 2026 04:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD0F2E8B8A;
	Thu,  5 Feb 2026 04:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QD5IDolM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3045F1C860B;
	Thu,  5 Feb 2026 04:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770265624; cv=none; b=BOiRwAob+xmOHNGKdi0Vq05I3q6XXcALe5Wc/T4umaxoxeJQXu58LWRv1W+7SQm+yC+c7RQANdYBQ8hYYy/XX7dHCSGJRO7vUfAHBYekfVWobzaTzaykvrzHRZNpQtDanuZh5X3qVZP9f+3QG2HYCnxwbG5eoKjs1FO+65iHU3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770265624; c=relaxed/simple;
	bh=RP4IfRqUPu9X41sG6CrMhkiScQA7dWvhTYysPcQngLY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=hNPOrJYFl9KwMXAYTcl9KAiOt5ZULJx4DkIP90IPce/SO4/IP6sqXVK7mKtxUyJULwByfhR0ZUQAQ+fwJwf3fLPE2O95VIsGoFp7qjey7ZgolI/AXXwxnhYM6in1BdRc4Ks0yyZOpJE2Xq2GpOUua+IAlAILD4e2IVDTd1cjvnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QD5IDolM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6151KDFe027389;
	Thu, 5 Feb 2026 04:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RP4IfR
	qUPu9X41sG6CrMhkiScQA7dWvhTYysPcQngLY=; b=QD5IDolMNdcYP2bXqqMOvj
	2dUVFKE5DXWhn1eJzddXKj70EWgIiKOelDrSuGhW33WNb1GXF09yYmFBSdJf5mTY
	98DZTbtnWtcp0j2r79bQBZxXuDkFLHsuWP7u4Pr9XiYJDd+eTDGJK/Y5fS9u/vwc
	H6oo1MT9qnc+8zabmVaB8n46QrC4odAbsf8WpfdAzNRBFtumtmaPZh4h33ZMvNoL
	awE5WFruCTLH5CQuKL98PbGXilwVYNMZIctf1YhjCtqxURlRjSklKUKV11HEasAn
	axNKVTe+4c7bkUBe8dga3UaXSogUBgGYu0gBhmXd3Ijclj62t6NtlPjn+Nvv4P0Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c175n2hb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 04:26:32 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 6154QVMS029415;
	Thu, 5 Feb 2026 04:26:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c175n2hb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 04:26:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6150YV1u015800;
	Thu, 5 Feb 2026 04:26:31 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c4gsgrkvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 04:26:31 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6154QUmZ15794796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Feb 2026 04:26:30 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 299EB5805B;
	Thu,  5 Feb 2026 04:26:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 823A058058;
	Thu,  5 Feb 2026 04:26:28 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.93.65])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Feb 2026 04:26:28 +0000 (GMT)
Message-ID: <6f82d5dc6b499ecd03c985d6de20de94fea04cfe.camel@linux.ibm.com>
Subject: Re: [PATCH v5 3/3] ima: Use kstat.ctime as a fallback change
 detection for stacked fs
From: Mimi Zohar <zohar@linux.ibm.com>
To: Frederick Lawler <fred@cloudflare.com>,
        Roberto Sassu
	 <roberto.sassu@huaweicloud.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin	
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E.
 Hallyn"	 <serge@hallyn.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner	 <brauner@kernel.org>,
        Josef Bacik
 <josef@toxicpanda.com>, Jeff Layton	 <jlayton@kernel.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
In-Reply-To: <aYO4fj0Uw0aUWXOX@CMGLRV3>
References: <20260130-xfs-ima-fixup-v5-0-57e84ea91712@cloudflare.com>
	 <20260130-xfs-ima-fixup-v5-3-57e84ea91712@cloudflare.com>
	 <c449523aef301a6b199e06d4c3fbf7587d1218c5.camel@huaweicloud.com>
	 <aYO4fj0Uw0aUWXOX@CMGLRV3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Feb 2026 23:26:27 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: isB5NKNz9U_iFU1lLWLg7WY9YxRtM4db
X-Authority-Analysis: v=2.4 cv=VcX6/Vp9 c=1 sm=1 tr=0 ts=69841bf8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RobKdUFHg6JuvS5dcHMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZnH4SyeQhBDME7XvwUD8PyCjWpuOZnnL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDAyNyBTYWx0ZWRfXzo6jxa4pO7Vu
 JIchXLuNAFTu1HXj9YCRR58m0H3qWnmshmHdBYp9Ov1BhGoAxG0ygNIBse54jGGxVb28ikGEPeO
 tzWbbovSIUvJ7Tq+nVusS/HDoMGWDlOVnFkHZwBeNz3bEwk3nmWYEFdAREwSEHqpaONdQAdWZQU
 BR0wKuyOjf2BQVtrDob2vU2mIO1DfU8hMctVZHR6jw+3vake0edezrsHRAI4ReWa8o0Ilx6oFla
 qxPZZ1Kdfwsji3k5pWEYhhFtnZ1SGxUwEEBHjk8MJfoFI5gXUsvVjRRkb7aE8Yk8g0JTDJU4k8A
 A/06ndAb7JfFeu6t+VNwYGQlAHJNkJtUR84z3zynm0CBE3V6FABsY0BtoOyTUvD+qNaFBizWI0v
 3gYW6R2ZyKzNd8TT82a8jQt4mYIChyItPbu4Oe5FvTlIi9ONDbNFn4y06jqv+nZ5jD7KTcZmopZ
 MZ3UqHe6R0IqiS7aBjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_08,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602050027
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-8452-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,kernel.org,toxicpanda.com,vger.kernel.org,cloudflare.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86331EE8A2
X-Rspamd-Action: no action

On Wed, 2026-02-04 at 15:22 -0600, Frederick Lawler wrote:
> That said, I think Mimi pointed out in an email [2] where multi-grain
> file systems are impacted regardless of stacked fs or not due to the last
> writer check.
>=20
> I don't recall coming across that in my tests, but perhaps I did that
> specific test wrong? To be sure, I created the C program, and on the VM,
> created a XFS disk, mounted it on loopback, ran the rdwr program on
> "somefile" multiple times, and only got 1 audit log for it, until I
> mutated it with touch, and only got 2 hits: original + after mutation
> after running the program multiple times.=20
>=20
> I'm not sure what's going on there, so I'll look into that a bit more,
> but so far the impact is stacked file systems & multigrain ctime AFAIK.

Make sure you're testing without your patch set applied or at least the las=
t
patch.

Mimi

