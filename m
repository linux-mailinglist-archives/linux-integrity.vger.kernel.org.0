Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B4F3B794C
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jun 2021 22:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbhF2U30 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Jun 2021 16:29:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235365AbhF2U3Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jun 2021 16:29:25 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TK2fZX132955;
        Tue, 29 Jun 2021 16:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RDhTG1oAvwX1v0k7pK8IpZBDPyBUUO3ZCe5VBzxdlRo=;
 b=T+pHH6LyvYWpul6CAtZXAzSEikf3Gcrlrp00Smk5FyDeprQysNZuG6WDYProCq1Z0VZc
 g/BjMJvZe92J5OLcCTXN1/ihLvIhbJyX7Rxs1TDUzgoXhOq+BJ5lNX/lGwZdQ8ciBY5r
 XSXFwr9dKnTUONhTQaRmBddt1fhBUDldEh4kwtjO+Ms6fWW3RsjirADKB6ZoyXoYXMWX
 HnzaA15DA+WfLclTgFklDm0wSMbfcVbFkJYR7EhgI33w4upHMDGCw9awb3llN9aWz7Tg
 PluK2zjvFVTQUVrvk7LWwTMdXYKIx/sV+/UB0Z/TiKQkWUA2uvJ6mMwBrceElJd8jbxU Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39ga540kws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 16:26:50 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15TK34jC134635;
        Tue, 29 Jun 2021 16:26:49 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39ga540kw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 16:26:49 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15TKGggE023899;
        Tue, 29 Jun 2021 20:26:49 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 39duvctj61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 20:26:48 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15TKQmPj41419096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 20:26:48 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E62EC12403D;
        Tue, 29 Jun 2021 20:26:47 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCD2012401D;
        Tue, 29 Jun 2021 20:26:47 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jun 2021 20:26:47 +0000 (GMT)
Subject: Re: [PATCH] certs: Redirect openssl error message to null device
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        nayna@linux.ibm.com, jeyu@kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, kernel test robot <lkp@intel.com>
References: <20210625122902.4058783-1-stefanb@linux.vnet.ibm.com>
 <9e925935-529e-49c9-e499-3eac43bddb66@linux.ibm.com>
 <20210629201257.dr77kemy66mxpox5@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <1f8b880a-fc01-34d6-20c2-9d573fd3797b@linux.ibm.com>
Date:   Tue, 29 Jun 2021 16:26:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210629201257.dr77kemy66mxpox5@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZSOwOWpKEXS7-ugClBmsx1c3Yhi6JTTu
X-Proofpoint-ORIG-GUID: Hh7mCvBkevXUpZZfo7VLAyf1-WPIfsN5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_11:2021-06-29,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 spamscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290125
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 6/29/21 4:12 PM, Jarkko Sakkinen wrote:
>
> The problem is that I have already a pending pull request, and merge window
> is soon closing.
>
> I think it's a better idea that I just drop these patches and send a new
> pull request, and you should construct a new version of the series. This
> cannot be a blocker for the rest of the patches (or even potential
> blocker). We can consider the current patches not ready for mainline.

I posted v7 based on what you had queue for the PR with the changes that 
I document for v7.

  Stefan


>
> /Jarkko
