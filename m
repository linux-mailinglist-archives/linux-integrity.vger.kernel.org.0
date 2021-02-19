Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47C031FBF5
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Feb 2021 16:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhBSP17 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 10:27:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65464 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229527AbhBSP16 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 10:27:58 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11JFPVxo029792;
        Fri, 19 Feb 2021 10:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=StJ+BByIddXYKbJ1xQOK0NWH2VrzUHYXzXPsGh1ZLSs=;
 b=HjPBpbbwd9L/RC2N6cl7w0VvVHrVyjGcXCr0T45a9KWFLoxkdTn6bVwllxwSc1JY6bM5
 zkvWe+SLpDco/zjRXPPuzD3hQA/EEPsZOEkFH8LpbIl6/V7BcwpUIxl5paqdmFlepVe1
 8cDNLiBaEJJyNqEJHNBUtVEHtH1SjeI6vawGXio+6vrpBx65xk3YT3b/e5Gz89m16CfJ
 33aUnSG7d1cPam7cYzDyYmBeoslrfwFNo2gXObWBdJR7ODUAm9JA9373pcLsJxIpViUs
 3DudCgBkgowROY2eYlBTbne5iCFyvnFUIocxPanyACHJoW9bAaMRNCj0O8/QV5xer/ax NA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36tfy8g1u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 10:27:12 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11JFQDkC032455;
        Fri, 19 Feb 2021 10:27:11 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36tfy8g1sn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 10:27:11 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11JFBbLZ032684;
        Fri, 19 Feb 2021 15:25:39 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 36p6da1uyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 15:25:39 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11JFPc8P35127784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 15:25:38 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 684A1124052;
        Fri, 19 Feb 2021 15:25:38 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54A67124053;
        Fri, 19 Feb 2021 15:25:38 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 19 Feb 2021 15:25:38 +0000 (GMT)
Subject: Re: [PATCH v2 4/5] keys: define build time generated ephemeral kernel
 CA key
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20210218220011.67625-1-nayna@linux.ibm.com>
 <20210218220011.67625-5-nayna@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <ba792d11-f85c-98cd-4156-096bf9b3315b@linux.ibm.com>
Date:   Fri, 19 Feb 2021 10:25:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210218220011.67625-5-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_07:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190117
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/18/21 5:00 PM, Nayna Jain wrote:
> Certificates being loaded onto the IMA trusted keyring must be signed by
> a key on either the builtin or secondary trusted keyring. Create and
> include in the kernel image an ephemeral CA key at build time when
> IMA_APPRAISE_MODSIG is enabled.
>
> Reported-by: kernel test robot <lkp@intel.com> (redirect openssl stderr)
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>   Makefile                    |  2 ++
>   certs/Makefile              | 68 ++++++++++++++++++++++++++++++++++---
>   certs/system_certificates.S | 16 ++++++++-
>   3 files changed, 80 insertions(+), 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index a971d4ae40bd..15e8344836b1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1475,6 +1475,8 @@ MRPROPER_FILES += include/config include/generated          \
>   		  certs/signing_key.pem certs/signing_key.x509 \
>   		  certs/x509.genkey certs/signing_key.key \
>   		  certs/signing_key.crt certs/signing_key.csr \
> +		  certs/ca_signing_key.pem certs/ca_signing_key.x509 \
> +		  certs/ca_signing_key.srl \
>   		  vmlinux-gdb.py \
>   		  *.spec
>   
> diff --git a/certs/Makefile b/certs/Makefile
> index b2be7eb413d3..3fe6b73786fa 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -32,6 +32,14 @@ endif # CONFIG_SYSTEM_TRUSTED_KEYRING
>   clean-files := x509_certificate_list .x509.list
>   
>   ifeq ($(CONFIG_MODULE_SIG),y)
> +SIGN_KEY = y
> +endif
> +
> +ifeq ($(CONFIG_IMA_APPRAISE_MODSIG),y)
> +SIGN_KEY = y
> +endif
> +
> +ifdef SIGN_KEY
>   ###############################################################################
>   #
>   # If module signing is requested, say by allyesconfig, but a key has not been
> @@ -51,6 +59,16 @@ silent_redirect_openssl = 2>/dev/null
>   # external private key, because 'make randconfig' might enable such a
>   # boolean option and we unfortunately can't make it depend on !RANDCONFIG.
>   ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
> +
> +ifeq ($(CONFIG_IMA_APPRAISE_MODSIG),y)
> +# openssl arguments for CA Signed certificate.
> +CA_KEY = certs/ca_signing_key.pem
> +SIGNER = -CA $(CA_KEY) -CAkey $(CA_KEY) -CAcreateserial
> +else
> +# openssl arguments for Self Signed certificate.
> +SIGNER = -signkey $(obj)/signing_key.key
> +endif # CONFIG_IMA_APPRAISE_MODSIG
> +
>   $(obj)/signing_key.pem: $(obj)/x509.genkey
>   	@$(kecho) "###"
>   	@$(kecho) "### Now generating an X.509 key pair to be used for signing modules."
> @@ -60,14 +78,23 @@ $(obj)/signing_key.pem: $(obj)/x509.genkey
>   	@$(kecho) "### needs to be run as root, and uses a hardware random"
>   	@$(kecho) "### number generator if one is available."
>   	@$(kecho) "###"
> +ifeq ($(CONFIG_IMA_APPRAISE_MODSIG),y)
> +	# Generate kernel build time CA Certificate.
> +	@$(Q)openssl req -new -nodes -utf8 \
> +		-$(CONFIG_MODULE_SIG_HASH) -days 36500 \
> +		-subj "/CN=Build time autogenerated kernel CA key" \
> +		-batch -x509 -config $(obj)/x509.genkey \
> +		-outform PEM -out $(CA_KEY) \
> +		-keyout $(CA_KEY) -extensions ca_ext \
> +		$($(quiet)redirect_openssl)
> +endif # CONFIG_IMA_APPRAISE_MODSIG
>   	$(Q)openssl req -new -nodes -utf8 \
>   		-batch -config $(obj)/x509.genkey \
>   		-outform PEM -out $(obj)/signing_key.csr \
>   		-keyout $(obj)/signing_key.key -extensions myexts \
>   		$($(quiet)redirect_openssl)
>   	$(Q)openssl x509 -req -days 36500 -in $(obj)/signing_key.csr \
> -		-outform PEM -out $(obj)/signing_key.crt \
> -		-signkey $(obj)/signing_key.key \
> +		-outform PEM -out $(obj)/signing_key.crt $(SIGNER) \
>   		-$(CONFIG_MODULE_SIG_HASH) -extensions myexts \
>   		-extfile $(obj)/x509.genkey \
>   		$($(quiet)redirect_openssl)
> @@ -95,19 +122,50 @@ $(obj)/x509.genkey:
>   	@echo >>$@ "keyUsage=digitalSignature"
>   	@echo >>$@ "subjectKeyIdentifier=hash"
>   	@echo >>$@ "authorityKeyIdentifier=keyid"
> +	@echo >>$@
> +	@echo >>$@ "[ ca_ext ]"
> +	@echo >>$@ "keyUsage=critical,keyCertSign"
> +	@echo >>$@ "basicConstraints=critical,CA:TRUE,pathlen:0"
> +	@echo >>$@ "subjectKeyIdentifier=hash"
> +	@echo >>$@ "authorityKeyIdentifier=keyid"
>   endif # CONFIG_MODULE_SIG_KEY
>   
>   $(eval $(call config_filename,MODULE_SIG_KEY))
> +SUBJECT=CN = Build time autogenerated kernel key
> +ISSUER=$(shell openssl x509 -in certs/signing_key.crt -noout -issuer $($(quiet)redirect_openssl))
>   
>   # If CONFIG_MODULE_SIG_KEY isn't a PKCS#11 URI, depend on it
> +
> +# GCC PR#66871 again.
> +ifeq ($(CONFIG_IMA_APPRAISE_MODSIG),y)
> +
> +# Remove existing keys if it is self-signed.
> +$(if $(findstring $(SUBJECT),$(ISSUER)),$(shell rm -f certs/signing_key.* certs/x509.genkey))
> +CA_KEY = certs/ca_signing_key.pem
> +
> +$(obj)/system_certificates.o: $(obj)/ca_signing_key.x509 $(obj)/signing_key.x509
> +
> +targets += ca_signing_key.x509
> +$(obj)/ca_signing_key.x509: $(obj)/signing_key.x509 scripts/extract-cert FORCE
> +	$(call if_changed,extract_certs,$(CA_KEY))
> +
> +targets += signing_key.x509
> +$(obj)/signing_key.x509: $(obj)/signing_key.pem scripts/extract-cert FORCE
> +	$(call if_changed,extract_certs,$(MODULE_SIG_KEY_SRCPREFIX)$(CONFIG_MODULE_SIG_KEY))
> +else
> +
> +# Remove existing keys if it is CA signed.
> +$(if $(findstring $(SUBJECT),$(ISSUER)),,$(shell rm -f certs/ca_signing_key.* certs/signing_key.* certs/x509.genkey))
> +
>   ifeq ($(patsubst pkcs11:%,%,$(firstword $(MODULE_SIG_KEY_FILENAME))),$(firstword $(MODULE_SIG_KEY_FILENAME)))
>   X509_DEP := $(MODULE_SIG_KEY_SRCPREFIX)$(MODULE_SIG_KEY_FILENAME)
>   endif
>   
> -# GCC PR#66871 again.

I think you should keep this comment at this place here.


>   $(obj)/system_certificates.o: $(obj)/signing_key.x509
>   
>   targets += signing_key.x509
> -$(obj)/signing_key.x509: scripts/extract-cert $(X509_DEP) FORCE
> +$(obj)/signing_key.x509: certs/signing_key.pem scripts/extract-cert $(X509_DEP) FORCE
>   	$(call if_changed,extract_certs,$(MODULE_SIG_KEY_SRCPREFIX)$(CONFIG_MODULE_SIG_KEY))
> -endif # CONFIG_MODULE_SIG
> +
> +endif # CONFIG_IMA_APPRAISE_MODSIG
> +endif # SIGN_KEY
> diff --git a/certs/system_certificates.S b/certs/system_certificates.S
> index 8f29058adf93..e10043800a7e 100644
> --- a/certs/system_certificates.S
> +++ b/certs/system_certificates.S
> @@ -8,8 +8,13 @@
>   	.globl system_certificate_list
>   system_certificate_list:
>   __cert_list_start:
> -#ifdef CONFIG_MODULE_SIG
> +__module_cert_start:
> +#if defined(CONFIG_MODULE_SIG) || defined(CONFIG_IMA_APPRAISE_MODSIG)
>   	.incbin "certs/signing_key.x509"
> +#endif
> +__module_cert_end:
> +#ifdef CONFIG_IMA_APPRAISE_MODSIG
> +	.incbin "certs/ca_signing_key.x509"
>   #endif
>   	.incbin "certs/x509_certificate_list"
>   __cert_list_end:
> @@ -35,3 +40,12 @@ system_certificate_list_size:
>   #else
>   	.long __cert_list_end - __cert_list_start
>   #endif
> +
> +	.align 8
> +	.globl module_cert_size
> +	module_cert_size:
> +#ifdef CONFIG_64BIT
> +	.quad __module_cert_end - __module_cert_start
> +#else
> +	.long __module_cert_end - __module_cert_start
> +#endif


