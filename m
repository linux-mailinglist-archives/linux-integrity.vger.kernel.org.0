Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20883489D3D
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jan 2022 17:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiAJQMz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jan 2022 11:12:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237115AbiAJQMy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jan 2022 11:12:54 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AEU6Mm011396;
        Mon, 10 Jan 2022 16:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=X72bm89DSt7v+PGfkGU/R92DHl3PW+kziiCZAIZUcx4=;
 b=DS18P9QPrzyJW4bLKEDclH6Pn2aGZsqm2Lz2r+u6ckDeXf0g71c9koZY8R+7EKUv6Skx
 rJ5kc5qzj8MkvxIQqkfZn2Nuo7b6xAiB4HqDE03v+z9bdbsKKnCNtHelZci59foHzX83
 ArKTnV2JCnsqZcFIr3ReZz8GUvvIN+aAnf6mLSXZJ0jueS9u/zXGOpQoJ9M9nSjb4LLP
 eo+bfjlv0A0tYtz1awPyha7WFf+KQ9EopEI9AcwKuNy203tAEY73jxklBSfLagP6jGQ1
 Or9R7xD17igbP0sze9Am3GV2lN9UMAz+v3sRxNZP3saY/ti3HXdzY/O++vm0d6Psg804 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dfm9gx6eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 16:12:48 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20AGCmhZ010558;
        Mon, 10 Jan 2022 16:12:48 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dfm9gx6e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 16:12:48 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20AGBxIw008665;
        Mon, 10 Jan 2022 16:12:47 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04wdc.us.ibm.com with ESMTP id 3df289r8m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 16:12:47 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20AGCkqR36569536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 16:12:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E239DB2077;
        Mon, 10 Jan 2022 16:12:45 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 162F9B2067;
        Mon, 10 Jan 2022 16:12:43 +0000 (GMT)
Received: from [9.211.85.241] (unknown [9.211.85.241])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 10 Jan 2022 16:12:42 +0000 (GMT)
Message-ID: <5b00bcbe-9881-b879-2474-33c52315a7a9@linux.vnet.ibm.com>
Date:   Mon, 10 Jan 2022 11:12:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v7 1/3] certs: export load_certificate_list() to be used
 outside certs/
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, kernel test robot <lkp@intel.com>
References: <20220105175410.554444-1-nayna@linux.ibm.com>
 <20220105175410.554444-2-nayna@linux.ibm.com> <YdmXlUcsa+xRcwSN@iki.fi>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <YdmXlUcsa+xRcwSN@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GW4ck36GhcRDvv2hy__-X2VSbPf_exk3
X-Proofpoint-GUID: jg9HPzLIclPxZaGKauZ977T9ccjt23qF
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_07,2022-01-10_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201100113
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/8/22 08:54, Jarkko Sakkinen wrote:
> On Wed, Jan 05, 2022 at 12:54:08PM -0500, Nayna Jain wrote:
>> load_certificate_list() parses certificates embedded in the kernel
>> image to load them onto the keyring.
>>
>> Commit "2565ca7f5ec1 (certs: Move load_system_certificate_list to a common
>> function)" made load_certificate_list() a common function in the certs/
>> directory. Now, export load_certificate_list() outside certs/ to be used
>> by load_platform_certificate_list() which is added later in the patchset.
>>
>> Reported-by: kernel test robot <lkp@intel.com> (auto build test ERROR)
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> This lacking fixes tag, if it is a bug, or "reported-by" needs to be
> completely removed.

When I posted my first version for this patch set, kernel test robot 
reported the build error - 
https://lore.kernel.org/linux-integrity/202109110507.ucpEmrwz-lkp@intel.com/

The Reported-by tag is because of this statement in the reported error - 
" If you fix the issue, kindly add following tag as appropriate 
Reported-by: kernel test robot <lkp@intel.com>"

Do you still think that the tag is not required ? If so, I am fine to 
remove it.

Thanks & Regards,

      - Nayna

