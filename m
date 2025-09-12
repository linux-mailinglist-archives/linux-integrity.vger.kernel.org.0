Return-Path: <linux-integrity+bounces-7061-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F8CB54F35
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Sep 2025 15:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88735A2ECB
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Sep 2025 13:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43D830146E;
	Fri, 12 Sep 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lDi0v9Cx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C3B2E7BAE;
	Fri, 12 Sep 2025 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683101; cv=none; b=R3+YSKFN2LZXHq5RO9Lt8sGBizzBYu4aj78NEpVXGJ61APUKNkMYR/5iIkRgBim8tG4wOQSGcZ0IOAuTHTpaJJdUcl96vMNxfPHTBOa+P2ZvNmsWdWwLfdpmKme5GBou8REqVrgqNXfEJ8jhkSVNnwLS/O/QKs1KHvKxO86NqiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683101; c=relaxed/simple;
	bh=rjGdHh+ftt2qBFlZwuyMmhQlwlfRRJVAShREhD2SeOI=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=gjyNrsmuXv3/LraIUGJym70z1INcLAhvCkoX2JekkLpBNj8xcHQ4PvHOA1s1ksv/XsTazmvlI8b53whR2aBB6iI58RE+SLT26b7iNZ/QtfLJEhG6SB/Vz8HNs689U88AHcw1CoCN2tFHD0KJq3IqTCxmoU1ETvxBYjFiycQTC4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lDi0v9Cx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CBfS6D029066;
	Fri, 12 Sep 2025 13:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rjGdHh
	+ftt2qBFlZwuyMmhQlwlfRRJVAShREhD2SeOI=; b=lDi0v9CxAwgzaIn2DllOwl
	4uLJ/7f70gJpB7U7fmtU39JTZFB0DOjUFP34jTlycbxTAlYwUClC1T5tGQhEkXz8
	XJyMRLv6UMhcZrZuFncWRyFuIKECTuEJSlloZ6unDrTVS4D/TDjw6KfWg0jASiuN
	v2OPbM+2+R+evsGRcAgqjcNJ0BKZiWYda2/DkWz7TzSJiwOvualhZYGE0tyHC1FB
	kvbEwcrWlUzwxuOCDIThSUcXTaVzwfwZaXCsjWBswQEdI+i+IxUuYIFyf9qbWltK
	2r0gpNOVG/gMNueUQU+cuSin1xSVGBtTzikin+rsWUv9nagh/yo9Y+OomRsij31Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmxbqpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 13:18:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58CCCdDW011428;
	Fri, 12 Sep 2025 13:18:09 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9uucgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 13:18:09 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58CDI9aV19333562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 13:18:09 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A5EC58052;
	Fri, 12 Sep 2025 13:18:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C16458045;
	Fri, 12 Sep 2025 13:18:08 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.85.212])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Sep 2025 13:18:08 +0000 (GMT)
Message-ID: <79bb6b761ef478b6b4ac71875ac9d7215edd7c78.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] ima_policy.sh: Optimize check for policy writable
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Cyril Hrubis
	 <chrubis@suse.cz>, Coiby Xu <coxu@redhat.com>
In-Reply-To: <20250912073210.47637-2-pvorel@suse.cz>
References: <20250912073210.47637-1-pvorel@suse.cz>
	 <20250912073210.47637-2-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Sep 2025 09:18:07 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IJMtwYpPVrK9FJR4g_nQkYt3IF4I-9GV
X-Proofpoint-ORIG-GUID: IJMtwYpPVrK9FJR4g_nQkYt3IF4I-9GV
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c41d92 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=9TuvdWacXOjX2tRd1rUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfXyrRD2ZcUMJqM
 RiiDrZcFjX8nCeIPOsZLEDo4sXd/nSNI+vuNUeBe6WrbqzF5DvM0IfS1ofxhkPntg28lv9VXxa5
 LAUw51Mv8rk5dmb2F+Udsi9P84eywR4RhDErd+WdMnpgafUZL+U9pwaPNYp8tJonsYwuRJtNZQH
 wcUvkd4npYp4zSdM83waBNILz5MfV0Ne3jp48Wrbt8grCUhJV2+14snVOqdUVL8lynpl/BtbrGV
 Pz1dEglvJKWeAoEwNt13F8SL626ZVid31T3T/KLl33HNIzGghj7jmX7clcku89lMUhzsCSKx38O
 hST/jNhicu9tZ2Arjp+nm8sSQavYIaf6i2tpRD5/EuJ/OSpsSN0+bQ/XYSJK385D7uO+NsWhnki
 bTX3UGVn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

On Fri, 2025-09-12 at 09:32 +0200, Petr Vorel wrote:
> Previously policy was checked in setup and in all tests
> (redundant in test1). It should be enough to test in setup and after
> write in test1, but let's being careful and test before writing the
> policy in load_policy().
>=20
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks, Petr.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


