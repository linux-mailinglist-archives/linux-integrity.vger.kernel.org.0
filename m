Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5782195C
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2019 15:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfEQNux (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 May 2019 09:50:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728692AbfEQNux (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 May 2019 09:50:53 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4HDbJgY010826
        for <linux-integrity@vger.kernel.org>; Fri, 17 May 2019 09:50:51 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2shw0a3mxv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 17 May 2019 09:50:51 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Fri, 17 May 2019 14:50:50 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 May 2019 14:50:48 +0100
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4HDolkN22348136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 May 2019 13:50:47 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 465FE7805C;
        Fri, 17 May 2019 13:50:47 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70DC178064;
        Fri, 17 May 2019 13:50:46 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.137.121])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 17 May 2019 13:50:46 +0000 (GMT)
Subject: Re: [PATCH] ima: skip verifying TPM 2.0 PCR values
To:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Cc:     ltp@lists.linux.it, Petr Vorel <pvorel@suse.cz>
References: <1558041162.3971.2.camel@linux.ibm.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Date:   Fri, 17 May 2019 09:50:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1558041162.3971.2.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19051713-0020-0000-0000-00000EEACC21
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011112; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01204635; UDB=6.00632408; IPR=6.00985570;
 MB=3.00026931; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-17 13:50:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051713-0021-0000-0000-000065DC5BC1
Message-Id: <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905170087
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 05/16/2019 05:12 PM, Mimi Zohar wrote:
> TPM 1.2 exported the PCRs.  Reading the TPM 2.0 PCRs requires a
> userspace application.  For now, skip this test.
>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   testcases/kernel/security/integrity/ima/tests/ima_tpm.sh | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> index 0ffc3c02247d..ebe4b4c360e4 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> @@ -88,6 +88,14 @@ test2()
>   	tst_res TINFO "verify PCR values"
>   	tst_check_cmds evmctl
>
> +	local tpm_description="/sys/class/tpm/tpm0/device/description"


I do not see a "description" file on either my PowerPC or x86 systems 
with TPM 2.0.  Perhaps instead of testing for the "description" file, if 
the "pcrs" file is not found, emit a more verbose informational message, 
for eg. - "pcrs file is not found - either you are running a TPM 2.0, or 
having sysfs failed to show pcrs for TPM 1.2"

Thanks & Regards,
       - Nayna

