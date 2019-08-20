Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B40F95C6D
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Aug 2019 12:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfHTKmD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Aug 2019 06:42:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728842AbfHTKmC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Aug 2019 06:42:02 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KASNmu086823;
        Tue, 20 Aug 2019 06:42:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ugdc5nq3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 06:42:00 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7KAT7b3089648;
        Tue, 20 Aug 2019 06:42:00 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ugdc5nq2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 06:42:00 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7KAeNQC022617;
        Tue, 20 Aug 2019 10:41:59 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04dal.us.ibm.com with ESMTP id 2ue976vc1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 10:41:59 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7KAfwnm42140020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 10:41:58 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EC3DAE05F;
        Tue, 20 Aug 2019 10:41:58 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E9C2AE05C;
        Tue, 20 Aug 2019 10:41:58 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 20 Aug 2019 10:41:58 +0000 (GMT)
Subject: Re: Does probing of TIS with interrupts work
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <f721bf34-1cfc-de2b-91e4-24b17150645b@linux.ibm.com>
 <20190813122838.GD29508@ziepe.ca>
 <20190815211701.7nhq3uelpddho7i7@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <dcb4e436-4da4-6e82-09eb-1f9f5fd344a4@linux.ibm.com>
Date:   Tue, 20 Aug 2019 06:41:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190815211701.7nhq3uelpddho7i7@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908200111
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/15/19 5:17 PM, Jarkko Sakkinen wrote:
> On Tue, Aug 13, 2019 at 09:28:38AM -0300, Jason Gunthorpe wrote:
>> On Mon, Aug 12, 2019 at 11:39:27PM -0400, Stefan Berger wrote:
>>> I have tried to get probing of TIS with interrupts to work on a module and I
>>> am wondering whether it works for anyone. I noticed it tries to probe while
>>> locality 0 is released and the TPM_CHIP_FLAG_IRQ is never set, so it never
>>> gets to certain places in the code. To get it to work I had to add a patch
>>> like this one here to tpm_tis_core_init:
>> It worked a long time ago, probably bitrotted
>>
>> We should probably drop it entirely if it doesn't even work today and
>> nobody has complained.
> I'd prefer to fix this.

I'll post a patch...

     Stefan


