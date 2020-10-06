Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361EA2850EA
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Oct 2020 19:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgJFRhr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Oct 2020 13:37:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbgJFRhr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Oct 2020 13:37:47 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 096HYPZW070186;
        Tue, 6 Oct 2020 13:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8HU3psVlh9k0kCn8UJVzAFAEuptjwMhk1FMDjM4hdc8=;
 b=XsldzDxwMwRaarzv/4l0R31W5E6aSDMXcIQ6u9iPQ7Ti6VCGysiwhqQeoNApTEVeepwB
 HO0FTNbVeK3y7HDstxic82z87RqTXQQNWEmc0SEcrUVkCttnolIMqkRjs6is1NmNnQbk
 ZdX1yyigDtQ06Q3f45lgdgngBM6nQKTV7UWUh1q8m4Vvg03m9A/zF8F9OMPV2h+rBW7v
 1iTAh7Wtg2tqLQQnMcZT9IegRpghJxUmHyLiN4DI3u7tECLFUhNdeJCxHPNsu5OEgQgh
 gIDZQOX7VSAHC+v+5ricOzgD/2ZQp7CwVJboyWQ4cxPDroZ5omw+H5PjHs6OxNB6vR79 lw== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 340vt1rnak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Oct 2020 13:37:43 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 096HbQn5028405;
        Tue, 6 Oct 2020 17:37:42 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 33xgx9ff7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Oct 2020 17:37:42 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 096Hbffe61407738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Oct 2020 17:37:41 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3595B6A04F;
        Tue,  6 Oct 2020 17:37:41 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B62236A047;
        Tue,  6 Oct 2020 17:37:40 +0000 (GMT)
Received: from [9.85.186.165] (unknown [9.85.186.165])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  6 Oct 2020 17:37:40 +0000 (GMT)
Subject: Re: [PATCH v3 0/4] TPM 2.0 fixes in IMA tests
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Petr Vorel <pvorel@suse.cz>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
References: <20200929165021.11731-1-pvorel@suse.cz>
 <20200929231118.GA805493@linux.intel.com> <20200930055314.GA21664@dell5510>
 <20200930115939.GB7612@linux.intel.com> <20201001120125.GE32109@dell5510>
 <20201001183104.GA15664@linux.intel.com> <20201006100130.GA14868@dell5510>
 <20201006155505.GB111447@linux.intel.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <ebf16375-39af-d09c-effd-4fa072394057@linux.ibm.com>
Date:   Tue, 6 Oct 2020 13:37:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201006155505.GB111447@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-06_10:2020-10-06,2020-10-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1011 adultscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010060112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/6/2020 11:55 AM, Jarkko Sakkinen wrote:
> On Tue, Oct 06, 2020 at 12:01:30PM +0200, Petr Vorel wrote:
>> If I understand James's commit fdc915f7f719 ("tpm: expose spaces via a device link /dev/tpmrm<n>")
>> from v4.12-rc1 correctly /dev/tpmrm0 is really for TPM 2.0. But how to detect it
>> for v4.0 - v4.11 when /sys/class/tpm detection fails?
> 
> I'd send an idempotent TPM2 command to /dev/tpm0. I.e. if it works,
> it does not change the state. If it doesn't, you know that it is
> not TPM2 device.
> 
> See the kernel function tpm2_probe() as an example of this approach.
>

As good candidate is getcapability, because it is guaranteed never to
require authorization.

