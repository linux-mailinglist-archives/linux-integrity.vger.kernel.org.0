Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56273EADFB
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 02:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbhHMAgn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Aug 2021 20:36:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22132 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234368AbhHMAgm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Aug 2021 20:36:42 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17D0Xtcn051441;
        Thu, 12 Aug 2021 20:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=14tC6AEhjpTx5usFQA+qHlRyg3GVrb++loOgFd4FamY=;
 b=d1sGkr3PAZNG9RnCN/6kkovT9ayQQitLNDzqogYlzEbU3tZ7TqmxNCPg498BDlIC3+S9
 96TyBVEEGC7ek3GSW2W4BLm3w7NgjLvZBBlYcI7eZlbauFA5O7kdF3sjb6tKJCT8+AcY
 vXx9zREk23PUVzgsTY0LemOai6PaJmMvCE7kAK9dNt+us1/mwRvDJ7ow2CXQJlYVLbCg
 /SyUXxP7du8fyjxZDd+sVsiFgt+M8Yigx1KM8R3kX4lu5lO9QtBA6mC1F+CN+BouVjdp
 KuL/viZAO1KwlCdnVxYsugn+gkB1zMt0uPBO1oM3ZBHofWj4Ukxn0DAKRvmEyltJNAVD lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ad5sdn2qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 20:35:53 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17D0Xv9G051514;
        Thu, 12 Aug 2021 20:35:53 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ad5sdn2pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 20:35:52 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17D0HBLP000611;
        Fri, 13 Aug 2021 00:35:50 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3abaq4dks0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 00:35:50 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17D0Zmgn56951210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 00:35:48 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A64442049;
        Fri, 13 Aug 2021 00:35:48 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBE9F42041;
        Fri, 13 Aug 2021 00:35:42 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.41.31])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 13 Aug 2021 00:35:42 +0000 (GMT)
Message-ID: <119db8a1ed406caf66c793fe8dbfaa439537c086.camel@linux.ibm.com>
Subject: Re: [PATCH v3 01/14] integrity: Introduce a Linux keyring for the
 Machine Owner Key (MOK)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        lszubowi@redhat.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        pjones@redhat.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Date:   Thu, 12 Aug 2021 20:35:41 -0400
In-Reply-To: <915366E7-0B86-4F38-8AFD-EDA5FC1916D5@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
         <20210812021855.3083178-2-eric.snowberg@oracle.com>
         <34b12d8d47564a182f0a29a9592e203b17ccdd69.camel@linux.ibm.com>
         <915366E7-0B86-4F38-8AFD-EDA5FC1916D5@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OWz3BPAhmxRY5oHaMZC-qyGkRbGYxJsB
X-Proofpoint-GUID: NXIq1mZzbH8x8lGFp_ml6UhY5pv23B9g
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_06:2021-08-12,2021-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108130001
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-08-12 at 16:36 -0600, Eric Snowberg wrote:
> > On Aug 12, 2021, at 3:31 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Wed, 2021-08-11 at 22:18 -0400, Eric Snowberg wrote:
> >> Many UEFI Linux distributions boot using shim.  The UEFI shim provides
> >> what is called Machine Owner Keys (MOK). Shim uses both the UEFI Secure
> >> Boot DB and MOK keys to validate the next step in the boot chain.  The
> >> MOK facility can be used to import user generated keys.  These keys can
> >> be used to sign an end-users development kernel build.  When Linux
> >> boots, both UEFI Secure Boot DB and MOK keys get loaded in the Linux
> >> .platform keyring.
> >> 
> >> Add a new Linux keyring called .mok.  This keyring shall contain just
> >> MOK keys and not the remaining keys in the platform keyring. This new
> >> .mok keyring will be used in follow on patches.  Unlike keys in the
> >> platform keyring, keys contained in the .mok keyring will be trusted
> >> within the kernel if the end-user has chosen to do so.
> >> 
> >> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> >> ---
> >> v1: Initial version
> >> v2: Removed destory keyring code
> >> v3: Unmodified from v2
> >> ---
> >> security/integrity/Makefile                   |  3 ++-
> >> security/integrity/digsig.c                   |  1 +
> >> security/integrity/integrity.h                |  3 ++-
> >> .../integrity/platform_certs/mok_keyring.c    | 21 +++++++++++++++++++
> >> 4 files changed, 26 insertions(+), 2 deletions(-)
> >> create mode 100644 security/integrity/platform_certs/mok_keyring.c
> >> 
> >> diff --git a/security/integrity/Makefile b/security/integrity/Makefile
> >> index 7ee39d66cf16..8e2e98cba1f6 100644
> >> --- a/security/integrity/Makefile
> >> +++ b/security/integrity/Makefile
> >> @@ -9,7 +9,8 @@ integrity-y := iint.o
> >> integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
> >> integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
> >> integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
> >> -integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
> >> +integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o \
> >> +						  platform_certs/mok_keyring.o
> >> integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
> >> 				      platform_certs/load_uefi.o \
> >> 				      platform_certs/keyring_handler.o
> >> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> >> index 3b06a01bd0fd..e07334504ef1 100644
> >> --- a/security/integrity/digsig.c
> >> +++ b/security/integrity/digsig.c
> >> @@ -30,6 +30,7 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
> >> 	".ima",
> >> #endif
> >> 	".platform",
> >> +	".mok",
> >> };
> >> 
> >> #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
> >> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> >> index 547425c20e11..e0e17ccba2e6 100644
> >> --- a/security/integrity/integrity.h
> >> +++ b/security/integrity/integrity.h
> >> @@ -151,7 +151,8 @@ int integrity_kernel_read(struct file *file, loff_t offset,
> >> #define INTEGRITY_KEYRING_EVM		0
> >> #define INTEGRITY_KEYRING_IMA		1
> >> #define INTEGRITY_KEYRING_PLATFORM	2
> >> -#define INTEGRITY_KEYRING_MAX		3
> >> +#define INTEGRITY_KEYRING_MOK		3
> >> +#define INTEGRITY_KEYRING_MAX		4
> >> 
> >> extern struct dentry *integrity_dir;
> >> 
> >> diff --git a/security/integrity/platform_certs/mok_keyring.c b/security/integrity/platform_certs/mok_keyring.c
> >> new file mode 100644
> >> index 000000000000..b1ee45b77731
> >> --- /dev/null
> >> +++ b/security/integrity/platform_certs/mok_keyring.c
> >> @@ -0,0 +1,21 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * MOK keyring routines.
> >> + *
> >> + * Copyright (c) 2021, Oracle and/or its affiliates.
> >> + */
> >> +
> >> +#include "../integrity.h"
> >> +
> >> +static __init int mok_keyring_init(void)
> >> +{
> >> +	int rc;
> >> +
> >> +	rc = integrity_init_keyring(INTEGRITY_KEYRING_MOK);
> >> +	if (rc)
> >> +		return rc;
> >> +
> >> +	pr_notice("MOK Keyring initialized\n");
> >> +	return 0;
> >> +}
> >> +device_initcall(mok_keyring_init);
> > 
> > The ordering of the patches in this patch set is not quite
> > right.  
> 
> I will work on reordering the patches in the next round.
> 
> > Please first introduce the new keyring with the new Kconfig,
> > new restriction, and loading the keys onto the new keyring.  Introduce
> > the builitin_secondary_and_ca_trusted restriction and linking the new
> > keyring to the secondary keyring.  Only after everything is in place,
> > define and use the UEFI mok variable(s).
> > 
> > Originally, I asked you to "Separate each **logical change** into a
> > separate patch."  After re-ordering the patches, see if merging some of
> > them together now makes sense.
> 
> I’ll see if merging some of them together makes sense.
> 
> With the new Kconfig option, should the default be 'y' or ’n' when the secondary 
> is defined?  Thanks.

It definitely needs to be opt in.  Please make it 'n'.

Mimi

