Return-Path: <linux-integrity+bounces-6448-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C28CAD9503
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Jun 2025 21:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B8D3A8361
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Jun 2025 19:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D99C238D49;
	Fri, 13 Jun 2025 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gNaODD++"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A9F146A72
	for <linux-integrity@vger.kernel.org>; Fri, 13 Jun 2025 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749841962; cv=none; b=JCxtqo0QAqprlQ+bQJF1GUJJ9gD7UhudkdhmyDaW0GS6TPAv3lYCwupE3byTTZeifLKPVKE9qI+e2Jcaa6tHlON/ZaQIKnhBVCKp/XlfyAObRCdnIG2FXrTj+ynTQSq3pMyHBs79rVrJtmvuvWzGX/q04WVp0E0HztBFKsHtZ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749841962; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=fY67y3WnVC7EnK7dmPA24TQhLPGH3Cun1lCXJ0tSkKf0aWGgqaQe1z++uK+JrYDWCgjj+DPXTBFswGIK0x488BP2wEXNPUmN2czYK8kTEOiP5lmNYOHr14IL3WHlo8EcNpqN8Ai5ZxTjdw2DC4klB4eyzo+qze2akvhUgzkcGQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gNaODD++; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DHV3rM012486
	for <linux-integrity@vger.kernel.org>; Fri, 13 Jun 2025 19:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=47DEQpj8HBSa+/TImW+5JCeuQeRk
	m5NMpJWZG3hSuFU=; b=gNaODD++u6yK3Xxg2E/jsFOil46Hn5nyTsUE5ZY+xOEu
	5E0JNVoTdstkFYpTzjwHXKY/SODTZAKsiNBdvQqglBa7VQr/JiOFA99o0KcIIzgq
	5PONKOfHLkz5ubBlwOJ+Z9gDj0eXSPpoSRy8xSK7Ima4Aw0QS54a/feDSVzC3biQ
	1bipM5OETYOdJfcsLB0Cgu+RIjGjXHTCjz/HCimeMC7IpZgGlHStmDSBNLEM988m
	Kg3A5C+axzqT28ML1TIz0UX22o6a36flhnGir6J6TQhGFXvXy8mD+Q1agI9nzRDv
	WBjvrYia4E1gwufukxGn4ICPzes3uWzrh7UEIUyzWA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxju5ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 13 Jun 2025 19:12:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55DIqko5003347
	for <linux-integrity@vger.kernel.org>; Fri, 13 Jun 2025 19:12:38 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4751ym39x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 13 Jun 2025 19:12:38 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55DJCbeg13369890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-integrity@vger.kernel.org>; Fri, 13 Jun 2025 19:12:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDD4058068
	for <linux-integrity@vger.kernel.org>; Fri, 13 Jun 2025 19:12:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABA9558067
	for <linux-integrity@vger.kernel.org>; Fri, 13 Jun 2025 19:12:37 +0000 (GMT)
Received: from [9.61.187.110] (unknown [9.61.187.110])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP
	for <linux-integrity@vger.kernel.org>; Fri, 13 Jun 2025 19:12:37 +0000 (GMT)
Message-ID: <32daef64-59d6-479d-b978-fe7c640874f9@linux.ibm.com>
Date: Fri, 13 Jun 2025 15:12:37 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-integrity@vger.kernel.org
From: Nayna Jain <nayna@linux.ibm.com>
Subject: subscribe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dKS-ZEYKRBo1-RATrd5GXQWyi7aLiKNj
X-Proofpoint-GUID: dKS-ZEYKRBo1-RATrd5GXQWyi7aLiKNj
X-Authority-Analysis: v=2.4 cv=fZWty1QF c=1 sm=1 tr=0 ts=684c7827 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=tclcd6dtLQvEqt9_mmAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDEzMSBTYWx0ZWRfXyQ/XRuUCusXM g8L8xvN2UwGN+V8VdZi14XOL+iearswddgp9C3C8qN6Ozv5lbEN0NYig5zPybc1OekFhPBs6dJk EXqV+YIjluqPYNFdUHxYHG6AJQCldvh8iAkjKjPE5c64MJDwDSsTgl/nOmSL02I9FUkCMsaQXRQ
 r+Xx7izm5AexPfN6gOJcdbTn5fPv8F3w5S+FI1/WsaR9a5hbyQt+H1LZUjx+TMeXlXNnxSVVo7l IRVMoCSAek05QSYHSDWvwGfQ2fKCLTHGsNEM9/cVdujs7f6FPFG5+KV4uFalUSMt6TmR9226TFS gCQcuJvKjv6cbhX8yJdFE8WeovdVLlvOdRW1xnI+1BDk5+2XUukTB4Jb1LUBRvD8aX3eeEOA5RT
 dxuNRpKaAP2MX5ZmDstUH2YorRvLr3zxspfaKsX27JUKwVvBcSqHFlAqRLh48u6uQE1V+FMc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=348
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506130131



