Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB4D1188931
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2020 16:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgCQPbM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Mar 2020 11:31:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726019AbgCQPbM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Mar 2020 11:31:12 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02HFLvcn072619;
        Tue, 17 Mar 2020 11:30:52 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ytb4uk3v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Mar 2020 11:30:52 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02HFH5Lv006235;
        Tue, 17 Mar 2020 15:30:51 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03wdc.us.ibm.com with ESMTP id 2yrpw696ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Mar 2020 15:30:51 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02HFUoca16384432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Mar 2020 15:30:51 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF441AE062;
        Tue, 17 Mar 2020 15:30:50 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFD5FAE05F;
        Tue, 17 Mar 2020 15:30:50 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 17 Mar 2020 15:30:50 +0000 (GMT)
Subject: Re: [PATCH] tpm2: Export tpm2_get_cc_attrs_tbl for ibmvtpm driver as
 module
To:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
References: <20200317130819.720318-1-stefanb@linux.vnet.ibm.com>
 <03C24A2B-643D-4CDB-99FA-F5321684EEE4@linux.vnet.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <d0c79cd1-a16b-b0c2-1828-69133670ea82@linux.ibm.com>
Date:   Tue, 17 Mar 2020 11:30:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <03C24A2B-643D-4CDB-99FA-F5321684EEE4@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_05:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003170062
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/17/20 11:22 AM, Sachin Sant wrote:
>> On 17-Mar-2020, at 6:38 PM, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>>
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> This patch fixes the following problem when the ibmvtpm driver
>> is built as a module:
>>
>> ERROR: modpost: "tpm2_get_cc_attrs_tbl" [drivers/char/tpm/tpm_ibmvtpm.ko] undefined!
>> make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
>> make: *** [Makefile:1298: modules] Error 2
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>

Thank you!

    Stefan


