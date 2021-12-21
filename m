Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D370947BCC6
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Dec 2021 10:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhLUJVP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Dec 2021 04:21:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232251AbhLUJVP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Dec 2021 04:21:15 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BL7I9jx002881;
        Tue, 21 Dec 2021 09:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=H1zYJIY9bsHIK4C/u1CW3jP/ZM+ixwX7opsXZVwhD9k=;
 b=jl3gggbkEQSUV5pHZ7/G1smK81HK1eZPp7nUUZmM99WkESTGZsB8RZVm/2pY/szQ8vLa
 kS4vINH0xWDuJEPkQW6rwO9umWxkGbhjm52l258TYw1xoXBlcerASWn/40Iatc91fKIe
 2hOn3BliFn+LVyByXRgclWpuCEPe+cdUIEkZuVKx/7tua2278enmrmmdUyKOrg9A1J69
 uthhWsOvpZDKfGgkYhvuHteX+WPEu7DviseGxEWiIAAkfuwgvmRMC07oBFrDYLEL7e8p
 VV6pVKPC7WCjd3UwplPENkeqtt0U70hjZKMVJK6/tsR+3g7w7Qaj+PVQeGpWA89KBpdI Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d1s7qrhf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 09:21:09 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BL98gWM017285;
        Tue, 21 Dec 2021 09:21:09 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d1s7qrhe7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 09:21:09 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BL9Gqbg003489;
        Tue, 21 Dec 2021 09:21:06 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3d1799trk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 09:21:06 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BL9L4S57602636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 09:21:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32C8911C054;
        Tue, 21 Dec 2021 09:21:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDCE711C06F;
        Tue, 21 Dec 2021 09:21:02 +0000 (GMT)
Received: from [9.43.19.198] (unknown [9.43.19.198])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Dec 2021 09:21:02 +0000 (GMT)
Message-ID: <aafb5351-a73a-dac3-b0fa-3faad707bafa@linux.ibm.com>
Date:   Tue, 21 Dec 2021 14:51:01 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v2] syscalls/keyctl09: test encrypted keys.
To:     Yael Tiomkin <yaelt@google.com>, ltp@lists.linux.it
Cc:     zohar@linux.ibm.com, pvorel@suse.cz,
        linux-integrity@vger.kernel.org
References: <20211221023721.129689-1-yaelt@google.com>
From:   Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20211221023721.129689-1-yaelt@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XrH1xARohmUtxsn_ih5_dWTSYXd87HRW
X-Proofpoint-ORIG-GUID: lQsQLo_xM1Wpfd4Co24fzaXM-6ClnLwF
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_03,2021-12-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210039
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 21/12/21 8:07 am, Yael Tiomkin wrote:
> Test that encrypted keys can be instantiated using
> both user-provided decrypted data
> (https://lore.kernel.org/linux-integrity/20211213192030.125091-1-yaelt@google.com/),
> or kernel-generated numbers.
> 
> Signed-off-by: Yael Tiomkin <yaelt@google.com>

Tested on ppc64le platform

Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>

...
<<<test_start>>>
tag=keyctl09 stime=1640078325
cmdline="keyctl09"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:1425: TINFO: Timeout per run is 0h 05m 00s
keyctl09.c:49: TPASS: Encrypted keys were successfully instantiated and read

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
...


> ---
> 
> Notes:
>      v -> v2: added key revocation and made styling changes.
> 
>   runtest/syscalls                            |  1 +
>   testcases/kernel/syscalls/keyctl/.gitignore |  1 +
>   testcases/kernel/syscalls/keyctl/keyctl09.c | 58 +++++++++++++++++++++
>   3 files changed, 60 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/keyctl/keyctl09.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index bcf3d56c9..ccea1ddbd 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -643,6 +643,7 @@ keyctl05 keyctl05
>   keyctl06 keyctl06
>   keyctl07 keyctl07
>   keyctl08 keyctl08
> +keyctl09 keyctl09
>   
>   kcmp01 kcmp01
>   kcmp02 kcmp02
> diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
> index 3544ac79c..f9948c176 100644
> --- a/testcases/kernel/syscalls/keyctl/.gitignore
> +++ b/testcases/kernel/syscalls/keyctl/.gitignore
> @@ -6,3 +6,4 @@
>   /keyctl06
>   /keyctl07
>   /keyctl08
> +/keyctl09
> diff --git a/testcases/kernel/syscalls/keyctl/keyctl09.c b/testcases/kernel/syscalls/keyctl/keyctl09.c
> new file mode 100644
> index 000000000..507cd5628
> --- /dev/null
> +++ b/testcases/kernel/syscalls/keyctl/keyctl09.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 Google, Inc.
> + */
> +
> +/*\
> + * [Description]
> + * Test that encrypted keys can be instantiated using user-provided decrypted
> + * data (plaintext), and separately, using kernel-generated key material.
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/keyctl.h"
> +
> +#define ENCRYPTED_KEY_1_PAYLOAD	"new enc32 user:masterkey 32 plaintext12345678901234567890123"
> +#define ENCRYPTED_KEY_2_PAYLOAD	"new enc32 user:masterkey 32"
> +
> +static void do_test(void)
> +{
> +	key_serial_t masterkey;
> +	key_serial_t encryptedkey1;
> +	key_serial_t encryptedkey2;
> +	char buffer[128];
> +
> +	masterkey = add_key("user", "user:masterkey", "foo", 3,
> +			    KEY_SPEC_PROCESS_KEYRING);
> +	if (masterkey == -1)
> +		tst_brk(TBROK | TERRNO, "Failed to add user key");
> +
> +	encryptedkey1 = add_key("encrypted", "ltptestkey1", ENCRYPTED_KEY_1_PAYLOAD,
> +				60, KEY_SPEC_PROCESS_KEYRING);
> +	if (encryptedkey1 == -1)
> +		tst_brk(TFAIL, "Failed to instantiate encrypted key using payload decrypted data");
> +
> +	TEST(keyctl(KEYCTL_READ, encryptedkey1, buffer, sizeof(buffer)));
> +	if (TST_RET < 0)
> +		tst_brk(TFAIL, "KEYCTL_READ failed for encryptedkey1");
> +
> +	encryptedkey2 = add_key("encrypted", "ltptestkey2", ENCRYPTED_KEY_2_PAYLOAD,
> +				27, KEY_SPEC_PROCESS_KEYRING);
> +	if (encryptedkey2 == -1)
> +		tst_brk(TFAIL,
> +			"Failed to instantiate encrypted key using kernel-generated key material");
> +
> +	TEST(keyctl(KEYCTL_READ, encryptedkey2, buffer, sizeof(buffer)));
> +	if (TST_RET < 0)
> +		tst_brk(TFAIL, "KEYCTL_READ failed for encryptedkey2");
> +
> +	tst_res(TPASS, "Encrypted keys were successfully instantiated and read");
> +
> +	keyctl(KEYCTL_REVOKE, encryptedkey1);
> +	keyctl(KEYCTL_REVOKE, encryptedkey2);
> +	keyctl(KEYCTL_REVOKE, masterkey);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +};

-- 
Thanks and Regards
R.Nageswara Sastry
