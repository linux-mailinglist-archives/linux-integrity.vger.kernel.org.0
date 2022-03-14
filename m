Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502B94D8628
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Mar 2022 14:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbiCNNoE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Mar 2022 09:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241976AbiCNNoD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Mar 2022 09:44:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B902DDE;
        Mon, 14 Mar 2022 06:42:53 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22ED7X06000851;
        Mon, 14 Mar 2022 13:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=npdWzeI7Gxi61S9GD9j737rgLRGyn0zuEO6ustPR85Y=;
 b=YXvESkGQbGu24IzQEoSCE4CNArqs/s4KdiB3ChwCc+WEBhKnu28bQyCc9CBe1v/3b4yR
 D+oVehrBKf64HYzLkmUxU6137D5pwHOXcyrKoma2x+WOCTsEzGVFGcMMYqqETKNpkdBY
 sQaZYaYWmtjtWg4dGjBUwyyIorzbmeTYDRMbcxNi5bfiPFmsU+EuqVCcMF1O+YM0BrHH
 5ZHWd7t5cF/sDFzGavV40CvVYTp7Ycf7oM1QCcg5k8tovEfVeHKC+M6U3IpM6ouCAVbL
 v+PK50Pls1qCmXGgpeILW6ER0CTGEk7U0sCb2lW8DT5/CZeGJOjskqtRY5r7W3JE9lCw cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3et6adscav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 13:42:40 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22ED8Q34009890;
        Mon, 14 Mar 2022 13:42:39 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3et6adscab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 13:42:39 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22EDb6OC006739;
        Mon, 14 Mar 2022 13:42:38 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04wdc.us.ibm.com with ESMTP id 3erk59e2w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 13:42:38 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22EDgajX23200112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 13:42:36 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFD836E052;
        Mon, 14 Mar 2022 13:42:36 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 146296E058;
        Mon, 14 Mar 2022 13:42:36 +0000 (GMT)
Received: from [9.163.30.16] (unknown [9.163.30.16])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 14 Mar 2022 13:42:35 +0000 (GMT)
Message-ID: <874ced6f-01f8-558a-bea8-4acc46288bb8@linux.vnet.ibm.com>
Date:   Mon, 14 Mar 2022 09:42:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v12 3/4] Revert "certs: move scripts/extract-cert to
 certs/"
Content-Language: en-US
To:     masahiroy@kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, rnsastry@linux.ibm.com,
        Nayna Jain <nayna@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org
References: <20220311210344.102396-1-nayna@linux.ibm.com>
 <20220311210344.102396-4-nayna@linux.ibm.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <20220311210344.102396-4-nayna@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R_B4gb2F38bpns991gLo8TBFNkzxrZBo
X-Proofpoint-GUID: BCqeSkITmMVKsBm_5cYeRwzz4Mibhqov
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_08,2022-03-14_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 3/11/22 16:03, Nayna Jain wrote:
> This reverts commit 340a02535ee785c64c62a9c45706597a0139e972.
>
> extract-cert is used outside certs/ by INTEGRITY_PLATFORM_KEYRING.

Hi Masahiro,

Could you review and Ack this patch ?

Thanks & Regards,

     - Nayna


>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>   MAINTAINERS                       |  1 +
>   certs/.gitignore                  |  1 -
>   certs/Makefile                    | 13 ++++---------
>   scripts/.gitignore                |  1 +
>   scripts/Makefile                  | 11 +++++++++--
>   {certs => scripts}/extract-cert.c |  2 +-
>   scripts/remove-stale-files        |  2 --
>   7 files changed, 16 insertions(+), 15 deletions(-)
>   rename {certs => scripts}/extract-cert.c (98%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 05fd080b82f3..cf4cd22ca3a0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4471,6 +4471,7 @@ L:	keyrings@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/admin-guide/module-signing.rst
>   F:	certs/
> +F:	scripts/extract-cert.c
>   F:	scripts/sign-file.c
>   
>   CFAG12864B LCD DRIVER
> diff --git a/certs/.gitignore b/certs/.gitignore
> index 9e42fe3e02f5..8c3763f80be3 100644
> --- a/certs/.gitignore
> +++ b/certs/.gitignore
> @@ -1,4 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> -/extract-cert
>   /x509_certificate_list
>   /x509_revocation_list
> diff --git a/certs/Makefile b/certs/Makefile
> index b92b6ff339d5..a4a6f6a78904 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -14,11 +14,11 @@ obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
>   endif
>   
>   quiet_cmd_extract_certs  = CERT    $@
> -      cmd_extract_certs  = $(obj)/extract-cert $(2) $@
> +      cmd_extract_certs  = scripts/extract-cert $(2) $@
>   
>   $(obj)/system_certificates.o: $(obj)/x509_certificate_list
>   
> -$(obj)/x509_certificate_list: $(CONFIG_SYSTEM_TRUSTED_KEYS) $(obj)/extract-cert FORCE
> +$(obj)/x509_certificate_list: $(CONFIG_SYSTEM_TRUSTED_KEYS) scripts/extract-cert FORCE
>   	$(call if_changed,extract_certs,$(if $(CONFIG_SYSTEM_TRUSTED_KEYS),$<,""))
>   
>   targets += x509_certificate_list
> @@ -75,7 +75,7 @@ endif
>   
>   $(obj)/system_certificates.o: $(obj)/signing_key.x509
>   
> -$(obj)/signing_key.x509: $(X509_DEP) $(obj)/extract-cert FORCE
> +$(obj)/signing_key.x509: $(X509_DEP) scripts/extract-cert FORCE
>   	$(call if_changed,extract_certs,$(if $(CONFIG_MODULE_SIG_KEY),$(if $(X509_DEP),$<,$(CONFIG_MODULE_SIG_KEY)),""))
>   endif # CONFIG_MODULE_SIG
>   
> @@ -83,12 +83,7 @@ targets += signing_key.x509
>   
>   $(obj)/revocation_certificates.o: $(obj)/x509_revocation_list
>   
> -$(obj)/x509_revocation_list: $(CONFIG_SYSTEM_REVOCATION_KEYS) $(obj)/extract-cert FORCE
> +$(obj)/x509_revocation_list: $(CONFIG_SYSTEM_REVOCATION_KEYS) scripts/extract-cert FORCE
>   	$(call if_changed,extract_certs,$(if $(CONFIG_SYSTEM_REVOCATION_KEYS),$<,""))
>   
>   targets += x509_revocation_list
> -
> -hostprogs := extract-cert
> -
> -HOSTCFLAGS_extract-cert.o = $(shell pkg-config --cflags libcrypto 2> /dev/null)
> -HOSTLDLIBS_extract-cert = $(shell pkg-config --libs libcrypto 2> /dev/null || echo -lcrypto)
> diff --git a/scripts/.gitignore b/scripts/.gitignore
> index eed308bef604..e83c620ef52c 100644
> --- a/scripts/.gitignore
> +++ b/scripts/.gitignore
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   /asn1_compiler
>   /bin2c
> +/extract-cert
>   /insert-sys-cert
>   /kallsyms
>   /module.lds
> diff --git a/scripts/Makefile b/scripts/Makefile
> index ce5aa9030b74..cedc1f0e21d8 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -3,19 +3,26 @@
>   # scripts contains sources for various helper programs used throughout
>   # the kernel for the build process.
>   
> +CRYPTO_LIBS = $(shell pkg-config --libs libcrypto 2> /dev/null || echo -lcrypto)
> +CRYPTO_CFLAGS = $(shell pkg-config --cflags libcrypto 2> /dev/null)
> +
>   hostprogs-always-$(CONFIG_BUILD_BIN2C)			+= bin2c
>   hostprogs-always-$(CONFIG_KALLSYMS)			+= kallsyms
>   hostprogs-always-$(BUILD_C_RECORDMCOUNT)		+= recordmcount
>   hostprogs-always-$(CONFIG_BUILDTIME_TABLE_SORT)		+= sorttable
>   hostprogs-always-$(CONFIG_ASN1)				+= asn1_compiler
>   hostprogs-always-$(CONFIG_MODULE_SIG_FORMAT)		+= sign-file
> +hostprogs-always-$(CONFIG_SYSTEM_TRUSTED_KEYRING)	+= extract-cert
>   hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-sys-cert
> +hostprogs-always-$(CONFIG_SYSTEM_REVOCATION_LIST)	+= extract-cert
>   
>   HOSTCFLAGS_sorttable.o = -I$(srctree)/tools/include
>   HOSTLDLIBS_sorttable = -lpthread
>   HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
> -HOSTCFLAGS_sign-file.o = $(shell pkg-config --cflags libcrypto 2> /dev/null)
> -HOSTLDLIBS_sign-file = $(shell pkg-config --libs libcrypto 2> /dev/null || echo -lcrypto)
> +HOSTCFLAGS_sign-file.o = $(CRYPTO_CFLAGS)
> +HOSTLDLIBS_sign-file = $(CRYPTO_LIBS)
> +HOSTCFLAGS_extract-cert.o = $(CRYPTO_CFLAGS)
> +HOSTLDLIBS_extract-cert = $(CRYPTO_LIBS)
>   
>   ifdef CONFIG_UNWINDER_ORC
>   ifeq ($(ARCH),x86_64)
> diff --git a/certs/extract-cert.c b/scripts/extract-cert.c
> similarity index 98%
> rename from certs/extract-cert.c
> rename to scripts/extract-cert.c
> index f7ef7862f207..3bc48c726c41 100644
> --- a/certs/extract-cert.c
> +++ b/scripts/extract-cert.c
> @@ -29,7 +29,7 @@ static __attribute__((noreturn))
>   void format(void)
>   {
>   	fprintf(stderr,
> -		"Usage: extract-cert <source> <dest>\n");
> +		"Usage: scripts/extract-cert <source> <dest>\n");
>   	exit(2);
>   }
>   
> diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
> index 7adab4618035..80430b8fb617 100755
> --- a/scripts/remove-stale-files
> +++ b/scripts/remove-stale-files
> @@ -39,5 +39,3 @@ if [ -n "${building_out_of_srctree}" ]; then
>   		rm -f arch/parisc/boot/compressed/${f}
>   	done
>   fi
> -
> -rm -f scripts/extract-cert
