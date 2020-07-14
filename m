Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374B421F012
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jul 2020 14:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGNMJH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jul 2020 08:09:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726748AbgGNMJH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jul 2020 08:09:07 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06EC30Te095417;
        Tue, 14 Jul 2020 08:09:05 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 327tna8dxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 08:09:04 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06EC11QX017939;
        Tue, 14 Jul 2020 12:09:04 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 327528r30g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 12:09:04 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06EC93ZS48300510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jul 2020 12:09:03 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D985AAC059;
        Tue, 14 Jul 2020 12:09:03 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0DB9AC05B;
        Tue, 14 Jul 2020 12:09:03 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 14 Jul 2020 12:09:03 +0000 (GMT)
Subject: Re: [PATCH v9 2/2] tpm: Add support for event log pointer found in
 TPM2 ACPI table
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20200706181953.3592084-1-stefanb@linux.vnet.ibm.com>
 <20200706181953.3592084-3-stefanb@linux.vnet.ibm.com>
 <20200706230914.GC20770@linux.intel.com>
 <78ec872f-89b3-6464-6ede-bd0a46fe5c4c@linux.ibm.com>
 <20200707022416.GC112019@linux.intel.com>
 <f3e0fb50-8617-da40-1456-158531a070cb@linux.ibm.com>
 <20200707040325.GB143804@linux.intel.com>
 <85c27199-df55-eecc-855c-dedcea64f89e@linux.ibm.com>
 <20200708140753.GC538949@linux.intel.com>
 <e42cb59d-6a3d-12be-bb51-88aa8c5dba23@linux.ibm.com>
 <20200714112030.GA1448526@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <69907c30-62c2-b4bd-e84f-11612bba9c95@linux.ibm.com>
Date:   Tue, 14 Jul 2020 08:09:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200714112030.GA1448526@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-14_03:2020-07-14,2020-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140085
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/14/20 7:20 AM, Jarkko Sakkinen wrote:
> On Wed, Jul 08, 2020 at 10:17:17AM -0400, Stefan Berger wrote:
>>> ❯ swtpm-mvo.swtpm socket --tpmstate dir=/tmp/mytpm1 \
>>>     --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
>>>     --log level=20
>>> swtpm: Could not open UnixIO socket: No such file or directory
>>
>> Did you create the directory '/tmp/mytpm1' ?
> Yes. It's the socket file that it is complain because it does
> not exist beforehand.


The socket file is created by the swtpm program.


>
> /Jarkko


