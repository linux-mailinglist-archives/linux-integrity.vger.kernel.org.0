Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1465642A51
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jun 2019 17:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437171AbfFLPHK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jun 2019 11:07:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51244 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436492AbfFLPHK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jun 2019 11:07:10 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CF5FWB128441
        for <linux-integrity@vger.kernel.org>; Wed, 12 Jun 2019 11:07:09 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t32n8ugn9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 12 Jun 2019 11:07:08 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 12 Jun 2019 16:07:06 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Jun 2019 16:07:04 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5CF73Er52559980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 15:07:03 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38DBE42042;
        Wed, 12 Jun 2019 15:07:03 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F39F4203F;
        Wed, 12 Jun 2019 15:07:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.109.218])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 12 Jun 2019 15:07:02 +0000 (GMT)
Subject: Re: [PATCH v3 3/4] ima/ima_measurements.sh: Require builtin IMA tcb
 policy
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>,
        linux-integrity@vger.kernel.org
Date:   Wed, 12 Jun 2019 11:06:51 -0400
In-Reply-To: <20190611193021.17651-4-pvorel@suse.cz>
References: <20190611193021.17651-1-pvorel@suse.cz>
         <20190611193021.17651-4-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061215-0008-0000-0000-000002F327C0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061215-0009-0000-0000-000022602A27
Message-Id: <1560352011.4578.43.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906120101
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Tue, 2019-06-11 at 21:30 +0200, Petr Vorel wrote:
> Although custom policy which contains tcb can be loaded via dracut,

^which may contain the equivalent measurement tcb rules

> systemd or later manually from user space, detecting it would require
> IMA_READ_POLICY=y. In order to simplify the check and avoid false
> positives lets ignore this option and require builtin IMA tcb policy.

This test is for adding new measurements to the measurement list.

> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  .../kernel/security/integrity/ima/tests/ima_measurements.sh    | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> index 328affc43..a3aa24d8a 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> @@ -57,7 +57,8 @@ setup()
>  	[ -z "$DIGEST_INDEX" ] && tst_brk TCONF \
>  		"Cannot find digest index (template: '$template')"
> 
> -	tst_res TINFO "IMA measurement tests assume tcb policy to be loaded (ima_policy=tcb)"
> +	grep -q -e ima_policy=[a-z_]*tcb -e ima_tcb -e ima_appraise_tcb /proc/cmdline || \
> +		tst_brk TCONF "IMA measurement tests require builtin IMA tcb policy (ima_policy=tcb or ima_policy=appraise_tcb kernel parameter)"
>  }
> 

"appraise_tcb" doesn't provide the necessary measurement rules.
"ima_policy=" isn't order specific.  The check would be for "|tcb", "|
tcb", "tcb|", "tcb |", or just "=tcb".  The deprecated "ima_tcb"
option is fine too.

Mimi

>  # TODO: find support for rmd128 rmd256 rmd320 wp256 wp384 tgr128 tgr160


