Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763365686BF
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Jul 2022 13:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiGFLf5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Jul 2022 07:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiGFLf4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Jul 2022 07:35:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DF2237E8
        for <linux-integrity@vger.kernel.org>; Wed,  6 Jul 2022 04:35:55 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266B31bA032723;
        Wed, 6 Jul 2022 11:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ql+sI5dq+MFNf+NF4oBU64vul1+DbOcV4U+iziAo0yQ=;
 b=tggnzrhz+rjZ66N3hJ6Sn4L37BfC6OydXNGC2x+1L99NrLfyOQUHWZ0+EeLvif13Md8k
 ZeJGIGU/LRb+AvZYnPmqaUM+0Klq3OAxOsG5LFB0c82YfBdLf+H1CgoIcK54RDHT0lCj
 DCNvFcaOfP4EL1hWllTZr0+TBGehvd5ujJn5josMgnOv6b54VZfyg9b8CdD87+kvskzk
 NCztN89jjoCu/Uy1B/VrWVFfZ/uNMa0C+uw9Q0L4YISKY5F6GNxlbmtpbJsh5dgvYquY
 ZC2CNASy4SzvgsAbAQ+Ia0yLzuosspiGLr13OgBt2mrxt/Z+8HmYAPRzv2517oDVyTnq Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h58g79su4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 11:35:44 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 266BROBT009453;
        Wed, 6 Jul 2022 11:35:44 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h58g79stc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 11:35:43 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 266BLiIM025727;
        Wed, 6 Jul 2022 11:35:42 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3h4usd0xte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 11:35:42 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 266BZecl14090708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Jul 2022 11:35:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD805A404D;
        Wed,  6 Jul 2022 11:35:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53697A4051;
        Wed,  6 Jul 2022 11:35:37 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.79.129])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Jul 2022 11:35:37 +0000 (GMT)
Message-ID: <711440de6340ef6ad73e4db5edd36fc391b8a11d.camel@linux.ibm.com>
Subject: Re: [PATCH v9 0/4] unify the keyrings of arm64 and s390 with x86 to
 verify kexec'ed kernel signature
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>
Date:   Wed, 06 Jul 2022 07:35:36 -0400
In-Reply-To: <20220704015201.59744-1-coxu@redhat.com>
References: <20220704015201.59744-1-coxu@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TYA_ERGXY3ga_vG9AqioBfuoig99-itw
X-Proofpoint-ORIG-GUID: i1pb20BIar8REAKISUTNt7Sh6oQJ53EX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_06,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207060044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-07-04 at 09:51 +0800, Coiby Xu wrote:
> Currently when loading a kernel image via the kexec_file_load() system
> call, x86 can make use of three keyrings i.e. the .builtin_trusted_keys,
> .secondary_trusted_keys and .platform keyrings to verify a signature.
> However, arm64 and s390 can only use the .builtin_trusted_keys and
> .platform keyring respectively. For example, one resulting problem is
> kexec'ing a kernel image  would be rejected with the error "Lockdown:
> kexec: kexec of unsigned images is restricted; see man
> kernel_lockdown.7".
> 
> This patch set enables arm64 and s390 to make use of the same keyrings
> as x86 to verify the signature kexec'ed kernel image.
> 
> The recently introduced .machine keyring impacts the roots of trust by
> linking the .machine keyring to the .secondary keyring. The roots of
> trust for different keyrings are described as follows,
> 
> .builtin_trusted_keys:
> 
> Keys may be built into the kernel during build or inserted into memory
> reserved for keys post build. The root of trust is based on verification
> of the kernel image signature. For example, on a physical system in a
> secure boot environment, this trust is rooted in hardware.
> 
> .machine:
> 
> If the end-users choose to trust the keys provided by first-stage UEFI
> bootloader shim i.e. Machine Owner Keys (MOK keys), the keys will be
> added to this keyring which is linked to the .secondary_trusted_keys
> keyring as the same as the .builtin_trusted_keys keyring. Shim has
> built-in keys from a Linux distribution or the end-users-enrolled keys.
> So the root of trust of this keyring is either a Linux distribution
> vendor or the end-users.
> 
> .secondary_trusted_keys:
> 
> Certificates signed by keys on the .builtin_trusted_keys, .machine, or
> existing keys on the .secondary_trusted_keys keryings may be loaded
> onto the .secondary_trusted_keys keyring. This establishes a signature
> chain of trust based on keys loaded on either the .builtin_trusted_keys
> or .machine keyrings, if configured and enabled.
> 
> .platform:
> 
> The .platform keyring consist of UEFI db and MOK keys which are used by
> shim to verify the first boot kernel's image signature. If end-users
> choose to trust MOK keys and the kernel has the .machine keyring
> enabled, the .platform keyring only consists of UEFI db keys since the
> MOK keys are added to the .machine keyring instead. Because the
> end-users could also enroll their own MOK keys, the root of trust could
> be hardware and the end-users.
> 
> The 3rd arm64 patch depends on the first two patches. The 4th s390 patch
> can be applied independently.
> 
> I've tested the patch set on 5.19.0-rc2 and it works as expected. 
> 
> For arm64, the tests were done as follows,
>   1. build 5.19.0-rc2
>   2. generate keys and add them to .secondary_trusted_keys, MOK, UEFI
>      db;
>   3. sign different kernel images with different keys including keys
>      from .builtin_trusted_key, .secondary_trusted_keys keyring, a UEFI db
>      key and MOK key
>   4. Without lockdown, all kernel images can be kexec'ed; with lockdown
>      enabled, only the kernel image signed by the key from the
>      .builtin_trusted_key keyring can be kexec'ed

Just confirming, for arm64, this patch set allows verifying the
kexec'ed kernel image signature using keys on either the .platform or
.secondary_trusted_keys keyrings.

thanks,

Mimi

> 
> For 390, I commented out the code that skips signature verification when
> secure boot is not enabled since the testing machine doesn't supports
> secure boot and can confirm before applying the patch, kernel images
> signed by keys from .builtin_trusted_key, .secondary_trusted_keys
> couldn't be kexec'ed when lockdown is enabled; after applying the patch,
> those kernel images could be kexec'ed.


