Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23786155B9
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Nov 2022 00:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiKAXF0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 19:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiKAXFW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 19:05:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2405E60D6
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 16:05:00 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1Mr9n3027912;
        Tue, 1 Nov 2022 23:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=t/hkVJwWqMTO82fpqP6LuNwB1DL9hcxkBE0ft+7mDFs=;
 b=ABl9DJi/GeYNq/pmhPVKvmwCrjN/i28moyNUbZ/4M2Rnn1AoF5OAcpqZZOQKJirARfj/
 9S/2b6N//drBxIojq10NXSjLi7usNKbFqW94HKiOuB0ccuIXt9b80k771C+abGKik2+R
 +/ha/MwzJS+wxPhBgKEchVogLHb7ZRYGLPH10aybBcwReo/1D1v5yzRFWGVJtJjMf/ut
 v4+YrKN0gQYFpxdmUbWukZEJ7fW1PGV6zxotJLyUKGWcOfhWpT16QktoW4enVfT0f2gn
 6T4k7w5sdplyo51E8IKzNcebwIXn6CrrvrkORHRGigPK13rcxEk962d6Rkhl9iova6b8 +g== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjw3kvwf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 23:04:54 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A1MoMZl031148;
        Tue, 1 Nov 2022 23:04:53 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03wdc.us.ibm.com with ESMTP id 3kgut9q0bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 23:04:53 +0000
Received: from smtpav04.wdc07v.mail.ibm.com ([9.208.128.116])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A1N4qhJ49873404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Nov 2022 23:04:53 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 531825807B;
        Tue,  1 Nov 2022 23:04:52 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C50985807E;
        Tue,  1 Nov 2022 23:04:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.106.109])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  1 Nov 2022 23:04:51 +0000 (GMT)
Message-ID: <145f4c70ec894c4980d9455485cdac4673e01d04.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v4 01/17] Revert "Reset 'errno' after
 failure to open or access a file"
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
Date:   Tue, 01 Nov 2022 19:04:51 -0400
In-Reply-To: <0a70ffe5-a35a-f8fa-dfa8-be3bf2e5e29f@linux.ibm.com>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
         <20221101201803.372652-2-zohar@linux.ibm.com>
         <0a70ffe5-a35a-f8fa-dfa8-be3bf2e5e29f@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UbQlSOZr2A9Cq__sNvr7Z7TCpfwAOjWP
X-Proofpoint-ORIG-GUID: UbQlSOZr2A9Cq__sNvr7Z7TCpfwAOjWP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010156
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

On Tue, 2022-11-01 at 17:46 -0400, Stefan Berger wrote:
> 
> On 11/1/22 16:17, Mimi Zohar wrote:
> > This reverts commit acb19d1894a4a95471b8d2346cd6c3ecf3385110.
> 
> $ git show acb19d1
> fatal: ambiguous argument 'acb19d1': unknown revision or path not in the working tree.
> 
> Are you reverting this from a public tree? or could you just drop this patch from your series?
> 
> Also after removing this patch from the mbox file I cannot apply these patches to my sourceforge checkout -- presumably next-testing branch:
> 
> $ git am ./v4_20221101_zohar_address_deprecated_warnings.mbx
> Applying: log and reset 'errno' after failure to open non-critical files
> Applying: Log and reset 'errno' on lsetxattr failure
> Applying: travis: update dist=focal
> Applying: Update configure.ac to address a couple of obsolete warnings
> Applying: Deprecate IMA signature version 1
> error: patch failed: src/libimaevm.c:684
> error: src/libimaevm.c: patch does not apply
> Patch failed at 0005 Deprecate IMA signature version 1
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".

Sorry, I should have used "--base=auto" when generating the patch set. 
Yes, the patch set is based on the github next-testing branch.

thanks,

Mimi

