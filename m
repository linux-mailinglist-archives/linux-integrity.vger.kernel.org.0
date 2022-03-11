Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6EA4D59BB
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Mar 2022 05:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbiCKEnB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Mar 2022 23:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346433AbiCKEnA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Mar 2022 23:43:00 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E26B1A907A;
        Thu, 10 Mar 2022 20:41:58 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22B4SD8w006855;
        Fri, 11 Mar 2022 04:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1La54FmIqIbZzewnmTDVKyzNOZ4KlniNQIRdC9L4pTw=;
 b=ln9zUlB5Wx3D72w9Io3Vz0b95Ndvlcy2bkSkNk4KCAWNaKf70X6DIESiLXiUIwwcDZGQ
 voY6D9bZECOTWwDqPRnFplW7WKABKaJB5MXbUzrEObjfUW34lNBeLC2Cvod+L6qJ9gSk
 rIXxS4PWXF8s+nh2meHcxH5qPrMZg6jQrdYcyXRgYUUlTFQr3XMMd8VpK2ScZNr81CN7
 1UDSgonAkJpgU23JT+uGwX/NybTkPyKyJEbO/mlJ3JwGqVeIi0p6g2cjRat+0SGjzF+x
 kh0oxjwS/3H8e5nel77XZk2Vlmw3jRcvmiajSlkPxbgPow+fuc4Vh5+LFSg7gVYuCjQS 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eqrrdq2fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 04:41:53 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22B4aSbj004503;
        Fri, 11 Mar 2022 04:41:53 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eqrrdq2fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 04:41:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22B4blDr022254;
        Fri, 11 Mar 2022 04:41:51 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3eqqf08pss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 04:41:51 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22B4fl5Y36897178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 04:41:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF1CCAE04D;
        Fri, 11 Mar 2022 04:41:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 312B5AE045;
        Fri, 11 Mar 2022 04:41:45 +0000 (GMT)
Received: from [9.43.5.3] (unknown [9.43.5.3])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 11 Mar 2022 04:41:44 +0000 (GMT)
Message-ID: <4afae87c-2986-6b0e-07be-954dd4937afd@linux.ibm.com>
Date:   Fri, 11 Mar 2022 10:11:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH v11 0/4] integrity: support including firmware ".platform"
 keys at build time
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, Masahiro Yamada <masahiroy@kernel.org>
References: <20220310214450.676505-1-nayna@linux.ibm.com>
From:   Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20220310214450.676505-1-nayna@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xINTBg14ZqSpZh-yay9uoKnMPzWX3n5y
X-Proofpoint-GUID: xseay6-Ax7BOXKVK0qR6OTHXLoou4EEd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_09,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203110020
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 11/03/22 3:14 am, Nayna Jain wrote:
> Some firmware support secure boot by embedding static keys to verify the
> Linux kernel during boot. However, these firmware do not expose an
> interface for the kernel to load firmware keys onto the ".platform"
> keyring, preventing the kernel from verifying the kexec kernel image
> signature.
> 
> This patchset exports load_certificate_list() and defines a new function
> load_builtin_platform_cert() to load compiled in certificates onto the
> ".platform" keyring.
> 
> Changelog:
> v11:
> * Added a new patch to conditionally build extract-cert if
> PLATFORM_KEYRING is enabled.
> 

Tested the following four patches with and with out setting 
CONFIG_INTEGRITY_PLATFORM_KEYS

Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>


1. With set CONFIG_INTEGRITY_PLATFORM_KEYS

# grep pem .config
CONFIG_INTEGRITY_PLATFORM_KEYS="certs/kernel.pem"
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYS="certs/rhel.pem"

# grep 
"CONFIG_INTEGRITY_PLATFORM_KEYS\|INTEGRITY_PLATFORM_KEYRING\|SYSTEM_REVOCATION_LIST" 
.config
CONFIG_INTEGRITY_PLATFORM_KEYRING=y
CONFIG_INTEGRITY_PLATFORM_KEYS="certs/kernel.pem"
# CONFIG_SYSTEM_REVOCATION_LIST is not set

# cat /proc/keys | grep platform
0e60c88d I------     1 perm 1f0b0000     0     0 keyring   .platform: 1

# keyctl show %keyring:.platform
Keyring
  241223821 ---lswrv      0     0  keyring: .platform
  308815460 ---lswrv      0     0   \_ asymmetric: IBM Corporation: 
Guest Secure Boot Imprint Kernel Signing Key: 
a0cf9069c30875320cb10a77325d4fa7012f8d12


2. With out set CONFIG_INTEGRITY_PLATFORM_KEYS

# grep pem .config
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYS="certs/rhel.pem"

# grep 
"CONFIG_INTEGRITY_PLATFORM_KEYS\|INTEGRITY_PLATFORM_KEYRING\|SYSTEM_REVOCATION_LIST" 
.config
CONFIG_INTEGRITY_PLATFORM_KEYRING=y
CONFIG_INTEGRITY_PLATFORM_KEYS=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set

# cat /proc/keys | grep platform
12a5f301 I------     1 perm 1f0b0000     0     0 keyring   .platform: empty

# keyctl show %keyring:.platform
Keyring
  312865537 ---lswrv      0     0  keyring: .platform


> 
> 
> base-commit: fb5abce6b2bb5cb3d628aaa63fa821da8c4600f9

-- 
Thanks and Regards
R.Nageswara Sastry
