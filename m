Return-Path: <linux-integrity+bounces-4586-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0ECA159EB
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Jan 2025 00:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEBAE168EB1
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jan 2025 23:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44641BD017;
	Fri, 17 Jan 2025 23:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NiA3Jv8q"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463F1D47A2;
	Fri, 17 Jan 2025 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737156654; cv=none; b=of2ToOQNDULmfqI/4XVMfCjqhposqvkh4R8xgcfa7kvyp3YS6rDd75m1e3R15P6+y91fkh9FgsIIvXL/0x1ZnaT9iGYQ4LuHhtpYaOQUkFhhiiKfkGbMCOsyfuqjZdKNz71ZBNCEY0jrb0OqpM82OxhQGVUUETc9OXpJL5v4838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737156654; c=relaxed/simple;
	bh=y/zjAo+P+L1BVvVxHliZSn3gIvYC9Rs2udH2vQllhrw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KlOBMEZepPwgAFFsHEdHjJScMGM6KJmGyv6Gwqq9DWyb8+Ns1zWUBM3cbL9eSf/VRrj4MvlKgWgHwfT6Wi4X5kxxThaumP4gRvEWZTTUfuVN3Txfuv9irK4odM111rqcKFzk0oInq5pTLa5f6F9FA+HRS+jzgW38IEXOHgpru98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NiA3Jv8q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HE6HTG021079;
	Fri, 17 Jan 2025 23:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/TqJwc
	8A+Lo37d1BW9sc3KiUOnQhGi5Ng8z3Hvrd2bc=; b=NiA3Jv8qDK5mLTLAcpV709
	VHoUBupdGszBlLTyD9y6HOz62v5L4B6HKGPRmWZc8AzIXx/hQ9+T1jkkhBAtQJ9i
	65qU868L8JNjhXo8WQy93lbMRnY+5JGgAiA6laQUbhM0RX8zc/jdoz/mUuvGh2EZ
	X6R+eTf7NyHQk+cOWXBTqt/gh88o1fSCNKMcTYyQdJo36WMF/Yqt6sDbgvb601Ni
	em77G9FHBFSbFZbDb4Zy4DY3rMIWqiNnXbr+wuGk2VV5sbcJy1mV0s6b/4CDIRej
	aJz9u8JkdjryiBlf+h67CbMjUIy97nYCfVTZd51DJJ9imyM85DR3wDX9W6yNUhGg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447rp5addx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 23:30:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50HM8QpG007364;
	Fri, 17 Jan 2025 23:30:44 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443ynn86a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 23:30:44 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50HNUhDK28246590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 23:30:43 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 596FB5805E;
	Fri, 17 Jan 2025 23:30:43 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0059A58055;
	Fri, 17 Jan 2025 23:30:43 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.15.82])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jan 2025 23:30:42 +0000 (GMT)
Message-ID: <32c5f9658265b862f300d2cb53ab25ce0e3f0c2b.camel@linux.ibm.com>
Subject: Re: [GIT PULL] integrity: subsystem updates for v6.13  (please
 ignore)
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel
 <linux-kernel@vger.kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Date: Fri, 17 Jan 2025 18:30:42 -0500
In-Reply-To: <2c3b092932bac0945b6d71326a726e09a8f50ee8.camel@linux.ibm.com>
References: <2c3b092932bac0945b6d71326a726e09a8f50ee8.camel@linux.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wMpQw1FuCz_yxjE6fOJx8Sstzesoe7HU
X-Proofpoint-ORIG-GUID: wMpQw1FuCz_yxjE6fOJx8Sstzesoe7HU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_08,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=591
 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501170182

Linus,

Please ignore this pull request.  Will resend shortly.

Mimi

