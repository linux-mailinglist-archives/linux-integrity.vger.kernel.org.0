Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1660245B05
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 05:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHQDWI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 16 Aug 2020 23:22:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgHQDWG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 Aug 2020 23:22:06 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07H32GsA093708;
        Sun, 16 Aug 2020 23:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=yrcGAZMTCbkxu8Rob8TJehQr1Z1+pPhPAUdmMReok2k=;
 b=n/YqSKfQjUygObrbMrnJJpneGSa1fbwHNG7CN2oU2x/+7/BqWf1PTx9F2NdJnG73AclT
 JVDiSfI6OXb/LfTBPNlPDIPKXFG2pJmMc7LzGHxvd5WWHmZ+941Yfg5hunKp8skynYoT
 OElC46JKAyVLAjxF5N0Zy0BMpy7uSoLXQS6vNC3ZVhsqdhGM0LaxXlQAE3r2cv9rrJQq
 hMwFpOPA1+W1/3MbZ9RVefywwwl1wJK7+37O4VpJnu1zQvIVWXPbJmvyAVKzgp9+xFYI
 js1UUdtXSCNpScR1J17U9Txyred07b4Y+WIOSlhS44tWCYR+YsgZMQZURpTElnizwvPy 5Q== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32y4f3e9sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 23:21:58 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07H3B5jI020046;
        Mon, 17 Aug 2020 03:21:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 32x7b81rxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 03:21:56 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07H3LssB25428338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Aug 2020 03:21:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C9F911C04C;
        Mon, 17 Aug 2020 03:21:54 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8350011C050;
        Mon, 17 Aug 2020 03:21:52 +0000 (GMT)
Received: from sig-9-65-237-100.ibm.com (unknown [9.65.237.100])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Aug 2020 03:21:52 +0000 (GMT)
Message-ID: <25a78f42d15dcb3312a59de587cb9f4e31ccd5b5.camel@linux.ibm.com>
Subject: Re: [PATCH v2 3/4] IMA: Add a test to verify measurement of
 certificate imported into a keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Date:   Sun, 16 Aug 2020 23:21:51 -0400
In-Reply-To: <20200807204652.5928-4-pvorel@suse.cz>
References: <20200807204652.5928-1-pvorel@suse.cz>
         <20200807204652.5928-4-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_01:2020-08-14,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=4
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008170020
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr, Lachlan,

On Fri, 2020-08-07 at 22:46 +0200, Petr Vorel wrote:
> From: Lachlan Sneff <t-josne@linux.microsoft.com>

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> index 53c289054..30950904e 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> 
> @@ -61,4 +65,52 @@ test1()
>  	tst_res TPASS "specified keyrings were measured correctly"
>  }
> 
> +# Create a new keyring, import a certificate into it, and verify
> +# that the certificate is measured correctly by IMA.
> +test2()
> +{
> +	tst_require_cmds evmctl keyctl openssl
> +
> +	local cert_file="$TST_DATAROOT/x509_ima.der"
> +	local keyring_name="key_import_test"
> +	local temp_file="file.txt"
> +	local keyring_id
> +
> +	tst_res TINFO "verify measurement of certificate imported into a keyring"
> +
> +	if ! check_ima_policy_content "^measure.*func=KEY_CHECK.*keyrings=.*$keyring_name"; then
> +		tst_brk TCONF "IMA policy does not contain $keyring_name keyring"
> +	fi
> +

If the IMA policy contains multiple KEY_CHECK measurement policy rules
it complains about "grep: Unmatched ( or \(".

Sample rules:
measure func=KEY_CHECK template=ima-buf
keyrings=.ima|.builtin_trusted_keys
measure func=KEY_CHECK template=ima-buf keyrings=key_import_test

> +	keyctl new_session > /dev/null
> +
> +	keyring_id=$(keyctl newring $keyring_name @s) || \
> +		tst_brk TBROK "unable to create a new keyring"
> +
> +	tst_is_num $keyring_id || \
> +		tst_brk TBROK "unable to parse the new keyring id"
> +
> +	evmctl import $cert_file $keyring_id > /dev/null || \
> +		tst_brk TBROK "unable to import a certificate into $keyring_name keyring"

"cert_file" needs to be updated from 
"ltp/testcases/kernel/security/integrity/ima/tests/datafiles/x509_ima.d
er" to
"ltp/testcases/kernel/security/integrity/ima/tests/../datafiles/ima_key
s/x509_ima.der".

On failure to open the file, 
errno: No such file or directory (2)
ima_keys 2 TBROK: unable to import a certificate into key_import_test keyring
ima_keys 2 TINFO: SELinux enabled in enforcing mode, this may affect test results
ima_keys 2 TINFO: it can be disabled with TST_DISABLE_SELINUX=1 (requires super/root)
ima_keys 2 TINFO: install seinfo to find used SELinux profiles
ima_keys 2 TINFO: loaded SELinux profiles: none

Mimi

> +
> +	grep $keyring_name $ASCII_MEASUREMENTS | tail -n1 | cut -d' ' -f6 | \
> +		xxd -r -p > $temp_file
> +
> +	if [ ! -s $temp_file ]; then
> +		tst_res TFAIL "keyring $keyring_name not found in $ASCII_MEASUREMENTS"
> +		return
> +	fi
> +
> +	if ! openssl x509 -in $temp_file -inform der > /dev/null; then
> +		tst_res TFAIL "logged certificate is not a valid x509 certificate"
> +		return
> +	fi
> +
> +	if cmp -s $temp_file $cert_file; then
> +		tst_res TPASS "logged certificate matches the original"
> +	else
> +		tst_res TFAIL "logged certificate does not match original"
> +	fi
> +}
> +
>  tst_run


