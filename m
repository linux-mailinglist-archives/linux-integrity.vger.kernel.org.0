Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCE631A7CB
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Feb 2021 23:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhBLWfi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Feb 2021 17:35:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232391AbhBLWdP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Feb 2021 17:33:15 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11CMWWuF013561;
        Fri, 12 Feb 2021 17:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RpUwvRSXFYNqFVyqJSUSQ8v6XBHrR5prZRtVeNjDcls=;
 b=JUY4A+u7eIeOTD17XAhAbsDEg0DQ+m3c3idoGa2MaPF/lE2rdSNJzWpxoBjJdSxluoYh
 4AgJ37BCxCJJcqRckfejKYHWO9JGwRc4/9nZJ7vUnpdKKpDmrF+QIN12S8OyeIZE/zDy
 UmK9B2UDZRSUAh7VPmQsFRS91lMQHRAnKLbz1HNGHYYs8h4ciny7s2dy722a9PIUmryy
 jAk8U/5yOvBdd/PvsXS4wtIwSGwEOTWevwc6HODHHALbdSzdjKQ4HYeu+LXeBiLxWUa5
 jtyInby3h9FdjWPJdqFWBpeahV9rTTCGxRfs/U2Co/BWqKdClzeaMe5rR8ue1Yfa2rGp Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36p2evr4s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 17:32:34 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11CMWX3X013632;
        Fri, 12 Feb 2021 17:32:33 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36p2evr4kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 17:32:33 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11CMTNiI007231;
        Fri, 12 Feb 2021 22:32:15 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03wdc.us.ibm.com with ESMTP id 36hjra0cy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 22:32:15 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11CMWE9J8454882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 22:32:14 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A17CB124064;
        Fri, 12 Feb 2021 22:32:14 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E3D2124062;
        Fri, 12 Feb 2021 22:32:14 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 12 Feb 2021 22:32:14 +0000 (GMT)
Subject: Re: [PATCH] tpm: ibmvtpm: Avoid -EINTR error when IMA talks to TPM
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>
References: <20210209221339.875739-1-stefanb@linux.ibm.com>
 <YCZE8nf9ylXJTo4k@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <e850c8e8-76ab-548c-1f45-6e68d9faecac@linux.ibm.com>
Date:   Fri, 12 Feb 2021 17:32:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YCZE8nf9ylXJTo4k@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_09:2021-02-12,2021-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120161
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/12/21 4:05 AM, Jarkko Sakkinen wrote:
> On Tue, Feb 09, 2021 at 05:13:39PM -0500, Stefan Berger wrote:
>> When IMA is taking measurements during compilation for example and a
>> user presses ctrl-c to abort the compilation, lots of these types of
>> messages will appear in the kernel log:
>>
>> [ 7406.275163] tpm tpm0: tpm_transmit: tpm_recv: error -4
>> [ 7406.275242] ima: Error Communicating to TPM chip, result: -4
>>
>> The issue is caused by the fact that the IBM vTPM driver's recv()
>> function is called immediately after send() without waiting for
>> status on whether a response was received. It currently waits for
>> the current command to finish using this call that ends up throwing
>> these error messages because it is 'interruptible':
> Why it is an issue?


The issue is the many kernel log entries we get when someone interrupts 
an application with ctrl-c while IMA is taking measurements of files it 
reads.I thought that was clear from the first paragraph.


