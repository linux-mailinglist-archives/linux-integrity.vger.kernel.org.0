Return-Path: <linux-integrity+bounces-6203-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B756BAB6B95
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 14:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D379170E8C
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 12:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586292777ED;
	Wed, 14 May 2025 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G9rlyfQZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A4C275866;
	Wed, 14 May 2025 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747226470; cv=none; b=tetH2ep2Oi+up84i3h4LXfcSNZGVkh3kkczdoRtPE6DSbudD0sWcRWB+ZdzEmKV4mHvH5Z7W/2Z8qzhxonLLxC4N1Y2Ubvu6zo9XGPXjq8lPa3rbA9fy2Ut8+hOjudos+q73u0fk2irFrnQpyohG+YnOjh1cy+CftKv/OLlDCnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747226470; c=relaxed/simple;
	bh=/ltR3xE1jIxqOWOOYkUnrtjTiBPuiBIUhmryLaCAdZY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LUM7YykCWCRJFtH8/2N5KxUNuHG3jJNS/A2mfw3fqNoHmh1/yMVFOq99NqQG3q3Y80aE8dF6KQTzS2HrNdF9Z4Fu+BgzpReD5GZFl0QEChv7byzJezvg4PriVBS+a08kVDQsq34vlhaaR2z49mU+PGV385k3ijM+qdwQgd1Hu/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G9rlyfQZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E743OT003207;
	Wed, 14 May 2025 12:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/ltR3x
	E1jIxqOWOOYkUnrtjTiBPuiBIUhmryLaCAdZY=; b=G9rlyfQZgDSitkauVm37X7
	BHyB8FK7hr6A5Gsr62t0bH4q8Py5mggMPDUKguvc7WESApV/lRbzxQMMTg0SX4ra
	Sw4k+jhxM2P21VSrrgqIKv3hgmO6WXCCsIXO87FWeeOW5XaQQA4p+56iQsIiVntK
	RhyJO1rrmrIBds5OGJhg7ldrbKDzVQWpbSLwiWgxfMReLT4xgDaWZxFsHV1rMzVa
	JlmMAlG+59dfqJZn4Ueu7XBp5N0G3Mo65J4cQGQLA7Ak47l0Ory83iOFx5kiyxhz
	o00IvQb+vZvoXC7F/W7bl5lh9uvVCJ+bkGjlf6h7jw/uYKGEXdBWD7k76d9Q1LNQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbh1475f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 12:40:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54E9xiIb024281;
	Wed, 14 May 2025 12:40:42 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfs45d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 12:40:42 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54ECefVe2687684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 12:40:42 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D644F58060;
	Wed, 14 May 2025 12:40:41 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 533225804E;
	Wed, 14 May 2025 12:40:40 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.143.84])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 May 2025 12:40:40 +0000 (GMT)
Message-ID: <47edc9708d0ca75489d59ef4b9b6ef2f5de21fe9.camel@linux.ibm.com>
Subject: Re: [PATCH V2] ima: do not copy measurement list to kdump kernel
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com
Date: Wed, 14 May 2025 08:40:39 -0400
In-Reply-To: <20250513143129.1165-1-chenste@linux.microsoft.com>
References: <20250513143129.1165-1-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RpTFLDmK c=1 sm=1 tr=0 ts=68248f4b cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=yMhMjlubAAAA:8 a=20KFwNOVAAAA:8 a=1v2mA-L8tnUgDz3cNWsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KFtkED7iNBqTTVFsvX40P1QhtKzqui76
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDExMSBTYWx0ZWRfX3pqPk3C/XJkr r3Cjk9ibS4n+GvwREoqEgmdxsP/iKvaO9gdEi9N1YlgFW2RYO95N/kkV18+YylD/9VdR7krRWyc TbcjDMX3p4vP/1tge40WSi0IB1A5Pu2N2kNItezM8WAqnk67Fb+63uNMAtsfEQK1Z/LUxeSTnYA
 iUA2W0L3idNEBZtMzTsq9lr4YEggrO9HqMqCDniCS6QWG+36DOL+HJ3g4BPW1YvFZvcm6lmVW3s HuAiLjC89URa2AglwefOIGQPr8XvsX0Tl0DajMG8XRqAdHt7YOQaIiDMeLG5qp9MwqFL+WasE/4 FMP42jOupTfaIc+zGMk+DjP//R5H8MJuZNbaUxHPY16ptrrQCLNQkbbCJ34JWO2AOTz+ahqKfRd
 rqMe7WGWp8FC0FwfmMEq2ScZ7jw128Mt51vRO72sspwFHZKsfdzzzrcqtQP4E5x9W5yf3+vo
X-Proofpoint-ORIG-GUID: KFtkED7iNBqTTVFsvX40P1QhtKzqui76
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140111

On Tue, 2025-05-13 at 07:31 -0700, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
>=20
> Kdump kernel doesn't need IMA to do integrity measurement.
> Hence the measurement list in 1st kernel doesn't need to be copied to
> kdump kernel.
>=20
> Here skip allocating buffer for measurement list copying if loading
> kdump kernel. Then there won't be the later handling related to
> ima_kexec_buffer.
>=20
> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
> Tested-by: Baoquan He <bhe@redhat.com>
> Acked-by: Baoquan He <bhe@redhat.com>

Thanks, Boaquan, Steven.

This patch is now queued in next-integrity and next-integrity-testing.

Mimi


