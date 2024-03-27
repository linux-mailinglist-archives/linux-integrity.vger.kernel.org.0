Return-Path: <linux-integrity+bounces-1877-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BFB88E557
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Mar 2024 15:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20EFB1C2C937
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Mar 2024 14:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ED612F36C;
	Wed, 27 Mar 2024 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JiIg/2pe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2F012F371
	for <linux-integrity@vger.kernel.org>; Wed, 27 Mar 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543525; cv=none; b=WUXHFSjeHrgL0w/cCQnFcXioyTAofhN4YXW0HuEFNritVhR9UXhl2DElkWUBb+6qv/GeOLjTeriBaOiJct1l57nNG930FtyieDnA37FJOZ5/uOaJ6xPP7U2YZm3Jr1ekgzTpvGGScK4vzwk54kS9P68Pxuo8Al3SDfNULQ4ZQMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543525; c=relaxed/simple;
	bh=A6UPIKxvDnkGPyCkyXuysz1oOP6FebM5yuOwlLjARGY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=TjF0OwAo14a8s0ep2p26DhOXMGJ/dPxOjkVVZ0Z6oS2QIRC4RRxniomxvf7ijmhEnx7YYAFD2LvVc5v502rN9zgWibOt53kpyrlv6wz6iKzKlSF2JsyfEm5vVYc7GdhQZsD01qaaCZ4qWEoFtnKLW4LnR1JCUaTTauee//fAXPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JiIg/2pe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42RC0p7L009854;
	Wed, 27 Mar 2024 12:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=GVBHWHSyFqJPMA5GP9+YNWF5rCOdsX6yVE7t+++7ywk=;
 b=JiIg/2peHCl8kMoqdorF7knhpYGziTR0OYibFevNwlqRec84vMuCu/mNdS2FwAuc1thn
 evx412AfGPm6+C1z36OE+LpKbz0rl2EDUBtZuqAZz9evX3g2vz0TDCbo9ySdEG7OW9gJ
 UeeCP4N9Wb11f5q7GHx1Gfr8U4Z2m2KB/PMuZuWvfT+DqfYs/C7omFjn2wQ34fB/kvxx
 4fqZLQKVf+PjppMv4ZUvr5FRbUR3vqWEAz3PEl0zMuLXTH263m4LzarfiY4WluhuhdtO
 PrjA8Kcbuny121KZHukbonBS7TC8ngg5XCzumeFAul/gNcq2vv8LfqGjm+nncNRCMhiW 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x4k3a03ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 12:44:54 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42RCisnp014984;
	Wed, 27 Mar 2024 12:44:54 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x4k3a03a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 12:44:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42RBxKTo011243;
	Wed, 27 Mar 2024 12:43:06 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2bmm67sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 12:43:05 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42RCh2Dx23396950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 12:43:04 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3283858056;
	Wed, 27 Mar 2024 12:43:02 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C0355805A;
	Wed, 27 Mar 2024 12:43:01 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.61.30])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Mar 2024 12:43:01 +0000 (GMT)
Message-ID: <551a91024eda38e5af92d57dd9024d4d50e7a73b.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils: PATCH v2 1/1] Change license to
 LGPL-2.0-or-later and GPL-2.0-or-later
From: Mimi Zohar <zohar@linux.ibm.com>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>, Petr Vorel
 <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Vitaly Chikunov
 <vt@altlinux.org>, Ken Goldman <kgold@linux.ibm.com>,
        James Bottomley
 <James.Bottomley@HansenPartnership.com>,
        Bruno Meneguele
 <bmeneg@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        George
 Wilson <gcwilson@linux.ibm.com>,
        Tergel Myanganbayar
 <tergelmyanganbayar2024@u.northwestern.edu>,
        =?ISO-8859-1?Q?Andr=E9?=
 Draszik <git@andred.net>,
        Frank Sorenson <sorenson@redhat.com>,
        Stephen
 Smalley <stephen.smalley.work@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>
Date: Wed, 27 Mar 2024 08:43:00 -0400
In-Reply-To: <103252ffff09c607e83c887cab2e0af5404d62ff.1710774200.git.dmitry.kasatkin@gmail.com>
References: 
	<103252ffff09c607e83c887cab2e0af5404d62ff.1710774200.git.dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: llQhkDWyyR49SQK3O_9L-tmUH73zY3Ap
X-Proofpoint-ORIG-GUID: DVvbJTb4okf2ErxdU9njVtJXBfn0Larm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_08,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1011 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270087

On Mon, 2024-03-18 at 17:07 +0200, Dmitry Kasatkin wrote:
> Currently libimaevm provided by this project is used by the tool evmctl,
> which is also provided by this project.
> 
> An issue was reported about using libimaevm with other software. Its
> GPL2-only license makes it incompatible to use with other licenses, in
> particular GPL3-only.
> 
> To address this issue, change the project license to GPL-2.0-or-later
> and libimaevm to LGPL 2.0 or later.
> 
> This patch includes all acks received so far.
> 
> Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Acked-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
> Acked-by: Petr Vorel <pvorel@suse.cz>
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Vitaly Chikunov <vt@altlinux.org>
> Acked-by: Ken Goldman <kgold@linux.ibm.com>
> Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Acked-by: Bruno Meneguele <bmeneg@redhat.com>
> Acked-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: George Wilson <gcwilson@linux.ibm.com>
> Acked-by: Tergel Myanganbayar <tergelmyanganbayar2024@u.northwestern.edu>
> Acked-by: André Draszik <git@andred.net>
> Acked-by: Frank Sorenson <sorenson@redhat.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Acked-by: Vivek Goyal <vgoyal@redhat.com>

In addition to those who have already Ack'ed the License change, a couple of
people used to work for IBM and contributed to this project have not responded.

The IP for all code contributions made by IBM employees is owned by IBM.

Acked-by: Mimi Zohar <zohar@linux.ibm.com>  # all IBM contributions   


