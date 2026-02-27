Return-Path: <linux-integrity+bounces-8684-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAwZGbXkoWmUwwQAu9opvQ
	(envelope-from <linux-integrity+bounces-8684-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Feb 2026 19:38:45 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9811BC197
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Feb 2026 19:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C66F63017BD1
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Feb 2026 18:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C091F37F74F;
	Fri, 27 Feb 2026 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QQcu+chh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810FD35A382;
	Fri, 27 Feb 2026 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772217520; cv=none; b=hKmBP4usr9x1ft74hN7OwM1+eptxj+cLOqVohNhwnHPHMDB1xJPMl5HXk9fAiNuhatU3tgJ4esuVgqvOVOL8V9Y0VGd8GNIx92CDKb0cbwKNdkOcUjEumFbf3HiHMqcD/WWiWNtq39ImxNuwQwfdFA4n6aPt27eH/f9MKRiu7Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772217520; c=relaxed/simple;
	bh=zGbD38Vn5ZL0nUnWg9qoIHc0Z/GfE/E1t3XHy4g0YKs=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=TN3+9EF/c47D070MpLT4C6P0r0WyqFBQFImcVSYm87ucGy+OO/Y9EH3sfpZsMW5aq8P/Th9/ip95Wu18QQ+KwEjym5s19ef2wWpuOTanqpS4dn5wPAV15O3U3h2qC+DP44atd/8N2HyfygStlc9hx4hJd61OB7LCobf9R6Vm3Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QQcu+chh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RGaXvn1001879;
	Fri, 27 Feb 2026 18:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jEh/js
	4fX1w5c4dwHXUYVUsXevadATFSnVZKTRpZqyg=; b=QQcu+chh3m+UtChJ6XYUT8
	GUkJBqvilx2vaC8s1T8BUezPU6gFFpM+2n0p1zw/4TeGTvi2uWz1HGy0x3F0YTKx
	oFd3DElfWewKUx0036I4qHSPgzbAHgnHvx3lg6rnI1SK/1MS493bLEgw+fUlV9DK
	63RSkzCDVCsv/De0IWcFQBvHofkws5c6PqP7G20kfgwuL4FelbWX2i6avHazQEYY
	M7mjwJ8g+INlD8eFmL02aubJn954ZBuxBKo7rqkSiPs2t4GiVqJh3/JU+wSqSAp2
	NzSbK4d+j/iTZJDaRtQTLbtPEMbjFTw7shz5QaituwIjvCQP6pt7PRYr/D7bU8Ow
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4bsd4a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 18:38:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61RI2VoR001653;
	Fri, 27 Feb 2026 18:38:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfr1nknat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 18:38:22 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61RIcLkW25756342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 18:38:21 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B8FC5805A;
	Fri, 27 Feb 2026 18:38:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEFAB58051;
	Fri, 27 Feb 2026 18:38:20 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.86.1])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Feb 2026 18:38:20 +0000 (GMT)
Message-ID: <fc98d328cc9d06d62cf16ddc620aadcec9c3c6ab.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity: digsig: Add blank line after declarations
From: Mimi Zohar <zohar@linux.ibm.com>
To: Chi Wang <wangchi05@163.com>, trivial@kernel.org
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
	 <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chi Wang <wangchi@kylinos.cn>
In-Reply-To: <20260227062311.140597-1-wangchi05@163.com>
References: <20260227062311.140597-1-wangchi05@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Feb 2026 13:38:20 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: C1eLXBhbEHIqb05VEKgEYLiNv72as6sC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE2MSBTYWx0ZWRfX7PJ82/FRDHcC
 8fd4txXeqSwK7FYG9PofiqCfD6wFlU/T8GCNDVa7p/UJRDgToYw7T8yf8ymr/YVaRGYYAsvDa8V
 vVfm1gsBwaBiq4WmxtPLojPSXgjLrIIqFkJTqK6+srpPhG/ZFGTxnTIQxu+TA2vIXT1eU27myhE
 bxgdWUujeRuNgXHFbGqavDEQ02P5uaEqOxkGhsvfKQc+mP9XocO2Ojc85CrwaWnP5YaBumV52Lh
 ZRq9KYyZgGt9sCfQ9qDRF2ASy9zFsh/DTognIiVQ3SJJS8eY7GorqB44BU9eZSPbDx/d0TexaMr
 XDnMV+ToPelDzs8QfkqlN3tbbgpJFYNc1owdckHNx6eFxOjWp3iWD05CeuUFkOL/pOlJ9FHSXmz
 u2rQttxnCnL4qX/CbRK1uzVB6zIc1gNvbgFWIMVj6OIi/bigKLqiX/Rjea4EUeEnAMontAPg3Y/
 sWDnFtzArSzfZysSHjg==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=69a1e49f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=9OWlH7pB7l07f5wWvPoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uOx7hEpQnU5m3j1D4hKQp4otMRPjzE8W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270161
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,vger.kernel.org,kylinos.cn];
	TAGGED_FROM(0.00)[bounces-8684-lists,linux-integrity=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[163.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: EC9811BC197
X-Rspamd-Action: no action

On Fri, 2026-02-27 at 14:23 +0800, Chi Wang wrote:
> From: Chi Wang <wangchi@kylinos.cn>
>=20
> Fixes checkpatch warning:
> WARNING: Missing a blank line after declarations
> +                       int err =3D PTR_ERR(keyring[id]);
> +                       pr_err("no %s keyring: %d\n", keyring_name[id], e=
rr);
>=20
> Add a blank line after the variable declaration to comply with
> the kernel coding style.
>=20
> Signed-off-by: Chi Wang <wangchi@kylinos.cn>

Agreed checkpatch complains today, but probably not back in 2011 when the p=
atch
was upstreamed.  Cosmetic changes are normally upstreamed only with other
changes.

thanks,

Mimi

