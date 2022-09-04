Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074915AC56A
	for <lists+linux-integrity@lfdr.de>; Sun,  4 Sep 2022 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiIDQ0Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 4 Sep 2022 12:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiIDQ0W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 4 Sep 2022 12:26:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFE032A81
        for <linux-integrity@vger.kernel.org>; Sun,  4 Sep 2022 09:26:17 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 284GIY9E027865;
        Sun, 4 Sep 2022 16:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=mcfcvJ+eQs1GK8+Ii3WCPIswCa7z+MiPqWdWsyT29/I=;
 b=i2tVnhv1+zgFTGdhhFRKV7owShYMuAqn+MxK0Hcd23bsm/onVG2aowIhHnsWAHh/gzjl
 WMhfzMM+rxc4pDc/CvukJGjKOCQ5TtpEK4iSpBI/Y6JdNcqTC+hik05DioBdGbx2mwYE
 hCCGtJgve9Lg36WJ3IMmJ2klOSQUGoiNIVVpz8VVdDBGBTXOVnUU6JIxWk/I+M6WD34H
 d5/gZq2Te50R9AMb7i+jvr6lwi0OOmdmSP2Zd+1Rdh8SzmdIQcvnLV0wXlXXh6LrlRou
 YfvKjqtzHQ4uhOnYxQ0XP+VwkWYNwhRj0Um+gIuxPC4OqSBjj4LqXl0foNYTgert7CKK 0A== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jcye5g2mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Sep 2022 16:26:11 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 284GOMnq002176;
        Sun, 4 Sep 2022 16:26:10 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma05wdc.us.ibm.com with ESMTP id 3jbxj9g795-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Sep 2022 16:26:10 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 284GQ9IC8192680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 4 Sep 2022 16:26:09 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 897D128059;
        Sun,  4 Sep 2022 16:26:09 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E94AD28058;
        Sun,  4 Sep 2022 16:26:08 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.48.194])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun,  4 Sep 2022 16:26:08 +0000 (GMT)
Message-ID: <9a0aaef15863586e6b57b20eb99cb6f7029f313b.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils 08/11] Deprecate use of OpenSSL v3
 "engine" support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Sun, 04 Sep 2022 12:26:08 -0400
In-Reply-To: <20220904030839.dighibhcyxz46utx@altlinux.org>
References: <20220902162836.554839-1-zohar@linux.ibm.com>
         <20220902162836.554839-9-zohar@linux.ibm.com>
         <20220904030839.dighibhcyxz46utx@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eF8cKYN_FEXkNLEqNvYBopDD3ORw9kwN
X-Proofpoint-GUID: eF8cKYN_FEXkNLEqNvYBopDD3ORw9kwN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-04_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209040081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Sun, 2022-09-04 at 06:08 +0300, Vitaly Chikunov wrote:
> On Fri, Sep 02, 2022 at 12:28:33PM -0400, Mimi Zohar wrote:
> > OpenSSL v3 "engine" support is deprecated and replaced with "providers".
> > Engine support will continue to work for a while, but results in
> > deprecated declaration and other messages.  One option is simply to hide
> > them ("-Wno-deprecated-declarations").  The other alternative is to
> > conditionally build ima-evm-utils without OpenSSL v3 engine support and
> > without disabling deprecated declarations.
> > 
> > Based on "--disable-engine" or "--enable-engine=no" configuration
> > option, disable OpenSSL v3 "engine" support.
> > 
> > When ima-evm-utils engine support is disabled, don't execute the tests
> > requiring it.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  configure.ac           | 13 +++++++++++++
> >  src/Makefile.am        |  8 ++++++++
> >  src/evmctl.c           | 17 ++++++++++++++++-
> >  src/imaevm.h           |  2 ++
> >  src/libimaevm.c        |  5 +++++
> >  tests/functions.sh     | 14 +++++++++++++-
> >  tests/ima_hash.test    |  9 +++++++++
> >  tests/sign_verify.test | 10 ++++++++++
> >  8 files changed, 76 insertions(+), 2 deletions(-)
> > 
> > diff --git a/configure.ac b/configure.ac
> > index dc666f2bb1fa..1a7d7eb17370 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -54,6 +54,17 @@ AC_ARG_ENABLE(sigv1,
> >  	AM_CONDITIONAL([CONFIG_SIGV1], [test "x$enable_sigv1" = "xyes"])
> >  	AS_IF([test "$enable_sigv1"  != "yes"], [enable_sigv1="no"])
> >  
> > +AC_ARG_ENABLE(engine,
> 
> Thanks.
> 
> BTW, if we now have handling of disabled engine -- OpenSSL have defines
> OPENSSL_NO_ENGINE and OPENSSL_NO_DYNAMIC_ENGINE -- I think if any of
> them is defined we could disable engine support automatically.

Ok

> 
> (Just a thought: In general, I would prefer if we rely on what is
> configured in OpenSSL (whatever is enabled or disabled), and not
> complicate things for user with post-decision of what is allowed for us
> from OpenSSL. But of course opinions are different.)

Sorry, but at leat for my testing purposes, being able to disable ima-
evm-utils OpenSSL engine support without recompiling other packages is
a requirement.

> > +	      [AS_HELP_STRING([--disable-engine], [build ima-evm-utils without OpenSSL v3 engine support])])
> 
> I think "v3" could be removed since it exists in v1 too.

configure.ac currently still limits disabling OpenSSL engine support to
v3, but that could be removed.

> 
> > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > index 4b37bf5bd62c..ba489402f6f1 100644
> > --- a/src/libimaevm.c
> > +++ b/src/libimaevm.c
> > @@ -959,6 +959,7 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
> >  	EVP_PKEY *pkey;
> >  
> >  	if (!strncmp(keyfile, "pkcs11:", 7)) {
> > +#ifdef CONFIG_ENGINE
> >  		if (!imaevm_params.keyid) {
> >  			log_err("When using a pkcs11 URI you must provide the keyid with an option\n");
> >  			return NULL;
> > @@ -975,6 +976,10 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
> >  			log_err("Failed to load private key %s\n", keyfile);
> >  			goto err_engine;
> >  		}
> > +#else
> > +		log_err("OpenSSL 3 \"engine\" support is deprecated\n");
> 
> And here too "3" could be removed. And perhaps "is disabled" since this is
> not just a deprecation warning, but an error.

Sure.

