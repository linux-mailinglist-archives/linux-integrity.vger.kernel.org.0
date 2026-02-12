Return-Path: <linux-integrity+bounces-8490-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD7ALyMujmmcAgEAu9opvQ
	(envelope-from <linux-integrity+bounces-8490-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Feb 2026 20:46:43 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E882130C40
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Feb 2026 20:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0CD9301BC2E
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Feb 2026 19:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099CA2F7462;
	Thu, 12 Feb 2026 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RNa8Hvjv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34532D061D;
	Thu, 12 Feb 2026 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770925597; cv=none; b=t4gM3DlXn+72xzDbyiGN+CD6nMPrJgMRq+xJmwd90GcspTRQmLyYKJBC0sk+ZzxklN82R6TGshRyKNev940oIi6qkpItcMlWWEVUNj4sKduzChpUc3ZrKf7/Lz3yvzwLmUNVYjoEde5O+JJtPqY6xRX/W34BkIUFr/pobWInRcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770925597; c=relaxed/simple;
	bh=pTG234008tRbkTBxx3ORJfpeN7UA2onmfbaOSaaNS7U=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ewctuCOmxFaiUAVq8R6kTKuGPSSAwrIF7QEvS4PnatuQKCe7S0EpMnwiH0YllxaUYHS+zoTIPhYMiyMwNiOgL/2eRe1WKq67VrVlMj9eB8vkiqI4rCZAvFU5TcAM2+kb5XYkrLvTmCztsUMO5buDi5C4ob9dedz5AniLMhds7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RNa8Hvjv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CIimjA397449;
	Thu, 12 Feb 2026 19:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SSYnjC
	riNfH4sLLJojOS+mFuvtcCUNULF/0jTmqFPLU=; b=RNa8HvjvMVRQlWHq5e+kmU
	gMi+xvDAvU+aI2QdEBtcvTKlDnQiBhmvBweQDCP8m37XkyKN8usevxWI2iBHtguy
	1EqOIXBwGQhxWSPEG+RHxUZ0MomChSlSNKeDaiuTwwFYjMuaS+NAtshHvsjJ6hoD
	vYAyTpsWcPJYYEn3x28EUb9nQ8KRs9yX6mVKrYip+xXtNlXmv4qTWLsD6fIFvbc/
	54ewjogy3dhNUFBxa/mN+x09AtJYxQEs5Ce6b7N4P/UmYOkaer6rsrI/sXWsSwKi
	Ro80QccvFlEiXyumcUgDdc6KK0M1DYtRqJSoxCINqWWOjZ4aSd8X91vRhIc9zooA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696wfx49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 19:46:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61CI7fJq001840;
	Thu, 12 Feb 2026 19:46:01 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6je2bq17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 19:46:01 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61CJk0bw10486378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Feb 2026 19:46:00 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C13A5805A;
	Thu, 12 Feb 2026 19:46:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A3D358054;
	Thu, 12 Feb 2026 19:45:59 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.21.193])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Feb 2026 19:45:58 +0000 (GMT)
Message-ID: <50c5e00a8c336e8ab393457af009c26902114688.camel@linux.ibm.com>
Subject: Re: [PATCH v6 0/3] ima: Detect changes to files via kstat changes
 rather than i_version
From: Mimi Zohar <zohar@linux.ibm.com>
To: Frederick Lawler <fred@cloudflare.com>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner	
 <brauner@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Jeff Layton	
 <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
In-Reply-To: <20260209-xfs-ima-fixup-v6-0-72f576f90e67@cloudflare.com>
References: <20260209-xfs-ima-fixup-v6-0-72f576f90e67@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Feb 2026 14:45:58 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=698e2dfa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=ylXcmsPOALl7ZWSU:21 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=_yJuncMy9niaL0El4z4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bsN-HBLmkWsRPLeKV2NtS_-6MPKAxi7s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE0OSBTYWx0ZWRfX/ipuTDKZNfif
 PZL1byCYEoAFaNetmO7RDSnlYv2zQFOc5YPeQbnQy08dWtQFB3j84iY5TiXrP5wLrxoz+AZPQb3
 +hgVTXeEF7QtTMxbZzjZGthwubJC6OVxsqm+MsxS8hWcd7azIMikm3YscnSjD3M9u+Cu0g07sp3
 bXkywOdVityXVsvWlNjnKFF+H9XXbVjNM/YqHQMNoNZSFvfzGeoWheWv16zyUvcp+aE9PaRr+p/
 cArPxB69nzgG0yLaWYDIvul3yn/JDNWl/xIZxfvajSD79+xcVLBEAEPrEiDj0e29sHj8bvYIlxJ
 1I7q/sioBFccRy3L7fkt8+Lg8stAUhPatTUWyBt3PQSlvtYqWAKQqqErH9BgloXR6gREsQw0O7C
 7fy0OmMofXU7ZVA6CUpQPojFv7/MeS9M4gA2xo7+vNgVK+gCFHCDJfISjebGrx/tb6xtYqMzlGK
 zFvfxfHwlIOrWBUfedg==
X-Proofpoint-ORIG-GUID: Ut358nOCft74tA6DE2R2NWjsszAsu0Da
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120149
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8490-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[cloudflare.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,kernel.org,toxicpanda.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 2E882130C40
X-Rspamd-Action: no action

On Mon, 2026-02-09 at 15:21 -0600, Frederick Lawler wrote:
> We uncovered a case in kernels >=3D 6.13 where XFS is no longer updating
> struct kstat.change_cookie on i_op getattr() access calls. Instead, XFS i=
s
> using multigrain ctime (as well as other file systems) for
> change detection in commit 1cf7e834a6fb ("xfs: switch to
> multigrain timestamps").
>=20
> Because file systems may implement i_version as they see fit, IMA
> unnecessarily measures files.

Statements like this are wrong and certainly unnecessary. Refer to commit
db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version").  Directly
accessing the i_version still worked on local filesystems.

I'll be posting a patch shortly that falls back to directly reading the
i_version, when STATX_CHANGE_COOKIE is not supported.  It cleans up the fil=
e
change detection code, making it more readable and should simplify adding t=
he
ctime file change detection.

> We're proposing to compare against the kstat.change_cookie
> directly to the cached version, and fall back to a ctime comparison,
> if STATX_CHANGE_COOKIE is not supplied by vfs_getattr_nosec()'s result
> mask.

Please rebase your proposed change on this patch.

Mimi

