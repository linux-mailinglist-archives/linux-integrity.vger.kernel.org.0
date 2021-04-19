Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E3B364712
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Apr 2021 17:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbhDSP0y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Apr 2021 11:26:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233733AbhDSP0x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Apr 2021 11:26:53 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JF3xwF094845
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kbQvmxukVpGWHefhUNd5zjazm2OeIFICfNHais9bP8c=;
 b=MVKt9iB6z8zE8iJiVebo0jCZHfdEB7F6EKjVOYe19ciZFutSTOG3AzYqDSFdibXVrEOx
 Xnc4Mc4Nf9hUzflIEtMUsgbnkT8GpGsxOjd7Zu195i5bLQ6co9Ve32XxMCTWZXnnhQbU
 cPvDViBUsaOmzINJGiUHRATeA1rwlJuwYWyJOnVgxqI4hqg82Ut4Y7YVlp+RRleWE9xn
 BQV+GwN3E5u098M262dgOOFZi4QGMWmiQQkelym4olqzqCM9tLNyK1qTl2V0wg8Q/KPZ
 RzSy6ZiF/w22RJqzNYQIetXrsBI9BjErqyGhDMXJMmzOxygWgDLgimZ3L6CKsEagzwkv 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 380crawcr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:26:23 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13JFQMnH035290
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:26:22 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 380crawc4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 11:26:22 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13JF8QdS010585;
        Mon, 19 Apr 2021 15:22:03 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01dal.us.ibm.com with ESMTP id 37yqa9qku2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 15:22:03 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13JFM17025362792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 15:22:01 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E02D136060;
        Mon, 19 Apr 2021 15:22:01 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09F72136051;
        Mon, 19 Apr 2021 15:22:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 19 Apr 2021 15:22:00 +0000 (GMT)
Subject: Re: [PATCH 3/6] libimaevm: Rename variable returned from readlink to
 len
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
References: <20210419150151.236409-1-stefanb@linux.ibm.com>
 <20210419150151.236409-4-stefanb@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <b0e764ba-948e-95b4-fe5d-df3775ed02bb@linux.ibm.com>
Date:   Mon, 19 Apr 2021 11:22:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210419150151.236409-4-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FLj3WePG0foLb1It0dRT11XBzwshxCtE
X-Proofpoint-GUID: -OM6rrC5ObL1ey5qL1V9HgerIlo6nqdg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_11:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190104
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/19/21 11:01 AM, Stefan Berger wrote:
> The variable returned from readlink is a length indicator of the
> number of bytes placed into a buffer, not only an error. Leave
> a note in the code that a zero-length link is also treated as an
> error, besdies the usual -1.

Is link signing supported by IMA in the kernel? Maybe I missed something 
when looking at the code in the Linux kernel, but I could not find that 
it was supported. What about directory signing and socket/device file 
signing?


    Stefan


