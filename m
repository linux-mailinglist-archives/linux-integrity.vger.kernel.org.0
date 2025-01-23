Return-Path: <linux-integrity+bounces-4622-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6DFA1A8FD
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 18:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFD4F7A2E58
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 17:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A838142E9F;
	Thu, 23 Jan 2025 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sMsMJEwh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8015CEC5
	for <linux-integrity@vger.kernel.org>; Thu, 23 Jan 2025 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653867; cv=none; b=Z4JRlFAaRkUwohdrvppGS/6YpVX3Tyk5pnLzhQo/LUFxf6DzQ+4R4YL4vjjGgfasVFSu52a7jWnsR0r47HsMg4XxoUaDmtWcawYT2qXNUDD7igxiQAkHlMhhFxsAKUvQhJYNUHUdew06NNxpWURvanDYkxYmJiDsUZ+XHU68hv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653867; c=relaxed/simple;
	bh=sBdkBXLZ9FLhhEvEZasj/WkEqJTWpg4MSICRVmy40u0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gruizCq2IEeBLdWjOa7HLsWR8sPKmsfRL2efPiycm5iQ8U6j/qtTbDwDXpLr4t+DSDGJb3Ahn5NRjJDdFSrSrLvfjAMCVVPkOAyVmhUb37X23fwIeGNXcFD7KuvqTtZ/UKF+hiu1PxvEI3teNsfQGn/OVdS2V155CJYdFV0hzwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sMsMJEwh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NBMSiK022576;
	Thu, 23 Jan 2025 17:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5FMTfV
	/YbNjqNiCiZf0tWPbXe390qR+aazPeYohJAsE=; b=sMsMJEwhYq7aPblNHujXp+
	qMMEnELxWt9Y3eBh+WQpGZq2IUHfzg7g0asPaXxXglTcCg1qtUBuoe7xpQwxTgYA
	cjF/fO3NFT1ZIVrE+B7fT3kVfZtApJssyAPp/fsah5Lb2O0NFoBZrOziZqBnHkbw
	5WupFg/KS1aNjhn6bmyaf/D3KClBBtO4hxJ8JuP2wGbGj72Ugjl2diDLwF+ap3Tt
	s1ln1fvdlvYOb10qx4BYJQnnfAeDRuLCW9e1ie4yBtPv7L/zMpqZhpb4vCpebVu5
	jeJaVhPKVbUF24tdyGqOZdI798XF6PWU2N0NGgtJCyDiLEeFpSctyCFhl6/B+m/w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bbu9cdch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 17:37:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NGaCjo021002;
	Thu, 23 Jan 2025 17:37:38 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 448sb1p8qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 17:37:38 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NHbbAO40239560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 17:37:37 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E2BA5804E;
	Thu, 23 Jan 2025 17:37:37 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 099A35803F;
	Thu, 23 Jan 2025 17:37:37 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.4.223])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 17:37:36 +0000 (GMT)
Message-ID: <317110b32e6cad2d2e828374be16e4057ca896bd.camel@linux.ibm.com>
Subject: Re: [PATCH v3 00/10] LTP tests: load predefined policy, enhancements
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Thu, 23 Jan 2025 12:37:36 -0500
In-Reply-To: <20250114112915.610297-1-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
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
X-Proofpoint-GUID: eZvRqARaKTCuy4ghDV6vLSYgYMhQ_4Ba
X-Proofpoint-ORIG-GUID: eZvRqARaKTCuy4ghDV6vLSYgYMhQ_4Ba
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230128

Hi Petr,

On Tue, 2025-01-14 at 12:29 +0100, Petr Vorel wrote:
> Changes v2->v3:
> * Rewrite verifying logic if policy needs to be loaded and how it is
> =C2=A0 loaded.
> * Allow testing when policy is not reliable, but relax failures to TCONF.
> * Add TCB policy example.
> * Document LTP_IMA_LOAD_POLICY in doc/users/setup_tests.rst.
> * Fix test policy installation (previously wrong Makefile).
> * Removed some of the previous commits ("ima_kexec.sh: Relax result on
> =C2=A0 unreadable policy to TCONF", "ima_violations.sh: Check for a requi=
red policy",
> =C2=A0 "ima_setup: Print warning when policy not readable").
> * More cleanup.

Very nice patch set.  Thank you!

>=20
> TODO: ima_measurements.sh and ima_violations.sh use detection for
> ima_policy=3Dtcb builtin policy. But if example policy is loaded there is
> no longer tcb policy. Not sure how to fix it - some tooling might not
> support reboot, thus I wanted to use ima_policy=3Dtcb, which previously
> worked.

The specific policy rules are mostly a subset of the tcb policy.  The only =
time that
loading a specific policy first is an issue is when it is the one and only =
custom
policy allowed to be loaded.  One possible method of avoiding this problem,=
 would be
to require running the ima_measurements.sh first.

Mimi

