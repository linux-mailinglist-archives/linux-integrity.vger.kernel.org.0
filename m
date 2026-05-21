Return-Path: <linux-integrity+bounces-9613-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA7ALOpoDmob+gUAu9opvQ
	(envelope-from <linux-integrity+bounces-9613-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 04:07:38 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED4F59DE1F
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 04:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D948302BB81
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 02:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5193148C9;
	Thu, 21 May 2026 02:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ix9XnF4E"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC4C2D7380;
	Thu, 21 May 2026 02:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329194; cv=none; b=JcAQC1FD9krkUfIF32nNcj+ZqKdFF0teBwpnKlGJ5cS1qJTCbkXfVOZ03AIsWoaAv3qq+No6mJH3C/u1DVgwEOxZJL+fgGX+NqfmuZUD6irjvy9PS3XnHhEc8x2lKuP2PcPNYI9UcCcn0Qvl114Knhdh4GoDI+5YZZm9Vp4EVYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329194; c=relaxed/simple;
	bh=+SPs8y+XpN08dCgC2Dr8QcggYOF661frMh9kZzVyoc0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=RYfiiJGoejAFXa4lEiqyUXEv6LmmmgChxRuw/kOulmhjZRudI7VKYAddZWxPbjKo4Ax2x3jn9va1vmThKjQjQiDZRogHfLKhSroGgkqSi+UeTsxxz/JM/aJ87QBYKvDZkLSpriAPhP8Fl5jOXpfbEBI/MYhysIsDlBCeJopE3q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ix9XnF4E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KFs7LJ1876843;
	Thu, 21 May 2026 02:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+SPs8y
	+XpN08dCgC2Dr8QcggYOF661frMh9kZzVyoc0=; b=ix9XnF4EDjLYXmB0/e7FDN
	uJRvNKae8ZMprcz9VC46fOPnXZbForCWApKbZAKu0uZSHT0eNCXZFRJYoGShnRNl
	f7cQzWvyccZPrsjDx6LqMZ1g5BpdB1WHLlt4si8YAIQ0PcDyjI3B9S5375O481C0
	VkGwioGiUBcNelL2z9xkirzcKS85SHKt2iGE93z6lwyhrVX46EX/byFGyIW6YLRE
	8VRMrt9Hi8G5V+7hvi/Vb83M0mggeLoLjehu2OcAdURdrqTgIAfs1dmwvcASxl9i
	PeeH1f/Z52BDFw02mXTfgMJE0DmMCTpFf+X/dCZeAfyhZLoznisRCMFoVgC0G2jQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88kn0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 02:06:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L1sBcF024927;
	Thu, 21 May 2026 02:06:10 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wka1rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 02:06:10 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L2691R28705420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 02:06:09 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8A3B58052;
	Thu, 21 May 2026 02:06:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B628258056;
	Thu, 21 May 2026 02:06:08 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.96.83])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 02:06:08 +0000 (GMT)
Message-ID: <b7f97a0a3b79b72a014d12514febc338d1ecd038.camel@linux.ibm.com>
Subject: Re: [PATCH v5 04/13] ima: Introduce per binary measurements list
 type binary_runtime_size value
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <20260429160319.4162918-5-roberto.sassu@huaweicloud.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
	 <20260429160319.4162918-5-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 22:06:08 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 0bNuSRYwxdQtX7haUEYHKGsZ_lt75MiD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAxOCBTYWx0ZWRfX3Uxj6Y3Bz4Vo
 LkDGEubw3dFSRZKJFzKwVInU5KvJdTu5HMIBAYJbaOQ9QVuCnvJVD9BeLk1ThuD9PAfhZbOA4X7
 wAMwO85CTwHgTk54XK1T8F6jox1bAtScfhlluF17+zOKnbv1c40KvuR6eFFODj5sAYKXOILkM2/
 7bz7d2Qm19y/v7aTdxSrHjsBA8GomwSqs46/5gF06xTNal3Ool2sfr1NmqLZTkCIVZ62Uw/E8GS
 xQUpbokNDMz9rolLQABo8b4Bhr/Q51z/sScIz+R96vJAiXYIdUk+INbHXiAi99c9hCxnD/HtUgS
 GSL6y/xbmTyrdlE9dlmPP10E8jDGkVV+DwDqO9gXRWlkMYamBLcqFUrugtxxeamzwqMNwn8Eosn
 8HCP3jQMF/taPXJjxFc8rJzKDE7U/vrJSewvOMxxh5U7KVGoedCyBSZUXdFoFgHSQF8CEPJk5F1
 Zo+NL4hcN40Wlu+0JKw==
X-Proofpoint-GUID: Dvlm-HQupllOa8fzPufkOBN28D9ukXgg
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0e6893 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NEAV23lmAAAA:8
 a=i0EeH86SAAAA:8 a=KGdsgSb-drRJz5pbZxUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210018
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9613-lists,linux-integrity=lfdr.de];
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
X-Rspamd-Queue-Id: 1ED4F59DE1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-29 at 18:03 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Make binary_runtime_size as an array, to have separate counters per binar=
y
> measurements list type. Currently, define the BINARY type for the existin=
g
> binary measurements list.
>=20
> Introduce ima_update_binary_runtime_size() to facilitate updating a
> binary_runtime_size value with a given binary measurement list type.
>=20
> Also add the binary measurements list type parameter to
> ima_get_binary_runtime_size(), to retrieve the desired value. Retrieving
> the value is now done under the ima_extend_list_mutex, since there can be
> concurrent updates.
>=20
> No functional change (except for the mutex usage, that fixes the
> concurrency issue): the BINARY array element is equivalent to the old
> binary_runtime_size.

The patch is really clear and well written, but I don't see a concurrency i=
ssue
requiring taking the ima_extend_list_mutex at least in this patch.

Mimi

>=20
> Link: https://github.com/linux-integrity/linux/issues/1
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

