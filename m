Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5643BE81E
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 14:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhGGMmv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 08:42:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231452AbhGGMmv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 08:42:51 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167CY77j103032;
        Wed, 7 Jul 2021 08:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wx/JpRCcGdk4qYmZ5bmqh70fHpwjzwyhpaIlkiGlpHc=;
 b=dWsrQipTOn+PL41twqWHGOBTQ2e89A7l3S/KTWcco6CgfMFSeLaPrj9DKp99t27yo+ej
 XC5NHcYAt+hAr+7Nc0bVSpBVuc0tZ1MQlCnhP7u60BhRlSbcU+FbxCliMhT/9eiRm81Q
 T0LUoYGZir20Cb+5IYocCz1e/gnl//vA38WU3YOt+NWfaxY5rh1YoBaZbP1J4JK9LhPZ
 APXzh+D+dvKFFxiScBmlEhHiTRbTkHtxsr8Xw7rW5jgxAwRRexUlMBIuPbdFcepdKtpM
 paO0htG0N7vJkj5pj3doJr90x28FusuNxBVMitJvKXrSZP4uHnw4ETDUygySTqNA4n/w Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39n1rdfvjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 08:39:30 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 167CYlV6105419;
        Wed, 7 Jul 2021 08:39:30 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39n1rdfvhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 08:39:30 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 167CcUWK018054;
        Wed, 7 Jul 2021 12:39:27 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 39jfh8gxfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 12:39:27 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 167CdPXc27001320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Jul 2021 12:39:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E59B8A4055;
        Wed,  7 Jul 2021 12:39:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36A90A4053;
        Wed,  7 Jul 2021 12:39:20 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.79.186])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  7 Jul 2021 12:39:19 +0000 (GMT)
Message-ID: <42b787dd3a20fe37c4de60daf75db06e409cfb6d.camel@linux.ibm.com>
Subject: Re: [PATCH RFC 00/12] Enroll kernel keys thru MOK
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jarkko@kernel.org, jmorris@namei.org,
        serge@hallyn.com
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com, konrad.wilk@oracle.com
Date:   Wed, 07 Jul 2021 08:39:19 -0400
In-Reply-To: <20210707024403.1083977-1-eric.snowberg@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1G7EUOP1DTg3GWWfkSMxalUbf94FTo0u
X-Proofpoint-ORIG-GUID: NKSSQ3wWrPVBLwZ5YQzEvHrglOSvH3dJ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-07_06:2021-07-06,2021-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107070075
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-07-06 at 22:43 -0400, Eric Snowberg wrote:
> This is a follow up to the "Add additional MOK vars" [1] series I 
> previously sent.  This series incorporates the feedback given 
> both publicly on the mailing list and privately from Mimi. This 
> series just focuses on getting end-user keys into the kernel trust 
> boundary.
> 
> Currently, pre-boot keys are not trusted within the Linux boundary [2].
> Pre-boot keys include UEFI Secure Boot DB keys and MOKList keys. These
> keys are loaded into the platform keyring and can only be used for kexec.
> If an end-user wants to use their own key within the Linux trust
> boundary, they must either compile it into the kernel themselves or use
> the insert-sys-cert script. Both options present a problem. Many
> end-users do not want to compile their own kernels. With the
> insert-sys-cert option, there are missing upstream changes [3].  Also,
> with the insert-sys-cert option, the end-user must re-sign their kernel
> again with their own key, and then insert that key into the MOK db.
> Another problem with insert-sys-cert is that only a single key can be
> inserted into a compressed kernel.
> 
> Having the ability to insert a key into the Linux trust boundary opens
> up various possibilities.  The end-user can use a pre-built kernel and
> sign their own kernel modules.  It also opens up the ability for an
> end-user to more easily use digital signature based IMA-appraisal.  To
> get a key into the ima keyring, it must be signed by a key within the
> Linux trust boundary.
> 
> Downstream Linux distros try to have a single signed kernel for each
> architecture.  Each end-user may use this kernel in entirely different
> ways.  Some downstream kernels have chosen to always trust platform keys
> within the Linux trust boundary for kernel module signing.  These
> kernels have no way of using digital signature base IMA appraisal. 
> 
> This series adds a new MOK variable to shim.  This variable allows the
> end-user to decide if they want to trust keys enrolled in the MOK within
> the Linux trust boundary.  By default, nothing changes; MOK keys are
> not trusted within the Linux kernel.  They are only trusted after the 
> end-user makes the decision themselves.  The end-user would set this
> through mokutil using a new --trust-mok option [4]. This would work
> similar to how the kernel uses MOK variable to enable/disable signature
> validation as well as use/ignore the db.
> 
> When shim boots, it mirrors the new MokTML Boot Services variable to a new
> MokListTrustedRT Runtime Services variable and extends PCR14. 
> MokListTrustedRT is written without EFI_VARIABLE_NON_VOLATILE set,
> preventing an end-user from setting it after booting and doing a kexec.
> 
> When the kernel boots, if MokListTrustedRT is set and
> EFI_VARIABLE_NON_VOLATILE is not set, the MokListRT is loaded into the
> secondary trusted keyring instead of the platform keyring. Mimi has
> suggested that only CA keys or keys that can be vouched for by other
> kernel keys be loaded. All other certs will load into the platform
> keyring instead.

Loading MOK CA keys onto the "secondary" keyring would need to be an
exception.   Once CA keys are loaded onto the "secondary" keyring,  any
certificates signed by those CA keys may be loaded normally, without
needing an exception, onto the "secondary" keyring.  The kernel MAY
load those keys onto the "secondary" keyring, but really doesn't need
to be involved.

Loading ALL of the MOK db keys onto either the "secondary" or
"platform" keyrings makes the code a lot more complicated.  Is it
really necessary?

thanks,

Mimi

> 
> This is done by introducing a new .mok keyring.  This keyring is only
> used during boot.  After booting it is destroyed and not visible to the
> end-user after booting completes.  This keyring contains a new keyring
> permission that only allows CA keys to be loaded. If the permission
> fails, the key is later loaded into the platform keyring.  After keys
> are added into the .mok keyring, they are moved into the secondary
> trusted keyring.
> 
> Secure Boot keys will never be trusted.  They will always be loaded
> into the platform keyring.  If an end-user wanted to trust one, they
> would need to enroll it into the MOK.
> 
> I have included links to both the mokutil [3] and shim [4] changes I
> have made to support this new functionality.
> 
> Thank you and looking forward to hearing your reviews.
> 
> [1] https://lore.kernel.org/linux-integrity/20210517225714.498032-1-eric.snowberg@oracle.com/
> [2] https://lore.kernel.org/lkml/1556221605.24945.3.camel@HansenPartnership.com/
> [3] https://lore.kernel.org/patchwork/cover/902768/
> [4] https://github.com/esnowberg/mokutil/tree/0.3.0-mokvars-v2
> [5] https://github.com/esnowberg/shim/tree/mokvars-v2
> 
> Eric Snowberg (12):
>   KEYS: Add KEY_ALLOC_BYPASS_RESTRICTION option to key_move
>   KEYS: Allow unrestricted keys to be moved to the secondary keyring
>   KEYS: CA link restriction
>   integrity: add integrity_destroy_keyring
>   integrity: Introduce mok keyring
>   integrity: Trust mok keys if MokListTrustedRT found
>   integrity: add add_to_mok_keyring
>   integrity: restrict INTEGRITY_KEYRING_MOK to
>     restrict_link_by_secondary_trusted_or_ca
>   integrity: accessor function to get trust_moklist
>   integrity: add new keyring handler
>   integrity: move keys from the mok keyring into the secondary keyring
>   integrity: Suppress error message for keys added to the mok keyring
> 
>  certs/system_keyring.c                        | 43 +++++++++
>  crypto/asymmetric_keys/restrict.c             | 60 +++++++++++++
>  include/crypto/public_key.h                   |  5 ++
>  include/keys/system_keyring.h                 | 21 +++++
>  security/integrity/Makefile                   |  3 +-
>  security/integrity/digsig.c                   | 26 +++++-
>  security/integrity/integrity.h                | 21 ++++-
>  .../platform_certs/keyring_handler.c          | 17 +++-
>  .../platform_certs/keyring_handler.h          |  5 ++
>  security/integrity/platform_certs/load_uefi.c |  5 +-
>  .../integrity/platform_certs/mok_keyring.c    | 90 +++++++++++++++++++
>  security/keys/keyring.c                       | 10 ++-
>  12 files changed, 294 insertions(+), 12 deletions(-)
>  create mode 100644 security/integrity/platform_certs/mok_keyring.c
> 
> 
> base-commit: 13311e74253fe64329390df80bed3f07314ddd61


