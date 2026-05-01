Return-Path: <linux-integrity+bounces-9397-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG/QHMCR9GmRCQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9397-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 01 May 2026 13:42:56 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1694AC1B6
	for <lists+linux-integrity@lfdr.de>; Fri, 01 May 2026 13:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A391330166C0
	for <lists+linux-integrity@lfdr.de>; Fri,  1 May 2026 11:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A223939AC;
	Fri,  1 May 2026 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cMekvySi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC309363C74
	for <linux-integrity@vger.kernel.org>; Fri,  1 May 2026 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777635774; cv=none; b=S8Uj8IqsQi0ibUbYpEpt4MMXaE4TAutUPkE8RsO2K7SEONcbUyfd3Rpg4c6wdO7lbRs+VRvQ9AWO4K6gvKTN+fUXCRqhcwyEo8XNLnOo+FQp9tM65AfoXWUm4ub9kVnhfnYQY1JG6AWDT2mQwD/hjfF47VFlofsHjBXEnLb9ID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777635774; c=relaxed/simple;
	bh=rAevRXBhAGu6iiKc1Umw0D6JxGBUzsZGpz16I/v5rqE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=SblQy2+3WVQy2m6rU3n5PNSZKb9FlhFn4nZGtwakO4TWbbKf5pgHfcLtSgFJSs9AKrRmkldT23vQdIV0e32xn0tV4KTAgm2yfQXr1F47B9Dcei5cwHrZamUZnHxgN1lwxETQ/9CTvIRpp4ZOtVLSmp4/m0Uv+JF6N7LcqilGiiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cMekvySi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6413wMF02815240;
	Fri, 1 May 2026 11:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=r3ucsX
	irgRLeBDCflv54aOIzDDRrswSY57MADTLRAcQ=; b=cMekvySiWf3TADNxgSUW/4
	6SWYhjU3tvvbgQXQXkfyxpvKESjAioFbfuiVF+KqtKOf8g4mJHrhbeLZ8wtFO/+M
	8MfFEjV4//5CSzD7GuwYEdwsfvdVWlIBmSV+NJ+rsN9Vr1b8sHrkStO7pA+Kop6C
	SedJ1h+QLwPbKG/PIVwFqT1UlgZA38aIEzXlVDHSS2ArwXSg78G1fabXZWHD61Th
	E8UZ3ltalcHAoivtSXWGYxRXB7pu0VrnFhTEMZBSPOl3yljXp9Z2lOW80fm6HUbP
	bhYjS7glAwRLre+M+ALNAxTN1dAUucleWsK2E8iNHyPmMRSc1XhsK3QVVZBkem0Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vtcym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 11:42:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641Bd92l032064;
	Fri, 1 May 2026 11:42:50 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamyq0yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 11:42:50 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 641BgnFB28181086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 May 2026 11:42:49 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F1B458050;
	Fri,  1 May 2026 11:42:49 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A97E458045;
	Fri,  1 May 2026 11:42:48 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.102.184])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 May 2026 11:42:48 +0000 (GMT)
Message-ID: <4cbd1b20680e2dceba8870f62f2081c333113192.camel@linux.ibm.com>
Subject: Re: IMA: Avoid redundant rehashing on stacked filesystems backed
 by structurally immutable filesystems
From: Mimi Zohar <zohar@linux.ibm.com>
To: Sahil Gupta <s.gupta@arista.com>
Cc: Danny Hu <dannyhu@arista.com>, linux-integrity@vger.kernel.org,
        Julien
 Gomes <julien@arista.com>, Pierre De Abreu <pierre@arista.com>,
        Kunal
 Bharathi	 <kbharathi@arista.com>
In-Reply-To: <CABEuK14__XuRO2KOd3w+qx5_nw4iB2yPcF2R68a09A4hcJkyFw@mail.gmail.com>
References: 
	<CAFn2k5DJNv5SDsx_-odHd3sB0Fw7r8FqhO8fWdXrraZn_vbpDw@mail.gmail.com>
	 <2b3c93a69e70b6fdf637bf9fb921d5e737a79e8e.camel@linux.ibm.com>
	 <CABEuK14__XuRO2KOd3w+qx5_nw4iB2yPcF2R68a09A4hcJkyFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 07:42:48 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f491ba cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=wBI2lREWRg8QwSjPO5kA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: 8pWmfFeTnCrCyT5zEyIhXmQNfCv0FhET
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDEwOCBTYWx0ZWRfX2jxmm1MFG7YG
 0CPBfXiPyC5VmtvhcuE5ujtrSVpCkC3SfUrNUyMOJRJyqWnjGAZq9A7AuLixwOHQug52G4pWK8D
 Irl9czhNowgZIlwLaGIFJcd98oUvsE3bN0KkaXbkaUPQyB7q9+5CxOo/GsxMJPFM7IC5rgpFwO8
 sWgwWsExirp1liRlMXdR4BAoN/BjxZ8lEA+BNQCWrJqa8XLkjOBvfkZ0EwceGqKNyXG4A4eZxqJ
 X0YYgRIPrduZ/u4V3ebN7Xc+5220DllABy2SPFfaDerjMBaIJCmLJob3+Bw8py75Asm4Zo1iLJI
 Vh+IFtRXjaBkeb1TSfM0e36OV9kldiM/EO5BaJvIVPFlQFzGihJBYkN7muElHhPXbMi2eKmSn2s
 5wLGpJZG5cX0oNxVjkAeLRYV7DpcH1QIOUXqMukB5CyF8cX3fS/MbcQUBWgO4alkEsVZyo4F0JP
 fx6tCacffb8IdVALMGw==
X-Proofpoint-GUID: 8pWmfFeTnCrCyT5zEyIhXmQNfCv0FhET
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605010108
X-Rspamd-Queue-Id: DF1694AC1B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9397-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]

On Thu, 2026-04-30 at 21:32 -0500, Sahil Gupta wrote:
> > Have you considered using IS_RDONLY(real_inode)?
>=20
> OOC are ima caches invalidated on fs reconfigure? If that is the case,
> then IS_RDONLY ought to do the trick.

Per-inode IMA integrity status (iint) is now stored directly in the inode's=
 LSM
security blob rather than in a red-black tree cache.  By "fs reconfiguratio=
n",
do you mean remounting the filesystem?  If so, the iint stored in the LSM
security blob should be freed when the filesystem is unmounted.

Mimi

