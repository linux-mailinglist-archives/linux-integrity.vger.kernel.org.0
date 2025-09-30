Return-Path: <linux-integrity+bounces-7308-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15F8BAC755
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 12:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716AF3B2E64
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 10:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11A12F6581;
	Tue, 30 Sep 2025 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eMBHta3C"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9642F83C5;
	Tue, 30 Sep 2025 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759227845; cv=none; b=cxGQix9AXuuHWcBiAr8Y926x3wyEs/edbKQB2ES1Se8piEp47tnAoyln9egfr0vLxF/G44cMpP4CYokkvg2YJ4fLD18iSItv6pku94rFGyZSVn5AZgXvfQTaenYP/Vx0X7epTwTigW5euCALIGCX3tI4XmehUOyTejV6OFu14SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759227845; c=relaxed/simple;
	bh=kFbjzKu4C1FIUbz3Du4tI6MtJPnBh7S5QIrZlxj8QZY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=IZ69QcS0KmhiswfzERawms321xDO76WS7CcbhkIihNqk2Geu1g6omnKAmS/E3U5o3eF8l0FF5Nf7RBq7HoiCqEPMpBGxq5ElGUoyMpJZuUfeeZ6RsJdw+vXZDmO8sfYX33E6FH/yfErkBFu4SB1lkXo3apwIuE6EvZDP8il36QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eMBHta3C; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U7NRKU016159;
	Tue, 30 Sep 2025 10:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=q+A6AB
	FPSBqxNX7wJhRsHf/mKikSfIHWXLZ/RDka+AQ=; b=eMBHta3COcHPnnF7LGIynZ
	3E8c6TP2VXnqVbfv9cruhvVn8WbnsPA9rKGK4/fZMbliyM6AYcbxiKEvQ8WB2UUu
	NsxXbuKxdcraf6+dSdZF0Y8uSOqOf/oHJoSOAwvAF58LZSBoY/7iNeHfshfKX7eA
	zW6lkxYkZbsAzx+9Tt/4EL0XXd7t9ExdNRiGkMmdcR0v6Tw8/i77p9MPl5KLW99N
	xm3h2cCXQtRqv0R6J40KNSHBBGzMEBI/o66zQ+DsPtZz2afTjbF4QoSL+PbV4D5d
	lq5bwiW8Qm7wUjfi7mYGyVS1pr3KMZ6dj6TULnZlOX2h0kq86wN/7UiyzzMFFxGQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7ku85a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 10:23:53 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58UALfDi027088;
	Tue, 30 Sep 2025 10:23:53 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7ku859v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 10:23:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58U81UA6020057;
	Tue, 30 Sep 2025 10:23:49 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49et8s32dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 10:23:49 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58UANmZS23724612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 10:23:48 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 915F05804E;
	Tue, 30 Sep 2025 10:23:48 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C75A95803F;
	Tue, 30 Sep 2025 10:23:47 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.25.147])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Sep 2025 10:23:47 +0000 (GMT)
Message-ID: <ef7c07585e41c8afbb2b97df98fd47c9374b15cb.camel@linux.ibm.com>
Subject: Re: [PATCH 0/2] ima: add dont_audit and fs_subtype to policy
 language
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jann Horn <jannh@google.com>, Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg
 <eric.snowberg@oracle.com>
Cc: Frank Dinoff <fdinoff@google.com>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
In-Reply-To: <20250926-ima-audit-v1-0-64d75fdc8fdc@google.com>
References: <20250926-ima-audit-v1-0-64d75fdc8fdc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Sep 2025 06:23:47 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=T7WBjvKQ c=1 sm=1 tr=0 ts=68dbafb9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=1XWaLZrsAAAA:8 a=Dp9FQI8HATi7HZ4XbgAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vkFhW_iLldhKBo0qD5CUO-Lgtt-gqC3o
X-Proofpoint-ORIG-GUID: YdTilexLCFbJWiq3Bhg22xQhLhmW8szR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX/5QVs33hE10z
 9cEBivf8VZ7+Mv7A2nw7t1XTE6tPKPmRLpjXml8mtUFnQLv31e7uG/Unfb1gb7C0CmRG/4innQM
 YPtpdWo7Pq1IOhFHHw6abdenXBBjDKf2uxEMxf9tJjYd4P+0ipx0Tly6W0+5w5fC8lIJ8ig5sbX
 oVJldNhLgCA+No/OLykIBDFf9V7GeHWqtQI9qanmdsF4oGTP5I+FkzoY/e/eKGFDm+o41txHrgL
 5DGzTd4axgGcO3wy+Q+xWCfvYwCiBEFil6A4SNcvGUa9IuzFKIRL1Ebv7FNIhRqq6YpOHiGGZtT
 8zn6V1PB2+IjJChTnOFLEsXsHHHeRX/XEN9BWGgTF4lgu8v3xZK3/g5X6yv9MhRhYe8HeSXnM9t
 LemWrcghNIrqQXJ9imd+R4mK2wGSkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

On Fri, 2025-09-26 at 01:45 +0200, Jann Horn wrote:
> This series adds a "dont_audit" action that cancels out following
> "audit" actions (as we already have for other action types), and also
> adds an "fs_subtype" that can be used to distinguish between FUSE
> filesystems.
>=20
> With these two patches applied, as a toy example, you can use the
> following policy:
> ```
> dont_audit fsname=3Dfuse fs_subtype=3Dsshfs
> audit func=3DBPRM_CHECK fsname=3Dfuse
> ```
>=20
> I have tested that with this policy, executing a binary from a
> "fuse-zip" FUSE filesystem results in an audit log entry:
> ```
> type=3DINTEGRITY_RULE msg=3Daudit([...]): file=3D"/home/user/ima/zipmount=
/usr/bin/echo" hash=3D"sha256:1d82e8[...]
> ```
> while executing a binary from an "sshfs" FUSE filesystem does not
> generate any audit log entries.
>=20
> Signed-off-by: Jann Horn <jannh@google.com>


Thanks, Jann.  The patches look fine.  Assuming the "toy" test program crea=
tes
and mounts the fuse filesystems, not just loads the IMA policy rules, could=
 you
share it?

thanks,

Mimi

