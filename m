Return-Path: <linux-integrity+bounces-9089-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIyAHgiVxGnH0gQAu9opvQ
	(envelope-from <linux-integrity+bounces-9089-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 03:08:08 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D032732E384
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 03:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98C003074E02
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 02:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A01390221;
	Thu, 26 Mar 2026 02:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KUps8xI0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30E81D9A54;
	Thu, 26 Mar 2026 02:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774490470; cv=none; b=o418dmq2cQS5n5PjbT2AtQYgMzWbXMHaF0HGpco3xj7TjfzVcGaSaJPuj8tZW7KNiKSQvaqGjthmdfdzZGXYGx1Gj1d5T7mhAzJG2xM80VLYdQT89yHgg2/brodjg9QhQgrcT2huHzKz26D4DNEf9nW5pmM4WzxWAjVpVsxZrTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774490470; c=relaxed/simple;
	bh=zxYMLwpruA5laFjuXunWu36BO89QZDNCdx1m1WWkXuE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=l2byDNjNKzEqYpp8/loHTk8fkT59uEtdU2SvkxSlqiotZKxcsbMRewrti1MYrueFELv26YK6/dJb4DNcDXDA9UqMptFRJH/ZJAvARUSDiKb56ugLFzxoe5YTxmVCOi1NgazH/UpB2k+Q+tzNHE4fM4kIlOJbsX2ue+3zbkssWC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KUps8xI0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PJ9eP23835878;
	Thu, 26 Mar 2026 02:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u9gGqs
	mLJItwfNVVlqA1KeC9cSvc49oDFBkverBawuQ=; b=KUps8xI0Q9LpST43vl0i0W
	tj2QJto9dIWYzK2MByOQVFgVgHU7FdG5TOHZ02C5K1yHbS1y/XQ9mY2ULO7dlWof
	2X+0Y25oZ0nojoX5FBI3A3L6a21YzusmWj0WXSVv00YvsW3NjoZUYy0+acfOScde
	lZfHoiswkx/JLzuiyZkoUcTghGEkAKs1apadnsQGDtA0teT7y2P/OUPymGW2jaMs
	gQitb++8XxZWa7i7guiUcTUYODm0sPZOKGY0zftQMA/4AXbEnphttO26cN4SncGr
	cjqI7GeMsAvbFGROBXGX9GxpUMmXIOZShX1aR0R+bxeUHrcGOpqiWaDjeNlGjgVA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky0a7tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 02:00:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62Q0I1fb005964;
	Thu, 26 Mar 2026 02:00:56 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261ys5qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 02:00:56 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62Q20tmR27591276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 02:00:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 991F658094;
	Thu, 26 Mar 2026 02:00:55 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1111558091;
	Thu, 26 Mar 2026 02:00:55 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.10.50])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 02:00:54 +0000 (GMT)
Message-ID: <d5d025df687fd90138507343d96dbed7b68546a5.camel@linux.ibm.com>
Subject: Re: [PATCH] evm: Enforce signatures version 3 with new EVM policy
 'bit 3'
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ebiggers@kernel.org,
        roberto.sassu@huawei.com
In-Reply-To: <20260325213349.1061363-1-stefanb@linux.ibm.com>
References: <20260325213349.1061363-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Mar 2026 22:00:54 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDAxMiBTYWx0ZWRfX2Jj0TNSNy2P6
 Ll4bJwkxZs6CU/wGHcl+MwrZBDDI4vEYtFU/W/RrWMaZLeMgtaio8NtuHVjAF69TWbUW/E3pBiC
 R4lC/5V5Q/nMjk230+fkAiszjTM51xbqI+eJ+0DUgBu94tvg/1k8RXJshMkfwFMD4FdJQgXI7rF
 8mMqfVASik38Vv5Rz/O+R4k+Ko/DgGgGzzd4QuMjHCBFV9fz1pPGSAb840yWJDSLJuIAKlLyZ83
 ZdCv3qJrALrcrseITOazdRC4aDBPjWZIdmDilX2zbe73+I0EtqOgaAkpYhMFpsl7p3AFA/3bUuE
 Gbr9+HtvpgfaYaSpAZzz8Ljpmlv4b8EXxFjTdFHR4xFv6CKhuioggKppkq+CnZz+v95ifpYneoH
 9tLSC5/Cazao55k7SBVqDqA9NiV6VuU88RC0KY7xBd8WrVfMw2X2Hs/z7I4sErNvm0KZ7GpyV8b
 uu3gr7le+ue0beWOseA==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c49359 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=S703qkuSWEuunT6D47QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: aU76p_wRzoM86Gof8fRPoSDdvmle5Ypt
X-Proofpoint-GUID: aU76p_wRzoM86Gof8fRPoSDdvmle5Ypt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260012
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9089-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: D032732E384
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-03-25 at 17:33 -0400, Stefan Berger wrote:
> Enable the configuration of EVM so that it requires that asymmetric
> signatures it accepts are of version 3 (sigv3). To enable this, introduce
> bit 3 (value 0x0008) that the user may write to EVM's securityfs policy
> configuration file 'evm' for sigv3 enforcement.
>=20
> Mention bit 3 in the documentation.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks, Stefan.  This patch is now queued in next-integrity-testing with th=
e
other sigv3 patches.

Mimi


