Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E83C12A892
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Dec 2019 17:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfLYQq4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Dec 2019 11:46:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbfLYQq4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Dec 2019 11:46:56 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBPGbu26029394;
        Wed, 25 Dec 2019 11:46:47 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2x3mdu76qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Dec 2019 11:46:47 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBPGitAW029630;
        Wed, 25 Dec 2019 16:46:47 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 2x1b16k4sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Dec 2019 16:46:47 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBPGkk2N62259478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Dec 2019 16:46:46 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F32726E052;
        Wed, 25 Dec 2019 16:46:45 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B14E66E050;
        Wed, 25 Dec 2019 16:46:45 +0000 (GMT)
Received: from [9.80.238.60] (unknown [9.80.238.60])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 25 Dec 2019 16:46:45 +0000 (GMT)
Subject: Re: Does IMA support SHA-256 PCR banks?
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <62e91411-d38d-8b75-bf0e-849fdd3c447f@linux.microsoft.com>
 <36fb73d7534f47b6906c348792bd5d96@huawei.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <1de18a3c-ec1f-3654-0c33-3faa26e4b286@linux.ibm.com>
Date:   Wed, 25 Dec 2019 11:46:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <36fb73d7534f47b6906c348792bd5d96@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-25_05:2019-12-24,2019-12-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011 mlxlogscore=992
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912250142
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/11/2019 3:45 AM, Roberto Sassu wrote:
> 
> For the first part, the patch will be very simple, as IMA will just query the TPM
> to get the list of hash algorithms and will calculate all the digests in
> ima_calc_field_array_hash().

This query is probably for the allocated PCR banks.  I.e., a TPM may 
implement more hash algorithms than it allocates PCR banks.

For example, my hardware TPM reports 3 implemented hash algorithms, but
it only allocates 2 PCR banks.

$ getcapability -cap 5
3 PCR selections
     hash TPM_ALG_SHA1
     TPMS_PCR_SELECTION length 3
     ff ff ff
     hash TPM_ALG_SHA256
     TPMS_PCR_SELECTION length 3
     ff ff ff
     hash TPM_ALG_SHA384
     TPMS_PCR_SELECTION length 3
     00 00 00


