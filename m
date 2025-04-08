Return-Path: <linux-integrity+bounces-5670-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14200A80DDB
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 16:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3FD1B671B6
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 14:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27F72CCC0;
	Tue,  8 Apr 2025 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gDQ2dgo1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F591DB958;
	Tue,  8 Apr 2025 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122162; cv=none; b=bUyUlzxxK+uNKWueo/VESKdmetRClV5n5xWY4M7FPELarRdZ3oSOSHaMy2GjP6oeEdtdpjKamSFcfyqWc4e6alyXT/KJjBgPdVlzVEHpBxqGNfFVrjSG3HVSwqGOExST9/BdIVnkYox9OcKbGlU8UW9h5M6YQymDLoWS0OvbR6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122162; c=relaxed/simple;
	bh=lcPbNoHY32hfMLXK0I9on2JgdqFyxj5M9NfZlD7bhIA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sYKhvVB1e7X+1FrBulDhBOsXYso/uQYRL4EDPXccOsVEUGJLs7LxLn4zJeuTT2Og/m/xG000j3p7U1s9hip2n+eK2SVexBcauADqtkETp0yMUfpnd/qcyBQsUaim8VNpXymAfUP1quhUOHRaGiVqnoZHrsv51KuzE3fJxvp64vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gDQ2dgo1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538ChQh8029846;
	Tue, 8 Apr 2025 14:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lcPbNo
	HY32hfMLXK0I9on2JgdqFyxj5M9NfZlD7bhIA=; b=gDQ2dgo1+c3N4ulFEkxdKS
	4P2Jlx0wNUPeWNcyzkcq0r/EGsLs8gRdlX+6q8OFuXeU102zAC4FhNHL/V+4qzJc
	p+niv1CGoOrOt0eBkfU3cTQO4TIhnRf1rmfp9flprMX1XeAa+YvuRExxMXHcFKM4
	wk/WAkEzjXkt1EixICdM/sx95ZKceC9B9viXquEgUByH8UOIZbEJ1svnNjlfkJ+n
	x1o5sr5mcVzRaetZy5JA/+L1PZEo36umXXXxleb+3XduujkUjGCy1PJcb5OM/0dH
	NJK41hSCjQ1yIvcCHzoAkrKg4kYW727re/cQwBfxlboMwaEeAT3m3o0GLyZmvHxw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vv6a2tq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 14:22:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538BLD5Q011078;
	Tue, 8 Apr 2025 14:22:13 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45uf7yk5hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 14:22:13 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 538EMDGD25035364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Apr 2025 14:22:13 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 288CB58057;
	Tue,  8 Apr 2025 14:22:13 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3FB458066;
	Tue,  8 Apr 2025 14:22:11 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.48.163])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Apr 2025 14:22:11 +0000 (GMT)
Message-ID: <deecee12f444b5b0ad03f5866749d6ad66659f7a.camel@linux.ibm.com>
Subject: Re: [PATCH v11 7/9] ima: verify if the segment size has changed
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Tue, 08 Apr 2025 10:22:11 -0400
In-Reply-To: <20250402124725.5601-8-chenste@linux.microsoft.com>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
	 <20250402124725.5601-8-chenste@linux.microsoft.com>
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
X-Proofpoint-ORIG-GUID: tD1oxfS_HxPWPw2k7-OlMQwtJG4Sl7kV
X-Proofpoint-GUID: tD1oxfS_HxPWPw2k7-OlMQwtJG4Sl7kV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 mlxlogscore=825 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080098

On Wed, 2025-04-02 at 05:47 -0700, steven chen wrote:
> kexec 'load' may be called multiple times. Free and realloc the buffer
> only if the segment_size is changed from the previous kexec 'load' call.
>=20
> Signed-off-by: steven chen <chenste@linux.microsoft.com>

Thanks, Steven.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

