Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F62253A2C
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Aug 2020 00:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHZWP5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Aug 2020 18:15:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50870 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726753AbgHZWP4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Aug 2020 18:15:56 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07QM2Tdp009433;
        Wed, 26 Aug 2020 18:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=nNPbnCetM8DJY93wEqN5qBmsHN/Kc8f0y0wqAxveMYM=;
 b=lr8055hdX63jt8oVvHSlch3OJPsPxt+yl8uIoQHl8xKY2lMNOv9sxXRSD+Sy8lU/4cVn
 t0rV1o6MEWNviKULF4RWIl+CrxUZTE1x7t9LyQzhIAGm+oG0IWqHOFoEYJsqAnz0yyGb
 14q+H4CZzhnsi01wa49rYrV9Hs2XDU6knWtdMCS8Oen+WHm0M15Ov8iCVCbiGhGAgoyF
 2jW1yyI/Eveco8qfZnqwSFgq8fx44uXeqAULYTCf2GuDKjlXzE7sa8ibJ6YPLWDf7y2+
 PY4dRAXZVWxRVqxeSmuorwTt27IFMCKzHxNoxgGJFEU0wq90wLk7sSLI5IXYohx0yvcF Jw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 335y7rj155-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 18:15:48 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07QMC69O025859;
        Wed, 26 Aug 2020 22:15:47 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 332ujkw0f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 22:15:47 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07QMFiq113959424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 22:15:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E23EAAE04D;
        Wed, 26 Aug 2020 22:15:44 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47387AE045;
        Wed, 26 Aug 2020 22:15:43 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.94.210])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Aug 2020 22:15:43 +0000 (GMT)
Message-ID: <b58057275ecdc06bb512d39ea46118197f33c33f.camel@linux.ibm.com>
Subject: Re: [LTP v4 4/5] IMA: Add a test to verify measurement of
 certificate imported into a keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 26 Aug 2020 18:15:42 -0400
In-Reply-To: <20200820090824.3033-5-pvorel@suse.cz>
References: <20200820090824.3033-1-pvorel@suse.cz>
         <20200820090824.3033-5-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_14:2020-08-26,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=833 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260165
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-08-20 at 11:08 +0200, Petr Vorel wrote:

> @@ -63,4 +73,50 @@ test1()
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
> +
> +	tst_res TINFO "verify measurement of certificate imported into a keyring"
> +
> +	if ! check_ima_policy_content "^measure.*func=KEY_CHECK.*keyrings=.*$keyring_name"; then
> +		tst_brk TCONF "IMA policy does not contain $keyring_name keyring"
> +	fi
> +
> +	KEYRING_ID=$(keyctl newring $keyring_name @s) || \
> +		tst_brk TBROK "unable to create a new keyring"
> +
> +	if ! tst_is_num $KEYRING_ID; then
> +		tst_brk TBROK "unable to parse the new keyring id ('$KEYRING_ID')"
> +	fi
> +

Instead of using TST_DATAROOT, which is defined as
"$LTPROOT/datafiles", use LTPROOT directly to define the path to the
cert.  Adding the following will allow the test to run from the build
directory.
 
      if [ ! -f $cert_file ]; then
              cert_file="$LTPROOT/../datafiles/ima_keys/x509_ima.der"
      fi

Mimi

> +	evmctl import $cert_file $KEYRING_ID > /dev/null || \
> +		tst_brk TBROK "unable to import a certificate into $keyring_name keyring"
> +

