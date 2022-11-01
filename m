Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B798E615467
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 22:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiKAVqe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 17:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKAVqd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 17:46:33 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB7410558
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 14:46:28 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1Kb7Iv025120;
        Tue, 1 Nov 2022 21:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=E6afF8uGKLj8mAya5Y3hCJgrDXlAnlSXNkV8EGsx4II=;
 b=jkDbVFF/cp/uTqbmd7cskpNeL5vLhXvLF4Htoxrzf9mz2w7zY3His90pK2NRmnA3cpf/
 cw7hRZDf5GG9nXhAzKE/osEKQLPWwTBPUDpTR/LSzn1TN+Dm9PFnJEFfXwHuXj0r1xNM
 em4pcSd3uinDqnYEupHiTCwYyAw6qhgnoLb7V0707LdRJZwra0GUPnRB2AEEjHwBOER1
 nBQm+GROz4bP6L1FfgB5nCh7HosUp7WVZ+lbqBJIUiHoZn6a/73qGd9y1pVnz23T5XzB
 Lfm/mNPdBbFZR4nxwdtA3eTiBoZvTQbRVX2iRjQIrvWdqLlVXrvcVnkF8LKV+7W2WFjJ EQ== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjwjjnm3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 21:46:24 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A1LaN7u020707;
        Tue, 1 Nov 2022 21:46:24 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03wdc.us.ibm.com with ESMTP id 3kgut9pn44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 21:46:24 +0000
Received: from smtpav03.wdc07v.mail.ibm.com ([9.208.128.112])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A1LkNRv6750886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Nov 2022 21:46:23 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28BC458054;
        Tue,  1 Nov 2022 21:46:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 977F158062;
        Tue,  1 Nov 2022 21:46:22 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  1 Nov 2022 21:46:22 +0000 (GMT)
Message-ID: <0a70ffe5-a35a-f8fa-dfa8-be3bf2e5e29f@linux.ibm.com>
Date:   Tue, 1 Nov 2022 17:46:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils v4 01/17] Revert "Reset 'errno' after
 failure to open or access a file"
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
 <20221101201803.372652-2-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20221101201803.372652-2-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GIR7ligOXEl1JHBgHKAlEYdOlglZ5H3n
X-Proofpoint-GUID: GIR7ligOXEl1JHBgHKAlEYdOlglZ5H3n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010149
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 11/1/22 16:17, Mimi Zohar wrote:
> This reverts commit acb19d1894a4a95471b8d2346cd6c3ecf3385110.

$ git show acb19d1
fatal: ambiguous argument 'acb19d1': unknown revision or path not in the working tree.

Are you reverting this from a public tree? or could you just drop this patch from your series?

Also after removing this patch from the mbox file I cannot apply these patches to my sourceforge checkout -- presumably next-testing branch:

$ git am ./v4_20221101_zohar_address_deprecated_warnings.mbx
Applying: log and reset 'errno' after failure to open non-critical files
Applying: Log and reset 'errno' on lsetxattr failure
Applying: travis: update dist=focal
Applying: Update configure.ac to address a couple of obsolete warnings
Applying: Deprecate IMA signature version 1
error: patch failed: src/libimaevm.c:684
error: src/libimaevm.c: patch does not apply
Patch failed at 0005 Deprecate IMA signature version 1
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

    Stefan

