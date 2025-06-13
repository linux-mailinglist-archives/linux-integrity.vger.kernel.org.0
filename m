Return-Path: <linux-integrity+bounces-6450-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EA7AD96A4
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Jun 2025 22:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7073BD0B6
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Jun 2025 20:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228992253B0;
	Fri, 13 Jun 2025 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IA3hFgAT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9847820E002
	for <linux-integrity@vger.kernel.org>; Fri, 13 Jun 2025 20:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749847780; cv=none; b=RCdXdBTWQHbfij0LZMW0o6rgBgf0D7DpmtAOgJMMKYmlJgbxz60GjtNHz3TGa4vsom349Er5vECAi/Trc9fwFEXEiJWh7j/lvlhMB7u9yzvFF3r92/Nq/PjnSLD2767UkAVbAdmVuWiF9SvGRK1muwkZMDGpE1JaguOnbm9vWzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749847780; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=sjEKGj0J1bNoYr/ccDCimx4/QARJWjmeOqTjWAAz044+dGT0WLpdpNn4fdwSCnoPIoq4T/Ng1/l7nqwVa3lEWaSgW6jNr0E41s40zIE73rUOL+eIpJVvT9kL+cPaGr/oMXRUMNXnxwVwZBSu85hPkco3RlvicuBzSQRvqbM3+pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IA3hFgAT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DJPj6s020661
	for <linux-integrity@vger.kernel.org>; Fri, 13 Jun 2025 20:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=47DEQpj8HBSa+/TImW+5JCeuQeRk
	m5NMpJWZG3hSuFU=; b=IA3hFgATAJy4Mdboj55L4RfPLtNQ3oF1dpmkOGlvNUC2
	1gSPuf2m1mgcCMrJ0feXTRFbYDSrkXc9F7kA6nOAHJIj3nOrr5t+T5ow38uMjOy3
	LVPdH0E7dHgMnSYr0b+6ang7RuzmWefiaJJ9lQ2tv4ffJKEc5pBSNZajFvdC6SBN
	iGWb+x1YAlU0WC5SirIY/Y7TzWEV0S0bRRMYYyJJK1V89/9bSa60Xjh2qFemQ7de
	6b05+BQeYUlnraBFzzy8yFP+Kq7/EM7Kv5PuNnn7Z8bEuqt0y3OBy0LvpZJLfZ/v
	kK9UlpjKpJiZR4hY+eOouruIomFmqNR1zqAYD8WTWA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4mrbs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 13 Jun 2025 20:49:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55DHdftG015192
	for <linux-integrity@vger.kernel.org>; Fri, 13 Jun 2025 20:49:34 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrtv2s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 13 Jun 2025 20:49:34 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55DKnYUR25821896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-integrity@vger.kernel.org>; Fri, 13 Jun 2025 20:49:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0058558052
	for <linux-integrity@vger.kernel.org>; Fri, 13 Jun 2025 20:49:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2BC558065
	for <linux-integrity@vger.kernel.org>; Fri, 13 Jun 2025 20:49:33 +0000 (GMT)
Received: from [9.61.187.110] (unknown [9.61.187.110])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP
	for <linux-integrity@vger.kernel.org>; Fri, 13 Jun 2025 20:49:33 +0000 (GMT)
Message-ID: <102703b5-c503-448a-9da2-5c50e7c2b34e@linux.ibm.com>
Date: Fri, 13 Jun 2025 16:49:33 -0400
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
X-Authority-Analysis: v=2.4 cv=Y4X4sgeN c=1 sm=1 tr=0 ts=684c8edf cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=tclcd6dtLQvEqt9_mmAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YcwIL74xJuQ_FpOHU2fRlM-ABBP1nAmB
X-Proofpoint-ORIG-GUID: YcwIL74xJuQ_FpOHU2fRlM-ABBP1nAmB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDE0NiBTYWx0ZWRfX0LB5M2J2iPmP qJGwb4zdoWjo2qWtSBJAqXMHvajDJKQ+dERFLqFypkpxSBHv0Rjda0YaAu46yLtpgD/TrNT7ZvO vblzdE1lFe1zvfcnlt4cB8LwNCQta2YTFql8Hj6IBxpK0b64nEpTasCjrURdDuP6tNjS3cu2PY2
 FxspIFv7bxkaFRAUTyeTw5CCN7V3ProfDwTbZnJQKXHCTCleyAXpenc6oiXeNYJD1SBubI46B6D Enm/3JO1d9c0mERB+iYK/R4YA7pQCwb4+F0xHhuHBHgOvdkDs1PVXCPz4q2fCHa+8mAetDzHXJu 1woimXSFEVDDSLi1PMogBKciXa7xms3roMjGwEIIvxKeHMsc0HPev3f7PFasMGHeY0T+6gHI3HE
 NiuzNznxog9039MGrADQtjzqV6RQMX2CCoMZn7OO8n1CfR2UzxEjfmBIbzwKLPMeslSqqhtg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_03,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=353 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506130146



