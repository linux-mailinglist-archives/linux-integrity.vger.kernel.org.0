Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6774BE95B
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Feb 2022 19:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbiBUNei (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Feb 2022 08:34:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359139AbiBUNea (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Feb 2022 08:34:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5E2220EE;
        Mon, 21 Feb 2022 05:34:04 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21LD9Fck015805;
        Mon, 21 Feb 2022 13:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OBmPzCDj/H2f/L1YMi7Wukhw+jIUkf8pjUePNO4iA6k=;
 b=f33WKmOyvDuAAvRYbAD2+OiczjKSScTlMCbHi6mC3wq6ecRP3vXAHsh0GYjl8xjfQrhe
 O1tWAq5g4HLKaB8+lTrfccVKTgvYlQol/3+HzDmvM2pjHoULG3uLc+o2v1qaF5+fJ7iU
 +FM755oUmOk2TAJh3/hPwv9Y8vOYD615kYE/XWAU3PQrRMNTny/Yt+fswIU+HyH2tnjz
 MHp8eNXNrwVMUCo561vtNUc3CKh8WAXvieOXkTit/PhAP+TbGEpIUPAwfFI4xSKAoqen
 RwINGV8eYjStknAGI77SS18K3pWXb7lPSkmMv1j0QPprGj/VX0a2Vo1SjxxyUA6+fMew +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ec5q0gb97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 13:33:59 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21LCrBMi019070;
        Mon, 21 Feb 2022 13:33:59 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ec5q0gb8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 13:33:58 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21LDWtWq012841;
        Mon, 21 Feb 2022 13:33:58 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03dal.us.ibm.com with ESMTP id 3ear6aea0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 13:33:57 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21LDXu3Q17891718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 13:33:56 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A27B13605E;
        Mon, 21 Feb 2022 13:33:56 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65418136068;
        Mon, 21 Feb 2022 13:33:55 +0000 (GMT)
Received: from [9.211.59.13] (unknown [9.211.59.13])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 21 Feb 2022 13:33:55 +0000 (GMT)
Message-ID: <0a87bb3b-574c-6e8e-2f8f-49e42d71ab8c@linux.vnet.ibm.com>
Date:   Mon, 21 Feb 2022 08:33:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v8 0/3] integrity: support including firmware ".platform"
 keys at build time
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, Nayna Jain <nayna@linux.ibm.com>
References: <20220111183647.977037-1-nayna@linux.ibm.com>
 <YhLIhJF0aWZt+8op@iki.fi>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <YhLIhJF0aWZt+8op@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: poqCIJwnj1fzXspijlfmjWakY7HPsrzX
X-Proofpoint-GUID: dkbMQ8Nn6WyO0fh_-go_lbCTQ01aY0bX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-21_07,2022-02-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202210078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/20/22 18:02, Jarkko Sakkinen wrote:
> On Tue, Jan 11, 2022 at 01:36:44PM -0500, Nayna Jain wrote:
>> Some firmware support secure boot by embedding static keys to verify the
>> Linux kernel during boot. However, these firmware do not expose an
>> interface for the kernel to load firmware keys onto the ".platform"
>> keyring, preventing the kernel from verifying the kexec kernel image
>> signature.
>>
>> This patchset exports load_certificate_list() and defines a new function
>> load_builtin_platform_cert() to load compiled in certificates onto the
>> ".platform" keyring.
>>
>> Changelog:
>>
>> v8:
>> * Includes Jarkko's feedback on patch description and removed Reported-by
>> for Patch 1.
>>
>> v7:
>> * Incldues Jarkko's feedback on patch description for Patch 1 and 3.
>>
>> v6:
>> * Includes Jarkko's feedback:
>>   * Split Patch 2 into two.
>>   * Update Patch description.
>>
>> v5:
>> * Renamed load_builtin_platform_cert() to load_platform_certificate_list()
>> and config INTEGRITY_PLATFORM_BUILTIN_KEYS to INTEGRITY_PLATFORM_KEYS, as
>> suggested by Mimi Zohar.
>>
>> v4:
>> * Split into two patches as per Mimi Zohar and Dimitri John Ledkov
>> recommendation.
>>
>> v3:
>> * Included Jarkko's feedback
>>   ** updated patch description to include approach.
>>   ** removed extern for function declaration in the .h file.
>> * Included load_certificate_list() within #ifdef CONFIG_KEYS condition.
>>
>> v2:
>> * Fixed the error reported by kernel test robot
>> * Updated patch description based on Jarkko's feedback.
>>
>> Nayna Jain (3):
>>    certs: export load_certificate_list() to be used outside certs/
>>    integrity: make integrity_keyring_from_id() non-static
>>    integrity: support including firmware ".platform" keys at build time
>>
>>   certs/Makefile                                |  5 ++--
>>   certs/blacklist.c                             |  1 -
>>   certs/common.c                                |  2 +-
>>   certs/common.h                                |  9 -------
>>   certs/system_keyring.c                        |  1 -
>>   include/keys/system_keyring.h                 |  6 +++++
>>   security/integrity/Kconfig                    | 10 +++++++
>>   security/integrity/Makefile                   | 17 +++++++++++-
>>   security/integrity/digsig.c                   |  2 +-
>>   security/integrity/integrity.h                |  6 +++++
>>   .../integrity/platform_certs/platform_cert.S  | 23 ++++++++++++++++
>>   .../platform_certs/platform_keyring.c         | 26 +++++++++++++++++++
>>   12 files changed, 92 insertions(+), 16 deletions(-)
>>   delete mode 100644 certs/common.h
>>   create mode 100644 security/integrity/platform_certs/platform_cert.S
>>
>> -- 
>> 2.27.0
> To sort out tree conflicts: what if I pick these patches? They look fine
> to me now. I can try to fix the possible merge conflicts and you can check
> them before I make a PR.

Sounds good. Thanks !!

Thanks & Regards,

      - Nayna

