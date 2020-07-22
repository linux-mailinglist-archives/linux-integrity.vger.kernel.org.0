Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D12822A0CC
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jul 2020 22:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgGVUeG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jul 2020 16:34:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbgGVUeG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jul 2020 16:34:06 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06MKXsKl168918;
        Wed, 22 Jul 2020 16:33:58 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32e1xxu7bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 16:33:57 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06MKUfOT002372;
        Wed, 22 Jul 2020 20:33:55 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 32brq85dy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 20:33:55 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06MKXqM161931584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jul 2020 20:33:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFC4FA4053;
        Wed, 22 Jul 2020 20:33:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07AC9A4040;
        Wed, 22 Jul 2020 20:33:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.219.44])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jul 2020 20:33:51 +0000 (GMT)
Message-ID: <1595450030.5211.53.camel@linux.ibm.com>
Subject: Re: [PATCH] IMA: Add a test to verify importing a certificate into
 custom keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lachlan Sneff <t-josne@linux.microsoft.com>, pvorel@suse.cz,
        ltp@lists.linux.it
Cc:     nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
Date:   Wed, 22 Jul 2020 16:33:50 -0400
In-Reply-To: <20200717205721.18173-1-t-josne@linux.microsoft.com>
References: <20200717205721.18173-1-t-josne@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_13:2020-07-22,2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007220128
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-07-17 at 16:57 -0400, Lachlan Sneff wrote:
> A test for verifying importing an x509 certificate into a keyring and
> validating the key measurement performed by IMA is needed.

Isn't the main purpose of this patch to verify the certificate being
loaded onto a keyring is properly measured.  The rest is just details.
 Please update the Subject line accordingly.

> Add an IMA measurement test that verifies that an x509 certificate
> can be imported into a custom keyring and measured correctly.
> 
> A certificate used by the test is included in the `datafiles/keys` directory.
> 
> Using a custom keyring for the test is preferred over using a pre-existing/built-in keyring,
> such as `.ima`, since there may be restrictions to importing any cert into a built-in keyring.
> For example, the `.ima` keyring requires that the imported certs be signed by a kernel private
> key in certain kernel configurations.
> 

First describe the problem, then provide the solution.  In this case,
perhaps something like:

There may be restrictions importing a certificate onto a builtin
trusted keyring.  For example ...   For this reason, this test defines
a userspace keyring.

(Please remember to limit the patch description line width to 72
chars.)


> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
> ---
>  .../kernel/security/integrity/ima/README.md   |  20 +++-----
>  .../security/integrity/ima/datafiles/Makefile |  11 ++---
>  .../integrity/ima/datafiles/keys/Makefile     |  31 ++++++++++++
>  .../integrity/ima/datafiles/keys/x509.der     | Bin 0 -> 784 bytes
>  .../integrity/ima/datafiles/policy/Makefile   |  31 ++++++++++++
>  .../datafiles/{ => policy}/keycheck.policy    |   0
>  .../ima/datafiles/{ => policy}/measure.policy |   0
>  .../{ => policy}/measure.policy-invalid       |   0
>  .../security/integrity/ima/tests/ima_keys.sh  |  45 +++++++++++++++++-
>  9 files changed, 117 insertions(+), 21 deletions(-)
>  create mode 100644 testcases/kernel/security/integrity/ima/datafiles/keys/Makefile
>  create mode 100644 testcases/kernel/security/integrity/ima/datafiles/keys/x509.der
>  create mode 100644 testcases/kernel/security/integrity/ima/datafiles/policy/Makefile
>  rename testcases/kernel/security/integrity/ima/datafiles/{ => policy}/keycheck.policy (100%)
>  rename testcases/kernel/security/integrity/ima/datafiles/{ => policy}/measure.policy (100%)
>  rename testcases/kernel/security/integrity/ima/datafiles/{ => policy}/measure.policy-invalid (100%)
> 
> diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
> index 732cd912f..db8819a99 100644
> --- a/testcases/kernel/security/integrity/ima/README.md
> +++ b/testcases/kernel/security/integrity/ima/README.md
> @@ -16,25 +16,19 @@ space, may contain equivalent measurement tcb rules, detecting them would
>  require `IMA_READ_POLICY=y` therefore ignore this option.
>  
>  ### IMA key import test
> -`ima_keys.sh` requires a x509 public key, by default in `/etc/keys/x509_ima.der`
> -(defined in `CONFIG_IMA_X509_PATH` kernel config option).
> -The key must be signed by the private key you generate. Follow these instructions:
> -https://manpages.ubuntu.com/manpages/disco/man1/evmctl.1.html#generate%20trusted%20keys
>  
> -The test cannot be set-up automatically because the x509 public key must be
> -built into the kernel and loaded onto a trusted keyring
> -(e.g. `.builtin_trusted_keys`, `.secondary_trusted_keyring`).
> -
> -As well as what's required for the IMA tests, the following are also required

This patch adds a new test, that shouldn't affect the existing test.
 If test1 changes, then it needs to be highlighted in the patch
description.

> +As well as what's required for the IMA tests, the following is also required
>  in the kernel configuration:
>  ```
>  CONFIG_IMA_READ_POLICY=y
> -CONFIG_IMA_X509_PATH="/etc/keys/x509_ima.der"
> -CONFIG_SYSTEM_TRUSTED_KEYRING=y
> -CONFIG_SYSTEM_TRUSTED_KEYS="/etc/keys/ima-local-ca.pem"
>  ```
>  
> -Test also requires loaded policy with `func=KEY_CHECK`, see example in `keycheck.policy`.
> +You must also add the following line to /etc/ima/ima-policy and reboot.

Documentation should be written in the third person.  For example,
instead of "you must", "A key measurement rule must be defined in the
IMA policy. For example, ...."

> +```
> +measure func=KEY_CHECK keyrings=key_import_test template=ima-buf
> +```
> +
> +The test also requires loaded policy with `func=KEY_CHECK`, see example in `keycheck.policy`.
>  
>  ## EVM tests
>  
> diff --git a/testcases/kernel/security/integrity/ima/datafiles/Makefile b/testcases/kernel/security/integrity/ima/datafiles/Makefile
> index a960f9d84..5261b9321 100644
> --- a/testcases/kernel/security/integrity/ima/datafiles/Makefile
> +++ b/testcases/kernel/security/integrity/ima/datafiles/Makefile
> @@ -1,5 +1,5 @@
>  #
> -#    testcases/kernel/security/integrity/ima/policy testcases Makefile.
> +#    kernel/security/integrity/ima testcase Makefile.

This change doesn't look right.

>  #
>  #    Copyright (C) 2009, Cisco Systems Inc.
>  #
> @@ -18,14 +18,13 @@
>  #    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  #
>  # Ngie Cooper, July 2009
> +# Lachlan Sneff, July 2020
>  #
>  
>  top_srcdir		?= ../../../../../..
>  
> -include	$(top_srcdir)/include/mk/env_pre.mk
> +include $(top_srcdir)/include/mk/env_pre.mk

Please review the actual patch before posting it.  Changes like this
are unnecessary.

>  
> -INSTALL_DIR		:= testcases/data/ima_policy
> +SUBDIRS			:= policy keys
>  
> -INSTALL_TARGETS		:= measure*
> -
> -include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +include $(top_srcdir)/include/mk/generic_trunk_target.mk

When making changes to someone else's code, please Cc them on the
change.  Use "git blame" to get the commit author.

> diff --git a/testcases/kernel/security/integrity/ima/datafiles/keys/Makefile b/testcases/kernel/security/integrity/ima/datafiles/keys/Makefile
> new file mode 100644
> index 000000000..3e381089c
> --- /dev/null
> +++ b/testcases/kernel/security/integrity/ima/datafiles/keys/Makefile
> @@ -0,0 +1,31 @@
> +#
> +#    testcases/kernel/security/integrity/ima/policy testcases Makefile.
> +#
> +#    Copyright (C) 2009, Cisco Systems Inc.

Hm, aren't you working for Microsoft?  If you're moving existing code,
please move that code separately from any other changes.  Newer files
probably use the SPDX format.

> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License along
> +#    with this program; if not, write to the Free Software Foundation, Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Lachlan Sneff, July 2020
> +#
> +
> +top_srcdir		?= ../../../../../../..
> +
> +include	$(top_srcdir)/include/mk/env_pre.mk
> +
> +INSTALL_DIR		:= testcases/data/ima_keys
> +
> +INSTALL_TARGETS		:= x509.der
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/security/integrity/ima/datafiles/keys/x509.der b/testcases/kernel/security/integrity/ima/datafiles/keys/x509.der
> new file mode 100644
> index 0000000000000000000000000000000000000000..538611c7244eac17377031038a97bf5d02c53d3f
> GIT binary patch
> literal 784
> zcmXqLV&*YuV*IjznTe5!Nkm*%!l+fPYOa%w{pGeOu7W)g|5Ocl**LY@JlekVGBR?r
> zG8lv!@&kpKLs__Z*gSn5b)6jzH4M~10?a(}KmmQ%Fkgk_)S{Biw9Mqhl2nD_%=Em>
> zymW=^)Jj7M12MR1oQz_e$%zh`xrw^Ti3W1wyha8Frbd>ArbZS<mQg^iArjXhz);YD
> zA7U*>Mt*TgUSe*lp|pV{#A2cHjQqshOccB13}le);)f`4fN3^poR91^Mpg#q#$E=4
> z#!jZjMuvqS<2&d4={o*uW**0h|9T%Tw9S&_xXFEO!9t#YW*25;x2$<5W-0eWw?OBy
> z^v@jizdt`D%q<d|ReAl{bE_$0%^l11#6PRp?#-6J7PfX<qx=M^6KT?qw?*WN1?*@I
> z%Cqp^b9sffLXO?miT~#3|NU~~-j<6EKTciX{lAO7bFKR(@pL9;Mh3>ku?EowJU|c1
> z3NtePXJIm6FyIF9_*qz(nb;c)WI-H07BLo)gzIHKKP^@H&nbIpE!y9-E`Uo=(m)<0
> zt;_-p@&=LZk_VQ~bi1@pYvM`%j}JQk-GBc`6502_h-GeKWMs(U%{uxsJ8V$|&s^U*
> zuT)C?`L3+KeqYmBdG>)zfpWi7n6jqq>YI1K{O3*;XK_o1>WKamk9bck{$vuzdw37y
> zvA`0c_d5A+eCHjLThIIJa@MIAVc(m-U;nXmbAi*F0<FyFA#2;;#Isxf2xngNvA$<=
> z$CMi7RW8Ag|Jk3|uI6~;sc!ZA<5Qn=%P&bzdui}MisQ9MYhlhY|F7HrKV4$gX6yNt
> zC8pkE<;LwsPD}g`oc<&~`(D3i*QEZk`);XW=B4u<{+H1Ux#t$eaj2M|C+nQUOz~ec
> zU5)v!tl*ZMaObGw{B>uG+jphhdu=ZLZTh9(PmEsIm`5}$d$_dpOSj%iU{I%d0|3@i
> BE~)?k
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/testcases/kernel/security/integrity/ima/datafiles/policy/Makefile b/testcases/kernel/security/integrity/ima/datafiles/policy/Makefile
> new file mode 100644
> index 000000000..692bf61ab
> --- /dev/null
> +++ b/testcases/kernel/security/integrity/ima/datafiles/policy/Makefile
> @@ -0,0 +1,31 @@
> +#
> +#    testcases/kernel/security/integrity/ima/policy testcases Makefile.
> +#
> +#    Copyright (C) 2009, Cisco Systems Inc.
> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License along
> +#    with this program; if not, write to the Free Software Foundation, Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Ngie Cooper, July 2009
> +#
> +
> +top_srcdir		?= ../../../../../../..
> +
> +include	$(top_srcdir)/include/mk/env_pre.mk
> +
> +INSTALL_DIR		:= testcases/data/ima_policy
> +
> +INSTALL_TARGETS		:= measure*
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/security/integrity/ima/datafiles/keycheck.policy b/testcases/kernel/security/integrity/ima/datafiles/policy/keycheck.policy
> similarity index 100%
> rename from testcases/kernel/security/integrity/ima/datafiles/keycheck.policy
> rename to testcases/kernel/security/integrity/ima/datafiles/policy/keycheck.policy
> diff --git a/testcases/kernel/security/integrity/ima/datafiles/measure.policy b/testcases/kernel/security/integrity/ima/datafiles/policy/measure.policy
> similarity index 100%
> rename from testcases/kernel/security/integrity/ima/datafiles/measure.policy
> rename to testcases/kernel/security/integrity/ima/datafiles/policy/measure.policy
> diff --git a/testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid b/testcases/kernel/security/integrity/ima/datafiles/policy/measure.policy-invalid
> similarity index 100%
> rename from testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid
> rename to testcases/kernel/security/integrity/ima/datafiles/policy/measure.policy-invalid
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> index 904b7515b..101d2ea92 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> @@ -5,8 +5,8 @@
>  #
>  # Verify that keys are measured correctly based on policy.
>  
> -TST_NEEDS_CMDS="grep mktemp cut sed tr"
> -TST_CNT=1
> +TST_NEEDS_CMDS="grep mktemp cut sed tr xxd keyctl evmctl openssl cmp"
> +TST_CNT=2
>  TST_NEEDS_DEVICE=1
>  
>  . ima_setup.sh
> @@ -65,4 +65,45 @@ test1()
>  	tst_res TPASS "specified keyrings were measured correctly"
>  }
>  
> +# Create a custom keyring and import a certficate to that

What is a custom keyring?  Try inverting the sentence - "Import a
certificate onto a newly created keyring."

> +test2() {

The patch description should mention this patch defines an additional
ima_keys.sh test.  Another difference between test1 and test2 is that
doesn't require root privileges.


> +	local custom_keyring_id temp_file="file.txt" \
> +		cert_file="$TST_DATAROOT/x509.der"
> +
> +	tst_res TINFO "checking for correct IMA policy"
> +
> +	[ -f $IMA_POLICY ] || tst_brk TCONF "missing $IMA_POLICY"
> +
> +	[ -r $IMA_POLICY ] || tst_brk TCONF "cannot read IMA policy (CONFIG_IMA_READ_POLICY=y required)"
> +
> +	if ! grep "measure func=KEY_CHECK.*keyrings=.*key_import_test" $IMA_POLICY > /dev/null; then
> +		tst_brk TCONF "the IMA policy does not include the key_import_test keyring. See the LTP IMA README."
> +	fi
> +
> +	tst_res TINFO "creating a custom keyring (key_import_test keyring)"
> +
> +	custom_keyring_id=$(keyctl newring key_import_test @s) || \
> +		tst_brk TCONF "unable to create a new keyring"
> +
> +	tst_is_num "$custom_keyring_id" || \
> +		tst_brk TCONF "unable to parse custom keyring id"
> +
> +	evmctl import $cert_file "$custom_keyring_id" > /dev/null || \
> +		tst_brk TCONF "unable to import a cert into the key_import_test keyring"
> +
> +	grep "key_import_test" "$ASCII_MEASUREMENTS" | tail -n1 | cut -d' ' -f6 | \
> +		xxd -r -p > $temp_file || \
> +		tst_brk TCONF "keyring not found in $ASCII_MEASUREMENTS"
> +
> +	if ! openssl x509 -in $temp_file -inform der > /dev/null; then
> +		tst_brk TCONF "the cert logged in $ASCII_MEASUREMENTS is not a valid x509 certificate"
> +	fi
> +
> +	if cmp -s $temp_file $cert_file; then
> +		tst_res TPASS "logged cert matches original cert"
> +	else
> +		tst_res TFAIL "logged cert does not match original cert"
> +	fi
> +}
> +
>  tst_run

Normally when code is duplicated with only minor changes, it implies
that the code can be refactored.

Mimi


