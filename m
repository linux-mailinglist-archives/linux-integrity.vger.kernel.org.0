Return-Path: <linux-integrity+bounces-868-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7280A83AB02
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jan 2024 14:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67671C20DFD
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jan 2024 13:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D1060DF9;
	Wed, 24 Jan 2024 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IYzCo1Vp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3C4199BA
	for <linux-integrity@vger.kernel.org>; Wed, 24 Jan 2024 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706103486; cv=none; b=GaM9fv+deZI0DmeISkbTaiYIqtWgNmBLzv92YF/D+HSRKBk3vzW+SQXN+5acczt3pQjKqJp+FSl6ZhNVtXWNs2CBohVzL5gzppuQM7ktpEtRblIXyAlZULK++o4S470ff+VJevrItjE4ZhxITVY+28YnC8QpNIliBE7ZVdfcUI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706103486; c=relaxed/simple;
	bh=kYfxayhOPS3U8kFZnmhf65PBlXAX7kSwXjOYqpMvSwA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MVtNtu8gnWhR2WN0r7RnbRgo012fEJUstVJ+isobUj+6rIeW4ubdEE23P0VTAoyYIqfCSHXK3l/xqUsnsP63sPn8ed7QCn258YfPwJ2TlinVa8T5qStklMMQJtluzENlg8rRmFnRv2rl8Ygh8kTWUEYld1LzAvhxd4UZ4oCbWB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IYzCo1Vp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OBWKVl006278;
	Wed, 24 Jan 2024 13:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=QFrOoUDx7oqBcA6chvgF+hyY0GkfGAxZPy/Ry2T2upM=;
 b=IYzCo1Vpyg/G451VaAPRVRNoia5k76zEz2ui6izPuyU6CoZfwIBIs7oP1pGz458oXa03
 Sc3bGjLdeak4z0i4Q68UxeBiJtOnau13c13cSrUPg5tIgkjjRW/zPbFAC9IYNSxBGzuc
 Ty2gW3J4lL81xnXT22AdvJHDaYnESsnMWZALCp4b7bf/1uQJEX3FoU0WNkr1XE6lD55+
 7CXmQzh3xILkNZRPnfF6/EEkYcyAAVQc992AH6V53Hu6atcHBm3hWKBAkc++EZOTTKIx
 8IqQQL20MvNfWEk+ULwf9KOTq1HhwpsFtmA8uIVI0fVUsLlCeZIIrxdU6kxD6XeCXLD3 ZQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu1rt2sk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 13:33:08 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40OBuSpi025268;
	Wed, 24 Jan 2024 13:33:07 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrtqkdp4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 13:33:07 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40ODX7Of26018534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 13:33:07 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C4A158054;
	Wed, 24 Jan 2024 13:33:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1529C5805C;
	Wed, 24 Jan 2024 13:33:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.166.202])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jan 2024 13:33:05 +0000 (GMT)
Message-ID: <8f8b573a3dda6020972f359f9c54d03272afe852.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/7] ima: define and call ima_alloc_kexec_file_buf
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Wed, 24 Jan 2024 08:33:05 -0500
In-Reply-To: <20240122183804.3293904-2-tusharsu@linux.microsoft.com>
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
	 <20240122183804.3293904-2-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3sntGgXaV1I3vNnS7rqBknklyO8b8ALu
X-Proofpoint-ORIG-GUID: 3sntGgXaV1I3vNnS7rqBknklyO8b8ALu
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240098

Hi Tushar,

On Mon, 2024-01-22 at 10:37 -0800, Tushar Sugandhi wrote:

Missing from this and the other patch descriptions is the problem
description.  Please refer to the section titled  "Describe your changes" in 
https://docs.kernel.org/process/submitting-patches.html.

"Describe your problem.  Whether your patch is a one-line bug fix or 5000 lines
of a new feature, there must be an underlying problem that motivated you to do
this work.  Convince the reviewer that there is a problem worth fixing and that
it makes sense for them to read past the first paragraph."

In this case, "why" you need to refactor ima_dump_measurement_list() is the
problem.

For example:

Carrying the IMA measurement list across kexec requires allocating a buffer and
copying the measurement records.  Separate allocating the buffer and copying the
measurement records into separate functions in order to allocate the buffer at
kexec "load" and copy the measurements at kexec "execute".

"Once the problem is established, describe what you are actually doing about it
in technical detail.  It's important to describe the change in plain English for
the reviewer to verify that the code is behaving as you intend it to."

> Refactor ima_dump_measurement_list() to move the memory allocation part
> to a separate function ima_alloc_kexec_file_buf() which allocates buffer
> of size 'kexec_segment_size' at kexec 'load'.  Make the local variable
> ima_kexec_file in function ima_dump_measurement_list() as local static to
> the file, so that it can be accessed from ima_alloc_kexec_file_buf().
> Make necessary changes to the function ima_add_kexec_buffer() to call the
> above two functions.

Please make this into an unordered list.

-- 
thanks,

Mimi


