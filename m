Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117441A889A
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2020 20:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503405AbgDNSHn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Apr 2020 14:07:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7863 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503393AbgDNSHm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Apr 2020 14:07:42 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03EI4Jis162387;
        Tue, 14 Apr 2020 14:07:32 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30dc3rkjdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Apr 2020 14:07:30 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03EI4V2c163496;
        Tue, 14 Apr 2020 14:07:30 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30dc3rkjcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Apr 2020 14:07:30 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03EHwQMJ013910;
        Tue, 14 Apr 2020 18:07:28 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 30b5h6seec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Apr 2020 18:07:28 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03EI7RUY52953438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 18:07:27 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34E9BAE05C;
        Tue, 14 Apr 2020 18:07:27 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7901AAE063;
        Tue, 14 Apr 2020 18:07:26 +0000 (GMT)
Received: from [9.80.213.149] (unknown [9.80.213.149])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 14 Apr 2020 18:07:26 +0000 (GMT)
Subject: Re: [PATCH] ima: optimize ima_pcr_extend function by asynchronous
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, zhangliguang@linux.alibaba.com,
        zhang.jia@linux.alibaba.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200414115020.99288-1-tianjia.zhang@linux.alibaba.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <0fdd1c13-51c6-e65c-1ca5-38621fa21f53@linux.ibm.com>
Date:   Tue, 14 Apr 2020 14:07:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414115020.99288-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-14_08:2020-04-14,2020-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1011 spamscore=0 mlxlogscore=778 lowpriorityscore=0 phishscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140131
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I wonder if there's a different issue?  I just ran selftest with 
fullTest = yes in two different TPM vendors.

One took 230 msec, the other 320 msec.

I've never seen anything near 10 seconds.

Note that this is worse than the worst case because it's forcing a full 
retest.  The TPM typically starts its self test immediately at power up 
and could be complete by the time the OS starts to boot.

When I run selftest with fullTest = no, I get 30 msec, probably
because it's not doing anything.

On 4/14/2020 7:50 AM, Tianjia Zhang wrote:
> Because ima_pcr_extend() to operate the TPM chip, this process is
> very time-consuming, for IMA, this is a blocking action, especially
> when the TPM is in self test state, this process will block for up
> to ten seconds.


