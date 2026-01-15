Return-Path: <linux-integrity+bounces-8257-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA01D279C6
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jan 2026 19:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 372FB324AE84
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jan 2026 18:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912342F619D;
	Thu, 15 Jan 2026 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PlSVDw8X"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF072D738F;
	Thu, 15 Jan 2026 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768500957; cv=none; b=oG7W927w2psXlaxhEKOpymSKkAfZJk/XLurXQ/wUIKLp5BwcZEVqLR4vCYOAMCRWKS8NF34aYOzNFrNio8I/b2bh/bXe18K+NsEiYE2DNf+VZs7vjdZnrWFeUSdO2r/X/8iaUYfgDFoVw7H574Av133TnxqWEZybSFJ9RQWEafg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768500957; c=relaxed/simple;
	bh=1TMsrY420HeCDkL4k1sDY9n3Hi4FknWUpSndjVB1pMA=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=eY7DzQY00L6NaEY2uUOrkd/lBzTllHTda9UQ5j61lTUHnloyFxH3b/fca4YbdlHhqT/8ozoPJJAJw7to5mjzSmx6N4TK3QnvEYVSYBjmg+rhkLCi1E32D6SUJZwJ0wzhtFj8t7QLWe/uDevIzhTqqzay0+6W7e31nsassC1fh78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PlSVDw8X; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60FHhgh3001905;
	Thu, 15 Jan 2026 18:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1TMsrY
	420HeCDkL4k1sDY9n3Hi4FknWUpSndjVB1pMA=; b=PlSVDw8Xs6vJ9LdUjUli0U
	vW3e5TLlDPwLyoly7hDMUEU4f5sN9daZBpYFgZahjSeegvPlI0FePQkLXDKFXpqd
	yClVu3+cBDZEm8mdPn+fmKstEXOvOIaU3/P5yo+Z+EAHx4xRSHnQvqCTOnPoRzPH
	6xsqPe8Xj8nZ0399D7p4EHgtTda9/Mm/uu1nfoF6X908M7FoMka9SBo//5lGWrXf
	t9mzUFtUhLGeADyEwp+q1UwfV5gZ+gzgGSxozH3jGIeXOtlwJfu93LoxBskHGh5B
	kR5XDq3d3Z/3eGGOMveqY7UWinscLJO/P2gUZHKx+jFeup2mGvVmi5hr/IZawBwQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeeq844c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 18:15:28 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60FI9G9C003970;
	Thu, 15 Jan 2026 18:15:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeeq844a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 18:15:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60FGtKYt014278;
	Thu, 15 Jan 2026 18:15:26 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm1fyhrft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 18:15:26 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60FIFQPC30343824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 18:15:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72AAD58058;
	Thu, 15 Jan 2026 18:15:26 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED2E458059;
	Thu, 15 Jan 2026 18:15:24 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.157.243])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Jan 2026 18:15:24 +0000 (GMT)
Message-ID: <522f60ac43b8757c0d7df5df0239190e49f577a8.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] evm: Don't enable fix mode when secure boot is
 enabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Roberto Sassu	
 <roberto.sassu@huaweicloud.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg
 <eric.snowberg@oracle.com>,
        Paul Moore	 <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>,
        "open
 list:SECURITY SUBSYSTEM"	 <linux-security-module@vger.kernel.org>,
        open
 list	 <linux-kernel@vger.kernel.org>
In-Reply-To: <20260115004328.194142-3-coxu@redhat.com>
References: <20260115004328.194142-1-coxu@redhat.com>
	 <20260115004328.194142-3-coxu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Jan 2026 13:15:24 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DI6CIiNb c=1 sm=1 tr=0 ts=69692ec0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=AiHppB-aAAAA:8 a=20KFwNOVAAAA:8 a=DCsw3ThD87bJHtXWWggA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8LggoQL5xkSocS48LF0jdeaQQPktLO2r
X-Proofpoint-ORIG-GUID: qixJrqEznCugkDB3s1Vn9ZkPlrQeL79q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDEzNyBTYWx0ZWRfX8ibpgRoDpYMu
 5EsY9VFzlm8C+ouw/jKLQHDBp5JPV8qH+Qpx01RUSQldATHWIOVwWzZQ1/XNN811H6Nua9bVkTV
 GIIGtrUpSbdjWNg8Jun/VRvX2r6A8VgOYDCc1h6t24iUb45GLbwt2kGx4ebbCSh+pcX5qPJokou
 Myw5zmYawpNyF4W/SFekhE9osD53lPfrPtdj+FrXO7PrAoTnF/j5ANlIg4jd7QXXhUnZmYKS2Up
 3d6dI6l01Gx7zIB96NUMi9VqR2wYHybpCBGI+EAHdnvwXfDWp8WlKSn22Hwz0Buc7VNc2ZFqH/o
 tyxH315dG25CCN2PTokbx6JHigBXS8DSgn9Bd3B8/cAe0spSyQwS7/z5qZMSE6N8Qgf/KK8wKx0
 mLkxORI+ReUaRcjIgq5MKi8FXIKLFPsXrpfl6zIITGEcksvYoG8yDQuzmdTLACTCq8MMKgX48SK
 OV9/G9YnF5svCcL0tJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_05,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601150137

On Thu, 2026-01-15 at 08:43 +0800, Coiby Xu wrote:
> Similar to IMA fix mode, forbid EVM fix mode when secure boot is
> enabled.
>=20
> Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Suggested-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>

Thanks, Coiby!

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

