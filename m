Return-Path: <linux-integrity+bounces-4511-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1575EA00B78
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2025 16:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF883A1155
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2025 15:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90901FBCB1;
	Fri,  3 Jan 2025 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GbfXpMcw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F07C1FBE89
	for <linux-integrity@vger.kernel.org>; Fri,  3 Jan 2025 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735918314; cv=none; b=IVILHoWY/+Xe0GQ+rnmu36pdvAu+IJk14lWFFhLVNVG58Hr3gSObRnmUPFCrJBSUn1ZrNVRhqoXmGL9ULsdBkSdDe2jcBAjvX1xMohOQUP07mZu0lGhps/YFINebyC+oBckrRY5VzupCM10M3mxw6ISBOe4WqnpHl7RS3+u1nqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735918314; c=relaxed/simple;
	bh=ZZNU+gW8f58PtP/5UinYg6vB/V3zxRBy/lLqkTeNCvM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tIgAoGP9emoL8M/lHmy2Ubh5QaX4Ycr/bj7BmavFW9qAttO7TgX1xVnfHzaLnd0NgRAVeS+2CU3sQAiwM6rUnC12onRPyAV9DXmAaNKxVv9WQcpfUOoh9oG6lP/fGxli0GkW6XJZ/B7/HGzqdU3+lYmyL2byqErzsN+WXJ0e9uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GbfXpMcw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503E6GIL001072;
	Fri, 3 Jan 2025 15:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZZNU+g
	W8f58PtP/5UinYg6vB/V3zxRBy/lLqkTeNCvM=; b=GbfXpMcwH2DBAKzaeJUS08
	ghPHcbnQH0MPO8SIJI10sk4FXJyIDzIJf49Bfy9dul5pkXoA1e/b1VZ4wew5uo1X
	pzHOrgDsVPRamANHTKYIeS6pTyuk3XmvOrQXSOWcje0Lhb1ubxPu/KyeNaBnpOv6
	3P9h9bZO9LpRg1NCIpX2d6KRxla2mko9m7JtimhhsqmGM6ur4OhakEOZxCgNi3Ad
	lecdyPHVwgZ7uZKdYFsnlMHF4h5Z64GLg5Y7yUfnCNs8vzPPfr8ScAePBDGHUVf2
	6KPXRLPBIg+2s2d7UtYNXKT9jKq1UVW5Gvh9c+9N60A+SZvBTnPDxMM/N5b5E0WQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43xhc50a6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 15:31:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 503D0WcG026981;
	Fri, 3 Jan 2025 15:31:45 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43txc26g7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 15:31:45 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 503FVjUd31654334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jan 2025 15:31:45 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 095FA58052;
	Fri,  3 Jan 2025 15:31:45 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4A975805A;
	Fri,  3 Jan 2025 15:31:44 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.116.14])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jan 2025 15:31:44 +0000 (GMT)
Message-ID: <c3acd3860127c8edae1cdbc4723ec50c4916b7d8.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/8] ima_setup.sh: Allow to load predefined policy
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Date: Fri, 03 Jan 2025 10:31:44 -0500
In-Reply-To: <20250103121858.GC211314@pevik>
References: <20241213222014.1580991-1-pvorel@suse.cz>
	 <20241213222014.1580991-3-pvorel@suse.cz>
	 <a617f000c69875b5c02743c8f0a8fee72cb1ea55.camel@linux.ibm.com>
	 <20241231100057.GB36475@pevik>
	 <b577405f0c6d2af8de6650eb1cd8c69305f616bf.camel@linux.ibm.com>
	 <20250103121858.GC211314@pevik>
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
X-Proofpoint-GUID: z-UfwFFHs8vj5hS52OibEloUS4eM_aRT
X-Proofpoint-ORIG-GUID: z-UfwFFHs8vj5hS52OibEloUS4eM_aRT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015
 mlxlogscore=691 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030137

Hi Petr,

...
> > Going forward what's probably needed is a new package containing a set =
of pre-
> > defined sample custom policies, which are signed by the distro.
>=20
> Please let me now once you or other IMA devs are doing any work in this.

Yes, of course we'll let you know.

Mimi

