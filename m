Return-Path: <linux-integrity+bounces-3305-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC6794C771
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Aug 2024 01:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153CF1C21548
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Aug 2024 23:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4A315B14C;
	Thu,  8 Aug 2024 23:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s0d/CC7A"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C177C2F23
	for <linux-integrity@vger.kernel.org>; Thu,  8 Aug 2024 23:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723160797; cv=none; b=JG1+u/Fk1g79g/Pb3aHAivZSWhAPnFhu7A6l9HRxhMcjqBuTt4SNDORmlAZ4jokzGgxH57EpQtxxuCu7cpSgtwLBMPg8JnFMQ644b8J514Jas1DJgnIQ0aQCgtQqPNH3CEvQTlqV4dlySb6VDV+H5Zvs7FcD2gUF/a1ctXiBbls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723160797; c=relaxed/simple;
	bh=Wk7BjZfk3Klk19AhMHr2WckKzhlCcJ9mgwmu73uii58=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NMVYLyO9PyNtwGv2rl6OqTirdOiA8tM/V9d/SoHn9uzgPcXaSlTM5ucCsPV19tm17J0fZIf6VlnsvHSdubKA6xM8mEIIeAdnySl8c6oWp9JeWgbE/74rfJQEtQYPgARDG9DJbY7Z2zVSu3PvCMcF0z/Ks7J5n/O0bR+ZvGttrVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s0d/CC7A; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478CaL3R010770;
	Thu, 8 Aug 2024 23:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	Wk7BjZfk3Klk19AhMHr2WckKzhlCcJ9mgwmu73uii58=; b=s0d/CC7AUMdxwFNL
	8ozz7Dc03O/W9lt90/abJAVBUu9UxdnpSoUmhPPKUkSXadlCiYBeToRCkdgdzFm6
	TJkX2oX5KQjtjCs0NzB+ZeYC7Z2WCYqbkllDDLi4YEhiKV7lfT4aEGbzF0KYt9Th
	ahggHLHJ0lSq+5NBWvasKK0Zc54u7S1GFZEG+MDF3Q/CNJfSI1f800wBYV49e2UP
	flHTVk2iGzgCcJ5YhBdZDoV3HbqWicYSS0w1mCHRtBUPp4cTACaPy7w8EL5zsARH
	XYYO3x7eDbkreB+pkAXJrWVk1KJqLQon2gdoCQ04yFb5RQiQ+i6xWMLS5AoXmrvL
	WuGRyw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vwkbhhbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 23:46:22 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 478NkM6Y000877;
	Thu, 8 Aug 2024 23:46:22 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vwkbhhbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 23:46:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 478JkaKS005968;
	Thu, 8 Aug 2024 23:46:21 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t13mrmf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 23:46:21 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 478NkIGw10027550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Aug 2024 23:46:20 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA2CA5805E;
	Thu,  8 Aug 2024 23:46:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68F1D5806D;
	Thu,  8 Aug 2024 23:46:18 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.101.242])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Aug 2024 23:46:18 +0000 (GMT)
Message-ID: <d94d37ef05cd96f86388f338abc21504e0a06abc.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: fix buffer overrun in
 ima_eventdigest_init_common
From: Mimi Zohar <zohar@linux.ibm.com>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
        roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com
Cc: eric.snowberg@oracle.com, linux-integrity@vger.kernel.org,
        enrico.bravi@huawei.com
Date: Thu, 08 Aug 2024 19:46:18 -0400
In-Reply-To: <20240807172713.1692608-1-samasth.norway.ananda@oracle.com>
References: <20240807172713.1692608-1-samasth.norway.ananda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3arA364acWS879zircNvbgVkUHGy_Vsx
X-Proofpoint-ORIG-GUID: qxzbLMQk0CnB1b94Gyk3BRIHWOEtcAtb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_23,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=890 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408080169

Hi Samasth,

On Wed, 2024-08-07 at 10:27 -0700, Samasth Norway Ananda wrote:
> Function ima_eventdigest_init() can call ima_eventdigest_init_common()

"can call" -> "calls"

> with HASH_ALGO__LAST which is then used to access the array
> hash_digest_size[] leading to buffer overrun. Have a conditional
> statement to handle this.
>=20
> Fixes: 9fab303a2cb3 ("ima: fix violation measurement list record")
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>

Thanks, Samasth for fixing the patch. It's now queued in next-integrity wit=
h the
change above.

thanks,

Mimi

