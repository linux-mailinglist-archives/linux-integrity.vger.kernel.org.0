Return-Path: <linux-integrity+bounces-9933-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tKfLJYQnVWpjkgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9933-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jul 2026 19:59:32 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E773474E3B0
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jul 2026 19:59:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=o9URy7oZ;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9933-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9933-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 972EC30F4E9D
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jul 2026 17:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3293E3451BB;
	Mon, 13 Jul 2026 17:55:30 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E607E2F360A
	for <linux-integrity@vger.kernel.org>; Mon, 13 Jul 2026 17:55:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965330; cv=none; b=cvxMUyDYZgmg26iJMC6fSkQxx9qPKx3MahqY0zS2OBpv1L5/oNWNZjemoiBY8228g9YUqXlqcokLGahXBF5ETyPRbPFk6f//MjcEyzDypUq4V7rNRO4q3yEHcjaPoovXIpcJtn2cqPneJrNd/82trvhJXruY2/Bht8nTgtqRXLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965330; c=relaxed/simple;
	bh=ra+R+/A4QXFsOtTcwSqEVFbmwl07gpHdxtZofOacijk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=EIYBOH4eLbE5NLRihs/dA9GAZH87CXhHw/y+rct2bz1rCPnr/LvqgJ0ZCLXeJt2nKu89zPD0q9kCu10qsnhWdMfuGBAAQmRVD5Gc+Hca9+cBID7havQfv8zQlu981SDv7zJ0Ry42wfkA5UU9mnUUMgayu6EnNrg3OBaxPdYixTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o9URy7oZ; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DFEOcY954425;
	Mon, 13 Jul 2026 17:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sQN5J8
	pEGGl7wZrHqdgheFySyfqf0iJJd4r5LstSLXA=; b=o9URy7oZhHOZtkey/XIZr4
	KKDS2XcP0uph0SHdzZuMYLAX2uvjunCaJVsEeA/JYIk13g5vUWhxYt/SR0sje0LM
	+puZZIMnFxvfsFBTxx4kojGQaFS6dTsbplRyKqQW+575Pk+5O6yRSqIiE7rOI7lv
	c3pjvLHB3ZEG/Uh4HJXjxUYZkgWiHfYNhk+DENiPJhMy/Ib0xfN/Jak+0TjBDLgp
	gqsBjM5Sv24HIKv4oxgrEyt3R3DzwZqUO9N58eYyPmvGFa1SBMT/Vl+F1wJcczFl
	Ly3g2OgTr+Y3BEzVqHkQzkr/LZHAgGI0jKgM4M/8dEK/oBxgE5IMgrzD3V4wr54A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv332mdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 17:55:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DHnixH030384;
	Mon, 13 Jul 2026 17:55:17 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nh6usu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 17:55:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DHtHXT62390746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 17:55:17 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CF0F5805D;
	Mon, 13 Jul 2026 17:55:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2A2F5805C;
	Mon, 13 Jul 2026 17:55:16 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.43.206])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 17:55:16 +0000 (GMT)
Message-ID: <6003ccfc3e6077ff14dd3f8d2fda6c5c4d5b71dd.camel@linux.ibm.com>
Subject: Re: [PATCH v6 0/2] ima: measure write on securityfs policy file
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com
In-Reply-To: <20260713080954.28520-1-enrico.bravi@polito.it>
References: <20260713080954.28520-1-enrico.bravi@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:55:16 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE4NCBTYWx0ZWRfX+YHXTanBevSD
 1uu6d9ECwZw2rFhX3mKV3nsDCTTenm+J7pns89cNtq88Hgp6UhEyzxAPU/gG6sqGgJMHJVpJlx9
 W7MYue2++VKK4jaNLi1g9d7DRmSGazM=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a552687 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=OmLL5hzFI6apHHhrWAwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: k9c8Vtz2_zsk2bJP5Z-8GjG5bxcJUT1V
X-Proofpoint-ORIG-GUID: rewk7-lFRlXW6K3v3PPbuUsLgUfSQ_oN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE4NCBTYWx0ZWRfXwwwQXliQsA8k
 OT4tgLpvSW94JrjEAX0Agy3nYH5ZitAfbZzLs7hYemfM9q+EMu/FaN9siXjw8dkUHreXD/JVUfm
 PxxljbHJyvP86ym5i4a0ZtuKPJyMzTsEMHNsIdF1oK3ldykoADnafGr6NitYU1vcNus202TED0U
 qbmcdwDkeACFUF3N8fVWuO+5ifVVhOecfxLLPHVZTsBNYG8K4DFpxwfYY6HQ0uNulcCfUCKVG5P
 u2LZbu8/PNVQR6vtNRDsJpFHAzYMg21VyWJ5GziJI7kVckgqmsBqzMbWuFk7fC4awPJxj0eAvf1
 El3OT4OlvFj9BTrf0zcgn/XStwwCAVVh13KM0Tme5QdM/SeMx6e3LtyxKZoqD0EQnWx9Py8gUpQ
 AZvYh544mvCBy9ztWIJRq10QVbrpi1ms/XGaqAdN7LB0kUtr4DTtHCyIR/vCFZX89zMo/H7kjZj
 kyY//XwDpAor6vULq3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130184
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9933-lists,linux-integrity=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[polito.it,vger.kernel.org,gmail.com,huawei.com];
	FORGED_RECIPIENTS(0.00)[m:enrico.bravi@polito.it,m:linux-integrity@vger.kernel.org,m:dmitry.kasatkin@gmail.com,m:roberto.sassu@huawei.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.ibm.com:from_mime,linux.ibm.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E773474E3B0

On Mon, 2026-07-13 at 10:09 +0200, Enrico Bravi wrote:
> This series aims to introduce integrity measurements when the IMA policy =
is
> written on the securityfs file.
> In particular, when a signed policy is not mandatory, it can be written
> directly on the securityfs file. This allows to override the boot policy
> at the first write, and append new policy rules at the subsequent writes =
(if
> CONFIG_IMA_WRITE_POLICY=3Dy). In this case new policy can be loaded
> without being measured.
>=20
> The patch #1 introduces a new critical-data record for the newly loaded
> policy. The measurement is performed over the textual representation of t=
he
> new policy once it becomes effective (after ima_update_policy()). As
> suggested by Mimi, the new critical-data rule is added to the arch
> specific policy rules (only when a signed policy is not mandatory).
>=20
> The patch #2, following what was suggested by Roberto, measures the input
> buffer sent to the securityfs policy file, regardless of whether the new
> policy will be accepted or not. This is done by calling
> process_buffer_measurement(), enabling POLICY_CHECK in ima_match_rules() =
and
> ima_match_rule_data() in order to catch it when 'measure func=3DPOLICY_CH=
ECK'
> is defined (e.g., ima_policy=3Dtcb).
>=20
> Changes in v6:
>  - Fixed a merge conflict.
>  - Initialized struct seq_file file.
>  - Fixed some lines longer than 80 characters.
>  - Moved from vmalloc() to kmalloc().
>  - Corrected POLICY_CHECK behaviour in ima_match_rules().

Thanks, Enrico.  The patches are now queued.

Mimi

