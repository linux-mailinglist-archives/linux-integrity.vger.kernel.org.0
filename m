Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C5A4CE816
	for <lists+linux-integrity@lfdr.de>; Sun,  6 Mar 2022 02:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiCFBdu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 5 Mar 2022 20:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiCFBdt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 5 Mar 2022 20:33:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A012D506FB;
        Sat,  5 Mar 2022 17:32:58 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2260g5MM017611;
        Sun, 6 Mar 2022 01:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=sqj4L3iFBiCsxLfju0d8t9uixWVZhENCYyevRk24lZU=;
 b=KUss6NYbEoOIMGm4Cdz4u+bgZpGiq/Qhs2DjdoUDwvmaryejA/6FlZGx8vjbPPlkriqR
 et26Nr4EWbexHsTqwVmh3QZl7dIWXX6rqMyInrj821hfXn47oJH5PIYcLgv7So3Cdm0t
 Xre3Hcilglu9Wziic1PgYqNVBa18Kk23Ie4zXWnUgYHe1i69m8lPLYCPa0U+iXYSlSDT
 KXtkqwsnsE0COFquXl+Tl59rVxos2lzLyJsJ9BB0EYFjLOzTlFgw3VCxEMP/01WPvq/0
 7dbgI6zYzHcuT4v6ct0Z03BgcCIDecSwRSubCDcqoxVSuUHvubDBKIDMtqV3XFWrddkU hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3emjmw0f62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Mar 2022 01:32:48 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2261WlnS027644;
        Sun, 6 Mar 2022 01:32:47 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3emjmw0f60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Mar 2022 01:32:47 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2261GndM025340;
        Sun, 6 Mar 2022 01:32:46 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 3emgak0wt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Mar 2022 01:32:46 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2261WjSN41746894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Mar 2022 01:32:45 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 940CEAE05C;
        Sun,  6 Mar 2022 01:32:45 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 732D3AE062;
        Sun,  6 Mar 2022 01:32:44 +0000 (GMT)
Received: from [9.211.132.166] (unknown [9.211.132.166])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun,  6 Mar 2022 01:32:44 +0000 (GMT)
Message-ID: <0902b082-d0c8-cbcd-f8fa-68696527144d@linux.vnet.ibm.com>
Date:   Sat, 5 Mar 2022 20:32:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v9 0/3] integrity: support including firmware ".platform"
 keys at build time
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, rnsastry@linux.ibm.com
References: <20220304175403.20092-1-nayna@linux.ibm.com>
 <YiL3DvrlAHaMm+lk@iki.fi> <YiL55eyeoyjbW6JH@iki.fi>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <YiL55eyeoyjbW6JH@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hOPsRyrsIY2qaXYUTB1PodnsmRzvl79H
X-Proofpoint-GUID: VqDZTZrhEhcBNeB8xkJZKyEfhK2qBFtH
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-05_09,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203060006
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 3/5/22 00:49, Jarkko Sakkinen wrote:
> On Sat, Mar 05, 2022 at 07:37:18AM +0200, Jarkko Sakkinen wrote:
>> On Fri, Mar 04, 2022 at 12:54:00PM -0500, Nayna Jain wrote:
>>> Some firmware support secure boot by embedding static keys to verify the
>>> Linux kernel during boot. However, these firmware do not expose an
>>> interface for the kernel to load firmware keys onto the ".platform"
>>> keyring, preventing the kernel from verifying the kexec kernel image
>>> signature.
>>>
>>> This patchset exports load_certificate_list() and defines a new function
>>> load_builtin_platform_cert() to load compiled in certificates onto the
>>> ".platform" keyring.
>>>
>>> Changelog:
>>> v9:
>>> * Rebased on tpmdd master branch repo -
>>> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
>>>
>>> v8:
>>> * Includes Jarkko's feedback on patch description and removed Reported-by
>>> for Patch 1.
>>>
>>> v7:
>>> * Incldues Jarkko's feedback on patch description for Patch 1 and 3.
>>>
>>> v6:
>>> * Includes Jarkko's feedback:
>>>   * Split Patch 2 into two.
>>>   * Update Patch description.
>>>
>>> v5:
>>> * Renamed load_builtin_platform_cert() to load_platform_certificate_list()
>>> and config INTEGRITY_PLATFORM_BUILTIN_KEYS to INTEGRITY_PLATFORM_KEYS, as
>>> suggested by Mimi Zohar.
>>>
>>> v4:
>>> * Split into two patches as per Mimi Zohar and Dimitri John Ledkov
>>> recommendation.
>>>
>>> v3:
>>> * Included Jarkko's feedback
>>>   ** updated patch description to include approach.
>>>   ** removed extern for function declaration in the .h file.
>>> * Included load_certificate_list() within #ifdef CONFIG_KEYS condition.
>>>
>>> v2:
>>> * Fixed the error reported by kernel test robot
>>> * Updated patch description based on Jarkko's feedback.
>>>
>>> Nayna Jain (3):
>>>    certs: export load_certificate_list() to be used outside certs/
>>>    integrity: make integrity_keyring_from_id() non-static
>>>    integrity: support including firmware ".platform" keys at build time
>>>
>>>   certs/Makefile                                |  5 ++--
>>>   certs/blacklist.c                             |  1 -
>>>   certs/common.c                                |  2 +-
>>>   certs/common.h                                |  9 -------
>>>   certs/system_keyring.c                        |  1 -
>>>   include/keys/system_keyring.h                 |  6 +++++
>>>   security/integrity/Kconfig                    | 10 +++++++
>>>   security/integrity/Makefile                   | 15 ++++++++++-
>>>   security/integrity/digsig.c                   |  2 +-
>>>   security/integrity/integrity.h                |  6 +++++
>>>   .../integrity/platform_certs/platform_cert.S  | 23 ++++++++++++++++
>>>   .../platform_certs/platform_keyring.c         | 26 +++++++++++++++++++
>>>   12 files changed, 90 insertions(+), 16 deletions(-)
>>>   delete mode 100644 certs/common.h
>>>   create mode 100644 security/integrity/platform_certs/platform_cert.S
>>>
>>>
>>> base-commit: c9e54f38976a1c0ec69c0a6208b3fd55fceb01d1
>>> -- 
>>> 2.27.0
>> Thank you, applied.
>>
>> BR, Jarkko
> You need to fix this:
>
> WARNING: externs should be avoided in .c files
> #129: FILE: security/integrity/platform_certs/platform_keyring.c:19:
> +extern __initconst const unsigned long platform_certificate_list_size;

Yes, because I followed the same convention as used for system keyring 
certs. Following externs are defined in system_keyring.c for referencing 
variables defined in .S file.

extern __initconst const u8 system_certificate_list[];
extern __initconst const unsigned long system_certificate_list_size;
extern __initconst const unsigned long module_cert_size;

Thanks & Regards,

     - Nayna

