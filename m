Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152F317A6D0
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2020 14:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgCEN4j (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Mar 2020 08:56:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9988 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbgCEN4j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Mar 2020 08:56:39 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 025Dt2KZ096371;
        Thu, 5 Mar 2020 08:56:33 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yhhy81wfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Mar 2020 08:56:33 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 025DobjQ027477;
        Thu, 5 Mar 2020 13:56:31 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03wdc.us.ibm.com with ESMTP id 2yffk7be2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Mar 2020 13:56:31 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 025DuV7550659810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Mar 2020 13:56:31 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14330C6057;
        Thu,  5 Mar 2020 13:56:31 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0ACA6C6055;
        Thu,  5 Mar 2020 13:56:29 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  5 Mar 2020 13:56:29 +0000 (GMT)
Subject: Re: [PATCH v6 0/3] Enable vTPM 2.0 for the IBM vTPM driver
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, jgg@ziepe.ca
References: <20200304132243.179402-1-stefanb@linux.vnet.ibm.com>
 <deab5eab2de31a1116e16e025c94fbc6f1d0d742.camel@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <3e3a37ea-a1e7-e960-a892-1a5a4b146d30@linux.ibm.com>
Date:   Thu, 5 Mar 2020 08:56:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <deab5eab2de31a1116e16e025c94fbc6f1d0d742.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-05_04:2020-03-05,2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050090
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/5/20 6:20 AM, Jarkko Sakkinen wrote:
> On Wed, 2020-03-04 at 08:22 -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> QEMU 5.0 will support the PAPR vTPM device model for TPM 1.2 and TPM 2.0.
>> This series of patches enables vTPM 2.0 support for the IBM vTPM driver.
> BTW, what is PAPR vTPM device model? Is it something that is used
> generally for vTPM's or just in IBM context?

It's an IBM pSeries specification. The device model is only used on pSeries.


    Stefan


>
> /Jarkko
>

