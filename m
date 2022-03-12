Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BD74D6C14
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Mar 2022 03:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiCLCoL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Mar 2022 21:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiCLCoK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Mar 2022 21:44:10 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173B54990E;
        Fri, 11 Mar 2022 18:43:06 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22C1RWuw020335;
        Sat, 12 Mar 2022 02:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1TZKdmVhIrLLgqUyFftdM7a+EouW7q6P7U9Yn32JeKQ=;
 b=EqYV7y8tOALck/9LmIsuEscvpBxe70uFXDFgTsnD8wp7yjYN8FbkxOsUfEnQ6d94pi51
 QoPi5IpnWjUVWhQ2Bt4OjBSYz4R81yWvQYfF3ttGGBLozJm/VaT36qyAAqDjQlp4TDvI
 TurcwqdFf+ZcJDiaVxWtOFod4T7uBvO0S3aMvb6eOryd8gYQUEdzD6yXiojsPQtfK3Xh
 irVQdzT6asfTLZ6KMzlKmPYRlZkEr/4twBwiq8IaEYBi8ocCsK6XD6iM1eMSp03yyHyK
 hwgFXef7osvsX296KDYJpQuIs3D6WLlqaLcE7t2n5lztdUteyic1dobvvtt6Reb19KnV CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eqm1bhtg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 02:43:00 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22C2Ztsr026366;
        Sat, 12 Mar 2022 02:43:00 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eqm1bhtfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 02:43:00 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22C2bsfU022802;
        Sat, 12 Mar 2022 02:42:58 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3epyswcqjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 02:42:58 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22C2gs4e16318948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 02:42:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4B2CA4054;
        Sat, 12 Mar 2022 02:42:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C55DA4062;
        Sat, 12 Mar 2022 02:42:52 +0000 (GMT)
Received: from [9.43.110.208] (unknown [9.43.110.208])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 12 Mar 2022 02:42:52 +0000 (GMT)
Message-ID: <e59f2006-6af2-5f3a-eb34-cc8ccc99d75f@linux.ibm.com>
Date:   Sat, 12 Mar 2022 08:12:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v12 0/4] integrity: support including firmware ".platform"
 keys at build time
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, masahiroy@kernel.org
References: <20220311210344.102396-1-nayna@linux.ibm.com>
From:   Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20220311210344.102396-1-nayna@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DASKLwDxXsXxtZB25zaNWsfr2jBMskun
X-Proofpoint-GUID: oCrjtsqQ0jzmm6vb2fhrSdiBrM6JpE1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-11_10,2022-03-11_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203120013
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 12/03/22 2:33 am, Nayna Jain wrote:
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
> v12:
> * Replace Patch 3/4 with reverting of the commit as suggested by
> Masahiro Yamada.
> 

Tested the following four patches ov v12 with and with out setting 
CONFIG_INTEGRITY_PLATFORM_KEYS

Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>


1. With CONFIG_INTEGRITY_PLATFORM_KEYS set to a key

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
0a7a11a9 I------     1 perm 1f0b0000     0     0 keyring   .platform: 1

# keyctl show %keyring:.platform
Keyring
  175772073 ---lswrv      0     0  keyring: .platform
  519271447 ---lswrv      0     0   \_ asymmetric: IBM Corporation: 
Guest Secure Boot Imprint Kernel Signing Key: 
a0cf9069c30875320cb10a77325d4fa7012f8d12


2. With out CONFIG_INTEGRITY_PLATFORM_KEYS set, leaving empty

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
39c749b9 I------     1 perm 1f0b0000     0     0 keyring   .platform: empty

# keyctl show %keyring:.platform
Keyring
  969361849 ---lswrv      0     0  keyring: .platform



> 
> base-commit: fb5abce6b2bb5cb3d628aaa63fa821da8c4600f9

-- 
Thanks and Regards
R.Nageswara Sastry
