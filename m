Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AA427D65A
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Sep 2020 21:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgI2TCh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 15:02:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728210AbgI2TCh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 15:02:37 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TJ2MAA084305;
        Tue, 29 Sep 2020 15:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=zjlmpNd+Fsp0oDR5NKJWbx0dWfAsKNpmCBx6hydglkE=;
 b=gb1WOGW0kusOdK5FxWd80KrV/g8UF7Jw+KQ2jVamDVyILGXQs48ePhrTmnsv6oovWaxi
 kvJqOodcFh/yWwRU8FOhkZ3dywc+1M8QkCu4dEx/ZAOT6CQUcdCo9s0oTMy6Pa+nCp5M
 0mFgpqkCWvObX44HA0irhLhltscLBYYNtmq+18F5OqDimzGAFp30yP+I5YAcgoHf0mfw
 iAQwWjLbWp5blu+MyDmgyeHhNLtWEPGXxF7oJZ8YNsRl+5DFHoEKKn+TGa2lvtM0skVX
 jT1P+A5ak73FaRlg2p12ICPmE2pRvnx57ye8lcOw5DBTEbB15pBgmNDj0SMl0LRdCQnb Mg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33v9g62b3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 15:02:27 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08TJ1mc0003945;
        Tue, 29 Sep 2020 19:01:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 33v5kg05j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 19:01:48 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08TJ1kr935717626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 19:01:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A4604204B;
        Tue, 29 Sep 2020 19:01:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BD7242047;
        Tue, 29 Sep 2020 19:01:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.90.38])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Sep 2020 19:01:44 +0000 (GMT)
Message-ID: <77a75615c8ee019bcd0b0dac7946449b2e26c891.camel@linux.ibm.com>
Subject: Re: [PATCH v3 4/4] ima_tpm.sh: Fix calculating PCR aggregate
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 29 Sep 2020 15:01:43 -0400
In-Reply-To: <20200929165021.11731-5-pvorel@suse.cz>
References: <20200929165021.11731-1-pvorel@suse.cz>
         <20200929165021.11731-5-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_11:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290155
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Tue, 2020-09-29 at 18:50 +0200, Petr Vorel wrote:
> +get_pcr10_aggregate()
> +{
> +       local pcr
> +
> +       evmctl -v ima_measurement $BINARY_MEASUREMENTS > hash.txt 2>&1
> +
> +       pcr=$(grep -E "^($ALGORITHM: )*PCRAgg.*:" hash.txt \
> +               | awk '{print $NF}')
> +
> +       if [ -z "$pcr" ]; then
> +               tst_res TFAIL "evmctl failed to get aggregate PCR-10"
> +               cat hash.txt >&2
> +               return
> +       fi
> +
> +       echo "$pcr"
> +}
> +

I'm seeing the following output:

10 a528ab7a7096e0187aa5c154502f467a0f931873 ima-ng
sha1:75bf81bc120313f6aa61430fad4a47afceea3e7c
/usr/local/lib/libimaevm.so.2.0.0
Failed to match per TPM bank or SHA1 padded TPM digest(s).
errno: No such file or directory (2)
ima_tpm 2 TBROK: Test didn't report any results
ima_tpm 2 TINFO: SELinux enabled in enforcing mode, this may affect
test results
ima_tpm 2 TINFO: it can be disabled with TST_DISABLE_SELINUX=1
(requires super/root)
ima_tpm 2 TINFO: install seinfo to find used SELinux profiles
ima_tpm 2 TINFO: loaded SELinux profiles: none

SELinux is blamed enough for different things.  Let's not add verifying
the IMA measurement list.  A more likely reason for failing to validate
the measurement list is that it contains violations.  Normally this is
because the builtin "ima_policy=tcb" policy has not been replaced with
a custom policy, based on LSM labels.

Test2 should fail when the measurement list contains violations, but it
should retry validating the measurement list with the "--ignore-
violations" option to provide additional context.

thanks,

Mimi

